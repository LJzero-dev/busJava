<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<section class="probootstrap_section">
      <div class="container">
        <div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
          <div class="col-md-12">
            <h2 class="border-bottom probootstrap-section-heading">고속버스 예매</h2>
          </div>
          <div class="col-md-12">
           
            <div class="col-md-8 m-auto">
              <div class="progress-bar-custom 1">
                <div class="progress-step  is-active">
                  <div class="step-count"></div>
                  <div class="step-description">정보 입력</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">배차 조회</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">좌석 선택</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">확인/결제</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">예매 결과</div>
                </div>
              </div>
            </div>
              
            <div class="col-md-12 m-auto">
              <div class="progress-bar-custom 2">
                <div class="progress-step is-active">
                  <div class="step-count"></div>
                  <div class="step-description">정보 입력</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">가는 날 배차 조회</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">가는 날 좌석 선택</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">오는 날 배차 조회</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">오는 날 좌석 선택</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">확인/결제</div>
                </div>
                <div class="progress-step">
                  <div class="step-count"></div>
                  <div class="step-description">예매 결과</div>
                </div>
                
              </div>
            </div>
          </div>

        </div>
        <div class="col-md-8 probootstrap-animate fadeInUp probootstrap-animated m-auto">
          <form action="#" class="probootstrap-form">
            <input type="hidden" name="mode" id="mode" value="" />
            <div class="form-group">
              <ul class="nav nav-pills nav-justified mb-3" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link w-100 active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true" aria-expanded="false">편도</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link w-100" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false" aria-expanded="true">왕복</button>
                </li>
              </ul>

              <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" aria-expanded="false">
                  <div class="row mb-3">
                    <div class="col-md">
                      <div class="form-group">
                        <label for="probootstrap-date-departure">가는날</label>
                        <div class="probootstrap-date-wrap">
                          <span class="icon ion-calendar"></span> 
                          <input type="text" id="probootstrap-date-departure" class="form-control" placeholder="">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" aria-expanded="true">
                  <div class="row mb-3">
                    <div class="col-md">
                      <div class="form-group">
                        <label for="probootstrap-date-departure">가는날</label>
                        <div class="probootstrap-date-wrap">
                          <span class="icon ion-calendar"></span> 
                          <input type="text" id="probootstrap-date-departure" class="form-control" placeholder="">
                        </div>
                      </div>
                    </div>
                    <div class="col-md">
                      <div class="form-group">
                        <label for="probootstrap-date-arrival">오는날</label>
                        <div class="probootstrap-date-wrap">
                          <span class="icon ion-calendar"></span> 
                          <input type="text" id="probootstrap-date-arrival" class="form-control" placeholder="">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              
              <div class="row mb-3">
                
                <div class="col-md">
                  <div class="form-group">
                    <label for="exampleInputEmail1">출발지</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" onclick="openModal();">
                  </div>
                </div>
                <div class="col-md">
                  <div class="form-group">
                    <label for="exampleInputEmail1">도착지</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                  </div>
                </div>
              </div>
              
              <div class="row mb-3">
                <div class="col-md">
                  <input type="submit" value="조회하기" class="btn btn-primary btn-block">
                </div>
              </div>
            </div>
          </form>
        </div>  
      </div>
    </section>
    <script>
    $(document).ready(function() {
        $(".progress-bar-custom.2").hide();
        $(".nav-item").click(function() {
          var navLink = $(this).find(".nav-link");
          var tabIndex = $(this).index();
          
          // active 상태에서 클릭시 아무런 변화없음
          if (navLink.hasClass("active")) {
            return;
          }

          navLink.toggleClass("active");
          var progressBarCustom = $(".progress-bar-custom." + (tabIndex + 1));
          if (navLink.hasClass("active")) {
            // 편도 클릭 시
            if (tabIndex === 0) {
              $("#mode").val("o");
             
              $(".progress-bar-custom.1").css("display","");
              $(".progress-bar-custom.2").css("display","none");
            }
            // 왕복 클릭 시
            else if (tabIndex === 1) {
              $("#mode").val("p");
              $(".progress-bar-custom.1").css("display","none");
              $(".progress-bar-custom.2").css("display","");
            }
          } 

          $(".nav-item").not(this).find(".nav-link").removeClass("active");
        });
      });
    </script>
<%@ include file="../_inc/foot.jsp" %>

    
