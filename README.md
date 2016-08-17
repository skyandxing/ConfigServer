# ConfigServer
基于beego开发的zookeeper应用配置中心

一、安装

go get github.com/astaxie/beego

go get github.com/beego/bee

wget https://codeload.github.com/skyandxing/ConfigServer/zip/master


重命名ConfigServer-master.zip --> ConfigServer.zip

unzip ConfigServer.zip

cd ConfigServer

二、修改配置（conf/app.conf）

修改登录帐号密码：

username=admin

password=admin

配置zookeeper址址：

zkserver = 192.168.2.231:2181,192.168.2.232:2181,192.168.2.233:2181


配置mysql数据库信息，并手工创建数据库:

dbhost = 127.0.0.1

dbport = 3306

dbuser = root

dbpass = mysql

dbname = configserver

maxIdle = 10

maxConn = 30


三、运行 bee run

四、访问:http://127.0.0.1:8080

注：未登录，只能查看。
