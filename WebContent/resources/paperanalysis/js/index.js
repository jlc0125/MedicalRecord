function changewhy(windex){
	//document.getElementById("why" + windex).class='current';
	$.ajax({
		url:"adultwhy/setAdultWhyjson.html",
		type:"post",
		dataType:"json",
		data:{"index":windex},
		success:function(json){
			var title = json.title;
			var id = json.id;
			
			var whyuserid = json.whyuserid;
			var answerContent = json.answerContent;
			var whyusernickname = json.whyusernickname;
			var adultAnswerBookList = json.adultAnswerBookList;
			document.getElementById("title").innerHTML= title + "<a rel='nofollow' target='_blank' class='answer' href='adultwhy/" + id + ".html'>我来解答</a>";
			document.getElementById("askUser").innerHTML='<span class="span1">提问人：</span><span class="span2"><a rel="nofollow" target="_blank" href="/read/bookShelf.html?userId='+whyuserid+'">'+whyusernickname+'</a></span>';
			document.getElementById("questionText").innerHTML=answerContent;
			document.getElementById("headImg").innerHTML='<img src="http://www.9yue.com/userpic/middle.html?userid='+json.answeruserid+'" alt="30x30头像" />';
			document.getElementById("commentText").innerHTML='<strong><a rel="nofollow" target="_blank" href="read/bookShelf.html?userId='+json.answeruserid+'">'+json.answerusernickname+'</a>：</strong>'+json.answerusercontent+'<a rel="nofollow" target="_blank" class="all" href="adultwhy/'+id+'.html">[全部]</a>';
			var answerbookStr = '<strong>推荐书籍：</strong>';
			if(adultAnswerBookList != null || adultAnswerBookList != 'undefined'){
				for(var i = 0; i < adultAnswerBookList.length; i++){
					if(adultAnswerBookList[i].productId != null || adultAnswerBookList[i].productId != ''){
						answerbookStr += '<a rel="nofollow" target="_blank" class="link" href="productdetail/'+adultAnswerBookList[i].productId+'.html">'+ adultAnswerBookList[i].bookName+'</a>';
					}
					else{
						answerbookStr += '<a class="link"'+ adultAnswerBookList[i].bookName + '</a>';
					}
				}
			}
			
            document.getElementById("commentLink").innerHTML = answerbookStr;   
            document.getElementById("commentApproval").innerHTML = '<span class="span1">满意('+json.satisfiedCount+')</span><span class="span2">|</span><span class="span1">没有帮助('+json.noHelpCount+')</span><a rel="nofollow" target="_blank" class="more" href="adultwhy/'+id+'.html">更多帮助&gt;</a>'; 
            document.getElementById("bookNoDelay").innerHTML = '<a  rel="nofollow" target="_blank" href="productdetail/'+json.whyproductid+'.html"><img src="http://www.9yue.com'+json.whypicturePath+'middle.jpg" alt="" /></div>'; 
            
            var whybookscore = json.whybookscore;
            if(whybookscore == null || whybookscore == '' || whybookscore <=0){
            	whybookscore = 3;
            }
            var price = json.whybookprice;
			price = new Number(price).toFixed(2);
            document.getElementById("bookinfotitle").innerHTML = '<p class="title"><a rel="nofollow" target="_blank" class="link" href="productdetail/'+json.whyproductid+'.html">'+json.whybookname+'</a></p>'+
                    '<p class="starScore"><span class="star score'+whybookscore*2+'"><strong>'+whybookscore+'</strong></span></p>'+
                    '<p class="author">作者：' + json.whybookauthor +'</p>'+
                    '<p class="price">￥'+price+'元</p>'+
                    '<p class="intro">'+json.whyrecommendContent+'</p>';
            
            
            var bookList = json.bookList;
            var bookStr = '';
            if(bookList != null || bookList != 'undefined'){
				for(var i = 0; i < bookList.length; i++){
					price = bookList[i].price;
					price = new Number(price).toFixed(2);
					bookStr += '<li><dl class="bookImg"><dd class="book">'+
                          '<p><span class="span1"><img class="minMax" alt="'+bookList[i].bookName+'" src="http://www.9yue.com'+bookList[i].bookpicturepath+'middle.jpg" /></span></p>'+
                          '</dd> <dt><p class="title"><a rel="nofollow" target="_blank" href="productdetail/${productId }.html">'+bookList[i].bookName+'</a></p>'+
                          '</dt><dd><p class="price">￥'+ price +'元</p></dd> </dl></li>';
				}
			}
            document.getElementById("bookList02cf").innerHTML = bookStr;
		}
	});
	
}
function parseJddbBook(book){
	var price;
	if(book[4]==""||book[4]=="NaN"||book[4]==null){
		price = "0.00";
	}else{
		price = parseFloat(book[4]);
		price = new Number(price).toFixed(2);
	}
	var author =book[3];
	if(author==""||author=="undefind")author=" ";
	else author = author+"--";
	var ht = '<div class="info">'
    +'<div class="text">'+book[5]+'</div>'
    +'<div class="buttonName">'
    +'<div class="button"><a class="like" href="javascript:;" style="dispaly:none" onclick="qidai('+book[8]+');">喜欢<span id="'+book[8]+'qidai">'
    +book[7]+'</span></a><a class="share" onclick="fenxiang('+book[7]+')">分享</a></div>'
    +'<div class="name">'+author+'《<a href="'+getRootPath()+'/productdetail/'+book[1]+'.html" title="'+book[2]+'" target="_blank">'+book[2]+'</a>》</div>'
    +'</div></div>'
    +'<div class="image"><a href="'+getRootPath()+'/productdetail/'+book[1]+'.html" title="'+book[2]+'" target="_blank">'
    +'<img src="http://www.9yue.com'+book[6]+'middle.jpg" alt="'+book[2]+'" /><span class="alpha"></span><span class="price">'
	+'￥'+price+'&nbsp;</span></a></div>'
	//alert(ht);
	$("#jddbBook").html(ht);
}
function change(){
	
	$.ajax({
		url:"getIndexPageSjkk.html?"+Math.random(),
		type:"post",
		dataType:"json",
		data:{"ids":ids},
		success:function(json){
			var code = json.code;
			if(code==2){
				var books = json.books;
				parseSjkkBooks(books);
			}else{
				var msg = json.msg;
				alert(msg);
				return;
			}
		}
	});
}

function parseSjkkBooks(books){
	var sjkkHtml = "";//"<ul class=\"bookList02 cf\">";
	
	       
	for(var i=0;i<books.length;i++){
		var book=books[i];
		ids += book.bookId+",";
		var bookNameTemp = book.bookName;
		var bookName = bookNameTemp;
		var author = book.author;
		if(author==null||author=="undefined"||author==""){
			author="&nbsp;";
		}
		var price = parseFloat(book.price);
		price = new Number(price).toFixed(2);
		if(price==null||price=="undefined"||price=="NaN"||price==""){
			price="0.00";
		}
		if(bookName.length>7)bookName=bookName.substring(0,7);
		if(author.length>9)author=author.substring(0,9);
		var bookHtml = '<li>'
	    +'<dl class="bookImg">'
	    +'<dd class="book">'
	    +'<p><span class="span1"><a href="'+getRootPath()+'/productdetail/'
	    +book.productId+'.html" target="_blank"title="'+bookNameTemp+'"><img class="minMax" alt="" src="http://www.9yue.com'+book.picturePath+'middle.jpg " /></a></span></p>'
	    +'</dd>'
	    +'<dt>'
	    +'<p class="title"><a href="'+getRootPath()+'/productdetail/'+book.productId+'.html" target="_blank"title="'+bookNameTemp+'">'+bookName+'</a></p>'
	    +'</dt>'
	    +'<dd>'
	    +'<p class="author">'+author+'</p>'
	    +'</dd>'
	    +'<dd>'
	    +'<p class="price">￥'+price+' &nbsp;</p>'
	    +'</dd>'
	    +'</dl>'
	    +'</li>';
		sjkkHtml += bookHtml;//+"</ul>";
	}
	
	document.getElementById("suijikankanbooks").innerHTML = sjkkHtml;
	document.getElementById("suijikankanbooks").style.height = "504px";
	//alert($("#suijikankanbooks").html().length);
	//$("#suijikankanbooks").before(sjkkHtml);
}

function qidai(id){
	if(id==null||id=="")return;
	var c = "#"+id+"qidai";
	var count = parseInt($(c).html());
	var curWwwPath=window.document.location.href;
	$.ajax({
		url:"indexpageqidai.html",
		data:{"id":id,"curWwwPath":curWwwPath},
		type:"post",
		dataType:"json",
		beforeSend:function(){
			
		},
		success:function(json){
			if(json==""||json=="undefind"||json==null)return;
			var code =json.code;
			if(code==2){
				$(c).html(count+1);
			}
		}
	});
}
var index = 0;
var leng = 5;
function prevJddb(){
	index--;
	if(index<0)index=leng;
	$.ajax({
		url:"getIndexPageJddb.html",
		type:"post",
		dataType:"json",
		data:{"index":index},
		success:function(json){
			var code = json.code;
			if(code==2){
				var book = json.book;
				parseJddbBook(book);
			}else{
				var msg = json.msg;
				alert(msg);
				return;
			}
		}
	});
}

function nextJddb(){
	index = index+1;
	if(index>leng)index=0;
	$.ajax({
		url:"getIndexPageJddb.html",
		type:"post",
		dataType:"json",
		data:{"index":index},
		success:function(json){
			var code = json.code;
			if(code==2){
				var book = json.book;
				parseJddbBook(book);
			}else{
				var msg = json.msg;
				alert(msg);
				return;
			}
		}
	});
}
function loadSuijikankan(){
	//alert($("#suijikankanbooks").html().length);
	if($("#suijikankanbooks").html().length<20){
		change();
	}
}
