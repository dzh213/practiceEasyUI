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
            //-----------------------------------------------editgrid---------------------------------------
            /**
             * 1.添加一行appendRow方法,被添加到最后一行,参数为一个行对象
             * 2.列属性editor,指定某列可编辑
             *      指示编辑类型。当是字符串（string）时则指编辑类型，当是对象（object）时则包含两个属性：
                    type：字符串，编辑类型，可能的类型：text、textarea、checkbox、numberbox、validatebox、datebox、combobox、combotree。
                    options：对象，编辑类型对应的编辑器选项。
             3.getRows方法获取当前页所有行的数组对象以及数组长度
             4.新增行的索引位为数组个数-1
             5.使用beginEdit方法开启对一行的编辑,传入参数为该行的索引位
             6.使用endEdit方法结束编辑
             7.使用validateRow校验一行的数据是否符合editor属性指定的格式.
             8.onAfterEdit事件,当结束编辑这一行会自动触发该事件
                    两个参数,index:在当前页的索引
                            record:这一行的数据
             9.回顾getSelections方法
             10.getRowIndex方法,获取指定行的索引,参数为一个行对象
             11.rejectChanges方法,回滚数据
             12.回顾删除操作,别忘了删完之后使用unselectAll清空idField
             */


        })
    </script>

</head>
<body>

<table id="mydata"></table>

</body>
<script>
    $(function () {
        var edit_flag = false;  //其实不指定值更好,为undefind的,不占用资源
        var method_flag;
        var rowIndex;   //行的索引
        $("#mydata").datagrid({

            toolbar: [{
                text: "新增用户",
                iconCls: "icon-add",
                handler: function () {
                    if(!edit_flag){
                        edit_flag = true;
                        method_flag = "save";
                        //1.追加一行
                        $("#mydata").datagrid("appendRow",{description:""});
                        //2.获取当前页的新增行的行号
                        rowIndex = $("#mydata").datagrid("getRows").length -1;
                        //3.开启编辑状态
                        $("#mydata").datagrid("beginEdit",rowIndex);
                    }else{
                        $.messager.show({
                            title:"提示",
                            msg:"已开启编辑状态了,不能再添加"
                        });
                    }

                }
            }, {
                text: "修改用户",
                iconCls: "icon-edit",
                handler: function () {
                    var arr = $("#mydata").datagrid("getSelections");
                    if(arr.length != 1){
                        $.messager.show({
                            title:"提示信息",
                            msg:"只能选择一条记录"
                        });
                    }else{
                        if(!edit_flag){
                            edit_flag = true;
                            method_flag = "update";
                            //获取指定行的索引,变为可编辑
                            rowIndex = $("#mydata").datagrid("getRowIndex",arr[0]);
                            $("#mydata").datagrid("beginEdit",rowIndex);
                        }
                    }

                }
            },{
                text: "保存用户",
                iconCls: "icon-save",
                handler: function () {
                    //保存之前先进行数据校验
                    if($("#mydata").datagrid("validateRow",rowIndex)){
                        //满足校验则取消编辑状态,页面数据保存
                        $("#mydata").datagrid("endEdit",rowIndex);
                        edit_flag = false;
                    }
                }
            }, {
                text: "删除用户",
                iconCls: "icon-remove",
                handler: function () {
                    var arr = $("#mydata").datagrid("getSelections");
                    if(arr.length <= 0){
                        $.messager.show({
                            title:"提示信息",
                            msg:"请至少选择一条记录操作"
                        });
                    }else{
                        $.messager.confirm("提示信息","你确定要删除选中的记录吗?", function (flag) {
                            if(flag){
                                var ids = "";
                                for(var i = 0;i < arr.length; i++){
                                    ids = arr[i].id + ",";
                                }
                                ids = ids.substring(0,ids.length-1);
                                $.post("../UserServlet?method=delete",{ids:ids}, function (result) {
                                    $("#mydata").datagrid("reload");
                                    $("#mydata").datagrid("unselectAll");
                                    $.messager.show({
                                        title:"提示信息",
                                        msg:"操作成功!"
                                    });
                                })
                            }
                        });
                        
                    }
                }
            }, {
                text: "取消操作",
                iconCls: "icon-cancel",
                handler: function () {
                    $("#mydata").datagrid("rejectChanges");//回滚数据
                    edit_flag = false;//手动改为未编辑状态
                }
            }],
            onAfterEdit: function (index,record) {  //事件
                $.post("../UserServlet?method="+method_flag, record,function (result) {
                    $.messager.show({
                        title:"提示信息",
                        msg:"保存成功!"
                    });
                    method_flag = undefined;
                })
            },


            idField: 'id',//指示哪个字段为标识字段,必备!
            title: "datagrid展示",
            //width: 1000,
            //fit:true,//自适应父容器
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
                },
                editor:{
                    type:"validatebox",
                    options:{
                        required:true,
                        missingMessage:"用户名必填"
                    }
                }

            }, {
                field: "password",
                title: "密码",
                width: 100,
                editor:{
                    type:"validatebox",
                    options:{
                        required:true,
                        missingMessage:"密码必填"
                    }
                }
            }, {
                field: "age",
                title: "年龄",
                width: 100,
                sortable: true, //允许该列被排序,列字段处有三角号标识,逻辑需要自己写
                //设置该列后,点击三角标识,会异步向后台发送sort和order两个参数
                editor:{
                    type:"numberbox",
                    options:{
                        required:true,
                        missingMessage:"年龄必填",
                        min:10,
                        max:100,
                        precision:0 //小数点后为0位
                    }
                }
            }, {
                field: "salary",
                title: "薪水",
                width: 100,
                editor:{
                    type:"numberbox",
                    options:{
                        min:1000,
                        max:10000
                    }
                }
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
                },
                editor:{
                    type:"combobox",
                    options:{
                        data:[{
                            id:1,
                            val:"男"
                        },{
                            id:2,
                            val:"女"
                        }],
                        valueField:"id",
                        textField:"val",
                        required:true,
                        misssingMessage:"性别必填"
                    }
                }
            }, {
                field: "birthday",
                title: "生日",
                width: 100,
                editor:{
                    type:"datebox",
                    options:{
                        required:true,
                        missingMessage:"生日必填",
                        editable:false//不可编辑
                    }
                }
            }, {
                field: 'city',
                title: "城市",
                width: 100,
                formatter: function (value, rowData, rowIndex) {
                     if(value == 1){
                     return "北京";
                     }else if(value == 2){
                     return "上海";
                     }else if(value == 3){
                     return "济南";
                     }else if(value == 4){
                     return "杭州";
                     }
                    /*var res = "";
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
                    return res;*/
                },
                editor:{
                    type:"combobox",
                    options:{
                        //data:[{id:1,val:"北京"},{id:2,val:"上海"},{id:3,val:"济南"},{id:4,val:"杭州"}],
                        url:"../UserServlet?method=getCity",
                        valueField:"id",
                        textField:"city"
                    }
                }
            }, {
                field: "startTime",
                title: "开始日期",
                width: 100,
                editor:{
                    type:"datetimebox",
                    options:{
                        required:true,
                        missingMessage:"开始时间必填",
                        editable:false//不可编辑
                    }
                }
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


</script>
</html>
