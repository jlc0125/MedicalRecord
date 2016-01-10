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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/revision/css/revision.css">
<link rel="stylesheet" type=text/css href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css">
</HEAD>

<BODY onload="initRevisionProfessor()">
	<div class=top>
	     <div>   
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
		    <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
			<div id="common_nav">
			    <div class="cf" id="common_nav_L2">
			        <ul>
			            <li>
			                <a title="注册" href="http://zcy.ckcest.cn/tcm/user/registerpage" rel="nofollow">注册</a>
			            </li>
		                <li>
		                    <a title="登录" href="http://zcy.ckcest.cn/tcm/user/loginpage" rel="nofollow">登录</a>
		                </li>
			            <li><a title="帮助中心" href="javascript:void(0);" rel="nofollow">帮助中心</a></li>
			            <li><a title="知识中心首页" href="http://www.ckcest.cn" rel="nofollow">知识中心首页</a></li>
			            <li><a class="current" title="中草药系统首页"  href="http://zcy.ckcest.cn/tcm/" rel="nofollow">中草药系统首页</a></li>
			        </ul>
			    </div>
			</div>
	     </div>
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></a></div>           
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
							类型: <span class="typename">医案标题修改&nbsp;</span>
							同意人数：<span class="typename">2&nbsp;</span>
							不同意人数：<span class="typename">4</span>
						</p>
					</div>
					<div class="info clearfix">
						<span class="time">12-07 15:00</span>						
						<a class="dispraise" href="javascript:;">
							<span class="dispraise_txt">关闭</span>
							
						</a>
						<a class="correct" href="javascript:;">
							<span class="correct_txt">修改</span>
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

    <noscript><p><img src="http://10.15.62.209/piwik/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
    <!-- End Piwik Code -->
    
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/footer.css"></link>
    <div class="footer" style="margin-bottom:0px;">
           <div class=footer_L2>
               <div class="footer_about cf">
                   <dl class=dlLeft>
                       <dt>中草药专业知识服务系统</dt>
                       <dd>
                           <a href="" rel="nofollow" target="_blank">关于我们</a>
                       </dd>
                       <dd>
                           <a href="" rel="nofollow" target="_blank">加入我们</a>
                       </dd>
                       <dd>
                           <a href="" target="_blank">网站地图</a>
                       </dd>
                   </dl>

                   <dl class=dlLeft>
                       <dt>服务与支持</dt>
                       <dd>
                           <a href="/tcm/user/agreementpage" rel="nofollow" target="_blank">注册服务条款</a>
                       </dd>
                       <dd>
                           <a href="/tcm/user/feedback" rel="nofollow" target="_blank">意见反馈</a>
                       </dd>
                       <dd>
                           <a href="" rel="nofollow" target="_blank">版权申明</a>
                       </dd>
                   </dl>

                   <dl class=dlLeft>
                       <dt>用户中心</dt>
                       <dd>
                           <a href="" rel="nofollow" target="_blank">常见问题</a>
                       </dd>
                       <dd>
                           <a href="/tcm/user/loginpage" rel="nofollow" target="_blank">登录</a>
                           <a href="/tcm/user/registerpage" rel="nofollow" target="_blank">注册</a>
                       </dd>
                   </dl>


                   <dl class="dlLeft">
                       <dt>联系我们</dt>
                       <dd>邮政信箱：北京8068信箱</dd>
                       <dd>邮编：100088</dd>
                       <dd>服务热线：010-0000000</dd>
                   </dl>
               </div>

               <div class=footer_links>
                   <span class=footer_links_title>友情链接：</span> 
                   <span class=footer_links_list> 
                       <a href="" target="_blank">药典</a> 
                       <a href="" target="_blank">中医论坛</a> 
                       <a href="" target="_blank">中草药知识库</a>
                       <a href="" target="_blank">中医养生</a> 
                       <a href="" target="_blank">方剂库</a>
                       <a href="" target="_blank">药剂库</a> 
                       <a href="" target="_blank">中药知识大全</a>
                   </span>
               </div>

               <div class=footer_copy>
                   <div class=footer_copy_right>
                       <p>地址：北京市西城区冰窖口胡同2号</p>
                       <p>Copyright ? 2008 中国工程院 ICP备案号:京ICP备05023557号</p>
                   </div>
               </div>
           </div>
       </div>
	</div>
</BODY>
</HTML>
