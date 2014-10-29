var authcode_flag = false;
var name_flag = false;
var pwd_flag = false;
/*该文件用于用户登录注册模块*/
$(function(){
    /*验证码更新*/
    $("#authcodeImage").click(function () 
    {
        $(this).hide().attr( "src", "../authcode/get?times=" + Math.floor(Math.random()*100)).fadeIn();
    });

    $("#authcode_input").focusout(verifyAuthcode);
    $("#username").focusout(checkName);
    $("#password").focusout(checkPwd);
    
    /*login*/
    $("#login_btn_a").live("click",login);
});
/**
 * 验证用户名
 * @returns {Boolean}
 */
function checkName()
{
    if(null == $("#username").val() || ""== $("#username").val())
    {
        $("#username_tip").css("color","#ff0000");
        $("#username_tip").html("用户名不能为空");
        name_flag = false;
        return false;
    }
    name_flag = true;
    $("#username_tip").html("");
}
/**
 * 验证密码
 * @returns {Boolean}
 */
function checkPwd()
{
    if(null== $("#password").val()|| ""== $("#password").val())
    {
        $("#pwd_tip").css("color","#ff0000");
        $("#pwd_tip").html("密码不能为空");
        pwd_flag = false;
        return false;
    }
    pwd_flag = true;
    $("#pwd_tip").html("");
}
/**
 * 验证验证码
 * @returns {Boolean}
 */
function verifyAuthcode()
{
    if(null == $("#authcode_input").val() || "" == $("#authcode_input").val())
    {
        $("#authcode_tip").css("color","#ff0000");
        $("#authcode_tip").html("验证码不能为空");
        authcode_flag = false;
        return false;
    }
    
    $("#authcode_tip").css("color","#55bd78");
    $("#authcode_tip").html("");
    
    var code = $("#authcode_input").val();
    var json = {
        "authcode":code
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "../authcode/verify";
    var contentType = "application/json;charset=utf-8";
    
    ajaxFunc(methodType,url,data,contentType,verifyAuthcodeSuccess,null);

}
function verifyAuthcodeSuccess(data, textStatus, jqXHR)
{
    authcode_flag = data.flag;
    if(true == data.flag)
    {
        $("#authcode_tip").css("color","#55bd78");
        $("#authcode_tip").html("验证码正确");
        $("#authcodeImage").click();
    }
    else if(false == data.flag)
    {
        $("#authcode_tip").css("color","#ff0000");
        $("#authcode_tip").html("验证码错误");
        
        /*更新验证码*/
        $("#authcodeImage").click();
    }
}

/**
 * 登录
 * @returns {Boolean}
 */
function login()
{
    var name = $("#username").val();
    var pwd = $("#password").val();
    if(!(true == name_flag && true == pwd_flag && true == authcode_flag))
    {
        return false;
    }
    
    var dataJson = 
        {
            "username":name,
            "password":hex_md5(pwd)
        };
    
    var data = JSON.stringify(dataJson);
    var methodType = "POST";
    var url = "./login";
    var contentType = "application/json;charset=utf-8";
    ajaxFunc(methodType,url,data,contentType,loginSuccessCB,null);
}
/**
 * 与后台通信成功的回调函数
 * @param data
 * @param textStatus
 * @param jqXHR
 */
function loginSuccessCB(data, textStatus, jqXHR)
{
    if(true == data.flag)
    {
        $("#login_state_tip").css("color","#55bd78");
        $("#login_state_tip").html("登录成功");
        
        /*登录成功，页面返回问题*/
        var url;
        if(null != getUrlParam("backurl")&&"" != getUrlParam("backurl"))
        {
            url = getUrlParam("backurl");
            
            setTimeout(function (){
                window.location.href = ".."+url;
            },2000);
        }
        else
        {
            url = document.referrer;
            setTimeout(function ()
            {
                
                if(null == url || "" == url)
                    window.location.href = "../";/*跳到首页*/
                else
                    window.location.href = url;/*登录成功，跳转到以前的页面*/
            }, 2000);
        }
    }
    else
    {
        $("#login_state_tip").css("color","#ff0000");
        $("#login_state_tip").html("登录失败，请核对用户名或者密码");
    }
}
