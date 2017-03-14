package com.dzh213.dao.daoImpl;

import com.dzh213.base.BaseDaoImpl;
import com.dzh213.dao.ProvinceDao;
import com.dzh213.model.City;
import com.dzh213.model.Province;
import com.dzh213.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by donghao on 2017/3/13.
 */
public class ProvinceDaoImpl extends BaseDaoImpl<Province> implements ProvinceDao {

    @Override
    public List<City> findCitiesByProId(int pid) throws SQLException {
        Connection connection = DBUtil.createConn();
        String sql = "select * from city where pro_id="+pid;
        PreparedStatement ps = DBUtil.getPs(connection,sql);
        ResultSet resultSet = ps.executeQuery();
        List<City> cities = new ArrayList<City>();
        while (resultSet.next()){
            City city = new City();
            city.setId(resultSet.getInt("id"));
            city.setCity(resultSet.getString("name"));
            city.setPro_id(resultSet.getInt("pro_id"));
            cities.add(city);
        }
        return cities;
    }
}
