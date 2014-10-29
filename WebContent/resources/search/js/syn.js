/*该文件用于证候分类浏览、组合查询以及信息显示模块*/

$(function() {
	$('#syn_nav_name').html(decodeURI(getUrlParam("synname")));

	$('#syn_relate_page').live('click',function() {
		window.location.href = "./synrelate?synname=" + getUrlParam("synname") 
							 + "&synid=" + getUrlParam("synid") + "&pageno=1&relate=pre";
	});
	$('#syn_info_page').live('click', function() {
		window.location.href = "./syn?synname=" + getUrlParam("synname");
	});
	
	$('#syn_recom_page').live('click', function() {
		window.location.href = "./synrecom?synname=" + getUrlParam("synname") + "&pageno=1";
	});

});

function initSynInfo() {
	getSyn();
}

function initSynRelate() {
	synRelateType = typeChToEn(decodeURI(getUrlParam("relate")));
	$("#syn_rs a[href='#syn_" + synRelateType + "_list']").tab('show');

	$('.syn_type').live('click',function() {
		synRelateType = typeChToEn($(this).text().trim());
		getSynRelateList();
		window.location.href = "./synrelate?" + "synname="
				+ getUrlParam("synname") + "&synid="
				+ decodeURI(getUrlParam("synid")) + "&pageno=1&relate="
				+ synRelateType;
	});

	getSynRelateList();

}

function getSyn() {
	var dataJson = {
		"synname" : decodeURI(getUrlParam("synname")),
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./syninfo";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getSynSuccessCB, getSynErrorCB);
}

function getSynSuccessCB(data, textStatus, jqXHR) {
	var synName = transNullString(data.synname);
	var synSummary = transNullString(data.synsummary);
	var synSymptom = transNullString(data.synsymptom);
	var synIllness = transNullString(data.synillness);
	var synDiscrimination = transNullString(data.syndiscrimination);
	var synPreference = transNullString(data.synpreference);
	var synClass = transNullString(data.synclass);
	var synID = transNullString(data.synid);

	synID = data.synid;

	$('#syn_info_name').html(synName);
	$('#syn_info_class').html(synClass);
	$('#syn_info_summary').html(synSummary);
	$('#syn_info_discrimination').html(synDiscrimination);
	$('#syn_info_symptom').html(synSymptom);
	$('#syn_info_illness').html(synIllness);
	$('#syn_info_preference').html(synPreference);

	$('#syn_relate_page').live('click',function() {
				window.location.href = "./synrelate?synname=" + getUrlParam("synname") 
									 + "&synid=" + synID + "&pageno=1&relate=pre";
				getMedRelateList();
			});

}

function getSynErrorCB(data, textStatus, jqXHR) {

}

function getSynRelateList() {
	var dataJson = {
		"synname" : decodeURI(getUrlParam("synname")),
		"synid" : parseInt(getUrlParam("synid")),
		"relate" : typeChToEn(decodeURI(getUrlParam("relate"))),
		"startrow" : getListStart(),
		"returnnum" : pageSize
	};
	var data = JSON.stringify(dataJson);
	var url = "./synrelatelist";
	var methodType = "POST";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getSynRelateListSuccessCB,
			getSynErrorCB);
}

function getSynRelateListSuccessCB(data, textStatus, jqXHR) {

	var typeEn = typeChToEn(synRelateType);
	var table = listToTable(data.list, typeEn);

	$("#syn_" + typeEn + "_list_info").html(table);

	if (parseInt(data.count) <= pageSize)
		$("#syn_rel_pagincation").hide();
	else
		$("#syn_rel_pagincation").pagination({
			items : parseInt(data.count),
			itemsOnPage : pageSize,
			cssStyle : 'light-theme',
			hrefTextPrefix : '#',
			onPageClick : function(pageNumber, event) {
				window.location.href = "./synrelate?synname=" + getUrlParam("synname") 
									 + "&synid=" + decodeURI(getUrlParam("synid")) 
									 + "&relate=" + decodeURI(getUrlParam("relate")) 
									 + "&pageno=" + pageNumber;
			},
			prevText : "上一页",
			nextText : "下一页",
			currentPage : getUrlParam("pageno")
		});
}

//推荐书目
var pageNo;

function initSynRecom() {
	getSynRecomList();
}

function getSynRecomList(){
	var keyword = decodeURI(getUrlParam("synname"));
		pageNo = getListStartt();

	var url="../gatherinfo/book?keyword=" + keyword + "&index=" + pageNo;	

	 $.getJSON(url,function(data){
	    getSynRecomListSuccessCB(data);
	 });
}

function getSynRecomListSuccessCB(data) {
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
						window.location.href = "./synrecom?synname="
								+ getUrlParam("synname") + "&pageno=" + pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

function getListStartt(){
	return getUrlParam("pageno") == null ? 1 :parseInt(getUrlParam("pageno"));
}