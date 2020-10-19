<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>员工列表</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--web路径:
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306);需要加上项目名
                  http://localhost:3306/crud
    -->

    <!--Bootstrap和jQuery的引入-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <!--Bootstrap依赖jQuery,所以要把jQuery放前面,以免Bootstrap在jQuery使用时没法使，有时候模态框一直没法调用就是因为这个问题-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
<body>
<!--员工修改的模态框-->
<div class="modal fade " id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="height: 550px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body" style="height:400px">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empname_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empno_add_input" class="col-sm-2 control-label">员工编号</label>
                        <div class="col-sm-10">
                            <input type="text" name="empno" class="form-control" id="empno_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emjob_add_input" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10">
                            <input type="text" name="job" class="form-control" id="emjob_update_input"
                                   placeholder="经理/工程师">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sal_add_input" class="col-sm-2 control-label">基本工资</label>
                        <div class="col-sm-10">
                            <input type="text" name="sal" class="form-control" id="sal_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="hiredate_add_input" class="col-sm-2 control-label">入职时间</label>
                        <div class="col-sm-10">
                          <p class="form-control-static" id="hiredate_update_input"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-4">
                            <!--部门提交Id即可-->
                            <select class="form-control" name="deptno">
                            </select>
                        </div>
                    </div>
                </form>
                <div class="modal-footer" >
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 新增Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="ename_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="ename" class="form-control" id="ename_add_input"
                                   placeholder="姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empno_add_input" class="col-sm-2 control-label">员工编号</label>
                         <div class="col-sm-10">
                            <input type="text" name="empno" class="form-control" id="empno_add_input">
                            <span class="help-block"></span>
                         </div>
                    </div>
                    <div class="form-group">
                        <label for="emjob_add_input" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10">
                            <input type="text" name="job" class="form-control" id="emjob_add_input"
                                   placeholder="经理/工程师">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sal_add_input" class="col-sm-2 control-label">基本工资</label>
                        <div class="col-sm-10">
                            <input type="text" name="sal" class="form-control" id="sal_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="hiredate_add_input" class="col-sm-2 control-label">入职时间</label>
                        <div class='input-group date' id='datetimepicker3'>
                            <input type='text' name="hiredate" class="form-control" id="hiredate_add_input" >
                            <span class="input-group-addon">
                               <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-4">
                            <!--部门提交Id即可-->
                            <select class="form-control" name="deptno">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class=".col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮-->
    <div classs="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_all_btn">全部删除</button>
        </div>
    </div>
    <!--  显示表格数据  -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emp_table">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"/></th>
                        <th>#</th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>职位</th>
                        <th>入职时间</th>
                        <th>基本工资</th>
                        <th>部门名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">
        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;

    $(function () {
        to_page(1);
    })

//时间选择器
$('#datetimepicker3').datetimepicker({
        language:  'zh-CN',
        format: "yyyy-mm-dd"
    })
//完成全选，全不选功能
   $("#check_all").click(function(){
       //attr获取checked是undefined；
       //我们这些dom原生的属性：attr获取自定义属性的值，用prop修改和读取dom原生属性的值；
       $(this).prop("checked");
       //让下面的选择框和第一个的值相同
       $(".check_item").prop("checked",$(this).prop("checked"));
   });

//给check_item绑定单击事件
    $(document).on("click",".check_item",function(){
        //判断当前选中的元素是否全选
        var flag = ($(".check_item:checked").length == $(".check_item").length);
         $("#check_all").prop("checked",flag);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/findemp",
            data: "pn=" + pn,
            type: "GET",
            //function中的result代表服务器返回的数据，和Msg类中的result无关
            success: function (result) {
                console.log(result);
                //1、解析显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条信息
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkboxId = $("<td><input type='checkbox' class='check_item'/></td>");
             var idTd = $("<td></td>").append(item.id);
              var empnoTd = $("<td></td>").append(item.empno);
              var enameTd = $("<td></td>").append(item.ename);
              var jobTd = $("<td></td>").append(item.job );
               var hiredateTd = $("<td></td>").append(item.hiredate);
                var sal = $("<td></td>").append(item.sal);
                var deptname = $("<td></td>").append(item.deptname);
            /**
             * <botton class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
             </botton>
             * @type {*|jQuery}
             */
            var editBtn = $("<botton></botton>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                .append("编辑");
            //为编辑按钮添加属性，来表示当前id
            editBtn.attr("edit-id",item.id);
            var delBtn = $("<botton></botton>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                .append("删除");
             delBtn.attr("del-id",item.id);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
           $("<tr></tr>").append(checkboxId)
                .append(idTd)
                .append(empnoTd)
                .append(enameTd)
                .append(jobTd)
                .append(hiredateTd)
                .append(sal)
                .append(deptname)
                .append(btnTd)
                .appendTo("#emp_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append(
            "当前第 " + result.extend.pageInfo.pageNum + " 页" + " 总 "
            + result.extend.pageInfo.pages + " 页" + " 总 "
            + result.extend.pageInfo.total + " 条记录");
        totalRecord = result.extend.pageInfo.pages;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

        firstPageLi.click(function () {
            to_page(1);
        })

        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum - 1);
        })

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));

        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        })

        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        })
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }

            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }


    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //表单重置（完整重置）
        reset_form("#myModal form")
        $("#myModal").modal({
            backdrop: "static"
        });
        getDepts("#myModal select");
    });

       // 获取部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "/depts",
            type: "GET",
            success: function (result) {
                console.log(result)
                // $("#dept_add_select").append("")
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptname).attr("value", this.deptid);
                    optionEle.appendTo(ele)
                })
            }
        })
    }

function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
        //校验员工编号是否可用
           $("#empno_add_input").change(function () {
               //发送ajax请求校验用户名是否可用
               var empno = this.value;//this.value是输入框的值
               $.ajax({
                   url: "${APP_PATH}/checkEmpno",
                   data: "empno=" + empno,
                   type: "post",
                   success: function (result) {
                       if (result.code == 100) {
                           show_validate_msg("#empno_add_input", "success", "员工编号可用");
                           $("#emp_save_btn").attr("ajax-va", "success");
                       } else {
                           show_validate_msg("#empno_add_input", "error", result.extend.va_msg);
                           $("#emp_save_btn").attr("ajax-va", "error");

                       }
                   }
               });
           });
           //校验员工编号是否可用
           $("#empno_update_input").change(function () {
               //发送ajax请求校验用户名是否可用
               var empno = this.value;//this.value是输入框的值
               $.ajax({
                   url: "${APP_PATH}/checkEmpno",
                   data: "empno=" + empno,
                   type: "post",
                   success: function (result) {
                       if (result.code == 100) {
                           show_validate_msg("#empno_update_input", "success", "员工编号可用");
                           $("#emp_update_btn").attr("ajax-va", "success");
                       } else {
                           show_validate_msg("#empno_update_input", "error", result.extend.va_msg);
                           $("#emp_update_btn").attr("ajax-va", "error");

                       }
                   }
               });
           });
    //保存
    $("#emp_save_btn").click(function () {
            if($(this).attr("ajax-va")=="error"){
                return false;
            }
            $.ajax({
                    url: "${APP_PATH}/insertorupdate",
                    type: "POST",
                    data: $("#myModal form").serialize(),
                    success: function (result) {
                        if(result==1){
                            $("#myModal").modal("hide");
                            to_page(totalRecord);}
                    }
                })
    });
    //这里绑定事件要注意,是之后添上去的标签，所以用on绑定单击事件
    $(document).on("click",".edit_btn",function () {
        //alert("fsf")
        //1、查出部门信息，显示部门列表
        getDepts("#empUpdateModal select");
        //3、把员工id传递给更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        })
    });
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                // console.log(result)
                var empData = result.extend.emp;
                $("#empname_update_static").text(empData.ename);
                //.val() 能够取到 针对text，hidden可输入的文本框的value值。
                // 而 .attr('value') 可以取到html元素中所设置的属性 value的值，不能获取动态的如input type="text" 的文本框手动输入的值
                $("#empno_update_input").val(empData.empno);
                $("#emjob_update_input").val(empData.job);
                $("#sal_update_input").val(empData.sal);
                $("#hiredate_update_input").text(empData.hiredate);
                $("#empUpdateModal select").val([empData.deptno]);
            }
        })
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
    if($(this).attr("ajax-va")=="error"){
                    return false;
                }
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                $("#empUpdateModal").modal("hide");
                  //2.回到本页面
                    to_page(currentPage)
            }
        })
    })


      // 单个删除
      $(document).on("click",".delete_btn",function(){
          //弹出是否确认删除对话框(找到当前的祖先节点的tr，tr下的第二个td的文本值)
          //alert($(this).parents("tr").find("td:eq(1)").text());
          var empName = $(this).parents("tr").find("td:eq(3)").text();
          var ids = $(this).attr("del-id");//要删除的员工id
          if(confirm("确认删除【"+empName+"】吗？")){
              //点击确认发送ajax请求，删除即可
              $.ajax({
                 url:"${APP_PATH}/emp/"+ids,
                  type:"DELETE",
                  success:function(result){
                     alert(result.msg);
                     //回到本页
                      to_page(currentPage);
                  }
              });
          }
      });

      //点击全部删除，就批量删除
         $("#emp_del_all_btn").click(function () {
            //遍历每一个被选中的，查出名字
             var empNames = "";
             var del_idstr = "";
            $.each($(".check_item:checked"),function(){
              empNames += $(this).parents("tr").find("td:eq(3)").text()+",";
              //组装员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除多余的（最后一个）逗号：从0开始截取字符串，到导数第二个
            empNames = empNames.substring(0,empNames.length-1);
             //去除多余的（最后一个）-：从0开始截取字符串，到导数第二个
            del_idstr = del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确认删除【"+empNames+"】员工吗？")){
                //发送ajax请求删除
                $.ajax({
                   url:"${APP_PATH}/emp/"+del_idstr,
                   type:"delete",
                   success:function(result){
                       alert(result.msg);
                       //回到当前页面
                       to_page(currentPage);
                   }
                });
            }

         });
</script>
</body>
</html>