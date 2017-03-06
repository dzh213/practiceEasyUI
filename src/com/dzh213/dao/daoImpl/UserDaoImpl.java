package com.dzh213.dao.daoImpl;

import com.dzh213.base.BaseDao;
import com.dzh213.base.BaseDaoImpl;
import com.dzh213.dao.UserDao;
import com.dzh213.model.User;
import com.dzh213.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by donghao on 2016/11/7.
 */
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao{
    @Override
    public List<User> findByPagination(int currentPage, int pageSize) throws Exception {
        Connection conn = DBUtil.createConn();
        //sql语句根据当前页第一条的索引和当前页的个数进行查询,索引从0开始
        String sql = "select *from user limit "+(currentPage-1)*pageSize+","+pageSize;
        PreparedStatement ps = DBUtil.getPs(conn,sql);
        ResultSet rs = ps.executeQuery();
        List<User> users = new ArrayList<User>();
        while (rs.next()){
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setAge(rs.getInt("age"));
            user.setSalary(rs.getString("salary"));
            user.setBirthday(rs.getString("birthday"));
            user.setCity(rs.getInt("city"));
            user.setSex(rs.getString("sex"));
            user.setStartTime(rs.getString("startTime"));
            user.setEndTime(rs.getString("endTime"));
            user.setDescription(rs.getString("description"));

            users.add(user);
        }
        return users;
    }

    @Override
    public List<User> findByPagination(int currentPage, int pageSize, Map<String, Object> m) throws Exception {
        return null;
    }

    @Override
    public int getTotal() throws Exception {
        Connection conn = DBUtil.createConn();
        String sql = "select count(*) from user";
        PreparedStatement ps = DBUtil.getPs(conn,sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        if(rs.next()){
            count = rs.getInt(1);
        }
        return count;
    }

    @Override
    public int getTotal(Map<String, Object> m) throws Exception {
        return 0;
    }

    @Override
    public List<User> searchByName(String q) throws Exception {
        return null;
    }
}
