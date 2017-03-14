package com.dzh213.servlet;

import com.dzh213.dao.ProvinceDao;
import com.dzh213.dao.daoImpl.ProvinceDaoImpl;
import com.dzh213.model.City;
import com.dzh213.model.Province;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by donghao on 2017/3/13.
 */
@WebServlet(value = "/ProvinceServlet")
public class ProvinceServlet extends HttpServlet {
    private ProvinceDao provinceDao = new ProvinceDaoImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("getPro".equals(method)){
            getPro(request,response);
        }else if ("getCity".equals(method)){
            getCity(request,response);
        }
    }

    //获取所有的城市
    private void getCity(HttpServletRequest request, HttpServletResponse response) {
        String pid = request.getParameter("pid");
        try {
            List<City> cities = provinceDao.findCitiesByProId(Integer.parseInt(pid));
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().write(JSONArray.fromObject(cities).toString());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //获取所有的省份
    private void getPro(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<Province> provinceList = provinceDao.findAll();
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().write(JSONArray.fromObject(provinceList).toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
