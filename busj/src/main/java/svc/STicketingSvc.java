package svc;

import org.springframework.transaction.annotation.Transactional;
import java.util.*;
import dao.*;
import vo.*;

public class STicketingSvc {
	private STicketingDao sTicketingDao;

	public void setSTicketingDao(STicketingDao sTicketingDao) {
		this.sTicketingDao = sTicketingDao;
	}
	
	public List<TerminalInfo> pickSpotSlow() {
		List<TerminalInfo> terminalList = sTicketingDao.pickSpotSlow();
		return terminalList;
	}

	public List<LineInfo> getArrivalLineList(int btsidx) {
		List<LineInfo> lineList = sTicketingDao.getArrivalLineList(btsidx);
		return lineList;
	}

	public int getsLineNum(String btsname, String btename) {
	// 받아온 출발지와 도착지를 이용하여 노선을 구함
		int blidx = sTicketingDao.getsLineNum(btsname, btename);
		return blidx;
	}
	
	public List<ReservationStep2> getScheduleList(int blidx, String ri_sday1) {
	// 구해온 노선에 운영되는 시간표를 ReservationStep2형 scheduleList인스턴스로 받아옴
		List<ReservationStep2> scheduleList = sTicketingDao.getScheduleList(blidx, ri_sday1);
		return scheduleList;
	}

	public List<SeatInfo> getSeatList(int bsidx, String ri_sday1) {
	// 선택한 시간에 운행하는 버스번호와 좌석정보를 불러옴 예매 테이블에서 기 예매된 좌석이 있는지 확인
		List<SeatInfo> seatList = sTicketingDao.getSeatList(bsidx, ri_sday1);
		return seatList;
	}
	
	@Transactional
	public void reservationIn(MemberInfo loginInfo, ReservationInfo ri, String seatWhere) {
	// 예매 메서드
		int totalP = (int) ((ri.getPrice() * ri.getRi_acnt()) + (ri.getPrice() * 0.8 * ri.getRi_scnt()) + (ri.getPrice() * 0.5 * ri.getRi_ccnt()));

		// 1. 예매 정보 테이블 insert
		String result = sTicketingDao.reservationIn(loginInfo, ri);
		// 인서트 성공시 성공한 ri_idx(예매번호) 리턴
		
		// 2. seatWhere 절에 맞는 좌석번호 리턴
		List<String> seatArr = sTicketingDao.getSeat(seatWhere);

		// 3. 예매 좌석 테이블 insert
		sTicketingDao.reservationSeatIn(result, seatArr);
		
		// 4. 결제방식이 페이머니인 경우에만 회원정보 테이블의 해당 회원 페이머니 잔액 업데이트 메서드 실행
		if (ri.getPayment().equals("페이머니")) {
			sTicketingDao.reservationUserUp(loginInfo, ri, totalP);
		}
		
		// 5. 회원 결제내역 테이블 insert
		sTicketingDao.reservationPayIn(result, loginInfo, ri, totalP);
		
		// 6. 예매 매출 집계 테이블 insert 
		sTicketingDao.reservationCntIn(result, ri, totalP);
		
	}
	

	
}

