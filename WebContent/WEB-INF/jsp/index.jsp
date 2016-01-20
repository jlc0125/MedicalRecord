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

<!-- css -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" type=text/css href="<%=contextPath%>/resources/common/css/logo.css">
<link href="<%=contextPath%>/resources/carousel.css" rel="stylesheet">


<script type="text/javascript">
  $(function(){
    $(".function-image").on("click", function(){
      // console.log($(this).attr("name"));
      window.location.href="<%=contextPath%>/" + $(this).data("name");
    })
  })
</script>


  
</head>

<body>
  <div class=top>
    <div>
        <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/css/nav_header.css"></link>
        <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/commonpages/dropdown/dropdown.css"></link>
        <script src="<%=contextPath%>/resources/commonpages/js/nav_header.js"></script>
        <%@include file="/WEB-INF/jsp/common/header.jsp"%>
    </div>
    <div class=logoSearch>
      <div class="logoSearch_L2">
        <div class="logo"><a href="index.html" target=_blank><IMG src="<%=contextPath%>/resources/search/Images/logo.png"></A></div>
        <div class="clearfix"></div>
      </div>
    </div>
    
  </div>
  
    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
        <li data-target="#myCarousel" data-slide-to="3"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img class="function-image" data-name="search" src="<%=contextPath%>/resources/search/Images/newPic/search-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption caption1">
              <h1>医案搜索</h1>
              <p>从中药、病症、方剂等多角度搜索相关医案</p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="function-image" data-name="browse" src="<%=contextPath%>/resources/search/Images/newPic/classify-browse-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption caption1">
              <h1>分类浏览</h1>
              <p>医案数据按照疾病、治则、辩证和词频四方面分类</p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="function-image" data-name="recipehome" src="<%=contextPath%>/resources/search/Images/newPic/analysis-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption caption1">
              <h1>医案分析</h1>
              <p>中药、疾病、方剂、辩证和治则五种角度分析医案集数据</p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="function-image" data-name="book" src="<%=contextPath%>/resources/search/Images/newPic/read-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption caption1">
              <h1>医书阅读</h1>
              <p>提供全面、齐全的医书阅读</p>
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div><!-- /.carousel -->
    
     <div class="container marketing">

      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-3 function-item function-image" data-name="search">
          <i class="function-icon icon-search"></i> 
            <h2 class="img-title">医案搜索</h2> 
        </div><!-- /.col-lg-3 -->

        <div class="col-lg-3 function-item function-image" data-name="browse">
          <i class="function-icon icon-classify"></i> 
          <h2 class="img-title">分类浏览</h2>
        </div><!-- /.col-lg-3 -->
        
        <div class="col-lg-3 function-item function-image" data-name="analysis_all">
          <i class="function-icon icon-analysis"></i> 
          <h2 class="img-title">医案分析</h2>          
        </div><!-- /.col-lg-3 -->
        
        <div class="col-lg-3 function-item function-image" data-name="book">
        	<i class="function-icon icon-read"></i>  
          	<h2 class="img-title">医书阅读</h2>          
        </div><!-- /.col-lg-3 -->
        
        <div class="col-lg-3 function-item function-image" data-name="revision">
        	<i class="function-icon icon-revision"></i>  
          	<h2 class="img-title">错误修正</h2>          
        </div><!-- /.col-lg-3 -->
      </div><!-- /.row -->
    </div><!-- /.container -->

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