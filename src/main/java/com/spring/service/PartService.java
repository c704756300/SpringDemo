package com.spring.service;

import com.spring.enity.Part;

import java.util.List;

public interface PartService {
    /**
     * 查询所有部门信息
     */
    public List<Part> findAllPart();

    /**
     * 根据Id查询
     */
    public List<Part> findById(int deptid);

    /**
     * 根据Id删除部门
     */
    public int deletePart(int deptid);

    /**
     * 修改部门信息
     */
    public int updatePart(Part part);

    /**
     * 增加部门信息
     */
    public int addPart(Part part);
}
