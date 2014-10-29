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
            html, body  { height:100%; }
            body { margin:0; padding:0; overflow:auto; text-align:center; 
                   background-color: #ffffff; }   
            object:focus { outline:none; }
            #flashContent { display:none; }
        </style>
        
        <!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->

    </head>
    <body bgColor="transparent" onload="analysisURL()">
	        <script type="text/javascript">
			
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
			
			function analysisURL(){

				
				if (getParam("videoPath") != ""){
				
					if (getParam("startTime") != ""){
						
						changeVideoSource(getParam("videoPath"),getParam("startTime"));
						//setTimeout(videoPlay,5000);
					}
					else{
					
						changeVideoSource(getParam("videoPath"),0);
							
					}
					
				}

			}

	function getStartTime(){

		return getParam("startTime");
	}
	
	function getVideoName(){

		return getParam("videoPath");
	}
	
	function getMediaServer(){

		return "rtmp://10.15.62.168/mediaplayer";
	}

			
			function videoPlay(){
			
				document.getElementById("VideoImport").playVideo();
			}

			function changeVideoSource(videoPath,startTime)
			{
				document.getElementById("VideoImport").changeVideoSource(videoPath,startTime);
			}
 
        </script>
        <!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
             JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
             when JavaScript is disabled.
        -->
        <div id="flashContent">
            <p>
                To view this page ensure that Adobe Flash Player version 
                10.2.0 or greater is installed. 
            </p>
            <script type="text/javascript"> 
                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
            </script> 
        </div>
        
        
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="350" height="300" id="VideoImport">
                <param name="movie" value="<%=request.getContextPath()%>/resources/search/video/VideoImport.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#ffffff" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowFullScreen" value="true" />
				<param name="wmode" value="transparent">
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="<%=request.getContextPath()%>/resources/search/video/VideoImport.swf" width="350" height="300">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#ffffff" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="allowFullScreen" value="true" />
					<param name="wmode" value="transparent">
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
            
   </body>
</html>
