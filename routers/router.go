package routers

import (
	"ConfigServer/controllers"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{})
	beego.Router("/AddNewSystem", &controllers.MainController{}, "post:AddNewSystem")
	beego.Router("/AddNewConfig", &controllers.MainController{}, "post:AddNewConfig")
	beego.Router("/ChangeConfig", &controllers.MainController{}, "post:ChangeConfig")
	beego.Router("/DelConfig", &controllers.MainController{}, "post:DelConfig")
	beego.Router("/Login", &controllers.MainController{}, "post:Login")
	beego.Router("/Signout", &controllers.MainController{}, "get:Signout")
}
