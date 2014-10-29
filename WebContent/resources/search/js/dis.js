/*该文件用于疾病信息显示模块*/

$(function(){	
	$('#dis_nav_name').html(decodeURI(getUrlParam("disname")));	
	
	$('#dis_relate_page').live('click', function () {			
    	window.location.href = "./disrelate?disname=" + getUrlParam("disname")
    						 + "&disid=" + getUrlParam("disid") 
    						 + "&pageno=1&relate=pre";
	});
	
		
	$('#dis_info_page').live('click', function () {			
	    	window.location.href = "./dis?disname=" + getUrlParam("disname");
		});
	
	$('#dis_recom_page').live('click', function() {
		window.location.href = "./disrecom?disname=" + getUrlParam("disname") + "&pageno=1";
	});
	
	$('#dis_analyse_page').live('click', function() {
		window.location.href = "./disanalyse?disname=" + getUrlParam("disname");
	});
});

function initDisRelate(){
	disRelateType = typeChToEn(decodeURI(getUrlParam("relate")));
	$("#dis_rs a[href='#dis_" + disRelateType + "_list']").tab('show');

	$('.dis_type').live('click',function() {
				disRelateType = typeChToEn($(this).text().trim());
				getDisRelateList();
				window.location.href = "./disrelate?" + "disname="
						+ getUrlParam("disname") + "&disid="
						+ decodeURI(getUrlParam("disid")) + "&pageno=1&relate="
						+ disRelateType;
			});

	getDisRelateList();

}

function initDisInfo() {
	getDis();
}

function getDis() {
	var dataJson = {
		"disname" : decodeURI(getUrlParam("disname")),
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./disinfo";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getDisSuccessCB, getDisErrorCB);
}

function getDisSuccessCB(data, textStatus, jqXHR) {
	var disName = transNullString(data.disname);
	var disDescription = transNullString(data.disdescription);
	var disClass = transNullString(data.disclass);
	var disID = transNullString(data.disid);
	
	$('#dis_info_name').html(disName);
	$('#dis_info_class').html(disClass);
	$('#dis_info_description').html(disDescription);
	
	$('#dis_relate_page').live('click', function () {			
    	window.location.href = "./disrelate?"+"disname="+getUrlParam("disname")+"&disid="+ disID +"&pageno=1&relate=pre";
	});
}

function getDisErrorCB(data, textStatus, jqXHR) {

}

function getDisRelateList() {
	var dataJson = {
		"disname" : decodeURI(getUrlParam("disname")),
		"disid" : parseInt(getUrlParam("disid")),
		"relate" : typeChToEn(decodeURI(getUrlParam("relate"))),
		"startrow" : getListStart(),
		"returnnum" : pageSize
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./disrelatelist";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getDisRelateListSuccessCB,
			getDisErrorCB);
}

function getDisRelateListSuccessCB(data, textStatus, jqXHR) {
	var typeEn = typeChToEn(disRelateType);
	var table = listToTable(data.list, typeEn);

	$("#dis_" + typeEn + "_list_info").html(table);
	
	if(parseInt(data.count) <= pageSize)
		$("#dis_rel_pagincation").hide();
	else
		$("#dis_rel_pagincation").pagination(
			{
				items : parseInt(data.count),
				itemsOnPage : pageSize,
				cssStyle : 'light-theme',
				hrefTextPrefix : '#',
				onPageClick : function(pageNumber, event) {
					window.location.href = "./disrelate?" + "disname="
							+ getUrlParam("disname") + "&disid="
							+ decodeURI(getUrlParam("disid")) + "&relate="
							+ decodeURI(getUrlParam("relate")) + "&pageno="
							+ pageNumber;
				},
				prevText : "上一页",
				nextText : "下一页",
				currentPage : getUrlParam("pageno")
			});
}

//推荐书目

var pageNo;

function initDisRecom() {
	getDisRecomList();
}

function getDisRecomList(){
	var keyword = decodeURI(getUrlParam("disname"));
		pageNo = getListStartt();
		
	var url="../gatherinfo/book?keyword=" + keyword + "&index=" + pageNo;	

	 $.getJSON(url,function(data){
	    getDisRecomListSuccessCB(data);
	 });
}

function getDisRecomListSuccessCB(data) {
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
						window.location.href = "./disrecom?disname="
								+ getUrlParam("disname") + "&pageno=" + pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

function getListStartt(){
	return getUrlParam("pageno") == null ? 1 :parseInt(getUrlParam("pageno"));
}
