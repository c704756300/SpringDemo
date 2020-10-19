package com.spring.service.Impl;

import com.spring.enity.Part;
import com.spring.mapper.PartMapper;
import com.spring.service.PartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class PartServiceImpl implements PartService {
    @Autowired
    private PartMapper partMapper;

    @Override
    public List<Part> findAllPart() {
        List<Part> list =partMapper.findAllPart();
        return list;
    }

    @Override
    public List<Part> findById(int deptid) {
        return partMapper.findById(deptid);
    }

    @Override
    public int deletePart(int deptid) {
        return partMapper.deletePart(deptid);
    }

    @Override
    public int updatePart(Part part) {
        return partMapper.updatePart(part);
    }

    @Override
    public int addPart(Part part) {
        return partMapper.addPart(part);
    }
}
