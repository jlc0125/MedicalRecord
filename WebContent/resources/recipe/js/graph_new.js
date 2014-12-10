(function(window){
	var diameter = 450;
	var tree = d3.layout.tree()
	.size([360, diameter / 2 - 60])
	.separation(function(a, b) {
		return (a.parent == b.parent ? 1 : 2) / a.depth;  
	});
				        
	var diagonal = d3.svg.diagonal.radial()
	.projection(function(d) {
		return [d.y, d.x / 180 * Math.PI]; 
	});
	
	function graph(selectStr, root){
		var svg = d3.select(selectStr).append("svg")
		.attr("width", diameter)
		.attr("height", diameter)
		.append("g")
		.attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");
					
		var nodes = tree.nodes(root),
					links = tree.links(nodes);
					
		var link = svg.selectAll(".link")
		.data(links)
		.enter()
		.append("path")
		.attr("class", "link")
		.attr("d", diagonal);
					
		link.append("title").text("相关关系");
	
		link.on("mouseover", function(){
			d3.select(this).style("stroke-width", 5);
		})
		.on("mouseout", function(){
			d3.select(this).style("stroke-width", 2.5);
		});
					
		var rootNode = svg.append("g")
		.attr("class", "rootnode");
					
		rootNode.append("circle")
		.attr("r", 7);
	
		rootNode.append("text")
		.attr("dy", "32")
		.attr("text-anchor", "middle")
		.text(nodes[0].name);
	
		var node = svg.selectAll(".node")
		.data(nodes.slice(1))
		.enter().append("g")
		.attr("class", "childnode")
		.attr("transform", function(d) {
			return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; 
		});
	
		node.append("circle")
		.attr("r", 4.5)
		.on("mouseover", function(){
			d3.select(this).attr("r", 8);
		 })
		.on("mouseout", function(){
			d3.select(this).attr("r", 4.5);
		})
		.on("click", function(d){
			var url = "search/retval?wd=" + d.parent.name+" "+d.name+"&type=content_contain";
			$.get(url, function(data, status){
				var txt = "";
				var numData = 0;
				for(var i=0; i<data.length; i++){
					if(data[i].recordTitle){
						txt += "<li><a href='record_detail?recordId=" + data[i].recordId + "&hlFlag=1&hlWords=" + d.parent.name+" "+d.name +"'"+ " target='_blank'>" + data[i].recordTitle + '</a></li>';
						numData++;
						if(numData >= 40)
							break;
					}
				}
				$(".alt_content").html(txt);
				if(txt != ""){
					$(".alt_content").css("border","1px solid #DB5C04");
					
					$('.alt_container').pajinate({
						items_per_page : 10,
						num_page_links_to_display : 4,
						item_container_id : '.alt_content',
						nav_panel_id : '.alt_page_navigation',
						nav_info_id : '.alt_info_text'
				      });
				}
			});
		});
	
		node.append("text")
		.attr("dy", ".5em")
		.attr("text-anchor", function(d) {
			return d.x < 180 ? "start" : "end";
		 })
		.attr("transform", function(d) {
			return d.x < 180 ? "translate(8)" : "rotate(180)translate(-8)";
		})
		.text(function(d) { return d.name; });
					
		node.append("title")
		.text(function(d){
			return "点击查看  " + d.parent.name + " 和  " + d.name +  " 相关的医案";
		});
	}
	
	window.graph = graph;
})(window)