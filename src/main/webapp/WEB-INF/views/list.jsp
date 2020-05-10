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
<%--    搭建显示页面（官方的全局CSS样式的栅格系统） --%>
    <div class="container">
<%--        标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM_CRUD</h1>
            </div>
        </div>
<%--        按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新 增</button>
                <button class="btn btn-danger">删 除</button>
            </div>
        </div>
<%--        显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>empId</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${ pageInfo.list }" var="emp">
                        <tr>
                            <td>${ emp.empId }</td>
                            <td>${ emp.empName }</td>
                            <td>${ emp.gender == "M" ? "男" : "女" }</td>
                            <td>${ emp.email }</td>
                            <td>${ emp.department.deptName }</td>
                            <td>
                                <button class="btn btn-info btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
<%--        显示分页信息--%>
        <div class="row">
<%--            分页文字信息--%>
            <div class="col-md-6">
                当前 ${ pageInfo.pageNum } 页，总 ${ pageInfo.pages } 页，总 ${ pageInfo.total } 条记录
            </div>
<%--            分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <%--首页--%>
                        <li><a href="${ APP_PATH }/emps?pn=1">首页</a></li>
                        <%--如果有上一页--%>
                        <c:if test="${ pageInfo.hasPreviousPage }">
                            <%--上一页--%>
                            <li>
                                <a href="${ APP_PATH }/emps?pn=${ pageInfo.pageNum - 1 }" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <%--显示五页--%>
                        <c:forEach items="${ pageInfo.navigatepageNums }" var="page_Num">
                            <%--当前页--%>
                            <c:if test="${ page_Num == pageInfo.pageNum }">
                                <li class="active"><a href="/">${ page_Num }</a></li>
                            </c:if>
                            <%--不是当前页--%>
                            <c:if test="${ page_Num != pageInfo.pageNum }">
                                <li><a href="${ APP_PATH }/emps?pn=${ page_Num }">${ page_Num }</a></li>
                            </c:if>
                        </c:forEach>
                        <%--如果有下一页--%>
                        <c:if test="${ pageInfo.hasNextPage }">
                            <%--下一页--%>
                            <li>
                                <a href="${ APP_PATH }/emps?pn=${ pageInfo.pageNum + 1 }" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <%--尾页--%>
                            <li><a href="${ APP_PATH }/emps?pn=${ pageInfo.pages }">尾页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
