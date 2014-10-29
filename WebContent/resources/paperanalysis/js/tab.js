// JavaScript Document
var __OldTab;
var __OldTabItem;
function switchTabIndex(obj, controlNo){
	var __CurTab = obj.parentNode.parentNode.parentNode.parentNode.parentNode;	
	var ff_controlNo=0;
	var txtCount=0;
	var curTxtCount=0;
	var tabS = obj.parentNode.getElementsByTagName("A");
	if(__OldTabItem!=obj){
		//if(!__OldTabItem || !__OldTab)
		//	return;			
		if(__OldTab != __CurTab){			
			for(j=0; j<tabS.length; j++){
				if(tabS[j].className=="tabMenu_Selected")
					__OldTabItem = tabS[j];
			}		
		}
		var child = __CurTab.childNodes;
		var children;		
		for(a=0; a<child.length; a++)
		{
			if(child[a].className=="C_columnTabContent")
				children=child[a].childNodes;
		}
		for(i=0; i<children.length; i++){
			if(Object.prototype.toString.apply(children[i])=="[object Text]")
			{	
				txtCount++;
				continue;
			}			
			ff_controlNo++;
			if(controlNo==ff_controlNo)
			{
				curTxtCount=txtCount;				
			}			
			children[i].style.display="none";			
		}	
		
		for(n=0; n<__CurTab.childNodes.length; n++)
		{
			if(__CurTab.childNodes[n].className=="C_columnTabContent"){
				__CurTab.childNodes[n].childNodes[controlNo+curTxtCount-1].style.display="";
			}
		}
		
		obj.className = "tabMenu_Selected";
		__OldTabItem.className = "tabMenu";		
		__OldTabItem = obj;	
		__OldTab = __CurTab;
	}
}

function switchTab(obj, controlNo){	
	//alert(1);
	var __CurTab = obj.parentNode.parentNode.parentNode.parentNode.parentNode;	
	var ff_controlNo=0;
	var txtCount=0;
	var curTxtCount=0;
	var tabS = obj.parentNode.getElementsByTagName("A");
	if(__OldTabItem!=obj){
		//if(!__OldTabItem || !__OldTab)
		//	return;			
		if(__OldTab != __CurTab){			
			for(j=0; j<tabS.length; j++){
				if(tabS[j].className=="tabMenu_Selected")
					__OldTabItem = tabS[j];
			}		
		}
		var child = __CurTab.childNodes;
		var children;		
		for(a=0; a<child.length; a++)
		{
			if(child[a].className=="C_columnTabContent")
				children=child[a].childNodes;
		}
		for(var i=0; i<children.length; i++){
			if(Object.prototype.toString.apply(children[i])=="[object Text]")
			{	
				txtCount++;
				continue;
			}			
			ff_controlNo++;
			if(controlNo==ff_controlNo)
			{
				curTxtCount=txtCount;				
			}
			children[i].style.display="none";			
		}	
		
		for(n=0; n<__CurTab.childNodes.length; n++)
		{
			if(__CurTab.childNodes[n].className=="C_columnTabContent"){
				__CurTab.childNodes[n].childNodes[controlNo+curTxtCount-1].style.display="";
			}
		}
		obj.className = "tabMenu_Selected";
		__OldTabItem.className = "tabMenu";		
		__OldTabItem = obj;	
		__OldTab = __CurTab;
	}
}

function getRootPath(){    
	var projroot="ebooknew/";
	//获取当前网址，如： http://127.0.0.1:8181/ebooknew/index.html  
	var curWwwPath=window.document.location.href;
	var host = window.location.host;
	var htt=host.indexOf("http://");
	if(htt<0)host="http://"+host;
	var pos=curWwwPath.indexOf(projroot);
	var rootPath =""; 
	if (pos>0){
		rootPath = host+"/"+projroot;
	}else{
		rootPath = host;
	}
	//alert(pos+"===="+rootPath)
	return rootPath;
}

function totop() {  
       var count = 500; //每次的距离  
       var speed = 200; //速度  
       var timer = setInterval(function () {  
           var top_top = document.body.scrollTop || document.documentElement.scrollTop;  
           var tt = top_top - count;  
           tt = (tt < 300) ? 0 : tt;  
           if (top_top > 0)  
               window.scrollTo(tt, tt);  
           else  
               clearInterval(timer);  
       }, speed);
}


function showOrHidFolt() {
       if ($(window).width() < 1440) {
           $("#floatWindow").css("display", "none");
       } else {
           $("#floatWindow").css("display", "");
       }
}

function  heightSet(obj){  
	     var win=obj;//自动适应iframe的高度适用IE FF 
		    if (document.getElementById) 
		    { 
		        if (win && !window.opera) 
		        { 
		          if (win.contentDocument && win.contentDocument.body.offsetHeight) 
		            win.height = win.contentDocument.body.offsetHeight; 
		            else if(win.Document && win.Document.body.scrollHeight) 
		            win.height = win.Document.body.scrollHeight; 
		        } 
		    } 
}  
var mesDialog ;
function showMesDialog(id) {
	if(mesDialog!=null)mesDialog.close();
    mesDialog = art.dialog({
         title: '提示',
         content:document.getElementById(id),
         lock: false,
         fixed: true
     });
     
     setTimeout('mesDialog.close()',3000); 
    // mesDialog
}

function addshopbox(bookid){
	$.ajax({
        type : "POST",
        url : getRootPath()+"/book/addshopbox.html",
        data : {
			productid:bookid
        },
        dataType : "json",
        success : function(data) {
            if(data[0]){
				 var cframe = document.getElementById("sbframe");
				 //alert("添加成功");
				 //dialog();
				 if(cframe != null) {
   				 	cframe.contentWindow.location.reload();
   				 }
            }
            showMesDialog("addxuanshukuang");
            // $('.btn').dialog({content: 'hello world'});
            //else{
			//	alert("已经添加进购书框!");
            //}
        },
        error : function(errorMsg) {
            alert("系统出错,请稍后尝试");
        }
    });
}

function buyatonce(bookid){
	$.ajax({
        type : "POST",
        url : getRootPath()+"/book/buyatonce.html",
        data : {
			id:bookid
        },
        dataType : "json",
        success : function(data) {
            if(data){
   				 window.location.href=getRootPath()+"/book/showshopbox.html";
            }else{
				alert("系统出错,请稍后尝试");
            }
        },
        error : function(errorMsg) {
            alert("系统出错,请稍后尝试");
        }
    });
}

function addcompare(bookid){
	$.ajax({
        type : "POST",
        url : getRootPath()+"/book/addcompare.html",
        data : {
			productid:bookid
        },
        dataType : "json",
        success : function(data) {
            if(data[0]){
				 var cframe = document.getElementById("contrastframe");
				 //alert("添加成功");
				 if(cframe != null) {
				 	 cframe.contentWindow.location.reload();
				 }
            }
            showMesDialog("addduibikuang");
            //else{
            //	alert("已经添加进对比框!");
            //}
        },
        error : function(errorMsg) {
            alert("系统出错,请稍后尝试");
        }
    });
}

/**
 * 发起一个AJAX请求检查当前用户是否已登录
 * @param executeFun 
 * 		登录成功之后执行的方法，可支持直接传入方法或者方法名称，在登录成功之后自动执行
 */
function checkUserLogin(executeFun){
	jQuery.ajax({
		type:"post",
		url: getRootPath() + "/checkuserlogin.html",
		data:{},
		dataType:"text",
		success:function (data){
			eval("var resultObj=" + data);
			var loginFlag = resultObj.loginFlag;
			// 已登录
			if (loginFlag == "1"){
				if (executeFun){
					if (typeof executeFun == "function"){
						var func = executeFun;
						eval("func();");
					} else {
						eval(executeFun + "()");
					}
				}
			// 未登录
			} else {
				ShowDIV();
			}
		},
		error:function (){
			alert("系统出错,请稍后再试!");
		}
	});
}

function doAddFavoriteBookOnTab(id, type){
	jQuery.ajax({
		type:"post",
		url: getRootPath() + "/book/addFavoriteBook.html",
		data:{
			"bookId":id,
			"type":type
		},
		dataType:"text",
		success:function (data){
			eval("var resultObj=" + data);
			var result = resultObj.result;
			if (result == "1"){
				alert("您已经收藏过该图书！");
			} else {
				var message;
				// 想看
				if (type == 0){
					message = "已成功添加为想看的图书！";
				// 已看
				} else {
					message = "已成功添加为已看的图书！";
				}
				alert(message);
			}
		},
		error:function (){
			alert("系统出错,请稍后再试!");
		}
	});
}

/**
 * 添加为想看和已看图书
 * @param id 图书ID
 * @param type 添加图书类型，0为想看，1为已看
 */
function addFavoriteBook(id, type){
	var user = getUserCookie();
	if (user == null){
		doCallBack = function (){
			doAddFavoriteBookOnTab(id, type);
		};
		ShowDIV();
	} else {
		doAddFavoriteBookOnTab(id, type);
	}
}

/**
 * 添加为想看和已看图书
 * @param id 图书ID
 * @param type 添加图书类型，0为想看，1为已看
 */
function delFavoriteBook(id, type){
	jQuery.ajax({
		type:"post",
		url: getRootPath() + "/book/delFavoriteBook.html",
		data:{
			"bookId":id,
			"type":type
		},
		dataType:"text",
		success:function (data){
			alert("取消成功");
			window.location.href=getRootPath()+"/read/user/userhomefcate.html";
		},
		error:function (){
			alert("系统出错,请稍后再试!");
		}
	});
}

/**
 * 分享当前图书
 * @param id 图书ID
 */
function share(id){
	var url = "http://www.9yue.com/productdetail/" + id + ".html";
	//var result = copyToClipboard(url);
	
	jQuery.ajax({
		type : "post",
		url : getRootPath() + "/book/addBookShareCount.html",
		data : {
			"bookId" : id
		},
		dataType : "text",
		success : function() {
			//if (result){
			//	alert("当前图书地址已复制到剪切板，您可直接粘贴分享给好友！");
			//}
			
		},
		error : function() {
			alert("系统出错,请稍后再试!");
		}
	});
}
function sharamousemove(productId,text){
	var sharediv = document.getElementById("sharediv");
	var bdshares = document.getElementById("bdshare"); 
	var data = "{'url':'http://www.9yue.com/productdetail/"+productId+".html','text':" +text + "}";
	bdshares.data = data;
	sharediv.style.display = "block";
	
}
function sharaover(){
	var sharediv = document.getElementById("sharediv");
	sharediv.style.display = "none";
}

/**
 * 将文本内容添加到剪切板中
 * @param maintext 添加到剪切板中的文本内容
 */
function copyToClipboard(data){ 
	//处理非IE浏览器
	if (-[1,]){
		if (window.netscape){
			try { 
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
			} catch(e) { 
				alert("被浏览器拒绝！请在浏览器地址栏输入'about:config'并回车,然后将 'signed.applets.codebase_principal_support'设置为'true'之后再重试!");
				return false;
			}
		} else {
			alert("您使用的浏览器不支持此复制功能，请使用Ctrl+C或鼠标右键。");
			return false;
		}
	} else {
		var flag = window.clipboardData.setData("text", data);
		return flag;
	}
	return true;
}