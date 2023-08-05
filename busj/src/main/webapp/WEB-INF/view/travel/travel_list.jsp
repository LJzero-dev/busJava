<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../_inc/head.jsp" %>
<script>
function schtype(type) {
	document.frm.type.value = type;
	document.frm.submit();
}


function openModal() {
	$('#ViewModal .modal-content').load("/busj/pickSpot");
	$('#ViewModal').modal()
}
</script>

<section class="probootstrap-cover overflow-hidden relative" style="background-image: url('assets/images/bg_1.jpg');"
    data-stellar-background-ratio="0.5" id="section-home">
    <div class="overlay"></div>
    <div class="container">
      <div class="row align-items-center text-center pb-1">
        <div class="col-md text-left">
          <h2 class="heading mb-2 display-4 font-light probootstrap-animate">어떤 곳으로</h2>
          <h2 class="heading mb-2 display-4 font-light probootstrap-animate">떠날 예정이신가요?</h2>
        </div>
      </div>
    <form name="frm">
    <input type="hidden" id="hiddenArea" name="hiddenArea" value="${param.hiddenArea }" />
      <div class="row p-5">
        <div class="col-md-6">
          <div class="col-md">
            <div class="input-group input-group-lg">
              <input type="text" class="form-control" placeholder="도착치" id="arrive" name="area" role="button" data-target="#ViewModal" data-toggle="modal" 
              onclick="openModal();" value="${param.area }" aria-describedby="emailHelp">
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="col-md">
            <input type="submit" value="조회하기" class="btn btn-primary btn-block">
          </div>
        </div>
      </div>
    </div>
    </div>
  </section>
  <!-- END section -->
  <section class="probootstrap_section pb-0">
  <input type="hidden" name="type" value="" />
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="btn-wrap">
            <button class="btn btn-primary" onclick="schtype(this.value);" value="">전체</button>
            <button class="btn btn-primary" onclick="schtype(this.value);" value="맛집">맛집</button>
            <button class="btn btn-primary" onclick="schtype(this.value);" value="명소">명소</button>
            <button class="btn btn-primary" onclick="schtype(this.value);" value="액티비티">엑티비티</button>
          </div>
        </div>
      </div>
    </div>
  </form>
  </section>
  <!-- END section -->

  <section class="probootstrap_section pt-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="card-deck">
          	<c:if test="${travelList.size() > 0 }">
				<c:forEach items="${travelList }" var="tl" varStatus="status">
		            <div class="card" style="width: 10rem;">
		              <img src="C:/lsj/spring/busjava/adminbusj/src/main/webapp/resources/images/travel/${tl.getTl_img() }" class="card-img-top" alt="...">
		              <div class="card-body">
		                <span class="badge badge-primary">${tl.getTl_ctgr() }</span>
		                <h5 class="card-title">[${tl.getTl_area() }]${tl.getTl_title() }</h5>
		                <p class="card-text">${tl.getTl_content() }</p>
		              </div>
		            </div>
	            </c:forEach>
			</c:if>

            <div class="card" style="width: 10rem;">
              <img src="assets/images/img_3.jpg" class="card-img-top" alt="...">
              <div class="card-body">
                <span class="badge badge-primary">맛집</span>
                <h5 class="card-title">[경상]태종대 유원지</h5>
                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                  card's
                  content.</p>
              </div>
            </div>

            <div class="card" style="width: 10rem;">
              <img src="assets/images/img_2.jpg" class="card-img-top" alt="...">
              <div class="card-body">
                <span class="badge badge-primary">맛집</span>
                <h5 class="card-title">[경상]태종대 유원지</h5>
                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                  card's
                  content.</p>
              </div>
            </div>

            <div class="card" style="width: 10rem;">
              <img src="assets/images/img_4.jpg" class="card-img-top" alt="...">
              <div class="card-body">
                <span class="badge badge-primary">맛집</span>
                <h5 class="card-title">[경상]태종대 유원지</h5>
                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                  card's
                  content.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- END section -->
  <!-- Modal -->
  <div class="modal fade" id="ViewModal" tabindex="-1" aria-labelledby="exampleModalLabel" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
      </div>
    </div>
  </div>
<%@ include file="../_inc/foot.jsp" %>
    
