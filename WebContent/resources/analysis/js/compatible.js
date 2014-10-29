function initCompatible(){
	$('.compatible').live('click', function() {
		var info = $(this).text();
		var result = getParam(info);
		var pa1 = result[1];
		var pa2 = result[2];
		print(result);
		$(".medAName").html(pa1);
		$(".medBName").html(pa2);
		showCompatible(pa1, pa2);
		$("#static_match").hide();
		$("#static_match_detail").show();
	});
}

function getParam(name) {
	var reg = new RegExp("(\\S*)\\s*(\\S*)");
	//var reg = new RegExp("([\\u4e00-\\u9fa5]*)[^\\u4e00-\\u9fa5]*([\\u4e00-\\u9fa5]*)");
	return name.match(reg);
}

function showCompatible(medAName, medBName) {
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
var table="";
function successConflict(data, textStatus, jqXHR) {
	print(data);
	var str = "";
	for ( var i = 0, j = 0; i < data.conflictList.length; i++, j++) {
		var preName = data.conflictList[i].preName;
		var preBook = data.conflictList[i].book;
		var preId= data.conflictList[i].preId;
		var tmp=preName+"-"+preBook;
		/*
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
		*/
		if (j == 6)
			j = 0;
		if (j == 0) {
			str += "<tr>" + "<td>" + "<a href='javascript:void(0)' "
					 + "ondblclick='fillStaticCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td>";
		} else if (j == 5) {
			str += "<td>"+ "<a href='javascript:void(0)' "
					 + "ondblclick='fillStaticCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td></tr>";
		} else {
			str += "<td>" + "<a href='javascript:void(0)' "
					 + "ondblclick='fillStaticCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td>";
		}
	}
	print(str);
	table=str;
	$('#compatibleTable').html(str);
}
var pre1="";
var pre2="";
var preStaticAnaArgCount =1;
function fillStaticCompareArgs(temp,preId){
 
	
	$("#static_pre_"+preStaticAnaArgCount).html(temp+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	$("#staticpre_"+preStaticAnaArgCount).html(temp+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	
   	if ( 1 == preStaticAnaArgCount){
	    preId1=preId;
		pre1=temp;
		preStaticAnaArgCount = 2;
	}
	else{
	    preId2=preId;
		pre2=temp;
		preStaticAnaArgCount = 1;
	}

}
function showCompare(){
 
  $("#static_match").hide();
  $("#static_match_detail").hide();
  $("#static_compare").show();
  
}
function showDynamicMatch(){
    $("#static_match").hide();
  $("#static_match_detail").hide();
  $("#static_compare").hide();
  $("#dynamic_match").show();
  
  $('#static_pie_chart_1').attr("src","./blank");
    $('#static_pie_chart_2').attr("src","./blank");
  
   var medName=$("#sub_q").val();
					
   $("#after_click").hide();			
   $("#home_med_ana").attr("src","./medana?medName="+medName);
   
  
}
function showList(data){
    $("#after_click").show();
	
	print(data);		
	totalPre=data.preCount;
	var str="";
			
	for ( var i = 0, j = 0; i < data.prelist.length; i++, j++) {
		var preName = data.prelist[i].pre_name_zh;
		print(preName);
		var preBook = data.prelist[i].pre_simple_book;
		var preId= data.prelist[i].preId;
		var tmp=preName+"-"+preBook;
		if (j == 6)
			j = 0;
		if (j == 0) {
			str += "<tr>" + "<td>" + "<a href='javascript:void(0)' "
					 + "ondblclick='fillCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td>";
		} else if (j == 5) {
			str += "<td>"+ "<a href='javascript:void(0)' "
					 + "ondblclick='fillCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td></tr>";
		} else {
			str += "<td>" + "<a href='javascript:void(0)' "
					 + "ondblclick='fillCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td>";
		}
	}
   $("#pre_table").html("");
    $("#pre_table").html(str);
	
	var medAName=data.medAName;
	
	var medBName=data.medBName;
	
	$("#medA").html(medAName);
	
	$("#medB").html(medBName);
	
	chagePageNo(num);
	
	$("#search_pagincation").show();
			  
}
var FromID;var ToID;
var totalPre=0;
var num=0;
function getPage(num){

        //chagePageNo(num);
		if(String(FromID).split(".").length == 1){
				var json = 
		    		{
		    		    "medAId":FromID,
		    			"medBId":ToID,
						"start" :(num-1)*40,
						"end" : num*40
		    		};
		    		var data = JSON.stringify(json);
		    		var methodType = "POST";
		    		var url = "./testclick";
		    		var contentType = "application/json;charset=utf-8";
		    		
		    		ajaxFunc(methodType,url,data,contentType,showList,null);
		}
		else{

			//var parmURL = "getPre=yes&"+"medList="+String(FromID)+"."+String(ToID)+"&from=0&to=40";
			
			//ajaxConnect("../PreComServlet",parmURL,edgeClickCallback);
			var medlist=String(FromID)+"."+String(ToID)
			var json = 
		    		{
		    			"medlist":medlist,
						"start" :(num-1)*40,
						"end" : num*40
		    		};
		    		var data = JSON.stringify(json);
		    		var methodType = "POST";
		    		var url = "./testtriclick";
		    		var contentType = "application/json;charset=utf-8";
		    		
		    		ajaxFunc(methodType,url,data,contentType,showTriPreList,null);
			
		}
}
function chagePageNo(number){


 $("#search_pagincation").pagination({
        items : totalPre,
        itemsOnPage : 40,
        cssStyle : 'light-theme',
        hrefTextPrefix : '#',
        onPageClick : function(pageNumber, event) {
           
			getPage(pageNumber);
			num=pageNumber;
			
        },
        prevText : "上一页",
        nextText : "下一页",
        currentPage : number
    });
	
}
function showTriPreList(data){

    $("#after_click").show();
	print(data);		
	totalPre=data.preCount;
	print(totalPre);
	var str="";
			
	for ( var i = 0, j = 0; i < data.prelist.length; i++, j++) {
		var preName = data.prelist[i].preName;
		var preBook = data.prelist[i].book;
		var preId= data.prelist[i].preId;
		var tmp=preName+"-"+preBook;
		if (j == 6)
			j = 0;
		if (j == 0) {
			str += "<tr>" + "<td>" + "<a href='javascript:void(0)' "
					 + "ondblclick='fillCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td>";
		} else if (j == 5) {
			str += "<td>"+ "<a href='javascript:void(0)' "
					 + "ondblclick='fillCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td></tr>";
		} else {
			str += "<td>" + "<a href='javascript:void(0)' "
					 + "ondblclick='fillCompareArgs(\""+tmp+"\",\""+preId+"\")'>" + preName + "</a></td>";
		}
	}
	$("#pre_table").html("");		  
    $("#pre_table").html(str);
	
	var medAName=data.medAName;
	
	var medBName=data.medBName;
	
	var medCName=data.medCName;
	
	$("#medA").html(medAName+","+medBName);
	
	$("#medB").html(medCName);
	

	
	chagePageNo(num);
	
	$("#search_pagincation").show();

}
var preAnaArgCount = 1;
var preId1=0;
var preId2=0;

function fillCompareArgs(temp,preId){
    print(preId);

	$("#pre_"+preAnaArgCount).html(temp+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	
   	if ( 1 == preAnaArgCount){
	   
		preId1=preId;
		preAnaArgCount = 2;
	}
	else{
	   
		preId2=preId;
		preAnaArgCount = 1;
	}

}
function dynamicPreCompare(){

 
 var json = 
	   {
		    "preId1": parseInt(preId1),
		    "preId2": parseInt(preId2)
       };
	   print(json);
	   var data = JSON.stringify(json);
	   var methodType = "POST";
	   var url = "./medcomchart";
	   var contentType = "application/json;charset=utf-8";
		    		
	   ajaxFunc(methodType,url,data,contentType,successMedComposeChart,null);
					
	   var url = "./precompreinfo";   		
	   ajaxFunc(methodType,url,data,contentType,successPreinfo,null);
					
	   var url = "./precomlist"; 		
	   ajaxFunc(methodType,url,data,contentType,successMedicineList,null);
  
  
  

   
}

function successMedComposeChart(data,textStatus, jqXHR){
			   
	pieChartData1=data.result1;
	pieChartData2=data.result2;
	
	type="dynamic";
	
	$('#pie_chart_1').attr("src","./medchartsubpage1");
    $('#pie_chart_2').attr("src","./medchartsubpage2");
			   
}
function successPreinfo(data,textStatus, jqXHR){
     
	 //$("#descriptor").html("<b>"+data.preInfo1.preName+"和"+data.preInfo2.preName+"的对比情况如下</b>");
	
	 //print(data.preInfo1);
	 $("#pre_name1").html(data.preInfo1.preName);
	 $("#pre_book1").html(data.preInfo1.book);
	 $("#pre_function1").html(data.preInfo1.function);
	 $("#pre_com1").html(data.preInfo1.dosage);
	 
	 //print(data.preInfo2);
	 $("#pre_name2").html(data.preInfo2.preName);
	 $("#pre_book2").html(data.preInfo2.book);
	 $("#pre_function2").html(data.preInfo2.function);
	 $("#pre_com2").html(data.preInfo2.dosage);
	 
	 if(data.preInfo1.function.length<=21)
	    $("#pre_function1").css("text-align","center");
	 if(data.preInfo2.function.length<=21)
	    $("#pre_function2").css("text-align","center");
	 if(data.preInfo1.dosage.length<=21)
	    $("#pre_com1").css("text-align","center");
	 if(data.preInfo2.dosage.length<=21)
	    $("#pre_com2").css("text-align","center");
	
	$("#result").show();
} 
function successMedicineList(data,textStatus, jqXHR){
    var common="";
	var source="";
	var target="";
    for(var i=0;i<data.commonList.length;i++)
	    common += "<a target=blank href=" + "../search/med?medname=" + data.commonList[i].medName + ">" + data.commonList[i].medName + "</a> ";
	for(var i=0;i<data.sourceList.length;i++)
	    source += "<a target=blank href=" + "../search/med?medname=" + data.sourceList[i].medName + ">" + data.sourceList[i].medName + "</a> ";
    for(var i=0;i<data.targetList.length;i++)
	    target += "<a target=blank href=" + "../search/med?medname=" + data.targetList[i].medName + ">" + data.targetList[i].medName + "</a> ";
	if(common==""){
	   $("#common1").html("无");
	   $("#common2").html("无");
	}
	else{
      $("#common1").html(common);
	  $("#common2").html(common);
	}
	$("#differ1").html(source);
	$("#differ2").html(target);
	
	if(source.length<=21)
	   $("#differ1").css("text-align","center");
	if(target.length<=21)
	  $("#differ2").css("text-align","center");
	  
}
function successStaticPreinfo(data,textStatus, jqXHR){
     
	 //$("#static_descriptor").html("<b>"+data.preInfo1.preName+"和"+data.preInfo2.preName+"的对比情况如下</b>");
	 //print(data.preInfo1);
	
	 
	 $("#static_pre_name1").html(data.preInfo1.preName);
	 $("#static_pre_book1").html(data.preInfo1.book);
	 $("#static_pre_function1").html(data.preInfo1.function);
	 $("#static_pre_com1").html(data.preInfo1.dosage);
	 
	 //print(data.preInfo2);
	 $("#static_pre_name2").html(data.preInfo2.preName);
	 $("#static_pre_book2").html(data.preInfo2.book);
	 $("#static_pre_function2").html(data.preInfo2.function);
	 $("#static_pre_com2").html(data.preInfo2.dosage);
	 
	 if(data.preInfo1.function.length<=21)
	    $("#static_pre_function1").css("text-align","center");
	 if(data.preInfo2.function.length<=21)
	    $("#static_pre_function2").css("text-align","center");
	 if(data.preInfo1.dosage.length<=21)
	    $("#static_pre_com1").css("text-align","center");
	 if(data.preInfo2.dosage.length<=21)
	    $("#static_pre_com2").css("text-align","center");
	
	
} 
var type="dynamic";
function drawPie1(){

    if(type=="dynamic")
			
	$('#pie_chart_1')[0].contentWindow.drawPieChart(pieChartData1);	
	
	else if(type="static")
	
	$('#static_pie_chart_1')[0].contentWindow.drawPieChart(pieChartData1);
	
			   
}
function drawPie2(){
			  
	if(type=="dynamic")
	
	$('#pie_chart_2')[0].contentWindow.drawPieChart(pieChartData2);
	
	else if(type="static")
	
	$('#static_pie_chart_2')[0].contentWindow.drawPieChart(pieChartData2);
}
function staticPreCompare(){
 
  
  $("#staticpre_1").html(pre1+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
  
  $("#staticpre_2").html(pre2+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
  
  var json = 
	   {
		    "preId1": parseInt(preId1),
		    "preId2": parseInt(preId2)
       };
	  var data = JSON.stringify(json);
	   var methodType = "POST";
	   var url = "./medcomchart";
	   var contentType = "application/json;charset=utf-8";
		    		
	   ajaxFunc(methodType,url,data,contentType,successStaticMedComposeChart,null);
					
	   var url = "./precompreinfo";   		
	   ajaxFunc(methodType,url,data,contentType,successStaticPreinfo,null);
					
	   var url = "./precomlist"; 		
	   ajaxFunc(methodType,url,data,contentType,successStaticMedicineList,null);
		
		$("#static_match_detail").hide();
		$("#static_match_table").html(table);
		$("#static_compare").show();
		$("#static_result").show();
		
}


function successStaticMedComposeChart(data,textStatus, jqXHR){
			   
	pieChartData1=data.result1;
	pieChartData2=data.result2;
	
	type="static";
			   
	$('#static_pie_chart_1').attr("src","./medchartsubpage1");
    $('#static_pie_chart_2').attr("src","./medchartsubpage2");
			   
}

function successStaticMedicineList(data,textStatus, jqXHR){
    var common="";
	var source="";
	var target="";
    for(var i=0;i<data.commonList.length;i++)
	    common += "<a target=blank href=" + "../search/med?medname=" + data.commonList[i].medName + ">" + data.commonList[i].medName + "</a> ";
	for(var i=0;i<data.sourceList.length;i++)
	    source += "<a target=blank href=" + "../search/med?medname=" + data.sourceList[i].medName + ">" + data.sourceList[i].medName + "</a> ";
    for(var i=0;i<data.targetList.length;i++)
	    target += "<a target=blank href=" + "../search/med?medname=" + data.targetList[i].medName + ">" + data.targetList[i].medName + "</a> ";
	if(common==""){
	   $("#static_common1").html("无");
	   $("#static_common2").html("无");
	}
	else{
      $("#static_common1").html(common);
	  $("#static_common2").html(common);
	}
	$("#static_differ1").html(source);
	$("#static_differ2").html(target);
	
	if(source.length<=21)
	   $("#static_differ1").css("text-align","center");
	if(target.length<=21)
	  $("#static_differ2").css("text-align","center");
	  
}