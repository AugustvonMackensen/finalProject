<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR:wght@500;700&display=swap"
	rel="stylesheet">
	<script type="text/javascript" 
src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
function imgSearch(){
	
	location.href="imgSearch.do";
}

function keywordSearch(){
	var input = document.getElementById('searchKeyword').value;
	location.href="result.do?keyword=" + input;
}

function camSearch(){
	location.href="camSearch.do";
}

</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	<div>
		<div class="header__logo">
			<br> <br> <a href="./index.html"><h1
					style="font-family: 'CookieRun'; font-size: 50px; color: white; letter-spacing: 5px;">
					음식이 맛있다!<br>감미
				</h1></a><br> <br> <br>
			<div class="search-box">
				<input id="searchKeyword" name="keyword" class="search-txt"
					type="text" placeholder="음식을 입력해주세요.">
				<button type="button" class="btm_image" id="img_btn"
					onclick="camSearch();">
					<img class="btn_image2" src="resources/img/camera4.png">
				</button>
				<button type="button" class="btm_image2" id="img_btn2"
					onclick="imgSearch();">
					<img class="btn_image3" src="resources/img/picture.png">
				</button>
				<input class="search-button" type="button" value="검색"
					onclick="keywordSearch();">
			</div>
		</div>
	</div>

	<!-- Categories Section Begin -->
	<section class="categories spad">
		<div class="categories__post">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-md-8">
						<div class="sidebar__item__title">
							<h6 style="font-family: 'CookieRun'; font-size: 25px">주간 레시피
								랭킹</h6>
						</div>
						<div class="categories__post__item categories__post__item--large">
							<a href="#" target="_blank"><div
									class="categories__post__item__pic set-bg"
									style="background-image: url(resources/img/food2.jpg);">
									<div class="post__meta">
										<h4 style="color: gold;">1위</h4>
									</div>
								</div></a>
							<div class="categories__post__item__text">
								<span class="post__label">Recipe</span>
								<h3>
									<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
								</h3>
								<ul class="post__widget">
									<li>조회수 :</li>
								</ul>

							</div>
						</div>
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="categories__post__item">
									<a href="#" target="_blank"><div
											class="categories__post__item__pic small__item set-bg"
											style="background-color: gray;">
											<div class="post__meta">
												<h4 style="color: #898989;">2위</h4>
											</div>
										</div></a>
									<div class="categories__post__item__text">
										<span class="post__label">Recipe</span>
										<h3>
											<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
										</h3>
										<ul class="post__widget">
											<li>조회수 :</li>


										</ul>

									</div>
								</div>
								<div class="categories__post__item">
									<a href="#" target="_blank"><div
											class="categories__post__item__pic set-bg"
											style="background-color: gray;">
											<div class="post__meta">
												<h4>4위</h4>

											</div>
										</div></a>
									<div class="categories__post__item__text">
										<span class="post__label">Recipe</span>
										<h3>
											<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
										</h3>
										<ul class="post__widget">
											<li>조회수 :</li>

										</ul>

									</div>
								</div>

								<div class="categories__post__item">
									<a href="#" target="_blank"><div
											class="categories__post__item__pic smaller__large set-bg"
											style="background-color: gray;">
											<div class="post__meta">
												<h4>6위</h4>
											</div>
										</div></a>
									<div class="categories__post__item__text">
										<span class="post__label">Recipe</span>
										<h3>
											<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
										</h3>
										<ul class="post__widget">
											<li>조회수 :</li>


										</ul>

									</div>
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="categories__post__item">
									<a href="#" target="_blank"><div
											class="categories__post__item__pic smaller__large set-bg"
											style="background-color: gray;">
											<div class="post__meta">
												<h4 style="color: #ab7966;">3위</h4>

											</div>
										</div></a>
									<div class="categories__post__item__text">
										<span class="post__label">RECIPE</span>
										<h3>
											<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
										</h3>
										<ul class="post__widget">
											<li>조회수 :</li>


										</ul>

									</div>
								</div>
								<div class="categories__post__item__small">

									<p>Part of the secret of success in life is to eat what you
										like and let the food fight it out inside. 인생에서 성공하는 비결 중 하나는
										좋아하는 음식을 먹고 힘내 싸우는 것이다.</p>
									<div class="posted__by">Mark Twain</div>
								</div>
								<div class="categories__post__item">
									<a href="#" target="_blank"><div
											class="categories__post__item__pic smaller__large set-bg"
											style="background-color: gray;">
											<div class="post__meta">
												<h4>5위</h4>
											</div>
										</div></a>
									<div class="categories__post__item__text">
										<span class="post__label">RECIPE</span>
										<h3>
											<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
										</h3>
										<ul class="post__widget">
											<li>조회수 :</li>

										</ul>

									</div>
								</div>
								<div class="categories__post__item">
									<a href="#" target="_blank"><div
											class="categories__post__item__pic set-bg"
											style="background-color: gray;">
											<div class="post__meta">
												<h4>7위</h4>
											</div>
										</div></a>
									<div class="categories__post__item__text">
										<span class="post__label">Recipe</span>
										<h3>
											<a href="#" style="font-family: 'Noto Sans KR', sans-serif;">제목~</a>
										</h3>
										<ul class="post__widget">
											<li>조회수 :</li>

										</ul>

									</div>
								</div>
							</div>
							<div class="col-lg-12 text-center"></div>
						</div>
					</div>
					<div class="col-lg-4 col-md-4">
						<div class="sidebar__item">
							<div class="sidebar__about__item">
								<div class="sidebar__item__title">
									<h6 style="font-family: 'CookieRun'; font-size: 25px">한식뉴스</h6>
								</div>
								<img class="sidebar_about"
									src="resources/img/sidebar/sidebar-about.jpg" alt="">
								<h6>
									Hi every one! I,m <span>Lena Mollein.</span>
								</h6>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua.</p>
								<a href="#" class="primary-btn">Read more</a>
							</div>

							<div class="sidebar__feature__item">
								<div class="sidebar__item__title">
									<h6 style="font-family: 'CookieRun'; font-size: 25px">최신
										공지 게시글</h6>
								</div>

								<div class="sidebar__feature__item__list">
									<c:forEach var = "notice" items="${ n_list }" varStatus="notice_status">
									<div class="sidebar__feature__item__list__single">
										<div class="post__meta">
											<h4>0${ notice_status.count }</h4>
										</div>
										<div class="post__text">
											<h5 style="font-family: 'CookieRun'; font-size: 20px">
												<a target="_blank" href="ndetail.do?notice_num=${ notice.notice_num }">${ notice.notice_title }</a>
											</h5>
										</div>
									</div>
									</c:forEach>
								</div>
							</div>
							<div class="sidebar__feature__item">
								<div class="sidebar__item__title">
									<h6 style="font-family: 'CookieRun'; font-size: 25px">최다
										조회 게시글</h6>
								</div>

								<div class="sidebar__feature__item__list">
								<c:forEach var = "board" items="${ b_list }" varStatus="board_status">
									<div class="sidebar__feature__item__list__single">
										<div class="post__meta">
											<h4>0${ board_status.count }</h4>

										</div>
										<div class="post__text">

											<h5 style="font-family: 'CookieRun'; font-size: 20px">
												<a target="_blank" href="bdetail.do?b_no=${ board.b_no }">${ board.b_title }</a>
											</h5>
										</div>
									</div>
								</c:forEach>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 스크롤 올리는 버튼 -->
	<a href="#doz_header" class="btn_gotop" id="click"> <img
		src="resources/img/upbtn.png">
	</a>
	<script type="text/javascript">
  $(window).scroll(function(){
		if ($(this).scrollTop() > 300){
			$('.btn_gotop').show();
		} else{
			$('.btn_gotop').hide();
		}
	});
	$('.btn_gotop').click(function(){
		$('html, body').animate({scrollTop:0},400);
		return false;
	});
  </script>

	<!-- Categories Section End -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>

</html>