$(function(){
	$('#dropdown').hover(
		function () {
			//display the submenu
			$('#dropdown ul.children').show();
		},
		function () {			
			//hide the submenu
			$('#dropdown ul.children').hide();
		}
	
	);
});