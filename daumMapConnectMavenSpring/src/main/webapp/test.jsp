<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script>
$(function() {
	/* $('#btnCheck').click(function(){
		debugger;
		var birthday = $('#birthday').val();
		if (birthday == '') {
			alert('생년월일을 작성해주세요.');
			return false;
		} else if (birthday.length != 8) {
			alert('생년월일을 정확히 작성해 주세요.\n(예. 1994년 1월 1일생 -> 19940101로 작성)');
			return false;
		}
		//=== 확인 : 생년월일 형식 // 시작
		var adt = 19; // 성년 나이
		var adt_max = 100; // 100세
		var d = new Date();
		var y = d.getFullYear();
		var m = (d.getMonth() + 1);
		var d = d.getDate();
		// 날짜 포맷 맞추기
		if (m < 10)
			m = '0' + m;
		if (d < 10)
			d = '0' + d;
		var birthday_y = parseInt(birthday.substr(0, 4));
		var birthday_m = birthday.substr(4, 2);
		var birthday_d = birthday.substr(6, 2);
		var birthday_md = birthday.substr(4, 4);
		if (age < adt || (age == adt && parseInt(('1' + birthday_md)) > parseInt(('1'+ m + d)))) {
			alert('19세 미만은 이용하실 수 없습니다.');
			return false;
		}
		if (birthday_y < parseInt(y - adt_max)
				|| (parseInt(birthday_m) < 1 || parseInt(birthday_m) > 12)
				|| (parseInt(birthday_d) < 1 || parseInt(birthday_d) > 31)) {
			alert('생년월일을 확인해 주세요.');
			return false;
		}
		//=== 확인 : 생년월일 형식 // 끝
		return true;
	}); */
	
	// 19980224
	$('#btnCheck').click(function(){
		
		var today = new Date();
		var now_year = today.getFullYear();
		var now_month = today.getMonth() + 1;
		var now_day = today.getDate();
		var birth_year = $('#birthday').val().substring(0, 4);
		var birth_month = $('#birthday').val().substring(4, 6);
		var birth_day = $('#birthday').val().substring(6);
		var chekAge = 19;

		var age = now_year - birth_year;
		var man_age = age;
		if (now_month < birth_month) {
			man_age = age - 1;
		} else if (now_month == birth_month) {
			if (now_day < birth_day) {
				man_age = age - 1;
			}
		}
		if (man_age >= chekAge) {
			alert("성인");
			return;
		} else {
			alert("만 19세 이상만 가입 가능합니다.");
			return;
		}
	});
});
</script>
<body>
<input type="text" id="birthday" name="birthday" value="">
<button id="btnCheck">확인</button>
</body>
</html>