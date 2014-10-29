//oriinfo

function initOriInfo() {
	getOri();
}

function getOri() {
	var dataJson = {
		"oriname" : decodeURI(getUrlParam("oriname")),
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./oriinfo";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getOriSuccessCB, getOriErrorCB);
}

function getOriSuccessCB(data, textStatus, jqXHR) {

	var oriName = transNullString(data.oriname);
	var oriLatin = transNullString(data.orilatin);
	var oriFamily = transNullString(data.orifamily);
	var oriGenus = transNullString(data.origenus);
	var oriAppearance = transNullString(data.oriappearance);
	var oriLocation = transNullString(data.orilocation);
	var oriEnvironment = transNullString(data.orienvironment);
	var oriRecovery = transNullString(data.orirecovery);
	var oriVideoName = transNullString(data.orivideoname);
	var oriVideoStartTime = transNullString(data.videostarttime);
	var oriID = transNullString(data.oriid);

	$('#ori_info_name').html(oriName);
	$('#ori_info_latin').html(oriLatin);
	$('#ori_info_family').html(oriFamily);
	$('#ori_info_appearance').html(oriAppearance);
	$('#ori_info_location').html(oriLocation);
	$('#ori_info_environment').html(oriEnvironment);
	$('#ori_info_recovery').html(oriRecovery);
	$('#ori_info_videoname').html(oriVideoName);

	$('#ori_relate_page').live(
			'click',
			function() {
				window.location.href = "./orirelate?oriname="
						+ getUrlParam("oriname") + "&oriid=" + oriID
						+ "&pageno=1&relate=med";
			});
}

function initOriRelate() {
	oriRelateType = typeChToEn(decodeURI(getUrlParam("relate")));
	$("#ori_rs a[href='#ori_" + oriRelateType + "_list']").tab('show');
	$('.ori_type').live(
			'click',
			function() {
				oriRelateType = typeChToEn($(this).text().trim());
				window.location.href = "./orirelate?" + "oriname="
						+ getUrlParam("oriname") + "&oriid="
						+ decodeURI(getUrlParam("oriid")) + "&pageno=1&relate="
						+ oriRelateType;
			});
	getOriRelateList();
}

function getOriRelateList() {
	var dataJson = {
		"oriname" : decodeURI(getUrlParam("oriname")),
		"oriid" : parseInt(getUrlParam("oriid")),
		"relate" : typeChToEn(decodeURI(getUrlParam("relate"))),
		"startrow" : getListStart(),
		"returnnum" : pageSize
	};
	var data = JSON.stringify(dataJson);
	var url = "./orirelatelist";
	var methodType = "POST";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getOriRelateListSuccessCB,
			getOriErrorCB);
}

function getOriRelateListSuccessCB(data, textStatus, jqXHR) {

	var typeEn = typeChToEn(oriRelateType);
	var table = listToTable(data.list, typeEn);

	$("#ori_" + typeEn + "_list_info").html(table);

	if (parseInt(data.count) <= pageSize)
		$("#ori_rel_pagincation").hide();
	else
		$("#ori_rel_pagincation").pagination(
				{
					items : parseInt(data.count),
					itemsOnPage : pageSize,
					cssStyle : 'light-theme',
					hrefTextPrefix : '#',
					onPageClick : function(pageNumber, event) {
						window.location.href = "./orirelate?" + "oriname="
								+ getUrlParam("oriname") + "&oriid="
								+ decodeURI(getUrlParam("oriid")) + "&relate="
								+ decodeURI(getUrlParam("relate")) + "&pageno="
								+ pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

//

function getOriErrorCB(data, textStatus, jqXHR) {

}

$(function() {
	$('#ori_nav_name').html(decodeURI(getUrlParam("oriname")));
	$('#ori_info_page').live('click', function() {
		window.location.href = "./ori?oriname=" + getUrlParam("oriname");
	});
	$('#ori_relate_page').live('click', function () {	
    	window.location.href = "./orirelate?oriname=" + getUrlParam("oriname")
    						 + "&oriid=" + getUrlParam("oriid") 
    						 + "&pageno=1&relate=med";
	});
	
	$('#ori_recom_page').live('click', function() {
		window.location.href = "./orirecom?oriname=" + getUrlParam("oriname") + "&pageno=1";
	});
});

//推荐书目

var pageNo;

function initOriRecom() {
	getOriRecomList();
}

function getOriRecomList(){
	var keyword = decodeURI(getUrlParam("oriname"));
		pageNo = getListStartt();

	var url="../gatherinfo/book?keyword=" + keyword + "&index=" + pageNo;	

	 $.getJSON(url,function(data){
	    getOriRecomListSuccessCB(data);
	 });
}

function getOriRecomListSuccessCB(data) {
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
						window.location.href = "./orirecom?oriname="
								+ getUrlParam("oriname") + "&pageno=" + pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

function getListStartt(){
	return getUrlParam("pageno") == null ? 1 :parseInt(getUrlParam("pageno"));
}