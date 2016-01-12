var medSearch = "";

function initConflict() {
	$('.conflict').live('click', function() {
		var info = $(this).text();
		var result = getParam(info);
		var pa1 = result[1];
		var pa2 = result[2];
		$(".medAName").html(pa1);
		$(".medBName").html(pa2);
		showConflict(pa1, pa2);
		$("#static_conflict").hide();
		$("#contradict").show();
	});

	$('#sub_search_button').live('click', function() {
		medSearch = $('#sub_q').val();
		if (medSearch != null && medSearch != '') {
			$("#medName") .html(medSearch);
			showMedConflict(medSearch);
			$("#static_conflict").hide();
			$("#contradict").hide();
			$("#conflict_search_result").show();
		}
	});
}

function getParam(name) {
	var reg = new RegExp("(\\S*)\\s*(\\S*)");
	return name.match(reg);
}

function showConflict(medAName, medBName) {
	var json = {
		"medAName" : medAName,
		"medBName" : medBName,
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./testconflict";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, successConflict, null);
}

function successConflict(data, textStatus, jqXHR) {
	print(data);
	var str = "";
	for ( var i = 0, j = 0; i < data.conflictList.length; i++, j++) {
		var preName = data.conflictList[i].preName;
		var preBook = data.conflictList[i].book;
		if (j == 6)
			j = 0;
		if (j == 0) {
			str += "<tr>" + "<td>" + "<a target=blank href="
					+ "../search/pre?prename=" + preName + "&prebook="
					+ preBook + ">" + preName + "</a></td>";
		} else if (j == 5) {
			str += "<td>" + "<a target=blank href=" + "../search/pre?prename="
					+ preName + "&prebook=" + preBook + ">" + preName
					+ "</a></td></tr>";
		} else {
			str += "<td>" + "<a target=blank href=" + "../search/pre?prename="
					+ preName + "&prebook=" + preBook + ">" + preName
					+ "</a></td>";
		}
	}
	print(str);
	$('#conflictTable').html(str);
}

function showMedConflict(medName) {
	var json = {
		"medName" : medName,
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./amedconflict";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, successMedConflict, null);
}

function successMedConflict(data, textStatus, jqXHR) {
	print(data);
	print(medSearch);
	var str= "";
	var medName = "";
	for ( var i = 0, j = 0; i < data.conflictList.length; i++, j++) {
		var medAName = data.conflictList[i].medAName;
		var medBName = data.conflictList[i].medBName;
		if(medAName == medSearch){
			medName = medBName;
		}else{
			medName = medAName;
		}
		print(medName);
		if (j == 6)
			j = 0;
		if (j == 0) {
			str += "<tr>" + "<td>" + "<a href='javascript:void(0)'  "+" ondblclick='showPre(\""+medName+"\")'>" + medName
					+ "</a></td>";
		} else if (j == 5) {
			str += "<td>" + "<a href='javascript:void(0)'  "+" ondblclick='showPre(\""+medName+"\")'>" + medName
					+ "</a></td></tr>";
		} else {
			str += "<td>" + "<a href='javascript:void(0)'  "+" ondblclick='showPre(\""+medName+"\")'>" + medName
					+ "</a></td>";
		}
	}
	$('#conflictMedTable').html(str);
}
/*
 * $("#static_conflict").hide(); $("#contradict").show();
 */
function showPre(medName){

 //alert(medName);
 
 $("#conflict_search_result_contradict").show();
 
 	var json = {
		"medAName" : medName,
		"medBName" : medSearch,
	};
	var data = JSON.stringify(json);
	var methodType = "POST";
	var url = "./testconflict";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, successDynamicConflict, null);
  
}
function successDynamicConflict(data){
    	print(data);
	var str = "";
	for ( var i = 0, j = 0; i < data.conflictList.length; i++, j++) {
		var preName = data.conflictList[i].preName;
		var preBook = data.conflictList[i].book;
		if (j == 6)
			j = 0;
		if (j == 0) {
			str += "<tr>" + "<td>" + "<a target=blank href="
					+ "../search/pre?prename=" + preName + "&prebook="
					+ preBook + ">" + preName + "</a></td>";
		} else if (j == 5) {
			str += "<td>" + "<a target=blank href=" + "../search/pre?prename="
					+ preName + "&prebook=" + preBook + ">" + preName
					+ "</a></td></tr>";
		} else {
			str += "<td>" + "<a target=blank href=" + "../search/pre?prename="
					+ preName + "&prebook=" + preBook + ">" + preName
					+ "</a></td>";
		}
	}
	print(str);
	$('#conflict_dynamic_contradict').html(str);
}
function showMed(medName){
 //alert();
  window.open("../search/med?medname="+ medName);
}