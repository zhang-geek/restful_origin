<%--
  Created by IntelliJ IDEA.
  User: zhangzhikai
  Date: 2020/2/23
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/static/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/static/layer/layer.js"></script>
</head>
<script type="text/javascript">
    function update() {
        var index = layer.load(1);
        $.post(
            "<%=request.getContextPath()%>/users",
            $("#fm").serialize(),
            function(data) {
                layer.close(index);
                if (data.code != 200){
                    layer.msg(data.msg);
                    return;
                }
                layer.msg(data.msg,{time:1000},function(){
                    parent.window.location.href = "<%=request.getContextPath()%>/user/toShow";
                });
            }
        );
    }
</script>
<body>
<form id="fm">
    <input type="hidden" value="PUT" name="_method">
    <input type="hidden" value="${user.id}" name="id">
    用户名：<input type="text" name="username" id="username" value="${user.username}"><br>
    密码：<input type="text" name="password" value="${user.password}"><br>
    性别：<input type="radio" name="sex" value="1" checked>男
        <input type="radio" name="sex" value="2" <c:if test="${user.sex == 2}">checked</c:if>>女<br>
    年龄：<input type="text" name="age" value="${user.age}"><br>
    <input type="button" value="update" onclick="update()"><br>
</form>
</body>
</html>
