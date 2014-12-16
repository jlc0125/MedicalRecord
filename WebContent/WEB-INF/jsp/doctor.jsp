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
		<title>中草药基础知识搜索系统</title>
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
	
		<div class=logo1>
			<div class="logo1_L1">
				<div class="logo">
	    	    	<a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A>
	    	    </div>
		    </div>
			<div class="logo1_L2">
				<div class="logo">
	    	    	<A href="../" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo_huiju.png"></A>
	    	    </div>
		    </div>
		</div>
		
		<div class="sub_nav_bg">
			<div id="sub_nav">
				<a href="<%=contextPath%>/index"><span id="nav_qwss" class="sub_nav_span"></span></a>
				<a href="<%=contextPath%>/Browse"><span id="nav_flll" class="sub_nav_span"></span></a>
				<a href="<%=contextPath%>/analysishome"><span id="nav_zhcx" class="sub_nav_span"></span></a>
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

</BODY></HTML>