package com.spring.service;

import com.spring.enity.Emp;

import java.util.List;

public interface EmpService {
    /**
     * 查询所有用户信息
     */
    public List<Emp> findAll();

    /**
     * 根据Id查询
     */
    public Emp findById(int id);

    /**
     * 根据Id删除员工信息
     */
    public int deleteEmp( int id);

    public int deleteByIds(List<Integer> ids);

    /**
     * 修改员工信息
     */
    public int updateEmp(Emp emp);

    /**
     * 增加员工信息
     */
    public int addEmp(Emp emp);

    /**
     * 检测重复
     * @param empno
     * @return
     */
    public boolean checkEmpno(String empno);
}
