<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextPath=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <title>医案系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"> 
        
        <meta name="keywords" content="flip, pages, flipboard, layout, responsive, web, web design, grid, ipad, jquery, css3, 3d, perspective, transitions, transform" />
        <meta name="author" content="" />
		<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300,300italic' rel='stylesheet' type='text/css'> -->
        <!-- <link rel="stylesheet" type="text/css" href="/MedicalRecord/resources/test/css/demo.css" /> -->
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/modernizr.custom.08464.js"></script>
		<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
		<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.tmpl.min.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.history.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/core.string.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.touchSwipe-1.2.5.js"></script>
		<script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.flips.js"></script>
		
		

        <link rel="stylesheet" type="text/css" href="/MedicalRecord/resources/test/css/style.css" />
        <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
	

		<script id="pageTmpl" type="text/x-jquery-tmpl">
			<div class="{{= theClass}}" style="{{= theStyle}}">
				<div class="front">
					<div class="outer">
						<div class="content" style="{{= theContentStyleFront}}">
							<div class="inner">{{html theContentFront}}</div>
						</div>
					</div>
				</div>
				<div class="back">
					<div class="outer">
						<div class="content" style="{{= theContentStyleBack}}">
							<div class="inner">{{html theContentBack}}</div>
						</div>
					</div>
				</div>
			</div>			
		</script>

		<script id="commentTmpl" type="text/x-jquery-tmpl">
			<dl class="clearfix">
				<dt class="user-logo">
					<a href="#" title="{{= userName}}" target="_blank"><img src="{{= userProfile}}" alt="{{= userName}}" width="58" height="58">{{html userName}}</a>
				</dt>
				<dd class="txt">
					<p>{{html content}}</p>  
				</dd>
			</dl>
		</script>

        <script id="catalogTmpl" type="text/x-jquery-tmpl">
            <li style="{{= style}}"><a href="?page={{= pageNo}}">{{html title}}</a></li>
        </script>
		
		<style type="text/css">
			.right-list{
				padding: 0 !important;
				box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
				height: 800px;
				overflow: auto;
			}
			
			.right-list .nav li{
				width: 50%;
				text-align: center;
				font-size: 18px;
			}

			.right-list ol li{
				text-align: center;
				padding-top: 10px;
				padding-bottom: 10px;
				font-size: 16px;
				
			}
			.right-list ol .odd{
				background-color: #E5EBF1;
			}

			.short-comm dl{
			    border-bottom: 1px solid #eee;
			    padding-top: 20px;
			    display: block;
			    
			    padding-bottom: 20px;
		    }
		    .user-logo{
		    	float: left;
				width: 60px;
				padding-top: 4px;
				line-height: 18px;
				font-size: 12px;
				margin-right: 20px;
				
		    }
		    .short-comm dt{
		    	font-weight: normal;!important
		    }
		</style>


    </head>
    <body>
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

    	
		<div class="board" style="width:1920px;  height:900px;  padding-top:2%">
            <div class="col-md-3">
                <div class="catalog right-list">
                    <p style= "    text-align: center; font-size: 20px; font-weight: bold; padding-top: 2%;">目录</p>
                    <ol class="catalog-content right-list-content" style="list-style-type:none; padding:0px">
                        


                    </ol>
                </div>
            </div>
            <div class="col-md-8" style="">
                <div id="flip" class="container" >
                                    
                </div>
            </div>
			<div class="col-md-1"></div>
			
		</div>
		<div class ="comm" style = "width:100%; border-top-style: solid">
			<div class="comm-input-div" style="margin-left:10%; width:80%; margin-top:2%">
				<textarea class="comm-input" style="width:100%;height:100px"></textarea>
				<button class="btn btn-primary comm-input-btn" style="margin-left: 96.5%" >评论</button>
			</div>
			<div class="short-comm" style="overflow:auto;height:650px; margin-left:10%">
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
		
		<script type="text/javascript">
			
			function getBook(){
                var currUrl = window.location.href;
                var tmpList = currUrl.split('?')[0].split('/')
                var bookId = tmpList[tmpList.length - 1]


                dataJson = {
                    bid : bookId
                }

                url = "/MedicalRecord/book/get";
                $.ajax({
                  type: "GET",
                  url: url,
                  data: dataJson,
                  success: successCB,
                  error: errorCB,
                  dataType:"text"
                });

                function successCB(data){
                    data=eval('(' + data + ')');
                    console.log(data);
                    pageNum = data.pageNum;
                    bookId = data.id;
                    console.log('-------------------bid');
                    console.log(bookId);
                    catalog = eval('(' + data.catalog + ')');
                    // catalog = [{"pageNo":4,"title":"郁证"}, {"pageNo":17,"title":"瘀证"}];
                    for(var i = 0; i < catalog.length; i++){
                        if(i%2 == 0) catalog[i]["style"] = "background-color: #E5EBF1;";
                        $( '#catalogTmpl' ).tmpl(catalog[i]).appendTo($(".catalog-content"));
                    }
                    setLayout(bookId, pageNum);
                }

                function errorCB(){
                    console.log("get book error");
                }
            }


			var setLayout = function(bookId,pageNum, page){
                // console.log(pageNum);
				var $container 	= $( '#flip' );
				if(!page){
					var page = parseInt(window.History.getState().url.queryStringToJSON().page);
				}
				$container.flips({bookId:bookId, pagesCount:pageNum, current: page , batchSize:20});
			}


				
			$(function(){
                getBook();
				getComment();
			})

			window.onpopstate = function(event){
				getComment();
			}

			function getComment(){
				$(".short-comm").empty();
				dataJson = {
					bid : 1,
					page : parseInt(window.History.getState().url.queryStringToJSON().page)
				}

				url = "get_comment";
				$.ajax({
				  type: "GET",
				  url: url,
				  data: dataJson,
				  success: successCB,
				  error: errorCB,
				  dataType:"text"
				});

				function successCB(data,textStatus,jqXHR){
					data=eval('(' + data + ')');
					// console.log(data.length);
					
					data.forEach(function(record){
						comment = {
							userName: "内测用户",
							userProfile: "/MedicalRecord/resources/profile/1.jpg",
							content: record.content
						}

						$( '#commentTmpl' ).tmpl( comment ).appendTo($(".short-comm"));
					});
				}

				function errorCB(){
					console.log("error");
				}
			}

			function postComment(){
				
				dataJson = {
					cont : $(".comm-input").val(),
					uid : 1,
					bid : 1,
					page : parseInt(window.History.getState().url.queryStringToJSON().page)
				}

				url = "post_comment";
				$.ajax({
				  type: "POST",
				  url: url,
				  data: dataJson,
				  success: successCB,
				  error: errorCB,
				  dataType:"text"
				});

				function successCB(data,textStatus,jqXHR){
					
					getComment();
					$(".comm-input").val("");
				}

				function errorCB(){
					console.log("error");
				}
			}

			$(".comm-input-btn").on("click",postComment);
			
				
		</script>
    </body>
</html>