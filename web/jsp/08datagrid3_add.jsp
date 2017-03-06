<%--
  Created by IntelliJ IDEA.
  User: donghao
  Date: 2016/11/2
  Time: 20:17
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
<script>
    $(function () {
        //-----------------------------------------------datagrid添加数据---------------------------------------
        /**
         *  1.dialog的使用
         *  2.datagrid异步刷新load和reload的区别:
         *      load:刷新到首页
         *      reload:刷新当前分页
         */

        //添加表单
        $("#save").click(function () {
            //如果验证通过
            if($("#form1").form("validate")){
                $.ajax({
                    url:"../UserServlet?method=save",
                    type:"post",
                    data:$("#form1").serialize(),
                    dataType:"json",
                    success: function (result) {
                        //1.关闭dialog
                        $("#mydialog").dialog("close");
                        //2.刷新datagrid的当前记录
                        $("#mydata").datagrid("reload");
                        //3.显示提示信息
                        $.messager.show({
                            title:"提示信息",
                            msg : result.message
                        })
                    },
                    error: function () {
                        alert("error");
                    }
                })
            }else{
                $.messager.show({
                    title:"提示信息",
                    msg : "数据验证不通过"
                })
            }
        })
    })
</script>

</head>
<body>
<table id="mydata">
</table>
<!--closed设置为true,默认关闭(不显示)
    draggable:设置是否可以拖拽
    modal:是否添加遮罩层
-->
<div id="mydialog" draggable="false" modal="true" class="easyui-dialog" title="新增用户"style="width: 300px" closed="true">
    <form action="" method="post" id="form1">
        <table>
            <tr>
                <td>用户名:</td>
                <td><input type="text" name="username" class="easyui-validatebox" required=true
                           validType="midLength[2,5]" missingMessage="用户名必填!" invalidMessage="用户名必须在2到5个字符之间!"
                           value=""/></td>
            </tr>
            <tr>
                <td>密码:</td>
                <td><input type="password" name="password" class="easyui-validatebox" required=true
                           validType="equalLength[4]" missingMessage="密码必填!" value=""/></td>
            </tr>
            <tr>
                <td>性别:</td>
                <td>
                    男<input type="radio" checked="checked" name="sex" value="1"/>
                    女<input type="radio" name="sex" value="2"/>
                </td>
            </tr>
            <tr>
                <td>年龄:</td>
                <td><input id="age" type="text" name="age" value=""/></td>
            </tr>
            <tr>
                <td>出生日期:</td>
                <td><input id="birthday" style="width:160px;" type="text" name="birthday" value=""/></td>
            </tr>
            <tr>
                <td>所属城市:</td>
                <td>
                    <!--combobox组件,获取下拉选项,select和input都能够使用,是input变成select形式了.
                        valueField:绑定到 ComboBox 的 value 上的基础数据的名称
                        textField:绑定到 ComboBox 的 text 上的基础数据的名称。
                        valueField,textField值要和json数据进行绑定
                        通过url访问到的json数据:[{"city":"北京","id":1,"pro_id":0},{"city":"上海","id":2,"pro_id":0},{"city":"济南","id":3,"pro_id":0}]
                     -->
                    <input name="city" class="easyui-combobox" url="/easy01/UserServlet?method=getCity" valueField="id"
                           textField="city" value=""/>
                </td>
            </tr>
            <tr>
                <td>薪水:</td>
                <td><input id="salary" type="text" name="salary" value=""/></td>
            </tr>
            <tr>
                <td>开始时间:</td>
                <td><input id="startTime" style="width:160px;" type="text" name="startTime" value=""/></td>
            </tr>
            <tr>
                <td>结束时间:</td>
                <td><input id="endTime" style="width:160px;" type="text" name="endTime" value=""/></td>
            </tr>
            <tr>
                <td>个人描述:</td>
                <td><input type="text" name="description" class="easyui-validatebox" required=true
                           validType="midLength[5,50]" missingMessage="个人描述必填!" invalidMessage="描述必须在5到50个字符之间!"
                           value=""/></td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <a class="easyui-linkbutton" id="save">保存</a>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
<script>
    $(function () {
        $("#mydata").datagrid({
            idField: 'id',//指示哪个字段为标识字段,必备!
            title: "datagrid展示",
            width: 1000,
            height: 'auto',
            url: '../UserServlet?method=getList',
            striped: true,//奇偶行变色
            nowrap: true,//数据显示在一行,默认为true,如果设为false,数据达到指定宽度会换行显示
            rownumbers: true,//显示行号
            //singleSelect:true,//单选模式
            rowStyler: function (index, row) {
//        console.log(index); 行的索引,从0开始
//        console.log(row);   每一行的数据对象
                if (row.age > 25) {
                    return "background:red";//将满足条件的行更改样式
                }
            },
            pagination: true,//启用分页组件
            pageSize: 5,//初始化页面条数,该数值一定是pageList中的数值
            pageList: [5, 6, 10, 20, 50],//自定义显示页面条数
            fitColumns: true,  //自动适应宽度,防止拖拽

            toolbar: [{
                text: "新增用户",
                iconCls: "icon-add",
                handler: function () {
                    //先清空表单数据
                    //$("#form1").find("input[name!=sex]").val("");//通过jquery过滤radio的,设置为空字符串
//                    $("#form1").form("clear");//执行form表单对象的clear方法,但是和第一种方法一样,radio中的value也会被清空
                    $("#form1").get(0).reset();//通过js对象的reset方法
                    $("#mydialog").dialog("open");
                }
            }, {
                text: "修改用户",
                iconCls: "icon-edit",
                handler: function () {

                }
            }, {
                text: "删除用户",
                iconCls: "icon-remove",
                handler: function () {

                }
            }, {
                text: "查询用户",
                iconCls: "icon-search",
                handler: function () {

                }
            }],


            columns: [[{
                //注意,checkbox列,datagrid的属性singleSelect:true,被设置为单选,会影响复选
                field: "checkbox", //此列是复选框,field可以随意写
                width: 50,
                checkbox: true //将此列设置checkbox属性,此列为复选框列
            }, {  //注意,这是一个二维数组
                field: "username",
                title: "用户名",
                width: 100,
                align: "center",  //指示如何对齐该列的数据，可以用 'left'、'right'、'center'
                styler: function (value, rowData, rowIndex) { //设置单元格的样式
                    if (value == "admin") {
                        return "background:blue";
                    }
                }
            }, {
                field: "password",
                title: "密码",
                width: 100
            }, {
                field: "age",
                title: "年龄",
                width: 100,
                sortable: true //允许该列被排序,列字段处有三角号标识,逻辑需要自己写
            }, {
                field: "salary",
                title: "薪水",
                width: 100
            }, {
                field: "sex",
                title: "性别",
                width: 100,
                formatter: function (value, rowData, rowIndex) {
                    /*
                     value：字段的值。 如:当前的1,2
                     rowData：行的记录数据。 后台返回这条记录的json数据
                     rowIndex：行的索引。
                     */
                    if (value == 1) {
                        return "男";
                    } else if (value == 2) {
                        return "女";
                    }
                }
            }, {
                field: "birthday",
                title: "生日",
                width: 100
            }, {
                field: 'city',
                title: "城市",
                width: 100,
                formatter: function (value, rowData, rowIndex) {
                    /*
                     if(value == 1){
                     return "北京";
                     }else if(value == 2){
                     return "上海";
                     }else if(value == 3){
                     return "济南";
                     }else if(value == 4){
                     return "杭州";
                     }
                     */
                    var res = "";
                    $.ajax({
                        url: '../UserServlet?method=getListName',
                        type: "post",
                        dataType: "json",
                        data: {
                            "id": value
                        },
                        async: false,//一定要将这个ajax设置成同步请求,因为有返回值
                        success: function (result) {
                            res = result.city;
                        },
                        error: function () {
                            alert("error");
                        }
                    })
                    return res;
                }
            }, {
                field: "startTime",
                title: "开始日期",
                width: 100
            }, {
                field: "description",
                title: "个人描述",
                width: 100,
                formatter: function (value, rowData, rowIndex) {   //数据太长无法完全显示,光标移动上方显示title
                    return "<span title=" + value + ">" + value + "</span>"
                }
            }]]
        })
    })




    //表单验证
    $(function () {
        // 自定义的校验器
        $.extend($.fn.validatebox.defaults.rules, {
            midLength: {
                //验证规则,value的长度必须在[2,5]之间
                validator: function (value, param) {    //value为输入的参数,param为定义的数组midLength[2,5]
                    return value.length >= param[0] && value.length <= param[1];
                },
                message: ''     //和html中的invalidMessage等价,html中的优先级大
            },
            equalLength: {
                validator: function (value, param) {
                    return value.length == param[0];
                },
                message: '密码必须为4个字符!'
            }
        });

        //数字验证组件
        $("#age").numberbox({
            min: 0,
            max: 100,
            required: true,
            missingMessage: "年龄必填",
            precision: 0 //允许小数点为0位
        })

        //日期验证插件
        $("#birthday").datebox({
            required: true,
            missingMessage: "生日必填",
            editable: false	//禁用手动编辑,只能通过组件点击日期
        })

        //薪水验证
        $("#salary").numberbox({
            required: true,
            missingMessage: "薪水必填",
            min: 200,
            max: 2000,
            precision: 2
        })

        //日期验证
        $("#startTime,#endTime").datebox({
            required: true,
            missingMessage: "日期必填",
            editable: false
        })

    })
</script>
</html>
