<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
 String sUserID = request.getParameter("sUserID")==null?"":request.getParameter("sUserID");  
 String member_id = SessionUtil.getMemberId(request);
 String logout_check = (String) request.getAttribute("logout");
 
 String company_title = SessionUtil.getProperties("mes.company");
 /* 
if (logout_check == "Logout") {
	System.out.println ("logout start");
	response.sendRedirect("https://login.vieworks.com/s/logout/?spid=sap.mes&authurl=http://10.16.0.204:8080/auth_check&backurl=http://10.16.0.204:8080/login");
} else if(!SessionUtil.isLogIn(request) && sUserID == "" ) {
	 //   response.sendRedirect("https://login.vieworks.com/s/login/?spid=sap.mes&authurl=http://10.16.0.204:8080/auth_check&backurl=http://10.16.0.204:8080/login");
} else {
	System.out.println("session start");
} 
*/
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="shortcut icon" href="/res/images/common/v_favicon.ico">
  
  <title><%=company_title%></title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="/res/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/res/admin_lte/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="/res/plugins/iCheck/square/green.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
<!--     <a href="/"><img src="/res/images/common/vieworksmes_img.png"></a> -->
  </div>
  
  <div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>
		<form>
	    <div class="form-group has-feedback">
	      <input type="input" id="member_id" name="member_id" class="form-control" placeholder="사번">
	      <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
	    </div>
	    <div class="form-group has-feedback">
	      <input type="password" id="member_pwd" name="member_pwd" class="form-control" placeholder="Password">
	      <span class="glyphicon glyphicon-lock form-control-feedback"></span>
	    </div>
	    <div class="row">
	      <div class="col-xs-8">
	        <div class="checkbox icheck">
	          <label>
	            <input type="checkbox" id="cb_userid_save" name="cb_userid_save" /> Remember Me
	          </label>
	        </div>
	      </div>
	      <div class="col-xs-4">
	        <button type="button" id="btn_login" name="btn_login" class="btn btn-success btn-block btn-flat">Sign In</button>
	      </div>
	    </div>
    </form>
  </div>
  
  <div class="modal fade" id="modal_message" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_message_title">Title</h4>
        </div>
        <div class="modal-body" id="modal_message_body">
          <p>Body</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-sm btn-warning" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  
</div>

<!-- jQuery 3.1.1 -->
<script src="/res/plugins/jQuery/jquery-3.1.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/res/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="/res/plugins/iCheck/icheck.min.js"></script>

<script src="/res/vieworks/vieworksCS.js?v=<%=System.currentTimeMillis()%>"></script>
<script>
$(function () {
	$('#cb_userid_save').iCheck({
		checkboxClass: 'icheckbox_square-green',
		radioClass: 'iradio_square-green',
		increaseArea: '20%' // optional
	});
/* 	$('input').iCheck({
		checkboxClass: 'icheckbox_square-grey',
		radioClass: 'iradio_square-grey',
		increaseArea: '20%' // optional
	}); */
	
	$("#cb_userid_save").iCheck('check');
	
	var sUserID = "<%=sUserID%>";
	$("#member_id").val(sUserID);
	if( nullToBlank(sUserID)!='' )
		fnLoginProcessAuto();
 	  
	var cookie_user_id = getLoginInfo(); 
	if(cookie_user_id != "") {
		//$("#member_email").val(cookie_user_id);
		$("#member_id").val(cookie_user_id);
// 		$("#cb_userid_save").attr("checked", true);
	}
});

//you don't need this, just used for changing background
jQuery(function($) {
	$("#member_id, #member_pwd").pressEnter(function(e) {
		e.preventDefault();
		fnLoginProcess();
	});
	
	$('#btn_login').on('click', function(e) {
		e.preventDefault();
		fnLoginProcess();
	});
});

function fnLoginProcess() {
// 	console.log('fnLoginProcess()');
	if($.trim($("#member_id").val()).length == 0) {
		fnMessageModalAlert("로그인 알림", "사번정보를 입력하세요.");
		return;
	}
	
	if($.trim($("#member_pwd").val()).length == 0) {
		fnMessageModalAlert("로그인 알림", "패스워드를 입력하세요.");
		return;
	}
	
	if($("#cb_userid_save").is(":checked")){ // 저장 체크시
		saveLoginInfo($("#member_id").val());
	} else { // 체크 해제시는 공백
		saveLoginInfo("");
	}
	
	var formURL = "/login_process";
	var postData = "member_id=" + encodeURIComponent($.trim($("#member_id").val()))
				 + "&member_pwd=" + encodeURIComponent($.trim($("#member_pwd").val()))
				 + "&use_yn=" + encodeURIComponent("Y");
	
	$.ajax({
	  	url : formURL,
	    type : "POST",
	    data : postData,
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.result == "200") {
	    		var url = "/";
	    		// vendor가 로그인 하면 구매오더 vendor확인 화면으로 이동하도록 설정
// 	    		var auth = fnChkUser($.trim($("#member_id").val()));
// 	    		if( auth=='1063' )
// 	    			url = "/frontend/location/scm/bringin_materials_confirm";
	    		//---
	    		$(location).attr('href',url);
	    	} else {
	    		fnMessageModalAlert("Notification(Login)", data.message);
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(Login)", "로그인처리에 에러가 발생했습니다.");
	    },
	    complete: function() {}
	});
}
/* 
function fnChkUser(memberId) {
// 	console.log('fnChkUser()');
	var page_url = "/frontend/scm/checkVenderMember";
	var params = "member_emp_no="+encodeURIComponent(memberId);
	var returnVal = '';
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				returnVal = data.result;
// 				var dept_cd = data.result;
// 				if( data.result=='1063') lifnr = memberId;
// 				else lifnr = '';
			}
		},
		complete: function () {}
	});
	return returnVal;
}
 */
function saveLoginInfo(id) {
	if(id != "") {
		// userid 쿠키에 id 값을 30일간 저장
		setSaveInfo("userid", id, 30);
		// setSaveInfo("lang", id, 30);
	} else {
		// userid 쿠키 삭제
		setSaveInfo("userid", id, -1);
		// setSaveInfo("lang", id, -1);
	}
}

function setSaveInfo(name, value, expiredays) {
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"
}

function getLoginInfo(){
// 	console.log('getLoginInfo()');
	var cook = document.cookie + ";";
	var idx = cook.indexOf("userid", 0);
	var val = "";
	
	if(idx != -1) {
		cook = cook.substring(idx, cook.length);
		begin = cook.indexOf("=", 0) + 1;
		end = cook.indexOf(";", begin);
		val = unescape(cook.substring(begin, end));
	} else {
		fnMessageModalAlert("Notification(Login)", "no Session info.");
	}
	return val;
}


function fnLoginProcessAuto(){
// 	console.log('fnLoginProcessAuto()');
	/* if($.trim($("#member_email").val()).length == 0) {
		fnMessageModalAlert("로그인 알림", "이메일정보를 입력하세요.");
		return;
	} */
	//alert ($("#member_id").val());
	if($.trim($("#member_id").val()).length == 0) {
		fnMessageModalAlert("Alert", "아이디정보를 입력하세요.");
		return;
	}
	
	var formURL = "/login_process_auto";
	//var postData = "member_email=" + encodeURIComponent($.trim($("#member_email").val()));
	var postData = "member_id=" + encodeURIComponent($.trim($("#member_id").val()))
				 + "&member_pwd=" + encodeURIComponent($.trim($("#member_pwd").val()))
				 + "&use_yn=" + encodeURIComponent("Y");
	
	$.ajax({
	  	url : formURL,
	    type : "POST",
	    data : postData,
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.result == "200") {
	    		var url = "/";    
	    		$(location).attr('href',url);
	    	} else {
				//로그인 에러 처리 URL 호출
				//	location.href="https://login.vieworks.com/s/error/?spid=sap.mes&authurl=http://10.16.0.204:8080/auth_check&backurl=http://10.16.0.204:8080/login&error=nouserid";
	    		fnMessageModalAlert("Notification(Login)", data.message);
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(Login)", "로그인처리에 에러가 발생했습니다.");
	    },
	    complete: function() {}
  });
}

</script>
</body>
</html>
