package svc;

import java.util.*;
import dao.*;
import vo.*;

public class ScheduleSvc {
	private ScheduleDao scheduleDao;

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}
}
