import com.angenin.crud.bean.Department;
import com.angenin.crud.bean.Employee;
import com.angenin.crud.dao.DepartmentMapper;
import com.angenin.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import java.util.UUID;

/*测试DepartmentMapper
 * 推荐Spring的项目使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration(locations = {"classpath:applicationContext.xml"})   指定spring配置文件的位置
 */
// - @RunWith(SpringJUnit4ClassRunner.class)指定Test用什么单元测试来运行
// - 如果出现`ExceptionInInitializerError`错误，
//   是因为`SpringJUnit4ClassRunner`要求`JUnit 4.12`或更高，
//   在pop.xml中把junit版本调高即可。
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    //3.直接autowired要使用的组件即可
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
//        1.插入几个部门
        departmentMapper.insertSelective(new Department(null, "开发部"));
        departmentMapper.insertSelective(new Department(null, "测试部"));
        departmentMapper.insertSelective(new Department(null, "运维部"));

//        2.生成员工数据，测试员工表的插入
        employeeMapper.insertSelective(new Employee(null, "张三", "M", "zhangsan@qq.com", 1));

//        3.批量插入多个员工；使用可以批量插入操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            employeeMapper.insertSelective(new Employee(null, uid, "M", uid + "@qq.com", 1));
        }
    }
}
