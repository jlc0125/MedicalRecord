var authcode_flag = false;
var title_flag = false;
var content_flag = false;
var url_flag = true;
/*该文件用于用户登录注册模块*/
$(function(){
    /*验证码更新*/
    $("#authcodeImage").click(function () 
    {
        $(this).hide().attr( "src", "../authcode/get?times=" + Math.floor(Math.random()*100)).fadeIn();
    });
    
    $("#changed_a").click(function(){
    	$("#trouble_url").attr("disabled",false);
    });
    
    $("#trouble_url").focusout(function(){
    	if(true!=isURL($("#trouble_url").val())){
    		url_flag = false;
    		$("#url_tip").css("color","#ff0000");
            $("#url_tip").html("网址不正确");
    		return false;
    	}
    	url_flag = true;
        $("#url_tip").html("");
    });
    
    $("#preshow_a").click(function(e){
    	preShow(e.pageX+5,e.pageY+5 );
    });

    
    $("#title").focusout(checkTitle);
    $("#content").focusout(checkContent);
    
    $("#authcode_input").focusout(verifyAuthcode);
    
    $("#submit").click(submitFeedback);

   
});

function checkTitle()
{
    if(null == $("#title").val() || ""== $("#title").val())
    {
        $("#title_tip").css("color","#ff0000");
        $("#title_tip").html("标题不能为空");
        title_flag = false;
        return false;
    }
    if($("#title").val().length>32)
    {
        $("#title_tip").css("color","#ff0000");
        $("#title_tip").html("标题长度不能超过32个字");
        title_flag = false;
        return false;
    }
    
    title_flag = true;
    $("#title_tip").html("");
}
function checkContent()
{
    if(null == $("#content").val() || ""== $("#content").val())
    {
        $("#content_tip").css("color","#ff0000");
        $("#content_tip").html("内容不能为空");
        content_flag = false;
        return false;
    }
    if($("#content").val().length>140)
    {
        $("#content_tip").css("color","#ff0000");
        $("#content_tip").html("内容长度不能超过140个字");
        content_flag = false;
        return false;
    }
    content_flag = true;
    $("#content_tip").html("");
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
function submitFeedback()
{
    var title = $("#title").val();
    var content = $("#content").val();
    var trouble_url = $("#trouble_url").val();
    if(!(true == title_flag && true == content_flag && true == authcode_flag&&true==url_flag))
    {
        return false;
    }
    
    var dataJson = 
        {
            "title":title,
            "content":content,
            "errorUrl":trouble_url
        };
    var data = JSON.stringify(dataJson);
    var methodType = "POST";
    var url = "./commitfeedback";
    var contentType = "application/json;charset=utf-8";
    ajaxFunc(methodType,url,data,contentType,submitFeedbackSuccessCB,null);
}
function submitFeedbackSuccessCB(data, textStatus, jqXHR)
{
    if(true == data.flag)
    {
        $("#fb_state_tip").css("color","#55bd78");
        $("#fb_state_tip").html("反馈成功");
        
        var url = document.referrer;
        setTimeout(function ()
        {
            if(null == url || "" == url)
                window.location.href = "../";/*跳到首页*/
            else
                window.location.href = url;/*登录成功，跳转到以前的页面*/
        }, 2000);
    }
    else
    {
    	$("#fb_state_tip").css("color","#FF0000");
        $("#fb_state_tip").html("反馈失败");
    }
   
}
/**
 * 预览页面
 */
function preShow(offset_x,offset_y){
	var x = offset_x+"px";
	var y = offset_y+"px";
	$.layer({
    	type: 2,
    	title: false,
    	fix: false,
    	closeBtn: false,
    	shadeClose: true,
    	shade: [0.1,'#fff', true],
    	border : [5, 0.3, '#666', true],
    	offset: [y,x],
    	area: ['600px','500px'],
    	iframe: {src: $("#trouble_url").val()}/*,
    	success: function(){
    		layer.msg('点击层外任意处，可关闭弹出层', 2, 9);
    	}*/
    });
}