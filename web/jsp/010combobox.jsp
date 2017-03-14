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
<!---------------------------------------combobox学习-------------------------------------------------------------------------------->
            <!--
                1.combobox组件基本用法,两个主要属性valueField和textField
                2.后台关于存在有参构造函数时,必须有无参构造函数
                3.使用onSelect方法时出现的问题:
                    在onSlect方法中使用getValue和getText方法,获取不到最新的选择项,
                    即只有onSelect方法执行完毕后,dom对象才刷新,无法获取到id.
                    所以使用带参数的onSelect方法,param参数就是当前选择的对象,可从中取出在combobox中定义的valueField,textField字段的值
            -->
<script>
    window.onload = function(){
        $("#sel_1").combobox({
            //当用户选择一个列表项时触发
            onSelect: function (param) {
                var pid = param.id;
                //var pid = $('#sel_1').combobox('getValue');
                //var text = $("#sel_1").combobox("getText");
                //var data = $("#sel_1").combobox("getData");
                $("#sel_2").combobox("reload","../ProvinceServlet?method=getCity&pid="+pid);
            }
        })
    }
</script>

<select id="sel_1" class="easyui-combobox" url="../ProvinceServlet?method=getPro" valueField="id" textField="name" style="width: 80px"></select>
<select id="sel_2" class="easyui-combobox" valueField="id" textField="city" style="width: 80px"></select>


</body>
</html>
