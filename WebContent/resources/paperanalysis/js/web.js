// JavaScript Document
$(function() {
	$("a").focus(function() {
		$(this).blur();
	})
	$(".bookImg .book, .bookImg .bookNoDelay").hover( 
                function () { 
                    $(this).addClass("linkHover");
                }, 
                function () { 
                    $(this).removeClass("linkHover");
                }
            )
})
//fixed固定导航条
$(document).ready(function(){
 var topMain=$(".logoSearch").height() + $(".top_banner").height()
 var nav=$(".nav");
 $(window).scroll(function(){
  if ($(window).scrollTop()>topMain){
   nav.addClass("nav_fixed");
  }else{
   nav.removeClass("nav_fixed");
  }
 });
 
})
//延迟加载图片
$(function() {
	$(".book img").lazyload({
		effect: "fadeIn",
		placeholder: getRootPath()+"/images/loading.gif"
	});
});
//搜索框样式
 jQuery(document).ready(function () {
        $(".search input.text")
        .blur(function () {
            $(this).css({'background-color':'#ffffff','color':'#e0808e'});
        })
        .keydown(function () {
            $(this).css({'background-color':'#fff','color':'#333'});
        })
        .focus(function () {
            $(this).css({'background-color':'#fff','color':'#333'});
            $(this).val("").css({'background-color':'#fff','color':'#333'});
        });
        $(document).focus();
    });
//下拉    
$(document).ready(function() {
	$(".toggleMenu_btn a").click(function() {
		$(".toggleMenu_main").slideToggle("fast");
		$(this).toggleClass("active");
		return false;
	});
});

//自动tab
$(document).ready(function(){ 
	var o=0;
	var timeInterval=15000;
	var $cont=$(".tabContent .layout");
	var $title=$(".tabUl li");
		
	$cont.hide();
	$($cont[0]).show();
	function auto(){
		o<$cont.length-1?o++:o=0;
		$cont.eq(o).fadeIn("slow").siblings().hide(); 
		$title.eq(o).addClass("current").siblings().removeClass("current");   
	}
	set = window.setInterval(auto,timeInterval);
	$title.mouseover(function(){
			window.clearInterval(set);
			o=$(this).index();
			$cont.eq(o).fadeIn("slow").siblings().hide(); 
			$title.eq(o).addClass("current").siblings().removeClass("current"); 
			set = window.setInterval(auto,timeInterval);  
		});   
 
})
var ids ="";
//排名
$(document).ready(function () {
            $(".rank_list li").hover(
            function () {
                $($(this).children()[0]).css("display", "none");
                $($(this).children()[1]).css("display", "");
                setOtherHid($(this));
            },
            function () {
            }
            );
        });

function setOtherHid(obj) {
    $(obj).parent().find("li").each(function () {
        if (obj[0] != $(this)[0] && $($(this).children()[1]).css("display") != "none") {
            $($(this).children()[1]).css("display", "none");
            $($(this).children()[0]).css("display", "");
        }
    });
}
//展开收缩文字		
$(function(){
	$(".commentMain").each(function(){
		var $targetEle = $(this).find(".commentMain_text"); 
		var $btnCtrl = $(this).find(".hitMore"); 
		var strAll = $targetEle.text();		
		if (strAll.length >300)
		{
			var sonStr = strAll.substr(0,300);
			$targetEle.text(sonStr)
			$btnCtrl.click(function(){
				if ($btnCtrl.text().substr(0,5)=="展开")
				{
					$targetEle.text(strAll);
					$btnCtrl.text("收起");
				}
				else{
					$targetEle.text(sonStr)
					$btnCtrl.text("展开");
				}			
			});
		}
		else{$btnCtrl.text("")}		
	});
 });




//下拉
var timeout         = 0;
var closetimer		= 0;
var ddmenuitem      = 0;

function jsddm_open()
{	jsddm_canceltimer();
	jsddm_close();
	ddmenuitem = $(this).find('.ulL2').eq(0).css('visibility', 'visible'),
	$(this).find('a.liA1').css({'background-color':'#292929','background-position':'112px -822px'}),
	$(this).find('a.liA2').css({'background-color':'#292929','background-position':'76px -822px'})
	;}

function jsddm_close()
{	if(ddmenuitem) ddmenuitem.css('visibility', 'hidden')
    
;}

function jsddm_timer()
{	closetimer = window.setTimeout(jsddm_close, timeout),
    $(this).find('a.liA1').css({'background-color':'#3c3c3c','background-position':'112px -779px'}),
    $(this).find('a.liA2').css({'background-color':'#3c3c3c','background-position':'76px -779px'})
    ;}

function jsddm_canceltimer()
{	if(closetimer)
	{	window.clearTimeout(closetimer);
		closetimer = null;}}

$(document).ready(function()
{	$('.ulL1 .liL1').bind('mouseover', jsddm_open);
	$('.ulL1 .liL1').bind('mouseout',  jsddm_timer);});

document.onclick = jsddm_close;
  jQuery(document).ready(function () {
        $("#Sameleft").height( Math.max($("#Sameleft").height(),$("#Sameright").height()));
        $("#Sameright").height($("#Sameleft").height());
    });


