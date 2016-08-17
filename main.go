package main

import (
	m "ConfigServer/models"
	_ "ConfigServer/routers"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	"github.com/samuel/go-zookeeper/zk"
	"strings"
	"time"
)

func init() {
	//初始化数据库
	orm.RegisterDriver("mysql", orm.DRMySQL)
	conn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&loc=Local",
		beego.AppConfig.String("dbuser"),
		beego.AppConfig.String("dbpass"),
		beego.AppConfig.String("dbhost"),
		beego.AppConfig.String("dbport"),
		beego.AppConfig.String("dbname"))
	maxIdle, _ := beego.AppConfig.Int("maxIdle")
	maxConn, _ := beego.AppConfig.Int("maxConn")
	orm.RegisterDataBase("default", "mysql", conn, maxIdle, maxConn)
	orm.RunSyncdb("default", false, true)
	o := orm.NewOrm()
	c, _ := o.QueryTable("Appconfig").Filter("Name", beego.AppConfig.String("Root")).Filter("Level", 0).Count()
	if c == 0 {
		var config m.Appconfig
		config.Name = beego.AppConfig.String("Root")
		config.Value = beego.AppConfig.String("Root")
		config.Level = 0
		config.Pid = 1
		config.Id = 1
		o.Insert(&config)
	}

	allconfig := m.GetAllConfig()

	servers := strings.Split(beego.AppConfig.String("zkserver"), ",")
	zkconn, _, err := zk.Connect(servers, 5*time.Second)
	if err != nil {
		fmt.Println(err)
	}
	defer zkconn.Close()

	for i := 0; i < len(allconfig); i++ {
		root := "/" + allconfig[i].Name
		value := allconfig[i].Value
		if e, _, _ := zkconn.Exists(root); e != true {
			zkconn.Create(root, []byte(value), 0, zk.WorldACL(zk.PermAll))
			fmt.Println("Root")
		}
		for j := 0; j < len(allconfig[i].Children); j++ {
			node := root + "/" + allconfig[i].Children[j].Name
			if e, _, _ := zkconn.Exists(node); e != true {
				zkconn.Create(node, []byte(allconfig[i].Children[j].Value), 0, zk.WorldACL(zk.PermAll))
			}
			for k := 0; k < len(allconfig[i].Children[j].Children); k++ {
				key := node + "/" + allconfig[i].Children[j].Children[k].Name
				if e, _, _ := zkconn.Exists(key); e != true {
					zkconn.Create(key, []byte(allconfig[i].Children[j].Children[k].Value), 0, zk.WorldACL(zk.PermAll))
				}
			}
		}
	}

}

func main() {
	orm.Debug = true
	beego.Run()
}
