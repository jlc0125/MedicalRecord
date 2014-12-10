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
<title>中草药基础知识搜索系统</title>
<!-- js -->
<script src="<%=contextPath%>/resources/common/jquery_1_8_3.js"></script>
<script src="<%=contextPath%>/resources/common/ajax.js"></script>
<!-- exlib -->
<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
<!-- css -->
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap-responsive.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/common.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/index.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/SubHeadAndFoot_index.css">
<link rel=stylesheet type=text/css 
	href="<%=contextPath%>/resources/search/css/yianfenxi.css">
</HEAD>

<BODY>
	<div class=top>
		<div>
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
		    <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
			<div id="common_nav">
			    <div class="cf" id="common_nav_L2">
			        <ul>
			            <li>
			                <a title="注册" href="/tcm/user/registerpage" rel="nofollow">注册</a>
			            </li>
		                <li>
		                    <a title="登录" href="/tcm/user/loginpage" rel="nofollow">登录</a>
		                </li>
			            <li><a title="帮助中心" href="javascript:void(0);" rel="nofollow">帮助中心</a></li>
			            <li><a title="知识中心导航" href="javascript:void(0);" rel="nofollow">知识中心导航</a></li>
			            <li><a title="知识中心首页" href="http://www.udms.org/ckcest/" rel="nofollow">知识中心首页</a></li>
			            <li><a class="current" title="中草药系统首页"  href="/tcm" rel="nofollow">中草药系统首页</a></li>
			        </ul>
			    </div>
			</div>
		</div>
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo"><A href="home" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	
	<div class="bg_heise">
		<div class="clearfix">
			<div class="imgFrame2">
					<img src="<%=contextPath%>/resources/search/Images/2_08.png" />
			</div>
		</div>

		<div class="UnderSearchBarTabs1" id="home_type_nav">
			<a id="href_A" href="index.html"></a> <a id="href_B" href="Browse"></a>
			<a id="href_C" href="Analysis"></a>
		</div>

		<div class="clearfix"></div>
		<br>
		<br>
		<br>
		
	
		
	  <div class="row-fluid" >
	     <div class="span3"><button class="btn btn-large" style="margin-right:100px;width:100%;height:100%"type="color:#33333">疾病分析</button></div>
	     <div class="span3"><button class="btn btn-large" style="margin-left:80px;width:100%;height:100%">辩证分析</button></div>
	  </div>
		
	</div>

	<!-- footer -->
	<div>
		
	
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
