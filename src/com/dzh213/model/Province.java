package com.dzh213.model;

/**
 * Created by donghao on 2017/3/13.
 */
public class Province {
    private int id;
    private String name;

    /**
     * 如果没有其他构造函数,无参构造函数可以不写,隐式存在
     * 如果有其他有参构造函数,无参构造函数必须显式的写出来
     */
    public Province(){
        super();
    }
    public Province(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Province{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
