package ctrl;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class PayChargeCtrl {
	@GetMapping("/test2")
	public String payCharge() {
		return "/popup/paymoney_charge";
	}
}