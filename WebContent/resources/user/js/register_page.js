var name_flag = false;
var pwd_flag = false;
var email_flag = false;
var authcode_flag = false;

$(function() {
	/* 验证码更新 */
	$("#authcodeImage").click(function() 
	{
		$(this).hide().attr("src","../authcode/get?times="+ Math.floor(Math.random() * 100)).fadeIn();
	});

	$("#username").focusout(checkName);
	$("#password").focusout(checkPwd);
	$("#email").focusout(checkEmail);
	$("#authcode_input").focusout(checkAuthcode);
	
	$("#register_btn_a").live("click", register);
});
/**************************check user name**************************************/
function checkName()
{
	if(null == $("#username").val() || ""== $("#username").val())
	{
		$("#username_tip").css("color","#ff0000");
		$("#username_tip").html("用户名不能为空");
		name_flag = false;
		return false;
	}
	if($("#username").val().length>30)
	{
		$("#username_tip").css("color","#ff0000");
		$("#username_tip").html("用户名不能超过30个字符");
		name_flag = false;
		return false;
	}
	$("#username_tip").html("");
	var name = $("#username").val();
	var json = 
	{
		"username" : name
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./authuname";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, authUnameSuccessCB, null);
}
function authUnameSuccessCB(data, textStatus, jqXHR)
{
	name_flag = data.flag;
	if(true == data.flag)
	{
		$("#username_tip").css("color","#55bd78");
		$("#username_tip").html("用户名未被注册");
	}
	else
	{
		$("#username_tip").css("color","#ff0000");
		$("#username_tip").html("用户名已被注册");
	}
	
}
/************************************check password******************************************/
function checkPwd()
{
	if(null== $("#password").val()|| ""== $("#password").val())
	{
		$("#pwd_tip").css("color","#ff0000");
		$("#pwd_tip").html("密码不能为空");
		pwd_flag = false;
		return false;
	}
	else if($("#password").val().length<6)
	{
		$("#pwd_tip").css("color","#ff0000");
		$("#pwd_tip").html("密码长度至少6位");
		pwd_flag = false;
		return false;
	}
	$("#pwd_tip").css("color","#55bd78");
	$("#pwd_tip").html("密码正确");
	pwd_flag = true;
}
/***********************************check email************************************************/
function checkEmail()
{
	if(null == $("#email").val() || ""== $("#email").val())
	{
		$("#email_tip").css("color","#ff0000");
		$("#email_tip").html("邮箱不能为空");
		email_flag = false;
		return false;
	}
	var email = $("#email").val();
	var email_reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(!email_reg.test(email))
	{
		$("#email_tip").css("color","#ff0000");
		$("#email_tip").html("邮箱格式不正确");
		email_flag = false;
		return false;
	}
	$("#email_tip").html("");
	
	var json = 
	{
		"email" : email
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./authemail";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, authEmailSuccessCB, null);
}
function authEmailSuccessCB(data, textStatus, jqXHR)
{
	email_flag = data.flag;
	if(true == data.flag)
	{
		$("#email_tip").css("color","#55bd78");
		$("#email_tip").html("邮箱未被注册");
	}
	else
	{
		$("#email_tip").css("color","#ff0000");
		$("#email_tip").html("邮箱已被注册");
	}
}
/*****************************************check authcode**********************/
function checkAuthcode()
{
	if(null == $("#authcode_input").val() || "" == $("#authcode_input").val())
	{
		$("#authcode_tip").css("color","#ff0000");
		$("#authcode_tip").html("验证码不能为空");
		authcode_flag = false;
		return false;
	}
	
	$("#authcode_tip").html("");
	
	var code = $("#authcode_input").val();
	var json = {
	    "authcode":code
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "../authcode/verify";
	var contentType = "application/json;charset=utf-8";
	
	ajaxFunc(methodType,url,data,contentType,checkAuthcodeSuccessCB,null);
}
function checkAuthcodeSuccessCB(data, textStatus, jqXHR)
{
	authcode_flag = data.flag;
	if(true == data.flag)
	{
		$("#authcode_tip").css("color","#55bd78");
		$("#authcode_tip").html("验证码正确");
	}
	else if(false == data.flag)
	{
		$("#authcode_tip").css("color","#ff0000");
		$("#authcode_tip").html("验证码错误");
		
	}
	$("#authcodeImage").click();
}
/** **********************register****************************** */
function register() {
	if(!(true == name_flag && true == pwd_flag &&true ==email_flag && true == authcode_flag))
	{
		return false;
	}
	var name = $("#username").val();
	var pwd = $("#password").val();
	var email = $("#email").val();
	var json = 
	{
		"username" : name,
		"password" : hex_md5(pwd),
		"email" : email
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./register";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, registerSuccessCB, null);

}
function registerSuccessCB(data, textStatus, jqXHR) {
	if(true == data.flag)
	{
		$("#register_state_tip").css("color","#55bd78");
		$("#register_state_tip").html("注册成功,立即登录吧");
		setTimeout(function ()
		{
			window.location.href = "./loginpage";
	    }, 2000);
	}
	else
	{
		$("#register_state_tip").css("color","#ff0000");
		$("#register_state_tip").html("注册失败");
	}
}
