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

	function test(obj){
		if(obj.id!='null')
		obj.href = 'http://zcy.ckcest.cn/tcm/search/med?medname='+obj.innerHTML+'&medid='+obj.id;
		else
		obj.href = 'http://zcy.ckcest.cn/tcm/search/frontsearch?keyword='+obj.innerHTML+'&range=111111&pageno=1&type=med#sub_nav';
	}


	window.onload=function(){
		altRows('alternatecolor');
	}
	</script>

	<style type="text/css">
	
	table.altrowstable {
	  font-family:"微软雅黑";
	  width:800px;
	  border-collapse:collapse;
	  text-align: center;
	}
	table.altrowstable th {
	    
		border-width: 1px; 
		padding: 8px;
		border-style: solid;
		border-color: transparent;
	}
	table.altrowstable td {
		font-size:1.1em;
		padding: 8px;
		border-style: solid;
		border-color: transparent;
	}
	.oddrowcolor{
		background-color:transparent;
	}
	.evenrowcolor{
		background-color:#E5EBF1;
	}
	
	table.altrowstable caption
	  {
	    font-size: 2em;
	  }
	
	table.altrowstable td.con
	  {
	  font-size:0.85em;
	  font-family:"宋体"
	  }
	a { /*text-decoration: none;*/ }
	a:link { color:#0000FF; }      /* 未访问的链接 */
	a:visited { color: #0000FF; }  /* 已访问的链接 */
	a:hover { color:#000077; }     /* 当有鼠标悬停在链接上 */
	a:active { color:#0000FF; }    /* 被选择的链接 */
	</style>

</head>
<body>

  <div style="position:relative; left:210px;top:110px">
       <table class="altrowstable" id="alternatecolor">
           <caption style="color:#FF0000">功效分类</caption>
		<tr>
		<td>消导化积</td>
		<td class="con">
		  <a href="#" id="380" onclick="test(this);">柴胡</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">陈皮</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="5833" onclick="test(this);">砂仁</a>&nbsp
		  <a href="#" id="6854" onclick="test(this);">枳壳</a>&nbsp
		  <a href="#" id="271" onclick="test(this);">党参</a>&nbsp
		  <a href="#" id="1543" onclick="test(this);">木香</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>痈疡剂</td>
		<td class="con">
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">黄芪</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="1475" onclick="test(this);">黄柏</a>&nbsp
		  <a href="#" id="4994" onclick="test(this);">附子</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">陈皮</a>&nbsp
		  <a href="#" id="271" onclick="test(this);">党参</a>&nbsp
		  <a href="#" id="2124" onclick="test(this);">酱</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>清热</td>
		<td class="con">
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">生地</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">丹皮</a>&nbsp
		  <a href="#" id="868" onclick="test(this);">黄芩</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="1437" onclick="test(this);">黄连</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>理血</td>
		<td class="con">
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">黄芪</a>&nbsp
		  <a href="#" id="1182" onclick="test(this);">川芎</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="607" onclick="test(this);">赤芍</a>&nbsp
		  <a href="#" id="337" onclick="test(this);">丹参</a>&nbsp
		  <a href="#" id="672" onclick="test(this);">牛膝</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>泻下</td>
		<td class="con">
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="672" onclick="test(this);">牛膝</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">麻仁</a>&nbsp
		  <a href="#" id="1249" onclick="test(this);">桑寄生</a>&nbsp
		  <a href="#" id="337" onclick="test(this);">丹参</a>&nbsp
		  <a href="#" id="271" onclick="test(this);">党参</a>&nbsp
		  <a href="#" id="3028" onclick="test(this);">杜仲</a>&nbsp
		  <a href="#" id="1157" onclick="test(this);">厚朴</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">熟地</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>解表</td>
		<td class="con">
		  <a href="#" id="311" onclick="test(this);">杏仁</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">贝母</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="7338" onclick="test(this);">橘</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="752" onclick="test(this);">沙参</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="6432" onclick="test(this);">枇杷</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>治燥</td>
		<td class="con">
		  <a href="#" id="5175" onclick="test(this);">连翘</a>&nbsp
		  <a href="#" id="7072" onclick="test(this);">桑叶</a>&nbsp
		  <a href="#" id="3403" onclick="test(this);">薄荷</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">生地</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="4466" onclick="test(this);">石膏</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">银花</a>&nbsp
		  <a href="#" id="911" onclick="test(this);">知母</a>&nbsp
		  <a href="#" id="311" onclick="test(this);">杏仁</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">麦冬</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>温里</td>
		<td class="con">
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="4994" onclick="test(this);">附子</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="4919" onclick="test(this);">干姜</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="6880" onclick="test(this);">桂枝</a>&nbsp
		  <a href="#" id="4870" onclick="test(this);">生姜</a>&nbsp
		  <a href="#" id="4463" onclick="test(this);">人参</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>祛痰</td>
		<td class="con">
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="3589" onclick="test(this);">竹茹</a>&nbsp
		  <a href="#" id="7338" onclick="test(this);">橘</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="1944" onclick="test(this);">藜</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">陈皮</a>&nbsp
		  <a href="#" id="1469" onclick="test(this);">郁金</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">瓜蒌</a>&nbsp
		  <a href="#" id="5630" onclick="test(this);">茯神</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>祛湿</td>
		<td class="con">
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="6880" onclick="test(this);">桂枝</a>&nbsp
		  <a href="#" id="1528" onclick="test(this);">泽泻</a>&nbsp
		  <a href="#" id="380" onclick="test(this);">柴胡</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">陈皮</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">茵陈</a>&nbsp
		  <a href="#" id="868" onclick="test(this);">黄芩</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>补益</td>
		<td class="con">
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">黄芪</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="271" onclick="test(this);">党参</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">熟地</a>&nbsp
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="300" onclick="test(this);">山药</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>和解</td>
		<td class="con">
		  <a href="#" id="380" onclick="test(this);">柴胡</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="1437" onclick="test(this);">黄连</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="1543" onclick="test(this);">木香</a>&nbsp
		  <a href="#" id="868" onclick="test(this);">黄芩</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>治风</td>
		<td class="con">
		  <a href="#" id="2926" onclick="test(this);">钩藤</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">菖蒲</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="1627" onclick="test(this);">菊花</a>&nbsp
		  <a href="#" id="2099" onclick="test(this);">酒</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">生地</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="5175" onclick="test(this);">连翘</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>开窍</td>
		<td class="con">
		  <a href="#" id="5175" onclick="test(this);">连翘</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">生地</a>&nbsp
		  <a href="#" id="4466" onclick="test(this);">石膏</a>&nbsp
		  <a href="#" id="911" onclick="test(this);">知母</a>&nbsp
		  <a href="#" id="3589" onclick="test(this);">竹茹</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">山栀</a>&nbsp
		  <a href="#" id="4411" onclick="test(this);">芦根</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">银花</a>&nbsp
		  <a href="#" id="1332" onclick="test(this);">石斛</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">花粉</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>理气</td>
		<td class="con">
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="6880" onclick="test(this);">桂枝</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">炙甘草</a>&nbsp
		  <a href="#" id="1543" onclick="test(this);">木香</a>&nbsp
		  <a href="#" id="1182" onclick="test(this);">川芎</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>固涩</td>
		<td class="con">
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">黄芪</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="271" onclick="test(this);">党参</a>&nbsp
		  <a href="#" id="300" onclick="test(this);">山药</a>&nbsp
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">生地</a>&nbsp
		  <a href="#" id="3028" onclick="test(this);">杜仲</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>驱虫</td>
		<td class="con">
		  <a href="#" id="309" onclick="test(this);">白术</a>&nbsp
		  <a href="#" id="3210" onclick="test(this);">茯苓</a>&nbsp
		  <a href="#" id="271" onclick="test(this);">党参</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="1528" onclick="test(this);">泽泻</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">黄芪</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">陈皮</a>&nbsp
		  <a href="#" id="6787" onclick="test(this);">大腹皮</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">腹皮</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>涌吐</td>
		<td class="con">
		  <a href="#" id="4309" onclick="test(this);">香附</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">盐</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">金铃子</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">陈皮</a>&nbsp
		  <a href="#" id="4123" onclick="test(this);">青蒿</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">元参</a>&nbsp
		  <a href="#" id="2597" onclick="test(this);">蚕沙</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">姜</a>&nbsp
		  <a href="#" id="1543" onclick="test(this);">木香</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">生薏仁</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>安神</td>
		<td class="con">
		  <a href="#" id="null" onclick="test(this);">生地</a>&nbsp
		  <a href="#" id="1874" onclick="test(this);">远志</a>&nbsp
		  <a href="#" id="5630" onclick="test(this);">茯神</a>&nbsp
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="337" onclick="test(this);">丹参</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">地黄</a>&nbsp
		  <a href="#" id="24" onclick="test(this);">牡蛎</a>&nbsp
		  <a href="#" id="1469" onclick="test(this);">郁金</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>祛暑</td>
		<td class="con">
		  <a href="#" id="24" onclick="test(this);">牡蛎</a>&nbsp
		  <a href="#" id="1332" onclick="test(this);">石斛</a>&nbsp
		  <a href="#" id="2362" onclick="test(this);">玉</a>&nbsp
		  <a href="#" id="1452" onclick="test(this);">川贝母</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">归身</a>&nbsp
		  <a href="#" id="672" onclick="test(this);">牛膝</a>&nbsp
		  <a href="#" id="3592" onclick="test(this);">阿胶</a>&nbsp
		  <a href="#" id="5857" onclick="test(this);">大麦</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">丹皮</a>&nbsp
		  <a href="#" id="1643" onclick="test(this);">沉香</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>表里双解</td>
		<td class="con">
		  <a href="#" id="380" onclick="test(this);">柴胡</a>&nbsp
		  <a href="#" id="868" onclick="test(this);">黄芩</a>&nbsp
		  <a href="#" id="2965" onclick="test(this);">甘草</a>&nbsp
		  <a href="#" id="2904" onclick="test(this);">半夏</a>&nbsp
		  <a href="#" id="4870" onclick="test(this);">生姜</a>&nbsp
		  <a href="#" id="1482" onclick="test(this);">藿香</a>&nbsp
		  <a href="#" id="6880" onclick="test(this);">桂枝</a>&nbsp
		  <a href="#" id="1525" onclick="test(this);">青皮</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">炙甘草</a>&nbsp
		  <a href="#" id="1581" onclick="test(this);">草果</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>经产剂</td>
		<td class="con">
		  <a href="#" id="433" onclick="test(this);">当归</a>&nbsp
		  <a href="#" id="4309" onclick="test(this);">香附</a>&nbsp
		  <a href="#" id="3707" onclick="test(this);">白芍</a>&nbsp
		  <a href="#" id="1182" onclick="test(this);">川芎</a>&nbsp
		  <a href="#" id="2846" onclick="test(this);">菟丝子</a>&nbsp
		  <a href="#" id="607" onclick="test(this);">赤芍</a>&nbsp
		  <a href="#" id="2357" onclick="test(this);">母草</a>&nbsp
		  <a href="#" id="2731" onclick="test(this);">菟丝</a>&nbsp
		  <a href="#" id="2038" onclick="test(this);">益母草</a>&nbsp
		  <a href="#" id="380" onclick="test(this);">柴胡</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>疏肝解郁</td>
		<td class="con">
		  <a href="#" id="7305" onclick="test(this);">桑枝</a>&nbsp
		  <a href="#" id="463" onclick="test(this);">秦艽</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">防己</a>&nbsp
		  <a href="#" id="672" onclick="test(this);">牛膝</a>&nbsp
		  <a href="#" id="466" onclick="test(this);">独活</a>&nbsp
		  <a href="#" id="2099" onclick="test(this);">酒</a>&nbsp
		  <a href="#" id="665" onclick="test(this);">海桐皮</a>&nbsp
		  <a href="#" id="501" onclick="test(this);">威灵仙</a>&nbsp
		  <a href="#" id="1042" onclick="test(this);">鸡血</a>&nbsp
		  <a href="#" id="2916" onclick="test(this);">五加皮</a>&nbsp
		</td>
		</tr>
		
		<tr>
		<td>耳鼻咽喉病方</td>
		<td class="con">
		  <a href="#" id="672" onclick="test(this);">牛膝</a>&nbsp
		  <a href="#" id="1475" onclick="test(this);">黄柏</a>&nbsp
		  <a href="#" id="3939" onclick="test(this);">防风</a>&nbsp
		  <a href="#" id="1249" onclick="test(this);">桑寄生</a>&nbsp
		  <a href="#" id="463" onclick="test(this);">秦艽</a>&nbsp
		  <a href="#" id="7305" onclick="test(this);">桑枝</a>&nbsp
		  <a href="#" id="868" onclick="test(this);">黄芩</a>&nbsp
		  <a href="#" id="4784" onclick="test(this);">北沙参</a>&nbsp
		  <a href="#" id="null" onclick="test(this);">怀牛膝</a>&nbsp
		  <a href="#" id="2099" onclick="test(this);">酒</a>&nbsp
		</td>
		</tr>
		
		</table>
    </div>

</body>
</html>