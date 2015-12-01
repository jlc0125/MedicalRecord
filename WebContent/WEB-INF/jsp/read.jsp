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
		.paragraph{
			margin-top: 10px;
			margin-bottom: 10px;
			font: 16px/1.5 "Open Sans", "Helvetica Neue", Helvetica, Arial, "Hiragino Sans GB W3", "Microsoft Yahei", sans-serif;
			line-height: 32px;
			color: #333;
			text-indent: 33px;
			text-align: justify;
			-webkit-font-smoothing: antialiased;
		}
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
		<div class="text">
			<div class="paragraph">
				五分，夜与当归龙荟丸下之，大小便皆利，热退诸症悉减，惟略恶
				心，与青皮饮，两帖全安。##
			</div>
			<div class="paragraph">
				程湘内人鼻衄后眩晕嘈杂，呕吐清水，夜卧不安，腹中饥，而食
				不下膈，孙谓由脾虚，肝胆有郁火也。以人参、黄连、白术、扁豆、甘
				草、陈皮、半夏、竹茹、茯苓、石膏，水煎调理而平。##
			</div>
			<div class="paragraph">
				黄履素曰：予少年患郁火之症，面时赤而热，手足不温，复觉咽
				干口燥，体中微黄，夜更甚。就医吴门，粗工投以黄连、黄芩、黄柏等
				药，服方二剂，忽觉手足甚冷，渐渐过脘过膝，鼻间突出冷气，神魂
				如从高桥坠下深溪，阴阴不能自止，几登鬼录。延名医张涟水治之，
				张云：症虽误服寒药，又不可骤以热药激之，但服八珍汤加姜及天
				麻，久当自愈。如法调之，虽渐安，而元气则大减矣。后检方书有云：
				郁症不可折以寒剂，误治致死。然则予之不死，幸也。夫记之以为
				鉴戒。##
			</div>	
			<div class="paragraph">
				潘埙曰：予禀气素偏于火，晚年多难，怀抱郁郁，因而肝气不
				平，上冲心肺，水火不能既济，殊无应病之药，乃自制一方，名曰兼
				制丸，以柴胡、龙胆、青皮各五钱平肝，归身一两养肝，生地一两、生
				甘草五钱泻南方，黄柏一两、知母五钱补北方，苍术八钱燥湿，芩、
				连各六钱清心肺，挂心二钱引经，加白术、防已、陈皮、茯苓、蜜丸，
				每服八十丸，常服有效。##
			</div>
			<div class="paragraph">
				《续名医类案》//
			</div>
			<div class="paragraph">
				冯楚瞻##
			</div>
			<div class="paragraph">
				一壮年作宦失意，退居抑郁成疾，即《经》所谓常贵后贱，名曰
				脱营；常富后贫，名曰失精。其候气血日消，神不外扬，六脉弦细而
				涩，饮食入胃，尽化为痰，必咳吐尽出乃能卧，津液内耗，肌表外疏，
				所以恶寒而瘦削，以东垣麻黄桂枝汤加白术、姜枣，二三剂脉气渐
				充有神，痰涎咳吐俱愈，继以十补丸及归脾养荣加减全瘳。##
			</div>
			<div class="paragraph">
				《续名医类案》//
			</div>
		</div>
		<div class="page">
			<a href="">上一页</a>
			<a href="" style="float:right">下一页</a>
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
