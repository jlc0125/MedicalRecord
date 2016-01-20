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
<script src="<%=contextPath%>/resources/common/jquery_1_8_3.js"></script>
<script src="<%=contextPath%>/resources/common/ajax.js"></script>
<script src="<%=contextPath%>/resources/common/d3.min.js"></script>
<script src="<%=contextPath%>/resources/common/d3pie.js"></script>
<script src="<%=contextPath%>/resources/medicine/med.js"></script>

<!-- exlib -->
<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>


<!-- css -->
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap-responsive.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/common.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/index.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/SubHeadAndFoot_index.css">
<link rel=stylesheet type=text/csz 
	href="<%=contextPath%>/resources/search/css/jichushousuo.css">
	
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/main.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/extra.css">
<style type="text/css">
	

</style>
</HEAD>
<script type="text/javascript">

var pie;
var dataAll;
var pageNo=1;
var pageSize=10;
var pageIndex;

$(function(){
	$(".option").each(function(){
		$(this).click(function(){
			$(".option").each(function(){
				$(this)[0].checked=false;
			});
			$(this)[0].checked=true;
		});
	});
	
	$("#btn").live(
			'click',
			function(){
				var keyword=$("#input").val();
				$.ajax({
					  type: 'POST',
					  url: "/MedicalRecord/search/retval",
					  data: {
						  "wd":keyword,
						  "type":"content"
					  },
					  success: success,
					  error:error,
					  dataType:"text"
					});
			});
	$(".med_checkbox").live("click",function(){
		generateLink();
	});
	/*
	$(window).scroll(function(){
		if(dataAll){
			if($("#records").offset().top+$("#records").height()-window.pageYOffset-$(window).height()<100){
				pageNo+=1;
				data=dataAll[pageIndex];
				records=data.records;
				showRecords(records,pageNo,pageSize);
				
			}
		}
	});
	*/
});

function success(data,textStatus,jqXHR){
	
	data=eval('(' + data + ')');
	$("#container").show();
	console.log(data);
	var head="<tr><th>编号</th><th>处方</th></tr>";
	var body="";
	var count=0;
	for(var i=0;i<data.length;i++){
		var cfIndex=data[i]["cfIndex"].split(" ");
		var content=data[i]["content"].split("|");
		for(var j=0;j<cfIndex.length;j++){
			count++;
			var pre=content[cfIndex[j]];
			var href="/MedicalRecord/pre_analysis?pre="+pre+"&recordId="+data[i]["recordId"]+"&recordTitle="+data[i]["recordTitle"];
			body+="<tr><td>" + count + "</td><td><a href='"+href+"'>" + pre + "</a></td></tr>";
		}
	}
	$("#front_search_list_title").html(head);
	$("#front_search_list_info").html(body);
	
}

function error(){
	alert("error");
}





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
				<div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
				<div class="clearfix"></div>
			</div>
		</div>
		</div>
	<div class="bg_heise">
		<div id="content" >
			<div class="logoSearch_L2" style="height:100px">
				<div id="search" class="search cf" style="height: 50px !important;">
					<INPUT id="input" class=text  name=q> 
					<A class=button id="btn" href="#"></A> <br>
				</div>
			</div>
			
			<div class="container-fluid " id="container" style="display:none">
				<div class="row-fluid">
					<div class="span12">
						<div class="tabbable tabs-left">
							<div class="tab-content span9">
								<div class="tab-pane active" id="front_search_list">
										<h2 id="sort_help"></h2>
										<table class="table " id="front_search_table">
											<thead id="front_search_list_title"></thead>
											<tbody id="front_search_list_info"></tbody>
										</table>
								</div>
							</div>
						</div>
					</div>
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
</BODY>
</HTML>
