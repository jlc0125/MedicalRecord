<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html dir="ltr" xml:lang="en-gb" xmlns="http://www.w3.org/1999/xhtml" lang="en-gb">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中草药基础知识搜索系统</title>
<head>
<!-- js -->
<script src="<%=contextPath%>/resources/common/jquery_1_8_3.js"></script>
<script src="<%=contextPath%>/resources/common/ajax.js"></script>
<script src="<%=contextPath%>/resources/common/d3.min.js"></script>
<script src="<%=contextPath%>/resources/common/d3pie.js"></script>
<script src="<%=contextPath%>/resources/medicine/med.js"></script>

<!-- exlib -->
<script src="<%=contextPath%>/resources/exlib/md5/md5.js"></script>
<script src="<%=contextPath%>/resources/search/js/bootstrap.min.js"></script>
<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>


<!-- css -->
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/bootstrap/css/bootstrap-responsive.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/common.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/index.css">
<link rel=stylesheet type=text/css
	href="<%=contextPath%>/resources/search/css/SubHeadAndFoot_index.css">
<link rel=stylesheet type=text/csz 
	href="<%=contextPath%>/resources/search/css/jichushousuo.css">
<style type="text/css">
	thead{
	background-color: #f5f2f1;
	}
	.info{
	background-color: #B8AEAB;
	text-align:center;
	}
	.alert{
		text-align:center;
		font-size: 20px;
		margin-left: 25%;
		margin-right: 26%;
		margin-top: 30px;
	}
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
				var type;
				if($("#bz_opt")[0].checked)	type="bz";
				else if ($("#zz_opt")[0].checked) type="zz";
				else type="bz";
				$.ajax({
					  type: 'POST',
					  url: "./"+type,
					  data: {
						  "wd":keyword
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
	
	dataAll=eval('(' + data + ')');
	console.log(dataAll);
	if (dataAll[0]["meds"]==0){
		$("#pieChart").empty();
		$(".container").empty();
		$(".alert").show();
		return 
	}
	else{
		$(".alert").hide();
	}
	var list="";
	for(var i=0;i<dataAll.length;i++){
		if(i==0) list+="<li class='active'><a id='nav"+i+"' onclick='init("+i+")'>"+dataAll[i].word+"</a></li>";
		else list+="<li><a id='nav"+i+"' onclick='init("+i+")'>"+dataAll[i].word+"</a></li>";
	}
	console.log(list);
	$("#nav").show();
	$("#nav").html(list);
	$("#nav li").each(function(){
		$(this).click(function(){
			$("#nav li").removeClass("active");
			$(this).addClass("active");
			generateLink();
		});
	});
	init(0);
}

function error(){
	alert("error");
}

function showRecords(records,pageNo,pageSize){
	tbody="";
	for(var i=(pageNo-1)*pageSize;i<pageNo*pageSize;i++){
		tbody+="<tr><th>"+records[i].recordTitle+"</th><th>"+records[i].doctorName+"</th><th>"+records[i].reference+"</th></tr>";
	}
	$("#records_body").append(tbody);
}

function init(index){
	pageNo=1;
	pageIndex=index;
	$("#pieChart").empty();
	$("#records_body").empty();
	data=dataAll[index];
	console.log(index);
	var color = d3.scale.category20();
	var meds=data.meds;
	var records=data.records;
	var likelihood=data.likelihood;
	var medsTable="<table id='meds_table' class='table'><thead><tr><th>选择中药</th><th>中药名称</th>\
	</tr><tbody>";
	var pieData=new Array();
	var sum=0;
	for(var i=0;i<meds.length;i++){
		medsTable+="<tr><td><input type='checkbox' class='med_checkbox'/></td><td class='medicine'><a>"+meds[i]+"</a></td></tr>";
		sum+=likelihood[i];
		pieData.push({
			"label":meds[i],
			"value":likelihood[i],
			"color":color(i)
		});
	}
	medsTable+="</tbody>"
	pieData.push({
		"label":"其他",
		"value":1-sum,
		"color":color(meds.length)
	});
	$("#meds_info").html("相关中药");
	$("#meds").html(medsTable);
	
	paintPie(pieData);
	generateLink();
	
	/*
	var recordsHead="<tr><th>医案名称</th><th>医生姓名</th><th>医案出处</th></tr>";
	$("#records_info").html("相关医案");
	$("#records_head").html(recordsHead);
	showRecords(records,pageNo,pageSize);
	*/
}

function seachForRecord(){
	
}

function generateLink(){
	var keywordList=getKeywordList();
	var keyword=keywordList.join("、")
	$("#search_link").html("查看<span style='color:red'>"+keyword+"</span>相关医案");
	$("#search_link").attr("href","../search/result?wd="+keyword+"&type=content");
	$("#search_link").attr("target","_blank");
}

function getKeywordList(){
	var keyword=[];
	$("#meds_table tbody tr").each(function(){
		var checkBoxCol=$(this).children('td')[0];
		var medNameCol=$(this).children('td')[1];
		if($(checkBoxCol).children()[0].checked){
			keyword.push($(medNameCol).text());
		}
	});
	
	keyword.push($(".nav .active a").text());
	return keyword;
}


function paintPie(data){
	pie = new d3pie("pieChart", {
		"header": {
			"title": {
				"text": "辩证分析",
				"fontSize": 24,
				"font": "open sans"
			},
			"subtitle": {
				"text": "辩证"+$("#input").val()+"常用的药材",
				"color": "#999999",
				"fontSize": 12,
				"font": "open sans"
			},
			"titleSubtitlePadding": 9
		},
		"footer": {
			"color": "#725b5b",
			"fontSize": 10,
			"font": "open sans",
			"location": "bottom-left"
		},
		"size": {
			"canvasHeight":250,
			"canvasWidth": 250,
			"pieInnerRadius": "13%",
			"pieOuterRadius": "81%"
		},
		"data": {
			"content": data
		},
		"labels": {
			"outer": {
				"hideWhenLessThanPercentage": 1,
				"pieDistance": 32
			},
			"inner": {
				"hideWhenLessThanPercentage": 3
			},
			"mainLabel": {
				"fontSize": 11
			},
			"percentage": {
				"color": "#ffffff",
				"decimalPlaces": 0
			},
			"value": {
				"color": "#adadad",
				"fontSize": 11
			},
			"lines": {
				"enabled": true
			}
		},
		"effects": {
			"pullOutSegmentOnClick": {
				"effect": "linear",
				"speed": 400,
				"size": 8
			}
		},
		"misc": {
			"gradient": {
				"enabled": true,
				"percentage": 81,
				"color": "#ffffff"
			}
		}
	});
}

</script>

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
			                <a title="注册" href="/tcm/user/registerpage" rel="nofollow">注册</a>
			            </li>
		                <li>
		                    <a title="登录" href="/tcm/user/loginpage" rel="nofollow">登录</a>
		                </li>
			            <li><a title="帮助中心" href="javascript:void(0);" rel="nofollow">帮助中心</a></li>
			            <li><a title="知识中心导航" href="javascript:void(0);" rel="nofollow">知识中心导航</a></li>
			            <li><a title="知识中心首页" href="http://www.udms.org/ckcest/" rel="nofollow">知识中心首页</a></li>
			            <li><a class="current" title="中草药系统首页"  href="/tcm" rel="nofollow">中草药系统首页</a></li>
			        </ul>
			    </div>
			</div>
		</div>
		<div class=logoSearch>
			<div class="logoSearch_L2">
				<div class="logo"><A href="home" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
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
				<div class="checkboxes2" id="option">搜索选项：&nbsp; 
						<input type="checkbox" class="option" id="bz_opt">辩证&nbsp;&nbsp;
						<input type="checkbox" class="option" id="zz_opt">治则&nbsp;&nbsp;
				</div>
			</div>
			<div class="alert" style="display:none">
			  <strong>您输入的词中不包含辩证或治则词汇，请再次输入</strong> 
			</div>
			<div class="container" style="background-color: white;">
				<ul id="nav" class="nav nav-tabs" style="display:none"></ul>
				<div class="info"><h1 id="meds_info"></h1>
				</div>
				<div class="row">
					<div class="span9">
						<div id="meds"  >
						</div>
					</div>
					<div id="pieChart" class="span3">
					</div>
				</div>
				<div id="search_link_div">
					<a id="search_link"></a>
				</div>
<!--			
				<div class="info"><h1 id="records_info"></h1>
				</div>
				<div class="row">
					<div class="span12">
						<div id="records">
							<table id="records_table" class="table">
								<thead id="records_head"></thead>
								<tbody id="records_body"></tbody>
							</table>
						</div>
					</div>
				</div>
-->
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
