package controllers

import (
	m "ConfigServer/models"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/samuel/go-zookeeper/zk"
	"strings"
	"time"
)

type MainController struct {
	beego.Controller
}

func (this *MainController) Get() {
	islogin := this.GetSession("isLogin")
	if islogin != true {

		this.Data["isLogin"] = false
	} else {
		this.Data["username"] = this.GetSession("username")
		this.Data["isLogin"] = true
	}
	//获取所有应用配置信息
	allconfig := m.GetAllConfig()
	this.Data["allconfig"] = allconfig
	this.TplName = "index.tpl"
}

func (this *MainController) Login() {
	username := this.GetString("username")
	password := this.GetString("password")
	if username == beego.AppConfig.String("username") && password == beego.AppConfig.String("password") {
		this.SetSession("username", username)
		this.SetSession("isLogin", true)
	} else {
		this.Data["isLogin"] = false
	}
	this.Redirect("/", 301)
}

func (this *MainController) Signout() {
	this.DelSession("username")
	this.DelSession("isLogin")
	this.Redirect("/", 302)
}

func ZkConnect() (zkconnect *zk.Conn) {
	servers := strings.Split(beego.AppConfig.String("zkserver"), ",")
	zkconn, _, err := zk.Connect(servers, 5*time.Second)
	if err != nil {
		fmt.Println(err)
	}
	return zkconn
}

func (this *MainController) AddNewSystem() {
	systemname := this.GetString("systemname")
	info := m.AddNewSystem(systemname)
	if info == "nil" {
		zkconn := ZkConnect()
		_, err := zkconn.Create("/"+beego.AppConfig.String("Root")+"/"+systemname, []byte(systemname), 0, zk.WorldACL(zk.PermAll))
		zkconn.Close()
		if err == nil {
			this.Data["json"] = map[string]interface{}{"type": "success", "message": systemname + " 添加成功"}
		} else {
			m.DelSystem(systemname)
			this.Data["json"] = map[string]interface{}{"type": "fail", "message": "添加失败，原因：" + err.Error()}
		}
	} else {
		this.Data["json"] = map[string]interface{}{"type": "fail", "message": "添加失败，原因：" + info}
	}
	this.ServeJSON()
}

func (this *MainController) AddNewConfig() {
	name := this.GetString("name")
	value := this.GetString("value")
	pid, _ := this.GetInt64("pid")
	system := this.GetString("system")
	info := m.AddNewConfig(name, value, pid)
	if info == "nil" {
		zkconn := ZkConnect()
		_, err := zkconn.Create("/"+beego.AppConfig.String("Root")+"/"+system+"/"+name, []byte(value), 0, zk.WorldACL(zk.PermAll))
		zkconn.Close()
		if err == nil {
			this.Data["json"] = map[string]interface{}{"type": "success", "message": name + " 添加成功"}
		} else {
			m.DelConfig(name, pid)
			this.Data["json"] = map[string]interface{}{"type": "fail", "message": "添加失败，原因：" + err.Error()}
		}

	} else {
		this.Data["json"] = map[string]interface{}{"type": "fail", "message": "添加失败，原因：" + info}
	}
	this.ServeJSON()
}

func (this *MainController) ChangeConfig() {
	name := this.GetString("name")
	value := this.GetString("value")
	pid, _ := this.GetInt64("pid")
	system := this.GetString("system")
	olddata := m.GetValue(name, pid)
	info := m.ChangeConfig(name, value, pid)
	if info == "nil" {
		zkconn := ZkConnect()
		_, err := zkconn.Set("/"+beego.AppConfig.String("Root")+"/"+system+"/"+name, []byte(value), -1)
		zkconn.Close()
		if err == nil {
			this.Data["json"] = map[string]interface{}{"type": "success", "message": name + " 配置项修改成功"}
		} else {
			m.ChangeConfig(name, olddata, pid)
			this.Data["json"] = map[string]interface{}{"type": "fail", "message": "修改失败，原因：" + err.Error()}
		}
	} else {
		this.Data["json"] = map[string]interface{}{"type": "fail", "message": "修改失败，原因：" + info}
	}
	this.ServeJSON()

}

func (this *MainController) DelConfig() {
	name := this.GetString("name")
	pid, _ := this.GetInt64("pid")
	system := this.GetString("system")
	info := m.DelConfig(name, pid)
	if info == "nil" {
		zkconn := ZkConnect()
		err := zkconn.Delete("/"+beego.AppConfig.String("Root")+"/"+system+"/"+name, -1)
		zkconn.Close()
		if err == nil {
			this.Data["json"] = map[string]interface{}{"type": "success", "message": name + " 配置项删除成功"}
		} else {
			this.Data["json"] = map[string]interface{}{"type": "fail", "message": "删除失败，原因：" + err.Error()}
		}
	} else {
		this.Data["json"] = map[string]interface{}{"type": "fail", "message": "删除失败，原因：" + info}
	}
	this.ServeJSON()
}
