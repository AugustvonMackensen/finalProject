<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="resources/css/enroll.css" type="text/css">
<head>
<meta charset="UTF-8">
<title></title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	//아이디 중복 체크 확인을 위한 ajax 실행 처리용 함수
	//ajax(Asynchronous Javascript And Xml) : 
	//페이지를 바꾸지 않고, 서버와 통신하는 기술임 
	// (서버측에 서비스 요청하고 결과받음)
	function dupCheckId() {
		// 입력된 아이디가 중복되지 않았는지 확인 : jQuery.ajax() 사용
		//jQuery는 $ 로 줄일 수 있음
		//jQuery.ajax(); => $.ajax();
		const idchkMsg = $('#idDupCheckMsg');
		$.ajax({
			url : "idchk.do",
			type : "post",
			data : {
				m_id : $("#m_id").val()
			},
			success : function(data) {
				console.log("sucess : " + data);
				if (data == "ok") {
					idchkMsg.html("사용 가능한 아이디입니다.");
					idchkMsg.css('color', 'green');
				} else {
					idchkMsg.html("이미 가입된 회원의 아이디입니다.");
					idchkMsg.css('color', 'red');
					$("#m_id").select();
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("error : " + jqXHR + ", " + textStatus + ", "
						+ errorThrown);
			}
		});

		idMinLength = document.getElementById("m_id").value.length;
		if (idMinLength < 4) {
			idchkMsg.html("아이디는 최소 4자 이상이어야 합니다.");
			idchkMsg.css('color', 'red');
		}
	}

	function dupCheckNick() {
		// 입력된 아이디가 중복되지 않았는지 확인 : jQuery.ajax() 사용
		//jQuery는 $ 로 줄일 수 있음
		//jQuery.ajax(); => $.ajax();
		const nickNamechkMsg = $('#nicknameDupCheckMsg');
		$.ajax({
			url : "nickchk.do",
			type : "post",
			data : {
				m_nickname : $("#m_nickname").val()
			},
			success : function(data) {
				console.log("sucess : " + data);
				if (data == "ok") {
					nickNamechkMsg.html("사용 가능한 닉네임입니다.");
					nickNamechkMsg.css('color', 'green');
				} else {
					nickNamechkMsg.html("이미 가입된 회원의 닉네임입니다.");
					nickNamechkMsg.css('color', 'red');
					$("#m_nickname").select();
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("error : " + jqXHR + ", " + textStatus + ", "
						+ errorThrown);
			}
		});
	}

	//비밀번호 생성 조건 
	function chkPwd() {
		var pwd1 = document.getElementById("upwd1").value;
		var pwd2 = document.getElementById("upwd2").value;
		var passRule = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;
		const chkPwdRuleMsg = $('#pwRuleChk');

		if (passRule.test(pwd1) === false) {
			chkPwdRuleMsg
					.html("비밀번호는 8~16자의 영문 대소문자와 숫자, 특수문자를 적어도 하나는 포함해야 합니다.");
			chkPwdRuleMsg.css('color', 'red');
		} else {
			chkPwdRuleMsg.html("");
		}

	}

	// 비밀번호 일치여부 
	function validPW() {
		var pwd1 = document.getElementById("upwd1").value;
		var pwd2 = document.getElementById("upwd2").value;
		const chkpwdMsg = $('#chkPwdMessage');

		if (pwd1 !== pwd2) {
			chkpwdMsg.html("비밀번호가 일치하지 않습니다.");
			chkpwdMsg.css('color', 'red');
		} else {
			chkpwdMsg.html("비밀번호가 일치합니다.");
			chkpwdMsg.css('color', 'green');
		}
	}

	//이메일 값 변경여부 확인
	function statusMail() {
		const mailStatusMsg = $('#emailStatus');
		mailStatusMsg.html('이메일 인증을 하세요.');
		mailStatusMsg.css('color', 'blue');
	}

	function validateMail() {
		console.log("동작되었음");
		const m_email = $('#m_email').val(); //이메일 주소값 얻어오기
		console.log("이메일 : " + m_email); //오는지 확인
		const checkInput = $('.mailcheck-input'); // 인증번호 입력하는 곳
		const mailStatusMsg = $('#emailStatus');

		$.ajax({
			type : 'get',
			url : '<c:url value="/mailCheck.do?m_email="/>' + m_email, //GET 방식이므로 url 뒤에 email 붙이기 가능
			success : function(data) {
				if (data != "failure") {
					console.log("data : " + data);
					checkInput.attr('disabled', false);
					code = data;
					alert('인증번호가 전송되었습니다.');
					return false;

				} else {
					alert('가입된 회원의 이메일입니다.');
					mailStatusMsg.html('가입된 회원의 이메일입니다.');
					mailStatusMsg.css('color', 'red');
					$('#m_mail').select();
					return false;
				}
			}
		}); //end ajax
	} //end send mail

	//인증번호 비교
	//blur : focus가 벗어나는 경우 발생
	function chkCode() {
		const inputCode = document.getElementById("validnum").value;
		const resultMsg = $('#validchkMessage');
		const mailStatusMsg = $('#emailStatus');

		if (inputCode == code) {
			resultMsg.html('인증번호가 일치합니다.');
			resultMsg.css('color', 'green');
			mailStatusMsg.html('인증되었습니다.');
			mailStatusMsg.css('color', 'green');
		} else {
			resultMsg.html('인증번호가 일치하지 않습니다.');
			resultMsg.css('color', 'red');
			mailStatusMsg.html('이메일 인증이 실패하였습니다.');
			mailStatusMsg.css('color', 'red');
		}
	}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
	<form action="enroll.do" method="post" onsubmit="return validate();">
		<div class="wrap">
			<div class="login">
				<h3 align="center" style="font-family: 'Noto Sans KR', sans-serif; font-size : 40px">회원 가입 페이지</h3><br>
				<div class="textForm">
					<input class="id" type="text" name="m_id" id="m_id" oninput="dupCheckId();" placeholder="*아이디를 입력해주세요." required><br>
					 <span id="idDupCheckMsg"></span>
				</div>
				<div class="textForm">
					<input class="name" type="text" name="m_name" id="m_name" placeholder="*이름을 입력해주세요." required>
				</div>
				<div class="textForm">
					<input type="text" name="m_nickname" id="m_nickname"
						oninput="dupCheckNick();" class="id" placeholder="*닉네임을 입력해주세요."
						required> <br> <span id="nicknameDupCheckMsg"></span>
				</div>
				<div class="textForm">

					<input type="password" class="pw" name="m_pw" id="upwd1" oninput="chkPwd();"
						placeholder="*비밀번호를 입력해주세요." required> <br> <span
						id="chkPwdMessage"></span>
				</div>
				<div class="textForm">

					<input type="password" class="pw" id="upwd2" oninput="validPW();"
						placeholder="*비밀번호 확인"> <Br> <span
						id="pwRuleChk"></span>
				</div>
				<div class="textForm">
					<input type="text" class="id" name="m_birth"  placeholder="*생일을 입력해주세요." required>
				</div>
				<div class="textForm2">
					<input type="email" class="m_email" name="m_email" id="m_email"
						oninput="statusMail();" placeholder="*이메일을 입력해주세요." required>
						<div class="emailchk">
					<input type="button" class="bttn" value="인증"
						onclick="return validateMail();"> <span id="emailStatus"></span>
						</div>
				</div>
				<div class="textForm">
					<div class="mailcheck">
						<input type="text" id="validnum" name="validnum"
							class="mailcheck-input" placeholder="*인증번호" disabled="disabled"
							maxlength="6" oninput="chkCode();" required> <span
							id="validchkMessage"></span>
					</div>
				</div>
				<div>
					<input class="submit2" type="submit" value="가입하기">&nbsp;<a id="mainmove" href="main.do">시작페이지</a>

				</div>
	</form>

	<hr style="clear: both;">
</body>
</html>