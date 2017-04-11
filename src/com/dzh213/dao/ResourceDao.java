package com.dzh213.dao;

import com.dzh213.base.BaseDao;
import com.dzh213.dto.TreeDTO;
import com.dzh213.model.Resource;

import java.util.List;

/**
 * Created by donghao on 2017/3/29.
 */
public interface ResourceDao extends BaseDao<Resource> {

    //根据父节点id获取所有子节点,子节点对象使用数据转换对象treeDto
    List<TreeDTO> getChildrenByParentId(String id) throws Exception;

    //根据父节点id获取所有的子节点
    List<Resource> getChildren(int id) throws Exception;
}
