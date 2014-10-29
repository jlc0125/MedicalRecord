$(function() {

	$('#med_nav_name').html(decodeURI(getUrlParam("medname")));
	$('#med_ana_nav_name').html(decodeURI(getUrlParam("medname")));

	$('#med_relate_page').live(
			'click',
			function() {
				window.location.href = "./medrelate?medname="
						+ getUrlParam("medname") + "&medid="
						+ getUrlParam("medid")
						+ "&pageno=1&relate=ori#med_ori_list";
			});

	$('#med_info_page').live('click', function() {
		window.location.href = "./med?medname=" + getUrlParam("medname");
	});

	$('#med_analyse_page').live(
			'click',
			function() {
				window.location.href = "./medanalyse?medname="
						+ getUrlParam("medname") + "&medid="
						+ getUrlParam("medid");
			});
	$('#med_identification_page').live('click', function(){
		window.location.href = "../identification/home?query=" + getUrlParam("medname");
	});

	$('#med_recom_page').live('click', function() {
		window.location.href = "./medrecom?medname=" + getUrlParam("medname") + "&pageno=1";
	});
	/*药物鉴别*/
	/*先关医案*/
});

function initMedInfo() {
	var dataJson = {
		"medname" : decodeURI(getUrlParam("medname")),
	};

	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./medinfo";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getMedSuccessCB, getMedErrorCB);
}

function initMedRelate() {
	medRelateType = typeChToEn(decodeURI(getUrlParam("relate")));
	$("#med_rs a[href='#med_" + medRelateType + "_list']").tab('show');

	$('.med_type').live(
			'click',
			function() {
				medRelateType = typeChToEn($(this).text().trim());
				getMedRelateList();
				window.location.href = "./medrelate?medname="
						+ getUrlParam("medname") + "&medid="
						+ decodeURI(getUrlParam("medid")) + "&pageno=1&relate="
						+ medRelateType;
			});

	getMedRelateList();
}

/* 记录地图信息 */
var medClimateCache = new Array();

var medGClimateCache = new Array();

var medLatCache = new Array();

var medGLatCache = new Array();

var medLngCache = new Array();

var medGLngCache = new Array();


function getMed() {
	var dataJson = {
		"medname" : decodeURI(getUrlParam("medname")),
	};

	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./medinfo";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getMedSuccessCB, getMedErrorCB);
}

function getMedSuccessCB(data, textStatus, jqXHR) {

	medID = data.medinfo.medid;

	var medName = transNullString(data.medinfo.medname);
	var medNameLatin = transNullString(data.medinfo.mednamelatin);
	var medAlias = transNullString(data.medinfo.medalias);
	var medFunction = transNullString(data.medinfo.medfunction);
	var medProperty = transNullString(data.medinfo.medproperty);
	var medTropisw = transNullString(data.medinfo.medtropisw);
	var medBook = transNullString(data.medinfo.medbook);
	var medNameEn = transNullString(data.medinfo.mednameen);
	var medProcessing = transNullString(data.medinfo.medprocessing);
	var medAttention = transNullString(data.medinfo.medattention);
	var medUsage = transNullString(data.medinfo.medusage);

	$('#med_info_name').html(medName);
	$('#med_info_name_en').html(medNameEn);
	$('#med_info_alias').html(medAlias);
	$('#med_info_latin').html(medNameLatin);
	$('#med_info_function').html(medFunction);
	$('#med_info_property').html(medProperty);
	$('#med_info_tropisw').html(medTropisw);
	$('#med_info_processing').html(medProcessing);
	$('#med_info_attention').html(medAttention);
	$('#med_info_usage').html(medUsage);

	/* 是否收录药典，否则隐藏书籍标志 */
	if (data.meddic == null) {
		$('#med_info_dic').hide();
	} else {
		$('#med_info_dic')
				.live(
						'click',
						function() {
							window
									.open("http://www.cadal.zju.edu.cn/book/tryBook/"
											+ data.meddic.bookno
											+ "/"
											+ data.meddic.startpage);
						});
	}

	/* 是否显示图片 */
	if (data.medpic.length == 0) {
		$('#med_info_pic_tr').hide();
	} else {
		var temp = '<div class="row-fluid">'
				+ '<div class="span2 med_info_pic_div"><img class="med_info_pic" src="" id="med_info_pic_0"/> <span class="label" id="med_info_pic_label_0">文字标签</span></div>'
				+ '<div class="span2 med_info_pic_div"><img class="med_info_pic" src="" id="med_info_pic_1"/> <span class="label" id="med_info_pic_label_1">文字标签</span></div>'
				+ '<div class="span2 med_info_pic_div"><img class="med_info_pic" src="" id="med_info_pic_2"/> <span class="label" id="med_info_pic_label_2">文字标签</span></div></div>';

		$('#med_info_pic_td').html(temp);
		for ( var i = 0; i < data.medpic.length; i++) {
			$("#med_info_pic_" + i).attr("src",
					picUrl + "med/" + data.medpic[i].picpath + ".jpg");
			$("#med_info_pic_label_" + i).html(data.medpic[i].pictype);
		}

	}

	/* 是否显示视频 */
	if (data.medvideo == null) {
		$('#med_video').parent().parent().hide();
	} else {
		$("#med_video").show();
		$("#med_video").attr(
				"src",
				"videoimport?videoPath="
						+ encodeURIComponent(data.medvideo.videopath + "")
						+ "&startTime=" + data.medvideo.starttime);
	}

	var medGenuineLocation = "";
	for ( var i = 0; i < data.medgenuinelocation.length; i++) {
		medGClimateCache.push(data.medgenuinelocation[i].climate);
		medGLatCache.push(data.medgenuinelocation[i].lat);
		medGLngCache.push(data.medgenuinelocation[i].lng);
		markGMap(data.medgenuinelocation[i].medlocation,data.medgenuinelocation[i].lat,data.medgenuinelocation[i].lng,data.medgenuinelocation[i].climate);
		medGenuineLocation += data.medgenuinelocation[i].medlocation + " ";
	}
	$("#med_info_genuine").html(
			medGenuineLocation == "" ? "无" : medGenuineLocation);

	var medLocation = "";
	for ( var i = 0; i < data.medlocation.length; i++) {
		medClimateCache.push(data.medlocation[i].climate);
		medLatCache.push(data.medlocation[i].lat);
		medLngCache.push(data.medlocation[i].lng);
		markMap(data.medlocation[i].medlocation,data.medlocation[i].lat,data.medlocation[i].lng,data.medlocation[i].climate);
		medLocation += data.medlocation[i].medlocation + " ";
	}
	$("#med_info_location").html(medLocation == "" ? "无" : medLocation);

	$("#med_location_map").attr("src",
			"medmap?" + "parm=" + encodeURIComponent("mark"));

	$('#med_relate_page').live(
			'click',
			function() {
				window.location.href = "./medrelate?medname="
						+ getUrlParam("medname") + "&medid=" + medID
						+ "&pageno=1&relate=ori";
				getMedRelateList();
			});

	$('#med_analyse_page').live(
			'click',
			function() {
				window.location.href = "./medanalyse?medname="
						+ getUrlParam("medname") + "&medid=" + medID;
			});
	
	$('#med_recom_page').live('click', function() {
		window.location.href = "./medrecom?medname=" + getUrlParam("medname") 
							 + "&medid=" + medID + "&pageno=1";
	});
}

function getMedErrorCB() {
}

function markGMap(location,lat,lng,climate) {

	$('#med_map').gmap3({
	    map:{
	      options:{
	        center:[33.51, 103.612224],
	        zoom: 4
	      }
	    },

	    marker:{
	      values:[
			  {latLng:[lat,lng], data:location + "的气候为: <br>" + climate,options:{icon: "http://maps.google.com/mapfiles/marker_green.png",}},
	      ],
	      options:{
	        draggable: false
	      },
	      events:{
	        mouseover: function(marker, event, context){
	          var map = $(this).gmap3("get"),
	            infowindow = $(this).gmap3({get:{name:"infowindow"}});
	          if (infowindow){
	            infowindow.open(map, marker);
	            infowindow.setContent(context.data);
	          } else {
	            $(this).gmap3({
	              infowindow:{
	                anchor:marker, 
	                options:{content: context.data}
	              }
	            });
	          }
	        },
	        mouseout: function(){
	          var infowindow = $(this).gmap3({get:{name:"infowindow"}});
	          if (infowindow){
	            infowindow.close();
	          }
	        }
	      }
	    }
	  });

}

function markMap(location,lat,lng,climate) {

	$('#med_map').gmap3({
	    map:{
	      options:{
	        center:[33.51, 103.612224],
	        zoom: 4
	      }
	    },

	    marker:{
	      values:[
			  {latLng:[lat,lng], data:location + "的气候为: <br>" + climate,},
	      ],
	      options:{
	        draggable: false
	      },
	      events:{
	        mouseover: function(marker, event, context){
	          var map = $(this).gmap3("get"),
	            infowindow = $(this).gmap3({get:{name:"infowindow"}});
	          if (infowindow){
	            infowindow.open(map, marker);
	            infowindow.setContent(context.data);
	          } else {
	            $(this).gmap3({
	              infowindow:{
	                anchor:marker, 
	                options:{content: context.data}
	              }
	            });
	          }
	        },
	        mouseout: function(){
	          var infowindow = $(this).gmap3({get:{name:"infowindow"}});
	          if (infowindow){
	            infowindow.close();
	          }
	        }
	      }
	    }
	  });

}

function getMedRelateList() {
	var dataJson = {
		"medname" : decodeURI(getUrlParam("medname")),
		"medid" : parseInt(getUrlParam("medid")),
		"relate" : typeChToEn(decodeURI(getUrlParam("relate"))),
		"startrow" : getListStart(),
		"returnnum" : pageSize
	};
	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./medrelatelist";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getMedRelateListSuccessCB,
			getMedErrorCB);
}

function getMedRelateListSuccessCB(data, textStatus, jqXHR) {

	var typeEn = typeChToEn(decodeURI(getUrlParam("relate")));
	var table = listToTable(data.list, typeEn);

	$("#med_" + typeEn + "_list_info").html(table);

	if (parseInt(data.count) <= pageSize)
		$("#med_rel_pagincation").hide();

	else
		$("#med_rel_pagincation").pagination(
				{
					items : parseInt(data.count),
					itemsOnPage : pageSize,
					cssStyle : 'light-theme',
					hrefTextPrefix : '#',
					onPageClick : function(pageNumber, event) {
						window.location.href = "./medrelate?medname="
								+ getUrlParam("medname") + "&medid="
								+ decodeURI(getUrlParam("medid")) + "&relate="
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

function initMedRecom() {
	getMedRecomList();
}

function getMedRecomList(){
	var keyword = decodeURI(getUrlParam("medname"));
		pageNo = getListStartt();

	var url="../gatherinfo/book?keyword=" + keyword + "&index=" + pageNo;	

	 $.getJSON(url,function(data){
	    getMedRecomListSuccessCB(data);
	 });
}

function getMedRecomListSuccessCB(data) {
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
						window.location.href = "./medrecom?medname="
								+ getUrlParam("medname") + "&pageno=" + pageNumber;
					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageno")
				});
}

function getListStartt(){
	return getUrlParam("pageno") == null ? 1 :parseInt(getUrlParam("pageno"));
}

