package com.dzh213.servlet;

import com.dzh213.dao.UserDao;
import com.dzh213.dao.daoImpl.UserDaoImpl;
import com.dzh213.model.City;
import com.dzh213.model.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by donghao on 2016/10/31.
 */
@WebServlet(value = "/UserServlet")
public class UserServlet extends HttpServlet {

    private UserDao userDao = new UserDaoImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String method = request.getParameter("method");
        if("save".equals(method)){
            save(request,response);
        }else if("getCity".equals(method)){
            getCity(request,response);
        }else if ("getList".equals(method)){
            getList(request,response);
        }else if ("getListName".equals(method)){
            getListName(request,response);
        }else if ("update".equals(method)){
            update(request, response);
        }else if("delete".equals(method)){
            delete(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        String ids = request.getParameter("ids");
        String[] idArray = ids.split(",");
        for (int i = 0;i<idArray.length;i++){
            try {
                userDao.delete(Integer.parseInt(idArray[i]));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    private void getListName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<City> citys = new ArrayList<City>();
        citys.add(new City(1,"北京"));
        citys.add(new City(2,"上海"));
        citys.add(new City(3,"济南"));
        citys.add(new City(4,"杭州"));
        int id = Integer.parseInt(request.getParameter("id"));

        for (City city : citys) {
            if(city.getId() == id){
                response.setContentType("text/html;charset=utf-8");
                response.getWriter().write(JSONObject.fromObject(city).toString());
            }
        }

    }

    private void getList(HttpServletRequest request, HttpServletResponse response) {
        try {
          //  List<User> users = userDao.findAll();
            //分页组件异步发送page和rows参数
            int currentPage = Integer.parseInt(request.getParameter("page"));
            int pageSize = Integer.parseInt(request.getParameter("rows"));

            //条件查询
            String username = request.getParameter("username") == null?"":request.getParameter("username");
            String startTime = request.getParameter("startTime") == null?"":request.getParameter("startTime");
            String endTime = request.getParameter("endTime") == null?"":request.getParameter("endTime");
            String order = request.getParameter("order") == null?"":request.getParameter("order");
            String sort = request.getParameter("sort") == null?"":request.getParameter("sort");

            Map<String,Object> map = new HashMap<String, Object>();
            map.put("username",username);
            map.put("startTime",startTime);
            map.put("endTime",endTime);
            map.put("order",order);
            map.put("sort",sort);


            List<User> users = userDao.findByPagination(currentPage,pageSize,map);
            int total = userDao.getTotal();
            response.setContentType("text/html;charset=utf-8");
            //{"total":10,"rows":[{},{}]}
            String json = "{\"total\":"+total+",\"rows\":"+JSONArray.fromObject(users).toString()+"}";
            response.getWriter().write(json);

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private void getCity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<City> citys = new ArrayList<City>();
        citys.add(new City(1,"北京",0));
        citys.add(new City(2,"上海",0));
        citys.add(new City(3,"济南",0));

        response.setContentType("text/html;charset=utf-8");
        String res = JSONArray.fromObject(citys).toString();
        response.getWriter().write(res);
        System.out.print(res);
    }

    private void save(HttpServletRequest request, HttpServletResponse response){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String sex = request.getParameter("sex");
        String age = request.getParameter("age");
        String birthday = request.getParameter("birthday");
        String salary = request.getParameter("salary");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String description = request.getParameter("description");
        String city = request.getParameter("city");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setSex(sex);
        user.setAge(Integer.parseInt(age));
        user.setBirthday(birthday);
        user.setSalary(salary);
        user.setStartTime(startTime);
        user.setEndTime(endTime);
        user.setDescription(description);
        user.setCity(Integer.parseInt(city));

        try {
            userDao.save(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("text/htlm;charset=utf-8");
        String str = "{\"status\":\"ok\",\"message\":\"操作成功\"}";
        try {
            response.getWriter().write(str);
        } catch (IOException e) {
            response.setContentType("text/htlm;charset=utf-8");
            String str2 = "{\"status\":\"fail\",\"message\":\"操作失败\"}";
            try {
                response.getWriter().write(str2);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    /**
     * 用户修改
     * @param request
     * @param response
     */
    private void update(HttpServletRequest request, HttpServletResponse response) {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String sex = request.getParameter("sex");
            String age = request.getParameter("age");
            String birthday = request.getParameter("birthday");
            String salary = request.getParameter("salary");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String description = request.getParameter("description");
            String city = request.getParameter("city");

            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDao.findById(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setSex(sex);
            user.setAge(Integer.parseInt(age));
            user.setBirthday(birthday);
            user.setSalary(salary);
            user.setStartTime(startTime);
            user.setEndTime(endTime);
            user.setDescription(description);
            user.setCity(Integer.parseInt(city));

            userDao.update(user);

            response.setContentType("text/html;charset=utf-8");
            String str = "{\"status\":\"ok\",\"message\":\"操作成功\"}";
            response.getWriter().write(str);
        }catch (Exception e){
            e.printStackTrace();
            response.setContentType("text/htlm;charset=utf-8");
            String str2 = "{\"status\":\"fail\",\"message\":\"操作失败\"}";
            try {
                response.getWriter().write(str2);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
}
