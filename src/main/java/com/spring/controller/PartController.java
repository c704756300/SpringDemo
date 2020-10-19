package com.spring.controller;


import com.spring.enity.Part;
import com.spring.service.PartService;
import com.spring.util.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class PartController {

    @Autowired
    private PartService partService;

    /**
     * 返回所有的部门信息
     * 返回JSON
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {

        List<Part> list = partService.findAllPart();
        return Msg.success().add("depts", list);
    }

}
