function tagscloud(selectStr){
    var element = $(selectStr + ' a');
	var offset1 = 0, offset2 = 5; 
    var radiusX = 10, radiusY = 15;
    var fontSize = 10;
	var stepping = 0.02;
	var list = $(selectStr);
	list.mousemove(function(e){
		var topOfList = list.eq(0).offset().top
		var listHeight = list.height();
        if((e.pageY - topOfList) * 2 >= listHeight)
            stepping = 0.02;
        else
            stepping = -0.02;
	});
	
    var num = element.length / 4;
    var angleStep = Math.PI * 2 / num;
	for (var i = 0; i < num; i++){
		element[i].elemAngle = i * angleStep;
        element[i+num].elemAngle = element[i].elemAngle;
        element[i+num*2].elemAngle = element[i].elemAngle;
        element[i+num*3].elemAngle = element[i].elemAngle;
	}
	
	var id = setInterval(render, 20);
    var color;
    
    element.mouseover(function(){
        clearInterval(id);
        color = $(this).css("color");
        $(this).css("color", "rgb(230, 28, 100)");
    })
    .mouseout(function(){
        id = setInterval(render, 20);
        $(this).css("color", color);
    })
    .click(function(){
    			var value = $(this).text();
    			$("#front_input").val(value);
    			d3.json("recipe/search?q=" + value, function(error, root) { 
    				$(".graph svg").remove();
    				graph("#component .graph", root.component);
    				graph("#attending .graph", root.attending);
    				graph("#similar .graph", root.similar);		
    				});
    	return false;
    });
	
	function render(){
		for (var i = 0; i < num; i++){
			var angle = element[i].elemAngle + offset1,
			x = 35 + Math.sin(angle) * radiusX,
			y = 25 + Math.cos(angle) * radiusY,
			size = Math.round(fontSize - Math.sin(angle) * fontSize),
			elementCenter = $(element[i]).width() / 2,
			leftValue = ((list.width()/2) * x / 100 - elementCenter) + "px";
			
			$(element[i]).css("fontSize", size + "pt")
			.css("opacity",size/100 + 0.6)
			.css("zIndex" ,size)
			.css("left" ,leftValue)
			.css("top", y + "%")
			.css("color", "rgb(123, 152, 167)");
            
			angle = element[i+num].elemAngle + offset2;
			x = 80 + Math.sin(angle) * radiusX;
			y = 25 + Math.cos(angle) * radiusY;
			size = Math.round(fontSize - Math.sin(angle) * fontSize);
			elementCenter = $(element[i+num]).width() / 2;
			leftValue = ((list.width()/2) * x / 100 - elementCenter) + "px";
			
			$(element[i+num]).css("fontSize", size + "pt")
			.css("opacity",size/100+ 0.6)
			.css("zIndex" ,size)
			.css("left" ,leftValue)
			.css("top", y + "%")
			.css("color", "rgb(191, 213, 220)");
            
			angle = element[i+num].elemAngle + offset2;
			x = 120 + Math.sin(angle) * radiusX;
			y = 25 + Math.cos(angle) * radiusY;
			size = Math.round(fontSize - Math.sin(angle) * fontSize);
			elementCenter = $(element[i+num]).width() / 2;
			leftValue = ((list.width()/2) * x / 100 - elementCenter) + "px";
			
			$(element[i+num*2]).css("fontSize", size + "pt")
			.css("opacity",size/100+ 0.6)
			.css("zIndex" ,size)
			.css("left" ,leftValue)
			.css("top", y + "%")
			.css("color", "rgb(156, 186, 178)");
            
			angle = element[i+num].elemAngle + offset1;
			x = 160 + Math.sin(angle) * radiusX;
			y = 25 + Math.cos(angle) * radiusY;
			size = Math.round(fontSize - Math.sin(angle) * fontSize);
			elementCenter = $(element[i+num]).width() / 2;
			leftValue = ((list.width()/2) * x / 100 - elementCenter) + "px";
			
			$(element[i+num*3]).css("fontSize", size + "pt")
			.css("opacity",size/100+ 0.6)
			.css("zIndex" ,size)
			.css("left" ,leftValue)
			.css("top", y + "%")
			.css("color", "rgb(78, 92, 120)");

		}
		offset1 += stepping;
		offset2 += stepping;
	}
}