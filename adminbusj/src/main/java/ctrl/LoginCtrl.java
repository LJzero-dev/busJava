package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginCtrl {
	@GetMapping("/login")
	public String index() {
		return "/member/login";
	}
}
