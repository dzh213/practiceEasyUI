package com.dzh213.dao;

import java.util.List;
import java.util.Map;

import com.dzh213.base.BaseDao;
import com.dzh213.model.User;


public interface UserDao extends BaseDao<User> {

	List<User> findByPagination(int currentPage,int pageSize) throws Exception;

	List<User> findByPagination(int currentPage, int pageSize, Map<String, Object> m) throws Exception;

	public int getTotal() throws Exception;

	public int getTotal(Map<String, Object> m) throws Exception ;

	List<User> searchByName(String q) throws Exception;
	
}
