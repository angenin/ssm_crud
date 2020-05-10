package com.angenin.crud.controller;

import com.angenin.crud.bean.Department;
import com.angenin.crud.bean.Msg;
import com.angenin.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

/**
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门的信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        //查出所有的部门信息
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }
}
