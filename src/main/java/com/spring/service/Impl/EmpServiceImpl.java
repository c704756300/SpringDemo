package com.spring.service.Impl;

import com.spring.enity.Emp;
import com.spring.mapper.EmpMapper;
import com.spring.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpMapper empMapper;

    public List<Emp> findAll() {
            return empMapper.findAll();
    }

    public Emp findById(int id) {
        return empMapper.findById(id);
    }

    public int deleteEmp(int id) {
        return empMapper.deleteEmp(id);
    }

    @Override
    public int deleteByIds(List<Integer> ids) {
        return empMapper.deleteByIds(ids);
    }

    public int updateEmp(Emp emp) {

        return empMapper.updateEmp(emp);
    }

    public int addEmp(Emp emp) {
        return empMapper.addEmp(emp);
    }

    @Override
    public boolean checkEmpno(String empno) {
        System.out.printf(empno);
        long count = empMapper.checkEmpno(empno);
        System.out.printf("d"+count);
        if (count == 0) {
            return true;
        } else
            return false;
    }
}
