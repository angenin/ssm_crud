package com.angenin.crud.controller;

import com.angenin.crud.bean.Employee;
import com.angenin.crud.bean.Msg;
import com.angenin.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    /**
     * 单个多选二合一删除员工信息
     * 多个删除：id中间用-分隔，如 1-2-4
     * 单个删除：如3
     * 删除指定delete请求
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids")String ids){
        //判断是否是多个删除
        if(ids.contains("-")){
            //多个删除
            //分隔成数组
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<>();
            for (String id : str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            //批量删除
            employeeService.deleteBatch(del_ids);

        }else{
            //单个删除
            //按照id删除指定员工信息
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


    /**
     * 员工更新
     * 更新指定put请求
     *
     * 如果ajax直接发put请求，请求体中的数据，request.getgetParameter("empName")拿不到
     * tomcat发现是put请求，就不会封装数据为map，只有post形式的请求才会封装请求体为map
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee, HttpServletRequest request){
        System.out.println("email: " + request.getParameter("email"));
        System.out.println(employee);
        //更新员工信息
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 查询员工信息
     * 查询指定是get请求
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        //查询指定的员工信息
        Employee employeee = employeeService.getEmp(id);
        return Msg.success().add("emp", employeee);
    }


    /**
     * 校验用户名是否已存在
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName")String empName){
        //后端判断用户名的合法性
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        //如果匹配失败，直接返回
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16个英文和数字或2-5位中文的组合！");
        }

        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            //用户名可用
            return Msg.success();
        }else{
            //用户名不可用
            return Msg.fail().add("va_msg", "用户名已存在！");
        }
    }


    /**
     * 保存新增的员工信息
     * Rest风格的URI，我们规定post的请求为保存请求
     * @param employee  页面表单传递过来的employee对象信息
     * @param result    封装校验的结果
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody   //加上@Valid注解的参数需要校验
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        //进行校验
        if(result.hasErrors()){
            //校验失败
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                //获取错误的字段名
                System.out.println("错误的字段名：" + fieldError.getField());
                //获取错误的信息
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                //把错误信息保存到map中
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFields", map);
        }else{
            //校验成功
            employeeService.saveEmp(employee);
            System.out.println(employee);
            return Msg.success();
        }
    }


    /**
     * 查询员工数据（分页显示）
     * json和ajax
     * 导入jackson包
     * @param pn 页码
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn", defaultValue = "1")Integer pn){
        //引入PageHelper分页插件
        //查询前调用分页插件，之后的查询就是分页查询（页码和每页显示的数据数）
        //第三个参数：emp_id asc 为指定排序的规则，按emp_id正序排序（不加后面插入数据后排序可能有问题）
        PageHelper.startPage(pn, 5, "emp_id asc");
        List<Employee> emps = employeeService.getAll();

        //使用pageInfo包装查询后的结果，传入查询结果和连续显示的页数
        PageInfo page = new PageInfo(emps, 5);

        return Msg.success().add("pageInfo", page);
    }

//    /**
//     * 查询员工数据（分页显示）
//     * @param pn 页码
//     * @param model
//     * @return
//     */
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value="pn", defaultValue = "1")Integer pn, Model model){
//
//        //引入PageHelper分页插件
//        //第三个参数：emp_id asc 为指定排序的规则，按emp_id正序排序（不加后面插入数据后排序可能有问题）
//        PageHelper.startPage(pn, 5, "emp_id asc");
//        List<Employee> emps = employeeService.getAll();
//
//        //使用pageInfo包装查询后的结果，传入查询结果和连续显示的页数
//        PageInfo page = new PageInfo(emps, 5);
//        //把page传到下个页面
//        model.addAttribute("pageInfo", page);
//
////        页面跳转到WEB-INF/views下的list.jsp页面（springMVC的视图解析器）
//        return "list";
//    }
}
