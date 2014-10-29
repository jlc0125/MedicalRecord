$(function(){
	$('#pre_nav_name').html(decodeURI(getUrlParam("prename")));
	$('#pre_info_page').live('click', function() {
		window.location.href = "./pre?prename=" + getUrlParam("prename") + "&prebook=" + getUrlParam("prebook");
	});
	$('#pre_compare_page').live('click', function() {
		window.location.href = "./precompare?prename=" + getUrlParam("prename") + "&prebook=" + getUrlParam("prebook") + "&preid=" + getUrlParam("preid");
	});
	$('#pre_relate_page').live('click', function () {			
    	window.location.href="./prerelate?"+"prename="+getUrlParam("prename")+"&prebook=" + getUrlParam("prebook") +"&preid="+ getUrlParam("preid") + "&pageno=1&relate=med";
	});
	
	$('#pre_recom_page').live('click', function() {
		window.location.href = "./prerecom?prename=" + getUrlParam("prename") +  "&prebook=" + getUrlParam("prebook") + "&pageno=1";
	});
});
//preinfo

function initPreInfo(){
	getPre();
}

function getPre() {
	var dataJson = {
		"prename" : decodeURI(getUrlParam("prename")),
		"prebook" : decodeURI(getUrlParam("prebook"))
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./preinfo";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getPreSuccessCB, getPreErrorCB);
}

function getPreSuccessCB(data, textStatus, jqXHR) {
	var preID = transNullString(data.preid);
	var preName = transNullString(data.prename);
	var preDosage = transNullString(data.predosage);
	var preFunction = transNullString(data.prefunction);
	var preAttention = transNullString(data.preattention);
	var preBook = transNullString(data.prebook);
	var preSimpleBook = transNullString(data.presimplebook);
	
	$('#pre_info_name').html(preName);
	$('#pre_info_function').html(preFunction);
	$('#pre_info_attention').html(preAttention);
	$('#pre_info_book').html(preBook);
	$('#pre_info_dosage').html(preDosage);
	
	$('#pre_relate_page').live('click', function () {			
    	window.location.href = "./prerelate?prename=" + getUrlParam("prename")
    						 + "&prebook=" + getUrlParam("prebook") 
    						 + "&preid=" + preID + "&pageno=1&relate=med";
	});
	
	$('#pre_compare_page').live('click', function() {
		window.location.href = "./precompare?prename=" + getUrlParam("prename") 
							 + "&prebook=" + getUrlParam("prebook") 
							 + "&preid=" + preID;
	});
}


//prerelate

function initPreRelate() {
	preRelateType = typeChToEn(decodeURI(getUrlParam("relate")));
	$("#pre_rs a[href='#pre_" + preRelateType + "_list']").tab('show');
	$('.pre_type').live('click', function() {
		preRelateType =typeChToEn($(this).text().trim());
		window.location.href = "./prerelate?prename=" + getUrlParam("prename") 
						     + "&preid=" + decodeURI(getUrlParam("preid")) 
						     + "&prebook=" + getUrlParam("prebook") 
						     + "&pageno=1&relate=" + preRelateType;
	});
	getPreRelateList();
}

function getPreRelateList() {
	var dataJson = {
		"prename" : decodeURI(getUrlParam("prename")),
		"preid" : parseInt(getUrlParam("preid")),
		"relate" : decodeURI(getUrlParam("relate")),
		"startrow" : getListStart(),
		"returnnum" : pageSize
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./prerelatelist";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getPreRelateListSuccessCB,
			getPreErrorCB);
}

function getPreRelateListSuccessCB(data, textStatus, jqXHR) {
	
	var typeEn = typeChToEn(decodeURI(getUrlParam("relate")));
    var table = listToTable(data.list,typeEn); 
    
    $("#pre_" + typeEn + "_list_info").html(table);
    
	if(parseInt(data.count) <= pageSize)
		$("#pre_rel_pagincation").hide();
    
	else
		$("#pre_rel_pagincation").pagination({
			items:parseInt(data.count),
	        itemsOnPage: pageSize,
	        cssStyle: 'light-theme',
	        hrefTextPrefix:'#',
	        onPageClick:function(pageNumber, event){
	        	window.location.href = "./prerelate?prename=" + getUrlParam("prename") 
	        						 + "&preid=" + decodeURI(getUrlParam("preid")) 
	        						 + "&prebook=" + getUrlParam("prebook")
	        						 + "&relate=" + decodeURI(getUrlParam("relate"))
	        						 + "&pageno=" + pageNumber;
	        },
	        prevText:"上一页",
	        nextText:"下一页",
	        currentPage:getUrlParam("pageno")
	    });
}


//共有
function getPreErrorCB(data, textStatus, jqXHR) {

}

//推荐书目

var pageNo;

function initPreRecom() {
	getPreRecomList();
}

function getPreRecomList(){
	var keyword = decodeURI(getUrlParam("prename"));
		pageNo = getListStartt();

	var url="../gatherinfo/book?keyword=" + keyword + "&index=" + pageNo;	

	 $.getJSON(url,function(data){
	    getPreRecomListSuccessCB(data);
	 });
}

function getPreRecomListSuccessCB(data) {
	var count = data.count;
	
	var str = "";
	for(var i = 0 ; i < pageSize && (pageNo-1)*pageSize+i < count; i++){
		str += "<div class ='recom_book'>";
		str += "<div class='recom_book_pic'><a class='recom_book_pic_url' href='" + data.bookList[i].Url + "'><img src='" + data.bookList[i].cover + "'/></a></div>"; 
		str += "<div class='recom_book_detail'><div class='recom_book_row1'><a class='recom_book_src' href='"+ data.bookList[i].Url + "'><span class='recom_book_title'>" + data.bookList[i].Title + "</span></a></div>";
		str += "<div class='recom_book_row2'>作者：" + data.bookList[i].Creator + "&nbsp;&nbsp;&nbsp;出版日期：&nbsp;" + data.bookList[i].CreateDate + "&nbsp;&nbsp;&nbsp;出版社：&nbsp;" + data.bookList[i].Publisher + "</div>";
		str += "<div class='recom_book_row3'>图书主题：" + (undefined ==data.bookList[i].Subject ? "无" : data.bookList[i].Subject) + "</div>"; 	
		//str += "<div class='recom_book_row4'>简介：" + book_json[i].intro + "</div>"
		str += "</div></div>";
	}
	$('#recom_book_container').html(str);
	
	if (count <= pageSize)
		$("#rel_pagincation").hide();

	else
		$("#rel_pagincation").pagination(
				{
					items : parseInt(count),
					itemsOnPage : pageSize,
					cssStyle : 'light-theme',
					hrefTextPrefix : '#',
					onPageClick : function(pageNumber, event) {
						window.location.href = "./prerecom?prename="
								+ getUrlParam("prename") + "&prebook=" + getUrlParam("prebook") + "&pageno=" + pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

function getListStartt(){
	return getUrlParam("pageno") == null ? 1 :parseInt(getUrlParam("pageno"));
}











