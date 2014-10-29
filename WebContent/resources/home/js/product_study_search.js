$(function(){
	show();
	
	$(".nav_a").click(function(){
		window.location.href="./prosturesearch?"+"type="+$(this).attr("type");
	});
});
function show(){
	var type=getUrlParam("type");
	var class_name = type + "_nav";
	$("."+class_name).find("a").eq(0).click();
}