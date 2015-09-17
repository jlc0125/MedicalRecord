<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>中草药基础知识搜索系统</title>
	
	<!-- css -->
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/recipe/css/recipe.css">
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/footer.css"></link>
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/recipe/css/jquery-ui.css">
	
	<!-- js -->
	<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/resources/recipe/js/jquery-ui.min.js"></script>
	<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/resources/common/d3.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/resources/recipe/js/graph_recipe.js"></script>
	
	<script type="text/javascript">
		$(function(){
			var recipeName = "安崩汤";
			if(recipeName != ''){
				var url = "<%=contextPath%>/recipe/search?q=" + recipeName;
				d3.json(url, function(error, root) { 
					if(error){
						$("#graph1").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						$("#graph2").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
					}
					else{
						graph("#graph-left", root.drug, 500, 1, 1);
						graph("#graph-right", root.zucheng, 500, 1, 0);
						$("#zc_chuchu").text("出自" + root.chuchu_zc);
						graph("#graph3", root.symptom, 450, 0, 1);
					}
				});
			}
		})
		// $(document).ready(function(){
		// 	$('#container').easyTabs({defaultContent:1});
			
		// 	var recipeName = $("#front_input").val();
		// 	if(recipeName != ''){
		// 		var url = "recipe/search?q=" + recipeName;
		// 		d3.json(url, function(error, root) { 
		// 			if(error){
		// 				$("#graph1").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
		// 				$("#graph2").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
		// 				$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
		// 			}
		// 			else{
		// 				graph("#graph1", root.drug, 300, 1, 1);
		// 				graph("#graph2", root.zucheng, 300, 1, 0);
		// 				$("#zc_chuchu").text("出自" + root.chuchu_zc);
		// 				graph("#graph3", root.symptom, 450, 0, 1);
		// 			}
		// 		});
		// 	}
			
		// 	$("#search_cf").submit(function(){
		// 		var value = $("#front_input").val();
		// 		$("svg").remove();
		// 		$("#zc_chuchu").empty();
		// 		$(".errorhit").empty();
		// 		if(value != ''){
		// 			var url = "recipe/search?q=" + value;
		// 			d3.json(url, function(error, root) { 
		// 				if(error){
		// 					$("#graph1").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
		// 					$("#graph2").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
		// 					$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
		// 				}
		// 				else{
		// 					graph("#graph1", root.drug, 300, 1);
		// 					graph("#graph2", root.zucheng, 300, 1);
		// 					$("#zc_chuchu").text("出自" + root.chuchu_zc);
		// 					graph("#graph3", root.symptom, 500, 0);
		// 				}
		// 			});
		// 		}
		// 		return false;
		// 	});
			
		// 	$("#front_input").autocomplete({
		// 		autoFocus: true,
		// 		minLength: 1,
		// 		source: function(request, response) {
		// 			var url = "recipe/hint?q=" + request.term;
		// 			$.get(url, function(data, status){
		// 				response(data);
		// 			});
		// 		 }
		// 	});
			
  //       });
	</script>
</head>

<body>
	<div class=top>
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
		

	<div class="container" style="min-height:700px">
		
			<ul class="nav nav-tabs analysis-result-nav">
				<li role="presentation" class="active"><a>相关中药</a></li>
				<li role="presentation"><a>相关疾病</a></li>
			</ul>
			<div class="analysis-result">
				<div class="analysis-result-left" style="float:left;width:50%">
					<div id="graph-left">
					</div>

				</div>
				<div class="analysis-result-rights" style="float:left;width:50%">
					<div id="graph-right">
					</div>
				</div>
			</div>
   		
	</div>


	<!-- footer -->
	<div>
    <div class="footer" style="margin-bottom:0px;">
           <div class=footer_L2>
               <div class="footer_about cf">
                   <dl class="dlLeft">
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

                   <dl class="dlLeft">
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

                   <dl class="dlLeft">
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

               <div class="footer_links">
                   <span class="footer_links_title">友情链接：</span> 
                   <span class="footer_links_list"> 
                       <a href="" target="_blank">药典</a> 
                       <a href="" target="_blank">中医论坛</a> 
                       <a href="" target="_blank">中草药知识库</a>
                       <a href="" target="_blank">中医养生</a> 
                       <a href="" target="_blank">方剂库</a>
                       <a href="" target="_blank">药剂库</a> 
                       <a href="" target="_blank">中药知识大全</a>
                   </span>
               </div>

               <div class="footer_copy">
                   <div class="footer_copy_right">
                       <p>地址：北京市西城区冰窖口胡同2号</p>
                       <p>Copyright ? 2008 中国工程院 ICP备案号:京ICP备05023557号</p>
                   </div>
               </div>
           </div>
       </div>
	</div>
</body>
</html>