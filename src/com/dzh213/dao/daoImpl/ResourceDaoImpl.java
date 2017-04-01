package com.dzh213.dao.daoImpl;

import com.dzh213.base.BaseDaoImpl;
import com.dzh213.dao.ResourceDao;
import com.dzh213.dto.TreeDTO;
import com.dzh213.model.Resource;
import com.dzh213.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by donghao on 2017/3/29.
 */
public class ResourceDaoImpl extends BaseDaoImpl<Resource> implements ResourceDao {
    @Override
    public List<TreeDTO> getChildrenByParentId(String id) throws Exception {
        Connection connection = DBUtil.createConn();
        String sql = "";
        if("".equals(id)||id == null){
            sql = "select *from resource where parent_id=999999";//根节点
        }else {
            sql = "select *from resource where parent_id="+id;
        }
        PreparedStatement ps = DBUtil.getPs(connection,sql);
        ResultSet resultSet = ps.executeQuery();

        List<Resource> resources = new ArrayList<Resource>();
        while (resultSet.next()){
            Resource resource = new Resource();
            resource.setId(resultSet.getInt("id"));
            resource.setName(resultSet.getString("name"));
            resource.setIcon(resultSet.getString("icon"));
            resource.setChecked(resultSet.getInt("checked"));
            resource.setUrl(resultSet.getString("url"));
            resource.setParent_id(resultSet.getInt("parent_id"));

            resources.add(resource);
        }

        List<TreeDTO> treeDTOList = new ArrayList<TreeDTO>();
        for (Resource resource:resources){
            TreeDTO treeDTO = new TreeDTO();
            treeDTO.setId(resource.getId());
            treeDTO.setChecked(resource.getChecked());
            treeDTO.setText(resource.getName());
            treeDTO.setIconCls(resource.getIcon());
            treeDTO.setParent_id(resource.getParent_id());

            //根据id判断是否有子节点,然后设置开启或关闭
            if(getChildren(resource.getId()).size() > 0){
                treeDTO.setState("closed");
            }else {
                treeDTO.setState("open");
            }

            Map<String,Object> attributes = new HashMap();
            attributes.put("url",resource.getUrl());    //url是自定义属性map的属性,所以放到map中
            treeDTO.setAttributes(attributes);

            treeDTOList.add(treeDTO);
        }
        return treeDTOList;
    }

    //根据id判断该节点是否是叶子节点
    public List<Resource> getChildren(int id) throws SQLException {
        Connection connection = DBUtil.createConn();
        String sql = "select *from resource where parent_id = "+id;
        PreparedStatement ps = DBUtil.getPs(connection,sql);
        ResultSet resultSet = ps.executeQuery();
        List<Resource> children = new ArrayList<Resource>();

        while (resultSet.next()){
            Resource resource = new Resource();
            resource.setId(resultSet.getInt("id"));
            resource.setName(resultSet.getString("name"));
            resource.setIcon(resultSet.getString("icon"));
            resource.setChecked(resultSet.getInt("checked"));
            resource.setUrl(resultSet.getString("url"));
            resource.setParent_id(resultSet.getInt("parent_id"));

            children.add(resource);
        }
        return children;
    }
}
