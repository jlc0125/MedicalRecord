<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>中草药基础知识搜索系统</title>
	
	<!-- js -->
	<script type="text/javascript" src="resources/common/jquery_1_8_3.js"></script>
	<script type="text/javascript" src="resources/recipe/js/easyTabs.js"></script>
	<script type="text/javascript" src="resources/D3JS/d3.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#container').easyTabs({defaultContent:1});
			
			var diameter = 560;
			var tree = d3.layout.tree()
			.size([360, diameter / 2 - 60])
			.separation(function(a, b) { 
				return (a.parent == b.parent ? 1 : 2) / a.depth;  
			});
			        
			var diagonal = d3.svg.diagonal.radial()
			.projection(function(d) { 
				return [d.y, d.x / 180 * Math.PI]; 
			});
			
			function graph(selectStr, root){
				var svg = d3.select(selectStr).append("svg")
				.attr("width", diameter)
				.attr("height", diameter)
				.append("g")
				.attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");
				
				var nodes = tree.nodes(root),
							links = tree.links(nodes);
				
				var link = svg.selectAll(".link")
				.data(links)
				.enter().append("path")
				.attr("class", function(d){
					if(d.source.depth == 0)
						return "rootlink";
					else
						return "childlink";
				})
				.attr("d", diagonal);

				var rootNode = svg.append("g")
				.attr("class", "rootnode");
				
				rootNode.append("circle")
				.attr("r", 7);

				rootNode.append("text")
				.attr("dy", "32")
				.attr("text-anchor", "middle")
				.text(nodes[0].name);

				var node = svg.selectAll(".node")
				.data(nodes.slice(1))
				.enter().append("g")
				.attr("class", function(d){
					if(d.depth == 1)
						return "childnode";
					else
						return "grandchildnode";
				})
				.attr("transform", function(d) {
					return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; 
				});

				node.append("circle")
				.attr("r", 4.5)
				.on("mouseover", function(){
					d3.select(this).attr("r", 8);
				})
				.on("mouseout", function(){
					d3.select(this).attr("r", 4.5);
				})
				.on("click", function(d){
					alert(d.parent.name + " , " + d.name);
				});

				node.append("text")
				.attr("dy", ".5em")
				.attr("text-anchor", function(d) {
					return d.x < 180 ? "start" : "end";
				})
				.attr("transform", function(d) {
					return d.x < 180 ? "translate(8)" : "rotate(180)translate(-8)";
				})
				.text(function(d) { return d.name; });

				node.append("title")
				.text("点击查看相关医案");
			}
			
			$("#front_btn").click(function(){
				var value = $("#front_input").val();
				if(value != ''){
					var url = "recipe/search?q=" + value;
					d3.json(url, function(error, root) { 
						graph("#component #graph", root.component);
						graph("#attending #graph", root.attending);
						graph("#similar #graph", root.similar);		
					});
				}
				return false;
			});
			
        });
	</script>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/reset.css">
	<link rel="stylesheet" type="text/css" href="resources/recipe/css/recipe.css">


	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/nav_header.css"></link>
	<link rel="stylesheet" type="text/css" href="resources/commonpages/css/footer.css"></link>
</head>

<BODY>
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
			<img src="resources/recipe/image/r_1.png" />
		</div>

		<div class="logoSearch_L2">
			<div class="clearfix"></div>
			<div id="search_cf" class="search cf">
				<input id="front_input" class="text" type="text" maxLength="20"> 
				<a class="button" id="front_btn" href="#"></a> <br>
			</div>
		</div>
		
		<div id="container">
			<ul class="tabs">
				<li><a href="#component">中药关联</a></li>
		  	<li><a href="#attending">疾病关联</a></li>
		  	<li><a href="#similar">方剂关联</a></li>
		 </ul>
	
    <div id="main_content">
    	<div id="component">
    		<div id="graph">
    		</div>
     </div>
     
     <div id="attending">
    		<div id="graph">
    		</div>
     </div>
     
     <div id="similar">
    		<div id="graph">
    		</div>
			</div>
    </div>
    <div id="sidebar">
    	<h2>相关医案</h2>
    	<ul>
    		<li>1</li>
      <li>2</li>
      <li>3</li>
     </ul>
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
</BODY>
</HTML>