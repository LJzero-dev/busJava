<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>BUSJAVA</title>
		<meta name="description" content="Free Bootstrap 4 Theme by ProBootstrap.com">
		<meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">
    
    
    <link href="https://fonts.googleapis.com/css?family=Work+Sans:300,400,700" rel="stylesheet">

		<link rel="stylesheet" href="assets/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="assets/fonts/ionicons/css/ionicons.min.css">
    
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    
    <link rel="stylesheet" href="assets/fonts/flaticon/font/flaticon.css">

    <link rel="stylesheet" href="assets/fonts/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="assets/css/select2.css">
    
    <link rel="stylesheet" href="assets/css/helpers.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/common.css">


	</head>
	<body>
    <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">출/도착지 선택</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="modal-body">
        <form>
          <div class="form-row">
            <div class="col-md-6 mb-3">
              <label for="validationDefault01">출발지</label>
              <input type="text" class="form-control form-control-lg" id="validationDefault01" required readonly>
            </div>
            <div class="col-md-6 mb-3">
              <label for="validationDefault02">도착지</label>
              <input type="text" class="form-control form-control-lg" id="validationDefault02" required readonly>
            </div>
          </div>
        <div class="input-group mb-3">
          <input type="text" class="form-control " placeholder="터미널 이름을 검색하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
          <div class="input-group-append">
            <button class="btn btn-outline-success" type="button" id="button-addon2">검색</button>
          </div>
        </div>
        <hr />
        <div>
        <button type="button" class="btn-success btn-sm">동서울</button>
        <button type="button" class="btn-success btn-sm">동서울</button>
        <button type="button" class="btn-success btn-sm">동서울</button>
        <button type="button" class="btn-success btn-sm">동서울</button>

        </div>
        <hr />
        <div class="row">
          <div class="col-2">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
              <button class="nav-link active" id="v-pills-home-tab" data-toggle="pill" data-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">전체</button>
              <button class="nav-link" id="v-pills-profile-tab" data-toggle="pill" data-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">서울/경기</button>
              <button class="nav-link" id="v-pills-messages-tab" data-toggle="pill" data-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">강원</button>
              <button class="nav-link" id="v-pills-settings-tab" data-toggle="pill" data-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">경상</button>
            </div>
          </div>
          <div class="col-10">
            <div class="tab-content" id="v-pills-tabContent">
              <div class="tab-pane show active scroll-box" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                <table class="table text-center">
                  <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                  </colgroup>
                  <tbody>
                    <tr>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                    </tr>
                    <tr>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                    </tr>
                    <tr>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                    </tr>
                    <tr>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                    </tr>
                    <tr>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                      <td><a href="javascript:void(0)">Mark</a></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="tab-pane scroll-box" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">...</div>
              <div class="tab-pane scroll-box" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">...</div>
              <div class="tab-pane scroll-box" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">...</div>
            </div> 
          </div>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      <button type="button" class="btn btn-primary">확인</button>
    </div>
	</body>
</html>