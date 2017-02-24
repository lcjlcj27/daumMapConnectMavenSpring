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
// 페이지js
$(function() {
	/* 주소 검색 버튼 js*/
	$('#btnMapSearch1').click(function(e) {
		e.preventDefault();
		
		var address = $('#sample4_roadAddress').val() +" "+ $('#sample4_roadAddressDetail').val();
		daumMap.searchLatLng(address, function(resultLatLng) {
			var makerLatLng = [ {
				title : '지점',
				latlng : resultLatLng
			} ];
			// 맵 생성
			daumMap.createMap(resultLatLng, makerLatLng, 'map');
		});
	});
	
	/* 주소 검색 버튼 java*/
	$('#btnMapSearch2').click(function(e) {
		e.preventDefault();
		
		var address = $('#sample4_jibunAddress').val() +" "+ $('#sample4_jibunAddressDetail').val();
		daumMap.searchLatLngJava(address, function(resultLatLng) {
			var makerLatLng = [ {
				title : '지점',
				latlng : resultLatLng
			} ];
			// 맵 생성
			daumMap.createMap(resultLatLng, makerLatLng, 'map');
		});
	});
});
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
// 우편번호주소
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=deb64cbfb0f9b09c03d272dbfed6b7b2"></script>
<script type="text/javascript">
// 다음맵 공통
var daumMap = (function(daumMap) {
	var daumMapUrl = '//apis.daum.net/local/geo/addr2coord?apikey=deb64cbfb0f9b09c03d272dbfed6b7b2';
	// 마커 이미지의 이미지 주소
	var imageSrc = "/common/m/images/common/img_map_pin.png";
	
	/* 주소로 조회하여 좌표를 반환 js*/
	daumMap.searchLatLng = function(address, fn_callback, fn_error) {
		var convertUrl = daumMapUrl + '&q=' + encodeURI(address) + '&output=json';
		$.ajax({
			  url : convertUrl
			, dataType : 'jsonp'
			, success : function(data) {
				if (data.channel.item.length == 0) {
					alert('검색 결과가 존재하지 않습니다.');
					return;
				}
				var item = data.channel.item[0];
				var resultLatLng = new daum.maps.LatLng(item.lat, item.lng);
				// 콜백함수를 실행
				fn_callback(resultLatLng);
			}
			, error : function(xhr) {
				if(typeof fn_error == 'function') {
					fn_error(xhr);
				}else {
					alert('실패하였습니다. ' + xhr);
				}
			}
		});
	};
	
	/* 주소로 조회하여 좌표를 반환 java*/
	daumMap.searchLatLngJava = function(address, fn_callback, fn_error) {
		var data = {
			'address1' : $('#sample4_jibunAddress').val(),
			'address2' : $('#sample4_jibunAddressDetail').val(),
		};		
		$.ajax({
			  url : '/home.do'
			, type : 'POST'
			, dataType : 'json'
			, data : data
			, success : function(data) {
				debugger;
				if (data.httpResult.channel.item.length == 0) {
					alert('검색 결과가 존재하지 않습니다.');
					return;
				}
				var item = data.httpResult.channel.item[0];
				var resultLatLng = new daum.maps.LatLng(item.lat, item.lng);
				// 콜백함수를 실행
				fn_callback(resultLatLng);
			}
			, error : function(xhr) {
				debugger;
				if(typeof fn_error == 'function') {
					fn_error(xhr);
				}else {
					alert('실패하였습니다. ' + xhr);
				}
			}
		});
	};
	
	
	/* 해당 좌표의 지도를 표시 */
	daumMap.createMap = function(targetLatLng, makerLatLng, divId) {
		var mapContainer = document.getElementById(divId); // 지도를 표시할 div
		var mapOption = {
			  center: targetLatLng // 지도의 중심좌표
			, level: 3 // 지도의 확대 레벨
		};
		map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = targetLatLng; 
	
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	};
	
	return daumMap;
})(window.daumMap || {});
</script>
<body>
<input type="text" id="sample4_postcode" placeholder="우편번호">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress" name="sample4_roadAddress" placeholder="도로명주소"><input type="text" id="sample4_roadAddressDetail" name="sample4_roadAddressDetail" placeholder="도로명주소상세"><button id="btnMapSearch1">지도찾기(javascript)</button><br/>
<input type="text" id="sample4_jibunAddress" name="sample4_jibunAddress" placeholder="지번주소"><input type="text" id="sample4_jibunAddressDetail" name="sample4_jibunAddressDetail" placeholder="지번주소상세"><button id="btnMapSearch2">지도찾기(java)</button>
<span id="guide" style="color:#999"></span>


<div>
	<!-- 지도 표시 -->
	<div id="map" style="width:400px;height:350px;"></div>
</div>
</body>
</html>