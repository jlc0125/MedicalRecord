<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String contextPath=request.getContextPath();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>医案系统</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/nav_header.css">
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/footer.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/treatment_mode.css">
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	
	<!-- js -->
	<script type="text/javascript" src="resources/common/jquery_1_8_3.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery-ui.min.js"></script>
	
	<script type="text/javascript">
		function altRows(id){
			if(document.getElementsByTagName){  
				
				var table = document.getElementById(id);  
				var rows = table.getElementsByTagName("tr"); 
				 
				for(i = 0; i < rows.length; i++){          
					if(i % 2 == 0){
						rows[i].className = "evenrowcolor";
					}else{
						rows[i].className = "oddrowcolor";
					}      
				}
			}
		}
	
		window.onload=function(){
			altRows('alternatecolor');
		}
		
		$('.med').live('click', function() {
			var id = $(this).attr("id");
			if(id==0){
				window.open("http://zcy.ckcest.cn/tcm/search/frontsearch?keyword="+$(this).text()+"&range=100000&pageno=1&type=med#sub_nav");
			}else{
				window.open("http://zcy.ckcest.cn/tcm/search/med?medname="+$(this).text()+"&medid="+id);
			}
		});
		
		$('.btn').live('click', function() {
			var zhifa = $(this).parent().parent().children(".title").text();
			window.open("/MedicalRecord/browse/result?wd="+zhifa+"&type=therapylabel");
		});

	</script>

</head>
<body>
	<div class=top>
		<%@include file="/WEB-INF/jsp/common/header.jsp"%>
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo">
					<a href="index.html" target=_blank><img src="resources/recipe/image/logo.png"></a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="imgFrame">
		<a href="treatmentmode"><img src="resources/recipe/image/r_127.png" /></a>
	</div>

  	<div id="main-content">
       <table class="altrowstable" id="alternatecolor">
		<tr>
			<td class="title">消导化积</td>
			<td class="con">
			  <a href="#" id="380" class="med">柴胡</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="0" class="med">陈皮</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="5833" class="med">砂仁</a>
			  <a href="#" id="6854" class="med">枳壳</a>
			  <a href="#" id="271" class="med">党参</a>
			  <a href="#" id="1543" class="med">木香</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">痈疡剂</td>
			<td class="con">
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="0" class="med">黄芪</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="1475" class="med">黄柏</a>
			  <a href="#" id="4994" class="med">附子</a>
			  <a href="#" id="0" class="med">陈皮</a>
			  <a href="#" id="271" class="med">党参</a>
			  <a href="#" id="2124" class="med">酱</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">清热</td>
			<td class="con">
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="0" class="med">生地</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="0" class="med">丹皮</a>
			  <a href="#" id="868" class="med">黄芩</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="1437" class="med">黄连</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
		<td class="title">理血</td>
			<td class="con">
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="0" class="med">黄芪</a>
			  <a href="#" id="1182" class="med">川芎</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="607" class="med">赤芍</a>
			  <a href="#" id="337" class="med">丹参</a>
			  <a href="#" id="672" class="med">牛膝</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
		<td class="title">泻下</td>
			<td class="con">
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="672" class="med">牛膝</a>
			  <a href="#" id="0" class="med">麻仁</a>
			  <a href="#" id="1249" class="med">桑寄生</a>
			  <a href="#" id="337" class="med">丹参</a>
			  <a href="#" id="271" class="med">党参</a>
			  <a href="#" id="3028" class="med">杜仲</a>
			  <a href="#" id="1157" class="med">厚朴</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="0" class="med">熟地</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
		<td class="title">解表</td>
			<td class="con">
			  <a href="#" id="311" class="med">杏仁</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="0" class="med">贝母</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="7338" class="med">橘</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="752" class="med">沙参</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="6432" class="med">枇杷</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">治燥</td>
			<td class="con">
			  <a href="#" id="5175" class="med">连翘</a>
			  <a href="#" id="7072" class="med">桑叶</a>
			  <a href="#" id="3403" class="med">薄荷</a>
			  <a href="#" id="0" class="med">生地</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="4466" class="med">石膏</a>
			  <a href="#" id="0" class="med">银花</a>
			  <a href="#" id="911" class="med">知母</a>
			  <a href="#" id="311" class="med">杏仁</a>
			  <a href="#" id="0" class="med">麦冬</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">温里</td>
			<td class="con">
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="4994" class="med">附子</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="4919" class="med">干姜</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="6880" class="med">桂枝</a>
			  <a href="#" id="4870" class="med">生姜</a>
			  <a href="#" id="4463" class="med">人参</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">祛痰</td>
			<td class="con">
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="3589" class="med">竹茹</a>
			  <a href="#" id="7338" class="med">橘</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="1944" class="med">藜</a>
			  <a href="#" id="0" class="med">陈皮</a>
			  <a href="#" id="1469" class="med">郁金</a>
			  <a href="#" id="0" class="med">瓜蒌</a>
			  <a href="#" id="5630" class="med">茯神</a>
			  <a href="#" id="0" class="med">姜</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">祛湿</td>
			<td class="con">
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="6880" class="med">桂枝</a>
			  <a href="#" id="1528" class="med">泽泻</a>
			  <a href="#" id="380" class="med">柴胡</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="0" class="med">陈皮</a>
			  <a href="#" id="0" class="med">茵陈</a>
			  <a href="#" id="868" class="med">黄芩</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">补益</td>
			<td class="con">
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="0" class="med">黄芪</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="271" class="med">党参</a>
			  <a href="#" id="0" class="med">熟地</a>
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="300" class="med">山药</a>
			  <a href="#" id="0" class="med">姜</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">和解</td>
			<td class="con">
			  <a href="#" id="380" class="med">柴胡</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="1437" class="med">黄连</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="1543" class="med">木香</a>
			  <a href="#" id="868" class="med">黄芩</a>
			  <a href="#" id="309" class="med">白术</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">治风</td>
			<td class="con">
			  <a href="#" id="2926" class="med">钩藤</a>
			  <a href="#" id="0" class="med">菖蒲</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="1627" class="med">菊花</a>
			  <a href="#" id="2099" class="med">酒</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="0" class="med">生地</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="5175" class="med">连翘</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">开窍</td>
			<td class="con">
			  <a href="#" id="5175" class="med">连翘</a>
			  <a href="#" id="0" class="med">生地</a>
			  <a href="#" id="4466" class="med">石膏</a>
			  <a href="#" id="911" class="med">知母</a>
			  <a href="#" id="3589" class="med">竹茹</a>
			  <a href="#" id="0" class="med">山栀</a>
			  <a href="#" id="4411" class="med">芦根</a>
			  <a href="#" id="0" class="med">银花</a>
			  <a href="#" id="1332" class="med">石斛</a>
			  <a href="#" id="0" class="med">花粉</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">理气</td>
			<td class="con">
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="6880" class="med">桂枝</a>
			  <a href="#" id="0" class="med">炙甘草</a>
			  <a href="#" id="1543" class="med">木香</a>
			  <a href="#" id="1182" class="med">川芎</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">固涩</td>
			<td class="con">
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="0" class="med">黄芪</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="271" class="med">党参</a>
			  <a href="#" id="300" class="med">山药</a>
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="0" class="med">生地</a>
			  <a href="#" id="3028" class="med">杜仲</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">驱虫</td>
			<td class="con">
			  <a href="#" id="309" class="med">白术</a>
			  <a href="#" id="3210" class="med">茯苓</a>
			  <a href="#" id="271" class="med">党参</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="1528" class="med">泽泻</a>
			  <a href="#" id="0" class="med">黄芪</a>
			  <a href="#" id="0" class="med">陈皮</a>
			  <a href="#" id="6787" class="med">大腹皮</a>
			  <a href="#" id="0" class="med">腹皮</a>
			  <a href="#" id="0" class="med">姜</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">涌吐</td>
			<td class="con">
			  <a href="#" id="4309" class="med">香附</a>
			  <a href="#" id="0" class="med">盐</a>
			  <a href="#" id="0" class="med">金铃子</a>
			  <a href="#" id="0" class="med">陈皮</a>
			  <a href="#" id="4123" class="med">青蒿</a>
			  <a href="#" id="0" class="med">元参</a>
			  <a href="#" id="2597" class="med">蚕沙</a>
			  <a href="#" id="0" class="med">姜</a>
			  <a href="#" id="1543" class="med">木香</a>
			  <a href="#" id="0" class="med">生薏仁</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">安神</td>
			<td class="con">
			  <a href="#" id="0" class="med">生地</a>
			  <a href="#" id="1874" class="med">远志</a>
			  <a href="#" id="5630" class="med">茯神</a>
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="337" class="med">丹参</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="0" class="med">地黄</a>
			  <a href="#" id="24" class="med">牡蛎</a>
			  <a href="#" id="1469" class="med">郁金</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">祛暑</td>
			<td class="con">
			  <a href="#" id="24" class="med">牡蛎</a>
			  <a href="#" id="1332" class="med">石斛</a>
			  <a href="#" id="2362" class="med">玉</a>
			  <a href="#" id="1452" class="med">川贝母</a>
			  <a href="#" id="0" class="med">归身</a>
			  <a href="#" id="672" class="med">牛膝</a>
			  <a href="#" id="3592" class="med">阿胶</a>
			  <a href="#" id="5857" class="med">大麦</a>
			  <a href="#" id="0" class="med">丹皮</a>
			  <a href="#" id="1643" class="med">沉香</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">表里双解</td>
			<td class="con">
			  <a href="#" id="380" class="med">柴胡</a>
			  <a href="#" id="868" class="med">黄芩</a>
			  <a href="#" id="2965" class="med">甘草</a>
			  <a href="#" id="2904" class="med">半夏</a>
			  <a href="#" id="4870" class="med">生姜</a>
			  <a href="#" id="1482" class="med">藿香</a>
			  <a href="#" id="6880" class="med">桂枝</a>
			  <a href="#" id="1525" class="med">青皮</a>
			  <a href="#" id="0" class="med">炙甘草</a>
			  <a href="#" id="1581" class="med">草果</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">经产剂</td>
			<td class="con">
			  <a href="#" id="433" class="med">当归</a>
			  <a href="#" id="4309" class="med">香附</a>
			  <a href="#" id="3707" class="med">白芍</a>
			  <a href="#" id="1182" class="med">川芎</a>
			  <a href="#" id="2846" class="med">菟丝子</a>
			  <a href="#" id="607" class="med">赤芍</a>
			  <a href="#" id="2357" class="med">母草</a>
			  <a href="#" id="2731" class="med">菟丝</a>
			  <a href="#" id="2038" class="med">益母草</a>
			  <a href="#" id="380" class="med">柴胡</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">疏肝解郁</td>
			<td class="con">
			  <a href="#" id="7305" class="med">桑枝</a>
			  <a href="#" id="463" class="med">秦艽</a>
			  <a href="#" id="0" class="med">防己</a>
			  <a href="#" id="672" class="med">牛膝</a>
			  <a href="#" id="466" class="med">独活</a>
			  <a href="#" id="2099" class="med">酒</a>
			  <a href="#" id="665" class="med">海桐皮</a>
			  <a href="#" id="501" class="med">威灵仙</a>
			  <a href="#" id="1042" class="med">鸡血</a>
			  <a href="#" id="2916" class="med">五加皮</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		<tr>
			<td class="title">耳鼻咽喉病方</td>
			<td class="con">
			  <a href="#" id="672" class="med">牛膝</a>
			  <a href="#" id="1475" class="med">黄柏</a>
			  <a href="#" id="3939" class="med">防风</a>
			  <a href="#" id="1249" class="med">桑寄生</a>
			  <a href="#" id="463" class="med">秦艽</a>
			  <a href="#" id="7305" class="med">桑枝</a>
			  <a href="#" id="868" class="med">黄芩</a>
			  <a href="#" id="4784" class="med">北沙参</a>
			  <a href="#" id="0" class="med">怀牛膝</a>
			  <a href="#" id="2099" class="med">酒</a>
			</td>
			<td><button class="btn">点击查看相关医案</button></td>
		</tr>
		
		</table>
    </div>
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/footer.css"></link>
	    <div class="footer" style="margin-bottom:0px;">
	           <div class=footer_L2>
	               <div class="footer_about cf">
	               
	                   <dl class=dlLeft id="dlLeft-first">
	                       <dt>法律声明</dt>
	                       <dd>
	                           <a href="${initParam.base}/user/agreementpage" rel="nofollow" target="_blank">注册服务条款</a>
	                       </dd>
	                       <dd>
	                           <a href="${initParam.base}/" target="_blank">首页</a>
	                       </dd>
	                   </dl>
	
	                   <dl class=dlLeft>
	                       <dt>帮助中心</dt>
	                       <dd>
	                           <a href="javascript:window.open('${initParam.base}/user/FAQ')" rel="nofollow" target="_blank">常见问题</a>
	                       </dd>
	                       <dd>
	                           <a href="${initParam.base}/user/getmanual" rel="nofollow" target="_blank">操作指南</a>
	                       </dd>
	                       <!-- 
	                       <dd>
	                           <a href="" target="_blank">版权申明</a>
	                       </dd>
	                       -->
	                   </dl>
	
	                   <dl class=dlLeft>
	                       <dt>支持我们</dt>
	                       <dd>
	                           <a href="${initParam.base}/user/feedback" rel="nofollow" target="_blank">意见反馈</a>
	                       </dd>
	                       <dd>
	                           <a href="${initParam.base}/user/join_us" rel="nofollow" target="_blank">加入我们</a>
	                       </dd>
	                   </dl>
	
	
	                   <dl class="dlLeft">
	                       <!-- <dd>邮政信箱：北京8068信箱</dd>
	                       <dd>邮编：100088</dd>
	                       <dd>服务热线：010-0000000</dd> -->
	                       <dt>关于我们</dt>
	                       <dd  class="aboutus-item"><a href="javascript:void(0);" class="#">项目简介</a></dd>
	                       <dd  class="aboutus-item"><a href="javascript:void(0);" class="#contact_us">联系我们</a></dd>
	                   </dl>
	               </div>
	
	               <div class=footer_links>
	                   <span class=footer_links_title>友情链接：</span> 
	                   <span class=footer_links_list> 
	                       <a href="http://www.cae.cn/cae/html/main/index.html" target="_blank">中国工程院</a> 
	                       <a href="http://www.satcm.gov.cn/" target="_blank">国家中医药管理局</a>
	                       <a href="http://www.catcm.ac.cn/" target="_blank">中国中医科学院</a> 
	                       <a href="http://www.sfda.gov.cn/WS01/CL0001/" target="_blank">国家食品药品监督管理总局</a>
	                       <a href="http://www.cma.org.cn/" target="_blank">中华医学会</a> 
	                   </span>
	               </div>
	               
	               <div class=footer_copy>
	                   <div class=footer_copy_right>
	                       <p>地址：北京市西城区冰窖口胡同2号</p>
	                       <p>Copyright © 2008 中国工程院 ICP备案号:京ICP备05023557号</p>
	                   </div>
	               </div>
	               <script type="text/javascript">
			          $('.aboutus-item').click(function(){
			            window.open("${initParam.base}/user/aboutuspage"+$(this).children().first().attr("class"));
			          })
			        </script>              
	           </div>
	       </div>
</body>
</html>