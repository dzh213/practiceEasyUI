package com.dzh213.model;

/**
 * Created by donghao on 2016/11/8.
 */
public class City {
    private int id;
    private String city;
    private int pro_id;

    public City(int id, String city) {
        this.id = id;
        this.city = city;
    }

    public City(int id, String city,int pro_id) {
        this.id = id;
        this.city = city;
        this.pro_id = pro_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getPro_id() {
        return pro_id;
    }

    public void setPro_id(int pro_id) {
        this.pro_id = pro_id;
    }
}
