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
	<title>医案系统</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/reset.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/recipe.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/jquery-ui.css">
  <link rel="stylesheet" type="text/css" href="resources/recipe/css/revision.css">
  <link rel="stylesheet" type="text/css" href="resources/commonpages/css/nav_header.css">
  <link rel="stylesheet" type="text/css" href="resources/commonpages/css/footer.css">
  <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	
	<!-- js -->
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/common/d3.min.js"></script>

	<!-- // <script type="text/javascript" src="resources/common/jquery_1_8_3.js"></script> -->
	<script type="text/javascript" src="resources/recipe/js/easyTabs.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/jquery.pajinate.min.js"></script>
	<script type="text/javascript" src="resources/recipe/js/graph_recipe.js"></script>
  <script type="text/javascript" src="resources/recipe/js/revision.js"></script>
	
	<script type="text/javascript">
        function getUrlParam(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
                var r = window.location.search.substr(1).match(reg);  //匹配目标参数
                if (r != null) return unescape(r[2]); return null; //返回参数值
        }
		$(document).ready(function(){
			$('#container').easyTabs({defaultContent:1});
			
			// var recipeName = $("#front_input").val();
            var recipeName = decodeURI(getUrlParam('name'));
			if(recipeName != ''){
				var url = "recipe/search?q=" + recipeName;
				d3.json(url, function(error, root) { 
					if(error){
						$("#graph1").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						$("#graph2").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
					}
					else{
						graph("#graph1", root.drug, 300, 1, 1);
						graph("#graph2", root.zucheng, 300, 1, 0);
						$("#zc_chuchu").text("出自" + root.chuchu_zc);
						graph("#graph3", root.symptom, 450, 0, 1);
					}
				});
			}
			
			$("#search_cf").submit(function(){
				var value = $("#front_input").val();
				$("svg").remove();
				$("#zc_chuchu").empty();
				$(".errorhit").empty();
				if(value != ''){
					var url = "recipe/search?q=" + value;
					d3.json(url, function(error, root) { 
						if(error){
							$("#graph1").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
							$("#graph2").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
							$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						}
						else{
							graph("#graph1", root.drug, 300, 1);
							graph("#graph2", root.zucheng, 300, 1);
							$("#zc_chuchu").text("出自" + root.chuchu_zc);
							graph("#graph3", root.symptom, 500, 0);
						}
					});
				}
				return false;
			});
			
			$("#front_input").autocomplete({
				autoFocus: true,
				minLength: 1,
				source: function(request, response) {
					var url = "recipe/hint?q=" + request.term;
					$.get(url, function(data, status){
						response(data);
					});
				 }
			});
			
        });
      
	</script>
</head>



<body>
  <!-- revision -->
  <div class="mask"></div>
    <div class="bomb-box">
      <h2 class="revision-advise">信息反馈</h2>
      <div class="rec-advise-div" >
          <p>您的建议</p>
          <input>和<input>不存在关系
      </div>
      <div class = "rec-comment-div">
          <p>您的理由</p>
          <textarea></textarea>
      </div>
      <button class="btn btn-primary revision-btn" style="margin-left: 80%;">提交</button>
  </div>
<!-- revision -->

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

	
		<div class="imgFrame">
			<a href="recipehome"><img src="resources/recipe/image/r_122.png" /></a>
		</div>
		
		<div class="logoSearch_L2">
			<form id="search_cf" class="search cf" >
				<input id="front_input" class="text" type="text" maxLength="20" value="${recipeName}"> 
				<input class="button" id="front_btn" type="submit" value=""> <br>
			</form>
		</div>

		<div id="container">
			<ul class="tabs">
				<li><a href="#component">相关中药</a></li>
		  		<li><a href="#attending">相关疾病</a></li>
		 	</ul>
	
	    	<div id="main_content">
		    	<div id="component">
		    		<div class="graph">
		    			<div class="graph_head">从医案中分析出的相关关系</div>
              <span class="glyphicon glyphicon-pencil revision-span" aria-hidden="true" style="display:block;margin-left:80%;margin-top:10px;cursor:pointer">关系有错误？</span>
		    			<div id="graph1"></div>
		    			<div id="separate"></div>
		    			<div class="graph_head">方剂组成成分</div>
		    			<div id="zc_chuchu"></div>
		    			<div id="graph2"></div>
                        <!-- <div id="descpt1">
                            <table>
                                <caption>图示说明</caption>
                                <tbody>
                                    <tr>
                                        <td><svg><circle cx="6" cy="12" r="4.5" stroke="red" stroke-width="1.5" fill="#fff"></circle></svg></td>
                                        <td>从医案中分析与方剂相关，同时又是方剂知识库中方剂的组成的中药</td>
                                    </tr>
                                    <tr>
                                        <td><svg><circle cx="6" cy="12" r="4.5" stroke="steelblue" stroke-width="1.5" fill="#fff"></circle></svg></td>
                                        <td>从医案中分析与方剂相关，但不是方剂知识库中方剂的组成的中药</td>
                                    </tr>
                                    <tr>
                                        <td><svg><circle cx="6" cy="12" r="4.5" stroke="#008000" stroke-width="1.5" fill="#fff"></circle></svg></td>
                                        <td>方剂知识库中方剂的组成，但在医案中暂未分析出与方剂相关的中药</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div> -->
 		    		</div>
                    <div id="sidebar">
                        <div class="alt_container right-list">
                            <h2>相关医案</h2>
                            <div class="alt_page_navigation"></div> 
                            <div class="alt_info_text"></div>
                            <ol class="alt_content">
                                
                            </ol>
                        </div>    
                    </div>
		    		<!-- <div id="descpt1">
    					<table>
    					 	<caption>图示说明</caption>
    						<tbody>
    							<tr>
    								<td><svg><circle cx="6" cy="12" r="4.5" stroke="red" stroke-width="1.5" fill="#fff"></circle></svg></td>
    								<td>从医案中分析与方剂相关，同时又是方剂知识库中方剂的组成的中药</td>
    							</tr>
    							<tr>
    								<td><svg><circle cx="6" cy="12" r="4.5" stroke="steelblue" stroke-width="1.5" fill="#fff"></circle></svg></td>
    								<td>从医案中分析与方剂相关，但不是方剂知识库中方剂的组成的中药</td>
    							</tr>
    							<tr>
    								<td><svg><circle cx="6" cy="12" r="4.5" stroke="#008000" stroke-width="1.5" fill="#fff"></circle></svg></td>
    								<td>方剂知识库中方剂的组成，但在医案中暂未分析出与方剂相关的中药</td>
    							</tr>
    						</tbody>
    					</table>
    				</div> -->
		     	</div>
	     
	     		<div id="attending">
	    			<div id="graph3">
              <span class="glyphicon glyphicon-pencil revision-span" aria-hidden="true" style="display:block;margin-left:80%;margin-top:10px;cursor:pointer">关系有错误？</span>
            </div>
	    			<!-- <div id="descpt2">
    					<div>图示说明</div>
    					<svg style="margin-top: 20%;">
    						<circle cx="30" cy="25" r="4.5" stroke="steelblue" stroke-width="1.5" fill="#fff"></circle>
    						<text x="45" y="29">从医案中分析与方剂相关的疾病</text>
    					</svg>
    				</div> -->
                    <div id="sidebar">
                        <div class="alt_container right-list">
                            <h2>相关医案</h2>
                            <div class="alt_page_navigation"></div> 
                            <div class="alt_info_text"></div>
                            <ol class="alt_content">
                                
                            </ol>
                        </div>    
                    </div>
	     		</div>
	    	</div>
    		
		    <!-- <div id="sidebar">
		    	<div class="alt_container">
					<h2>相关医案</h2>
					<div class="alt_page_navigation"></div>	
					<div class="alt_info_text"></div>
					<ul class="alt_content"></ul>
				</div>    
		    </div> -->
	    	<div class="clearfix"></div>
   		</div>
        
	

	<!-- footer -->
	<!-- 统计信息 -->
<!-- Piwik -->
<script type="text/javascript">
  var _paq = _paq || [];
  _paq.push([ 'trackPageView' ]);
  _paq.push([ 'enableLinkTracking' ]);
  (function() {
    var u = (("https:" == document.location.protocol) ? "https" : "http")
        + "://www.ckcest.zju.edu.cn/piwik//";
    _paq.push([ 'setTrackerUrl', u + 'piwik.php' ]);
    _paq.push([ 'setSiteId', 1 ]);
    var d = document, g = d.createElement('script'), s = d
        .getElementsByTagName('script')[0];
    g.type = 'text/javascript';
    g.defer = true;
    g.async = true;
    g.src = u + 'piwik.js';
    s.parentNode.insertBefore(g, s);
  })();

</script>
<noscript><p><img src="http://www.ckcest.zju.edu.cn/piwik/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
    <!-- End Piwik Code -->

    <noscript><p><img src="http://www.ckcest.zju.edu.cn/piwik/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
    <!-- End Piwik Code -->
    
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/footer.css"></link>
    <div class="footer" style="margin-bottom:0px;">
           <div class=footer_L2>
               <div class="footer_about cf">
               
                   <dl class=dlLeft id="dlLeft-first">
                       <dt>法律声明</dt>
                       <dd>
                           <a href="${initParam.base}/user/agreementpage" rel="nofollow" target="_blank">注册服务条款</a>
                       </dd>
                       <dd>
                           <a href="${initParam.base}/" target="_blank">首页</a>
                       </dd>
                   </dl>

                   <dl class=dlLeft>
                       <dt>帮助中心</dt>
                       <dd>
                           <a href="javascript:window.open('${initParam.base}/user/FAQ')" rel="nofollow" target="_blank">常见问题</a>
                       </dd>
                       <dd>
                           <a href="${initParam.base}/user/getmanual" rel="nofollow" target="_blank">操作指南</a>
                       </dd>
                       <!-- 
                       <dd>
                           <a href="" target="_blank">版权申明</a>
                       </dd>
                       -->
                   </dl>

                   <dl class=dlLeft>
                       <dt>支持我们</dt>
                       <dd>
                           <a href="${initParam.base}/user/feedback" rel="nofollow" target="_blank">意见反馈</a>
                       </dd>
                       <dd>
                           <a href="${initParam.base}/user/join_us" rel="nofollow" target="_blank">加入我们</a>
                       </dd>
                   </dl>


                   <dl class="dlLeft">
                       <!-- <dd>邮政信箱：北京8068信箱</dd>
                       <dd>邮编：100088</dd>
                       <dd>服务热线：010-0000000</dd> -->
                       <dt>关于我们</dt>
                       <dd  class="aboutus-item"><a href="javascript:void(0);" class="#">项目简介</a></dd>
                       <dd  class="aboutus-item"><a href="javascript:void(0);" class="#contact_us">联系我们</a></dd>
                   </dl>
               </div>

               <div class=footer_links>
                   <span class=footer_links_title>友情链接：</span> 
                   <span class=footer_links_list> 
                       <a href="http://www.cae.cn/cae/html/main/index.html" target="_blank">中国工程院</a> 
                       <a href="http://www.satcm.gov.cn/" target="_blank">国家中医药管理局</a>
                       <a href="http://www.catcm.ac.cn/" target="_blank">中国中医科学院</a> 
                       <a href="http://www.sfda.gov.cn/WS01/CL0001/" target="_blank">国家食品药品监督管理总局</a>
                       <a href="http://www.cma.org.cn/" target="_blank">中华医学会</a> 
                   </span>
               </div>
               
               <div class=footer_copy>
                   <div class=footer_copy_right>
                       <p>地址：北京市西城区冰窖口胡同2号</p>
                       <p>Copyright © 2008 中国工程院 ICP备案号:京ICP备05023557号</p>
                       <p><a href="http://www.imicams.ac.cn/" target="_blank">中国医学科学院医学信息研究所</a>创办并维护</p>
                   </div>
               </div>
               
               <script type="text/javascript">
          $('.aboutus-item').click(function(){
            window.open("${initParam.base}/user/aboutuspage"+$(this).children().first().attr("class"));
          })
        </script>
               
           </div>
       </div>
</body>
</html>