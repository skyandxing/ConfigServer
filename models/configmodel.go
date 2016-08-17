package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
)

type Appconfig struct {
	Id    int64  `orm:"auto"`
	Name  string `orm:size(20)`
	Value string `orm:size(200)`
	Level int64
	Pid   int64
}

func init() {
	orm.RegisterModel(new(Appconfig))
}

func DelConfig(name string, pid int64) (result string) {
	o := orm.NewOrm()
	_, err := o.QueryTable("Appconfig").Filter("Name", name).Filter("Pid", pid).Delete()
	if err != nil {
		result = err.Error()
		return result
	} else {
		return "nil"
	}
	return
}

func ChangeConfig(name, value string, pid int64) (result string) {
	o := orm.NewOrm()
	_, err := o.QueryTable("Appconfig").Filter("Name", name).Filter("Pid", pid).Update(orm.Params{"Value": value})
	if err != nil {
		result = err.Error()
		return result
	} else {
		return "nil"
	}
	return
}

func AddNewConfig(name, value string, pid int64) (result string) {
	o := orm.NewOrm()
	count, err := o.QueryTable("Appconfig").Filter("Name", name).Filter("Level", 2).Filter("Pid", pid).Count()
	if err != nil {
		return err.Error()
	}
	if count == 0 {
		var config Appconfig
		config.Name = name
		config.Value = value
		config.Level = 2
		config.Pid = pid
		_, err := o.Insert(&config)
		if err != nil {
			return err.Error()
		}
	} else {
		result = name + " 配置项已存在"
		return result
	}
	return "nil"
}

func AddNewSystem(systemname string) (result string) {
	o := orm.NewOrm()
	count, err := o.QueryTable("Appconfig").Filter("Name", systemname).Filter("Level", 1).Count()
	if err != nil {
		return err.Error()
	}
	var data []orm.Params
	o.QueryTable("Appconfig").Filter("Level", 0).Values(&data)
	if count == 0 {
		var config Appconfig
		config.Name = systemname
		config.Value = systemname
		config.Level = 1
		config.Pid = data[0]["Id"].(int64)
		_, err := o.Insert(&config)
		if err != nil {
			return err.Error()
		}
	} else {
		result = systemname + " 已存在"
		return result
	}
	return "nil"
}

func DelSystem(systemname string) (result string) {
	o := orm.NewOrm()
	_, err := o.QueryTable("Appconfig").Filter("Name", systemname).Delete()
	if err != nil {
		return err.Error()
	}
	return "nil"
}

func GetValue(name string, pid int64) (result string) {
	o := orm.NewOrm()
	var data []orm.Params
	_, err := o.QueryTable("Appconfig").Filter("Name", name).Filter("Pid", pid).Filter("Level", 2).Values(&data)
	if err != nil {
		fmt.Println(err.Error())
		return "nil"
	}
	return data[0]["Value"].(string)

}

type AllConfig struct {
	Name     string
	Value    string
	Pid      int64
	Children []*AllConfig
}

func GetAllConfig() (result []*AllConfig) {
	o := orm.NewOrm()
	var data []orm.Params
	count, _ := o.QueryTable("Appconfig").Count()
	count, err := o.QueryTable("Appconfig").Limit(count).Values(&data)
	if err != nil {
		fmt.Println(err)
	}
	if count == 0 {
		return result
	} else {
		var i int64 = 0
		for i = 0; i < count; i++ {
			if data[i]["Level"].(int64) == 0 {
				Root := new(AllConfig)
				Root.Name = data[i]["Name"].(string)
				Root.Value = data[i]["Value"].(string)
				Root.Pid = data[i]["Pid"].(int64)
				result = append(result, Root)
			}
		}

		for i = 0; i < count; i++ {
			if data[i]["Level"].(int64) == 1 {
				Node := new(AllConfig)
				Node.Name = data[i]["Name"].(string)
				Node.Value = data[i]["Value"].(string)
				Node.Pid = data[i]["Id"].(int64)
				result[0].Children = append(result[0].Children, Node)
			}
		}

		for j := 0; j < len(result[0].Children); j++ {
			for i = 0; i < count; i++ {
				if data[i]["Level"].(int64) == 2 && data[i]["Pid"].(int64) == result[0].Children[j].Pid {
					Keys := new(AllConfig)
					Keys.Name = data[i]["Name"].(string)
					Keys.Value = data[i]["Value"].(string)
					result[0].Children[j].Children = append(result[0].Children[j].Children, Keys)
				}
			}
		}

		return
	}
}
