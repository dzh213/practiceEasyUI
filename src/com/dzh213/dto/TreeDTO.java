package com.dzh213.dto;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by donghao on 2017/3/30.
 */
public class TreeDTO {
    private int id;
    private String text;
    private String iconCls;
    private int checked;
    private int parent_id;
    private Map<String,Object> attributes = new HashMap<String, Object>();//自定义属性
    private String state;

    public TreeDTO() {
    }

    public TreeDTO(int id, String text, String iconCls, int checked, int parent_id, Map<String, Object> attributes, String state) {
        this.id = id;
        this.text = text;
        this.iconCls = iconCls;
        this.checked = checked;
        this.parent_id = parent_id;
        this.attributes = attributes;
        this.state = state;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    public int getChecked() {
        return checked;
    }

    public void setChecked(int checked) {
        this.checked = checked;
    }

    public int getParent_id() {
        return parent_id;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }

    public Map<String, Object> getAttributes() {
        return attributes;
    }

    public void setAttributes(Map<String, Object> attributes) {
        this.attributes = attributes;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
