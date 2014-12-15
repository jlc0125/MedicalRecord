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
		.chufang{
			background-color:rgb(220, 234, 247);
			cursor:pointer;
		}
		p {
			text-indent: 2em;
			padding:5px;
			font-size:12px;
			margin:5px 0;
		}
		
		#doctor{
			padding-top:5%;
			font-size:14px;
			line-height:18px;
			font-family: inherit;
			font-weight: bold;
			text-align:center;
		}
		#content{
			padding-top:5%;
			text-align:left;
		}
		#title{
			padding-top:5%;
			text-align:center;
		}
		#reference{
			text-align:right;
			font-size:14px;
			line-height:18px;
			font-family: inherit;
			font-weight: bold;
		}
		
		#content_container{
			background-color:white;
			width:80%;
		}
		</style>
		
		<script type="text/javascript">
		var dataGlobal;
		$(function(){
			var dataJson = {
					"recordId" : getUrlParam("recordId")
					};
			
			$.ajax({
				type: 'POST',
				url: "./record_detail/record",
				data: dataJson,
				success: getRecordSuccess,
				error: getRecordError,
				dataType:'text'
			});
			
		});
		
		function getRecordSuccess(data,textStatus,jqXHR){
			data=eval('(' + data + ')');
			dataGlobal=data;
			console.log(data);
			content=data.content.split("|").slice(0,-1);
			var cfIndex=data.cfIndex.split(" ");
			for(var i=0;i<cfIndex.length;i++){
				cfIndex[i]=parseInt(cfIndex[i]);
			}
			console.log(cfIndex);
			var doctor="<h3><a target='_blank' href='/MedicalRecord/doctor?id="+data.doctorId+"'>"+data.doctorName+"</a></h3>";
			var body="";
			for (var i=0;i<content.length;i++){
				if(cfIndex.indexOf(i)!=-1) body+="<p class='chufang'>"+content[i]+"</p>";
				else body+="<p>"+content[i]+"</p>";
			}
			var reference="<br/><br/><a href='/MedicalRecord/search/result?wd="+data.reference+"&type=reference'>出自"+data.reference+"</a><br/><br/>"
			var title="";
			title+="<h2>"+data.recordTitle+"</h2>";
			$("#doctor").html(doctor);
			$("#title").html(title);
			$("#content").html(body);
			$("#reference").html(reference);
			
			var hlFlag=getUrlParam("hlFlag");
			if(hlFlag=="1"){
				var hlWords=decodeURI(getUrlParam("hlWords"));
				hlWords=hlWords.split(" ");
				highLight(hlWords);
			}
			
			$(".chufang").live("click",function(){
				var url="/MedicalRecord/pre_analysis?pre="+$(this).text()+"&recordId="+dataGlobal["recordId"]+"&recordTitle="+dataGlobal["recordTitle"]
				window.open(url);
			});

		}
		
		function getRecordError(){
			alert("error");
		}
		
		function highLight(words){
			var content=$("#content").html();
			for(var i=0;i<words.length;i++){
				var word=words[i];
				var reg=new RegExp(word,"g");
				content=content.replace(reg,"<font color='red' style='font-weight:bold' >"+word+"</font>");
			}
			$("#content").html(content);
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
		<div id="underline"></div>
		<div class="clearfix"></div>
		
		<div class="container-fluid ">
				<div class="row-fluid">
					<div class="span12">
						<div id="content_container" class="container-fluid">
							<div id="title">
							</div>
							<div id="doctor">
							</div>
							<div id="content">
							</div>
							<div id="reference">
							</div>
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