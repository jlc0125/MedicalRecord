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
		<script src="<%=contextPath%>/resources/search/js/csrf.js"></script>
	
		<!-- exlib -->
		<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
		<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
		<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>
		
		
		<!-- css -->	
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap.css">
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap-responsive.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/main.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/common.css">
						
	</head>
	<style>
		#adjust_search{
			margin-left: 90%;
			font-size: 18px;
			line-height: 1.2;
			margin-bottom: 20px;
		}
		.sub, .add{
		cursor:pointer;
		height:15px;
		width:15px;
		display:inline !important  ;
		}
		.table td,.table th{
			text-align:center !important;
			vertical-align: middle;
			font-size:18px;
		}
		.header{
			font-size: 22px !important;
			font-weight: bold !important;
			text-align: center !important;
			line-height: 5em !important;
 		}
 		
 		.info{
 			border: 1px solid;
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
			classicTableBody+="<td><a href='../../DocAssist/pre/prescription?id="+data["经方"][i]["prescription_id"]+"'>"+data["经方"][i]["name"]+"</a></td><td>"+data["经方"][i]["dosage"]+"</td></tr>";
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
				<a href="index.html"><span id="nav_qwss" class="sub_nav_span"></span></a>
				<a href="Browse"><span id="nav_flll" class="sub_nav_span"></span></a>
				<a href="graph"><span id="nav_zhcx" class="sub_nav_span"></span></a>
		    </div>          
	    </div>
		
		<div class="clearfix"></div>
			
		<div id="tab-title">	
			<div id="front_menu">
	    	</div>
		</div>
		
		<div class="clearfix"></div>
		<div id="underline"></div>
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