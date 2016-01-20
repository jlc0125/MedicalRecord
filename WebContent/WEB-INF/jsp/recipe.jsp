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
       /*  function getPrescription(name){
        	var url = "recipe/prescription?q=" + name;
        	d3.json(url, function(error, root) {        		
				if(error){
					$("#accordion").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到 "' + name + '" 其他来源的组成。');
				}
				else{
					if(root.length==0){
						$("#accordion").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到 "' + name + '" 其他来源的组成。');
					}else{
						var str = "";
						for(var i=0;i<root.length;i++){						
							str += "<div class='panel panel-default'>"+
					        			"<div class='panel-heading'>"+
				            				"<p class='panel-titles'><a class='pre_name' data-toggle='collapse' data-parent='#accordion' href='#collapse_"+i+"'>"+root[i].name+"&nbsp;"+root[i].description.chuchu+"</a></p>"+
				        				"</div>"+
					        			"<div id='collapse_"+i+"' class='panel-collapse collapse'>"+
					            			"<div class='panel-body' id='pre_graph_"+i+"'></div>"+
					        			"</div>"+
			   			 			"</div>";						
						}
						$("#accordion").html(str);
						for(var i=0;i<root.length;i++){	
							graph("#pre_graph_"+i, root[i].description.id, root[i].description.zucheng, 300, 1, 1);
						}
					}
				}
			});
        } */
        function getPrescription(name){
        	var url = "recipe/prescription?q=" + name;
        	d3.json(url, function(error, root) {        		
				if(error){
					$("#accordion").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到 "' + name + '" 其他来源的组成。');
				}
				else{
					if(root.length==0){
						$("#accordion").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到 "' + name + '" 其他来源的组成。');
					}else{
						var str = "";
						for(var i=0;i<root.length;i++){						
							str +="<div class='content'>"+
				            		"<div class='title'><a>"+root[i].name+"&nbsp;"+root[i].description.chuchu+"</a></div>"+
				        			"<div id='collapse_"+i+"' class='submenu'>"+
				            			"<div class='panel-body' id='pre_graph_"+i+"'></div>"+
				        			"</div>"+
			   			 		"</div>";						
						}
						$("#accordion").html(str);
						for(var i=0;i<root.length;i++){	
							graph("#pre_graph_"+i, root[i].description.id, root[i].description.zucheng, 300, 1, 1);
						}
						Accordions();
					}
				}
			});
        }
        
        function Accordions(){
        	var Accordion = function(el, multiple) {
				this.el = el || {};
				this.multiple = multiple || false;

				// Variables privadas
				var links = this.el.find('.title');

				// Evento
				links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
			}

			Accordion.prototype.dropdown = function(e) {
				var $el = e.data.el;
					$this = $(this),
					$next = $this.next();

				$next.slideToggle();
				$this.parent().toggleClass('open');
				PreCompare($this);

				if (!e.data.multiple) {
					$el.find('.submenu').not($next).slideUp().parent().removeClass('open');
				};
			}	

			var accordion = new Accordion($('#accordion'), false);
        } 
        
        function PreCompare(e){
        	var pre = e.next().children('.panel-body').children('svg').children('g').find('g');//.find('g.childnode');//children("panel-body").children("svg").children("g").children(".childnode");
        //	alert(pre.length);
        	var recipe = $('#graph1').children('svg').children('g').find('g');
        //	alert(recipe.length);
        	for(var j=1;j<recipe.length;j++){
        		$(recipe[j]).attr("class", "childnode");
        	}
        	for(var i=1;i<pre.length;i++){		
        		for(var j=1;j<recipe.length;j++){
        			if($(pre[i]).children("text").text() == $(recipe[j]).children("text").text()){
        				$(pre[i]).attr("class", "childnode1");
        				$(recipe[j]).attr("class", "childnode1");
        			}
        		}
        	}
        	for(var i=1;i<pre.length;i++){
        		if($(pre[i]).attr('class')=='childnode'){
    				$(pre[i]).attr("class", "childnode3");
        		}
        	}
        	for(var j=1;j<recipe.length;j++){
        		if($(recipe[j]).attr('class')=='childnode'){
    				$(recipe[j]).attr("class", "childnode2");
        		}
        	}
        }
        
		$(document).ready(function(){
			$('#container').easyTabs({defaultContent:1});
			
            var recipeName = decodeURI(getUrlParam('name'));
			if(recipeName != ''){
				var url = "recipe/search?q=" + recipeName;
				d3.json(url, function(error, root) { 
					if(error){
						$("#graph1").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + recipeName + '" 相关的结果。');
						$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + recipeName + '" 相关的结果。');
					}
					else{
						graph("#graph1", 0, root.drug, 300, 1, 1);
						graph("#graph3", 0, root.symptom, 450, 0, 1);
					}
				});
				getPrescription(recipeName);
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
							$("#graph3").prepend("div").attr("class", "errorhit").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						}
						else{
							graph("#graph1",0,  root.drug, 300, 1);
							graph("#graph3",0,  root.symptom, 500, 0);
						}
					});
					getPrescription(value);
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
			
			$('.pre_name').click(function() {
				alert("k");
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
		<%@include file="/WEB-INF/jsp/common/header.jsp"%>
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
				<!-- <input class="button" id="front_btn" type="submit" value=""> <br> -->
				<button class="btn btn-primary search-btn" id="front_btn" type="submit">分析</button>
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
		    			<div id="descpt1">
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
	    				</div>		    			
		    			<div id="separate"></div>
		    			<div class="graph_head">各来源的方剂组成</div>
		    			<!-- <div class="graph_head">方剂组成成分</div> -->
		    			<!-- <div id="zc_chuchu"></div> -->
		    			<!-- <div id="graph2"></div> -->
		    			<!-- <div class="panel-group" id="accordion"></div> -->
		    			<div id="accordion" class="accordion"></div>
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
		     	</div>
	     
	     		<div id="attending">
	    			<div id="graph3">
              			<span class="glyphicon glyphicon-pencil revision-span" aria-hidden="true" style="display:block;margin-left:80%;margin-top:10px;cursor:pointer">关系有错误？</span>
            		</div>
	     		</div>
	     		
	     		<div id="sidebar">
                    <div class="alt_container right-list">
                        <h2>相关医案</h2>
                        <div class="alt_page_navigation"></div> 
                        <div class="alt_info_text"></div>
                        <ol class="alt_content"></ol>
                    </div>    
                </div>		
	    	</div>
	    	
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