<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String contextPath=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医案分析</title>
<!-- js -->
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<!-- exlib -->

<!-- css -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" type=text/css href="<%=contextPath%>/resources/common/css/logo.css">
<link href="<%=contextPath%>/resources/analysis_all.css" rel="stylesheet">
</head>
<body>
	<div class=top>
    <div>
        <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
        <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
        <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
        <%@include file="/WEB-INF/jsp/common/header.jsp"%>
    </div>
    <div class=logoSearch>
      <div class="logoSearch_L2">
        <div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/newPic/logo.png"></A></div>
        <div class="clearfix"></div>
      </div>
    </div>
    
  </div>

	<div class="container main-container">
		<div class="fieldset">
			<h4>系统介绍</h4>
			<p>医案系统旨在收集和展示医案， 分析和挖掘医案中潜在的信息， 帮助用户更好的理解医案。 系统基于历代中医医案，提供医案搜索、分类浏览以及医案分析的服务。从医案内容、医生以及出处多角度搜索医案。 将医案按照疾病、辩证、 治则等分类。 分析并呈现医案中方剂、中药和疾病之间的关系。</p>
		</div>
		<div class="fieldset">
			<h4>功能模块</h4>
			<ul class="function-list">
				<li class="function-item left">
					<a href="<%=contextPath%>/recipehome">
						<i class="function-icon icon-recipe"></i>
						<strong>方剂分析</strong>
						<p>分析方剂内容</p>
					</a>					
				</li>
				<li class="function-item">
					<a href="<%=contextPath%>/drughome">
						<i class="function-icon icon-drug"></i>
						<strong>中药分析</strong>
						<p>分析中药内容</p>
					</a>
				</li>
				<li class="function-item">
					<a href="<%=contextPath%>/symptomhome">
						<i class="function-icon icon-symptom"></i>
						<strong>疾病分析</strong>
						<p>分析疾病内容</p>
					</a>
				</li>
				<li class="function-item">
					<a href="<%=contextPath%>/treatmentmode">
						<i class="function-icon icon-bzzz"></i>
						<strong>治疗模式分析</strong>
						<p>分析治疗模式</p>
					</a>
				</li>
				<li class="function-item left bottom">
					<a href="<%=contextPath%>/bzzz/result">
						<i class="function-icon icon-treatment"></i>
						<strong>辩证治则分析</strong>
						<p>辩证治则分析</p>
					</a>
				</li>
				<li class="function-item bottom">
					<a href="">
						<i class=""></i>
						<strong></strong>
						<p></p>
					</a>
				</li>
				<li class="function-item bottom">
					<a href="">
						<i class=""></i>
						<strong></strong>
						<p></p>
					</a>
				</li>
				<li class="function-item bottom">
					<a href="">
						<i class=""></i>
						<strong></strong>
						<p></p>
					</a>
				</li>
			</ul>
		</div>
		
	</div>
	<!-- footer -->
	<!-- 统计信息 -->
	<!-- Piwik -->
	<script type="text/javascript">
	  var _paq = _paq || [];
	  _paq.push([ 'trackPageView' ]);
	  _paq.push([ 'enableLinkTracking' ]);
	  (function() {
	    var u = (("https:" == document.location.protocol) ? "https" : "http")
	        + "://www.ckcest.zju.edu.cn/piwik//";
	    _paq.push([ 'setTrackerUrl', u + 'piwik.php' ]);
	    _paq.push([ 'setSiteId', 1 ]);
	    var d = document, g = d.createElement('script'), s = d
	        .getElementsByTagName('script')[0];
	    g.type = 'text/javascript';
	    g.defer = true;
	    g.async = true;
	    g.src = u + 'piwik.js';
	    s.parentNode.insertBefore(g, s);
	  })();
	
	</script>
	<noscript><p><img src="http://www.ckcest.zju.edu.cn/piwik/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
    <!-- End Piwik Code -->

    <noscript><p><img src="http://www.ckcest.zju.edu.cn/piwik/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
    <!-- End Piwik Code -->
    
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