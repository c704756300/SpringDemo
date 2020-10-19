package com.spring.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spring.enity.Emp;
import com.spring.service.EmpService;
import com.spring.util.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmpController {

    @Autowired
    private EmpService emps;

    @RequestMapping("/findallemp")
    public String findAllEmp(Model model) {
        List<Emp> list = emps.findAll();
        model.addAttribute("list", list);
        return "index";
    }

//    @RequestMapping("/findById")
//    public  String findById(Integer empno,Model model){
//        if (empno!=null) {
//            List<Emp> list = emps.findById(empno);
//            model.addAttribute("emp",list.get(0));
//        }
//        return "ioru";
//    }

    /**
     * 按照员工id查询员工
     *
     * @param id
     * @return
     */
    //rest风格的url
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Emp emp = emps.findById(id);
        return Msg.success().add("emp", emp);
    }

    /**
     * @param
     * @return Message
     * @description:单个批量删除  批量删除:1-2-3
     */
    @DeleteMapping(value = "/emp/{ids}")
    @ResponseBody
    public Msg deleteEmployee(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
        String[] str_ids = ids.split("-");//分割成数组
        List<Integer> del_ids = new ArrayList<>();
            for (String id : str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            emps.deleteByIds(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            emps.deleteEmp(id);
        }
        return Msg.success();
    }


//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    public Msg deleteEmp(@PathVariable("id") Integer id) {
//        emps.deleteEmp(id);
//        return Msg.success();
//    }

    @RequestMapping("insertorupdate")
    @ResponseBody
    public Integer insertoripdate(Emp emp) {
        if (emp.getId() != null) {
            // 需要判断是否重复，返回提示信息
            emps.updateEmp(emp);
            return 0;
        } else {
            emps.addEmp(emp);
            return 1;
        }
    }

    /**
     * 员工保存
     *    遇到的问题：请求体中有数据：
     *    但是Employee对象封装不上；
     *    SQL语句变成了 update tbl_emp where emp_id = 1014;
     *    原因：
     *       Tomcat：
     *     		1.将请求体中的数据，封装成一个map
     *     		2.request.getParameter("empName")就会从这个map中取值。
     *      	3.SpringMvc封装pojo的时候会把pojo中的每个属性值，request.getParamter("email");
     *       Ajax发送PUT请求引发的血案
     *       	PUT请求：请求体中的数据，request.getParameter("empName")拿不到的根本原因就是
     *      这里ajax请求直接发put请求而不是post请求,那么所有的参数都会获取不到,因为tomcat只会封装post的数据。
     *      也就是说request.getParameter("empId")为空,springmvc也无法封装Bean
     *       	Tomcat一看是put请求，不会封装请求体中的数据为map，只有post形式的请求才封装请求体为map
     * @param emp
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Emp emp) {
        emps.updateEmp(emp);
        return Msg.success();
    }

    /**
     * 需要导入json包
     * 分页数据
     * @param pn
     * @return
     */
    @RequestMapping(value = "findemp", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpsWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Emp> emp = emps.findAll();
        //使用PageInfo查询包装后的结果，只需要把PageInfo交给页面就行
        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emp, 5);
        return Msg.success().add("pageInfo", page);
    }

    @ResponseBody
    @RequestMapping("/checkEmpno")
    public Msg check(@RequestParam("empno")String empno){
        boolean b = emps.checkEmpno(empno);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","员工编号重复！");
        }
    }
}
