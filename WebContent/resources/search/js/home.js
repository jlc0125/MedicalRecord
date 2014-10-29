var pageSize=5;


$(function() {

	var checkBox = document.getElementsByName("option");
	for ( var k = 0; k < checkBox.length; k++)
		checkBox[k].checked = false;

	

	$('#front_btn').live(
			'click',
			function() {
				var keyword = $('#front_input').val();
				var range = "";
				var typeIndex = -1;
				for ( var k = 0; k < checkBox.length; k++) {
					if (checkBox[k].checked == true) {
						if (typeIndex == -1)
							typeIndex = k;
						range += "1";
					} else
						range += "0";
				}
				if (typeIndex == -1) {
					typeIndex = 0;
					range = "10"
				}
				window.location.href = "./frontsearch?keyword=" + keyword
						+ "&range=" + range + "&pageno=1" + "&type="
						+ typeEnMap[typeIndex];
			});

	window.location.hash = "#home_type_nav";
});

function initFront() {
	
	
	window.location.hash = "#sub_nav";
	getFrontList();

}


function getFrontList() {
	
	var dataJson = {
		"wd" : decodeURI(getUrlParam("wd")),
		"pageNo" : parseInt(getUrlParam("pageNo")),
		"pageSize" : pageSize
	};
	var methodType = "POST";
	var url = "./search/records";
	var contentType = "application/json;charset=utf-8";
	$.ajax({
		  type: methodType,
		  url: url,
		  data: dataJson,
		  success: getFrontListSuccessCB,
		  error:getFrontErrorCB,
		  dataType:"text"
		});
}



function getFrontListSuccessCB(data,textStatus,jqXHR) {
    
	console.log(pageSize);
	
    data=eval('(' + data + ')');
    console.log(parseInt(data.length));
	
	var table = listToTable(data);
	
	$("#front_search_list_title").html("嘻嘻");
	$("#front_search_list_info").html(table);
	
	if (100 <= pageSize)
	{	
		$("#front_search_pagincation").hide();
		if(parseInt(data.length)==0)
			getFrontErrorCB();
	}
	else
		$("#front_search_pagincation").pagination(
				{
					items : 100,
					itemsOnPage : pageSize,
					cssStyle : 'light-theme',
					hrefTextPrefix : '#',
					onPageClick : function(pageNumber, event) {
						window.location.href = "./search?wd="
								+ decodeURI(getUrlParam("wd")) + "&pageNo="
								+ pageNumber+"&pageSize="+pageSize;

					},
					prevText : "上一页",
					nextText : "下一页",
					currentPage : getUrlParam("pageNo")
				});
}

function getFrontErrorCB(){
	console.log("Error");
	
}