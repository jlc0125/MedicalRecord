(function($){
	$(function(){
        
		$('body').on('click','#login_header',function(){
        	window.location.href = location.origin+'/MedicalRecord/user/loginpage'+'?prehref='+location.href; 
    	});
    
    	$('body').on('click','#logout_header',function(){
    		var url = location.origin+'/MedicalRecord/user/logout'+'?prehref='+location.href;
			window.location.href=url;
			window.event.returnValue = false;
    	});
        $('body').on('click','#regist_header',function(){
            window.location = location.origin+'/MedicalRecord/user/registpage'+'?prehref='+location.href; 
        });
	});
}(jQuery));
	