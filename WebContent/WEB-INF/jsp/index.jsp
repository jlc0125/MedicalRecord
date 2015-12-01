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
<link href="<%=contextPath%>/resources/carousel.css" rel="stylesheet">

<style type="text/css">
  .img-circle{
    margin-left: 25%;
  }
  .img-title{
    text-align: center;
  }
</style>

<script type="text/javascript">
  $(function(){
    $(".function-image").on("click", function(){
      // console.log($(this).attr("name"));
      window.location.href="<%=contextPath%>/" + $(this).attr("name");
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
          <img src="<%=contextPath%>/resources/search/Images/newPic/search-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption">
              <h1>医案搜索</h1>
            </div>
          </div>
        </div>
        <div class="item">
          <img id="search" src="<%=contextPath%>/resources/search/Images/newPic/classify-browse-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption">
              <h1>分类浏览</h1>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="<%=contextPath%>/resources/search/Images/newPic/analysis-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption">
              <h1>医案分析</h1>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="<%=contextPath%>/resources/search/Images/newPic/read-bg.jpg"/>
          <div class="container">
            <div class="carousel-caption">
              <h1>医书阅读</h1>
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
        <div class="col-lg-3">
          <img class="img-circle function-image" name="search" src="<%=contextPath%>/resources/search/Images/newPic/search-icon-clean.png" alt="Generic placeholder image" width="140" height="140">
          <h2 class="img-title">医案搜索</h2>
          
          
        </div><!-- /.col-lg-3 -->
        <div class="col-lg-3">
          <img class="img-circle function-image" name="browse" src="<%=contextPath%>/resources/search/Images/newPic/classify-browse-icon-clean.png" alt="Generic placeholder image" width="140" height="140">
          <h2 class="img-title">分类浏览</h2>
          
        </div><!-- /.col-lg-3 -->
        <div class="col-lg-3">
          <img class="img-circle function-image" name="analysishome" src="<%=contextPath%>/resources/search/Images/newPic/analysis-icon-clean.png" alt="Generic placeholder image" width="140" height="140">
          <h2 class="img-title">医案分析</h2>
          
        </div><!-- /.col-lg-3 -->
        <div class="col-lg-3">
          <img class="img-circle function-image" name="book" src="<%=contextPath%>/resources/search/Images/newPic/read-icon-clean.png" alt="Generic placeholder image" width="140" height="140">
          <h2 class="img-title">医书阅读</h2>
          
        </div><!-- /.col-lg-3 -->
      </div><!-- /.row -->


      <!-- START THE FEATURETTES -->

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading"><span class="text-muted">多角度搜索</span></h2>
          <p class="lead">从中药、病症、方剂等多角度搜索相关医案</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" src="<%=contextPath%>/resources/search/Images/newPic/search-icon.png" alt="医案搜索" style="width:40%;height:40%">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7 col-md-push-5">
          <h2 class="featurette-heading"><span class="text-muted">多层面分类</span></h2>
          <p class="lead">医案数据按照疾病、治则、辩证和词频四方面分类</p>
        </div>
        <div class="col-md-5 col-md-pull-7">
          <img class="featurette-image img-responsive center-block" src="<%=contextPath%>/resources/search/Images/newPic/classify-browse-icon.png" style="width:40%;height:40%" alt="Generic placeholder image" >
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading"><span class="text-muted">多方面分析</span></h2>
          <p class="lead">中药、疾病、方剂、辩证和治则五种角度分析医案集数据</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" src="<%=contextPath%>/resources/search/Images/newPic/analysis-icon.png" style="width:40%;height:40%" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">
      
      

      <!-- /END THE FEATURETTES -->



    </div><!-- /.container -->
    <!-- footer -->
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
</body>
</html>
