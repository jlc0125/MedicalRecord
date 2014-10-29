var selectNO = 1;

function getBookByPre(name, no){
	selectNo = no;
	var json = {
			"preName":name
	};
	var data =JSON.stringify(json);
	var methodType = "POST";
	var url="../auxiliary/prebook";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType,url,data,contentType,successPreBook,null);
}

function successPreBook(data){
	if(data.booklist == null){
		if(selectNO == 1)
			jsRemoveAllFromSelect(book1);
		else
			jsRemoveAllFromSelect(book2);
		return;
	}
	if(selectNo == 1){
		jsRemoveAllFromSelect(book1);
		for(var i = 0; i < data.booklist.length; i++){
			jsAddItemToSelect(book1, data.booklist[i].simpleBook);
		}
	}else{
		jsRemoveAllFromSelect(book2);
		for(var i = 0; i < data.booklist.length; i++){
			jsAddItemToSelect(book2, data.booklist[i].simpleBook)
		}
	}
}

function jsRemoveAllFromSelect(objSelect){
	var length = objSelect.options.length - 1;
	for(var i = length; i >= 0; i--){
		objSelect.innerHTML = "";
	}
}

function jsAddItemToSelect(objSelect, objItemText, objItemValue) {        
    var varItem = new Option(objItemText, objItemValue);      
    objSelect.options.add(varItem);           
} 
//----
function initPreCompare(){
	var firstname = decodeURI(getUrlParam("prename"));
	$('#fjone:text').val(firstname);
	getBookByPre(firstname, 1);
	$('#medprecompare').live('click',function(){
		preCompare();
	});
}

function preCompare(){
	var option = document.getElementById("book1");
	var book1 = option.options[option.selectedIndex].text;
	
	option = document.getElementById("book2");
	var book2 = option.options[option.selectedIndex].text;
	
	 var json = 
		{
		    "preName1":$("#fjone").val(),
			"preSimpleBook1" : book1,
			"preName2":$("#fjtwo").val(),
			"preSimpleBook2" : book2
		};
		
		var data = JSON.stringify(json);
		var methodType = "POST";
		var url = "../auxiliary/preid";
		var contentType = "application/json;charset=utf-8";
		
	ajaxFunc(methodType,url,data,contentType,successPreId,null);
}

function successPreId(data){
	var preId1 = data.preId1;
	var preId2 = data.preId2;
	
	var json = {
			"preId1":preId1,
			"preId2":preId2
	}
	
	   var data = JSON.stringify(json);
	   var methodType = "POST";
	   var url = "../auxiliary/medcomchart";
	   var contentType = "application/json;charset=utf-8";
		    		
	   ajaxFunc(methodType,url,data,contentType,successMedComposeChart,null);
					
	   var url = "../auxiliary/precompreinfo";   		
	   ajaxFunc(methodType,url,data,contentType,successPreinfo,null);
					
	   var url = "../auxiliary/precomlist"; 		
	   ajaxFunc(methodType,url,data,contentType,successMedicineList,null);
}

function successMedComposeChart(data,textStatus, jqXHR){
	   
	pieChartData1=data.result1;
	pieChartData2=data.result2;
			   
	$('#pie_chart_1').attr("src","../auxiliary/medchartsubpage1");
    $('#pie_chart_2').attr("src","../auxiliary/medchartsubpage2");
			   
}
function successPreinfo(data,textStatus, jqXHR){
     
	 $("#descriptor").html("<b>"+data.preInfo1.preName+"和"+data.preInfo2.preName+"的对比情况如下</b>");
	 $("#pre_name1").html(data.preInfo1.preName);
	 $("#pre_book1").html(data.preInfo1.book);
	 $("#pre_function1").html(data.preInfo1.function);
	 $("#pre_com1").html(data.preInfo1.dosage);
	 
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
function drawPie1(){
	
	$('#pie_chart_1')[0].contentWindow.drawPieChart(pieChartData1);	
			   
}
function drawPie2(){
			  
	$('#pie_chart_2')[0].contentWindow.drawPieChart(pieChartData2);
}
