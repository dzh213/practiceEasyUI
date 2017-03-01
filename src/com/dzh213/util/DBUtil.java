package com.dzh213.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * Created by donghao on 2016/11/7.
 */
public class DBUtil {
    private static Properties properties = new Properties();
    static {
        InputStream is = null;
        is = DBUtil.class.getClassLoader().getResourceAsStream("jdbc.properties");
        try {
            properties.load(is);
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            if(is!=null){
                try {
                    is.close();
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
        }
    }

    //创建连接
    public static Connection createConn(){
        Connection conn  = null;
        try{
            Class.forName((String)properties.get("driver"));
            conn = DriverManager.getConnection((String)properties.get("url"),(String)properties.get("username"),(String)properties.get("password"));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    //编译执行
    public static PreparedStatement getPs(Connection conn,String sql){
        PreparedStatement ps = null;
        try{
            ps = conn.prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ps;
    }

    //关闭连接,ps,和ResultSet
    public static void close(Connection conn){
        if(conn != null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public static void close(PreparedStatement ps){
        if(ps != null){
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public static void close(ResultSet rs){
        if(rs != null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
