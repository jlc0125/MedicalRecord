var no_data_url = "<img src='./resources/commonpages/images/no_data.png'/>";
var str="";
str += "<div>";
        str += "<div style='text-indent:20px;'>一级分类<span style='margin-left:25px;'><img src='./resources/paperanalysis/images/down.png'/></span><div>";
        str += "<div style='color:#000;font-size: 14px;'>";
            str += "<ul style:normal;>";
                str += "<li>";
                    str += "医药、卫生";
                str += "</li>";
                str += "<li>";
                    str += "农业科学";
                str += "</li>";
                str += "<li>";
                    str += "数理化";
                str += "</li>";
                str += "<li>";
                    str += "生物科学";
                str += "</li>";
                
                str += "<li>";
                    str += "综合性图书";
                str += "</li>";
            str += "</ul>";
        str += "</div>";
        
        str += "<div style='text-indent:20px;margin-top:15px;'>年份<span style='margin-left:25px;'><img src='./resources/paperanalysis/images/down.png'/></span><div>";
        str += "<div style='color:#000;font-size: 14px;'>";
            str += "<ul style:normal;>";
                str += "<li>";
                    str += "2005";
                str += "</li>";
                str += "<li>";
                    str += "2004";
                str += "</li>";
                str += "<li>";
                    str += "2003";
                str += "</li>";
                str += "<li>";
                    str += "2002";
                str += "</li>";
            str += "</ul>";
        str += "</div>";
        
    str += "</div>";

function initBookInfo(){
    $("#left_top").html(str);
    var url = "./gatherinfo/book?keyword="+decodeURI(getUrlParam("query"))+"&index="+1;
    $.getJSON(url,function(data){
        initPagination(data.count,getBookPagination,5);
    });
}
function getBookPagination(pageNum){
    var url = "./gatherinfo/book?keyword="+decodeURI(getUrlParam("query"))+"&index="+pageNum;
    
    $.getJSON(url,function(data){
        if(data.count==0){
             $("#right_reslut").html(no_data_url);
                $("#simple_pagination").pagination('destroy');
                return;
        }
        var content = "";
        $.each(data.bookList,function(i,item){
             var tmp = "";
                tmp += "<div class='book_result_item'>";
                    tmp += "<div class='book_result_item_left'>";
                        tmp += "<img src='"+item.cover+"' width='94' height='133'/>";
                    tmp += "</div>";
                    tmp += "<div class='book_result_item_right'>";
                        tmp += "<div style='width:100%;'>"+"<a href='"+item.Url+"' target='_blank'>"+item.Title+"</a>"+"</div>";
                        tmp += "<div style='width:100%;margin-top:10px;'>"+"作者: "+item.Creator+"&nbsp;&nbsp;&nbsp;出版日期: "+item.CreateDate+"&nbsp;&nbsp;&nbsp;出版社："+item.Publisher+"</div>";
                        tmp += "<div style='width:100%;margin-top:10px;'>"+"图书主题: "+((undefined==item.Subject)?"无":item.Subject)+"</div>";
                    tmp += "</div>";
                tmp += "</div>";
                
            content += tmp;
        });
        $("#right_reslut").html(content);
    });
}
