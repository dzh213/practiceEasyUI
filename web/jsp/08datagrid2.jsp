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
  $(function () {
    $("#mydata").datagrid({
      idField:'id',//指示哪个字段为标识字段,必备!
      title:"datagrid展示",
      width:1000,
      height:'auto',
      url:'../UserServlet?method=getList',
      striped:true,//奇偶行变色
      nowrap:true,//数据显示在一行,默认为true,如果设为false,数据达到指定宽度会换行显示
      rownumbers:true,//显示行号
      //singleSelect:true,//单选模式
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
      fitColumns:true,  //自动适应宽度,防止拖拽

      columns:[[{
          //注意,checkbox列,datagrid的属性singleSelect:true,被设置为单选,会影响复选
          field:"checkbox", //此列是复选框,field可以随意写
          width:50,
          checkbox:true //将此列设置checkbox属性,此列为复选框列
      },{  //注意,这是一个二维数组
        field:"username",
        title:"用户名",
        width:100,
          align:"center",  //指示如何对齐该列的数据，可以用 'left'、'right'、'center'
          styler:function(value,rowData,rowIndex){ //设置单元格的样式
              if(value == "admin"){
                  return "background:blue";
              }
          }
      },{
        field:"password",
        title:"密码",
        width:100
      },{
        field:"age",
        title:"年龄",
        width:100,
          sortable:true //允许该列被排序,列字段处有三角号标识,逻辑需要自己写
      },{
        field:"salary",
        title:"薪水",
        width:100
      },{
          field:"sex",
          title:"性别",
          width:100,
          formatter:function(value,rowData,rowIndex){
              /*
               value：字段的值。 如:当前的1,2
               rowData：行的记录数据。 后台返回这条记录的json数据
               rowIndex：行的索引。
               */
                if(value == 1){
                    return "男";
                }else if(value ==2){
                    return "女";
                }
          }
      },{
          field:"birthday",
          title:"生日",
          width:100
      },{
          field:'city',
          title:"城市",
          width:100,
          formatter: function (value,rowData,rowIndex) {
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
                  url:'../UserServlet?method=getListName',
                  type:"post",
                  dataType:"json",
                  data:{
                      "id":value
                  },
                  async:false,//一定要将这个ajax设置成同步请求,因为有返回值
                  success: function (result) {
                      res = result.city;
                  },
                  error: function () {
                      alert("error");
                  }
              })
              return res;
          }
      },{
          field:"startTime",
          title:"开始日期",
          width:100
      },{
          field:"description",
          title:"个人描述",
          width:100,
          formatter:function(value,rowData,rowIndex){   //数据太长无法完全显示,光标移动上方显示title
              return "<span title="+value+">"+value+"</span>"
          }
      }]]
    })
  })
</script>
</html>
