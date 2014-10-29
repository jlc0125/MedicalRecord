var chemID = 0;
$(function(){	
	
	var chemName = decodeURI(getUrlParam("chemname"));
	$('#chem_nav_name').html(chemName.length > 35? chemName.substring(0,35) + "..." : chemName);	
	
	$('#chem_relate_page').live('click', function () {			
    	window.location.href = "./chemrelate?chemname=" + getUrlParam("chemname")
    						 + "&chemid=" + getUrlParam("chemid") 
    						 + "&pageno=1&relate=med";
	});
	
		
	$('#chem_info_page').live('click', function () {			
	    	window.location.href = "./chem?chemname=" + getUrlParam("chemname");
		});
	$('#chem_recom_page').live('click', function() {
		window.location.href = "./chemrecom?chemname=" + getUrlParam("chemname") + "&pageno=1";
	});
});

function initChemInfo(){	
	getChem();
}

function initChemRelate(){
	chemRelateType = typeChToEn(decodeURI(getUrlParam("relate")));
	$("#chem_rs a[href='#chem_" + chemRelateType +"_list']").tab('show');
	
		
	$('.chem_type').live('click', function () {			
		chemRelateType = typeChToEn($(this).text().trim());
		getChemRelateList();
    	window.location.href = "./chemrelate?chemname=" + getUrlParam("chemname") 
    					     + "&chemid=" + decodeURI(getUrlParam("chemid"))
    					     + "&pageno=1&relate=" + chemRelateType;
	});
	

	getChemRelateList();
}

function getChem()
{			
	 var dataJson = 
	{
		"chemname":decodeURI(getUrlParam("chemname")),
	};
	
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./cheminfo";
	var contentType = "application/json;charset=utf-8";
	
	ajaxFunc(methodType,url,data,contentType,getChemSuccessCB,getChemErrorCB);
}

function getChemSuccessCB(data, textStatus, jqXHR)
{
	var chemID = data.chemid;
	
	$("#chem_info_name").html(transNullString(data.chemname));
	$("#chem_info_formula").html(transNullString(data.chemformula));
	$("#chem_info_en").html(transNullString(data.chemnameen));
	$("#chem_info_cas").html(transNullString(data.cas));
	$("#chem_info_fenziliang").html(transNullString(data.fenziliang));
	$("#chem_info_moertiji").html(transNullString(data.moertiji));
	$("#chem_info_zhengqiya").html(transNullString(data.zhengqiya));
	$("#chem_info_midu").html(transNullString(data.midu));
	$("#chem_info_shandian").html(transNullString(data.shandian));
	$("#chem_info_dengzhangbirong").html(transNullString(data.dengzhangbirong));
	$("#chem_info_jihualv").html(transNullString(data.jihualv));
	$("#chem_info_shushuichangshu").html(transNullString(data.shushuichangshu));
	$("#chem_info_biaomianzhangli").html(transNullString(data.biaomianzhangli));
	$("#chem_info_han").html(transNullString(data.han));
	$("#chem_info_zhengqiya").html(transNullString(data.zhengqiya));
	$("#chem_info_moertiji").html(transNullString(data.moertiji));
	
	$("#chem_info_2d").attr("src",picUrl + "chem/" + data.twodimension+".jpg");
	
	if(transNullString(data.threedimension) == "无")
		$("#chem_info_3d").parent().parent().hide();
	else{
			$("#chem_info_3d").attr("src","chem3D_small?" + "molName=" + data.threedimension);
			$("#chem_info_3d").css("width","320px").css("height","320px").css("margin-left","30px");;
	}

	$('#chem_relate_page').live('click', function () {			
    	window.location.href = "./chemrelate?chemname=" + getUrlParam("chemname")
    						 + "&chemid=" + chemID + "&pageno=1&relate=med";
    	getMedRelateList();
	});
}

function getChemErrorCB(){}

function getChemRelateList()
{
	 var dataJson = 
	{
		"chemname":decodeURI(getUrlParam("chemname")),
		"chemid":parseInt(getUrlParam("chemid")),
		"relate":typeChToEn(decodeURI(getUrlParam("relate"))),
		"startrow":getListStart(),
		"returnnum":pageSize
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./chemrelatelist";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType,url,data,contentType,getChemRelateListSuccessCB,getChemErrorCB);
}

function getChemRelateListSuccessCB(data, textStatus, jqXHR)
{		
	var typeEn = typeChToEn(decodeURI(getUrlParam("relate")));
    var table = listToTable(data.list,typeEn);  
    	
    $("#chem_" + typeEn + "_list_info").html(table);
    
	if(parseInt(data.count) <= pageSize)
		$("#chem_rel_pagincation").hide();
    
	else
		$("#chem_rel_pagincation").pagination({
			items:parseInt(data.count),
	        itemsOnPage: pageSize,
	        cssStyle: 'light-theme',
	        hrefTextPrefix:'#',
	        onPageClick:function(pageNumber, event){
	        	window.location.href = "./chemrelate?chemname=" + getUrlParam("chemname") 
	        						 + "&chemid=" + decodeURI(getUrlParam("chemid")) 
	        						 + "&relate=" + decodeURI(getUrlParam("relate"))
	        						 + "&pageno=" + pageNumber;
	        },
	        prevText:"上一页",
	        nextText:"下一页",
	        currentPage:getUrlParam("pageno")
	    });
 
}

//推荐书目

var pageNo;

function initChemRecom() {
	getChemRecomList();
}

function getChemRecomList(){
	var keyword = decodeURI(getUrlParam("chemname"));
		pageNo = getListStartt();

	var url="../gatherinfo/book?keyword=" + keyword + "&index=" + pageNo;	

	 $.getJSON(url,function(data){
	    getChemRecomListSuccessCB(data);
	 });
}

function getChemRecomListSuccessCB(data) {
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
						window.location.href = "./chemrecom?chemname="
								+ getUrlParam("chemname") + "&pageno=" + pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

function getListStartt(){
	return getUrlParam("pageno") == null ? 1 :parseInt(getUrlParam("pageno"));
}
