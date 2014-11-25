
$(function(){	

});

/*初始化分类浏览结果页面*/
var table="";
function initSeniorSearchResult(){
	type = decodeURI(getUrlParam("type"));
	$('#senior_search_type').html("<div class='senior_rs_tab'>搜索到的信息如下</div>");
		
	if(type == "dis")
		
		getDisList();
	
	else if (type=="disc")
		
		getDiscList();
	
	else if (type=="ther")
		
		getTherList();
	
}

function getDisList()
{
		var dataJson = 
	{
		"disname": decodeURI(getUrlParam("disname")),
		"pageno" : parseInt(getUrlParam("pageno")),
		"pagesize":pageSize
	};
	
	var url = "./dislist";
	var contentType = "text";
	$.ajax({
		  type: 'POST',
		  url: url,
		  data: dataJson,
		  success: getSeniorListSuccessCB,
		  error: getSeniorListErrorCB,
		  dataType: contentType
		});
	
}

function getDiscList()
{
	var dataJson=
		{
			"discword": decodeURI(getUrlParam("discword")),
			"pageno": parseInt(getUrlParam("pageno")),
			"pagesize":pageSize
		};
	var url="./disclist";
	var contentType="text";
	$.ajax({
		type:"POST",
		url: url,
		data: dataJson,
		success: getSeniorListSuccessCB,
		error :getSeniorListErrorCB,
		dataType: contentType
	});
}

function getTherList()
{
	var dataJson=
		{
			"therword": decodeURI(getUrlParam("therword")),
			"pageno": parseInt(getUrlParam("pageno")),
			"pagesize":pageSize
		};
	var url="./therlist";
	var contentType="text";
	$.ajax({
		type:"POST",
		url: url,
		data: dataJson,
		success: getSeniorListSuccessCB,
		error :getSeniorListErrorCB,
		dataType: contentType
	});
}

function getSeniorListSuccessCB(data, textStatus, jqXHR)
{

	data=eval('(' + data + ')');
	var searchContent = window.location.search;
	var index = searchContent.indexOf("pageno", 0);
	
	var typeEn = "other"
    var table = listToTable(data.list,typeEn);  
    
    $("#senior_search_list_title").html(getTableTitle(typeEn));
    $("#senior_search_list_info").html(table);

	if(parseInt(data.count) <= pageSize)
		$("#senior_search_pagincation").hide();
    
	else
		$("#senior_search_pagincation").pagination({
			items:parseInt(data.count),
	        itemsOnPage: pageSize,
	        cssStyle: 'light-theme',
	        hrefTextPrefix:'#',
	        onPageClick:function(pageNumber, event){
	        	window.location.href = "./seniorsearch" + searchContent.substring(0, index)
	        						 + "pageno=" + pageNumber;
	        },
	        prevText:"上一页",
	        nextText:"下一页",
	        currentPage:getUrlParam("pageno")
	    });
	
}

function getSeniorListErrorCB(data, textStatus, jqXHR){
	
}

/*初始化分类浏览*/
function initClassify(){
	
	
	var type = decodeURI(getUrlParam("type"));
	
	if(type == "wordfrequency" || type == "null")
	{
		getWFSearchType();
	}
	
	else if(type == "medicalclassify")
	{
		getMCSearchType();
	}
	else if(type == "discriminate")
	{
		getDiscSearchType();
	}
	
	
	$('#classify_wordfrequency').live('click', function () {
		window.location.href = "./Browse?type=wordfrequency";
	});	
		
	$('#classify_medicalclassify').live('click', function () {
		window.location.href = "./Browse?type=medicalclassify";
	});	
	
	$('#classify_discriminate').live('click', function () {
		window.location.href = "./Browse?type=discriminate";
	});	
	
	
	window.location.hash = "#home_type_nav";
	
}

/*生成按词频浏览标签*/

function getWFSearchType(){
	var string = '<ul id="navlist"><li><a href="#"  id="classify_wordfrequency">&nbsp;按词频浏览&nbsp;</a></li>' 
		   + '<li><a href="#" id="classify_medicalclassify">&nbsp;按医学分类浏览&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_discriminate">&nbsp;辨证&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	//
	tempArray = new Array("胃脘","胁痛","痛经","痹证","咳嗽","癃闭","不孕","闭经","遗尿","脑炎","痿证","胃痛",
			"癫痫","肺炎","遗精","喘证","耳聋","肾病","咳血","胃炎","虚劳","咯血","失眠","肾炎","口疮","噎膈","淋证",
			"湿疹","痢疾","肺痨","乳糜","血证","伏暑","反胃","红斑","心衰","肺癌","胃癌","血崩","偏瘫","吐血","失音",
			"子痫","肝硬化","关节炎","糖尿病","高血压","结肠炎","冠心病","荨麻疹","偏头痛","心绞痛","白血病","肠梗阻","尿毒症","心肌炎","心脏病",
			"银屑病","乙型肝炎");
	table = "";
	table += "<table id='mian-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>常见疾病:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("湿热","气滞","气虚","脾虚","阴虚","寒湿","淤血","肾虚","风邪","少阳","阳虚","冲任","血虚","风寒","郁热","虚寒","寒邪","三焦","中焦","津液","内热","血亏","风湿","无力","炽盛","寒热","心包","肝火","郁滞","中气","入营","心悸","肾亏","生风","肾阳虚","肾阴虚");
	table += "<tr><td  class='c-left-text'>辩证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("清热","益气","健脾","活血","化痰","通络","养血","解毒","滋阴","疏肝","熄风","补肾","温阳","理气","止血","宣肺","开窍","祛风","利水","止痛","安神","散结","补气","补血","除湿","养心","生津","温中","补益","解郁","消肿","降火","止咳","止痒","利尿","活血化瘀","清热解毒","疏肝理气","平肝潜阳","行气活血","");
	table += "<tr><td  class='c-left-text'>治则:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("./Browse/result?wd="+ $(this).text() +"&type=wordfrequency&pageNo=1&pageSize=10");
	});
	
	$("#mian-table").html(table + "</table>");
}


/*生成辩证的标签*/
function getDiscSearchType(){
	var string = '<ul id="navlist"><li><a href="#"  id="classify_wordfrequency">&nbsp;按词频浏览&nbsp;</a></li>' 
		   + '<li><a href="#" id="classify_medicalclassify">&nbsp;按医学分类浏览&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_discriminate">&nbsp;辨证&nbsp;</a></li></ul>';
    $("#navcontainer").html(string);
    //
    tempArray = new Array("表里辨证","寒热辨证","虚实辨证","阴阳辨证");
	table = "";
	table += "<table id='mian-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>八纲辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("心与小肠病辨证","肺与大肠病辨证","脾与胃病辨证","肝与胆病辨证","肾与膀胱病辨证","脏腑兼证辨证");
	table += "<tr><td  class='c-left-text'>脏腑辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("太阳病辨证","阳明病辨证","少阳病辨证","太阴病辨证","少阴病辨证","厥阴病辨证")
	table += "<tr><td  class='c-left-text'>六经辨证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("卫分证辨证","气分证辨证","营分证辨证","血分证辨证","三焦辨证")
	table += "<tr><td  class='c-left-text'>卫气营血辨证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("上焦病辨证","中焦病辨证","下焦病辨证")
	table += "<tr><td  class='c-left-text'>三焦辨证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("气病辨证","血病辨证","气血同病辨证","津液病辨证")
	table += "<tr><td  class='c-left-text'>气血津液辨证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("六淫病辨证","疫疠病辨证","七情病辨证","饮食劳伤辨证","外伤辨证")
	table += "<tr><td  class='c-left-text'>病因辨证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("发热","恶寒","头痛","眩晕","烦躁","失眠","心悸","喘","哮鸣","咳血","呕吐","腹泻","便血","心下痞","胃脘痛","皮肤发黄","便秘","腹满腹痛","咽喉痛","吐血","小便不利","骨关节痛","手足逆冷","汗出")
	table += "<tr><td  class='c-left-text'>症状辨证:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("./Browse/result?wd="+ $(this).text() +"&type=discriminate&pageNo=1&pageSize=10");
	});
	
	$("#mian-table").html(table + "</table>");
    
    
}
/*
function getTherSearchType(){
	var string = '<ul id="navlist"><li><a href="#"  id="classify_dis">&nbsp;疾病&nbsp;</a></li>' 
		   + '<li><a href="#" id="classify_ther">&nbsp;治则&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_disc">&nbsp;辩证&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_other">&nbsp;其他&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	//
	tempArray = new Array("清热","益气","健脾","活血","化痰","通络","养血","解毒","滋阴","疏肝","熄风","补肾","温阳","理气","止血","宣肺","开窍","祛风","利水","止痛","安神","散结","补气","补血","除湿","养心","生津","温中","补益","解郁","消肿","降火","止咳","止痒","利尿","活血化瘀","清热解毒","疏肝理气","平肝潜阳","行气活血","");
	table = "";
	table += "<table id='mian-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>治则:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("seniorsearch?therword=" + $(this).text() + "&type=ther&pageno=1");
	});
	
	$("#mian-table").html(table + "</table>");
}
*/
function getMCSearchType(){
	var string = '<ul id="navlist"><li><a href="#"  id="classify_wordfrequency">&nbsp;按词频浏览&nbsp;</a></li>' 
		   + '<li><a href="#" id="classify_medicalclassify">&nbsp;按医学分类浏览&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_discriminate">&nbsp;辨证&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	//
	tempArray = new Array("外感病","肺系病","脾胃病证","肾系病","心系病","肝胆病证","气血津液病证","经络肢体病证","中毒","杂病");
	table = "";
	table += "<table id='mian-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>内科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("疮疡","疖","痈","疽","疗","痰核瘰疬","乳房疾病","肛肠疾病","小便异常","男科疾病","肿瘤","其它外科疾病","皮肤病");
	table += "<tr><td  class='c-left-text'>外科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("骨折","关节脱位","软组织损伤","内伤");
	table += "<tr><td  class='c-left-text'>骨科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("月经病","带下病","妊娠病","临产","妇科杂病");
	table += "<tr><td  class='c-left-text'>妇科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("眼睑病","白睛病","黑睛病","内障病","其它");
	table += "<tr><td  class='c-left-text'>眼科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("耳病","鼻病","咽喉病","口腔病");
	table += "<tr><td  class='c-left-text'>耳鼻喉科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("./Browse/result?wd="+ $(this).text() +"&type=medicalclassify&pageNo=1&pageSize=10");
	});
	
	$("#mian-table").html(table + "</table>");
}

/*��ʼ����ϲ�ѯ*/
/*function initSeniorSearch(){
	
	window.location.hash = "#home_type_nav";
	
	var type = decodeURI(getUrlParam("type"));
	
	if(type == "med" || type == "null")
		initMedSenior();
	
	else if(type == "chem")
		initChemSenior();
	
	else if(type == "ori")
		initOriSenior();
	
	else if(type == "pre")
		initPreSenior();
	
	else if(type == "syn")
		initSynSenior();
	
	else if(type == "dis")
		initDisSenior();

	
	$('#senior_med').live('click', function () {
		window.location.href = "./senior?type=med";
	});	
	
	$('#senior_chem').live('click', function () {
		window.location.href = "./senior?type=chem";
		
	});	
	$('#senior_ori').live('click', function () {
		window.location.href = "./senior?type=ori";
	});	
	
	$('#senior_syn').live('click', function () {
		window.location.href = "./senior?type=syn";
	});	
	
	$('#senior_pre').live('click', function () {
		window.location.href = "./senior?type=pre";
	});	
	
	$('#senior_dis').live('click', function () {
		window.location.href = "./senior?type=dis";
	});	
}

function initMedSenior(){
	 var dataJson = 
		{
		};
		var methodType = "POST";
		var url = "./medsearchtype";
		var contentType = "application/json;charset=utf-8";
		var data = "";
		ajaxFunc(methodType,url,data,contentType,getMedSearchTypeForSeniorSuccessCB,getSeniorListErrorCB);
}

function getMedSearchTypeForSeniorSuccessCB(data, textStatus, jqXHR){
	var string = '<ul id="navlist"><li><a href="#" id="current"  id="senior_med">&nbsp;��ζҩ&nbsp;</a></li>' 
		   + '<li><a href="#" id="senior_chem">&nbsp;������&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_ori">&nbsp;ҩ�ö�ֲ��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_pre">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_dis">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_syn">&nbsp;֤&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	
	var content = '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�&nbsp;'
				+ '<input name="fjone" class="senior_input" id="med_name"/></span>'
			    + '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ч��&nbsp;'
			    + '<select id="med_function" class="senior_option_select senior_input"></select></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ζ��&nbsp;'
			    + '<select id="med_property" class="senior_option_select senior_input"></select></span>'
				+ '<span class="s-title fj"> ҩ�ò�λ��&nbsp;'
			    + '<select id="med_part" class="senior_option_select senior_input"></select></span>'
			    + '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�أ�&nbsp;'
			    + '<select id="med_location" class="senior_option_select senior_input"></select></span>'
			    + '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;'
			    + '<select id="med_tropisw" class="senior_option_select senior_input"></select></span>'
			    + '<span><input type="button" class="fjbutton" id="senior_med_btn"/></span>'
			    + '<span class="s-title fj"><input id="med_function_in" class="senior_option_input senior_input"/></span>'
    			+ '<span class="s-title fj"><input id="med_part_in" class="senior_option_input senior_input"/></span>'
				+ '<span class="s-title fj"><input id="med_property_in" class="senior_option_input senior_input"/></span>'
				+ '<span class="s-title fj"><input id="med_tropisw_in" class="senior_option_input senior_input"/></span>'
				+ '<span class="s-title fj"><input id="med_location_in" class="senior_option_input senior_input"/></span>'
	$("#senior_content").html(content);
	
	var option = "";
	for(var i = 0 ; i < data.medfunction.length; i++){
		option += "<option value='" + data.medfunction[i] + "'>" + data.medfunction[i] + "</option>";
	}
	$("#med_function").html(option);
	overhiddenSelectByInput("med_function");
	
	tempArray = new Array("ȫ��","��","��","Ҷ","��","��ʵ","����","������","��","�׳�","��","����","ȫ��","��","��");
	var option = "";
	for(var i = 0 ; i < tempArray.length; i++){
		option += "<option value='" + tempArray[i] + "'>" + tempArray[i] + "</option>";
	}
	$("#med_part").html(option);
	overhiddenSelectByInput("med_part");
	
	//��ʼ����ζ
	tempArray = new Array("��","��","��","��","ƽ","��","��","��","��","ɬ","��","�ж�","�޶�");
	var option = "";
	for(var i = 0 ; i < tempArray.length; i++){
		option += "<option value='" + tempArray[i] + "'>" + tempArray[i] + "</option>";
	}
	$("#med_property").html(option);
	overhiddenSelectByInput("med_property");
	
	//��ʼ���龭
	tempArray = new Array("��","��","Ƣ","��","��","����","С��","��","θ");
	var option = "";
	for(var i = 0 ; i < tempArray.length; i++){
		option += "<option value='" + tempArray[i] + "'>" + tempArray[i] + "</option>";
	}
	$("#med_tropisw").html(option);
	overhiddenSelectByInput("med_tropisw");
	
	//��ʼ�����
	tempArray = new Array("����","�Ϻ�","����","����","����","���","����","����","�㽭","����","����","�㶫","����","����","�Ĵ�","ɽ��","����","����","����","����","�ӱ�","����","ɽ��","����","����","���ɹ�","����","�ຣ","�½�","����","����","���","����","̨��");
	var option = "";
	for(var i = 0 ; i < tempArray.length; i++){
		option += "<option value='" + tempArray[i] + "'>" + tempArray[i] + "</option>";
	}
	$("#med_location").html(option);
	overhiddenSelectByInput("med_location");
	
	
	$('#senior_med_btn').live('click', function () {
		window.open("./seniorsearch?medname=" + $("#med_name").val() 
				  + "&medfunction=" + $("#med_function_in").val()
				  + "&medpart=" + $("#med_part_in").val()
				  + "&medproperty=" + $("#med_property_in").val()
				  + "&medtropisw=" + $("#med_tropisw_in").val()
				  + "&medlocation=" + $("#med_location_in").val()
				  + "&type=med&pageno=1");
	});	
		
	window.location.hash = "#home_type_nav";
}

function initChemSenior(){
	var string = '<ul id="navlist"><li><a href="#"  id="senior_med">&nbsp;��ζҩ&nbsp;</a></li>' 
		   + '<li><a href="#" id="current" id="senior_chem">&nbsp;������&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_ori">&nbsp;ҩ�ö�ֲ��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_pre">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_dis">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_syn">&nbsp;֤&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	
	var content = '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�&nbsp;'
				+ '<input name="fjone" class="senior_input" id="chem_name"/></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;ʽ��&nbsp;'
			    + '<input name="fjone" class="senior_input" id="formula" /></span>'
				+ '<span class="s-title fj"> CAS�ţ�&nbsp;'
			    + '<input name="fjone" class="senior_input" id="cas" /></span>'
			    + '<span><input type="button" class="fjbutton" id="senior_chem_btn"/></span>';
	$("#senior_content").html(content);
	$('#senior_chem_btn').live('click', function () {
		window.open("./seniorsearch?chemname=" + $("#chem_name").val() 
				  + "&formula=" + $("#formula").val()
				  + "&cas=" + $("#cas").val()
				  + "&type=chem&pageno=1");
	});	
	
	window.location.hash = "#home_type_nav";
}

function initOriSenior(){
	var string = '<ul id="navlist"><li><a href="#"  id="senior_med">&nbsp;��ζҩ&nbsp;</a></li>' 
		   + '<li><a href="#" id="senior_chem">&nbsp;������&nbsp;</a></li>'
		   + '<li><a href="#" id="current" id="senior_ori">&nbsp;ҩ�ö�ֲ��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_pre">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_dis">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_syn">&nbsp;֤&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	
	var content = '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�&nbsp;'
				+ '<input name="fjone" class="senior_input" id="ori_name"/></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;'
			    + '<input name="fjone" class="senior_input" id="ori_family" /></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;̬��&nbsp;'
			    + '<input name="fjone" class="senior_input" id="ori_appearance" /></span>'
				+ '<span class="s-title fj"> ��Դ�ֲ���&nbsp;'
			    + '<input name="fjone" class="senior_input" id="ori_location" /></span>'
				+ '<span class="s-title"> ��̬������&nbsp;'
			    + '<input name="fjone" class="senior_input" id="ori_environment" /></span>'
				+ '<span class="s-title"> ������գ�&nbsp;'
			    + '<input name="fjone" class="senior_input" id="ori_recovery" /></span>'
			    + '<span><input type="button" class="fjbutton" id="senior_ori_btn"/></span>';

	$("#senior_content").html(content);

	$('#senior_ori_btn').live('click', function () {
		window.open("./seniorsearch?oriname=" + $("#ori_name").val() 
				  + "&orifamily=" + $("#ori_family").val()
				  + "&oriappearance=" + $("#ori_appearance").val()
				  + "&orilocation=" + $("#ori_location").val()
				  + "&orienvironment=" + $("#ori_environment").val()
				  + "&orirecovery=" + $("#ori_recovery").val()
				  + "&type=ori&pageno=1");
	});	
	
	window.location.hash = "#home_type_nav";
}

function initSynSenior(){
	 var dataJson = 
		{
		};
		var methodType = "POST";
		var url = "./synsearchtype";
		var contentType = "application/json;charset=utf-8";
		var data = "";
		ajaxFunc(methodType,url,data,contentType,getSynSearchTypeForSeniorSuccessCB,getSeniorListErrorCB);
}

function getSynSearchTypeForSeniorSuccessCB(data, textStatus, jqXHR){
	var string = '<ul id="navlist"><li><a href="#"  id="senior_med">&nbsp;��ζҩ&nbsp;</a></li>' 
		   + '<li><a href="#" id="senior_chem">&nbsp;������&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_ori">&nbsp;ҩ�ö�ֲ��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_pre">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_dis">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="current" id="senior_syn">&nbsp;֤&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	
	var content = '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�&nbsp;'
				+ '<input name="fjone" class="senior_input" id="syn_name"/></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�飺&nbsp;'
			    + '<input name="fjone" class="senior_input" id="syn_summary" /></span>'
				+ '<span class="s-title fj"> �ٴ����֣�&nbsp;'
			    + '<input name="fjone" class="senior_input" id="syn_symptom" /></span>'
				+ '<span class="s-title"> ����֢��&nbsp;'
			    + '<input name="fjone" class="senior_input" id="syn_illness" /></span>'
				+ '<span class="s-title"> ��֤������&nbsp;'
			    + '<input name="fjone" class="senior_input" id="syn_discrimination" /></span>'
			    + '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ࣺ&nbsp;'
			    + '<select id="syn_class" class="senior_option_select senior_input"></select></span>'
			    + '<span><input type="button" class="fjbutton" id="senior_syn_btn"/></span>'
			    + '<span class="s-title fj"><input id="syn_class_in" class="senior_option_input senior_input"/></span>';
	
	var option = "";
	for(var i = 0 ; i < data.synclass.length; i++){
		option += "<option value='" + data.synclass[i] + "'>" + data.synclass[i] + "</option>";
	}

	$("#senior_content").html(content);
	$("#syn_class").html(option);
	overhiddenSelectByInput("syn_class");

	$('#senior_syn_btn').live('click', function () {
		window.open("./seniorsearch?synname=" + $("#syn_name").val() 
				  + "&synsummary=" + $("#syn_summary").val()
				  + "&synsymptom=" + $("#syn_symptom").val()
				  + "&synillness=" + $("#syn_illness").val()
				  + "&syndiscrimination=" + $("#syn_discrimination").val()
				  + "&synclass=" + $("#syn_class_in").val()
				  + "&type=syn&pageno=1");
	});	
	
	window.location.hash = "#home_type_nav";
}

function initPreSenior(){
	var string = '<ul id="navlist"><li><a href="#"  id="senior_med">&nbsp;��ζҩ&nbsp;</a></li>' 
		   + '<li><a href="#" id="senior_chem">&nbsp;������&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_ori">&nbsp;ҩ�ö�ֲ��&nbsp;</a></li>'
		   + '<li><a href="#" id="current" id="senior_pre">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_dis">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_syn">&nbsp;֤&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	
	var content = '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�&nbsp;'
				+ '<input name="fjone" class="senior_input" id="pre_name"/></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ɣ�&nbsp;'
			    + '<input name="fjone" class="senior_input" id="pre_attention" /></span>'
				+ '<span class="s-title fj"> ������ɣ�&nbsp;'
			    + '<input name="fjone" class="senior_input" id="pre_dosage" /></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ч��&nbsp;'
			    + '<input name="fjone" class="senior_input" id="pre_function" /></span>'
				+ '<span class="s-title"> ����������&nbsp;'
			    + '<input name="fjone" class="senior_input" id="pre_book" /></span>'
			    + '<span><input type="button" class="fjbutton" id="senior_pre_btn"/></span>';


	$("#senior_content").html(content);

	$('#senior_pre_btn').live('click', function () {
		window.open("./seniorsearch?prename=" + $("#pre_name").val() 
				  + "&predosage=" + $("#pre_dosage").val()
				  + "&prebook=" + $("#pre_book").val()
				  + "&preattention=" + $("#pre_attention").val()
				  + "&prefunction=" + $("#pre_function").val()
				  + "&type=pre&pageno=1");
	});	
	
	window.location.hash = "#home_type_nav";
}

function initDisSenior(){	
	 var dataJson = 
		{
		};
		var methodType = "POST";
		var url = "./dissearchtype";
		var contentType = "application/json;charset=utf-8";
		var data = "";
		ajaxFunc(methodType,url,data,contentType,getDisSearchTypeForSeniorSuccessCB,getSeniorListErrorCB);
}

function getDisSearchTypeForSeniorSuccessCB(data, textStatus, jqXHR){
	var string = '<ul id="navlist"><li><a href="#"  id="senior_med">&nbsp;��ζҩ&nbsp;</a></li>' 
		   + '<li><a href="#" id="senior_chem">&nbsp;������&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_ori">&nbsp;ҩ�ö�ֲ��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_pre">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="current" id="senior_dis">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li>'
		   + '<li><a href="#" id="senior_syn">&nbsp;֤&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	
	var content = '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�&nbsp;'
				+ '<input name="fjone" class="senior_input" id="dis_name"/></span>'
				+ '<span class="s-title"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;'
			    + '<input name="fjone" class="senior_input" id="dis_description" /></span>'
			    + '<span class="s-title fj"> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ࣺ&nbsp;'
			    + '<select id="dis_class" class="senior_option_select senior_input"></select></span>'
			    + '<span><input type="button" class="fjbutton" id="senior_dis_btn"/></span>'
			    + '<span class="s-title fj"><input id="dis_class_in" class="senior_option_input senior_input"/></span>';
	
	var option = "";
	for(var i = 0 ; i < data.disclass.length; i++){
		option += "<option value='" + rtrim(data.disclass[i]) + "'>" + rtrim(data.disclass[i]) + "</option>";
	}

	$("#senior_content").html(content);
	$("#dis_class").html(option);
	overhiddenSelectByInput("dis_class");

	$('#senior_dis_btn').live('click', function () {
		window.open("./seniorsearch?disname=" + $("#dis_name").val() 
				  + "&disdescription=" + $("#dis_description").val()
				  + "&disclass=" + $("#dis_class_in").val()
				  + "&type=dis&pageno=1");
	});	
	
	window.location.hash = "#home_type_nav";
}

function rtrim(value) {

	while (value.charAt(value.length - 1) == ' ' || value.charAt(value.length - 1) == ' ' || value.charAt(value.length - 1) == '��') {
		value = value.substring(0, value.length - 1);
	}
	return value;
}

function overhiddenSelectByInput(id){
	$("#" + id + "_in").offset({top: $("#" + id).offset().top, left: $("#" + id).offset().left});
	
	var input = document.getElementById(id + "_in");
	var select = document.getElementById(id);
	select.onchange = function(){
		input.value = input.value.length == 0? this.value : input.value + " " + this.value;
		};
}*/