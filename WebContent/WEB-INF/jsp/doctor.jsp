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
		<script src="<%=contextPath%>/resources/search/js/search_com.js"></script>
		<style>
		img{
			max-width:90%;
		}
		.info th:nth-child(2){
			padding-top:10%;
			padding-bottom:10%;
			padding-left:5%;
			padding-right:5%;
		}
		.info th:nth-child(1){
			padding-top:5%;
			padding-bottom:5%;
			padding-left:10%;
			padding-right:10%;
		}
		.info td{
			text-align:left !important;
		}
		
		.record th{
			text-align: center !important;
			vertical-align: middle !important;
		}
		</style>
		
		<script type="text/javascript">
			var dataGlobal;
			$(function(){
				$.ajax({
					type: 'POST',
					url: "./doctor/data",
					data: {id:getUrlParam("id")},
					success: getDoctorSuccess,
					error: getDoctorError,
					dataType:'text'
				});
				
				$("#doctor_info").live("click",function(){
					$(this).attr("class","active");
					$("#doctor_record").removeClass("active");
					showData(dataGlobal,"info");
				});
				
				$("#doctor_record").live("click",function(){
					$(this).attr("class","active");
					$("#doctor_info").removeClass("active");
					showData(dataGlobal,"record");
				});
			});
			
			function getDoctorSuccess(data){
				data=eval('(' + data + ')');
				dataGlobal=data;
				$("#doctor_info").html("<a href='#'>"+data.name+"信息</a>")
				$("#doctor_record").html("<a href='#'>"+data.name+"医案</a>")
				showData(data,"info");
			}
			
			function getDoctorError(){
				console.log("error");
			}
			function showData(data,type){
				var thead="";
				var tbody="";
				if(type=="info"){
					console.log($("#doctor_body"));
					$("#doctor_body").addClass("info");
					$("#doctor_body").removeClass("record");
					thead="<tr><th>肖像</th><th>个人简介</th></tr>";
					tbody+="<tr><td><img src='<%=contextPath%>/resources/"+data.picture+"'/></td><td>"+data.introduction+"</th></td>";
					$("#doctor_head").html(thead);
					$("#doctor_body").html(tbody);
					
				}
				else if(type=="record"){
					$("#doctor_body").addClass("record");
					$("#doctor_body").removeClass("info");
					thead="<tr><th>医案名称</th><th>医案出处</th></tr>";
					$.ajax({
						type: 'POST',
						url: "./search/retval",
						data: {
							wd:data.name,
							type:"doctor"
							},
						success: success,
						error: error,
						dataType:'text'
					});
					
					function success(data){
						data=eval('(' + data + ')');
						for(var i=0;i<data.length;i++){
							if(data[i].recordTitle=="") continue;
							tbody+="<tr><th class='record_list_th'><a href='/MedicalRecord/record_detail?recordId="+data[i].recordId+"'>"+data[i].recordTitle+"</th><th><a href='/MedicalRecord/search/result?wd="+data[i].reference+"&type=reference'>"+data[i].reference+"</a></th></tr>"
						}
						$("#doctor_head").html(thead);
						$("#doctor_body").html(tbody);
					}
					
					function error(){
						console.log("recordListError");
					}
				}
				
			}
		</script>
		
		
		
	
		<!-- exlib -->
		<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
		<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
		<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>
		
		
		<!-- css -->	
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap.css">
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap-responsive.css">
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/main.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/Peiwu_analyse.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/extra.css">
						
	</head>
	<body>
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
	
		
		
		<div class="clearfix"></div>
			
		<div id="tab-title">	
			<div id="front_menu">
	    	</div>
		</div>
		
		<div class="clearfix"></div>
		<div class="clearfix"></div>
		
		<div class="container-fluid ">
				<div class="row-fluid">
					<div class="span12">
					<ul class="nav nav-tabs">
					  <li class="active" id="doctor_info">
					  </li>
					  <li id="doctor_record"></li>
					</ul>
						<div id="content_container" class="container-fluid" style="background-color:white">
							<table class="table">
								<thead id="doctor_head">
								</thead>
								<tbody id="doctor_body">
								</tbody>
							</table>
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
                       <p><a href="http://www.imicams.ac.cn/" target="_blank">中国医学科学院医学信息研究所</a>创办并维护</p>
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