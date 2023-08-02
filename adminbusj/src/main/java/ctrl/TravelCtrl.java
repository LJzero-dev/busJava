package ctrl;

import java.io.*;
import java.net.URLEncoder;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@Controller
public class TravelCtrl {
	@GetMapping("/travelList")
	public String terminalAdd()  {
		return "/travel/travel_list";
	}
}
