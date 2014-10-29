/**
 * 获取QA统计数目
 */
function getQARecord()
{
    var query = getUrlParam("query");
    var url = qa_get_number_url+query+"&callback=?";
    $.getJSON(url,function(data){
        getQARecordCB(data);
    });
}
/**
 * 获取QA统计数目 CallBack
 * @param data
 * @param status
 * @param xhr
 */
function getQARecordCB(data)
{
    /*#left_top*/
    var str = "<div class='left_top_qa_div'>"+"<span class='left_top_qa_txt'>"+data.questionNum+"</span>"+"个问题"+"</div>";
    str += "<div class='left_top_qa_div'>"+"<span class='left_top_qa_txt'>"+data.answerNum+"</span>"+"个回答"+"<hr class='line_hr'/>"+"</div>";
    /*相关标签*/
    str += "<div style='margin-top:40px;'>+ 相关标签</div>";
    str += "<div ><hr class='line_hr'/></div>";
    $("#left_top").html(str);
    
    var query = getUrlParam("query");
    var url = qa_get_tags_list_url+query+"&callback=?";
    $.getJSON(url,function(result){
        var listStr = '<ul class="part_list table_info">';
        $.each(result.relatedTags,function(i,item){
            listStr += '<li><a href="javascript:void(0);">'+item+'</a></li><br/>';
        });
        listStr += "</ul>";
        
        $("#left_top").append(listStr);
    });
    
    
    /*分页插件初始化*/
    initPagination(data.questionNum,qaPagination,10);
}
/**
 * 获得第pageNumber页的数据
 * @param pageNumber
 */
function qaPagination(pageNumber){
    var query = getUrlParam("query");
    var url = qa_pagination_url+"&q="+query+"&page="+pageNumber+"&limit="+10+"&callback=?";
    $.getJSON(url,function(data){
        /*#right_reslut*/
        $("#right_reslut").html("");
        $.each(data.questionsContent,function(i,item){
            var tags="";
            $.each(item.tagsList,function(j,item2){
                tags+='<a href="javascript:void(0);">'+item2+'</a>&nbsp;';
            });
            var itemStr = '<table>'
                        +      '<tbody>'
                        +          '<tr>'
                        +              '<td rowspan="2" class="table_AQdetail title"><b><a href="'+item.url+'" target="_blank">'+item.title+'</a></b>'
                        +                  '<ul>'
                        +                      '<li>'
                        +                           tags
                        +                       '</li>'
                        +                   '</ul>'
                        +              '</td>'
                        +              '<td>'                                                                                 
                            +              '<ul class="table_AQ_label">'
                            +                     '<li>'
                            +                           '<a href="javascript:void(0);"><span>'+item.hottestCount+'</span><span>最热</span></a>&nbsp;'
                            +                           '<a href="javascript:void(0);"><span>'+item.answerCount+'</span><span>回答</span></a>&nbsp;'
                            +                           '<a href="javascript:void(0);"><span>'+item.viewCount+'</span><span>浏览</span></a>&nbsp;'
                            +                     '</li>'
                            +               '</ul>'
                        +               '</td>'
                        +          '</tr>'
                        +          '<tr>'
                        +               '<th class="table_user table_Timetitle"><span>'+item.lastAcitivityTime+'</span>&nbsp;<a href="javascript:void(0);">'+item.author+'</a></th>'
                        +          '</tr>'
                        +      '</tbody>'
                        +'</table>';
            itemStr += "<hr class='line_hr'/>";
            $("#right_reslut").append(itemStr);
        });
    });
}
