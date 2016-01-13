var pie;
var dataAll;
var pageNo=1;
var pageSize=10;
var pageIndex;

$(function(){
    $(".option").each(function(){
        $(this).click(function(){
            $(".option").each(function(){
                $(this)[0].checked=false;
            });
            $(this)[0].checked=true;
        });
    });
    
    $("#btn").click(
            function(){
                var keyword=$("#input").val();
                var type;
                type = getType();
                $.ajax({
                      type: 'POST',
                      url: "./"+type,
                      data: {
                          "wd":keyword
                      },
                      success: success,
                      error:error,
                      dataType:"text"
                    });
            });
    /*
    $(window).scroll(function(){
        if(dataAll){
            if($("#records").offset().top+$("#records").height()-window.pageYOffset-$(window).height()<100){
                pageNo+=1;
                data=dataAll[pageIndex];
                records=data.records;
                showRecords(records,pageNo,pageSize);
                
            }
        }
    });
    */
});

function getType(){
    if($("#bz_opt")[0].checked) type="bz";
    else if ($("#zz_opt")[0].checked) type="zz";
    else type="bz";
    return type;
}

function success(data,textStatus,jqXHR){
    
    dataAll=eval('(' + data + ')');
    console.log(dataAll);
    if (dataAll[0]["meds"]==0){
        $("#pieChart").empty();
        $(".container").empty();
        $(".alert").show();
        return 
    }
    else{
        $(".alert").hide();
    }
    var list="";
    for(var i=0;i<dataAll.length;i++){
        if(i==0) list+="<li class='active nav'><a id='"+i+"'>"+dataAll[i].word+"</a></li>";
        else list+="<li><a id='nav"+i+"' onclick='init("+i+")'>"+dataAll[i].word+"</a></li>";
    }
    console.log(list);
    $(".content").show();
    $("#nav").html(list);
    $("#nav li").each(function(){
        $(this).click(function(){
            $("#nav li").removeClass("active");
            $(this).addClass("active");
            generateLink();
        });
    });
     $("#nav li a").each(function(){
        var id = parseInt($(this).attr("id"));
        $(this).click(function(){
            init(id);
        });
    });

    init(0);

}

function error(){
    alert("error");
}

function showRecords(records,pageNo,pageSize){
    tbody="";
    for(var i=(pageNo-1)*pageSize;i<pageNo*pageSize;i++){
        tbody+="<tr><th>"+records[i].recordTitle+"</th><th>"+records[i].doctorName+"</th><th>"+records[i].reference+"</th></tr>";
    }
    $("#records_body").append(tbody);
}

function init(index){
    pageNo=1;
    pageIndex=index;
    $("#pieChart").empty();
    $("#records_body").empty();
    data=dataAll[index];
    console.log(index);
    var color = d3.scale.category20();
    var meds=data.meds;
    var records=data.records;
    var likelihood=data.likelihood;
    var medsTable="<table id='meds_table' class='table'><thead><tr><th>选择中药</th><th>中药名称</th>\
    </tr><tbody>";
    var pieData=new Array();
    var sum=0;
    for(var i=0;i<meds.length;i++){
        medsTable+="<tr><td><input type='checkbox' class='med_checkbox'/></td><td class='medicine'><a>"+meds[i]+"</a></td></tr>";
        sum+=likelihood[i];
        pieData.push({
            "label":meds[i],
            "value":likelihood[i],
            "color":color(i)
        });
    }
    medsTable+="</tbody>"
    pieData.push({
        "label":"其他",
        "value":1-sum,
        "color":color(meds.length)
    });
    $("#meds_info").html("相关中药");
    $("#meds").html(medsTable);
    $(".med_checkbox").click(function(){
        generateLink();
    });
    
    paintPie(pieData);
    generateLink();
    
    /*
    var recordsHead="<tr><th>医案名称</th><th>医生姓名</th><th>医案出处</th></tr>";
    $("#records_info").html("相关医案");
    $("#records_head").html(recordsHead);
    showRecords(records,pageNo,pageSize);
    */
}

function seachForRecord(){
    
}

function generateLink(){
    var keywordList=getKeywordList();
    console.log(keywordList);
    var keyword=keywordList.join("、")
    $("#search_link").html("查看<span style='color:red'>"+keyword+"</span>相关医案");
    $("#search_link").attr("href","../search/result?wd="+keyword+"&type=content");
    $("#search_link").attr("target","_blank");
}

function getKeywordList(){
    var keyword=[];
    $("#meds_table tbody tr").each(function(){
        var checkBoxCol=$(this).children('td')[0];
        var medNameCol=$(this).children('td')[1];
        if($(checkBoxCol).children()[0].checked){
            keyword.push($(medNameCol).text());
        }
    });
    
    keyword.push($(".nav .active a").text());
    return keyword;
}


function paintPie(data){
    var title = "";
    var type = getType();
    if (type == "bz") title = "辩证";
    else title = "治则";
 
    var name = $(".active a").text();
    pie = new d3pie("pieChart", {
        "header": {
            "title": {
                "text": title + "分析",
                "fontSize": 24,
                "font": "open sans"
            },
            "subtitle": {
                "text": title + name +"常用的药材",
                "color": "#999999",
                "fontSize": 12,
                "font": "open sans"
            },
            "titleSubtitlePadding": 9
        },
        "footer": {
            "color": "#725b5b",
            "fontSize": 10,
            "font": "open sans",
            "location": "bottom-left"
        },
        "size": {
            "canvasHeight":250,
            "canvasWidth": 250,
            "pieInnerRadius": "13%",
            "pieOuterRadius": "81%"
        },
        "data": {
            "content": data
        },
        "labels": {
            "outer": {
                "hideWhenLessThanPercentage": 1,
                "pieDistance": 32
            },
            "inner": {
                "hideWhenLessThanPercentage": 3
            },
            "mainLabel": {
                "fontSize": 11
            },
            "percentage": {
                "color": "#ffffff",
                "decimalPlaces": 0
            },
            "value": {
                "color": "#adadad",
                "fontSize": 11
            },
            "lines": {
                "enabled": true
            }
        },
        "effects": {
            "pullOutSegmentOnClick": {
                "effect": "linear",
                "speed": 400,
                "size": 8
            }
        },
        "misc": {
            "gradient": {
                "enabled": true,
                "percentage": 81,
                "color": "#ffffff"
            }
        }
    });
}