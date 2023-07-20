<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/head.jsp" %>
<script>
    function openModal() {
      $('#exampleModal .modal-content').load("ex_pop.html");
      $('#exampleModal').modal('show');
    }

  </script>
    

    <section class="probootstrap-cover overflow-hidden relative"  style="background-image: url('assets/images/bg_1.jpg');" data-stellar-background-ratio="0.5"  id="section-home">
      <div class="overlay"></div>
      <div class="container">
        <div class="row align-items-center justify-content-center">
          <div class="col-md-8 probootstrap-animate">
            <form action="#" class="probootstrap-form">
              <div class="form-group">
                <ul class="nav nav-pills nav-justified mb-3" id="pills-tab" role="tablist">
                  <li class="nav-item" role="presentation">
                    <button class="nav-link active w-100" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">편도</button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link w-100" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">왕복</button>
                  </li>
                </ul>

                <div class="tab-content" id="pills-tabContent">
                  <div class="row">
                    
                      <div class="col-md">
                        <div class="form-check custom">
                          <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="option1" checked>
                          <label class="form-check-label" for="exampleRadios1">고속</label>
                        </div>
                        <div class="form-check custom">
                          <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="option2">
                          <label class="form-check-label" for="exampleRadios2">시외</label>
                        </div>
                      </div>
                    </div>
                  <div class="tab-pane show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
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
                  <div class="tab-pane" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
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
      </div>
    
    </section>
    
    <!-- END section -->
    

<!--   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" onclick=";">
    Launch demo modal
  </button> -->

  <!-- Modal -->
  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      </div>
    </div>
  </div>
  <%@ include file="_inc/foot.jsp" %>
    
