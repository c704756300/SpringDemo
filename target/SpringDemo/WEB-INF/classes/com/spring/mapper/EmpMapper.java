package com.spring.mapper;

import com.spring.enity.Emp;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmpMapper {
    /**
     * 查询所有用户信息
     */
    public List<Emp> findAll();

    /**
     * 根据Id查询
     * @return
     */
    public Emp findById(int id);

    /**
     * 根据Id删除员工信息
     */
    public int deleteEmp( int id);

    /**
     * 方法描述：根据ids集合进行删除
     * @return
     */
    int deleteByIds(List<Integer> ids);

    /**
     * 修改员工信息
     */
    public int updateEmp(Emp emp);

    /**
     * 增加员工信息
     */
    public int addEmp(Emp emp);

    public Integer checkEmpno(@Param("empno") String empno);
}
