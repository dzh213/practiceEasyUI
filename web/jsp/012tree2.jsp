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
                    1.远程加载tree
                    2.model对象和数据库字段相对应,从数据库取到数据封装到model对象,但字段不是tree需要的格式,
                        所以建立dto,对model中的数据进行中转,将转换后的dto数据转换成json传给前端tree
                    3.tree的基本格式
                        id：节点的 id，它对于加载远程数据很重要。
                        text：要显示的节点文本。
                        state：节点状态，'open' 或 'closed'，默认是 'open'。当设置为 'closed' 时，该节点有子节点，并且将从远程站点加载它们。
                        checked：指示节点是否被选中。
                        attributes：给一个节点添加的自定义属性。
                        children：定义了一些子节点的节点数组。
                    4.url异步ajax请求时,会携带节点id,第一次加载tree不会有id,展开子节点会有,发送给后端,异步加载
                    5.后台从数据库加载tree所需要的数据.
                        model数据转换为dto数据
                        第一次为根节点的sql处理
                        是否有子节点的判断,有子节点的话展开状态设置为closed,否则open,这样展开子节点时会继续异步请求
                    6.onDrop拖拽事件(设置操作节点的父节点)
                        target:dom对象,放置的目标节点
                        source:源节点对象,被操纵的节点对象
                        point:放置操作,可能的值是：'append'、'top' 或 'bottom'。
                        后台在进行处理时,append操作即目标节点(target)是操作节点(source)的父节点,
                        top和bottom相对方式时,操作节点的父节点为目标节点的父节点.
                    -->

<!--js代码初始化tree-->
<ul id="t1"></ul><br/>
<script>
    $(function () {
        $("#t1").tree({
            //发送异步ajax请求,还会携带一个id的参数
            url:"../ResourceServlet?method=loadTree",
            dnd:true,
            onDrop: function (target,source,point) {
//                console.info($("#t1").tree("getNode",target));//getNode方法,根据dom对象获取节点对象
//                console.info(source);
//                console.info(point);
                var tar = $("#t1").tree("getNode",target);
                $.ajax({
                    url:"../ResourceServlet?method=changeLevel",
                    type:"post",
                    data:{
                        "targetId":tar.id,
                        "sourceId":source.id,
                        "point":point
                    },
                    success: function () {
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
        });
    })
</script>
</body>
</html>
