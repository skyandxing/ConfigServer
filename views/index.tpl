<!DOCTYPE html>

<head>
    <meta charset="utf-8" />
    <title>配置中心</title>

    <meta name="description" content="data tables" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="/static/assets/img/favicon.png" type="image/x-icon">

    <!--Basic Styles-->
    <link href="/static/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link id="bootstrap-rtl-link" href="" rel="stylesheet" />
    <link href="/static/assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/static/assets/css/weather-icons.min.css" rel="stylesheet" />


    <link href="/static/assets/css/beyond.min.css" rel="stylesheet" />
    <link href="/static/assets/css/demo.min.css" rel="stylesheet" />
    <link href="/static/assets/css/typicons.min.css" rel="stylesheet" />
    <link href="/static/assets/css/animate.min.css" rel="stylesheet" />
    <link id="skin-link" href="" rel="stylesheet" type="text/css" />

    <link href="/static/assets/css/dataTables.bootstrap.css" rel="stylesheet" />

    <script src="/static/assets/js/skins.min.js"></script>
</head>

<body>

    <div class="navbar">
        <div class="navbar-inner">
            <div class="navbar-container">
                <!-- Navbar Barnd -->
                <div class="navbar-header pull-left">
                    <a href="#" class="navbar-brand">
                        <div style="padding:10px 0 0 20px">
                        <small>
                            配置中心
                        </small>
                    </div>
                    </a>
                </div>

                <div class="sidebar-collapse" id="sidebar-collapse"> <i class="collapse-icon fa fa-bars"></i>
                </div>

                <div class="navbar-header pull-right">
                    <div class="navbar-account">
                        <ul class="account-area">

                            <li>
                                <a class="login-area dropdown-toggle" data-toggle="dropdown">
                                    <section>
                                        <h2>
                                            <span class="profile">
                                            {{if .isLogin}}
                                                <span>{{.username}}</span>
                                            {{else}}
                                                <span  data-toggle="modal" data-target="#login">登录</span>
                                            {{end}}
                                            </span>
                                        </h2>
                                    </section>
                                </a>
                                {{if .isLogin}}
                                <ul class="pull-right dropdown-menu disabled dropdown-arrow dropdown-login-area">
                                    <li class="dropdown-footer">
                                        <a href="/Signout">Sign out</a>
                                    </li>
                                </ul>
                                {{end}}
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- /Account Area and Settings --> </div>
        </div>
    </div>
    <!-- /Navbar -->
    <!-- Main Container -->
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
            <!-- Page Sidebar -->
            <div class="page-sidebar" id="sidebar">
                
                <ul class="nav sidebar-menu">
                    <li class="active open">
                        <a href="#" class="menu-dropdown">
                            <i class="menu-icon fa fa-table"></i>
                            <span class="menu-text">配置中心</span>
                            <i class="menu-expand"></i>
                        </a>  
                    </li>             
                </ul>
            </div>

            <div class="page-content">
            
                <div class="page-body">

                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                {{if .isLogin}}
                                    <a href="#" class="btn btn-info  btn-xs modify" data-toggle="modal" data-target="#addnewsystem">
                                        <i class="fa fa-edit"></i>
                                        新增系统
                                    </a>
                                    <a href="#" class="btn btn-info  btn-xs modify"  data-toggle="modal" data-target="#addconfig">
                                        <i class="fa fa-edit"></i>
                                        添加配置
                                    </a>
                                    <a href="#" class="btn btn-warning  btn-xs modify" onclick="modify()" data-toggle="modal" data-target="#myModa2">
                                        <i class="fa fa-edit"></i>
                                        修改配置
                                    </a>
                                    <a href="#" class="btn btn-danger  btn-xs modify" onclick="del()" data-toggle="modal" data-target="#myModa2">
                                        <i class="fa fa-edit"></i>
                                        删除配置
                                    </a>
                                {{end}}
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize">
                                            <i class="fa fa-expand"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="widget-body">
                                <table class="table table-striped table-hover table-bordered">
                                    <tr >
                                        <td >
                                        {{range .allconfig}}
                                        <div class="col-md-12  body-one"  style="margin-top:-10px 0 -10px 0;">
                                            <div class="checkbox ">
                                                <span class="glyphicon glyphicon-chevron-right body-one-unfold" aria-hidden="true"></span>
                                                <span class="glyphicon glyphicon-chevron-down body-one-fold" aria-hidden="true"></span>
                                                <label>
                                                  <input type="checkbox" class="body-one-checkbox">
                                                  <span class="text">{{.Name}}</span>
                                                </label>
                                            </div>
                                        {{range .Children}}
                                        <div class="col-md-10 body-two" style="margin-top:-15px;">
                                            <div class="checkbox  " style="margin-left:17px;">   
                                            <span class="glyphicon glyphicon-chevron-right body-two-unfold" aria-hidden="true"></span>
                                            <span class="glyphicon glyphicon-chevron-down body-two-fold" aria-hidden="true"></span>
                                                <label>
                                                  <input type="checkbox" id="{{.Pid}}" class="body-two-checkbox" value="{{.Name}}" pid="{{.Pid}}">
                                                  <span class="text">{{.Name}}</span>
                                                </label>
                                            </div>

                                            <div class="col-md-8 body-three" style="padding-left:55px;margin-top:-15px;">
                                            {{range .Children}}
                                                <div class="checkbox">
                                                    <label>
                                                      <input type="checkbox" id="{{.Pid}}" class="body-three-checkbox" key="{{.Name}}" value="{{.Value}}">
                                                      <span class="text">{{.Name}}   -->   {{.Value}}</span>
                                                    </label>
                                                </div>
                                                {{end}}
                                            </div>
                                            </div>
                                        {{end}}
                                    </div>
                                    {{end}}
                                      </td>
                                    </tr>
                                </table>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /Page Body --> </div>
            <!-- /Page Content --> </div>
            <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title " id="myModalLabel">Login</h4>
                    </div>
                   <div class="modal-body">
                        <form class="form-horizontal form-bordered" role="form" action="/Login" method="post">
                           
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">用户名</label>
                                <div class="col-sm-10">
                                    <input class="form-control"  type="text" name="username">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right">密码</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="password" name="password">
                                </div>
                            </div>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary" >登录</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="addnewsystem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title " id="myModalLabel">添加系统</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="系统名称" name="systemname"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary" onclick="AddNewSystem()">添加</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="addconfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title " id="myModalLabel">添加配置项</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal form-bordered" role="form">
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">系统名称</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="system" data-bv-field="country">
                                    <option value="">请选择</option>
                                    {{range .allconfig}}
                                    {{range .Children}}
                                        <option value="{{.Pid}}" >{{.Name}}</option>
                                   {{end}}
                                   {{end}}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">属性</label>
                                <div class="col-sm-10">
                                    <input class="form-control"  type="text" name="key">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right">值</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="text" name="value">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="AddNewConf();">添加</button>
                    </div>
                </div>
            </div>
    </div>
    <div class="modal fade" id="modifyconfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title " id="myModalLabel">修改配置项</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal form-bordered" role="form">
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">系统名称</label>
                                <div class="col-sm-10">
                                    <input class="form-control " disabled  type="text" name="system">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">属性</label>
                                <div class="col-sm-10">
                                    <input class="form-control" disabled  type="text" name="key">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right">值</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="text" name="changevalue">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="ChangeConfig();">修改</button>
                    </div>
                </div>
            </div>
    </div>
    <div class="modal fade" id="delconfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title " id="myModalLabel">删除配置项</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal form-bordered" role="form">
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">系统名称</label>
                                <div class="col-sm-10">
                                    <input class="form-control " disabled  type="text" name="system">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label no-padding-right">属性</label>
                                <div class="col-sm-10">
                                    <input class="form-control" disabled  type="text" name="key">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right">值</label>
                                <div class="col-sm-10">
                                    <input class="form-control" disabled type="text" name="changevalue">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="DelConfig();">删除</button>
                    </div>
                </div>
            </div>
    </div>
    <script src="/static/assets/js/jquery-2.0.3.min.js"></script>
    <script src="/static/assets/js/bootstrap.min.js"></script>

    <!--Beyond Scripts-->
    <script src="/static/assets/js/beyond.min.js"></script>
    <script src="/static/assets/js/toastr/toastr.js"></script>

    <script type="text/javascript">
   
    function ChangeConfig(system,pid,key){
        var value = $('input[name="changevalue"]').val();
        $.post("/ChangeConfig", 
                {  "name": key,"value":value,"pid":pid,"system":system},
              function(data){
                if (data.type == "success"){
                    Notify(data.message, 'top-right', '3000', 'success', 'fa-check', true);
                    $("#addconfig").modal('hide');
                    setTimeout(function(){
                        location.reload();
                    },2000); 
                    
                }else{
                    Notify(data.message, 'top-right', '3000', 'warning', 'fa-check', true);
                    $('select option:selected').attr("selected",false);
                    $('input[name="key"]').val("");
                    $('input[name="value"]').val("");
                    $("#modifyconfig").modal('hide');
                }
              });  
    }

    function del(){
        var inputs = $('.body-two').find('.body-two-checkbox');
        var threeinput = $('.body-two').find('.body-three-checkbox');
        num = 0;
        threeinput.each(function(index){
            checked = this.checked
            if(checked){
                num +=1
             }
        })
        
        inputs.each(function(index){
            checked = this.checked
            if(checked){
                num +=1
             }
       })
       if(num == 0){
            Notify("请选择要删除的配置项", 'top-right', '3000', 'warning', 'fa-warning', true);
            return
       }else if(num > 2){
            Notify("亲，一次只能删除一个配置项", 'top-right', '3000', 'danger', 'fa-times', true);
            var allinput = $('.widget-body').find('input')
            allinput.each(function(){
                this.checked=false;
            })
            return
       }
       system ="";
       pid="";
       $('.body-two').find('.body-two-checkbox').each(function(i){
            if(this.checked){
                system = this.value;
                pid=$(this).attr("pid")
            }  
       })
       key="";
       value="";
       $('.body-three').find('.body-three-checkbox').each(function(i){
            if(this.checked){
                key = $(this).attr("key");
                value = this.value;
            }  
       })
       $("#delconfig").find("input").eq(0).val(system);
       $("#delconfig").find("input").eq(1).val(key);
       $("#delconfig").find("input").eq(2).val(value);
       $("#delconfig").find("button").eq(2).attr("onclick",'DelConfig("'+system+'",'+pid+',"'+key+'");');
       $("#delconfig").modal('show');
   }

   function DelConfig(system,pid,key) {
        $.post("/DelConfig", 
                {  "name": key,"pid":pid,"system":system},
              function(data){
                if (data.type == "success"){
                    Notify(data.message, 'top-right', '3000', 'success', 'fa-check', true);
                    $("#delconfig").modal('hide');
                    setTimeout(function(){
                        location.reload();
                    },2000); 
                    
                }else{
                    Notify(data.message, 'top-right', '3000', 'warning', 'fa-check', true);
                    $('select option:selected').attr("selected",false);
                    $('input[name="key"]').val("");
                    $('input[name="value"]').val("");
                    $("#delconfig").modal('hide');
                }
              });  
   }
    function modify(){
        var inputs = $('.body-two').find('.body-two-checkbox');
        var threeinput = $('.body-two').find('.body-three-checkbox');
        num = 0;
        threeinput.each(function(index){
            checked = this.checked
            if(checked){
                num +=1
             }
        })
        
        inputs.each(function(index){
            checked = this.checked
            if(checked){
                num +=1
             }
       })

       if(num == 0){
            Notify("请选择要修改的配置项", 'top-right', '3000', 'warning', 'fa-warning', true);
            return
       }else if(num > 2){
            Notify("亲，一次只能修改一个配置项", 'top-right', '3000', 'danger', 'fa-times', true);
            var allinput = $('.widget-body').find('input')
            allinput.each(function(){
                this.checked=false;
            })
            return
       }
       system ="";
       pid="";
       $('.body-two').find('.body-two-checkbox').each(function(i){
            if(this.checked){
                system = this.value;
                pid=$(this).attr("pid")
            }  
       })
       key="";
       value="";
       $('.body-three').find('.body-three-checkbox').each(function(i){
            if(this.checked){
                key = $(this).attr("key");
                value = this.value;
            }  
       })

       $("#modifyconfig").find("input").eq(0).val(system);
       $("#modifyconfig").find("input").eq(1).val(key);
       $("#modifyconfig").find("input").eq(2).val(value);
       $("#modifyconfig").find("button").eq(2).attr("onclick",'ChangeConfig("'+system+'",'+pid+',"'+key+'");');
       $("#modifyconfig").modal('show');
    }

    function AddNewConf(){
        var pid = $('select option:selected').val();
        var system=$('select option:selected').html();
        console.log(system);
        var name = $('input[name="key"]').val();
        var value = $('input[name="value"]').val();
        $.post("/AddNewConfig", 
                {  "name": name,"value":value,"pid":pid,"system":system},
              function(data){
                if (data.type == "success"){
                    Notify(data.message, 'top-right', '3000', 'success', 'fa-check', true);
                    $("#addconfig").modal('hide');
                    setTimeout(function(){
                        location.reload();
                    },2000);  
                }else{
                    Notify(data.message, 'top-right', '3000', 'warning', 'fa-check', true);
                    $('select option:selected').attr("selected",false);
                    $('input[name="key"]').val("");
                    $('input[name="value"]').val("");
                    $("#addconfig").modal('hide');
                }
              });            
        }
        
        function AddNewSystem(){
            if ($('input[name="systemname"]').val() == "" ){
                Notify('系统名称不能为空', 'top-right', '1000', 'warning', 'fa-warning', true); return false;
            } 
            var systemname = $('input[name="systemname"]').val(); 
            $.post("/AddNewSystem", 
                    {   "systemname": systemname},
                  function(data){
                    if (data.type == "success"){
                        Notify(data.message, 'top-right', '3000', 'success', 'fa-check', true);
                        $("#addnewsystem").modal('hide');
                        setTimeout(function(){
                            location.reload();
                        },2000);    
                    }else{
                        Notify(data.message, 'top-right', '3000', 'warning', 'fa-check', true);
                        $('input[name="systemname"]').val("");
                        $("#addnewsystem").modal('hide');

                    }
                    
                  });        
        }
      
        ///////////////////////
    $('.body-one-fold').hide();
    $('.body-two-fold').hide();
    $('.body-three').hide();

    $('.body-one-unfold').click(function(){
        var parent = $(this).parent().parent();
        parent.find('.body-two').each(function(){
            $(this).show()
            
        })
        parent.find('.body-one-fold').each(function(){
            $(this).show()
            
        })
        parent.find('.body-one-unfold').each(function(){
            $(this).hide()
            
        })
        
    })

    $('.body-one-fold').click(function(){
        var parent = $(this).parent().parent();
        parent.find('.body-two').each(function(){
            $(this).hide()
        })
        parent.find('.body-one-fold').each(function(){
            $(this).hide()
            
        })
        parent.find('.body-one-unfold').each(function(){
            $(this).show()
            
        })
        
    })

    $('.body-two-unfold').click(function(){
        var parent = $(this).parent().parent();
        parent.find('.body-three').each(function(){
            $(this).show()
        })
        parent.find('.body-two-fold').each(function(){
            $(this).show()
        })
        parent.find('.body-two-unfold').each(function(){
            $(this).hide()
        })
    })

    $('.body-two-fold').click(function(){
        var parent = $(this).parent().parent();
        parent.find('.body-three').each(function(){
            $(this).hide()
        })

        parent.find('.body-two-fold').each(function(){
            $(this).hide()
        })
        parent.find('.body-two-unfold').each(function(){
            $(this).show()
        })
    })

    // 选中
    $('.body-one-checkbox').click(function(){
        var inputs=$(this).parent().parent().parent().find('input')
        var bool=this.checked?true:false;
        inputs.each(function(){
             this.checked=bool;
        })
    })
    $('.body-two-checkbox').click(function(){

        var inputs=$(this).parent().parent().parent().parent().find('.body-one-checkbox')
        var twoinputs=$(this).parent().parent().parent().parent().find('.body-two-checkbox')
        num = 0
        twoinputs.each(function(i){
            
            if(this.checked){
                num += 1
            }
        })
        var bools=this.checked?true:false;
        inputs.each(function(){
            if(num < 1){
                this.checked=bools;
            }else{
                this.checked=true;
            }

        })

        var inputs=$(this).parent().parent().parent().find('input')
        var bool=this.checked?true:false;
        inputs.each(function(){
             this.checked=bool;
        })
    })

    $('.body-three-checkbox').click(function(){
        var inputs=$(this).parent().parent().parent().parent().find('.body-two-checkbox')
        var threeinputs=$(this).parent().parent().parent().find('.body-three-checkbox')
        num = 0
        threeinputs.each(function(i){
            if(this.checked){
                num +=1
            }
        })

        var bool=this.checked?true:false;
        inputs.each(function(i){
            if(num < 1){
                this.checked=bool;
            }else{
                this.checked=true;
            }
            
        })
        var twoinputs=$(this).parent().parent().parent().parent().parent().find('.body-two-checkbox')
        numtwo = 0
        twoinputs.each(function(i){
            
            if(this.checked){
                numtwo += 1
            }
        })
        var oneinputs=$(this).parent().parent().parent().parent().parent().find('.body-one-checkbox')
        oneinputs.each(function(i){
            if(numtwo<1){
                this.checked=bool;
            }else{
                this.checked=true;
            }
            
        })
        
    })
    </script>

    <!--Google Analytics::Demo Only-->

</body>
    <!--  /Body -->
</html>