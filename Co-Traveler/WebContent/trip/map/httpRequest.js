var xhr = null;

//브라우저를 구별하여 xhr 객체를 생성하는 함수
function getRequest(){
	if(window.ActiveXObject)
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	else
		xhr = new XMLHttpRequest();
}

//사용자가 서버를 호출할 때 사용하는 함수

function sendRequest(url, param, callback, method, async){
	// ( 요청경로, 인자, 도착함수, 전송방식, 비동기식여부 )
	getRequest();
	
	// 전송방식 문자열을 받아서 소문자로 변경 후 "get"과 비교한다.
	// 만약! "get"이면 "GET"으로 변경하고, 아니면 "POST"로 변경
	method = (method.toLowerCase() == "get") ? "GET":"POST";
	
	// 요청방식에 따라 파라미터의 URL이 달라진다.
	// 예를 들면 get방식일 때는 URL이 "test.jsp?v1=java"
	// post방식일 때는 "test.jsp"
	
	param = (param == null || param == "") ? null : param;
	
	if(method == "GET" && param != null){
		url = url + "?" + param;
	}


	xhr.onreadystatechange = callback; // 서버의 응답이 도착하는 함수지정
	xhr.open(method, url, async); // 요청정보 지정
	
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	// 서버 요청 보내기
	xhr.send( (method == "POST") ? param : null);
}