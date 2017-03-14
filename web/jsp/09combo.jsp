<%--
  Created by IntelliJ IDEA.
  User: donghao
  Date: 2017/3/10
  Time: 20:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="../jquery-easyui-1.5/jquery.min.js"></script>
    <link type="text/css" rel="stylesheet" href="../jquery-easyui-1.5/themes/default/easyui.css"/>
    <link type="text/css" rel="stylesheet" href="../jquery-easyui-1.5/themes/icon.css"/>
    <script src="../jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script src="../jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>

<select id="cc" style="width:150px"></select>

<div id="sp">
    <div style="color:#99BBE8;background:#fafafa;padding:5px;">Select a language</div>
    <div style="padding:10px">
        <input type="radio" name="lang" value="01"><span>Java</span><br/>
        <input type="radio" name="lang" value="02"><span>C#</span><br/>
        <input type="radio" name="lang" value="03"><span>Ruby</span><br/>
        <input type="radio" name="lang" value="04"><span>Basic</span><br/>
        <input type="radio" name="lang" value="05"><span>Fortran</span>
    </div>
</div>
<script>
    $(function () {
        $("#cc").combo({
            required:true,
            editable:false//禁止输入
        })
        $("#sp").appendTo($("#cc").combo("panel"));//调用combo的panel方法,获取下拉面板对象
        $("#sp input").click(function () {
            var v = $(this).val();
            var s = $(this).next('span').text();
            $("#cc").combo("setValue",v).combo("setText",s).combo("hidePanel");//将选中的选项回显到文本框
        })
    })
</script>

</body>
</html>
