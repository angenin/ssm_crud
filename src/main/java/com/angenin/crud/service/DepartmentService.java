package com.angenin.crud.service;

import com.angenin.crud.bean.Department;
import com.angenin.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
//        查出所有部门信息并返回给对应的controller
        return departmentMapper.selectByExample(null);
    }
}
