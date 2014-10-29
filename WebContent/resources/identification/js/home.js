/*性状信息总的记录数*/
var character_currentPageIndex = 1;
var NO_RESULT = "<div style='width:415px;margin:0 auto;'><img src='../resources/commonpages/images/no_data.png' /><div>";

var pic_root_url = "http://10.15.62.32:8888/tcmpro/pictures/identification/";

$(function() {
	
    $(".li_a_tab").live("click", function() {
        $(".li_a_tab").parent().removeClass("selected").addClass("noselected");
        $(this).parent().removeClass("noselected").addClass("selected");

        $("#simple_pagination").hide();
    });
    $('#slides').slides({
		preload: true,
		preloadImage: '../resources/exlib/slides/images/loading.gif',
		play: 3000,
		pause: 2500,
		hoverPause: true
	});


    $("#basic_info_img").live("click", function() {
        $(".basic_info_a").click();
    });

    $("#character_info_img").live("click", function() {
        $(".character_info_a").click();
    });

    $("#micro_info_img").live("click", function() {
        $(".micro_info_a").click();
    });

    $("#phy_chemical_img").live("click", function() {
        $(".pc_info_a").click();
    });

    $("#contain_info_img").live("click", function() {
        $(".contain_info_a").click();
    });

    $("#forge_mix_img").live("click", function() {
        $(".forge_mix_info_a").click();
    });

    $("#search_btn").live("click", search);

    $(".basic_info_a").live("click", getBasicInfo);
    $(".contain_info_a").live("click", getContainInfo);
    $(".pc_info_a").live("click", getPhyChemInfo);
    $(".character_info_a").live("click", function() {
        getCharacterInfo(1);
    });
    $(".micro_info_a").live("click", getMicroInfo);

    $(".net_push_info").live(
            "click",
            function() {
            	window.open("./pushinfo?keyword="+ $(".search_name").html() + "&index=1&num=10","target='_blank'");
            });
    $(".forge_mix_info_a").live("click", getForgeMixInfo);
    
    /*对外接口*/
    queryInterface();
});
function queryInterface(){
	if(null==getUrlParam("query")||""==getUrlParam("query"))
		return false;
	var query = decodeURI(getUrlParam("query"));
	if(null!=query&&""!=query){
		$("#query_input").val(query);
		$("#search_btn").click();
	}
		
}



/**
 * input egg:checkInput("xxxx", "#xxx")
 * 
 * @param keyword
 * @param msg_ele_id
 * @returns
 */
function checkInput(keyword, msg_ele_id) {
    if (null == keyword || "" == keyword || "" == $.trim(keyword)) {
        $(msg_ele_id).html("请输入中药名称");
        return false;
    }
    $(msg_ele_id).html("");
}

/**
 * Tab 切换时，检查输入
 * 
 * @param keyword
 * @returns {Boolean}
 */
function checkInputFOrTab(keyword) {
    if (null == keyword || "" == keyword || "" == $.trim(keyword)) {
        return false;
    }
    return true;
}
/*******search  button***/
function search() {
    var keyword = $("#query_input").val();
    if (false == checkInput(keyword, "#input_search_tip")) {
        return false;
    }

    var length = $(".nav_tab").find("span").length;
    for ( var i = 0; i < length; i++) {
        if ("selected" == $(".nav_tab").find("span").eq(i).attr("class")) {
            if (0 == i) {
                getBasicInfo();
            } else if (1 == i) {
                getCharacterInfo(1);
            } else if (2 == i) {
                getMicroInfo();
            } else if (3 == i) {
                getPhyChemInfo();
            } else if (4 == i) {
                getContainInfo();
            } else if (5 == i) {
                getForgeMixInfo();
            }
        }
    }

}
/*********get basic information start*********/
function getBasicInfo() {
    var keyword = $("#query_input").val();
    var bookid = $("#book_select").val();

    if (false == checkInputFOrTab(keyword)) {
        return false;
    }

    keyword = $.trim(keyword);
    var json = {
        "keyword" : keyword,
        "bookid" : bookid
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "./basicinfo";
    var contentType = "application/json;charset=utf-8";

    ajaxFunc(methodType, url, data, contentType, basicSuccessCB, null);
}
function basicSuccessCB(data, textStatus, jqXHR) {
    if (null == data) {
    	$("#result_content").html(NO_RESULT);
        return false;
    } else {
        /* nav_top div */
        var str = '<div class="nav_top">'
                + '<div class="search_result">'
                + '<span class="text_search">搜索结果：</span><a class="search_name">'
                + $("#query_input").val()
                + '</a></span>'
                + '<span class="text_webrecommend"><a class="net_push_info" href="#">网络推荐</a><img src="../resources/identification/images/Web_Recommend.png" height="27" width="20"/></span>'
                + '</div>' + '</div>';
        $("#result_content").html("");
        $("#result_content").append(str);

        var line_div = '<div id="underline_category"></div>';
        $("#result_content").append(line_div);

        var str2 = '<div id="background_content">'
                + '<div class="table" style="background-color:#FFF">'
                + '<table>' + '<tr>'
                + '<th class="text_herb_left"><span>药材名称</span></th>'
                + '<th class="herb_midd">'
                + data.name
                + '</th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info" style="width:770px;"></div>'
                + '<br>'
                + '<br>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>药材描述</span></th>'
                + '<th class="herb_midd"><span>'
                + data.intro
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info" style="width:770px;"></div>'
                + '<br>'
                + '<br>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>药材基源</span></th>'
                + '<th class="herb_midd"><span>'
                + data.base
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>药材产地</span></th>'
                + '<th class="herb_midd"><span>'
                + data.location
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>药材存储</span></th>'
                + '<th class="herb_midd"><span>'
                + data.storage
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<div id="img_ul" class="img_right" style="background-image:url(../resources/identification/images/banner_border_small2.png); width:192px; height:122px;">'
                + '<ul>'
                + '<li><a href="#" ><img src="../resources/identification/images/arrow_large_prev.png" height="110" width="15"></a></li>'
                + '<li><span ><a href="../search/med?medname='+data.name+'" target="_blank"><img src="../resources/identification/images/test.png" height="110" width="150"/></a></span> </li>'
                + '<li><a href="#"><img src="../resources/identification/images/arrow_large_next.png" height="110" width="15"></a> </li>'
                + '</ul>' + '</div>' + '</div>' + '</div>';

        $("#result_content").append(str2);
    }
}

/***get contain information***/
/**
 * get contain information
 */
function getContainInfo() {
    var keyword = $("#query_input").val();
    var bookid = $("#book_select").val();

    if (false == checkInputFOrTab(keyword)) {
        return false;
    }

    keyword = $.trim(keyword);
    var json = {
        "keyword" : keyword,
        "bookid" : bookid
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "./containinfo";
    var contentType = "application/json;charset=utf-8";

    ajaxFunc(methodType, url, data, contentType, containSuccessCB, null);
}
/**
 * callback function for getContainInfo
 * 
 * @param data
 * @param textStatus
 * @param jqXHR
 */
function containSuccessCB(data, textStatus, jqXHR) {
    if (null == data) {
    	$("#result_content").html(NO_RESULT);
        return false;
    } else {
        /* nav_top div */
        var str = '<div class="nav_top">'
                + '<div class="search_result">'
                + '<span class="text_search">搜索结果：</span><a class="search_name">'
                + $("#query_input").val()
                + '</a></span>'
                + '<span class="text_webrecommend"><a class="net_push_info" href="#">网络推荐</a><img src="../resources/identification/images/Web_Recommend.png" height="27" width="20"/></span>'
                + '</div>' + '</div>';
        $("#result_content").html("");
        $("#result_content").append(str);

        var line_div = '<div id="underline_category"></div>';
        $("#result_content").append(line_div);

        var str2 = '<div id="background_content">'
                + '<div class="table" style="background-color:#FFF">'
                + '<table>' + '<tr>'
                + '<th class="text_herb_left"><span>实验条件</span></th>'
                + '<th class="herb_midd">'
                + data.conditions
                + '</th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>有效成分</span></th>'
                + '<th class="herb_midd">'
                + data.component
                + '</th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left" style="width:72px;"><span>对照品溶剂的制备</span></th>'
                + '<th class="herb_midd"><span>'
                + data.referproduce
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left" style="width:72px;"><span>供试品溶剂的制备</span></th>'
                + '<th class="herb_midd"><span>'
                + data.testproduce
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>测定方法</span></th>'
                + '<th class="herb_midd"><span>'
                + data.method
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>' + '</div>'

                + '</div>';

        $("#result_content").append(str2);
    }
}


/**
 * get physical chemical information
 * @returns {Boolean}
 */
function getPhyChemInfo() {
    var keyword = $("#query_input").val();
    var bookid = $("#book_select").val();

    if (false == checkInputFOrTab(keyword)) {
        return false;
    }

    keyword = $.trim(keyword);
    var json = {
        "keyword" : keyword,
        "bookid" : bookid
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "./phycheminfo";
    var contentType = "application/json;charset=utf-8";

    ajaxFunc(methodType, url, data, contentType, pcSuccessCB, null);
}
function pcSuccessCB(data, textStatus, jqXHR) {
    if (null == data) {
    	$("#result_content").html(NO_RESULT);
        return false;
    } else {
        /* nav_top div */
        var str = '<div class="nav_top">'
                + '<div class="search_result">'
                + '<span class="text_search">搜索结果：</span><a class="search_name">'
                + $("#query_input").val()
                + '</a></span>'
                + '<span class="text_webrecommend"><a class="net_push_info" href="#">网络推荐</a><img src="../resources/identification/images/Web_Recommend.png" height="27" width="20"/></span>'
                + '</div>' + '</div>';
        $("#result_content").html("");
        $("#result_content").append(str);

        var line_div = '<div id="underline_category"></div>';
        $("#result_content").append(line_div);

        var str2 = '<div id="background_content">'
                + '<div class="table" style="background-color:#FFF">'
                + '<table>' + '<tr>'
                + '<th class="text_herb_left"><span>波层色谱</span></th>'
                + '<th class="herb_midd">'
                + data.chromatography
                + '</th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info" style="width:770px;"></div>'
                + '<br>'
                + '<br>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>化学特性</span></th>'
                + '<th class="herb_midd"><span>'
                + data.chemproperties
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info" style="width:770px;"></div>'
                + '<br>'
                + '<br>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>光谱鉴别</span></th>'
                + '<th class="herb_midd"><span>'
                + data.spectrum
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'

                + '<table>'
                + '<tr>'
                + '<th class="text_herb_left"><span>荧光检查</span></th>'
                + '<th class="herb_midd"><span>'
                + data.fluorescence
                + '</span></th>'
                + '<th class="herb_left"></th>'
                + '</tr>'
                + '</table>'
                + '<div id="underline_down_info"></div>'
                + '</div>'

                + '</div>';

        $("#result_content").append(str2);
    }
}

/**
 * get character information
 * @param index
 * @returns {Boolean}
 */
function getCharacterInfo(index) {
    var keyword = $("#query_input").val();
    var bookid = $("#book_select").val();

    if (false == checkInputFOrTab(keyword)) {
        return false;
    }

    keyword = $.trim(keyword);

    var json = {
        "keyword" : keyword,
        "bookid" : bookid,
        "index" : index
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "./characterinfo";
    var contentType = "application/json;charset=utf-8";

    ajaxFunc(methodType, url, data, contentType, characterSuccessCB, null);
}
function characterSuccessCB(data, textStatus, jqXHR) {

    if (null == data || 1 == data.length) {
    	$("#result_content").html(NO_RESULT);
        return false;
    } else {
        /* nav_top div */
        var str = '<div class="nav_top">'
                + '<div class="search_result">'
                + '<span class="text_search">搜索结果：</span><a class="search_name">'
                + $("#query_input").val()
                + '</a></span>'
                + '<span class="text_webrecommend"><a class="net_push_info" href="#">网络推荐</a><img src="../resources/identification/images/Web_Recommend.png" height="27" width="20"/></span>'
                + '</div>' + '</div>';
        $("#result_content").html("");
        $("#result_content").append(str);

        var line_div = '<div id="underline_category"></div>';
        $("#result_content").append(line_div);

        var str2 = '<div id="background_content">';
        str2 += '<div class="table" style="background-color:#FFF">';
        for ( var i = 1; i < data.length; i++) {
            str2 += '<table>'
                    + '<tr>'
                    + '<th class="character_text_herb_left" style="text-align:left;"><span>'
                    + data[i].header + '</span></th>'
                    + '<th class="character_herb_midd">' + data[i].content
                    + '</th>' + '</tr>' + '</table>'
                    + '<div id="underline_down_info"></div>';
        }
        str2 += '</div>';
        str2 += '</div>';

        $("#result_content").append(str2);

        initPagination("#simple_pagination", character_currentPageIndex,
                data[0].totalNum);
    }

}
function initPagination(divId, currentPageIndex, totalNum) {
    $(divId).show();
    $(divId).pagination({
        items : totalNum,
        itemsOnPage : 5,
        cssStyle : 'light-theme',
        hrefTextPrefix : '#',
        onPageClick : function(pageNumber, event) {
            character_currentPageIndex = pageNumber;
            getCharacterInfo(pageNumber);
        },
        prevText : "上一页",
        nextText : "下一页",
        currentPage : currentPageIndex
    });

}
/**
 * get micro_structure information
 */
function getMicroInfo() {
    var keyword = $("#query_input").val();
    var bookid = $("#book_select").val();

    if (false == checkInputFOrTab(keyword)) {
        return false;
    }

    keyword = $.trim(keyword);

    var json = {
        "keyword" : keyword,
        "bookid" : bookid
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "./microinfo";
    var contentType = "application/json;charset=utf-8";

    ajaxFunc(methodType, url, data, contentType, microSuccessCB, null);
}
function microSuccessCB(data, textStatus, jqXHR) {
    if (null == data) {
    	$("#result_content").html(NO_RESULT);
        return false;
    } else {
        /* nav_top div */
        var str = '<div class="nav_top">'
                    + '<div class="search_result">'
                        + '<span class="text_search">搜索结果：</span><a class="search_name">'
                        + $("#query_input").val()
                        + '</a>'
                        +'</span>'
                        + '<span class="text_webrecommend"><a class="net_push_info" href="#">网络推荐</a><img src="../resources/identification/images/Web_Recommend.png" height="27" width="20"/></span>'
                    + '</div>' 
                + '</div>';
        $("#result_content").html("");
        $("#result_content").append(str);

        var line_div = '<div id="underline_category"></div>';
        $("#result_content").append(line_div);

        var str2= '<div id="background_content">'
                + '<div class="table" style="background-color:#FFF">'
                    + '<table>' 
                        + '<tr>'
                            + '<th class="text_herb_left"><span>显微信息</span></th>'
                            + '<th class="herb_midd">'
                            + data.microintro
                            + '</th>'
                            + '<th class="herb_left"></th>'
                        + '</tr>'
                    + '</table>'
                    + '<div id="underline_down_info"></div>'

                    + '<table>'
                        + '<tr>'
                            + '<th id="text_herb_left"><span>图片</span></th>'
                            + '<th id="herb_midd">'
                                + '<div id="micro_img_ul" class="micro_img_right" style="background-image:url(../resources/identification/images/banner_border_03.png); width:690px; height:132px;">'
                                    + '<ul>'
                                        + '<li><a href="#" ><img src="../resources/identification/images/arrow_large_prev.png" height="122" width="15"></a></li>'
                                        + '<li><span><a href="#"><img src="../resources/identification/images/test.png" width="150"/></a></span></li>'
                                        + '<li><span><a href="#"><img src="../resources/identification/images/test.png" width="150"/></a></span></li>'
                                        + '<li><span><a href="#"><img src="../resources/identification/images/test.png" width="150"/></a></span></li>'
                                        + '<li><span><a href="#"><img src="../resources/identification/images/test.png" width="150"/></a></span></li>'
                                        + '<li><a href="#"><img src="../resources/identification/images/arrow_large_next.png" height="122" width="15"></a></li>'
                                    + '</ul>'
                                + '</div> '
                            + '</th>'
                        + '</tr>'
                    + '</table>'
                + '</div>'

                + '</div>';

        $("#result_content").append(str2);
    }
}

/**
 * get forge mix information
 * @returns {Boolean}
 */
function getForgeMixInfo() {
    var keyword = $("#query_input").val();

    if (false == checkInputFOrTab(keyword)) {
        return false;
    }

    keyword = $.trim(keyword);
    var json = {
        "keyword" : keyword
    };
    var data = JSON.stringify(json);
    var methodType = "POST";
    var url = "./forgemixinfo";
    var contentType = "application/json;charset=utf-8";

    ajaxFunc(methodType, url, data, contentType, forgetMixSuccessCB, null);
}
function forgetMixSuccessCB(data, textStatus, jqXHR) {
    if (null == data) {
    	$("#result_content").html(NO_RESULT);
        return false;
    } else {
        $("#result_content").html("");
        
        $("#result_content")
        .append("<div style='color:red;margin:0 auto;width:600px;'>真品图片</div><div id='true_img_part' style='border:0px;width:600px;margin:5px auto;' class='scroll-img'><ul id='true_img_part_ul' style='width:1500px;height:245px;'></ul></div>");
        
        var true_str="";
        $.each(data,function(i,item){
        	if(true == data[i].imgflag)
            {
        		var src = pic_root_url + data[i].imgpath + ".jpg";
        		true_str += "<li>"+'<img src="'+src+'" height="250" width="200" title="'+item.imgname+'"/>'+"</li>";
            }
        });
        
        $("#true_img_part_ul").html(true_str);
        
        $('#true_img_part').scrollbox({
    	  direction: 'h',
    	  distance: 140
    	});
        
        
        $("#result_content")
                .append("<div style='color:red;margin:0 auto;width:600px;'>伪混图片</div><div id='booklet_bg' style='font:normal 12px/1.2 arial, verdana, sans-serif;'></div>");
        $("#booklet_bg").html("<section><div id='booklet'></div></section>");

        var str = "";
        for ( var i = 0; i < data.length; i++) {
        	if(false == data[i].imgflag)
            {
	            str += '<div style="text-align:center;vertical-align:middle;">';
	                var src = pic_root_url + data[i].imgpath + ".jpg";
	                str += '<div><img src="' + src + '"/></div>';
	            str += '</div>';

                str += '<div style="font-size:14px;">';
                str += '<div style="margin-top:10px;">';
                    str += '伪品名称:';
                str += '</div>';
                str += '<div style="margin-top:10px;text-indent:16px;">';
                    str +=  data[i].imgname;
                str += '</div>';
                str += '<div style="margin-top:20px;">伪品简介:</div>';
                if(null != data[i].forgemixintro )
                    str += '<div style="margin-top:10px;text-indent:16px;">'+data[i].forgemixintro+ '</div>';
                else
                    str += '<div style="margin-top:10px;text-indent:16px;">'+"暂无"+ '</div>';
                str += "</div>";
            }
            
        }
        $("#booklet").html(str);

        /* 初始化翻书页 */
        $("#booklet").booklet({ 
            height: 320,
            ause: "#customPause",
            arrows: true,
            arrowsHide: true,
            padding:2,
            auto: true
            
        });
    }
}
