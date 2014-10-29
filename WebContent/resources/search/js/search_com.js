
/*2大类映射*/
var typeChMap = ["医生姓名","其他信息"];
var typeEnMap = ["doctor","other"];



function concatStr(str){
	return "%" + str +"%";
}

/*把空格分隔多关键字加上‘%’再组成数组，方便mtbatis模糊foreach查询*/
function transMultiKeyword(str){
  rs = new Array;
  
  if(str != "null" && str != null){
	  rs = str.split(" ");
	  
	  for(var i = 0; i < rs.length; i++){
		  rs[i] = concatStr(rs[i]);
	  }
  }
  
  else rs[0] = "%%";
 
  return rs;
}

function transNullString(str){
	return str == null? "无" : str;
}

function transMultiKeywordFromUrl(str){
	return transMultiKeyword(decodeURI(getUrlParam(str)));
}

/*根据url得到查找信息开始处*/
function getListStart(){
	return getUrlParam("pageno") == null ? 0 :(parseInt(getUrlParam("pageno"))-1)*pageSize;
}

/*6大类进行中英转换*/
function typeChToEn(type){	
	for(var i = 0 ; i < typeChMap.length ; i++)
		if(typeChMap[i] == type)
			return typeEnMap[i];
	return type;
}
function typeEnToCh(type){	
	for(var i = 0 ; i < typeEnMap.length ; i++)
		if(typeEnMap[i] == type)
			return typeChMap[i];
	
	return type;
}


/*把返回信息列表组成table格式*/
function listToTable(data){
	
	
	var table = "";
	
	for(var i = 0 ; i < data.length ; i++) {
    	
        var field1 = transNullString(data[i].field1);
        var field2 = transNullString(data[i].field2);
        var field3 = "";
        
        var listClass="";
       
        var prefix = "<tr><td class='list_field1'><a href='#' class='doctor_list_name'>";
        var medInfo = prefix + field1 +"</a></td><td class='list_field2'><a href='#' class='case_list_name'>" + field2 + "</a></td></tr>";
        
        
        table += medInfo;
    }
	
	return table;
}


function getTableTitle(type){
	var prefix = "<tr class='success'><th>";
	var suffix = "</th></tr>";
	if(type == "doctor")
		return prefix + "医生姓名</th><th>生平介绍" + suffix;
	if(type == "other") 
		return prefix + "医生姓名</th><th>病例名称" + suffix;
	
}

/*对table中进行点击名字事件绑定*/
$(function(){

	$('.doctor_list_name').live('click', function () {
		window.open("./doctor?drname=" + $(this).text()+"&pageno=1");
	});
	
	$('.case_list_name').live('click', function () {
		window.open("./casedetail?casename=" + $(this).text()+"&pageNo=1");
	});
	
	
	
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
