$(function() {
	$("#search_btn").live(
			"click",
			function() {
				if (null == $("#search_input").val()
						|| "" == $("#search_input").val()
						|| "" == $.trim($("#search_input").val())) {
					$("#search_input_tip").html("请输入查询关键字");
					return false;
				}
				$("#search_input_tip").html("");
				var query = $.trim($("#search_input").val());
				window.location.href = "./gatherinfo?query=" + encodeURI(query);
			});
	$('#slides').slides({
		preload : true,
		preloadImage : './resources/exlib/slides/images/loading.gif',
		play : 3000,
		pause : 2500,
		hoverPause : true
	});

});