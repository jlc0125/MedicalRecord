<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>中草药基础知识搜索系统</title>
	
	<!-- js -->
	<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
	<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<!-- exlib -->

	<!-- css -->
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/reset.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/home.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/nav_header.css"></link>
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/footer.css"></link>
	
	<!-- js -->
	<script type="text/javascript" src="resources/common/d3.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery.pajinate.min.js"></script>
	
	<style type="text/css">
		.search-div{
			padding-top: 5%;
			font-size: 14px;
		}
		.search-input{
			line-height: 20px;
			width: 580px;
			padding: 10px 9px 10px 7px;
			vertical-align: middle;
			font-size: 16px;
			box-shadow: 0 1px 3px rgba(0,0,0,0.2);
		}
		.search-btn{
			height: 46px;
			line-height: 40px;
			font-size: 16px;
			padding: 0;
			margin: 0;
			width: 104px;
		}
		.center{
			text-align: center
		}
		.search-logo{
			padding-top: 80px;
			padding-bottom: 50px;
    	}
    	
    	
		.right-list{
			padding: 0 !important;
			box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
			height: 700px;
			overflow: auto;
		}
		
		.right-list .nav li{
			width: 50%;
			text-align: center;
			font-size: 18px;
		}

		.right-list ol li{
			text-align: center;
			padding-top: 10px;
			padding-bottom: 10px;
			font-size: 16px;
			
		}
		.right-list ol .odd{
			background-color: #E5EBF1;
		}

		.table tbody td{
			font-family: "微软雅黑";
			line-height: 20px;
			height:80px;
			vertical-align: middle !important; 
			text-align: center;
			font-size: 15px;
			border-top: 1px solid #dddddd;
			padding: 8px;
			background-color:white;
			
		}
		.table thead tr th {
			font-family: "微软雅黑";
			vertical-align: middle;
			text-align: center;
			height:80px;
			color: #555555;
			font-size: 18px;
			background-color:white;
		}

		.search-result{
			padding-top: 5%;
			padding-left: 25%;
			padding-right: 25%;
		}

		.search-result table{
			width: 100%;
			box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
		}
		
		.search-result table th, .search-result table td{
			text-align: center !important;
		
		}

	</style>



	<script type="text/javascript">
		
		function getByFrequence(order){
			var url = "symptom/pinci?q=" + order;
			$.get(url, function(data, status){
				try{
					if(!data) return;
					var listContent = $(".right-list-content");
					listContent.empty();
					var count = 0;
					data.forEach(function(recipe){
						count +=1;
						var label = "";
						if(count % 2 == 0){
							label = "even";
						}
						else{
							label = "odd";
						}

						var html = "<li class='" + label + "'>" + recipe.name +"</li>";
						
						listContent.append(html);
					});
				}
				catch(err){
					console.log(err);
				}
			});
		}

		function getByAlphabet(str){
			var url = "symptom/pinyin?q=" + str;
			$.get(url, function(data, status){
				try{
					if(!data) return;
					var listContent = $(".right-list-content");
					var count = 0;
					data.forEach(function(recipe){
						count +=1;
						var label = "";
						if(count % 2 == 0){
							label = "even";
						}
						else{
							label = "odd";
						}

						var html = "<li class='" + label + "'>" + recipe.name +"</li>";
						
						listContent.append(html);
					});
				}
				catch(err){
					
				}
			});
		}

		function initAlphabet(){
			try{
				var listContent = $(".right-list-content");
				listContent.empty();
				var count = 0;
				alphabetList=['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
				alphabetList.forEach(function(alp){
					count +=1;
					var label = "";
					if(count % 2 == 0){
						label = "even";
					}
					else{
						label = "odd";
					}

					var html = "<li class='alphabet " + label + "'>" + alp +"</li>";
					
					listContent.append(html);
				});
				$('.alphabet').click(function(event){
					console.log(event);
					var target = event.target;
					listContent.empty();
					listContent.append(target);
					target = listContent.children()[0];
					console.log(target);
					$(target).click(function(event){
						initAlphabet();
					})
					getByAlphabet(target.textContent);
				})
			}
			catch(err){
				
			}
		}

		function search(query, option){
			var url = "symptom?q=" + query + "&option=" + option;
			$.get(url, function(data, status){
				$(".search-logo").css("display", "none");
				if(!data) return;
				console.log(data);
				var html = "";
				data.forEach(function(recipe){
					html += "<tr><td>" + recipe.name + "</td><td>" + recipe.pinci + "</td></tr>";
				});
				$(".search-result > table > tbody").html(html);
				$(".search-result").css("display","block");
			})

		}

		$(document).ready(function(){

			getByFrequence(0);
			var nav1 = $(".right-list-nav > li:first-child");
			var nav2 = $(".right-list-nav > li:last-child");
			nav1.click(function(event){
				nav2.removeClass("active");
				nav1.addClass("active");
				getByFrequence(0);
			});

			nav2.click(function(event){
				nav1.removeClass("active");
				nav2.addClass("active");
				initAlphabet();
			});

			$(".search-btn").click(function(){
				var query = $(".search-input").val();
				var option;
				if($(".analysis-checkbox > input:first-child")[0].checked){
					option = 1;
				}
				else if($(".analysis-checkbox > input:last-child")[0].checked){
					option = 2;
				}
				else{
					alert("请选择“相关”搜索选项");
				}
				search(query,option);
			})

			$(".search-input").on("keydown",function(event){
				if(event.keyCode == 13){
					var query = $(".search-input").val();
					var option;
					if($(".analysis-checkbox > input:first-child")[0].checked){
						option = 1;
					}
					else if($(".analysis-checkbox > input:last-child")[0].checked){
						option = 2;
					}
					else{
						alert("请选择“相关”搜索选项");
					}
					search(query,option);
				}
			})


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
		
		
	</div>
	<div class="col-md-2" stype="height:100%">
		<ul class="nav nav-pills nav-stacked">
			<li role="presentation">
				<div class="fill" style="background-image:url('http://placehold.it/300x199&amp;text=方剂分析');height:233px"></div>
			</li>
			<li role="presentation" class="active">
				<div class="fill" style="background-image:url('http://placehold.it/300x199&amp;text=中药分析');height:233px"></div>
			</li>
			<li role="presentation" class="active">
				<div class="fill" style="background-image:url('http://placehold.it/300x199&amp;text=疾病分析');height:233px"></div>
			</li>
		</ul>
		
	</div>

	<div class="col-md-8" style="min-height:700px">
		
		<div class="search-logo center">
			<a href="analysishome"><img src="resources/recipe/image/r_122.png" /></a>
		</div>
		
		<div class="search-div center">
			<div id="search" class="search">
				<input id="analysis-search-input" class="text search-input" maxLength="50" > 
				<button class="btn btn-primary search-btn" id="analysis-search-btn">分析</button>
				<br>
				<br>
				<div class="analysis-checkbox" id="option">相关：&nbsp; 
					<input type="checkbox" class="option" id="symptom-opt">中药&nbsp;&nbsp;
					<input type="checkbox" class="option" id="recipe-opt">方剂&nbsp;&nbsp;
				</div>
			</div>
		</div>

		<div class="search-result" style="display:none">
			<table class="table">
				<thead>
					<tr>
						<th>相关疾病</th>
						<th>共生频次</th>
					</tr>
				</thead>
				<tbody>
					
					
				</tbody>
			</table>
		</div>
		

		

	</div>

	<div class="col-md-2 right-list">
		<!--
		<div class="fill" style="background-image:url('http://placehold.it/1000x700&amp;text=频次排序');height:700px"></div>
		-->
		<ul class="nav nav-tabs right-list-nav">
			<li role="presentation" class="active"><a>常见方剂</a></li>
			<li role="presentation"><a>字母排序</a></li>
		</ul>
		<ol class="right-list-content">
			
		</ol>
	</div>
	<!-- footer -->
	<div>
    <div class="footer col-md-12" style="margin-bottom:0px;">
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