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
      .content{
        border-top: 1px solid #ddd;
      }
      .comm{
          width:100%; 
          border-left-style: solid;
          padding-right: 40px;
      }
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
	    .book-type ul { 
        list-style:none; 
        text-align: right;
        padding-right: 20px;
      }
			.book-type ul li { }
			.book-type ul li a { }
			.book-type:after{
				clear:both;
			}
			.book-type ul li a.active,
			.book-type ul li a:hover { color:#d91d2a;font-weight:bold; }
		</style>


    </head>
    <body>
    	<div class=top>
			<div>
			    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
			    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
			    <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
				<%@include file="/WEB-INF/jsp/common/header.jsp"%>
			</div>
			
		</div>

    	<div class="basic-information">
    		<div class="book-name" style="text-align:center;">
				    <h2 id="book-title"></h2>
        </div>
			<div class="book-type" >
				<ul>
                	<li><a id="pic" class="active" href="javascript:void(0);">图片</a></li>
                	<li><a id="text" href="javascript:void(0);">文本</a></li>
                	<li><a id="pic-text" href="javascript:void(0);">图片&文本</a></li>
            	</ul>
            </div>
    	</div>
    <div class = "content">
    <div class="pic-board  showup">
		<div class="board" style="width:1920px;  height:900px;  padding-top:2%">
			<div class="col-md-1">
                <div class="catalog right-list">
                    <p style= "    text-align: center; font-size: 20px; font-weight: bold; padding-top: 2%;">目录</p>
                    <ol class="catalog-content right-list-content" style="list-style-type:none; padding:0px">
                    </ol>
                </div>
            </div>
			
			<div class="col-md-8" style="">
    				<div class="flip" class="container" >
    									
    				</div>
    			</div>
    			<div class="col-md-3">
    				<div class ="comm" style = "width:100%; border-left-style: solid">
                        <h1 style="text-align: center;">评论区</h1>
                        <div class="comm-input-div" style="margin-left:10%; width:80%; margin-top:2%">
                            <textarea class="comm-input" style="width:100%;height:100px"></textarea>
                            <button class="btn btn-primary comm-input-btn" style="margin-left: 96.5%" >评论</button>
                        </div>
                        <div class="short-comm" style="overflow:auto;height:650px; margin-left:10%">
                        </div>
                    </div>
    			</div>
    		</div>
		</div>
		<div class="text-board " style="height:900px;display:none;min-width:">
			<div class="col-md-2" ></div>
			<div class="col-md-8" style="height:100%;">
				<iframe class="text-book-iframe" src="" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			<div class="col-md-2" ></div>
		</div>
		<div class="pic-text-board" style="display:none;height:2500px;" >
			<div class="board" style="width:1920px;  height:900px;  padding-top:2%">
			<div class="col-md-1">
                <div class="catalog right-list">
                    <p style= "    text-align: center; font-size: 20px; font-weight: bold; padding-top: 2%;">目录</p>
                    <ol class="catalog-content right-list-content" style="list-style-type:none; padding:0px">
                        


                    </ol>
                </div>
            </div>

			<div class="col-md-8" style="">
				<div class="flip" class="container" >
									
				</div>
			</div>
			<div class="col-md-3">
                    <div class ="comm" >
                        <h1 style="text-align: center;">评论区</h1>
                        <div class="comm-input-div" style="margin-left:10%; width:80%; margin-top:2%">
                            <textarea class="comm-input" style="width:100%;height:100px"></textarea>
                            <button class="btn btn-primary comm-input-btn" style="margin-left: 96.5%" >评论</button>
                        </div>
                        <div class="short-comm" style="overflow:auto;height:650px; margin-left:10%">
                        </div>
                    </div>
                </div>
		</div>
        <div class="text-book-div" style="border-top-style: solid;">
            <h1 style="text-align: center;padding: 30px;">文本电子书籍</h1>
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<iframe class="text-book-iframe" src="" width="100%" height="700px" frameborder="0"></iframe>
			</div>
			<div class="col-md-2"></div>
        </div>
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
                    var type = data.type;
                    console.log(data);
                    var bookTitle = data.title;
                    $("#book-title").html(bookTitle);
                    switch(type){
                    case 1:

                        $("pic").click();
                        $("#text").unbind();
                        $("#text").css("color","gray");
                        $("#pic-text").unbind();
                        $("#pic-text").css("color","gray");

                        //set pic-book
                        pageNum = data.pageNum;
                        bookId = data.id;
                        if(data.catalog){
                            catalog = eval('(' + data.catalog + ')');
                        }
                        else{
                            catalog=[];
                        }

                        for(var i = 0; i < catalog.length; i++){
                          console.log(catalog[i]);
                          console.log(Math.floor(catalog[i].pageNo/2));
                            catalog[i].pageNo = Math.floor(catalog[i].pageNo/2);
                            if(i%2 == 0) catalog[i]["style"] = "background-color: #E5EBF1;";
                            $( '#catalogTmpl' ).tmpl(catalog[i]).appendTo($(".catalog-content"));
                        }
                        setLayout(bookId, pageNum);
                        break;

                    case 2:
                        //set text-book
                        var textBookpre = "http://zcy.ckcest.cn/DocAssist/learning/book#/book/";
                        var daId = data.da_id
                        var textBookSrc = textBookpre+daId;
                        
                        $(".text-book-iframe").attr("src",textBookSrc);
                        $("#text").click();
                        $("#pic").unbind();
                        $("#pic").css("color","gray");
                        $("#pic-text").unbind();
                        $("#pic-text").css("color","gray");
                        break;

                    case 3:
                        
                        $("#pic-text").click();
                        //set pic-book
                        pageNum = data.pageNum;
                        bookId = data.id;
                        if(data.catalog){
                            catalog = eval('(' + data.catalog + ')');
                        }
                        else{
                            catalog=[];
                        }

                        for(var i = 0; i < catalog.length; i++){
                            catalog[i].pageNo = Math.floor(catalog[i].pageNo/2);
                            if(i%2 == 0) catalog[i]["style"] = "background-color: #E5EBF1;";
                            $( '#catalogTmpl' ).tmpl(catalog[i]).appendTo($(".catalog-content"));
                        }
                        setLayout(bookId, pageNum);

                        //set text-book
                        var textBookpre = "http://zcy.ckcest.cn/DocAssist/learning/book#/book/";
                        var daId = data.da_id
                        var textBookSrc = textBookpre+daId;
                        var bookTitle = data.title;
                        $("#book-title").html(bookTitle);
                        $(".text-book-iframe").attr("src",textBookSrc);

                        break;
                    }


                }

                function errorCB(){
                    console.log("get book error");
                }
            }


			var setLayout = function(bookId,pageNum, page){
                // console.log(pageNum);
				var $container 	= $( '.flip' );
				if(!page){
					var page = parseInt(window.History.getState().url.queryStringToJSON().page);
				}
				$container.flips({bookId:bookId, pagesCount:pageNum, current: page , batchSize:20});
			}



			// var $container 	= $( '#flip' );
			// $container.flips({pagesCount:100, nextPage:0, batchSize:20});

			// $container.on("DOMSubtreeModified",setLayout);
				
			$(function(){
				$(".book-type a").click(function(){
					$(".active").removeClass("active");
					$(this).addClass("active");
					var type = $(this).attr("id");
					switch(type){
					case "pic":
						$(".showup").hide();
						$(".showup").removeClass("showup");
						$(".pic-board").show();
						$(".pic-board").addClass("showup");
						break;
					case "text":
						$(".showup").hide();
						$(".showup").removeClass("showup");
						$(".text-board").show();
						$(".text-board").addClass("showup");
						break;
					case "pic-text":
						$(".showup").hide();
						$(".showup").removeClass("showup");
						$(".pic-text-board").show();
						$(".pic-text-board").addClass("showup");
						break;
					}
					
				});

                
                getComment();
                getBook();

			});

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
			function getUrlParam(name) {
				var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
				var r = window.location.search.substr(1).match(reg); // 匹配目标参数
				if (r != null)
					return r[2];
				return null; // 返回参数值
			}
				
		</script>
    </body>
</html>