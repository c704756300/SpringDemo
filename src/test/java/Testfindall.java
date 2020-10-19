import com.spring.enity.Emp;
import com.spring.enity.Part;
import com.spring.service.EmpService;
import com.spring.service.PartService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring.xml")
public class Testfindall {

    @Autowired
    private EmpService empService;

    @Autowired
    private PartService partService;

    @Test
    public void Testfind(){
       List<Emp> list =  empService.findAll();
       List<Part> list1 = partService.findAllPart();
        System.out.println(list);


    }
}
