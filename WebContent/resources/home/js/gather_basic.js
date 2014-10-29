/**
 * basic knowledge part 
 */
var no_data_url = "<img src='./resources/commonpages/images/no_data.png'/>";

function initBasicSubMenu(){
    var str = "";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='submenu_a' type='med' col_name='功效'>单味药</a></div>";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='submenu_a' type='chem' col_name='cas号'>化合物</a></div>";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='submenu_a' type='ori' col_name='科属'>药用动植物</a></div>";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='submenu_a' type='pre' col_name='方剂出处'>方剂</a></div>";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='submenu_a' type='dis' col_name='疾病种类'>疾病</a></div>";
    str += "<div class='basic_left_top_submenu'><a href='javascript:void(0);' class='submenu_a' type='syn' col_name='证候类型'>证候</a></div>";
    
    $("#left_top").html(str);
    /*单位药*/
    $(".submenu_a").eq(0).click();
    
}

function getBasicKnowledgeInfoCB(data, textStatus, jqXHR)
{
    if(undefined == data || null== data || 0 == data.count)
    {
        $("#right_reslut").html(no_data_url);
        $("#simple_pagination").pagination('destroy');
        return;
    }
    initPagination(data.count,getBasicPagination,10);
}

function getBasicPagination(pageNumber){
    var type = $(".submenu_a_selected").text();
    var dataJson =
    {
           "keyword":decodeURI(getUrlParam("query")),
           "type":type,
           "pageno":pageNumber,
           "pagesize":10
    };
    var url = "./search/homefrontresultlist";
    var methodType = "POST";
    
    var contentType = "application/json;charset=utf-8";
    
    ajaxFunc(methodType,url,JSON.stringify(dataJson),contentType,getBasicPaginationCB,null);
}
function getBasicPaginationCB(data, textStatus, jqXHR){
    if(undefined == data || null==data || 0== data.count)
    {
        $("#right_reslut").html(no_data_url);
        $("#simple_pagination").pagination('destroy');
        return;
    }
    /*#right_reslut*/
    var str = "";
    var type = $(".submenu_a_selected").attr("type");
    
    var table_menu = "";
    table_menu += "<div>";
	    table_menu += "<table>";
	       table_menu += "<tr>";
	           table_menu += "<td class='name_td' style='font-weight:bold;font-size:18px;color:#000;'>";
	               table_menu += "中文名";
	           table_menu += "</td>";
	           table_menu += "<td class='intro_td' style='font-weight:bold;font-size:18px;text-indent:30px;'>";
	               table_menu += $(".submenu_a_selected").attr("col_name");
	           table_menu += "</td>";
	           table_menu += "<td class='img_td' style='font-weight:bold;font-size:18px;'>";
	               table_menu += "预览";
	           table_menu += "</td>";
	       table_menu += "</tr>";
	    table_menu += "</table>";
    table_menu += "</div>";
    
    str += table_menu;
    
    $.each(data.list,function(i,item){
        var tmp = "";
        tmp += "<div class='basic_result_item'>";
            tmp += "<table class='item_table'>";
                tmp += "<tr>";
                    tmp += "<td class='name_td'>";
                        var href;
                        if("pre"==type)
                            href="./search/"+type+"?"+type+"name="+item.field1+"&prebook="+item.field2;
                        else
                            href="./search/"+type+"?"+type+"name="+item.field1;
                        tmp += "<a href='"+href+"' target='_blank'>"+item.field1+"</a>";
                    tmp += "</td>";
                    tmp += "<td class='intro_td'>";
                        if("pre"==type)
                            tmp += item.field3;
                        else
                        {
                            if(undefined == item.field2 || null == item.field2)
                                tmp+="暂无信息";
                            else
                                tmp += item.field2;
                        }
                    tmp += "</td>";
                    tmp += "<td class='img_td'>";
                        var src = basic_img__root +type+"/"+ item.field4+".jpg";
                        tmp += "<img src='"+src+"' style='width:150px;height:110px;'/>";
                    tmp += "</td>";
                tmp += "</tr>";
            tmp += "</table>";
        tmp += "</div>";
        
        tmp += "<div>";
            tmp += "<hr class='line_hr'/>";
        tmp += "</div>";
        
        str+=tmp;
    });
    $("#right_reslut").html(str);
    removePicNotFound(getRootPath()+"/resources/home/Images/no_pic.png");
    
}