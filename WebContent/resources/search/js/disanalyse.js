var medlist="";
var preMedList="";
var currentMedList="";
var distinctMedCount=0;

var kind="";

function initDisAna(){
	showPreList();
}

function showPreList(){
   
     var disease = decodeURI(getUrlParam("disname"));
     var json = 
     {
	   "disName":disease
     };
     var data = JSON.stringify(json);
     var methodType = "POST";
	 var url = "../auxiliary/disprelist";
	 var contentType = "application/json;charset=utf-8";
		    		
	ajaxFunc(methodType,url,data,contentType,successPreList,null);
	$("#descriptor").html(disease);
    $("#result").show();
	$("#ana_result").hide();
}
function successPreList(data){
   	medlist="";
	preMedList="";
	distinctMedCount=data.distinctMedCount;
	for(var i=0;i<data.resultlist.length;i++){
			for(var j=0;j<data.resultlist[i].medlist.length;j++){
					medlist+=data.resultlist[i].medlist[j].medName+",";
					preMedList+=data.resultlist[i].medlist[j].medName+",";
			}
			preMedList+=" ";
     }
	
	var result="";
	for(var i=0;i<data.resultlist.length;i++){
		/*如需返回基础搜索页面的链接必须提供preBook*/
	   result+="<div class=\"result_table_content\">";
	   result+="<span id=\"c_name\">"+data.resultlist[i].preName+"</span>";
	   result+="<span class=\"shu\">&nbsp;</span>";
	   result+="<span id=\"c_fun1\">"+data.resultlist[i].preFunction+"</span>";
	   result+="<span class=\"shu\">&nbsp;</span>";
	   result+="<span id=\"c_fun2\">";
	   
	   for(var j=0;j<data.resultlist[i].medlist.length;j++){
			        
				result+=data.resultlist[i].medlist[j].medName+" ";
				
				result+=data.resultlist[i].medlist[j].dosage+data.resultlist[i].medlist[j].unit+";";
	  }
	  result+="</span >";
	  result+="</div>";
	  result+="<div class=\"underline_down\"></div>";
	}
    $("#search_result").html(result);
			   
}
function showAnalysis(){
  
  
  $("#tab1").addClass("ypfx");
  $("#tab1").removeClass("ypfx_off");
  
  $("#tab2").removeClass("pdfx");
  $("#tab3").removeClass("hhwfx");
  $("#tab4").removeClass("gxfx");
  
   $("#tab2").addClass("pdfx_off");
  $("#tab3").addClass("hhwfx_off");
  $("#tab4").addClass("gxfx_off");
  
  $("#ana_result").show();
  
  var number=0;
  
  var temp = document.getElementsByName("select_kind");
  for(var i=0;i<temp.length;i++){
		     if(temp[i].checked){
			 
			    number=temp[i].value;
			   }
  }
  var temp1 = document.getElementsByName("graph_kind");
		  for(var i=0;i<temp1.length;i++){
		     if(temp1[i].checked){
			   
			   kind=temp1[i].value;
			  }
  }
  if(kind=="histo"||kind=="pie"){
     switch(parseInt(number)){
	     case 1 : {
			      var fore=parseInt(document.getElementById("fore").value);
				  if(!isNaN(fore)&&fore<=distinctMedCount){
				      showMedFreq(0,fore);
				  }
				  else
				  alert("输入的不是数字或超过范围，请重新输入！");
			      break;
		}
		case 2 : {
		         var post=parseInt(document.getElementById("behind").value);
				  if(!isNaN(post)&&post<=distinctMedCount){
				    showMedFreq(distinctMedCount-post,distinctMedCount);
				  }
				  else
				  alert("输入的不是数字或超过范围，请重新输入！");
			      break;
		}
		case 3 : {
			      var fore=parseInt(document.getElementById("from").value);
				  var post=parseInt(document.getElementById("to").value);
				  if(!isNaN(fore)&&!isNaN(post)&&fore>0&&post<=distinctMedCount){
				     showMedFreq(fore-1,post);
				  }
				   else
				  alert("输入的不是数字或超过范围，请重新输入！");
			      break;
		}
		default : 
			   break;
	 }
  }
		  
  
}
function showMedFreq(fore,post){

	    var json = 
		{
		    	"medlist":medlist.substring(0,medlist.length-1),
				"from":fore,
				"to": post
		};
		    		
		var data = JSON.stringify(json);
		var methodType = "POST";
		var url = "../auxiliary/dispremedfreqfrom";
		var contentType = "application/json;charset=utf-8";
		    		
		ajaxFunc(methodType,url,data,contentType,successMedFreq,null);
}
function showMedMatch(){
       
	   $("#tab2").addClass("pdfx");
	   $("#tab2").removeClass("pdfx_off");
	   
       $("#tab1").removeClass("ypfx");
       $("#tab3").removeClass("hhwfx");
       $("#tab4").removeClass("gxfx");
	   
	   $("#tab1").addClass("ypfx_off");
       $("#tab3").addClass("hhwfx_off");
       $("#tab4").addClass("gxfx_off");
	   	    					
	   var json = 
	   {
		    "prelist":preMedList.substring(0,preMedList.length-1),
			"currentMedList":currentMedList.substring(0,currentMedList.length-1)
	   };
		    		
	  var data = JSON.stringify(json);
	  var methodType = "POST";
	  var url = "../auxiliary/dispremedmatch";
	  var contentType = "application/json;charset=utf-8";
		    		
	  ajaxFunc(methodType,url,data,contentType,successMedMatch,null);
}
function showChemFreq(){

        $("#tab3").removeClass("hhwfx_off");
        $("#tab3").addClass("hhwfx");
		
        $("#tab1").removeClass("ypfx");
        $("#tab2").removeClass("pdfx");
        $("#tab4").removeClass("gxfx");
		
		$("#tab1").addClass("ypfx_off");
        $("#tab2").addClass("pdfx_off");
        $("#tab4").addClass("gxfx_off");
		
		var json = 
		{
			"currentMedList":currentMedList.substring(0,currentMedList.length-1)
		};
		    		
		var data = JSON.stringify(json);
		var methodType = "POST";
		var url = "../auxiliary/disprechemlist";
		var contentType = "application/json;charset=utf-8";
		    		
		ajaxFunc(methodType,url,data,contentType,successChemFreq,null);
}
function successMedFreq(data,textStatus, jqXHR){

			  currentMedList="";
			  var medNameList=new Array();
			  var medCountList=new Array();
			  for(var i=0;i<data.resultlist.length;i++){
				 currentMedList+=data.resultlist[i].medName+",";
				 
				 medNameList.push(data.resultlist[i].medName);
				 medCountList.push(data.resultlist[i].count);
			  }
			
		   $("#med_match").hide();
		   $("#med_function").hide();
           $('#container2').hide();
		   $('#container1').show();
			 if(kind=="histo"){
			   
			    BarGraph(medNameList,medCountList,1);
			    
			 }
			 else if(kind="pie"){
			 
			    PieGraph(medNameList,medCountList,1);
			 }
			
}
function successMedMatch(data){
 
  $('#container1').hide();
  $('#container2').hide();
  $('#med_function').hide();
  $("#med_match").show();
  $("#med_match_graph").attr("src","../auxiliary/medmatchgraph?xmlString="+data.resultXML);
}
function successChemFreq(data){

           var chemNameList=new Array();
		   var chemCountList= new Array();
           for(var i=0;i<data.chemlist.length;i++){	  
				  chemNameList.push(data.chemlist[i].chemName);
				  
				  chemCountList.push(data.chemlist[i].count);
           }
		   $('#container1').hide();
		   $("#med_match").hide();
		   $("#med_function").hide();
           $('#container2').show();
		   
		   if(kind=="histo"){
			   
			    BarGraph(chemNameList,chemCountList,2);
			    
			 }
			 else if(kind="pie"){
			 
			    PieGraph(chemNameList,chemCountList,2);
			 }
		   
			
}
function BarGraph(NameList,CountList,num){
        var text="";
        if(num==1) 
		   text="药频分析";
		else if(num==2)
		   text="化合物分析";
		   
        $('#container'+num).highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: text
            },
            subtitle: {
                text: '来源: 中草药药方病症分析系统'
            },
            xAxis: {
                categories: NameList,
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: '频次（次）',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: ' 次'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -40,
                y: 200,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                name: '频次',
                data: CountList
            }]
           });
   
}
function PieGraph(NameList,CountList,num){
       var text="";
        if(num==1) 
		   text="药频分析";
		else if(num==2)
		   text="化合物分析";
		   
		var data =new Array();
		
		for(var i=0;i<NameList.length;i++){
		   data[i]=new Array();
		   data[i].push(NameList[i],CountList[i]);
		}
 
        $('#container'+num).highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: text
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                type: 'pie',
                name: '比例',
                data: data
            }]
        });
    

}
function showMedFunction(){
      
	 $("#tab4").removeClass("gxfx_off");
     $("#tab4").addClass("gxfx");
		
     $("#tab1").removeClass("ypfx");
     $("#tab2").removeClass("pdfx");
     $("#tab3").removeClass("hhwfx");
		
	 $("#tab1").addClass("ypfx_off");
     $("#tab2").addClass("pdfx_off");
     $("#tab3").addClass("hhwfx_off");
		
     $('#container1').hide();
      $('#container2').hide();
  
      $("#med_match").hide();
  
        var json = 
		{
			"currentMedList":currentMedList.substring(0,currentMedList.length-1)
		};
		    		
		var data = JSON.stringify(json);
		var methodType = "POST";
		var url = "../auxiliary/dispremedfun";
		var contentType = "application/json;charset=utf-8";
		    		
		ajaxFunc(methodType,url,data,contentType,successMedFun,null);
        $('#med_function').show();
}
function successMedFun(data){
 
 var str="<table  border = \"1\" style=\"text-align:center; ;\"><th style=\"width:100px\"><center>药名</center></th >"+"<th><center>功效</center></th>" +"<th style=\"width:100px\"><center>归类</center></th><tr/>";
// "<th style=\"text-align:center; \">功效</th>"+

 for(var i=0;i<data.medlist.length;i++){
 
    var medName=data.medlist[i].name;
	var medfunction = data.medlist[i].medfunction;
	var classify= data.medlist[i].classify;

	str+="<td style=\"text-align:center;width:100px; \">"+medName+"</td>"+"<td style=\"text-align:center; \">"+medfunction+"</td>"+"<td style=\"text-align:center; width:100px;\">"+classify+"</td><tr/>";
	//"<td style=\"text-align:center; \">"+medfunction+"</td>"+
 
 }
 str+="</table>";
 
  $('#med_function').html(str);
}