<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html dir="ltr" xml:lang="en-gb" xmlns="http://www.w3.org/1999/xhtml"
	lang="en-gb">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医案系统</title>
<!-- js -->
<script src="<%=contextPath%>/resources/common/jquery_1_8_3.js"></script>
<script src="<%=contextPath%>/resources/common/ajax.js"></script>
<script src="<%=contextPath%>/resources/search/js/search_com.js"></script>
<script src="<%=contextPath%>/resources/revision/js/revision.js"></script>

<!-- exlib -->
<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>

<!-- css -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/revision/css/revision.css">
</HEAD>

<BODY onload="initRevision()">
	<div class=top>
	     <div>   
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
		    <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
			<%@include file="/WEB-INF/jsp/common/header.jsp"%>
	     </div>
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></a></div>  
				<button class="btn btn-success professor">专家评价入口</button>         
			</div>
		</div>
	</div>

	<div id="main-content">
		<div id="list">
			<div class="box clearfix">
				<div class="content">
					<div class="main">
						<p class="title"><span class="id">ID:1&nbsp;</span>339#麻黄治愈阳虚</p>
						<p class="txt">“麻黄治愈阴虚”这个医案不属于阴虚，属于阳虚。</p>
						<p class="type">
							类型: <span class="typename">医案标题修改</span>
						</p>
					</div>
					<div class="info clearfix">
						<span class="time">12-07 15:00</span>						
						<a class="dispraise" href="javascript:;">
							<span class="dispraise_txt">不同意</span>
							(<span class="dispraises-total" dis-total="2">2</span>)
						</a>
						<a class="praise" href="javascript:;">
							<span class="praise_txt">同意</span>
							(<span class="praises-total" total="4">4</span>)
						</a>
					</div>
					<!-- <div class="praises-total" total="4" style="display:block;">4个人同意他的观点</div> -->
				</div>
			</div>
			<div class="box clearfix">
				<div class="content">
					<div class="main">
						<p class="title"><span class="id">ID:2&nbsp;</span>麻黄/阴虚</p>
						<p class="txt">麻黄不能治疗阴虚</p>
						<p class="type">
							类型: <span class="typename">相关关系删除</span>
						</p>
					</div>
					<div class="info clearfix">
						<span class="time">12-07 15:00</span>						
						<a class="dispraise" href="javascript:;">
							<span class="dispraise_txt">不同意</span>
							(<span class="dispraises-total" dis-total="2">2</span>)
						</a>
						<a class="praise" href="javascript:;">
							<span class="praise_txt">同意</span>
							(<span class="praises-total" total="4">4</span>)
						</a>
					</div>
				</div>
			</div>
			<div class="box clearfix">
				<div class="content">
					<div class="main">
						<p class="title"><span class="id">ID:3&nbsp;</span>医案分类错了</p>
						<p class="txt">“六君子汤治愈发热恶寒”没有表里辨证</p>
						<p class="type">
							类型: <span class="typename">医案分类错误</span>
						</p>
					</div>
					<div class="info clearfix">
						<span class="time">12-07 15:00</span>						
						<a class="dispraise" href="javascript:;">
							<span class="dispraise_txt">不同意</span>
							(<span class="dispraises-total" dis-total="2">2</span>)
						</a>
						<a class="praise" href="javascript:;">
							<span class="praise_txt">同意</span>
							(<span class="praises-total" total="4">4</span>)
						</a>
					</div>
				</div>
			</div>
		</div>
		<div id="rvs_pagincation" class="rs_pagincation"></div>
	</div>

	<!-- footer -->
	<div>
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
	</div>
</BODY>
</HTML>
