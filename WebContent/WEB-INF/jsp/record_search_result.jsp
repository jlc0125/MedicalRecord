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
	<script src="<%=contextPath%>/resources/exlib/simple_pagination/jquery.simplePagination.js"></script>
	
	<!-- css -->
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<link rel="stylesheet"  href="<%=contextPath%>/resources/exlib/simple_pagination/simplePagination.css">
	<style type="text/css">
		#front_search_table{
			box-shadow: 0 5px 10px rgba(0,0,0,0.2);
		}
		.row{
			margin-top:100px;
		}
		
		body{
			background-color: #f5f2f1
		}
		
		.table tbody td{
			font-family: "微软雅黑";
			line-height: 20px;
			height:80px;
			vertical-align: middle !important; 
			text-align: center;
			font-size: 15px;
			border-top: 1px solid #dddddd;
			padding: 8px;
			
		}
		
		td{
			width:33%;
		}
		
		.tab-content{
			margin-left:16.7%;
			float: none !important;
		}
		
		#front_search_pagincation{
			margin-left: 38%;
			margin-top:80px;
			margin-bottom:80px;
		}
		
		.table thead tr th {
			font-family: "微软雅黑";
			vertical-align: middle;
			text-align: center;
			height:80px;
			color: #555555;
			font-size: 18px;
			background-color:white;
		}
		
		.table{
			background-color:white;
		}
	</style>
	
	<script type="text/javascript">
	function getUrlParam(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg);  //匹配目标参数
		if (r!=null) return r[2]; return null; //返回参数值
	} 
	
	var pageSize=10;
	var pageNo=1;
	var type;
	var dataGlobal;
	$(function(){
		type=getUrlParam("type");
		getFrontList();
		//显示结果排序，与医案相关度排序冲突，暂不实现
		if (type!="content"){
			$(document).on(
				"click",
				".head",
				function(){
					order=$(this).attr("name");
					bubbleSort(dataGlobal,order);
					showData(dataGlobal);
				
			});
		}
	});
	
	function bubbleSort(data,key){
	    for(var i=0;i<data.length;i++){
	        for(var j=i;j<data.length;j++){
	            if(data[i][key]<data[j][key]){
	                var temp=data[i];
	                data[i]=data[j];
	                data[j]=temp;
	            }
	        }
	    }
	}

	function getFrontList() {
		
		var dataJson = {
			"wd" : decodeURI(getUrlParam("wd")),
			"type" : type,
		};
		console.log(getUrlParam("wd"));
		var url = "./retval";
		$.ajax({
			  type: "GET",
			  url: url,
			  data: dataJson,
			  success: getFrontListSuccessCB,
			  error:getFrontErrorCB,
			  dataType:"text"
			});
	}



	function getFrontListSuccessCB(data,textStatus,jqXHR) {
		
	    data=eval('(' + data + ')');
	    console.log(data);
	    dataGlobal=[];
	    for(var i=0;i<data.length;i++){
	    	if (data[i].recordTitle!="") dataGlobal.push(data[i]);
	    }
	    showData(dataGlobal);
	}

	function showData(data){
		var thead= getTableTitle();
		var tbody = getTableBody(data);
		
		$("#front_search_list_title").html(thead);
		if(type!="content"){
			$("#sort_help").html("点击表头将搜索结果按照相应字段排序");
			$(".head").css("cursor","pointer");
		}
		$("#front_search_list_info").html(tbody);
		if (data.length <= pageSize)
		{
			$("#front_search_pagincation").hide();
			if(parseInt(data.count)==0)
				getFrontErrorCB();
		}
		else
			$("#front_search_pagincation").pagination(
					{
						items : data.length,
						itemsOnPage : pageSize,
						cssStyle : 'light-theme',
						hrefTextPrefix : '#',
						onPageClick : function(pageNumber, event) {
							pageNo=pageNumber;
							showData(data);
						},
						prevText : "上一页",
						nextText : "下一页",
						currentPage : pageNo
					});
	}
	
	function getFrontErrorCB(){
		
		window.location.href = "./error";
	}
	
	function getTableTitle(){
		return "<tr><th class='head' name='doctorName'>医生姓名</th><th class='head' name='recordTitle'>医案名称</th><th class='head' name='reference'>医案出处</th></tr>" ;
	}
	
	function getTableBody(data){
		var tbody="";
		for(var i=(pageNo-1)*pageSize;i<pageNo*pageSize&&i<data.length;i++){
			tbody+="<tr><td><a href='/MedicalRecord/doctor?id="+data[i].doctorId+"'>"+data[i].doctorName +"</a></td>"+
			"<td><a href='/MedicalRecord/record_detail?recordId="+data[i].recordId+"'>"+data[i].recordTitle+"</a></td>"+
			"<td><a href='/MedicalRecord/search/result?wd="+data[i].reference+"&type=reference'>"+data[i].reference+"</a></td></tr>";
		}
		return tbody;
	}
	</script>
	
	
	
</head>
<body>

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
		    <div class="navbar-header">
		      <div class="navbar-brand glyphicon glyphicon-search" href="#">
		      </div>
		    </div>
		    <form class="navbar-form navbar-left" role="search">
			  <div class="form-group">
			    <input type="text" class="form-control" placeholder="请输入内容...">
			  </div>
			  <button type="submit" class="btn btn-default">搜索</button>
			</form>
		</div><!-- /.container-fluid -->
	</nav>
	
	
	<div class="row">
		<div class="col-md-12">
			<div class="tab-content col-md-8">
				<div class="tab-pane active" id="front_search_list">
						<h2 id="sort_help"></h2>
						<table class="table " id="front_search_table">
							<thead id="front_search_list_title"><tr><th class="head" name="doctorName">医生姓名</th><th class="head" name="recordTitle">医案名称</th><th class="head" name="reference">医案出处</th></tr></thead>
							<tbody id="front_search_list_info"><tr><td><a href="/MedicalRecord/doctor?id=772">陈典周</a></td><td><a href="/MedicalRecord/record_detail?recordId=16741">当归补血汤治愈血虚发热</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=933">施汉章</a></td><td><a href="/MedicalRecord/record_detail?recordId=17513">柴胡注射液治愈变应性亚败血症</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=951">吴立文</a></td><td><a href="/MedicalRecord/record_detail?recordId=18287">六君子汤治愈发热恶寒</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=1363">李子质</a></td><td><a href="/MedicalRecord/record_detail?recordId=17642">解热饮治愈感冒</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=794">蔡友敬</a></td><td><a href="/MedicalRecord/record_detail?recordId=14742">四味消毒饮治愈咳嗽痰多</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=802">孔继菼</a></td><td><a href="/MedicalRecord/record_detail?recordId=11020">清热、祛痰治愈阳明</a></td><td><a href="/MedicalRecord/search/result?wd=《孔氏医案》&amp;type=reference">《孔氏医案》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=1376">刘永年</a></td><td><a href="/MedicalRecord/record_detail?recordId=18528">六君子汤治愈食管癌根治术</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=911">李明富</a></td><td><a href="/MedicalRecord/record_detail?recordId=18392">增液汤治愈发热</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=942">孟澍江</a></td><td><a href="/MedicalRecord/record_detail?recordId=16321">小柴胡汤治愈阳明</a></td><td><a href="/MedicalRecord/search/result?wd=《中国现代名中医医案精粹》&amp;type=reference">《中国现代名中医医案精粹》</a></td></tr><tr><td><a href="/MedicalRecord/doctor?id=263">佚名</a></td><td><a href="/MedicalRecord/record_detail?recordId=13540">清毒活血汤治愈发热</a></td><td><a href="/MedicalRecord/search/result?wd=《李氏医案》&amp;type=reference">《李氏医案》</a></td></tr></tbody>
						</table>
				</div>
			</div>
			<div id="front_search_pagincation" class="rs_pagincation light-theme simple-pagination"><ul><li class="active"><span class="current prev">上一页</span></li><li class="active"><span class="current">1</span></li><li><a href="#2" class="page-link">2</a></li><li><a href="#3" class="page-link">3</a></li><li><a href="#4" class="page-link">4</a></li><li><a href="#5" class="page-link">5</a></li><li class="disabled"><span class="ellipse">…</span></li><li><a href="#9" class="page-link">9</a></li><li><a href="#10" class="page-link">10</a></li><li><a href="#2" class="page-link next">下一页</a></li></ul></div>
		</div>
	</div>
	
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
	
	
	
</body>


