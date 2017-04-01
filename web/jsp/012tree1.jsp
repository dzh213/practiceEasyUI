<%--
  Created by IntelliJ IDEA.
  User: donghao
  Date: 2017/3/22
  Time: 19:10
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
                    <!--
                    1.使用html和js分别创建tree
                    2.tree的基本属性
                    3.tree的基本方法
                    -->
<!--html形式渲染tree-->
<ul id="t1" class="easyui-tree">
    <li>
        <span>根节点</span>
        <ul>
            <li><span>节点1</span></li>
            <li><span>节点2</span></li>
            <li><span>节点3</span></li>
        </ul>
    </li>
</ul>
<hr/>
<!--js代码初始化tree-->
<ul id="t2"></ul><br/>
                    <input type="button" onclick="getRoot()" value="获取根节点"/>
                    <input type="button" onclick="getChildren()" value="获取子节点"/>
                    <input type="button" onclick="getChecked()" value="获取所有选中的节点"/>
                    <input type="button" onclick="isLeaf()" value="判断是否是叶子节点"/>
<script>
    $(function () {
        $("#t2").tree({
            url:'012tree1.json',
            animate:true,        //展开收缩动画效果,默认为false
            checkbox:true,
            dnd:true,        //拖拽
            cascadeCheck:false  //选中是否级联,默认true
        });
    })
    function getRoot(){
        console.info($("#t2").tree("getRoot"));
    }
    function getChildren(){
        var root = $("#t2").tree("getRoot");
        console.info($("#t2").tree("getChildren",root.target));
    }
    function getChecked(){
        console.info($("#t2").tree("getChecked"))
    }
    function isLeaf(){
        //判断选中的节点是否是叶子节点
        var select = $("#t2").tree("getSelected");  //获取选中的节点,如果没有返回null
        console.info($("#t2").tree("isLeaf",select.target));
    }
</script>
</body>
</html>
