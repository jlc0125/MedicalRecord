<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0014)about:internet -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en"> 
    <!-- 
    Smart developers always View Source. 
    
    This application was built using Adobe Flex, an open source framework
    for building rich Internet applications that get delivered via the
    Flash Player or to desktops via Adobe AIR. 
    
    Learn more about Flex at http://flex.org 
    // -->
    <head>
        <title></title>
        <meta name="google" value="notranslate" />         
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Include CSS to eliminate any default margins/padding and set the height of the html element and 
             the body element to 100%, because Firefox, or any Gecko based browser, interprets percentage as 
             the percentage of the height of its parent container, which has to be set explicitly.  Fix for
             Firefox 3.6 focus border issues.  Initially, don't display flashContent div so it won't show 
             if JavaScript disabled.
        -->
        <style type="text/css" media="screen"> 
            html, body  { height:550px; width:750px }
            body { margin:0; padding:0; overflow:auto; text-align:center; }   
            object:focus { outline:none; }
            #flashContent { display:none; }
        </style>
        
        <!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/search/map/history/history.css" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/resources/search/map/history/history.js"></script>
       	<script src="<%=request.getContextPath()%>/resources/common/ajax.js"></script>
        <!-- END Browser History required section -->  
            
        <script type="text/javascript" src="<%=request.getContextPath()%>/resources/search/map/swfobject.js"></script>
		<script src="<%=request.getContextPath()%>/resources/common/jquery_1_8_3.js"></script>	
        <script type="text/javascript">     
            // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. 
            var swfVersionStr = "10.2.0";
            // To use express install, set to playerProductInstall.swf, otherwise the empty string. 
            var xiSwfUrlStr = "<%=request.getContextPath()%>/resources/search/map/playerProductInstall.swf";
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.wmode = "transparent"
            //params.wmode = "opaque"
            var attributes = {};
            attributes.id = "zyy";
            attributes.name = "zyy";
            attributes.align = "middle";
            swfobject.embedSWF(
                "<%=request.getContextPath()%>/resources/search/map/zyy.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
            // JavaScript enabled so display the flashContent div in case it is not replaced with a swf object.
            swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        </script>
    </head>
    <body>
        <!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
             JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
             when JavaScript is disabled.
        -->

		

		<script type="text/javascript"> 
		
			var map1;

			function getParam(paramName){
				paramValue = "";
				isFound = false;
				if (decodeURIComponent(this.location.search).indexOf("?") == 0 && decodeURIComponent(this.location.search).indexOf("=")>1)
				{
					arrSource = unescape(decodeURIComponent(this.location.search)).substring(1,decodeURIComponent(this.location.search).length).split("&");
					i = 0;
					while (i < arrSource.length && !isFound)
					{
						if (arrSource[i].indexOf("=") > 0)
						{
							 if (arrSource[i].split("=")[0].toLowerCase()==paramName.toLowerCase())
							 {
								paramValue = arrSource[i].split("=")[1];
								isFound = true;
							 }
						}
						i++;
					}   
				}
			   return paramValue;
			}
			
			
			function initMap(){
				if (getParam("parm") == "mark"){
					window.parent.markMap();
					markGhostLocation();	
				}				
			}
			
			var locationNameSet = new Array("湖南","辽宁","内蒙古","浙江","黑龙江","陕西","台湾","广西","安徽","湖北","贵州","福建","山西","西藏","河南","江西","海南","山东","江苏","云南","北京","广东","天津","上海","新疆","青海","吉林","河北","四川","重庆","甘肃","宁夏");
			
			function markGhostLocation(){

				for(var i=0; i<locationNameSet.length; i++){

					 var dataJson = 
						{
							"locationname":locationNameSet[i],
						};
						
						var data = JSON.stringify(dataJson);
						var methodType = "POST";
						var url = "./medlocation";
						var contentType = "application/json;charset=utf-8";
						
						ajaxFunc(methodType,url,data,contentType,markGhostLocationSuccessCB,markGhostLocationErrorCB);									
				}						
			}
			
			function markGhostLocationSuccessCB(data, textStatus, jqXHR){
				print(data);
				
				var tmpInfo = data.medlocation.locationname + "盛产的药材为：";

				for(var i=0; i<data.medname.length; i++){				
					tmpInfo += data.medname[i] +" ";

				}
				markGhostLocationEx(data.medlocation.lat,data.medlocation.lng,tmpInfo);		
			}
			
			function markGhostLocationErrorCB(){}
			
			function isReady(){
				return true;
			}
		
			function cacheMap(){	
				if (navigator.appName.indexOf('Microsoft') != -1)
					map1=window['zyy'];
				else 
					map1=document['zyy'];			
			}
		
			function test(){
				requestData(120,30,"");			
			}
		
            function requestData(x,y,info)
			{
				var map;
				if (navigator.appName.indexOf('Microsoft') != -1)
					map=window['zyy'];
				else 
					map=document['zyy'];

				map.addCustomMarkerCoord("100","30","","<%=request.getContextPath()%>/resources/search/map/assets/images/poi-red.png",info,200,80);
			}
			
            function markGLocation(x,y,info)
			{
				var map;
				if (navigator.appName.indexOf('Microsoft') != -1)
					map=window['zyy'];
				else 
					map=document['zyy'];

				map.addCustomMarkerCoord(x,y,"","<%=request.getContextPath()%>/resources/search/map/assets/images/poi-red.png",info,200,80);
			}
			
            function markGhostLocationEx(x,y,info)
			{

				var map;
				if (navigator.appName.indexOf('Microsoft') != -1)
					map=window['zyy'];
				else 
					map=document['zyy'];

				map.addCustomMarkerCoord(x,y,"","<%=request.getContextPath()%>/resources/search/map/assets/images/transparent.png",info,200,80);
			}
	
            function markLocation(x,y,info)
			{
				var map;
				if (navigator.appName.indexOf('Microsoft') != -1)
				{
					map=window['zyy'];
				} 
				else 
				{
					map=document['zyy'];
				}

				map.addCustomMarkerCoord(x,y,"","<%=request.getContextPath()%>/resources/search/map/assets/images/poi03.png",info,200,80,info,"hehe");

			}
			
			function hehe(data){
			// alert(data);
			}
			
			
			function cancelData()
			{
				var map;
				if (navigator.appName.indexOf('Microsoft') != -1)
				{
					map=window['zyy'];
				} 
				else 
				{
					map=document['zyy'];
				}
				

				map.clearFeatures();
				

			}
			
			function getURL(){
				return "http://10.15.62.103:7687/geoserver/wms";
			//return "http://localhost:9999/geoserver/xiandai/wms";
			//return "http://www.udms.org/geoserver/wms";
			//return "http://10.15.62.32:9999/geoserver/xiandai/wms";
			
			}
			
			function getZoom(){
				return 4;
			}
			
			function getLayerName(){
				return "bou2_4p";
			}
			
			function getX(){
			 return 105;
			}
			
			function getY(){
			return 36;
			}			

        </script>
		
        <div id="flashContent">


        </div>
        
        <noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="zyy">
                <param name="movie" value="<%=request.getContextPath()%>/resources/search/map/zyy.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#ffffff" />
                <param name="allowScriptAccess" value="always" />
                <param name="allowFullScreen" value="true" />
                <param name="wmode" value="transparent" />
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="<%=request.getContextPath()%>/resources/search/map/zyy.swf" width="100%" height="100%">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#ffffff" />
                    <param name="allowScriptAccess" value="always" />
                    <param name="allowFullScreen" value="true" />
                    <param name="wmode" value="transparent" />
                <!--<![endif]-->
                <!--[if gte IE 6]>-->
                    <p> 
                        Either scripts and active content are not permitted to run or Adobe Flash Player version
                        10.2.0 or greater is not installed.
                    </p>
                <!--<![endif]-->
                    <a href="http://www.adobe.com/go/getflashplayer">
                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
                    </a>
                <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
            </object>
        </noscript>     
   </body>
</html>
