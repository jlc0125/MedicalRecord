
/**
 * 获取字符串的长度
 *中文字和全角符号长度为2，英文为1
*/
function getStrLength(str){
	var len = str.length;
    var reLen = 0;
    for (var i = 0; i < len; i++) {        
        if (str.charCodeAt(i) < 27 || str.charCodeAt(i) > 126) {
            // 全角    
            reLen += 2;
        } else {
            reLen++;
        }
    }
    return reLen;  
}
/**
 *去左空格 
*/
function LTrim(str){ 
return str.replace(/^\s*/g,""); 
}  
/**
*去右空格
*/ 
function RTrim(str){ 
return str.replace(/\s*$/g,""); 
} 

/**
*去首尾空格 
*/
function Trim(str){ 
return str.replace(/^\s*|\s*$/g,""); 
} 

/**
*空值判断
*/
function isEmpty(str){
	return (str==null||str.replace(/(^\s*)|(\s*$)/g,"")=='');
} 
/**项目路径 全网址*/
function getRootPath(){    
	var projroot="ebooknew";
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
$(function(){
			
			
			input("q", "请输入任意文字......");//s即时input框的ID
		});
		
		//搜索清空文字脚本
		function input(theInput, val) {
			var $input = $("#"+theInput+"");
			var val = val;
			$input.attr({value:val});
			$input.focus(function() {
			if ($input.val() == val) {
				$(this).attr({value:""});
			}
			}).blur(function() {
				if ($input.val() == "") {
				$(this).attr({value:val});
				}
			});
		}
