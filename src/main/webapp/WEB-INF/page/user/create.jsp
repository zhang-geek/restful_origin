<%--
  Created by IntelliJ IDEA.
  User: zhangzhikai
  Date: 2020/2/23
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/static/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/static/layer/layer.js"></script>
</head>
<script type="text/javascript">
    $(function(){
        $("#fm").validate({
            errorPlacement: function (error, element) {
                if(element.is("[name='userSex']")){//如果需要验证的元素名为userSex
                    error.appendTo($("#sexSpan"));   //错误信息增加在id为‘sexSpan’中
                }else {
                    error.insertAfter(element);//其他的就显示在添加框后
                }
            },
            rules:{
                username:{
                    required:true,
                    rangelength:[0,10],
                    remote: {
                        type: 'get',
                        url: "<%=request.getContextPath()%>/users/deDuplicate",
                        dataType: "json"
                    }
                },
                password:{
                    required:true,
                    rangelength:[0,6]
                },
                age:{
                    required:true,
                    range: [0,100]
                },
                sex:{
                    required:true
                }
            },
            messages:{
                username:{
                    required:"请输入姓名",
                    rangelength:"长度限制在{0}到{1}之间",
                    remote:"用户名已存在~"
                },
                password:{
                    required:"请输入密码",
                    rangelength:"长度限制在{0}到{1}之间"
                },
                age:{
                    required:"请输入年龄",
                    range: "请输入{0}到{1}之间的整数"
                },
                sex:{
                    required:"请选择性别"
                }
            }
        })
    })

    $.validator.setDefaults({
        submitHandler : function() {
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
    });

</script>
<body>
<form id="fm">
    用户名：<input type="text" name="username" id="username"><br>
    密码：<input type="text" name="password"><br>
    性别：<input type="radio" name="sex" value="1">男<input type="radio" name="sex" value="2">女
    <span id="sexSpan"></span><br>
    年龄：<input type="text" name="age"><br>
    <input type="submit"><br>
</form>
</body>
</html>
