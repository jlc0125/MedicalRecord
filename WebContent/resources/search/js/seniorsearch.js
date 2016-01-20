
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
	else if(type == "therapy")
	{
		getTherSearchType();
	}
	
	$('#classify_wordfrequency').live('click', function () {
		window.location.href = "./browse?type=wordfrequency";
	});	
		
	$('#classify_medicalclassify').live('click', function () {
		window.location.href = "./browse?type=medicalclassify";
	});	
	
	$('#classify_discriminate').live('click', function () {
		window.location.href = "./browse?type=discriminate";
	});	
	
	$('#classify_therapy').live('click', function () {
		window.location.href = "./browse?type=therapy";
	});	
	
	
	window.location.hash = "#home_type_nav";
	
}

/*生成按词频浏览标签*/

function getWFSearchType(){
	$('#classify_wordfrequency').parent().addClass('active');
	tempArray = new Array("胃脘","胁痛","痛经","痹证","咳嗽","癃闭","不孕","闭经","遗尿","脑炎","痿证","胃痛",
			"癫痫","肺炎","遗精","喘证","耳聋","肾病","咳血","胃炎","虚劳","咯血","失眠","肾炎","口疮","噎膈","淋证",
			"湿疹","痢疾","肺痨","乳糜","血证","伏暑","反胃","红斑","心衰","肺癌","胃癌","血崩","偏瘫","吐血","失音",
			"子痫","肝硬化","关节炎","糖尿病","高血压","结肠炎","冠心病","荨麻疹","偏头痛","心绞痛","白血病","肠梗阻","尿毒症","心肌炎","心脏病",
			"银屑病","乙型肝炎");
	table = "";
	table += "<table id='main-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>常见疾病:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("湿热","气滞","气虚","脾虚","阴虚","寒湿","淤血","肾虚","风邪","少阳","阳虚","冲任","血虚","风寒","郁热","虚寒","寒邪","三焦","中焦","津液","内热","血亏","风湿","无力","炽盛","寒热","心包","肝火","郁滞","中气","入营","心悸","肾亏","生风","肾阳虚","肾阴虚");
	table += "<tr><td  class='c-left-text'>病症:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("清热","益气","健脾","活血","化痰","通络","养血","解毒","滋阴","疏肝","熄风","补肾","温阳","理气","止血","宣肺","开窍","祛风","利水","止痛","安神","散结","补气","补血","除湿","养心","生津","温中","补益","解郁","消肿","降火","止咳","止痒","利尿","活血化瘀","清热解毒","疏肝理气","平肝潜阳","行气活血","");
	table += "<tr><td  class='c-left-text'>治则:</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("./browse/result?wd="+ $(this).text() +"&type=wordfrequency");
	});
	
	$("#main-table").html(table + "</table>");
}


/*生成辨证的标签*/
function getDiscSearchType(){
	$('#classify_discriminate').parent().addClass('active');
    //
    tempArray = new Array("表里辨证","寒热辨证","虚实辨证","阴阳辨证");
	table = "";
	table += "<table id='main-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>八纲辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("心与小肠病辨证","肺与大肠病辨证","脾与胃病辨证","肝与胆病辨证","肾与膀胱病辨证","脏腑兼证辨证");
	table += "<tr><td  class='c-left-text'>脏腑辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("太阳病辨证","阳明病辨证","少阳病辨证","太阴病辨证","少阴病辨证","厥阴病辨证")
	table += "<tr><td  class='c-left-text'>六经辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("卫分证辨证","气分证辨证","营分证辨证","血分证辨证","三焦辨证")
	table += "<tr><td  class='c-left-text'>卫气营血辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("上焦病辨证","中焦病辨证","下焦病辨证")
	table += "<tr><td  class='c-left-text'>三焦辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("气病辨证","血病辨证","气血同病辨证","津液病辨证")
	table += "<tr><td  class='c-left-text'>气血津液辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("六淫病辨证","疫疠病辨证","七情病辨证","饮食劳伤辨证","外伤辨证")
	table += "<tr><td  class='c-left-text'>病因辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("发热","恶寒","头痛","眩晕","烦躁","失眠","心悸","喘","哮鸣","咳血","呕吐","腹泻","便血","心下痞","胃脘痛","皮肤发黄","便秘","腹满腹痛","咽喉痛","吐血","小便不利","骨关节痛","手足逆冷","汗出")
	table += "<tr><td  class='c-left-text'>症状辨证：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("./browse/result?wd="+ $(this).text() +"&type=discriminate");
	});
	
	$("#main-table").html(table + "</table>");
    
    
}

function getTherSearchType(){
	$('#classify_therapy').parent().addClass('active');
	//
	tempArray = new Array("标本缓急","正治","反治","同病异治","异病同治");
	table = "";
	table += "<table id='main-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text'>治病求本：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("扶正","祛邪");
	table += "<tr><td  class='c-left-text'>扶正祛邪：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("因时制宜","因地制宜","因人制宜");
	table += "<tr><td  class='c-left-text'>三因制宜：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("汗","吐","下","和","温","清","补","消");
	table += "<tr><td  class='c-left-text'>八法：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("消导化积","痈疡剂","清热","理血","泻下","解表","治燥","温里","祛痰","祛湿","补益","和解","治风","开窍","理气","固涩","驱虫","涌吐","安神","祛暑","表里双解","经产剂","疏肝解郁","耳鼻咽喉病方");
	table += "<tr><td  class='c-left-text'>治疗模式：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='zhifa'>" + tempArray[i] + "</a></span>";
	
	
	table += "</td></tr>";
	$('.dis_type_list').live('click', function () {			
		window.open("./browse/result?wd="+ $(this).text() +"&type=therapy");
	});
	$('.zhifa').live('click', function () {			
		window.open("./browse/result?wd="+ $(this).text() +"&type=therapylabel");
	});
	
	$("#main-table").html(table + "</table>");
	

}

function getMCSearchType(){
	$('#classify_medicalclassify').parent().addClass('active');
	//
	tempArray = new Array("外感病","肺系病","脾胃病证","肾系病","心系病","肝胆病证","气血津液病证","经络肢体病证","中毒","杂病");
	table = "";
	table += "<table id='main-table'><th class='c-left'></th><th class='c-right'></th>"
		  +	"<tr><td  class='c-left-text first_category' title='点击查看相关医案'>内科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("疮疡","疖","痈","疽","疗","痰核瘰疬","乳房疾病","肛肠疾病","小便异常","男科疾病","肿瘤","其它外科疾病","皮肤病");
	table += "<tr><td  class='c-left-text first_category' title='点击查看相关医案'>外科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("骨折","关节脱位","软组织损伤","内伤");
	table += "<tr><td  class='c-left-text first_category' title='点击查看相关医案'>骨科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("月经病","带下病","妊娠病","临产","妇科杂病");
	table += "<tr><td  class='c-left-text first_category' title='点击查看相关医案'>妇科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("眼睑病","白睛病","黑睛病","内障病","其它");
	table += "<tr><td  class='c-left-text first_category' title='点击查看相关医案'>眼科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	tempArray = new Array("耳病","鼻病","咽喉病","口腔病");
	table += "<tr><td  class='c-left-text first_category' title='点击查看相关医案'>耳鼻喉科：</td><td class='c-right-text'>";
	for(var i = 0 ; i < tempArray.length; i++)
		table += "<span class='classify_content_short'><a href='#' class='dis_type_list'>" + tempArray[i] + "</a></span>";
	
	
	table += "</td></tr>";
	
	
	$('.first_category').live('click', function () {			
		window.open("./browse/result?wd="+ $(this).text().replace("：", "") +"&type=medicalclassify_first");
	});

	$('.dis_type_list').live('click', function () {			
		window.open("./browse/result?wd="+ $(this).text() +"&type=medicalclassify");
	});
	
	$("#main-table").html(table + "</table>");
	
}

/*
function getWFSearchType(){
	var string = '<ul id="navlist"><li><i><a href="#"  id="classify_wordfrequency">&nbsp;按词频浏览&nbsp;</a></i></li>' 
		   + '<li><a href="#" id="classify_medicalclassify">&nbsp;按疾病分类浏览&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_discriminate">&nbsp;按辨证分类浏览&nbsp;</a></li>'
		   + '<li><a href="#" id="classify_therapy">&nbsp;按治则分类浏览&nbsp;</a></li></ul>';
	$("#navcontainer").html(string);
	//
	tempArray = new Array("胃脘","胁痛","痛经","痹证","咳嗽","癃闭","不孕","闭经","遗尿","脑炎","痿证","胃痛",
			"癫痫","肺炎","遗精","喘证","耳聋","肾病","咳血","胃炎","虚劳","咯血","失眠","肾炎","口疮","噎膈","淋证",
			"湿疹","痢疾","肺痨","乳糜","血证","伏暑","反胃","红斑","心衰","肺癌","胃癌","血崩","偏瘫","吐血","失音",
			"子痫","肝硬化","关节炎","糖尿病","高血压","结肠炎","冠心病","荨麻疹","偏头痛","心绞痛","白血病","肠梗阻","尿毒症","心肌炎","心脏病",
			"银屑病","乙型肝炎");
	table = "";
	table += "<table id='main-table'><th class='c-left'></th><th class='c-right'></th>"
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
		window.open("./Browse/result?wd="+ $(this).text() +"&type=wordfrequency");
	});
	
	$("#main-table").html(table + "</table>");
}
*/