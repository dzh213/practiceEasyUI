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
                1.menu菜单组件的使用
                2.tree中onContextMenu事件的使用,右键点击节点时触发
                3.回顾dialog的使用
                4.新增节点
                    前台更新:getSelected方法获取节点对象
                            tree中的append方法追加节点
                                第一个参数 parent:dom对象的父节点
                                第二个参数 data:数组,节点数据,能够批量新增
                    后台更新
                        异步发送ajax请求,主要参数为父节点的id
                        返回时要reload选中节点的父节点,重新加载局部tree,获取新增节点的id

                5.更新节点
                    将选中节点的id(主要)以及更新的参数异步发送给后台
                    后台response.setContentType("text/xml;charset=utf-8");避免ajax中dataType为json时出错
                    ajax请求结束后回调在页面刷新修改节点的父节点
                6.删除节点
                    后台孩子节点的递归删除
            -->
<script>

    var flag;
    function append(){
        flag = "add";
        $("#mydiv").dialog("open");
    }
    function editor(){
        flag ="edit";
        //清空表单中的信息
        $("#myform").get(0).reset();
        //重新填充选中节点的数据
        var node = $("#t1").tree("getSelected");
        //将node节点对象的json数据加载到form表单中
        $("#myform").form("load",{
            id:node.id,
            name:node.text,
            url:node.attributes.url
        })
        //打开dialog
        $("#mydiv").dialog("open");
    }
    function remove(){
        //前台删除
        var node = $("#t1").tree("getSelected");
        $("#t1").tree("remove",node.target);

        //后台删除
        $.post("../ResourceServlet?method=delete",{id:node.id}, function (result) {
            $.messager.show({
                title:"提示信息",
                msg:"操作成功"
            });
        })
    }
</script>
<!--js代码初始化tree-->
<ul id="t1"></ul>
<br/>

<div class="easyui-menu" id="mm" style="width: 150px">
    <div onclick="append()">添加</div>
    <div onclick="editor()">编辑</div>
    <div onclick="remove()">删除</div>
</div>
            <div id="mydiv" class="easyui-dialog" closed="true" title="设置权限">
                <form id="myform" method="post">
                    <input type="hidden" name="id" id="id"/>
                    <table>
                        <tr>
                            <td>权限名称:</td>
                            <td><input type="text" name="name"/></td>
                        </tr>
                        <tr>
                            <td>url:</td>
                            <td><input type="text" name="url"/></td>
                        </tr>
                        <tr align="center">
                            <td colspan="2">
                                <a id="savebtn" class="easyui-linkbutton">保存</a>
                                <a id="cancelbtn" class="easyui-linkbutton">取消</a>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
<script>
    $(function () {



        //新增菜单保存
        $("#savebtn").click(function () {
            if(flag == "add"){
                //1.做前台更新
                //获取选中节点的节点对象
                var node = $("#t1").tree("getSelected");
                //添加子节点
                $("#t1").tree("append",{
                    parent:node.target,
                    data:[{
                        text:$("#myform").find("input[name=name]").val(),
                        attributes:{
                            url:$("#myform").find("input[name=url]").val()//因为是自定义属性,所以要放到attributes中
                        }
                    }]
                });

                //2.后台同步更新
                $.ajax({
                    url:"../ResourceServlet?method=save",
                    type:"post",
                    //dataType:"json",
                    data:{
                        parentId:node.id,
                        name:$("#myform").find("input[name=name]").val(),
                        url:$("#myform").find("input[name=url]").val()
                    },
                    success: function (data) {
                        //重新从后台加载一次选中节点,因为新增完的节点,在前台是没有节点id的,所以无法给新增的节点继续添加节点
                        //使用reload方法,更新新增节点的父节点,
                        var parent = $('#t1').tree('getParent' ,node.target);
                        $('#t1').tree('reload',parent.target);

                        $.messager.show({
                            title:"提示信息",
                            msg:"操作成功"
                        });
                    },
                    error: function () {
                        alert("error");
                    }
                })
            }else if(flag == "edit"){
                //直接后台更新
                $.ajax({
                    url:"../ResourceServlet?method=update",
                    type:"post",
                    dataType:"json",
                    data:{
                        "id":$("#myform").find("input[name=id]").val(),
                        "name":$("#myform").find("input[name=name]").val(),
                        "url":$("#myform").find("input[name=url]").val()
                    },
                    success: function (data) {
                        //刷新节点(一定是选中节点的父节点)
                        var node = $('#t1').tree('getSelected');
                        var parent = $('#t1').tree('getParent' ,node.target);
                        $('#t1').tree('reload',parent.target);

                        $.messager.show({
                            title:"提示信息",
                            msg:"操作成功"
                        });
                    },
                    error: function () {
                        alert("error");
                    }
                })
            }


            $("#mydiv").dialog("close");

        })
        //取消按钮
        $("#cancelbtn").click(function () {
            $("#mydiv").dialog("close");
        })
        
        $("#t1").tree({
            //发送异步ajax请求,还会携带一个id的参数
            url: "../ResourceServlet?method=loadTree",
            dnd: true,
            //右键点击节点触发菜单事件
            onContextMenu: function (even,node) {
                //禁止浏览器默认右键菜单
                even.preventDefault();
                //选中一个节点,让节点高亮
                $("#t1").tree("select",node.target);
                //让菜单显示出来
                $("#mm").menu("show",{
                    left:even.pageX,
                    top:even.pageY
                })
            },
            onDrop: function (target, source, point) {
//                console.info($("#t1").tree("getNode",target));//getNode方法,根据dom对象获取节点对象
//                console.info(source);
//                console.info(point);
                var tar = $("#t1").tree("getNode", target);
                $.ajax({
                    url: "../ResourceServlet?method=changeLevel",
                    type: "post",
                    data: {
                        "targetId": tar.id,
                        "sourceId": source.id,
                        "point": point
                    },
                    success: function () {
                        $.messager.show({
                            title: "提示信息",
                            msg: "操作成功"
                        });
                    },
                    error: function () {
                        alert("error");
                    }
                })
            }
        });
    })
</script>
</body>
</html>
