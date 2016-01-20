<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>医案系统</title>
		<!-- js -->
		<script src="<%=contextPath%>/resources/common/jquery_1_8_3.js"></script>		
		<script src="<%=contextPath%>/resources/common/ajax.js"></script>
		<script src="<%=contextPath%>/resources/search/js/csrf.js"></script>
	
		<!-- exlib -->
		<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
		<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
		<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>
		
		
		<!-- css -->	
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

						
	</head>
	<style>
		.logoSearch {
			WIDTH: 100%;
			HEIGHT: 93px;
		}
		
		.logoSearch_L2 {
			MARGIN: auto;
			width:960px
		}
		.logoSearch_L2 .logo {
			FLOAT: left; 
			PADDING-TOP: 18px; 
			height:75px
		}
		#main-content{
			font-family:"Microsoft YaHei";/* font-size:15px;text-align:center;*/ 
			width:960px;
			min-height:200px;
			margin:auto;
			margin-bottom:80px;
			float:none
		}
		#adjust_search{
			margin-left: 85%;
			font-size: 16px;
			line-height: 1.2;
			margin-bottom: 20px;
			border: 1px solid #cbcbcb;
			 border-bottom: 4px solid #b2b1b1;
		}
		.sub, .add{
			cursor:pointer;
			height:15px;
			width:15px;
			display:inline !important  ;
		}
		.table th{
			min-width:80px;
		}
		.table td,.table th{
			text-align:center !important;
			vertical-align: middle;
			font-size:14px;
		}
		.header{
			font-size: 18px !important;
			font-weight: bold !important;
			text-align: center !important;
			line-height: 3em !important;
 		}
 		
 		.info{
 			border: 1px solid #999999;
			border-radius: 15px;
			margin-top: 15px;
			margin-bottom:30px;
 		}
 		table{
 			margin-left:0% !important;
 		}
	</style>
	
	<script type="text/javascript">
	jQuery(function(){
		var pageSize=6;
		var pre=decodeURI(getUrlParam("pre"));
		var url="./pre_analysis/retval";
		var dataJson={
				pre:pre,
		};
		jQuery.ajax({
			type: "GET",
			url: url,
			data: dataJson,
			success:successCB,
			error:errorCB		
		});
		
		jQuery("#adjust_search").live("click",function(){
			keyword="";
			jQuery(".med").each(function(){
				keyword+=jQuery(this).html();
			});
			
			window.location.href = "/MedicalRecord/search/result?wd=" + keyword
			+ "&type=content";
		});
	});

	function successCB(data){
		console.log(data);
		var recordId=getUrlParam("recordId");
		var recordTitle=decodeURI(getUrlParam("recordTitle"));
		var pre=decodeURI(getUrlParam("pre"));
		var recordBody="<tr><th>医案名称</th><td><a href='/MedicalRecord/record_detail?recordId="+recordId+"'>"+recordTitle+"</a></td></tr>";
		recordBody+="<tr><th>处方</th><td>"+pre+"</td></tr>";
		jQuery("#record_header").html("医案信息");
		jQuery("#record_body").html(recordBody);
		
		var adjustTableBody="<tr>";
		for(var i=0;i<data["中草药"].length;i++){
			adjustTableBody+="<td><span class='med'>"+data["中草药"][i]+"</span><img src='/MedicalRecord/resources/image/icon/sub.jpg'  class='sub' ></td>";
		}
		adjustTableBody+="<td><span>加方</span><img src='/MedicalRecord/resources/image/icon/add.jpg' class='add'/></td>";
		jQuery("#adjust_pre_header").html("加减方");
		jQuery("#adjust_pre_body").html(adjustTableBody);
		
		jQuery("#adjust_pre").after("<button id='adjust_search' type='button' class='btn' >检索医案</button>")
		jQuery(".sub").live("click",function (){
			jQuery(this).parent().remove();
		});
		
		jQuery(".add").live("click",function (){
			jQuery(this).parent().children().eq(0).remove();
			jQuery(this).before("<input type='text' class='add_med' value='请输入' size='6'/>");
			jQuery(".add_med").live("keydown",function(event){
				if(event.keyCode==13){
					console.log("enter");
					var input=jQuery(this).val();
					var parent=jQuery(this).parent();
					parent.empty();
					parent.append("<span class='med'>"+input+"</span><img src='/MedicalRecord/resources/image/icon/sub.jpg'  class='sub' ></td>");
					parent.after("<td><span>加方</span><img src='/MedicalRecord/resources/image/icon/add.jpg' class='add'/></td>");
				}
			});
		});
		
		var classicTableHead="<tr><th>经方名称</th><th>经方组成</th></tr>";
		var classicTableBody="<tr>";
		for (var i=0;i<data["经方"].length;i++){
			classicTableBody+="<td><a href='../../DocAssist/pre/prescription?id="+data["经方"][i]["id"]+"'>"+data["经方"][i]["name"]+"</a></td><td>"+data["经方"][i]["dosage"]+"</td></tr>";
		}
		jQuery("#classic_pre_header").html("经方分析");
		jQuery("#classic_pre_title").html(classicTableHead);
		jQuery("#classic_pre_body").html(classicTableBody);
		
		jQuery("#med_header").html("自用药");
		var medTableBody="<tr>";
		for (var i=0;i<data["自用药"].length;i++){
			medTableBody+="<td>"+data["自用药"][i]+"</td>";
		}
		medTableBody+="</tr>";
		
		jQuery("#med_body").html(medTableBody);
		
	}
	function errorCB(){
		
	}
	
	
	</script>
	
	
	
	
	<body>
	<div class="top">
	    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
	    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
	    <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
		<%@include file="/WEB-INF/jsp/common/header.jsp"%>
	</div>
	
	<div class=logoSearch>
		<div class="logoSearch_L2">
			<div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></a></div>           
		</div>
	</div>
		
	<div class="clearfix"></div>
	
	<div class="container-fluid ">
		<div id="main-content" class="content clearfix"> 
           	<div id="pre_info">
           		<div class="info">
           			<h2 id="record_header" class="header"></h2>
					<table id="record" class="table">
						<tbody id="record_body"></tbody>
					</table>
				</div>
           	
				<div class="info">
					<h2 id="classic_pre_header" class="header"></h2>
					<table id="classic_pre" class="table">
						<thead id="classic_pre_title"></thead>
						<tbody id="classic_pre_body"></tbody>
					</table>
				</div>
				
				<div class="info">
					<h2 id="med_header" class="header"></h2>
					<table id="med" class="table">
						<thead id="med_title"></thead>
						<tbody id="med_body"></tbody>
					</table>
				</div>
				
				<div class="info">
					<h2 id="adjust_pre_header" class="header"></h2>
					<table id="adjust_pre" class="table">
						<thead id="adjust_pre_title"></thead>
						<tbody id="adjust_pre_body"></tbody>
					</table>
					
				</div>
               </div>
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

</BODY></HTML>