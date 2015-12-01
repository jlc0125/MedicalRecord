<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <title>医案系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"> 
        
        <meta name="keywords" content="flip, pages, flipboard, layout, responsive, web, web design, grid, ipad, jquery, css3, 3d, perspective, transitions, transform" />
        <meta name="author" content="" />
		<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300,300italic' rel='stylesheet' type='text/css'> -->
        <!-- <link rel="stylesheet" type="text/css" href="/MedicalRecord/resources/test/css/demo.css" /> -->
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/modernizr.custom.08464.js"></script>
		<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
		<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.tmpl.min.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.history.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/core.string.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.touchSwipe-1.2.5.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.flips.js"></script>
		
		

        <link rel="stylesheet" type="text/css" href="/MedicalRecord/resources/test/css/style.css" />
        <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	

		<script id="pageTmpl" type="text/x-jquery-tmpl">
			<div class="{{= theClass}}" style="{{= theStyle}}">
				<div class="front">
					<div class="outer">
						<div class="content" style="{{= theContentStyleFront}}">
							<div class="inner">{{html theContentFront}}</div>
						</div>
					</div>
				</div>
				<div class="back">
					<div class="outer">
						<div class="content" style="{{= theContentStyleBack}}">
							<div class="inner">{{html theContentBack}}</div>
						</div>
					</div>
				</div>
			</div>			
		</script>

		<script id="commentTmpl" type="text/x-jquery-tmpl">
			<dl class="clearfix">
				<dt class="user-logo">
					<a href="#" title="{{= userName}}" target="_blank"><img src="{{= userProfile}}" alt="{{= userName}}" width="58" height="58">{{html userName}}</a>
				</dt>
				<dd class="txt">
					<p>{{html content}}</p>  
				</dd>
			</dl>
		</script>
		
		<style type="text/css">
			.right-list{
				padding: 0 !important;
				box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
				height: 800px;
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

			.short-comm dl{
			    border-bottom: 1px solid #eee;
			    padding-top: 20px;
			    display: block;
			    
			    padding-bottom: 20px;
		    }
		    .user-logo{
		    	float: left;
				width: 60px;
				padding-top: 4px;
				line-height: 18px;
				font-size: 12px;
				margin-right: 20px;
				
		    }
		    .short-comm dt{
		    	font-weight: normal;!important
		    }
		</style>


    </head>
    <body>
    	<div class=top>
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
			
		</div>

    	
		<div class="board" style="width:1920px;  height:900px;  padding-top:2%">
			<div class="col-md-1"></div>
			<div class="col-md-8" style="">
				<div id="flip" class="container" >
									
				</div>
			</div>
			<div class="col-md-3">
				<div class="catalog right-list">
					<p style= "    text-align: center; font-size: 20px; font-weight: bold; padding-top: 2%;">目录</p>
					<ol class="right-list-content" style="list-style-type:none; padding:0px">
						<li class="odd"><a href="read?page=4">郁证</a></li>
						<li class="even"><a href="read?page=17">瘀症</a></li>
						<li class="odd"><a>厥证</a></li>
						<li class="even"><a>脱症</a></li>
						<li class="odd"><a>水肿</a></li>
						<li class="even"><a>汗症</a></li>
						<li class="odd"><a>痰饮</a></li>
						<li class="even"><a>消渴</a></li>
						<li class="odd"><a>积聚</a></li>
						<li class="even"><a>虚劳</a></li>
						<li class="odd"><a>内伤发热</a></li>
						<li class="even"><a>麻木</a></li>
						<li class="odd"><a>咳血</a></li>
						<li class="even"><a>吐血</a></li>
						<li class="odd"><a>衄血</a></li>
						<li class="even"><a>下血</a></li>
						<li class="odd"><a>溺血</a></li>
						<li class="even"><a>便血</a></li>
						<li class="odd"><a>尿血</a></li>
						<li class="even"><a>紫斑</a></li>
						<li class="odd"><a>痛痹</a></li>
						<li class="even"><a></a></li>
						<li class="odd"><a>臁疮</a></li>
						<li class="even"><a>火热</a></li>
						<li class="odd"><a>痰</a></li>
						<li class="even"><a></a></li>
						<li class="odd"><a>积块</a></li>
						<li class="even"><a>虚损</a></li>


					</ol>
				</div>
			</div>
		</div>
		<div class ="comm" style = "width:100%; border-top-style: solid">
			<div class="comm-input-div" style="margin-left:10%; width:80%; margin-top:2%">
				<textarea class="comm-input" style="width:100%;height:100px"></textarea>
				<button class="btn btn-primary comm-input-btn" style="margin-left: 96.5%" >评论</button>
			</div>
			<div class="short-comm" style="overflow:auto;height:650px; margin-left:10%">
			</div>
		</div>
		<!-- footer -->
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
		
		<script type="text/javascript">
			
			var batchStart = 0;
			var batchEnd = 1;
			var count = 0;
			// var setLayout = function(){
			// 	var currentPage = parseInt(window.History.getState().url.queryStringToJSON().page);
			// 	var $container 	= $( '#flip' );
			// 	if(currentPage%10 > 8) {
					
			// 		if(Math.floor(currentPage/10) == batchEnd - 1){
			// 			console.log('---------main--------');
			// 			console.log(Math.floor(currentPage/10), batchEnd);
			// 			batchEnd ++;
			// 			$container.flips({pagesCount:100, nextPage:(batchEnd-1)*20-1, batchSize:20});		
						
			// 		}
			// 		else{
			// 			return false;
			// 		}
			// 	}

			// }

			var setLayout = function(page){
				var $container 	= $( '#flip' );
				if(!page){
					var page = parseInt(window.History.getState().url.queryStringToJSON().page);
				}
				$container.flips({pagesCount:100, current: page , batchSize:20});
			}



			// var $container 	= $( '#flip' );
			// $container.flips({pagesCount:100, nextPage:0, batchSize:20});

			// $container.on("DOMSubtreeModified",setLayout);
				
			$(function(){
				setLayout();
				getComment();
			})

			window.onpopstate = function(event){
				getComment();
			}

			function getComment(){
				$(".short-comm").empty();
				dataJson = {
					bid : 1,
					page : parseInt(window.History.getState().url.queryStringToJSON().page)
				}

				url = "read/get_comment";
				$.ajax({
				  type: "GET",
				  url: url,
				  data: dataJson,
				  success: successCB,
				  error: errorCB,
				  dataType:"text"
				});

				function successCB(data,textStatus,jqXHR){
					data=eval('(' + data + ')');
					// console.log(data.length);
					
					data.forEach(function(record){
						comment = {
							userName: "内测用户",
							userProfile: "resources/profile/1.jpg",
							content: record.content
						}

						$( '#commentTmpl' ).tmpl( comment ).appendTo($(".short-comm"));
					});
				}

				function errorCB(){
					console.log("error");
				}
			}

			function postComment(){
				
				dataJson = {
					cont : $(".comm-input").val(),
					uid : 1,
					bid : 1,
					page : parseInt(window.History.getState().url.queryStringToJSON().page)
				}

				url = "read/post_comment";
				$.ajax({
				  type: "POST",
				  url: url,
				  data: dataJson,
				  success: successCB,
				  error: errorCB,
				  dataType:"text"
				});

				function successCB(data,textStatus,jqXHR){
					
					getComment();
					$(".comm-input").val("");
				}

				function errorCB(){
					console.log("error");
				}
			}

			$(".comm-input-btn").on("click",postComment);
			
				
		</script>
    </body>
</html>