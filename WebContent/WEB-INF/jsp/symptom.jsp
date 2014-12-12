<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>中草药基础知识搜索系统</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/reset.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/detail.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/nav_header.css"></link>
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/footer.css"></link>
	
	<!-- js -->
	<script type="text/javascript" src="resources/d3js/d3.min.js"></script>
	<script type="text/javascript" src="resources/common/jquery_1_8_3.js"></script>
	<script type="text/javascript" src="resources/recipe/js/easyTabs.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery.pajinate.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/graph_new.js"></script>
	<script type="text/javascript" src="resources/recipe/js/tagscloud_new.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			tagscloud("#tagscloud", "symptom");
			
			$('#container').easyTabs({defaultContent:1});
			
			var symptomName = $("#front_input").val();
			if(symptomName != ''){
				var url = "symptom/search?q=" + symptomName;
				d3.json(url, function(error, root) { 
					if(error){
						$(".graph").prepend("div").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
					}
					else{
						graph("#component .graph", root.drug);
						graph("#attending .graph", root.symptom);
						graph("#similar .graph", root.recipe);		
					}
				});
			}
			
			$("#search_cf").submit(function(){
				var value = $("#front_input").val();
				$(".graph").empty();
				if(value != ''){
					var url = "symptom/search?q=" + value;
					d3.json(url, function(error, root) { 
						if(error){
							$(".graph").prepend("div").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						}
						else{
							$("#tagscloud ul").empty();
							var drugs = root.drug.children;
							var htl = '';
							for(var i=0; i<drugs.length; i++){
								htl += '<li><a href="">' + drugs[i].name + '</a></li>';
							}
							$("#tagscloud ul").html(htl);
							tagscloud("#tagscloud", "symptom");
							graph("#component .graph", root.drug);
							graph("#attending .graph", root.symptom);
							graph("#similar .graph", root.recipe);		
						}
					});
				}
				return false;
			});
			
			$("#front_input").autocomplete({
				autoFocus: true,
				minLength: 1,
				source: function(request, response) {
					var url = "symptom/hint?q=" + request.term;
					$.get(url, function(data, status){
						response(data);
					});
				 }
			});
			
        });
	</script>
</head>

<body>
	<div class=top>
		<div id="common_nav">
			<div class="cf" id="common_nav_L2">
				<ul>
					<li> <a title="注册" href="/tcm/user/registerpage" rel="nofollow">注册</a> </li>
					<li> <a title="登录" href="/tcm/user/loginpage" rel="nofollow">登录</a>  </li>
					<li> <a title="帮助中心" href="javascript:void(0);" rel="nofollow">帮助中心</a> </li>
					<li> <a title="知识中心导航" href="javascript:void(0);" rel="nofollow">知识中心导航</a> </li>
					<li> <a title="知识中心首页" href="http://www.udms.org/ckcest/" rel="nofollow">知识中心首页</a> </li>
					<li> <a class="current" title="中草药系统首页"  href="/tcm" rel="nofollow">中草药系统首页</a> </li>
				</ul>
			</div>
		</div>
		
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo">
					<a href="home" target=_blank><img src="resources/recipe/image/logo.png"></a>
				</div>
			</div>
		</div>
	</div>

	<div class="bg_heise">
		<div class="imgFrame">
			<a href="symptomhome"><img src="resources/recipe/image/r_125.png" /></a>
		</div>
		
		<div class="logoSearch_L2">
			<form id="search_cf" class="search cf" >
				<input id="front_input" class="text" type="text" maxLength="20" value="${symptomName}"> 
				<input class="button" id="front_btn" type="submit" value=""> <br>
			</form>
			<div id="tagscloud">
				<ul>
				<c:forEach var="item" items="${name}">
					<li><a href=""><c:out value="${item}"></c:out></a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
		
		<div id="container">
			<ul class="tabs">
		  	<li><a href="#attending">相关疾病</a></li>
		  	<li><a href="#component">相关中药</a></li>
		  	<li><a href="#similar">相关方剂</a></li>
		 </ul>
	
    <div id="main_content">
    <div id="attending">
    		<div class="graph">
    		</div>
     </div>
     
    	<div id="component">
    		<div class="graph">
    		</div>
     </div>
     
     <div id="similar">
    		<div class="graph">
    		</div>
			</div>
    </div>
    <div id="sidebar">
    	<div class="alt_container">
				<h2>相关医案</h2>
				<div class="alt_page_navigation"></div>	
				<div class="alt_info_text"></div>
				<ul class="alt_content"></ul>
			</div>    
    </div>
    <div class="clearfix"></div>
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