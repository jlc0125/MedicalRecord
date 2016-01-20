<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String contextPath=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>权限不够</title>
<style type="text/css">
    body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, fieldset, textarea, p, blockquote, th, td, img {margin:0; padding:0;}
    dl, dt, dd, ul, ol, li {list-style:none; list-style-position:outside;}
    body { background:#FFFFFF; color:#454545;font: 12px/1.5 "Microsoft Yahei";}
    a { color:#0081CC; text-decoration:none;}
    a:hover {color:#005BAC; text-decoration:underline;}
    .main { width:510px; height:300px; position:absolute; left:50%; margin-left:-255px; margin-top:100px; background:#FAFAFA; box-shadow:0 0 8px #DDDDDD;}
    .c_l { width:170px; float:left; display:inline; background:#e0c9ac url("err.png") no-repeat center 10px; color:#FFFFFF; padding:90px 20px 20px; border-radius:3px 0 0 3px; height:190px; text-align:center;}
    .c_l h1 { font:bold 80px/90px "Verdana"; }
    .c_r { width:260px; height:260px; float:left; display:inline; padding:20px; border-radius:0 3px 3px 0; background:url("url.png") no-repeat right bottom;}
    .c_r h1 { font:normal 40px/50px "Microsoft Yahei"; margin-bottom:10px;}
    .c_r h2 { font:normal 13px/20px "Microsoft Yahei"; margin-bottom:20px; color:#808080;}
    .c_r h3 { font:bold 13px/20px "Microsoft Yahei"; margin-bottom:10px;}
    .c_r ul li { font:normal 13px/24px "Microsoft Yahei";}
    .c_r ul li i { font-family:Arial; font-style:normal;margin-right:5px; font-weight:bold;}
    .c_r ul li a { margin:0 5px;}
</style>
</head>

<body>
<div class="main">
	<div class="c_l">
		<img alt="" src="<%=contextPath%>/resources/common/Images/err.png">
	</div>
    <div class="c_r">
        <h1>找不到该页</h1>
        <h2>您的权限不够，请联系管理员进行升级。</h2>
        <h3>请尝试以下操作</h3>
        <ul>
            <li><a href="<%=request.getContextPath()%>/index">返回首页</a></li>
        </ul>
    </div>
</div>
</body>
</html>