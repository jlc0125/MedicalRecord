/**
 * 获得总的记录数和时间
 * @param data
 */
function getJournalRecord(data){
    var totalNum = data.totalHits;
    
    var str = "";
    str += "<div>";
        str += "<div style='text-indent:20px;'>出版社杂志<span style='margin-left:25px;'><img src='./resources/paperanalysis/images/down.png'/></span><div>";
        str += "<div style='color:#000;font-size: 14px;'>";
            str += "<ul style:normal;>";
                str += "<li>";
                    str += "《中医药学报》";
                str += "</li>";
                str += "<li>";
	                str += "《天津中医药》";
	            str += "</li>";
	            str += "<li>";
	                str += "《河南中医》";
	            str += "</li>";
	            str += "<li>";
	                str += "《山西中医》";
	            str += "</li>";
	            
	            str += "<li>";
	                str += "《中成药》";
	            str += "</li>";
	            str += "<li>";
	                str += "《吉林中医药》";
	            str += "</li>";
	        str += "</ul>";
	    str += "</div>";
	    
	    str += "<div style='text-indent:20px;margin-top:15px;'>学科分类<span style='margin-left:25px;'><img src='./resources/paperanalysis/images/down.png'/></span><div>";
        str += "<div style='color:#000;font-size: 14px;'>";
            str += "<ul style:normal;>";
                str += "<li>";
                    str += "中医内科";
                str += "</li>";
                str += "<li>";
	                str += "其他分类";
	            str += "</li>";
	            str += "<li>";
	                str += "中药学";
	            str += "</li>";
	            str += "<li>";
	                str += "中医临床学";
	            str += "</li>";
	        str += "</ul>";
	    str += "</div>";
	    
	str += "</div>";
    
    $("#left_top").html(str);
    initPagination(totalNum,getJournalPagination,10);
}
/*分页展示*/
function getJournalPagination(pageNumber){
    var url = "./paper/paperanalysis/collectSearch?k="+decodeURI(getUrlParam("query"))+"&p="+pageNumber+"&pz=10&c=&pub=&y=";
    $.getJSON(url,function(data){
        var str = "";
        $.each(data.list,function(i,item){
            var tmp = "<div class='journal_result_item'>";
                tmp += "<table class='journal_result_item_table'>";
                    tmp += "<tr>";
                        tmp += "<td colspan='2' class='journal_title'>";
                            tmp += '<img class="image_style" src="'+getRootPath()+'/resources/paperanalysis/images/paper_icon.png">';
                            tmp += '<a href="./paper/paperanalysis/paperInfo.do?docId='+item.docId+'" target="_blank">'+item.title+'</a>';
                        tmp += "</td>";
                    tmp += "</tr>";
                    tmp += "<tr>";
                        tmp += "<td colspan='2' class='journal_publish_date'>";
                            tmp += item.publisher+"-"+item.publishDate;
                        tmp += "</td>";
                    tmp += "</tr>";
                    tmp += "<tr>";
                        tmp += "<td class='journal_author'>";
                            tmp += "作者";
                        tmp += "</td>";
                        tmp += "<td class='journal_author_list'>";
                            var list_author="";
                            $.each(item.authorList,function(i,e){
                                list_author += "<a href='"+e.personUrl+"'>"+e.nameCn+"</a>"+" ";
                            });
                            tmp += list_author;
                        tmp += "</td>";
                    tmp += "</tr>";
                    tmp += "<tr>";
                        tmp += "<td class='journal_abstract'>";
                            tmp += "摘要";
                        tmp += "</td>";
                        tmp += "<td class='journal_abstract_content'>";
                            tmp += item.abstracts;
                        tmp += "</td>";
                    tmp += "</tr>";
                    tmp += "<tr>";
                        tmp += "<td class='journal_key'>";
                            tmp += "关键词";
                        tmp += "</td>";
                        tmp += "<td class='journal_key_list'>";
                            var list_key="";
                            $.each(item.keyList,function(i,e){
                                list_key += e.key+" ";
                            });
                            tmp += list_key;
                        tmp += "</td>";
                    tmp += "</tr>";
                    tmp += "<tr>";
                        tmp += "<td colspan='2' class='journal_smart'>";
                            tmp += '<img class="label1" src="'+getRootPath()+'/resources/paperanalysis/images/Star_Button.png">';
                            tmp += '<a href="./paper/paperanalysis/paperInfo.do?docId='+item.docId+'" target="_blank">智能分析</a>';
                        tmp += "</td>";
                    tmp += "</tr>";
                tmp += "</table>";
            tmp += "</div>";
            
            str += tmp;
        });
        $("#right_reslut").html(str);
    });
}