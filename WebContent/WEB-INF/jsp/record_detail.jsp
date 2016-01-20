<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
		<link rel="stylesheet" type=text/css href="<%=contextPath%>/resources/common/css/logo.css">
		
		<style>
		.container-fluid{
			background-color: #f5f2f1;
		}
		
		.recommend_head{
			white-space:nowrap;
			vertical-align: middle !important;
			font-weight:bold;
			font-size:20px;
			
		}
		
		.recommend_content{
			text-align:left;
		}
		.recommend_field{
			cursor:pointer;
		}
		
		#recommend-row{
			margin:50px;
		}
		
		.chufang{
			background-color:rgb(220, 234, 247);
			cursor:pointer;
		}
		p {
			text-indent: 2em;
			padding:5px;
			font-size:12px;
			margin:5px 0;
		}
		
		#doctor{
			padding-top:5%;
			font-size:14px;
			line-height:18px;
			font-family: inherit;
			font-weight: bold;
			text-align:center;
		}
		#content{
			padding-top:5%;
			text-align:left;
		}
		#title{
			padding-top:5%;
			text-align:center;
		}
		#reference{
			text-align:right;
			font-size:14px;
			line-height:18px;
			font-family: inherit;
			font-weight: bold;
		}
		
		#content_container{
			background-color:white;
			width:80%;
		}
		</style>
		
		<script type="text/javascript">
		function getUrlParam(name){
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
			var r = window.location.search.substr(1).match(reg);  //匹配目标参数
			if (r!=null) return r[2]; return null; //返回参数值
		} 
		
		var dataGlobal;
		$(function(){
			var dataJson = {
					"recordId" : getUrlParam("recordId")
					};
			
			$.ajax({
				type: 'POST',
				url: "./record_detail/record",
				data: dataJson,
				success: getRecordSuccess,
				error: getRecordError,
				dataType:'text'
			});
			
			getSimRecoreds(getUrlParam("recordId"),5);
		});
		
		function getRecordSuccess(data,textStatus,jqXHR){
			data=eval('(' + data + ')');
			dataGlobal=data;
			console.log(data);
			content=data.content.split("|");
			var cfIndex=[];
			if(data.cfIndex){
				cfIndex=data.cfIndex.split(" ");	
			}
			
			
			for(var i=0;i<cfIndex.length;i++){
				cfIndex[i]=parseInt(cfIndex[i]);
			}
			console.log(cfIndex);
			var doctor="<h3><a target='_blank' href='/MedicalRecord/doctor?id="+data.doctorId+"'>"+data.doctorName+"</a></h3>";
			var body="";
			for (var i=0;i<content.length;i++){
				if(cfIndex.indexOf(i)!=-1) body+="<p class='chufang' title='点击进行处方分析'>"+content[i]+"</p>";
				else body+="<p>"+content[i]+"</p>";
			}
			var reference="<br/><br/><a href='/MedicalRecord/search/result?wd="+data.reference+"&type=reference'>出自"+data.reference+"</a><br/><br/>"
			var title="";
			title+="<h2>"+data.recordTitle+"</h2>";
			$("#doctor").html(doctor);
			$("#title").prepend(title);
			$("#content").html(body);
			$("#reference").html(reference);
			
			var hlFlag=getUrlParam("hlFlag");
			if(hlFlag=="1"){
				var hlWords=decodeURI(getUrlParam("hlWords"));
				hlWords=hlWords.split(" ");
				highLight(hlWords);
			}
			
/* 			$(".chufang").tooltip({
			      title:"点击进行处方分析",
			      placement:'bottom'
			}); */
			$(document).on("click",".chufang",function(){
				
				var url="/MedicalRecord/pre_analysis?pre="+$(this).text()+"&recordId="+dataGlobal["recordId"]+"&recordTitle="+dataGlobal["recordTitle"]
				window.open(url);
			});

		}
		
		function getRecordError(){
			alert("error");
		}
		
		function highLight(words){
			var content=$("#content").html();
			for(var i=0;i<words.length;i++){
				var word=words[i];
				var reg=new RegExp(word,"g");
				content=content.replace(reg,"<font color='red' style='font-weight:bold' >"+word+"</font>");
			}
			$("#content").html(content);
		}
		
		
		function getSimRecoreds(recordId,size){
			var dataJson = {
					"recordId" : recordId,
					"size": size
					};
			
			$.ajax({
				type: 'GET',
				url: "./recommend/by_record_sim",
				data: dataJson,
				success: getSimRecordsSuccess,
				error: getSimRecordsError,
				dataType:'text'
			});
		}
		
		function getSimRecordsSuccess(data,textStatus,jqXHR){
			data=eval('(' + data + ')');
			console.log(data);
			var html="<table class='table'><tbody><tr><td class='recommend_head'>相关医案</td>";
			for(var i=0;i<data.length;i++){
				var content=data[i].content.split("|");
				html+="<td><div class='recommend_field' record_id='"+data[i].recordId+"'><p class='recommend_title'>"+data[i].recordTitle+"</p><p class='recommend_content'>";
				if(content.length > 0){
					html+=content[0].substring(0,10);	
				}
				
				html+="...</br>";
				html+="</p></div></td>";
			}
			html+="</tr></tbody></table>";
			$("#recommend").html(html);
			$(document).on("click",".recommend_field",function(){
				var url="/MedicalRecord/record_detail?recordId="+$(this).attr("record_id");
				window.open(url);
			});
			$(".recommend_field").mouseover(function(){
				$(this).css("background-color","#FAFAFA");
			});
			$(".recommend_field").mouseout(function(){
				$(this).css("background-color","");
			});
			
		}
		
		function getSimRecordsError(){
			alert("getSimRecordsError");
		}




        //revision
        $(function(){
            
            function showBombBox(){
               
                var height = $("body").height();
                $(".mask").css("height",height);
                $(".mask").show();
                $(".bomb-box").show();
                
            }

            function hideBombBox(){
                $(".bomb-box").hide();
                $(".mask").hide();
            }

            $(".revision-span").click(function(){
               
                showBombBox();
                $("body").click(function(event){
                    var toElement = event.toElement;
                    if(toElement == $(".revision-span")[0]){
                        return;
                    }
                
                    var x = event.clientX;
                    var scrollY = document.documentElement.scrollTop || document.body.scrollTop;
                    var y = event.clientY + scrollY;
                    var top = $(".bomb-box").offset().top;
                    var left = $(".bomb-box").offset().left;
                    var width = $(".bomb-box").width();
                    var height = $(".bomb-box").height();
                    // console.log([x,y,top,left,width,height]);
                    if(x < left || y < top || x > left + width || y > top + height){
                        hideBombBox();
                        $("body").unbind();
                    }
                })

            });
            
            


            $(".revision-btn").click(function(){
                hideBombBox();
                var id = getUrlParam("recordId");
                var title = $(".rec-advise-div input").val();
                var comment = $(".rec-comment-div textarea").val();
                dataJson = {
                    t : title,
                    c: comment,
                    id : id
                }
                console.log(dataJson);

                url = "revision/record_title";
                $.ajax({
                  type: "GET",
                  url: url,
                  data: dataJson,
                  success: successCB,
                  error: errorCB,
                  dataType:"text"
                });
            })

            function successCB(data){
                console.log("success");
            }

            function errorCB(){
                alert("revision error");
            }

        })






		</script>
		
		
		
						
	</head>

    <style type="text/css">
        .revision-span{
            cursor: pointer;
        }
        .mask{
            display:none;
            width:100%;
            position:absolute;
            background:black;
            z-index:10;
            top:0;
            left:0;
            opacity:0.4;
        }

        .bomb-box {
            display:none;
            background:#fff;
            position:absolute;
            top:320px;
            left:500px;
            z-index:20;
            width:800px;
            height:600px;
            background: aliceblue;
            border-radius: 20px;
            box-shadow: 10px 10px 20px rgba(0,0,0,0.2);
        }

        .revision-advise{
            text-align: center;padding-top: 3%;
        }

        .rec-advise-div{
            height: 20%;
            margin-left: 5%;
            margin-right: 5%;
            margin-top: 5%;
        }
        .rec-advise-div p{
            font-size:20px;
        }

        .rec-advise-div input{
            width: 80%;
            margin-left: 10%;
            height: 50%;
            font-size: 20px;
            padding: 10px;
        }

        .rec-comment-div{
            height: 40%;
            margin-left: 5%;
            margin-right: 5%;
            margin-top: 5%;
        }

        .rec-comment-div p{
            font-size:20px;
        }

        .rec-comment-div textarea{
            width: 80%;  
            margin-left: 10%;
            height: 65%;
            font-size: 20px;
            padding: 10px;
        }

    </style>


	<body>
    	<div class="mask"></div>
        <div class="bomb-box">
            
                <h2 class="revision-advise">信息反馈</h2>
                <div class="rec-advise-div" >
                    <p>推荐标题</p>
                    <input>
                </div>
                <div class = "rec-comment-div">
                    <p>推荐理由</p>
                    <textarea></textarea>
                </div>
                <button class="btn btn-primary revision-btn" style="margin-left: 80%;">提交</button>

            
        </div>
	        

        <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
        <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
        <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
    	<%@include file="/WEB-INF/jsp/common/header.jsp"%>
		<div class=logoSearch>
          <div class="logoSearch_L2">
            <div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
            <div class="clearfix"></div>
          </div>
        </div>
		
		<div class="sub_nav_bg">
			<div id="sub_nav">
				<a href="<%=contextPath%>/index"><span id="nav_qwss" class="sub_nav_span"></span></a>
				<a href="<%=contextPath%>/Browse"><span id="nav_flll" class="sub_nav_span"></span></a>
				<a href="<%=contextPath%>/analysishome"><span id="nav_zhcx" class="sub_nav_span"></span></a>
		    </div> 
	    </div>
		
		<div class="clearfix"></div>
			
		<div id="tab-title">	
			<div id="front_menu">
	    	</div>
		</div>
		
		<div class="clearfix"></div>
		<div id="underline"></div>
		<div class="clearfix"></div>
		
		<div class="container-fluid ">
				<div class="row-fluid">
					<div class="span12">
						<div id="content_container" class="container-fluid">
							<div id="title">
                               <span class="glyphicon glyphicon-pencil revision-span" aria-hidden="true" style="display:block;margin-left:80%">标题有错误？</span>
							</div>
							<div id="doctor">
							</div>
							<div id="content">
							</div>
							<div id="reference">
							</div>
						</div>
					</div>
				</div>
				
				<div class="row-fluid" id="recommend-row">
					<div class="span12" id="recommend"></div>
				
				</div>
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