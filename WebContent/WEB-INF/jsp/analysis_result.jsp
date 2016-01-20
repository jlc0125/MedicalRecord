<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html dir="ltr" xml:lang="en-gb" xmlns="http://www.w3.org/1999/xhtml" lang="en-gb">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医案系统</title>
<head>
<!-- js -->
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<script src="<%=contextPath%>/resources/common/d3.min.js"></script>
<script src="<%=contextPath%>/resources/common/d3pie.js"></script>
<script type="text/javascript" src="<%=contextPath%>/resources/analysis/js/bzzz_analysis.js"></script>


<!-- css -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" type=text/css href="<%=contextPath%>/resources/common/css/logo.css">


<style type="text/css">
	thead{
	background-color: #f5f2f1;
	}
	.info{
	background-color: #B8AEAB;
	text-align:center;
	}
	.alert{
		text-align:center;
		font-size: 20px;
		margin-left: 25%;
		margin-right: 26%;
		margin-top: 30px;
	}

  .record_search_logo{
    padding-top:80px;
    padding-bottom:50px;
  }
  .center{
    text-align:center;
  }
  #input{
    line-height: 20px;
    width: 580px;
    
    padding: 10px 9px 10px 7px;
    vertical-align: middle;
    font-size: 16px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
  }
  
  #btn{
    height: 46px;
    line-height: 40px;
    font-size: 16px;
    padding: 0;
    margin: 0;
    width: 104px;
  }

  .bg_heise{
    min-height: 600px;
  }
  #meds th{
    text-align: center !important;
  } 
  #meds table{
    margin-bottom: 0px !important; 
  }
    
</style>
</HEAD>
<script type="text/javascript">

</script>

<BODY>
	<div class=top>
		<div>
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
		    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
		    <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
			<%@include file="/WEB-INF/jsp/common/header.jsp"%>
		</div>
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo"><a href="/MedicalRecord/index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
				<div class="clearfix"></div>
			</div>
		</div>
		</div>
	<div class="bg_heise">
	
			<!-- <div class="logoSearch_L2" style="height:100px">
				<div id="search" class="search cf" style="height: 50px !important;">
					<INPUT id="input" class=text  name=q> 
					<A class=button id="btn" href="#"></A> <br>
				</div>
				<div class="checkboxes2" id="option">搜索选项：&nbsp; 
						<input type="checkbox" class="option" id="bz_opt">辩证&nbsp;&nbsp;
						<input type="checkbox" class="option" id="zz_opt">治则&nbsp;&nbsp;
				</div>
			</div> -->
            <div class="search_div center">
                <div id="search" class="search">
                    <input id="input" class=text maxLength=50> 
                    <button class="btn btn-primary" id="btn">搜索</button>
                    <br>
                    <br>
                    <!-- <div id="checkboxes center" id="option">搜索选项：&nbsp; 
                        <input type="checkbox" class="option" id="content_opt">医案内容(包括中药、方剂、疾病、辩证、治则等)&nbsp;&nbsp;
                        <input type="checkbox" class="option" id="doctor_opt">医生&nbsp;&nbsp;
                        <input type="checkbox" class="option" id="reference_opt">医案出处&nbsp;&nbsp;
                    </div> -->
                    <div class="checkboxes center" id="option">搜索选项：&nbsp; 
                        <input type="checkbox" class="option" id="bz_opt">辩证&nbsp;&nbsp;
                        <input type="checkbox" class="option" id="zz_opt">治则&nbsp;&nbsp;
                    </div>
                </div>
            </div>

      <div class="alert" style="display:none">
        <strong>您输入的词中不包含辩证或治则词汇，请再次输入</strong> 
      </div>
      <div class="col-md-2"></div>
			<div class="col-md-8 content" style="display:none">
        <ul id="nav" class="nav nav-tabs"></ul>
        <div style="border: 1px solid #ddd;">
          <div id="meds" style="text-align: center;border-bottom: 1px solid #ddd !important;">
          </div>
          
          <div id="pieChart" class="span3" style="padding-left:40%;width:20%">
          </div>
          <div id="search_link_div">
            <a id="search_link"></a>
          </div>
        </div>
			</div>
		
	</div>
	

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
</BODY>
</HTML>
