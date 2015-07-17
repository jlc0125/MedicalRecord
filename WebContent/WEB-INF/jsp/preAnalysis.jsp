<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html dir="ltr" xml:lang="en-gb" xmlns="http://www.w3.org/1999/xhtml" lang="en-gb">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中草药基础知识搜索系统</title>
<head>
<!-- js -->
<script src="${initParam.resources}/resources/common/jquery_1_8_3.js"></script>
<script src="${initParam.resources}/resources/common/ajax.js"></script>
<script src="${initParam.resources}/resources/common/d3.min.js"></script>
<script src="${initParam.resources}/resources/common/d3pie.js"></script>
<script src="${initParam.resources}/resources/medicine/med.js"></script>

<!-- exlib -->
<script src="${initParam.resources}/resources/exlib/md5/md5.js"></script>
<script src="${initParam.resources}/resources/search/js/bootstrap.min.js"></script>
<script src="${initParam.resources}/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>


<!-- css -->
<link rel=stylesheet type=text/css
	href="${initParam.resources}/resources/exlib/bootstrap/css/bootstrap.css">
<link rel=stylesheet type=text/css
	href="${initParam.resources}/resources/exlib/bootstrap/css/bootstrap-responsive.css">
<link rel=stylesheet type=text/css
	href="${initParam.resources}/resources/exlib/simple_pagination/simplePagination.css">
<link rel=stylesheet type=text/css
	href="${initParam.resources}/resources/search/css/common.css">
<link rel=stylesheet type=text/css
	href="${initParam.resources}/resources/search/css/index.css">
<link rel=stylesheet type=text/css
	href="${initParam.resources}/resources/search/css/SubHeadAndFoot_index.css">
<link rel=stylesheet type=text/csz 
	href="${initParam.resources}/resources/search/css/jichushousuo.css">
	
		<LINK rel=stylesheet type=text/css href="${initParam.resources}/resources/search/css/main.css">
		<LINK rel=stylesheet type=text/css href="${initParam.resources}/resources/search/css/extra.css">
<style type="text/css">
	

</style>
</HEAD>
<script type="text/javascript">

var pie;
var dataAll;
var pageNo=1;
var pageSize=10;
var pageIndex;

$(function(){
	$(".option").each(function(){
		$(this).click(function(){
			$(".option").each(function(){
				$(this)[0].checked=false;
			});
			$(this)[0].checked=true;
		});
	});
	
	$("#btn").live(
			'click',
			function(){
				var keyword=$("#input").val();
				$.ajax({
					  type: 'POST',
					  url: "/MedicalRecord/search/retval",
					  data: {
						  "wd":keyword,
						  "type":"content"
					  },
					  success: success,
					  error:error,
					  dataType:"text"
					});
			});
	$(".med_checkbox").live("click",function(){
		generateLink();
	});
	/*
	$(window).scroll(function(){
		if(dataAll){
			if($("#records").offset().top+$("#records").height()-window.pageYOffset-$(window).height()<100){
				pageNo+=1;
				data=dataAll[pageIndex];
				records=data.records;
				showRecords(records,pageNo,pageSize);
				
			}
		}
	});
	*/
});

function success(data,textStatus,jqXHR){
	
	data=eval('(' + data + ')');
	$("#container").show();
	console.log(data);
	var head="<tr><th>编号</th><th>处方</th></tr>";
	var body="";
	var count=0;
	for(var i=0;i<data.length;i++){
		var cfIndex=data[i]["cfIndex"].split(" ");
		var content=data[i]["content"].split("|");
		for(var j=0;j<cfIndex.length;j++){
			count++;
			var pre=content[cfIndex[j]];
			var href="/MedicalRecord/pre_analysis?pre="+pre+"&recordId="+data[i]["recordId"]+"&recordTitle="+data[i]["recordTitle"];
			body+="<tr><td>" + count + "</td><td><a href='"+href+"'>" + pre + "</a></td></tr>";
		}
	}
	$("#front_search_list_title").html(head);
	$("#front_search_list_info").html(body);
	
}

function error(){
	alert("error");
}





</script>

<BODY>
	<div class=top>
		<div>
		    <link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/commonpages/css/nav_header.css"></link>
		    <link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/commonpages/dropdown/dropdown.css"></link>
		    <script src="${initParam.resources}/resources/commonpages/js/nav_header.js"></script>
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
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo"><a href="index.html" target=_blank><IMG src="${initParam.resources}/resources/search/Images/logo.png"></A></div>
				<div class="clearfix"></div>
			</div>
		</div>
		</div>
	<div class="bg_heise">
		<div id="content" >
			<div class="logoSearch_L2" style="height:100px">
				<div id="search" class="search cf" style="height: 50px !important;">
					<INPUT id="input" class=text  name=q> 
					<A class=button id="btn" href="#"></A> <br>
				</div>
			</div>
			
			<div class="container-fluid " id="container" style="display:none">
				<div class="row-fluid">
					<div class="span12">
						<div class="tabbable tabs-left">
							<div class="tab-content span9">
								<div class="tab-pane active" id="front_search_list">
										<h2 id="sort_help"></h2>
										<table class="table " id="front_search_table">
											<thead id="front_search_list_title"></thead>
											<tbody id="front_search_list_info"></tbody>
										</table>
								</div>
							</div>
						</div>
					</div>
				</div>
		</div>	
		</div>
	</div>
	

	<!-- footer -->
	<div>
    	<link rel="stylesheet" type="text/css" href="${initParam.resources}/resources/commonpages/css/footer.css"></link>
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
