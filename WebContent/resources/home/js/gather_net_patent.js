var net_base_url = 'http://10.214.55.215/deepsearch01/servlet/SearchServlet?action=search';
var patent_base_url = "http://10.214.55.215/deepsearch01/servlet/SearchServlet?action=search";
function initNetSubMenu(){
    var str = "";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='net_submenu_a' type='web'>网络搜索</a></div>";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='net_submenu_a' type='baike'>百科搜索</a></div>";
    
    $("#left_top").html(str);
    /*单位药*/
    $(".net_submenu_a").eq(0).click();
}
function getNetPagination(pageNumber){
    var url = net_base_url +"&q="+decodeURI(getUrlParam("query"))+"&pn="+pageNumber+"&psize=10"+"&searchType="+$(".net_submenu_a_selected").attr("type")+"&callback=?";
    $.getJSON(url,function(data){
        var str = "";
        $.each(data,function(i,item){
            var tmp = "";
            tmp += "<div class='net_item_title'>";
                tmp += "<a href='"+item.url+"' target='_blank'>"+item.title+"</a>";
            tmp += "</div>";
            tmp += "<div class='net_item'>";
                tmp += "<span class='net_item_abstract'>摘要：</span>"+((item.abstract=="")?"无":item.abstract);
            tmp += "</div>";
            
            tmp += "<div>";
                tmp += "<hr class='line_hr'/>";
            tmp += "</div>";
        
            str += tmp;
        });
        $("#right_reslut").html(str);
    });
}
/*专利*/
function initPatentInfo(){
    var url = patent_base_url +"&q="+decodeURI(getUrlParam("query"))+"&pn=1"+"&psize=10"+"&searchType=patent"+"&title="+decodeURI(getUrlParam("query"))+"&callback=?";
    $.getJSON(url,function(data){
        /*#left_top*/
        var str = "<div class='left_top_qa_div'>"+"<span class='left_top_qa_txt'>"+data[0].total+"</span>"+"条结果"+"</div>";
        $("#left_top").html(str);
        initPagination(data[0].total, getPatentPagination,10);
    });
    
}
function getPatentPagination(pageNumber){
    var url = patent_base_url +"&q="+decodeURI(getUrlParam("query"))+"&pn="+pageNumber+"&psize=10"+"&searchType=patent"+"&title="+decodeURI(getUrlParam("query"))+"&callback=?";
    var start = (pageNumber-1)*10;
    $.getJSON(url,function(data){
        var str = "<table class='patent_tb'>";
        str += "<tr>";
            str += "<td class='patent_item_tb_order'>";
                str+= "序号";
            str += "</td>";
                
            str += "<td class='patent_item_tb_name'>";
                str+= "专利名称";
            str += "</td>";
            
            str += "<td class='patent_item_tb_owner'>";
                str+= "申请人";
            str += "</td>";
            
            str += "<td class='patent_item_tb_abstract'>";
                str+= "摘要";
            str += "</td>";
            
            str += "<td class='patent_item_tb_scan'>";
                str+= "查看";
            str += "</td>";
        str += "</tr>";
        $.each(data,function(i,item){
            var tmp = "<tr>";
            
                tmp += "<td class='patent_tb_tr_order'>";
                    tmp += (start+i+1);
                tmp += "</td>";
                
                tmp += "<td class='patent_tb_tr_name'>";
                    tmp += item.name;
                tmp += "</td>";
                
                tmp += "<td class='patent_tb_tr_inventor'>";
                    var s = item.inventor;
                    tmp += s.replace(new RegExp(';', 'g'), '<br/>');
                tmp += "</td>";
                
                tmp += "<td class='patent_tb_tr_summary'>";
                    tmp += item.summary;
                tmp += "</td>";
                
                tmp += "<td class='patent_tb_tr_scan'>";
                    tmp += "<a href='http://202.107.204.54:8080/cnipr/' class='patent_more_a'>"+"查看"+"</a>";
                tmp += "</td>";
                
            tmp += "</tr>";
            str += tmp;
        });
        str += "</table>";
        $("#right_reslut").html(str);
    });
}