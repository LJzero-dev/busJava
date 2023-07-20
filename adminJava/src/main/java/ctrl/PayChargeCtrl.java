package ctrl;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class PayChargeCtrl {
	@GetMapping("/test2")
	public String payCharge() {
		return "/popup/paymoney_charge";
	}
}