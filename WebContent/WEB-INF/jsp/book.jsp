<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html dir="ltr" xml:lang="en-gb" xmlns="http://www.w3.org/1999/xhtml"
	lang="en-gb">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>医案系统</title>
	<!-- js -->
	<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
	<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<!-- exlib -->
	
	<!-- css -->
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	
	
	<style type="text/css">
		.product{
			position: relative;
			float: left;
			padding: 0;
			margin: 0;
			line-height: 1.5;
			overflow: hidden;
			z-index: 1;
			height: 290px;
			margin-left: 8px;
			margin-right: 8px;
		}
		.product-iWrap{
			position: absolute;
			background-color: #fff;
			border-color: #fff;
			margin: 0;
			padding: 10px;
			font-size: 0;
		}
		.hglpic{}
	</style>
		
		
</head>

<BODY>
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

	<div class="container" style="min-height:700px">
		<div class="view" style="margin-bottom:40px;width:1006px;background-color:white;float:left;">
			<div class="product" style="width:150px;float:left;">
				<div class="product-iWrap" style="width:150px;float:left;">
					<!--Image-->
					<div class="hglpic">
						<a href="read?id=1" target="_blank" style="color:#0064A9;">
							<abbr title="点击查看图书">
								<img class="bookimg" src="<%=contextPath%>/resources/book/1/cover.jpg" alt="Loading failure">
							</abbr>
						</a>
					</div>

					<!--Title-->
					<p class="productTitle" style="text-align:left;margin-left:6px;margin-right:6px;">
					<a href="read/" target="_blank" style="color:#0064A9;">
						<abbr title="气血及津液病类">气血及津液病类</abbr>
					</a>
					</p>

					<!--Author-->
					<p class="productAuthor" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;TEXT-ALIGN:left;" onmouseover="this.className='authorEffect'" onmouseout="this.className=''">
						<font size="2">
							<abbr title="鲁兆麟">鲁兆麟</abbr>
						</font>
					</span>
					</p>

					<!--Press-->
					<p class="productPress" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;text-align:left; "> 
						<font size="2">
							<abbr title="中国建材工业出版社">中国建材工业出版社</abbr>
						</font>
					</span>
					</p>
				</div>
			</div>

			<div class="product" style="width:150px;float:left;">
				<div class="product-iWrap" style="width:150px;float:left;">
					<!--Image-->
					<div class="hglpic">
						<a href="read?id=1" target="_blank" style="color:#0064A9;">
							<abbr title="点击查看图书">
								<img class="bookimg" src="<%=contextPath%>/resources/book/1/cover.jpg" alt="Loading failure">
							</abbr>
						</a>
					</div>

					<!--Title-->
					<p class="productTitle" style="text-align:left;margin-left:6px;margin-right:6px;">
					<a href="read/" target="_blank" style="color:#0064A9;">
						<abbr title="气血及津液病类">气血及津液病类</abbr>
					</a>
					</p>

					<!--Author-->
					<p class="productAuthor" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;TEXT-ALIGN:left;" onmouseover="this.className='authorEffect'" onmouseout="this.className=''">
						<font size="2">
							<abbr title="鲁兆麟">鲁兆麟</abbr>
						</font>
					</span>
					</p>

					<!--Press-->
					<p class="productPress" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;text-align:left; "> 
						<font size="2">
							<abbr title="中国建材工业出版社">中国建材工业出版社</abbr>
						</font>
					</span>
					</p>
				</div>
			</div>

			<div class="product" style="width:150px;float:left;">
				<div class="product-iWrap" style="width:150px;float:left;">
					<!--Image-->
					<div class="hglpic">
						<a href="read?id=1" target="_blank" style="color:#0064A9;">
							<abbr title="点击查看图书">
								<img class="bookimg" src="<%=contextPath%>/resources/book/1/cover.jpg" alt="Loading failure">
							</abbr>
						</a>
					</div>

					<!--Title-->
					<p class="productTitle" style="text-align:left;margin-left:6px;margin-right:6px;">
					<a href="read/" target="_blank" style="color:#0064A9;">
						<abbr title="气血及津液病类">气血及津液病类</abbr>
					</a>
					</p>

					<!--Author-->
					<p class="productAuthor" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;TEXT-ALIGN:left;" onmouseover="this.className='authorEffect'" onmouseout="this.className=''">
						<font size="2">
							<abbr title="鲁兆麟">鲁兆麟</abbr>
						</font>
					</span>
					</p>

					<!--Press-->
					<p class="productPress" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;text-align:left; "> 
						<font size="2">
							<abbr title="中国建材工业出版社">中国建材工业出版社</abbr>
						</font>
					</span>
					</p>
				</div>
			</div>

			<div class="product" style="width:150px;float:left;">
				<div class="product-iWrap" style="width:150px;float:left;">
					<!--Image-->
					<div class="hglpic">
						<a href="read?id=1" target="_blank" style="color:#0064A9;">
							<abbr title="点击查看图书">
								<img class="bookimg" src="<%=contextPath%>/resources/book/1/cover.jpg" alt="Loading failure">
							</abbr>
						</a>
					</div>

					<!--Title-->
					<p class="productTitle" style="text-align:left;margin-left:6px;margin-right:6px;">
					<a href="read/" target="_blank" style="color:#0064A9;">
						<abbr title="气血及津液病类">气血及津液病类</abbr>
					</a>
					</p>

					<!--Author-->
					<p class="productAuthor" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;TEXT-ALIGN:left;" onmouseover="this.className='authorEffect'" onmouseout="this.className=''">
						<font size="2">
							<abbr title="鲁兆麟">鲁兆麟</abbr>
						</font>
					</span>
					</p>

					<!--Press-->
					<p class="productPress" style="text-align:left;margin-left:6px;margin-right:6px;">
					<span style="display:inline-block;text-align:left; "> 
						<font size="2">
							<abbr title="中国建材工业出版社">中国建材工业出版社</abbr>
						</font>
					</span>
					</p>
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
</BODY>
</HTML>
