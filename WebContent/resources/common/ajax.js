/**
 * tool-functions for Helper Project
 */

/**
 * 将数据打印出来，便于调试，比alert()显示的信息更详细
 */
function print(data) {
	console.log(data);
}
/**
 * To ajax
 * 
 * methodType: GET | PUT | DELETE or others url: request url data:
 * 需要向后台传递的字符串，由JSON转化成字符串而来 contentType:"application/json;charset=utf-8"
 * successCallBack: 成功运行的回调函数 errorCallBack: 运行失败的回调函数
 */
/**
 * 使用示例： var json = { "name":"test" }; var data =
 * JSON.stringify(json);//把JSON转成字符串
 * 
 * var methodType = "GET"; var url = "./test"; var contentType =
 * "application/json;charset=utf-8";
 * ajaxFunc(methodType,url,data,contentType,verifyAuthcodeSuccess,verifyAuthcodeError);
 */
function ajaxFunc(methodType, url, data, contentType, successCallBack,
		errorCallBack) {
	$.ajax({
		type : methodType,
		url : url,
		data : data,
		contentType : contentType,
		dataType : "json",
		cache : "false",
		statusCode : {
			400 : function() {
				alert("非法请求");
			},
			401 : function() {
				alert("非法用户");
			},
			403 : function() {
				alert("无权限");
			},
			404 : function() {
				alert("URL访问路径错误");
			},
			409 : function() {
				alert("操作冲突，不允许");
			},
			500 : function() {
				alert("服务器错误");
			}
		}
	}).success(
			function(data, textStatus, jqXHR) {
				if (successCallBack != undefined && successCallBack != null
						&& successCallBack != "")
					successCallBack(data, textStatus, jqXHR);/* 根据自己的回调函数的参数列表，决定要返回参数的个数,data是后台返回的数据 */
			}).error(
			function(jqXHR, textStatus, errorThrown) {
				if (errorCallBack != undefined && errorCallBack != null
						&& successCallBack != "")
					errorCallBack(jqXHR, textStatus, errorThrown);
			});
}

/**
 * 输入参数名称，即可从当前页面的url中获得该参数的值
 * 如：http://localhost:8080/tcm/identification/pushinfo?keyword=%E9%BA%BB%E9%BB%84&index=3&num=10，
 * 传入getUrlParam("keyword"),可获得"%E9%BA%BB%E9%BB%84",要转成汉字"麻黄"，还需要decodeURI(%E9%BA%BB%E9%BB%84)
 * 
 * @param name
 * @returns
 */
function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg); // 匹配目标参数
	if (r != null)
		return r[2];
	return null; // 返回参数值
}

/* js获取项目根路径，如： http://localhost:8083/uimcardprj */
function getRootPath() {
	// 获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	var curWwwPath = window.document.location.href;
	// 获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:8083
	var localhostPaht = curWwwPath.substring(0, pos);
	// 获取带"/"的项目名，如：/uimcardprj
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);
	return (localhostPaht + projectName);
}

/**
 * 除去未找到图片
 * 
 * @param no_img_Url
 */
function removePicNotFound(no_img_url) {
	$("img").error(function() {
		if (null == no_img_url)
			$(this).remove(); // 1.remove the image
		else
			$(this).attr("src", no_img_url); // 2.replace the image
	});
}

/**
 * 验证URL格式是否正确
 * @param str_url
 * @returns {Boolean}
 */
function isURL(str_url) {
	var strRegex = /(https?):\/\/([^\.\/]+)([\.]?)([^\.\/]+)([\.]?)([^\.\/]+)(\/[\w-\.\/\?\%\&\=]*)?/i;
	var re = new RegExp(strRegex);
	if (re.test(str_url)) {
		return true;
	}
	return false;
	
}
