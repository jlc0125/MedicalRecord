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
		<script src="<%=contextPath%>/resources/search/js/csrf.js"></script>
		<script src="<%=contextPath%>/resources/search/js/home.js"></script>
	
		<!-- exlib -->
		<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
		<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
		<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>
		
		
		<!-- css -->	
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap.css">
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap-responsive.css">
		<link rel=stylesheet type=text/css href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/main.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/common.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/Peiwu_analyse.css">
		<LINK rel=stylesheet type=text/css href="<%=contextPath%>/resources/search/css/extra.css">
						
	</head>
	<script type="text/javascript">

	$(function() {

		var checkBox = document.getElementsByName("option");
		for ( var k = 0; k < checkBox.length; k++)
			checkBox[k].checked = false;

		

		$('#front_btn').live(
				'click',
				function() {
					var keyword = $('#front_input').val();
					var range = "";
					var typeIndex = -1;
					for ( var k = 0; k < checkBox.length; k++) {
						if (checkBox[k].checked == true) {
							if (typeIndex == -1)
								typeIndex = k;
							range += "1";
						} else
							range += "0";
					}
					if (typeIndex == -1) {
						typeIndex = 0;
						range = "10"
					}
					window.location.href = "./frontsearch?keyword=" + keyword
							+ "&range=" + range + "&pageno=1" + "&type="
							+ typeEnMap[typeIndex];
				});

		window.location.hash = "#home_type_nav";
	});

	function initFront() {
		getFrontList();
	}


	function getFrontList() {
		
		var type = decodeURI(getUrlParam("type"));
		var dataJson = {
			"wd" : decodeURI(getUrlParam("wd")),
			"type" : type,
			"pageNo" : parseInt(getUrlParam("pageNo")),
			"pageSize" : parseInt(getUrlParam("pageSize")),
		};
		var url = "./retval";
		$.ajax({
			  type: 'POST',
			  url: url,
			  data: dataJson,
			  success: getFrontListSuccessCB,
			  error:getFrontErrorCB,
			  dataType:'text'
			});
	}



	function getFrontListSuccessCB(data,textStatus,jqXHR) {
		var type = decodeURI(getUrlParam("type"));
		console.log(data);
	    data=eval('(' + data + ')');
	    console.log(data);
	    var thead= getTableTitle(type);
		var tbody = getTableBody(data,type);
		
		$("#front_search_list_title").html(thead);
		$("#front_search_list_info").html(tbody);
		console.log(tbody);
		if (parseInt(data.count) <= pageSize)
		{
			$("#front_search_pagincation").hide();
			if(parseInt(data.count)==0)
				getFrontErrorCB();
		}
		else
			$("#front_search_pagincation").pagination(
					{
						items : 100,
						itemsOnPage : pageSize,
						cssStyle : 'light-theme',
						hrefTextPrefix : '#',
						onPageClick : function(pageNumber, event) {
							window.location.href = "./result?wd="
									+decodeURI(getUrlParam("wd"))+"&type="+getUrlParam("type")+"&pageNo="
									+pageNumber+"&pageSize="+getUrlParam("pageSize");

						},
						prevText : "上一页",
						nextText : "下一页",
						currentPage : getUrlParam("pageNo")
					});
	}

	function getFrontErrorCB(){
		
		window.location.href = "./error";
	}
	
	function getTableTitle(type){
		var prefix = "<tr class='success'><th>";
		var suffix = "</th></tr>";
		if(type == "record") 
			return prefix + "医生姓名</th><th>病例名称" + suffix;
	}
	
	function getTableBody(data,type){
		var tbody="";
		for(var i=0;i<data.length;i++){
			if (type=="record"){
				tbody+="<tr><td><a href='#'>"+data[i].doctorName +"</a></td><td><a href='#'>"+data[i].recordTitle+"</a></td></tr>";
			}
			if (type=="doctor"){
				
			}
		}
		return tbody;
	}
	</script>
	
	
	
	
	<body onload="initFront()">
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
	    	    	<A href="home" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A>
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
				<a href="front"><span id="nav_qwss" class="sub_nav_span"></span></a>
				<a href="classifybrowse"><span id="nav_flll" class="sub_nav_span"></span></a>
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
				<div class="row-fluid">
					<div class="span12">
						<div class="tabbable tabs-left">
							<div class="tab-content span9">
								<div class="tab-pane active" id="front_search_list">
										<table class="table " id="front_search_table">
											<thead id="front_search_list_title"></thead>
											<tbody id="front_search_list_info"></tbody>
										</table>
								</div>
	
							</div>
						</div>
						<div id="front_search_pagincation" class="rs_pagincation"></div>
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