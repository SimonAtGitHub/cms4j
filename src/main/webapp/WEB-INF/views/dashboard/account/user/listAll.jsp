<%--
  查看所有用户
  User: baitao.jibt@gmail.com
  Date: 12-4-3
  Time: 下午15:32
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户列表</title>
</head>
<body>
<div class="row">
    <div class="span12">
        <form:form modelAttribute="article" id="articleForm" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>用户名</th>
                    <th>邮箱</th>
                    <th>用户组</th>
                    <th>创建时间</th>
                    <th>最后登录时间</th>
                    <th>最后登录IP</th>
                    <th>审核状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user" begin="0" step="1" varStatus="stat">
                    <tr class="gradeA">
                        <td><input type="checkbox" name="isSelected" value="${user.id}"></td>
                        <td>${user.username}</td>
                        <td>${user.email} <c:choose><c:when test="${user.emailStatus}"><img src="${ctx}/static/js/jquery-validation/images/checked.gif"/></c:when><c:otherwise><img src="${ctx}/static/js/jquery-validation/images/unchecked.gif"/></c:otherwise></c:choose>
                        </td>
                        <td><c:forEach items="${user.groupList}" begin="0" step="1" var="group">${group.groupName} </c:forEach></td>
                        <td><fmt:formatDate value="${user.createdDate}" type="both"/></td>
                        <td><fmt:formatDate value="${user.lastTime}" type="both"/></td>
                        <td>${user.lastLoginIP}</td>
                        <td><a href="${ctx}/account/user/audit/${user.id}"><c:choose><c:when test="${user.status}"><span class="green_text">已审核</span></c:when><c:otherwise><span class="red_text">未审核</span></c:otherwise></c:choose></a></td>
                        <td>${article.deleted}<a href="${ctx}/account/user/repass/${user.id}">【密码找回】</a> <a href="${ctx}/account/user/edit/${user.id}">【编辑】</a> <a href="${ctx}/account/user/delete/${user.id}"><c:choose><c:when test="${user.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="control-group">
                <div class="controls">
                    <button class="btn btn-primary" id="auditAll"><i class="icon-flag icon-white"></i> 批量审核</button>
                    <button class="btn btn-primary" id="deleteAll"><i class="icon-remove icon-white"></i> 批量删除</button>
                </div>
            </div>
        </form:form>
    </div>
</div>
<script>
    $(function () {
        $(".alert").delay(1500).fadeOut("slow");

        $('#auditAll').click(function () {
            if (confirm("确定批量审核吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/auditAll").submit();
            } else {
                return false;
            }
        });

        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/deleteAll").submit();
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>