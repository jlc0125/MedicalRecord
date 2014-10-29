/*是否预览图片*/
var listShowPicFlag = [true,true,true,false,false,false];

/*图片地址前缀*/
var picUrl = "http://10.15.62.32:8888/tcmpro/pictures/search/";


/*6大类映射*/
var typeChMap = ["方剂","药物","疾病","症状"];
var typeEnMap = ["Pre","Med","Dis","Sym"];


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

/*根据类型得到是否预览图片*/
function isShowPic(type){
	for(var i = 0 ; i < typeChMap.length ; i++)
		if(typeChMap[i] == type)
			return listShowPicFlag[i];
	for(var i = 0 ; i < typeEnMap.length ; i++)
		if(typeEnMap[i] == type)
			return listShowPicFlag[i];
}

/*把返回信息列表组成table格式*/
function listToTable(data,type){
	
	/*显示文字版版本*/
	/*if(data.length == 0)
		return "<tr><td></td><td class='null_info'>暂无信息</td><td></td></tr>";*/
	
	/*显示图片版本*/
	//var nodata = getRootPath() + "/resources/commonpages/images/no_data.png";
	//if(data.length == 0)
		//return "<tr><td></td><td class='null_info'><img src=" + nodata + " width=311px height=223px /></td><td></td></tr>";
	
	var table = "";
	
	for(var i = 0 ; i < data.length ; i++) {
    	
        var field1 = transNullString(data[i].field1);
        var field2 = transNullString(data[i].field2);
        var field3 = "";
        /*显示文字版本*/
        /*判断是否预览图片*/
        /*if(isShowPic(type))
        	field3 = "<img class='preview_pic' src=" + picUrl + type + "/" + transNullString(data[i].field4) + ".jpg onerror='$(this).hide()' onload='$(this).show()'/>";
        else field3 = transNullString(data[i].field3);*/
        
        /*显示图片版本*/
       /*var nopic = getRootPath() + "/resources/home/Images/no_pic.png";
       if(isShowPic(type)){
        	field3 = "<img class='preview_pic' src=" + picUrl + type + "/" + transNullString(data[i].field4) + ".jpg onerror=$(this).attr('src','" + nopic + "').css('width','140px') onload='$(this).show()'/>";
       }
       else{
    	   field3 = transNullString(data[i].field3);
       }*/
        
        var prefix = "<tr><td class='list_field1'><a href='#' class='" + type+"_list_name'>";
        var medInfo = prefix + field1 +"</a></td><td class='list_field2'>" + field2 + "</td>";
        /*if(field3!='无' && (type == "pre" || type == "syn" || type == "dis")){
        	medInfo += "style='text-align:left;line-height:23px;padding-right:15px;'>" + field3 + "</td></tr>";
        }else{
        	medInfo += ">" + field3 + "</td></tr>";
        }*/
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
	
	$('.other_list_name').live('click', function () {
		window.open("./ori?oriname=" + $(this).text());
	});
	
	$('.syn_list_name').live('click', function () {
		window.open("./syn?synname=" + $(this).text());
	});
	
	$('.dis_list_name').live('click', function () {
		window.open("./dis?disname=" + $(this).text());
	});
	
	$('.chem_list_name').live('click', function () {
		window.open("./chem?chemname=" + $(this).text());
	});
	
	$('.pre_list_name').live('click', function () {
		var selectedRow = $('td',$(this).parent().parent());
		var preName = $(selectedRow[0]).text();
		var preBook = $(selectedRow[1]).text();
		window.open("./pre?prename=" + preName + "&prebook=" + preBook);
	});
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
