package com.dzh213.servlet;

import com.dzh213.dao.ResourceDao;
import com.dzh213.dao.daoImpl.ResourceDaoImpl;
import com.dzh213.dto.TreeDTO;
import com.dzh213.model.Resource;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by donghao on 2017/3/29.
 */
@WebServlet(value = "/ResourceServlet")
public class ResourceServlet extends HttpServlet {

    private ResourceDao resourceDao = new ResourceDaoImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String method = request.getParameter("method");
        if("loadTree".equals(method)){
            loadTree(request,response);
        }else if ("changeLevel".equals(method)){
            changeLevel(request,response);
        }else if ("save".equals(method)){
            save(request, response);
        }else if ("update".equals(method)){
            update(request,response);
        }else if ("delete".equals(method)){
            delete(request,response);
        }
    }

    //删除节点
    private void delete(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            deleteNodes(id);
            response.setContentType("text/xml;charset=utf-8");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //递归删除节点
    private void deleteNodes(int id) throws Exception {
        List<Resource> resources = resourceDao.getChildren(id);
        for(Resource resource : resources){
            int resourceId = resource.getId();
            resourceDao.delete(id);
            deleteNodes(resourceId);
        }
        resourceDao.delete(id);
    }

    //更新节点
    private void update(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String url = request.getParameter("url");

            Resource resource = resourceDao.findById(id);
            resource.setName(name);
            resource.setUrl(url);

            resourceDao.update(resource);
            response.setContentType("text/xml;charset=utf-8");
            //response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("{\"status\":\"0\"}");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //新增节点
    private void save(HttpServletRequest request, HttpServletResponse response) {
        try {
            String parentId = request.getParameter("parentId");
            String name = request.getParameter("name");
            String url = request.getParameter("url");

            Resource resource = new Resource();
            resource.setParent_id(Integer.parseInt(parentId));
            resource.setName(name);
            resource.setUrl(url);

            resourceDao.save(resource);
           // String result = "{\'ok\':\'操作成功\'}";
            //response.getWriter().write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //改变 节点的位置
    private void changeLevel(HttpServletRequest request, HttpServletResponse response) {
        try {
            String targetId = request.getParameter("targetId");
            String sourceId = request.getParameter("sourceId");
            String point = request.getParameter("point");

            //得到目标对象
            Resource target = resourceDao.findById(Integer.parseInt(targetId));
            //得到操作的对象
            Resource source = resourceDao.findById(Integer.parseInt(sourceId));
            //操作的方式
            //1.如果相对方式是append,则目标对象就是操作对象的父节点,直接设置操作对象的父节点即可
            if("append".equals(point)){
                source.setParent_id(target.getId());
            }else{
                //2.如果相对方式是top,或则bottom,则操作节点相对目标节点的上方或下方(同级的).那么目标节点的父节点也是操作节点的父节点,
                //直接设置操作节点的父节点为目标节点的父节点即可.
                source.setParent_id(target.getParent_id());
            }
            resourceDao.update(source);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //从数据库加载tree所需的数据
    private void loadTree(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        try {
            List<TreeDTO> treeDTOList = resourceDao.getChildrenByParentId(id);
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().write(JSONArray.fromObject(treeDTOList).toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
