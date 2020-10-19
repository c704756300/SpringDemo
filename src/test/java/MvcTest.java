import com.github.pagehelper.PageInfo;
import com.spring.enity.Emp;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:spring.xml","classpath:spring-mvc.xml"})
public class MvcTest {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/findemp").param("pn","1"))
                .andReturn();
        //请求成功以后，请求域中会有pageInfo；我们可以取出PageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码:" + pi.getPages());
        System.out.println("总记录数:" + pi.getTotal());
        System.out.println("页面需要连续显示的页码:");
        int[] nums = pi.getNavigatepageNums();
        for(int i : nums ){
            System.out.println(""+ i);
        }

        //获取员工数据
        List<Emp> list = pi.getList();
        for(Emp emp : list ){
            System.out.println("ID:" + emp.getId()+"==>Name:"+emp.getEname());
        }
    }
}
