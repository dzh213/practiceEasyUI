package com.dzh213.dao;

import com.dzh213.base.BaseDao;
import com.dzh213.dto.TreeDTO;
import com.dzh213.model.Resource;

import java.util.List;

/**
 * Created by donghao on 2017/3/29.
 */
public interface ResourceDao extends BaseDao<Resource> {

    List<TreeDTO> getChildrenByParentId(String id) throws Exception;
}
