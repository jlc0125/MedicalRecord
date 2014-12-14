
$(function(){
	$(".medicine").live("click",function(){
		var medName=$(this).text();
		window.location.href="http://zcy.ckcest.cn/tcm/search/med?medname="+medName;
	});
});


