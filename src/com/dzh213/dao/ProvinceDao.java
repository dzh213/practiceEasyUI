package com.dzh213.dao;

import com.dzh213.base.BaseDao;
import com.dzh213.model.City;
import com.dzh213.model.Province;

import java.util.List;

/**
 * Created by donghao on 2017/3/13.
 */
public interface ProvinceDao extends BaseDao<Province> {
    List<City> findCitiesByProId(int pid) throws Exception;
}
