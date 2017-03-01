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
    $(function(){
      // 自定义的校验器
      $.extend($.fn.validatebox.defaults.rules, {
        midLength: {
          //验证规则,value的长度必须在[2,5]之间
          validator: function(value, param){    //value为输入的参数,param为定义的数组midLength[2,5]
            return value.length >= param[0] && value.length <= param[1];
          },
          message: ''     //和html中的invalidMessage等价,html中的优先级大
        } ,
        equalLength : {
          validator: function(value, param){
            return value.length == param[0];
          },
          message: '密码必须为4个字符!'
        }
      });

      //数字验证组件
      $("#age").numberbox({
        min:0,
        max:100,
        required:true ,
        missingMessage:"年龄必填",
        precision:0 //允许小数点为0位
      })

      //日期验证插件
      $("#birthday").datebox({
        required:true,
        missingMessage:"生日必填",
        editable:false	//禁用手动编辑,只能通过组件点击日期
      })

      //薪水验证
      $("#salary").numberbox({
        required:true,
        missingMessage:"薪水必填",
        min:200,
        max:2000,
        precision:2
      })

      //日期验证
      $("#startTime,#endTime").datebox({
        required:true,
        missingMessage:"日期必填",
        editable:false
      })

      $("#save").click(function () {
        $.ajax({
          type:"post",
          data:$("#form1").serialize(),
          url:"/easy01/UserServlet?method=save",
          success: function (data) {
            alert("success");
            alert(data.message);
          },
          error: function () {
            alert("error");
          },
          dataType:"json"
        })
      })

    })
  </script>
</head>
<body>
<div id="mydiv" class="easyui-panel" style="width:400px;height:350px" title="用户新增">
  <form action="" method="post" id="form1">
    <table>
      <tr>
        <td>用户名:</td>
        <td><input type="text" name="username" class="easyui-validatebox" required=true validType="midLength[2,5]" missingMessage="用户名必填!" invalidMessage="用户名必须在2到5个字符之间!"  value="" /></td>
      </tr>
      <tr>
        <td>密码:</td>
        <td><input type="password" name="password" class="easyui-validatebox" required=true validType="equalLength[4]" missingMessage="密码必填!" value="" /></td>
      </tr>
      <tr>
        <td>性别:</td>
        <td>
          男<input type="radio" checked="checked" name="sex" value="1" />
          女<input type="radio" name="sex" value="2" />
        </td>
      </tr>
      <tr>
        <td>年龄:</td>
        <td><input id="age" type="text"  name="age" value="" /></td>
      </tr>
      <tr>
        <td>出生日期:</td>
        <td><input id="birthday" style="width:160px;"  type="text" name="birthday" value="" /></td>
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
          <input name="city" class="easyui-combobox" url="/easy01/UserServlet?method=getCity" valueField="id" textField="city"  value="" />
        </td>
      </tr>
      <tr>
        <td>薪水:</td>
        <td><input id="salary" type="text" name="salary" value="" /></td>
      </tr>
      <tr>
        <td>开始时间:</td>
        <td><input id="startTime" style="width:160px;"  type="text" name="startTime"  value="" /></td>
      </tr>
      <tr>
        <td>结束时间:</td>
        <td><input id="endTime" style="width:160px;"   type="text" name="endTime"  value="" /></td>
      </tr>
      <tr>
        <td>个人描述:</td>
        <td><input type="text" name="description" class="easyui-validatebox" required=true validType="midLength[5,50]" missingMessage="个人描述必填!" invalidMessage="描述必须在5到50个字符之间!"  value="" /></td>
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
</html>
