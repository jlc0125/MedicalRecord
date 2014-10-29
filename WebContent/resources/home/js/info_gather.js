var resultNum = -1;
var qa_get_number_url="http://10.15.62.205/search/?t=questionsNum&q=";
var qa_get_tags_list_url = "http://10.15.62.205/search/?t=relatedTags&q=";
var qa_pagination_url = "http://10.15.62.205/search/?t=questionsContent";
var basic_img__root = "http://10.15.62.32:8888/tcmpro/pictures/search/";
$(function() {    
    /*init input*/
    $("#search_input").val(decodeURI(getUrlParam("query")));
    
     /*收缩面板*/
    $(".btn-slide").live("click",function(){
        $("#panel").slideToggle("slow");
        $(this).toggleClass("active");
        return false;
    });
    
    $("#search_btn").live("click",function(){
    	if (null == $("#search_input").val()
                || "" == $("#search_input").val()
                || "" == $.trim($("#search_input").val())) {
            $("#search_input_tip").html("请输入查询关键字");
            return false;
        }
        $("#search_input_tip").html("");
        var query = $("#search_input").val();
        window.location.href="./gatherinfo?query="+encodeURI(query);
    });
    /*menu 超链接格式*/
    $(".menu_li_a").live("click",function(){
        $(".menu_li_a").css("font-weight","normal");
        $(".menu_div").css("background","#f5f2f1");
        $(this).css("font-weight","bold");
        $(this).parents().find("div").eq(0).css("background","#fff");
    });
    
    /*basic 二级选项*/
    $(".submenu_a").live("click",function(){
        $(".submenu_a").removeClass("submenu_a_selected");
        $(this).addClass("submenu_a_selected");
        
        var type = $(this).text();
        var dataJson =
        {
               "keyword":decodeURI(getUrlParam("query")),
               "type":type,
               "pageno":1,
               "pagesize":10
        };
        var url = "./search/homefrontresultlist";
        var methodType = "POST";
        
        var contentType = "application/json;charset=utf-8";
        ajaxFunc(methodType,url,JSON.stringify(dataJson),contentType,getBasicKnowledgeInfoCB,null);
       
    });
    
    /*基本信息*/
    $("#basic_knowledge_a").live("click",function(){
        initBasicSubMenu();
    });
    
    /*问答*/
    $("#qaos_a").live("click",function(){
        getQARecord();
    });
    
    /*期刊*/
    $("#journal_a").live("click",function(){
        var url = "./paper/paperanalysis/collectSearch?k="+decodeURI(getUrlParam("query"))+"&p=1&pz=10&c=&pub=&y=";
        $.getJSON(url,function(data){
            getJournalRecord(data);
        });
        
    });
    /*网络搜索*/
    $(".net_submenu_a").live("click",function(){
        $(".net_submenu_a").removeClass("net_submenu_a_selected");
        $(this).addClass("net_submenu_a_selected");
        
        initPagination(400, getNetPagination,10);
     
       
    });
    
    /*网络*/
    $("#net_a").live("click",function(){
    	initNetSubMenu();
    });
    
    /*专利*/
    $("#patent_a").live("click",function(){
    	initPatentInfo();
    });
    
    /*书籍*/
    $("#book_a").live("click",function(){
    	initBookInfo();
    });
    
    /*展开面板*/
    $(".btn-slide").click();
    
    /*显示基本信息的单味药*/
    $("#basic_knowledge_a").click();
});

/**
 * 初始化翻页;
 * 多模块共用;
 * @param totalNum
 *     the number of record
 * @param functionName
 *    function to send ajax equest
 */
function initPagination(totalNum,functionName,number)
{
    $("#simple_pagination").pagination({
        items:totalNum,
        itemsOnPage: number,
        cssStyle: 'light-theme',
        hrefTextPrefix:'#',
        onPageClick:function(pageNumber, event){
            functionName(pageNumber);
        },
        prevText:"上一页",
        nextText:"下一页",
        onInit:function(){
            /*第一页*/
            functionName(1);
        }
    });
}

