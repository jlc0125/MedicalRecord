<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>中草药基础知识搜索系统</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/recipe/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/recipe/css/cslider.css">
	<link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/recipe/css/analysishome.css">
	<link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/commonpages/css/nav_header.css"></link>
	<link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/commonpages/css/footer.css"></link>
	
	<!-- js -->
	<script type="text/javascript" src="${initParam.resources}/resources/common/jquery_1_8_3.js"></script>
	<script type="text/javascript" src="${initParam.resources}/resources/recipe/js/modernizr.custom.28468.js"></script>
	<script type="text/javascript" src="${initParam.resources}/resources/recipe/js/jquery.cslider.js"></script>
	<script type="text/javascript">
			$(document).ready(function() {
				$('#da-slider').cslider({
					autoplay	: true,
					bgincrement	: 450
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
					<a href="index.html" target=_blank><img src="${initParam.resources}/resources/recipe/image/logo.png"></a>
				</div>
			</div>
		</div>
	</div>
	 <div class="container">
				<div id="da-slider" class="da-slider">
					<div class="da-slide">
						<h2>方剂分析</h2>
						<p>分析医案中方剂与中药以及疾病之间的关联关系。</p>
						<a href="recipehome" class="da-link" target=_blank>点击进入</a>
					</div>
					<%--
					<div class="da-slide">
						<h2>处方分析</h2>
						<p>分析医案中处方与中药，疾病的关联关系。</p>
						<a href="#" class="da-link">点击进入</a>
					</div>
					--%>
					<div class="da-slide">
						<h2>中药分析</h2>
						<p>分析医案中中药与中药，疾病以及方剂之间的关联关系。</p>
						<a href="drughome" class="da-link" target=_blank>点击进入</a>
					</div>
					<div class="da-slide">
						<h2>疾病分析</h2>
						<p>分析医案中疾病与中药，疾病以及方剂之间的关联关系。</p>
						<a href="symptomhome" class="da-link" target=_blank>点击进入</a>
					</div>
					<div class="da-slide">
						<h2>处方分析</h2>
						<p>根据病名病症、方剂、中药、辨证或治则等查询医案中的相关处方</p>
						<a href="/MedicalRecord/pre_analysis/home" class="da-link">点击进入</a>
					</div>
					<div class="da-slide">
						<h2>辩证治则分析</h2>
						<p>在指定辩证和治则下，分析得出经常使用的中药。</p>
						<a href="Analysis/Result" class="da-link" target=_blank>点击进入</a>
					</div>
					
					<nav class="da-arrows">
						<span class="da-arrows-prev"></span>
						<span class="da-arrows-next"></span>
					</nav>
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