(function(window){
	var diameter = 560;
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
		.attr("class", function(d){
			if(d.source.depth == 0)
				return "rootlink";
			else
				return "childlink";
		})
		.attr("d", diagonal);
					
		if(selectStr == "#component #graph"){
			link.append("title").text(function(d){
				if(d.source.depth == 0)
					return "组成关系";
				else
					return "共生关系";
			});
		}
		else if(selectStr == "#attending #graph"){
			link.append("title").text(function(d){
				if(d.source.depth == 0)
					return "主治关系";
				else
					return "伴随关系";
			});
		}
		else{
			link.append("title").text("相似关系");
		}
	
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
		.attr("class", function(d){
			if(d.depth == 1)
				return "childnode";
			else
				return "grandchildnode";
		})
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
			//var url = "search/relate?wd1=" + d.parent.name + "&wd2=" + d.name;
			var url = "search/retval?wd=" + d.parent.name+" "+d.name+"&type=content_contain";
			$.get(url, function(data, status){
				var txt = "";
				for(var i=0; i<data.length; i++){
					txt += "<li><a href='record_detail?recordId=" + data[i].recordId + "&hlFlag=1&hlWords=" + d.parent.name+" "+d.name +"'"+ " target='_blank'>" + data[i].recordTitle + '</a></li>';
				}
				$(".alt_content").css("border","1px solid #DB5C04").html(txt);
							
				$('.alt_container').pajinate({
					items_per_page : 10,
					num_page_links_to_display : 4,
					item_container_id : '.alt_content',
					nav_panel_id : '.alt_page_navigation',
					nav_info_id : '.alt_info_text'
			      });
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