package com.dzh213.base;

import com.dzh213.util.DBUtil;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by donghao on 2016/11/7.
 */
public class BaseDaoImpl<Entity> implements BaseDao<Entity> {

    private Class clazz;

    public BaseDaoImpl() {
        //this.getClass().getSuperclass();获取该类的父类
        ParameterizedType pt = (ParameterizedType) this.getClass().getGenericSuperclass();//获取带有泛型的父类
        clazz = (Class) pt.getActualTypeArguments()[0];//获取参数化类型的数组,泛型可能有多个

    }

    @Override
    public void save(Entity obj) throws Exception {
        Connection conn = DBUtil.createConn();
        String sql = "insert into "+clazz.getSimpleName()+" values(null";//id都是自增的,设为null,注意空格
        //获取本类声明的变量
        Field[] fs = clazz.getDeclaredFields();
        for (int i = 1;i<fs.length;i++){    //因为没有id变量,所以id从1开始
            sql +=",?";
        }
        sql = sql+ ");";
        System.out.print(sql);

        //进行预编译
        PreparedStatement ps = DBUtil.getPs(conn,sql);

        //ps.setString(1,user.getName());   从对象的方法中获取参数塞到sql语句中
        for (int i = 1;i<fs.length;i++){
            //拼接对象方法的名称
            //变量名第一个字母大写,然后截取剩下的字母
            String methodName = "get"+Character.toUpperCase(fs[i].getName().charAt(0))+fs[i].getName().substring(1);
            Method method = clazz.getMethod(methodName);//通过反射的方式获取对象的方法
            ps.setObject(i,method.invoke(obj)); //根据问号的所以,填充相应的参数.
        }

        ps.executeUpdate();
        DBUtil.close(ps);
        DBUtil.close(conn);

    }

    @Override
    public void update(Entity obj) throws Exception {
        Connection connection = DBUtil.createConn();
        String sql = "update "+clazz.getSimpleName()+" set ";
        Field[] fields = clazz.getDeclaredFields();
        //获取字段从索引1开始,因为0号位是id,不需要更新
        for (int i = 1; i < fields.length; i++) {
            sql += fields[i].getName()+"=?,";
        }
        //截取最后一个逗号
        sql = sql.substring(0,sql.length()-1)+" where id=?";
        PreparedStatement ps = DBUtil.getPs(connection,sql);
        //这里i也是从1开始
        for (int i = 1; i < fields.length; i++) {
            String methodName = "get"+Character.toUpperCase(fields[i].getName().charAt(0))+fields[i].getName().substring(1);
            Method method = clazz.getMethod(methodName);
            ps.setObject(i,method.invoke(obj)); //根据索引位填充?
        }
        Method method2 = clazz.getMethod("getId");
        ps.setInt(fields.length,(Integer)method2.invoke(obj));//id是int类型的,别忘了强制转换,并且使用setInt方法

        ps.executeUpdate(); //执行更新
        DBUtil.close(ps);
        DBUtil.close(connection);
    }

    @Override
    public void delete(int id) throws Exception {
        Connection connection = DBUtil.createConn();
        String sql = "delete from "+clazz.getSimpleName()+" where id="+id;
        PreparedStatement ps = DBUtil.getPs(connection,sql);
        ps.executeUpdate(sql);//注意这里和update方法的区别
        DBUtil.close(ps);
        DBUtil.close(connection);
    }

    @Override
    public List<Entity> findAll() throws Exception {
        Connection connection = DBUtil.createConn();
        String sql = "select * from "+clazz.getSimpleName();
        PreparedStatement ps = DBUtil.getPs(connection,sql);

        List<Entity> list = new ArrayList<Entity>();
        ResultSet rs = ps.executeQuery();
        while (rs.next()){
            Entity entity = (Entity) clazz.newInstance();
            Field [] fields = clazz.getDeclaredFields();
            for (int i=0;i<fields.length;i++){
                //获取set的方法名
                String methodName = "set"+Character.toUpperCase(fields[i].getName().charAt(0))+fields[i].getName().substring(1);

                //getMethod第一个参数是方法名，第二个参数是该方法的参数类型，
                //因为存在同方法名不同参数这种情况，所以只有同时指定方法名和参数类型才能唯一确定一个方法
                Method method = clazz.getMethod(methodName,fields[i].getType());

                //第一个参数是具体调用该方法的对象
                //第二个参数是执行该方法的具体参数
               //re.getObject 获取此 ResultSet 对象的当前行中指定列的值。
                method.invoke(entity,rs.getObject(fields[i].getName()));
            }
            list.add(entity);
        }
        DBUtil.close(rs);
        DBUtil.close(ps);
        DBUtil.close(connection);
        return list;
    }

    @Override
    public Entity findById(int id) throws Exception {
        Connection connection = DBUtil.createConn();
        String sql = "select * from "+clazz.getSimpleName()+" where id="+id;
        PreparedStatement ps = DBUtil.getPs(connection,sql);
        ResultSet rs = ps.executeQuery();
        Entity entity = (Entity) clazz.newInstance();
        if(rs.next()){
            Field[] field = clazz.getDeclaredFields();
            for (int i = 0; i < field.length ; i++) {
                String methodName = "set"+Character.toUpperCase(field[i].getName().charAt(0))+field[i].getName().substring(1);
                Method method = clazz.getDeclaredMethod(methodName,field[i].getType());
                method.invoke(entity,rs.getObject(field[i].getName()));
            }
        }
        DBUtil.close(rs);
        DBUtil.close(ps);
        DBUtil.close(connection);
        return entity;
    }
}

