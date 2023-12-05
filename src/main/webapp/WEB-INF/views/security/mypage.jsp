<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../layouts/header.jsp"%>
<%@ include file="../security/profilemenu.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/security/mypage.css"
	type="text/css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.0.min.js"></script>


<style>
.card-text {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>


<sec:authentication property="principal.username" var="username" />

<div class="container">
	<div class="d-flex my-3">
		<form:form modelAttribute="member" enctype="multipart/form-data" 
			action="/security/mypage?_csrf=${_csrf.token}" style="width:900px"
			class="mx-auto">

			<h1 class="title">강아지 정보</h1>
			<h6 class="welcomeM">${member.memberName}(${member.loginId})님
				반갑습니다.</h6>

			<!-- Modal button-->
			<div class="CTA text-right" style="padding-right: 20px;">
				<button type="button" class="dogRegister" data-toggle="modal"
					data-target="#registerModal" onclick="openRegisterModal()">
					강아지 등록</button>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="registerModal" tabindex="-1"
				role="dialog" aria-labelledby="registerModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">

					<div class="modal-content">
						<!-- 강아지 등록 페이지 /dog/register.jsp -->
					</div>
				</div>
			</div>

			<div class="cardHolder" style="display: flex;">
				<c:forEach var="dog" items="${dogList}">
					<div class="card card-margin">
						<div class="card-dog">
							<img src="/dog/avatar/lg/${dog.dogName}" class="dog-pic" style="width:200px; height:200px;"
                            	onerror="this.src='https://static.vecteezy.com/system/resources/previews/009/664/031/non_2x/paw-icon-set-black-icon-transparent-free-png.png'"/>
							<h5>${dog.dogName}</h5>
							<div class="dog-profile">
								<ul style="list-style: none; padding-left: 10px; font-size:16px;">
									<li><i class="fa-solid fa-bone" style="color: #ffc107;"></i> 견종: ${dog.dogKind}</li>
									<li><i class="fa-solid fa-bone" style="color: #ffc107;"></i> 생일:
									 <fmt:formatDate pattern="yyyy-MM-dd" value="${dog.dogBirth}" /></li>
									<%-- <li>관심사: ${dog.dogFavorite}</li> --%>
									<li><i class="fa-solid fa-bone" style="color: #ffc107;"></i> 소개: ${dog.dogDescription}</li>

								</ul>
							</div>

							

							<!-- Modal button-->
							<div class="CTA text-right"
								style="margin: 0; padding: 0; padding-right: 10px;">
								<ul style="margin:0; padding:0">
									<li style="list-style:none; text-align:right; font-size:14px; padding-right:10px;">
										<a href="/dog/modify" class="dogModify" data-toggle="modal"
										data-target="#modifyModal" onclick="openModifyModal()">수정</a>
										<a href="/dog/remove">삭제</a>
									</li>
								</ul>
							</div>

							<!-- Modal -->
							<div class="modal fade" id="modifyModal" tabindex="-1"
								role="dialog" aria-labelledby="modifyModalLabel"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">

										<!-- Modal Body -->
										<div class="modal-body">
											<div class="modal-body" style="padding: 50px;">
												<div class="dogModify">

													<h4 style="padding-bottom: 30px; text-align: center;">
														<i class="far fa-edit"></i>강아지 정보 수정
													</h4>

													<form action="dog/modify" name="modify" method="post">
														<input type="hidden" name="id" value="${member.memberId}">
														<input type="hidden" name="id" value="${dog.dogId}">

														<div class="form-group row">
															<label class="">이름</label> 
															<input type="text" class="form-control" name="dogName"	value="${dog.dogName}">
														</div>
														<div class="form-group row">
															<label class="">견종</label> 
															<input type="text" class="form-control" name="dogKind"	value="${dog.dogKind}">
														</div>
														<div class="form-group row">
															<label>생일</label> 
															<input type="date" class="form-control" name="dogBirth" value="${dog.dogBirth}" >
														</div>
														<div class="form-group row">
															<label class="">강아지 소개</label> 
															<input type="text" class="form-control" name="dogDescription" value="${dog.dogDescription}">
														</div>
														
															<label class="">강아지 프로필 사진</label>
															<input type="file" name="avatar"/>
															
														<div style="float: right;">
															<button class="btn btn-dark" type="submit">수정</button>
															<input class="btn btn-dark" type="button" value="취소" data-dismiss="modal">
														</div>
													</form>
												</div>
											</div>
										</div>
										<!-- Modal body 끝 -->
									</div>
								</div>
							</div>
							<!-- 강아지 정보 수정 Modal 끝 -->
						</div>
					</div>
				</c:forEach>
			</div>
		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp"%>


<script>
	function openRegisterModal() {
		$('.modal-content').load("/dog/register");
	}

</script>