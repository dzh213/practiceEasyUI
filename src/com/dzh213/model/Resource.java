package com.dzh213.model;

/**
 * Created by donghao on 2017/3/29.
 */
public class Resource {
    private int id;
    private String name;
    private String url; //自定义属性访问的地址
    private int checked;
    private String icon;
    private int parent_id;

    public Resource() {
    }

    public Resource(int id, String name, String url, int checked, String icon, int parent_id) {
        this.id = id;
        this.name = name;
        this.url = url;
        this.checked = checked;
        this.icon = icon;
        this.parent_id = parent_id;
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getChecked() {
        return checked;
    }

    public void setChecked(int checked) {
        this.checked = checked;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public int getParent_id() {
        return parent_id;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }
}
