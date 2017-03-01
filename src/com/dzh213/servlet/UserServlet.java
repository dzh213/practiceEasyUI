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
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
                System.out.print("aa");
                response.setContentType("text/html;charset=utf-8");
                response.getWriter().write(JSONObject.fromObject(city).toString());
            }
        }

    }

    private void getList(HttpServletRequest request, HttpServletResponse response) {
        try {
          //  List<User> users = userDao.findAll();
            int currentPage = Integer.parseInt(request.getParameter("page"));
            int pageSize = Integer.parseInt(request.getParameter("rows"));
            List<User> users = userDao.findByPagination(currentPage,pageSize);
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
}
