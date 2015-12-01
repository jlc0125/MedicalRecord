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
        <link rel="stylesheet" type="text/css" href="/MedicalRecord/resources/test2/css/style.css" />
        <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/modernizr.custom.08464.js"></script>
		<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
		<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test2/js/jquery.tmpl.min.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test2/js/jquery.history.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test2/js/core.string.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test2/js/jquery.touchSwipe-1.2.5.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test2/js/jquery.flips.js"></script>

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

    	
		<div class="board" style="width:1920px;height:900px">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div id="flip" class="container">
				
					<div class="f-page">
						<div>
							<img src="/MedicalRecord/resources/book/1/00000001.jpg" style="width:600px;height:800px">
						</div>
						
					</div>
					
					<div class="f-page">
						<div>
							<img src="/MedicalRecord/resources/book/1/00000002.jpg" style="width:600px;height:800px">
							<img src="/MedicalRecord/resources/book/1/00000003.jpg" style="width:600px;height:800px">
						</div>
					</div>
					
					
				</div>
			</div>
			<div class="col-md-2"></div>
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

			var $container 	= $( '#flip' ),
				$pages		= $container.children().hide();

			function addPage(startPageNo, endPageNo){
				var i = startPageNo;
				while(i < endPageNo){					
					var fileName1 = "00000000" + i;
					fileName1 = fileName1.substring(fileName1.length-8, fileName1.length);

					i++;
					var fileName2 = "00000000" + i;
					fileName2 = fileName2.substring(fileName2.length-8, fileName2.length);
					i++;

					var html = "<div class='f-page'>\
									<div>\
										<img src='/MedicalRecord/resources/book/1/" + fileName1 + ".jpg' style='width:600px;height:800px'>\
										<img src='/MedicalRecord/resources/book/1/" + fileName2 + ".jpg' style='width:600px;height:800px'>\
									</div>\
								</div>"
					$container.append(html);
				}
				$container.flips();
			};

			var i = 3;
			while(i < 10){
				console.log(i);
				setTimeout(addPage(i,i+10),2000);
				i+=10;
			}
			
				
		</script>
    </body>
</html>