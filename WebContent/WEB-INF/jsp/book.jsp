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
    <script type="text/javascript" src="/MedicalRecord/resources/test/js/jquery.tmpl.min.js"></script>
	<!-- exlib -->
	
	<!-- css -->
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" type=text/css href="<%=contextPath%>/resources/search/css/browse.css">
	
	
	<style type="text/css">
        .book-filter{
            margin-top: 50px;
        }

        .book-search{
            margin-top: 50px;
        }
        .book-search .btn{
            height: 46px;
            line-height: 40px;
            font-size: 16px;
            padding: 0;
            margin: 0;
            width: 80px;
        }

        .book-search input{
            line-height: 20px;
            width: 200px;
            padding: 10px 9px 10px 7px;
            vertical-align: middle;
            font-size: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.2);
        }
		.product{
			position: relative;
			float: left;
			padding: 0;
			margin: 0;
			line-height: 1.5;
			overflow: hidden;
			z-index: 1;
			height: 290px;
			margin-left: 8px;
			margin-right: 8px;
		}
		.product-iWrap{
			position: absolute;
			background-color: #fff;
			border-color: #fff;
			margin: 0;
			padding: 10px;
			font-size: 0;
		}
	</style>

    <script id="bookTmpl" type="text/x-jquery-tmpl">
          <div class="product" style="width:150px;float:left;">
                <div class="product-iWrap" style="width:150px;float:left;">
                    <!--Image-->
                    <div class="hglpic">
                        <a href="read/{{= id}}?page=0" target="_blank" style="color:#0064A9;">
                            <abbr title="点击查看图书">
                                <img class="bookimg" src="{{= imgSrc}}" onerror="javascript:this.src='<%=contextPath%>/resources/book/none-cover.jpg'">
                            </abbr>
                        </a>
                    </div>

                    <!--Title-->
                    <p class="productTitle" style="text-align:left;margin-left:6px;margin-right:6px;">
                    <a href="read/{{= id}}?page=0" target="_blank" style="color:#0064A9;">
                        <abbr title="{{= title}}">{{= title}}</abbr>
                    </a>
                    </p>

                    <!--Author-->
                    <p class="productAuthor" style="text-align:left;margin-left:6px;margin-right:6px;">
                    <span style="display:inline-block;TEXT-ALIGN:left;" onmouseover="this.className='authorEffect'" onmouseout="this.className=''">
                        <font size="2">
                            <abbr title="{{= author}}">{{= author}}</abbr>
                        </font>
                    </span>
                    </p>

                    <!--Press-->
                    <p class="productPress" style="text-align:left;margin-left:6px;margin-right:6px;">
                    <span style="display:inline-block;text-align:left; "> 
                        <font size="2">
                            <abbr title="{{= publisher}}">{{= publisher}}</abbr>
                        </font>
                    </span>
                    </p>
                </div>
            </div>
    </script>
	
	
    <script type="text/javascript">
        function checkImgExists(imgurl) {  
          var ImgObj = new Image(); //判断图片是否存在  
          ImgObj.src = imgurl;  
          //没有图片，则返回-1  
          if (ImgObj.fileSize > 0 || (ImgObj.width > 0 && ImgObj.height > 0)) {  
            return true;  
          } else {  
            return false;
          }  
        } 
        function getBook(keyword,type){
            if(type == "filter"){
                url = "/MedicalRecord/book/pinyin_filter";
                dataJson = {
                    c:keyword
                };
            }
            else if(keyword == undefined || keyword ==''){
                url = "/MedicalRecord/book/get_all";
                dataJson = {};
            }
            else{
                url = "/MedicalRecord/book/search";
                dataJson = {
                    q:keyword
                };
            }
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
                    for(var i = 0; i < data.length; i++){
                        imgSrc = "<%=contextPath%>/resources/book/" + data[i].id + "/cover.jpg";
    
                        data[i].imgSrc = imgSrc;
                        $('#bookTmpl').tmpl(data[i]).appendTo($('.view'));
                    }
                }

                function errorCB(){
                    console.log("get book error");
                }
            }

        $(function(){
            getBook("","search");
            $('.book-search .btn').click(function(){
                keyword = $('.book-search input').val();
                $('.view').empty();
                getBook(keyword,"search");
            })

            $(".form-control").change(function(){
                var label = $(this).children('option:selected').val().toLowerCase();
                $('.view').empty();
                getBook(label,"filter");
                
            })
        })

    </script>
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
    <div class=logoSearch>
        <div class="logoSearch_L2">
            <div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
            <div class="clearfix"></div>
        </div>
    </div>

	
    <div class="col-md-2">
        <div class="book-search">
            <h3>搜索图书</h3>
            <input>
            <button class="btn btn-primary">搜索</button>
        </div>
        <div class="book-filter">
            <h3>按字母序浏览</h3>
            <select class="form-control">
                <option value=""></option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
                <option value="E">E</option>
                <option value="F">F</option>
                <option value="G">G</option>
                <option value="H">H</option>
                <option value="I">I</option>
                <option value="J">J</option>
                <option value="K">K</option>
                <option value="L">L</option>
                <option value="M">M</option>
                <option value="N">N</option>
                <option value="O">O</option>
                <option value="P">P</option>
                <option value="Q">Q</option>
                <option value="R">R</option>
                <option value="S">S</option>
                <option value="T">T</option>
                <option value="U">U</option>
                <option value="V">V</option>
                <option value="W">W</option>
                <option value="X">X</option>
                <option value="Y">Y</option>
                <option value="Z">Z</option>
            </select>
        </div>
    </div>
    <div class="col-md-8">
		<div class="view" style="margin-bottom:40px;width:100%;background-color:white;float:left;">
		</div>
    </div>


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
    <div class="col-md-12">
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
   </div>
</BODY>
</HTML>
