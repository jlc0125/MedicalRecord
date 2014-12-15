function tagscloud(selectStr, tagStr){
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
	
    var num = Math.ceil(element.length / 4);
    var angleStep = Math.PI * 2 / num;
	for (var i = 0; i < num; i++){
		element[i].elemAngle = i * angleStep;
		if(i+num < element.length)
			element[i+num].elemAngle = element[i].elemAngle;
   if(i+num*2 < element.length)
	   element[i+num*2].elemAngle = element[i].elemAngle;
   if(i+num*3 < element.length)
	   element[i+num*3].elemAngle = element[i].elemAngle;
	}
	
	var id = setInterval(render, 20);
    var color;
    
    element.mouseover(function(){
        clearInterval(id);
        color = $(this).css("color");
        $(this).css("color", "#0ff");
    })
    .mouseout(function(){
        id = setInterval(render, 20);
        $(this).css("color", color);
    })
    .click(function(){
    			var value = $(this).text();
    			$("#front_input").val(value);
    			$(".graph").empty();	
    			d3.json(tagStr + "/search?q=" + value, function(error, root) { 
						if(error){
							$(".graph .error").text('很抱歉，没有找到与 "' + value + '" 相关的结果。');
						}
						else{
							$("#tagscloud ul").empty();
							var drugs;
							if(tagStr == "drug")
								drugs = root.drug.children;
							else if(tagStr == "symptom")
								drugs = root.symptom.children;
							var htl = '';
							for(var i=0; i<drugs.length; i++){
								htl += '<li><a href="">' + drugs[i].name + '</a></li>';
							}
							$("#tagscloud ul").html(htl);
							tagscloud("#tagscloud", tagStr);
							graph("#component .graph", root.drug, 1);
							graph("#attending .graph", root.symptom, 2);
							graph("#similar .graph", root.recipe, 3);		
						}
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
			.css("color", "#8462ec");
            
			if(i+num < element.length){
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
					.css("color", "#d074f3");
					
					if(i+num*2 < element.length){
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
						.css("color", "#6b3dba");
						
						if(i+num*3 < element.length){
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
							.css("color", "#442513");
						}
					}
			}
		}
		offset1 += stepping;
		offset2 += stepping;
	}
}