
$(function() {
	
	$('#front_btn').live(
			'click',
			function() {
				var keyword = $('#front_input').val();
				
				window.location.href="./graphsearch?keyword="+keyword;
				
			});

});



function getFrontGraph(){
	var dataJson={
			"keyword" : decodeURI(getUrlParam("keyword"))
	};
	url="./graphresultlist";
	
	$.ajax({
		  type: 'POST',
		  url: url,
		  data: dataJson,
		  success: getFrontListSuccessCB,
		  error:getFrontErrorCB,
		  dataType:'text'
		});
}


function getFrontListSuccessCB(data,textStatus,jqXHR) {
    
    //D3.js version
	/*
    var width = 960,
    height = 800;

    var cluster = d3.layout.cluster()
    .size([height, width - 160]);

    var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });

    var svg = d3.select(".container-fluid").append("svg")
    	.attr("width", width)
    	.attr("height", height)
    	.append("g")
    	.attr("transform", "translate(80,0)");

    var root=eval('(' + data + ')');
    var nodes = cluster.nodes(root),
    	links = cluster.links(nodes);

    var link = svg.selectAll(".link")
    	.data(links)
    	.enter().append("path")
    	.attr("class", "link")
    	.attr("d", diagonal);

    var node = svg.selectAll(".node")
    	.data(nodes)
    	.enter().append("g")
    	.attr("class", "node")
    	.attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; })

    	node.append("circle")
    	.attr("r", 4.5);

    	node.append("text")
    	.attr("dx", function(d) { return d.children ? -8 : 8; })
    	.attr("dy", 3)
    	.attr("id","graph_text")
    	.style("text-anchor", function(d) { return d.children ? "end" : "start"; })
    	.text(function(d) { return d.name; })
    	.on("click",function(d){window.open('http://127.0.0.1:8000/graphsearch?keyword='+d.name);});
  


    	d3.select(self.frameElement).style("height", height + "px");
    	
    	
    */
    data = eval("("+data+")");
    for(var key in data)
    {
    	if(key!='keyword')
    	{
    		id = "accordion-inner"+key;
    		if(data[key].length!=0)
    		{
    			var text='';
    			for(var i=0;i<data[key].length;i++)
    				text+= "<a href=''>"+data[key][i]+"</a></br>";
    			document.getElementById(id).innerHTML = text;
    		}
    		else
    		{
    			document.getElementById("accordion-group"+key).style.display="none";
    		}
    	}
    }
}

function getFrontErrorCB(){
	alert("Error");
}