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


</head>
<body>
  <table id="mydata">

  </table>
</body>
<script>
    //---------------------------datagrid属性展示------------------------------------------------
  $(function () {
    $("#mydata").datagrid({
      idField:'id',//指示哪个字段为标识字段,必备!
      title:"datagrid展示",
      width:400,
      height:'auto',
      url:'../UserServlet?method=getList',
      striped:true,//奇偶行变色
      nowrap:true,//数据显示在一行,默认为true,如果设为false,数据达到指定宽度会换行显示
      rownumbers:true,//显示行号
      singleSelect:true,//单选模式
      remoteSort:false,//启用本地排序,默认为true,选择false,启用自定义排序
      sortName:"salary",//指定按照哪一列排序
      sortOrder:"desc",//asc从低到高排序,desc从高到低排序
      rowStyler:function(index,row){
//        console.log(index); 行的索引,从0开始
//        console.log(row);   每一行的数据对象
        if(row.age>25){
          return "background:red";//将满足条件的行更改样式
        }
      },
      pagination:true,//启用分页组件
      pageSize:5,//初始化页面条数,该数值一定是pageList中的数值
      pageList:[5,6,10,20,50],//自定义显示页面条数
      //fitColumns:true,  //自动适应宽度,防止拖拽
      frozenColumns:[[  //冻结列,也是一个二维数组,注意,不能和fitColumns同时使用
        {
          field:"id",
          title:"id",
          width:100
        }
      ]],
      columns:[[{  //注意,这是一个二维数组
        field:"username",
        title:"用户名",
        width:100
      },{
        field:"password",
        title:"密码",
        width:100
      },{
        field:"age",
        title:"年龄",
        width:100
      },{
        field:"salary",
        title:"薪水",
        width:100
      }]]
    })
  })
</script>
</html>
