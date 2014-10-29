var name_flag = false;
var email_flag = false;
var authcode_flag = false;
$(function() {
	/* 验证码更新 */
	$("#authcodeImage").click(
			function() {
				$(this).hide().attr(
						"src",
						"../authcode/get?times="
								+ Math.floor(Math.random() * 100)).fadeIn();
			});

	$("#authcodeImage_a").click(function() {
		$("#authcodeImage").click();
	});

	$("#username").focusout(function() {
		checkUsername();
	});

	$("#email").focusout(function() {
		checkEmail();
	});

	$("#authcode").focusout(function() {
		checkAuthcode();
	});
	
	$("#find_pwd").click(function(){
		findPwd();
	});

});

function checkUsername() {
	if ("" == $("#username").val()) {
		$("#username_tip").addClass("form_tip_error")
				.removeClass("form_tip_ok");
		$("#username_tip").html("用户名不能为空");
		return false;
	}
	$("#username_tip").html("");
	var name = $("#username").val();
	var json = {
		"username" : name
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./authuname";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, authUnameSuccessCB, null);
}
function authUnameSuccessCB(data, textStatus, jqXHR) {
	name_flag = !data.flag;
	if (true == name_flag) {
		$("#username_tip").addClass("form_tip_ok")
				.removeClass("form_tip_error");
		$("#username_tip").html("有效用户名");
	} else {
		$("#username_tip").addClass("form_tip_error")
				.removeClass("form_tip_ok");
		$("#username_tip").html("用户名未被注册");
	}
}

function checkEmail() {
	if ("" == $("#email").val()) {
		$("#email_tip").addClass("form_tip_error").removeClass("form_tip_ok");
		$("#email_tip").html("邮箱不能为空");
		return false;
	}
	$("#email_tip").html("");
	var email = $("#email").val();
	var email_reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(!email_reg.test(email))
	{
		$("#email_tip").addClass("form_tip_error").removeClass("form_tip_ok");
		$("#email_tip").html("邮箱格式不正确");
		email_flag = false;
		return false;
	}
	$("#email_tip").html("");
	
	var json = {
		"email" : email
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./authemail";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, authEmailSuccessCB, null);
}
function authEmailSuccessCB(data, textStatus, jqXHR) {
	email_flag = !data.flag;
	if (true == email_flag) {
		$("#email_tip").addClass("form_tip_ok").removeClass("form_tip_error");
		$("#email_tip").html("有效邮箱");
	} else {
		$("#email_tip").addClass("form_tip_error").removeClass("form_tip_ok");
		$("#email_tip").html("邮箱未被注册");
	}
}

function checkAuthcode() {
	if (null == $("#authcode").val() || "" == $("#authcode").val()) {
		$("#authcode_tip").addClass("form_tip_error")
				.removeClass("form_tip_ok");
		$("#authcode_tip").html("验证码不能为空");
		authcode_flag = false;
		return false;
	}

	$("#authcode_tip").html("");

	var json = {
		"authcode" : $("#authcode").val()
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "../authcode/verify";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, checkAuthcodeSuccessCB, null);
}
function checkAuthcodeSuccessCB(data, textStatus, jqXHR) {
	authcode_flag = data.flag;
	if (true == data.flag) {
		$("#authcode_tip").addClass("form_tip_ok")
				.removeClass("form_tip_error");
		$("#authcode_tip").html("验证码正确");
		$("#authcodeImage").click();
	} else if (false == data.flag) {
		$("#authcode_tip").addClass("form_tip_error")
				.removeClass("form_tip_ok");
		$("#authcode_tip").html("验证码错误");

		$("#authcodeImage").click();
	}
}

function findPwd() {
	if(!(true == name_flag &&true ==email_flag && true == authcode_flag))
	{
		return false;
	}
	var name = $("#username").val();
	var email = $("#email").val();
	var json = 
	{
		"username" : name,
		"email" : email
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./usermatchemail";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, findPwdSuccessCB, null);

}
function findPwdSuccessCB(data, textStatus, jqXHR) {
	if(true == data.flag)
	{
		$("#register_state_tip").addClass("form_tip_ok")
		.removeClass("form_tip_error");
		
		var mail = getMail($("#email").val());
		
		var link = "<a href='"+mail+"'>"+"邮箱"+"</a>";
		$("#register_state_tip").html("提交成功,请登录"+link+"查看新密码");
	}
	else
	{
		$("#register_state_tip").addClass("form_tip_error")
		.removeClass("form_tip_ok");
		$("#register_state_tip").html("用户名和邮箱不匹配失败");
	}
}
function getMail(mail){
	var array = mail.split("@");
	if(array[1]!="gmail.com")
		return "http://mail."+array[1];
	return "http://gmail.com";
}

