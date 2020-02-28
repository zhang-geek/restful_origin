<%--
  Created by IntelliJ IDEA.
  User: zhangzhikai
  Date: 2020/2/23
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
</head>
<script type="text/javascript">

    $(function () {
        search();
    })

    function search() {
        var index = layer.load(1);
        $.post(
            "<%=request.getContextPath()%>/users/list",
            $("#fm").serialize(),
            function (data) {
                layer.close(index);
                if (data.code != 200) {
                    layer.alert(data.msg);
                    return;
                }
                var html = "";
                for (var i = 0; i < data.data.list.length; i++) {
                    var user = data.data.list[i];
                    html += "<tr>";
                    html += "<td><input type='checkbox' name='ids' value='"+user.id+"'></td>"
                    html += "<td>" + user.id +"</td>";
                    html += "<td>" + user.username +"</td>";
                    html += "<td>" + user.password +"</td>";
                    html += user.sex == 1 ? "<td>男</td>" : "<td>女</td>";
                    html += "<td>" + user.age +"</td>";
                    html += "<td>" + user.createTime +"</td>";
                    html += user.updateTime == null ? "<td>暂无</td>" : "<td>" + user.updateTime +"</td>";
                    html += "</tr>";
                }
                $("#tbd").html(html);
                var pageHtml = "";
                var pageNo = parseInt($("#pageNo").val());
                pageHtml += "<input type='button' value='上一页' onclick='page("+data.data.totalNum+","+(pageNo - 1)+")'/>";
                pageHtml += "<input type='button' value='下一页' onclick='page("+data.data.totalNum+","+(pageNo + 1)+")'/>";
                $("#pageInfo").html(pageHtml);
            }
        );
    }

    function page(totalNum, pageNo) {
        if (pageNo < 1) {
            layer.msg("已是第一页");
            return;
        }
        if (pageNo > totalNum) {
            layer.msg("已是最后一页");
            return;
        }
        $("#pageNo").val(pageNo);
        search();
    }

    function fuzzySearch() {
        $("#pageNo").val(1);
        search();
    }

    function getIds() {
        var ids=new Array();
        $(":checkbox[name='ids']:checked").each(function () {
            ids.push($(this).val());
        })
        return ids;
    }

    function toUpdate() {
        var ids = getIds();
        if (ids.length < 1){
            layer.msg("请选择一条数据");
            return;
        }
        if (ids.length > 1) {
            layer.msg("只能选择一条数据！");
            return;
        }
        //iframe层
        layer.open({
            type: 2,
            title: '修改',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            shade: 0.8,
            area: ['380px', '90%'],
            content: '<%=request.getContextPath()%>/user/toUpdate?id='+ids[0]
        });
    }

    function del() {
        var ids = getIds();
        if (ids.length < 1){
            layer.msg("请选择一条数据");
            return;
        }
        layer.confirm('确认删除？', {icon: 3, title:'提示'}, function(index){
            $.post(
                "${ctx}/users",
                {"id":ids.join(","), "_method":"DELETE", "isDel" : 0},
                function (data) {
                    layer.msg(data.msg,{time:500},function () {
                        window.location.href = "<%=request.getContextPath()%>/user/toShow";
                    });
                }
            );
            layer.close(index);
        });
    }

    function toCreate() {
        layer.open({
            type: 2,
            title: '修改',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            shade: 0.8,
            area: ['380px', '90%'],
            content: '<%=request.getContextPath()%>/user/toCreate'
        });
    }
</script>
<body>
<form id="fm">
    <input type="hidden" value="1" name="pageNo" id="pageNo">
    <input type="hidden" value="2" name="pageSize">
    <input type="text" name="username" placeholder="用户名"><br>
    性别：<input type="radio" name="sex" value="1" >男
    <input type="radio" name="sex" value="2" >女
    <input type="radio" name="sex" value="0" >都行<br>
    年龄：<input type="text" name="startAge">~<input type="text" name="endAge"><br>
    <input type="button" value="search" onclick="fuzzySearch()">
</form>
    <input type="button" value="新增" onclick="toCreate()">
    <input type="button" value="修改" onclick="toUpdate()">
    <input type="button" value="删除" onclick="del()">
<table border="1px" cellpadding="5" cellspacing="0">
    <tr>
        <th></th>
        <th>id</th>
        <th>用户名</th>
        <th>密码</th>
        <th>性别</th>
        <th>年龄</th>
        <th>注册时间</th>
        <th>修改时间</th>
    </tr>
    <tbody id="tbd"></tbody>
</table>
<div id="pageInfo"></div>
</body>
</html>
