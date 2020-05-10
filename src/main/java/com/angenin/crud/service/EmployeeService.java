package com.angenin.crud.service;

import com.angenin.crud.bean.Employee;
import com.angenin.crud.bean.EmployeeExample;
import com.angenin.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }


    /**
     * 员工保存方法
     * @param employee
     */
    public void saveEmp(Employee employee) {
        //因为我们的员工id是自增的，所有使用insertSelective有选择的插入，而不是insert。
        employeeMapper.insertSelective(employee);
    }

    /**
     * 查询用户名是否已存在
     * @param empName
     * @return true为可用（输入的用户名不存在）
     */
    public boolean checkUser(String empName) {

        //查询条件
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //查询数据库中emp_name和传参empName相同的记录数
        criteria.andEmpNameEqualTo(empName);

        //countByExample方法返回符合条件的记录数
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }


    /**
     * 根据id查询员工信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }


    /**
     * 根据主键有选择的更新员工信息
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }


    /**
     * 根据id删除指定员工信息
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除员工信息
     * @param ids
     */
    public void deleteBatch(List<Integer> ids) {
        //自定义条件
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //删除语句将变成：delete from xxx where emd_id in (1, 2, 4 ...)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
