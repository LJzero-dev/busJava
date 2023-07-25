package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class IndexCtrl {
	@GetMapping("/")
	public String index() {
		/* System.out.println("이왜진?"); */
		return "index";
	}
}
