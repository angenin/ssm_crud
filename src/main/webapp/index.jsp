<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入标签核心库--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>

    <%
        //获取当前项目名（得到的是 /加项目名（例：/ssm_crud） ，所以使用的时候前面不用加/而后面需要）
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%-- web的路径：
           - 不以/开始的相对路径，找资源，以当前资源的路径为基准，经常出问题。
           - 以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306）再需要加上项目名（项目名也不是写死的）
                http://localhost:8080/ssm_crud
     --%>
    <script type="text/javascript" src="${ APP_PATH }/static/js/jquery-3.4.1.min.js"></script>
    <%--    下载的bootstrap前端框架有问题，用第二种方式引入--%>
    <%--    <link href="${ APP_PATH }/static/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet"/>--%>
    <%--    <script src="${ APP_PATH }/static/bootstrap-dist/js/bootstrap.min.js"></script>--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>

    <%--   员工修改的模态框   --%>
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <%--       弹窗标题             --%>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <%--   弹窗内容     --%>
                <div class="modal-body">
                    <%--      表单    --%>
                    <%--      empName    --%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <%--     员工姓名不可修改     --%>
                                <p class="form-control-static" id="empName_update_static"></p>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--      email    --%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--      gender    --%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <%--      deptName    --%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <%--      提交部门id即可    --%>
                                <select class="form-control" name="dId"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <%--        弹窗关闭按钮            --%>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <%--        弹窗保存按钮            --%>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

    <%--    员工添加按钮的模态框   --%>
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <%--       弹窗标题             --%>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <%--   弹窗内容     --%>
                <div class="modal-body">
                    <%--      表单    --%>
                    <%--      empName    --%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--      email    --%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--      gender    --%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <%--      deptName    --%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <%--      提交部门id即可    --%>
                                <select class="form-control" name="dId"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <%--        弹窗关闭按钮            --%>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <%--        弹窗保存按钮            --%>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <%--    搭建显示页面（官方的全局CSS样式的栅格系统） --%>
    <div class="container">
        <%-- 标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM_CRUD</h1>
            </div>
        </div>
        <%--  按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_modal_btn">新 增</button>
                <button class="btn btn-danger" id="emp_delete_modal_btn">删 除</button>
            </div>
        </div>
        <%--  显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all">
                            </th>
                            <th>empId</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
        <%-- 显示分页信息--%>
        <div class="row">
            <%-- 分页文字信息--%>
            <div class="col-md-6" id="page_info_area"></div>
            <%-- 分页条信息--%>
            <div class="col-md-6" id="page_nav_area"></div>
        </div>
    </div>

    <script type="text/javascript">

        //定义一个全局变量：总记录数和当前页（在分页信息那赋值）
        var totalRecord, currentPage;

        //1.页面加载完成后，发送一个ajax请求，要到分页数据
        $(function () {
            //请求首页收据
            to_page(1);
        });

        //页面跳转方法
        function to_page(pn) {
            $.ajax({
                url: "${APP_PATH}/emps",
                data: "pn=" + pn,
                type: "get",
                success:function(result){
                    // console.log(result);
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析并显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        //解析显示员工信息
        function build_emps_table(result) {
            //每次页面跳转都先清空原先的员工数据
            $("#emps_table tbody").empty();

            var emps = result.extend.pageInfo.list;
            //jquery自带的遍历
            $.each(emps, function (index, item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                //员工信息单元格
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                //修改删除按钮，在同一个单元格内
                var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("编辑");
                //为编辑按钮添加一个自定义属性，表示当前员工id
                editBtn.attr("edit-id", item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                        .append("删除");
                //同理，也为删除按钮添加一个自定义属性
                delBtn.attr("del-id", item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //把相同员工的单元格添加到同一行
                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody"); //添加到id为emps_table的表里的tbody中
            });
        }

        //解析显示分页信息
        function build_page_info(result) {
            //每次页面跳转都先清空分页信息
            $("#page_info_area").empty();

            $("#page_info_area").append("当前 " + result.extend.pageInfo.pageNum + " 页，" +
                "总 " + result.extend.pageInfo.pages  + " 页，" +
                "总 " + result.extend.pageInfo.total + " 条记录");
            //为全局变量赋值
            totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        //解析显示分页条
        function build_page_nav(result) {
            //每次页面跳转都先清空table表格数据
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");
            //首页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            //上一页
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
            //如果没有上一页，给首页和前一页按钮增加不能点击的效果
            if(!result.extend.pageInfo.hasPreviousPage){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //如果有上一页
                //为首页添加点击翻页事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                //为上一页添加点击翻页事件
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }

            //下一页
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
            //尾页
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
            //如果没有下一页，给后一页和尾页按钮增加不能点击的效果
            if(!result.extend.pageInfo.hasNextPage){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                //如果有下一页
                //为下一页添加点击翻页事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                //为尾页页添加点击翻页事件
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }

            //添加首页
            ul.append(firstPageLi).append(prePageLi);

            //5个连续显示的页码
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
                //如果循环到的页码是当前页码
                if(item == result.extend.pageInfo.pageNum){
                    numLi.addClass("active");
                }
                //为页码按钮添加点击事件
                numLi.click(function () {
                    //页面跳转到对应的页数
                    to_page(item);
                });
                //添加页码
                ul.append(numLi);
            })
            //添加下一页和尾页
            ul.append(nextPageLi).append(lastPageLi);

            //把ul添加到nav中
            var navEle = $("<nav></nav>").append(ul).appendTo("#page_nav_area");
        }


        //新增按钮的点击弹窗事件
        $("#emp_add_modal_btn").click(function () {
            //清除表单数据（表单重置）
            //清空文本框内容
            $("#empAddModal form")[0].reset();
            //去除表单样式
            $("#empAddModal form").find("*").removeClass("has-success has-error");
            //清空有带有help-block类的内容（即错误信息）
            $("#empAddModal form").find(".help-block").text("");

            //发送ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#empAddModal select");
            //调用模态框
            $("#empAddModal").modal({
                backdrop: "static"
            });
        });

        //查出所有部门信息并显示在下拉列表中
        function getDepts(ele){
            //清空下拉列表
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "get",
                success: function (result) {
                    //显示部门信息到下拉列表中
                    $.each(result.extend.depts, function () {  //不传参使用this代表当前被遍历的对象
                        var optionEle = $("<option></option>").append(this.deptName)
                            .attr("value", this.deptId).appendTo(ele);
                    });
                }
            });
        }


        //校验表单员工名
        function validate_add_form_empName(ele){
            //拿到数据，用jQuery的正则表达式进行校验
            //校验员工姓名
            var empName = $(ele).val();
            //正则：允许（6到16位，允许a-z A-Z 0-9 _ - 2到5个中文）
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                // alert("用户名可以是2-5位中文或6-16个英文和数字的组合！");
                //显示校验的信息
                show_validate_msg(ele, "error", "用户名可以是2-5位中文或6-16个英文和数字的组合");

                return false;
            }else{
                //判断员工姓名是否可用
                validate_usable_empName(ele);
            }
            //校验通过
            return true;
        }
        //校验表单邮箱
        function validate_add_form_email(ele) {
            //校验邮箱
            var email = $(ele).val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                // alert("邮箱格式不正确！");
                //显示校验的信息
                show_validate_msg(ele, "error", "邮箱格式不正确");

                return false;
            }else{
                show_validate_msg(ele, "success", "");
            }
            //校验通过
            return true;
        }

        //校验的提示信息
        //ele校验的元素，status校验状态，msg提示信息
        function show_validate_msg(ele, status, msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if("success" == status){
                //改变文本框颜色为绿色
                $(ele).parent().addClass("has-success");
                //清空错误提示信息
                $(ele).next("span").text(msg);

            }else if("error" == status){
                //改变文本框颜色为红色
                $(ele).parent().addClass("has-error");
                //显示错误提示信息
                $(ele).next("span").text(msg);
            }
        }

        //员工名输入框失去焦点校验事件（弹窗）
        $("#empName_add_input").blur(function () {
            validate_add_form_empName("#empName_add_input");
        });
        //邮箱输入框失去焦点校验事件（弹窗）
        $("#email_add_input").blur(function () {
            validate_add_form_email("#email_add_input");
        });

        //检验用户名是否可用
        function validate_usable_empName(ele) {
            //获取输入框的内容
            var empName = $(ele).val();
            //发送ajax请求校验用户名是否存在
            $.ajax({
                url: "${APP_PATH}/checkuser",
                data: "empName=" + empName,
                type: "get",
                success: function (result) {
                    //判断是否成功（100为成功，200为失败）
                    if(100 == result.code){
                        show_validate_msg(ele, "success", "用户名可用");
                        //并给保存按钮添加一个自定义属性，success代表用户名可用
                        $("#emp_save_btn").attr("ajax-va", "success");
                    }else{
                        show_validate_msg(ele, "error", result.extend.va_msg);
                        //并给保存按钮添加一个自定义属性，fail代表用户名不可用
                        $("#emp_save_btn").attr("ajax-va", "error");
                    }
                }
            });
        }

        //弹窗的保存按钮的点击保存事件
        $("#emp_save_btn").click(function () {
            //对提交的数据进行校验
            if(!validate_add_form_empName("#empName_add_input") || !validate_add_form_email("#email_add_input")){
                alert("请正确输入信息");
                return false;
            }

            //判断用户名是否通过可用性校验
            if($(this).attr("ajax-va") == "error"){
                //没通过，不保存
                alert("请正确输入信息");
                return false;
            }

            //调用JQuery的serialize，系列化表单里的员工信息
            //系列化后的字符串：empName=cat&email=cat%40qq.com&gender=F&dId=3
            // alert($("#empAddModal form").serialize());

            //发送ajax请求把保存表单内新增的员工信息提交给服务器
            $.ajax({
                url: "${APP_PATH}/emp",
                type: "post",
                data: $("#empAddModal form").serialize(),
                success: function(result){

                    if(100 == result.code){
                        //当保存成功：
                        //1.关闭弹窗
                        $("#empAddModal").modal('hide');
                        //2.跳转到最后一页
                        // （因为我们已经添加了bootstrap的合理化参数，所以当超过总页数将会跳转到最后一页）
                        to_page(totalRecord);

                    }else{
                        //显示失败信息，哪个错误就显示哪个
                        if(undefined != result.extend.errorFields.empName){
                            //显示员工名字的错误信息
                            show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                            alert(result.extend.errorFields.empName);
                        }
                        if(undefined != result.extend.errorFields.email){
                            //显示邮箱的错误信息
                            show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                            alert(result.extend.errorFields.email);
                        }

                    }
                }
            });
        });



        //因为在按钮创建之前就绑定click，所以绑定不了
        //解决：在创建按钮后在绑定 或 绑定点击.live()
        //jquery新版用on代替了live
        //为修改按钮添加点击事件
        $(document).on("click", ".edit_btn", function () {
            //清除当前元素的校验状态
            $("#email_update_input").parent().removeClass("has-success has-error");
            $("#email_update_input").next("span").text("");

            //查出并显示部门信息
            getDepts("#empUpdateModal select");
            //查出并显示员工信息，$(this)当前被点击的编辑按钮
            getEmp($(this).attr("edit-id"));

            //把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

            //调用模态框
            $("#empUpdateModal").modal({
                backdrop: "static"
            });
        });


        //查询员工信息
        function getEmp(id){
            $.ajax({
                url: "${APP_PATH}/emp/" + id,
                type: "get",
                success: function (result) {
                    //获取员工信息
                    var empData = result.extend.emp;
                    //员工姓名
                    $("#empName_update_static").text(empData.empName);
                    //邮箱
                    $("#email_update_input").val(empData.email);
                    //性别
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    //下拉列表
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //更新按钮的点击事件
        $("#emp_update_btn").click(function () {
            //校验邮箱信息
            if (!validate_add_form_email("#email_update_input")){
                alert("邮箱格式不正确，请输入正确的邮箱");
                return false;
            }

            //发送ajax请求更新员工信息
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
                //第一种方法：
                // 如果ajax直接发put请求，请求体中的数据，request.getgetParameter("empName")拿不到
                // tomcat发现是put请求，就不会封装数据为map，只有post形式的请求才会封装请求体为map
                // 所以要在web.xml中注册FormContentFilter过滤器，支持put和delete请求
                //第二种方法：
                // ajax发送post请求，并在发送的data加上 "_method=put"
                // HiddenHttpMethodFilter把post转为put
                type: "put",
                data: $("#empUpdateModal form").serialize(),
                success: function (result) {
                    //关闭对话框
                    $("#empUpdateModal").modal("hide");
                    //回到本页面（刷新）
                    to_page(currentPage);
                }
            });

        });

        //修改模态框邮箱输入框失去焦点校验事件（弹窗）
        $("#email_update_input").blur(function () {
            validate_add_form_email("#email_update_input");
        });


        //为员工对应的删除按钮添加点击事件（单个删除）
        $(document).on("click", ".delete_btn", function () {
            //获取删除的员工姓名
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            //获取删除的员工id
            var empId = $(this).attr("del-id");

            //弹出是否确认删除提示
            if(confirm("确定要删除【" + empName + "】吗？")){
                //确认，发送ajax请求删除员工
                $.ajax({
                    url: "${APP_PATH}/emp/" + empId,
                    type: "delete",
                    success: function (result) {
                        //回到本页（刷新页面）
                        to_page(currentPage);
                    }
                });
            }else {
                //取消
                return false;
            }
        });

        //完成全选/全不选功能
        $("#check_all").click(function () {
            //attr获取checked是undefined;
            //attr获取自定义属性的值;
            //prop修改和读取dom原生属性的值
            //check_item应跟随全选按钮，一同选中或不选中
            $(".check_item").prop("checked", $(this).prop("checked"));
        });

        //check_item的点击事件
        $(document).on("click", ".check_item", function () {
            //是否满足选中的个数和当前页员工的个数相同
            var flag = $(".check_item:checked").length == $(".check_item").length;
            //check_all全选按钮要和判断的结果相同，如果相同就选中，不同不选中
            $("#check_all").prop("checked", flag);
        });

        //为上方删除按钮添加点击删除选中员工信息事件
        $("#emp_delete_modal_btn").click(function () {
            var empName = "";
            var del_idstr = "";
            //遍历当前页被选中的员工
            $.each($(".check_item:checked"), function () {
                //获取被选中的员工姓名
                empName += $(this).parents("tr").find("td:eq(2)").text() + "，";
                //组装员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";;
            });
            //去除多余 ，
            empName = empName.substring(0, empName.length - 1);
            //去除多余 -
            del_idstr = del_idstr.substring(0, del_idstr.length - 1);

            if(confirm("确定要删除【" + empName + "】吗？")){
                //确认，发送ajax请求删除指定员工
                $.ajax({
                    url: "${APP_PATH}/emp/" + del_idstr,
                    type: "delete",
                    success: function (result) {
                        //提示删除成功
                        alert(result.msg);
                        //回到当前页
                        to_page(currentPage);
                    }
                });
            }else{
                //取消
                return false;
            }
        });

    </script>
</body>
</html>
