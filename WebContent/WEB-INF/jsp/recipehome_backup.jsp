<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>中草药基础知识搜索系统</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/reset.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/home.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/nav_header.css"></link>
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/footer.css"></link>
	
	<!-- js -->
	<script type="text/javascript" src="resources/common/d3.min.js"></script>
	<script type="text/javascript" src="resources/common/jquery_1_8_3.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery.pajinate.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#front_input").autocomplete({
				autoFocus: true,
				minLength: 1,
				source: function(request, response) {
					var url;
					if($('input:radio:checked').val() == "1")
						url = "symptom/hint?q=" + request.term;
					else if($('input:radio:checked').val() == "2")
						url = "drug/hint?q=" + request.term;
					else
						url = "recipe/hint?q=" + request.term;
					$.get(url, function(data, status){
						response(data);
					});
				 }
			});
			
			function page(str){
				var url = "recipe/pinyin?q=" + str;
				$.get(url, function(data, status){
					var txt = "";
					for(var i=0; i<data.length; i++){
						txt += '<li><form method="post" action="recipe" target="_blank"><input type="hidden" name="q" value="' + data[i].name + '"><input type="hidden" name="option" value="0"><a href="#" onclick="javascript:$(this).parent().submit();return false;"><div>' + data[i].name + '</div><div>' + data[i].pinci + '</div></a></form></li>';
					}
					if(txt != ""){
						$(".alt_content").html(txt);
						$(".alt_content").css("border","1px solid #DB5C04");
					}
					else{
						$(".alt_content").html('<div class="noResult">很抱歉，没有相关的方剂。</div>');
					}
					$('.alt_container').pajinate({
						items_per_page : 8,
						item_container_id : '.alt_content',
						nav_panel_id : '.alt_page_navigation',
						nav_label_first : '<<',
						nav_label_last : '>>',
						nav_label_prev : '<',
						nav_label_next : '>'
				      });
				});
			}
			
			function page2(str){
				var url = "recipe/pinci?q=" + str;
				$.get(url, function(data, status){
					var txt = "";
					for(var i=0; i<data.length; i++){
						txt += '<li><form method="post" action="recipe" target="_blank"><input type="hidden" name="q" value="' + data[i].name + '"><input type="hidden" name="option" value="0"><a href="#" onclick="javascript:$(this).parent().submit();return false;"><div>' + data[i].name + '</div><div>' + data[i].pinci + '</div></a></form></li>';
					}
					if(txt != ""){
						$(".alt_content2").html(txt);
						$(".alt_content2").css("border","1px solid #DB5C04");
					}
					else{
						$(".alt_content2").html('<div class="noResult">很抱歉，没有相关的方剂。</div>');
					}
					$('.alt_btns').pajinate({
						items_per_page : 8,
						num_page_links_to_display : 16,
						item_container_id : '.alt_content2',
						nav_panel_id : '.alt_page_navigation2',
						nav_label_first : '<<',
						nav_label_last : '>>',
						nav_label_prev : '<',
						nav_label_next : '>'
				      });
				});
			}
			
			page("a");
			
			var label= $('.label');
			var content= $('.content');
			
			$(content).hide();
			$('.content:first').show();
			$('.label h5').addClass('default');
			$('.label:first h5').addClass('clicked');
			
			$("#label1").on("click", function(){
				var tLabel = $(this);
				var tLabelColor = $(this).find('h5');
				var tContent = $(this).next('.content');
				
				$(content).hide();
				$(tContent).show();
					
				$('.label h5').removeClass('clicked');
				$(tLabelColor).addClass('clicked');
			});
			
			var label2_click = 0;
			$("#label2").on("click", function(){
				var tLabel = $(this);
				var tLabelColor = $(this).find('h5');
				var tContent = $(this).next('.content');
				
				$(content).hide();
				$(tContent).show();
					
				$('.label h5').removeClass('clicked');
				$(tLabelColor).addClass('clicked');
				
				if(label2_click == 0)
					page2("0");
				label2_click++;
			});
			
			$(label).hover(function(){
				var tLabelColor = $(this).find('h5');
				$(tLabelColor).addClass('hover');
			}, function(){
				$('.label h5').removeClass('hover');
			});
			
			$(".wrapper_label a").click(function(){
				$(".wrapper_label a.current").removeClass("current");
				$(this).addClass("current");
				page($(this).text().toLowerCase());
				return false;
			});
			
			$("#alt_button1").on("click", function(){
				$('.alt_button').removeClass('visited');
				$(this).addClass('visited');
				page2("0");
			});
			
			$("#alt_button2").on("click", function(){
				$('.alt_button').removeClass('visited');
				$(this).addClass('visited');
				page2("1");
			});
			
        });
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
		
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo">
					<a href="index.html" target=_blank><img src="resources/recipe/image/logo.png"></a>
				</div>
			</div>
		</div>
	</div>

	<div class="bg_heise">
		<div class="imgFrame">
			<a href="analysishome"><img src="resources/recipe/image/r_122.png" /></a>
		</div>
		
		<div class="logoSearch_L2">
			<form id="search_cf" class="search cf" method="post" action="recipe">
				<input id="front_input" class="text" type="text" name="q" value="${searchName}"> 
				<input class="button" id="front_btn" type="submit" value="">
				<div class="clearfix"></div>
				<div class="checkboxes">搜索选项：&nbsp; 
					<c:choose>
						<c:when test="${option == 1}">
							<input type="radio" name="option" value="0">方剂&nbsp;&nbsp;
							<input type="radio" name="option" value="1"   checked>疾病&nbsp;&nbsp;
							<input type="radio" name="option" value="2">中药&nbsp;&nbsp;
						</c:when>
						<c:when test="${option == 2}">
							<input type="radio" name="option" value="0">方剂&nbsp;&nbsp;
							<input type="radio" name="option" value="1">疾病&nbsp;&nbsp;
							<input type="radio" name="option" value="2"  checked>中药&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<input type="radio" name="option" value="0" checked>方剂&nbsp;&nbsp;
							<input type="radio" name="option" value="1">疾病&nbsp;&nbsp;
							<input type="radio" name="option" value="2">中药&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					<c:if test="${error == 1}">
	  					<div class="errinfo">抱歉，没有找到相关的方剂，请重新输入！</div>
					</c:if>
				</div>
			</form>
		</div>
	</div>

	<c:choose>
		<c:when test="${option == 1}">
			<div class="relate_recipe">
				<div class="relate_wrap">
					<div class="relate_info">相关方剂</div>
					<c:choose>
						<c:when test="${noResult == 1}">
							<div class="noResultInfo">抱歉，没有找到相关的方剂，请重新输入！</div>
						</c:when>
						<c:otherwise>
							<table class="relate_table">
								<thead>
									<tr>
										<th>序号</th>
										<th>方剂名称</th>
										<th>共生频次</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="node" items="${nodes}">
										<tr>
											<td>${node.index}</td>
											<td>
												<form method="post" action="recipe" target="_blank">
													<input type="hidden" name="q" value="${node.name}">
													<input type="hidden" name="option" value="0">
													<a href="#" onclick="javascript:$(this).parent().submit();return false;">${node.name}</a>
												</form>
											</td>
											<td>${node.pinci}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:when>
		<c:when test="${option == 2}">
			<div class="relate_recipe">
				<div class="relate_wrap">
					<div class="relate_info">相关方剂</div>
					<c:choose>
						<c:when test="${noResult == 1}">
							<div class="noResultInfo">抱歉，没有找到相关的方剂，请重新输入！</div>
						</c:when>
						<c:otherwise>
							<table class="relate_table">
								<thead>
									<tr>
										<th>序号</th>
										<th>方剂名称</th>
										<th>共生频次</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="node" items="${nodes}">
										<tr>
											<td>${node.index}</td>
											<td>
												<form method="post" action="recipe" target="_blank">
													<input type="hidden" name="q" value="${node.name}">
													<input type="hidden" name="option" value="0">
													<a href="#" onclick="javascript:$(this).parent().submit();return false;">${node.name}</a>
												</form>
											</td>
											<td>${node.pinci}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:when>
	</c:choose>

	<div id="vtabs">
		<div class="container">
			<div class="label" id="label1">
      			<h5>按首字母排序</h5>
    		</div>
    	
	    	<div class="content">
	      		<div id="content_label">
	      			<div class="wrapper_label">
		      			<a href="#" class="current">A</a>
						<a href="#">B</a>
						<a href="#">C</a>
						<a href="#">D</a>
						<a href="#">E</a>
						<a href="#">F</a>
						<a href="#">G</a>
						<a href="#">H</a>
						<a href="#">I</a>
						<a href="#">J</a>
						<a href="#">K</a>
						<a href="#">L</a>
						<a href="#">M</a>
					</div>
					<div class="wrapper_label">
						<a href="#">N</a>
						<a href="#">O</a>
						<a href="#">P</a>
						<a href="#">Q</a>
						<a href="#">R</a>
						<a href="#">S</a>
						<a href="#">T</a>
						<a href="#">U</a>
						<a href="#">V</a>
						<a href="#">W</a>
						<a href="#">X</a>
						<a href="#">Y</a>
						<a href="#">Z</a>
					</div>
				</div>
			
	      		<div class="alt_container">
	      			<div class="alt_head">方剂名</div>
	      			<div class="alt_head">出现频次</div>
					<ul class="alt_content"></ul>
					<div class="alt_page_navigation"></div>
	      		</div>
	    	</div>
		</div>
		
		<div class="container">
			<div class="label" id="label2">
      			<h5>按出现频次排序</h5>
    		</div>
    		
    		<div class="content">
    			<div class="alt_btns">
	    			<div class="alt_head"><div id="alt_button1" class="alt_button visited">降序排列</div></div>
	      			<div class="alt_head"><div id="alt_button2" class="alt_button">升序排列</div></div>
	      			<ul class="alt_content2"></ul>
					<div class="alt_page_navigation2"></div>
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