package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class IndexCtrl {
	@GetMapping("/")
	public String index() {
		return "index";
	}
}
