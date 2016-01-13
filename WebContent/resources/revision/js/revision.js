var pageNo=1;
var pageSize=5;

$(function(){
	$('.praise').live('click', function() {
		praise($(this));
	});
	
	$('.dispraise').live('click', function() {
		dispraise($(this));
	});
	$('.correct').live('click', function(){
		var el=$(this).parent().prev();
		var type = el.children('.type').children('.typename').first().html();
		var title = el.children('.title').text();
		if(type.indexOf('医案标题') != -1){
			title = title.split(":")[1];
			BootstrapDialog.show({
			  title: type,
	          message: '将医案&nbsp<b>'+title+'</b>&nbsp更正为:<input type="text" class="form-control">',
	          buttons: [{
	        	  label: "确定",
	        	  action: function(dialogRef){
	        		  var title = dialogRef.getModalBody().find('input').val();
	        		  dialogRef.close();
	        	  }
	          },{
	        	  label: "取消",
	        	  action: function(dialogRef){
	        		  dialogRef.close();
	        	  }
	          }]
	        });
		} else if(type.indexOf('相关关系') != -1){
			title = title.split(":")[1].split("/");
			BootstrapDialog.show({
				  title: type,
		          message: '将&nbsp<b>'+title[0]+'</b>&nbsp和&nbsp<b>'+title[1]+"</b>&nbsp相关关系删除",
		          buttons: [{
		        	  label: "确定",
		        	  action: function(dialogRef){
		        		  dialogRef.close();
		        	  }
		          },{
		        	  label: "取消",
		        	  action: function(dialogRef){
		        		  dialogRef.close();
		        	  }
		          }]
		        });
		}
		  
	});
	
	$('.uncorrect').live('click', function(){
		BootstrapDialog.show({
			title: "关闭问题",
			message: "请确定关闭该问题",
			 buttons: [{
	        	  label: "确定",
	        	  action: function(dialogRef){
	        		  dialogRef.close();
	        	  }
	          },{
	        	  label: "取消",
	        	  action: function(dialogRef){
	        		  dialogRef.close();
	        	  }
	          }]
	        });
		});
	
	$('.professor').live('click', function(){
		window.open('/MedicalRecord/revision_professor'); 
	});
});    


function praise(el) {  
	var dispraise = el.prev().children('.dispraise_txt').html();
	if(dispraise == '不同意'){
		var praise = el.children('.praise_txt');
        var txt = praise.html();
        var praisesTotal = el.children('.praises-total');
        var oldTotal = parseInt(praisesTotal.attr('total'));
        var newTotal;
        var rvsId = el.parent('.info').prev().children('.title').attr("id");
        
        if (txt == '同意') {
            newTotal = oldTotal + 1;
            praisesTotal.attr('total', newTotal);
            praisesTotal.html(newTotal);
            praise.html('取消同意');
            setAgree(newTotal,rvsId);
        }
        else if(txt == '取消同意'){
            newTotal = oldTotal - 1;
            praisesTotal.attr('total', newTotal);
            praisesTotal.html(newTotal);
            praise.html('同意');
            setAgree(newTotal,rvsId);
        }
        else{
        	
        }
	}else{
		alert('您已选择"不同意"，请先取消！');
	}
	
}

function dispraise(el) {  
	var praise = el.next().children('.praise_txt').html();
	if(praise == '同意'){
    	var dispraise = el.children('.dispraise_txt');
        var txt = dispraise.html();
        var dispraisesTotal = el.children('.dispraises-total');
        var oldTotal = parseInt(dispraisesTotal.attr('dis-total'));
        var newTotal;
        var rvsId = el.parent('.info').prev().children('.title').attr("id");
        
        if (txt == '不同意') {
            newTotal = oldTotal + 1;
            dispraisesTotal.attr('dis-total', newTotal);
            dispraisesTotal.html(newTotal);
            dispraise.html('取消不同意');
            setDisagree(newTotal,rvsId);
        }
        else if(txt == '取消不同意'){
            newTotal = oldTotal - 1;
            dispraisesTotal.attr('dis-total', newTotal);
            dispraisesTotal.html(newTotal);
            dispraise.html('不同意');
            setDisagree(newTotal,rvsId);
        }
        else{
        	
        }
	}else{
		alert('您已选择"同意"，请先取消！');
	}
}


function initRevision(){
	var dataJson = {
			
	};

	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./revision/revisionlist";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getRevisionSuccessCB, getRevisionErrorCB);
}

function getRevisionSuccessCB(data, textStatus, jqXHR){
	showData(data);
}
function showData(data){
	var str = "";
	var count = data.length;
	for(var i=(pageNo-1)*pageSize;i<pageNo*pageSize&&i<count;i++){
		str +=  '<div class="box clearfix">'+
					'<div class="content">'+
						'<div class="main">'+
							'<p class="title" id='+data[i].id+'>'+getTitle(data[i].type,data[i].advise)+'</p>'+
							'<p class="txt">'+data[i].comment+'</p>'+
							'<p class="type">'+
								'类型: <span class="typename">'+getType(data[i].type)+'</span>'+
							'</p>'+
						'</div>'+
						'<div class="info clearfix">'+
							'<span class="time">'+formateDate(new Date(data[i].create_date))+'</span>'+						
							'<a class="dispraise" href="javascript:;">'+
								'<span class="dispraise_txt">不同意</span>'+
								'(<span class="dispraises-total" dis-total="'+data[i].disagree+'">'+data[i].disagree+'</span>)'+
							'</a>'+
							'<a class="praise" href="javascript:;">'+
								'<span class="praise_txt">同意</span>'+
								'(<span class="praises-total" total="'+data[i].agree+'">'+data[i].agree+'</span>)'+
							'</a>'+
						'</div>'+
					'</div>'+
				'</div>';
		
	}
	$('#list').html(str);
	
	if (count <= pageSize){
		$("#rvs_pagincation").hide();
	}
	else{
		$("#rvs_pagincation").pagination(
		{
			items : parseInt(data.length),
			itemsOnPage : pageSize,
			cssStyle : 'light-theme',
			hrefTextPrefix : '#',
			onPageClick : function(pageNumber, event) {
				pageNo=pageNumber;
				showData(data);
			},
			prevText : "上一页",
			nextText : "下一页",
			currentPage : pageNo
		});
	}
}
    
function getRevisionErrorCB(){
	
	
}

function getType(type){
	if(type == '1'){
		return '医案标题修改';
	}else if(type == '2'){
		return '相关关系删除';
	}		
}

function getTitle(type,title){
	var str="";
	if(type == "1"){
		var tmp = title.split("#");
		str = "<a href = '/MedicalRecord/record_detail?recordId="+tmp[0]+"'>"+tmp[0]+"号医案</a>标题改为:"+tmp[1];
	}else if(type == "2"){
		str = "删除关系对:"+title;
	}
	return str;
}

//格式化日期
function formateDate(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    var h = date.getHours();
    var mi = date.getMinutes();
    m = m > 9 ? m : '0' + m;
    return y + '-' + m + '-' + d + ' ' + h + ':' + mi;
}


function setAgree(newTotal,rvsId){
	var dataJson = {
	};

	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./revision/setagree?agree="+newTotal+"&id="+rvsId;
	var contentType = "text";

	ajaxFunc(methodType, url, data, contentType,setAgreeSuccessCB, setAgreeErrorCB);
}

function setAgreeSuccessCB(data, textStatus, jqXHR){
	
}
    
function setAgreeErrorCB(){	
	
}


function setDisagree(newTotal,rvsId){
	var dataJson = {
	};

	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./revision/setdisagree?disagree="+newTotal+"&id="+rvsId;
	var contentType = "text";

	ajaxFunc(methodType, url, data, contentType,setDisagreeSuccessCB, setDisagreeErrorCB);
}

function setDisagreeSuccessCB(data, textStatus, jqXHR){
	
}
    
function setDisagreeErrorCB(){	
	
}


/*专家页面*/
function initRevisionProfessor(){
	var dataJson = {
			
	};

	var data = JSON.stringify(dataJson);
	var methodType = "POST";
	var url = "./revision/revisionlist";
	var contentType = "application/json;charset=utf-8";

	ajaxFunc(methodType, url, data, contentType, getRevisionProfessorSuccessCB, getRevisionProfessorErrorCB);
}

function getRevisionProfessorSuccessCB(data, textStatus, jqXHR){
	showProfessorData(data);
}
function getRevisionProfessorErrorCB(){
	
}
function showProfessorData(data){
	var str = "";
	var count = data.length;
	for(var i=(pageNo-1)*pageSize;i<pageNo*pageSize&&i<count;i++){
		str +=  '<div class="box clearfix">'+
					'<div class="content">'+
						'<div class="main">'+
							'<p class="title" id='+data[i].id+'>'+getTitle(data[i].type,data[i].advise)+'</p>'+
							'<p class="txt">'+data[i].comment+'</p>'+
							'<p class="type">'+
								'类型: <span class="typename">'+getType(data[i].type)+'&nbsp&nbsp</span>'+
								'同意人数: <span class="typename">'+data[i].agree+'&nbsp&nbsp</span>'+
								'不同意人数: <span class="typename">'+data[i].disagree+'</span>'+
							'</p>'+
						'</div>'+
						'<div class="info clearfix">'+
							'<span class="time">'+formateDate(new Date(data[i].create_date))+'</span>'+						
							'<a class="uncorrect" href="javascript:;">'+
								'<span class="uncorrect-txt">关闭问题</span>'+
							'</a>'+
							'<a class="correct" href="javascript:;">'+
								'<span class="correct-text">修改</span>'+
					
							'</a>'+
						'</div>'+
					'</div>'+
				'</div>';
		
	}
	$('#list').html(str);
	
	if (count <= pageSize){
		$("#rvs_pagincation").hide();
	}
	else{
		$("#rvs_pagincation").pagination(
		{
			items : parseInt(data.length),
			itemsOnPage : pageSize,
			cssStyle : 'light-theme',
			hrefTextPrefix : '#',
			onPageClick : function(pageNumber, event) {
				pageNo=pageNumber;
				showData(data);
			},
			prevText : "上一页",
			nextText : "下一页",
			currentPage : pageNo
		});
	}
}











/*
    *//**
     * 发评论
     * @param box 每个分享的div容器
     * @param el 点击的元素
     *//*
    function reply(box, el) {
        var commentList = box.getElementsByClassName('comment-list')[0];
        var textarea = box.getElementsByClassName('comment')[0];
        var commentBox = document.createElement('div');
        commentBox.className = 'comment-box clearfix';
        commentBox.setAttribute('user', 'self');
        commentBox.innerHTML =
            '<img class="myhead" src="images/my.jpg" alt=""/>' +
                '<div class="comment-content">' +
                '<p class="comment-text"><span class="user">我：</span>' + textarea.value + '</p>' +
                '<p class="comment-time">' +
                formateDate(new Date()) +
                '<a href="javascript:;" class="comment-praise" total="0" my="0" style="">赞</a>' +
                '<a href="javascript:;" class="comment-operate">删除</a>' +
                '</p>' +
                '</div>'
        commentList.appendChild(commentBox);
        textarea.value = '';
        textarea.onblur();
    }

    *//**
     * 赞回复
     * @param el 点击的元素
     *//*
    function praiseReply(el) {
        var myPraise = parseInt(el.getAttribute('my'));
        var oldTotal = parseInt(el.getAttribute('total'));
        var newTotal;
        if (myPraise == 0) {
            newTotal = oldTotal + 1;
            el.setAttribute('total', newTotal);
            el.setAttribute('my', 1);
            el.innerHTML = newTotal + ' 取消赞';
        }
        else {
            newTotal = oldTotal - 1;
            el.setAttribute('total', newTotal);
            el.setAttribute('my', 0);
            el.innerHTML = (newTotal == 0) ? '赞' : newTotal + ' 赞';
        }
        el.style.display = (newTotal == 0) ? '' : 'inline-block'
    }

    *//**
     * 操作留言
     * @param el 点击的元素
     *//*
    function operate(el) {
        var commentBox = el.parentNode.parentNode.parentNode;
        var box = commentBox.parentNode.parentNode.parentNode;
        var txt = el.innerHTML;
        var user = commentBox.getElementsByClassName('user')[0].innerHTML;
        var textarea = box.getElementsByClassName('comment')[0];
        if (txt == '回复') {
            textarea.focus();
            textarea.value = '回复' + user;
            textarea.onkeyup();
        }
        else {
            removeNode(commentBox);
        }
    }*/


  /*      //评论
        var textArea = boxs[i].getElementsByClassName('comment')[0];

        //评论获取焦点
        textArea.onfocus = function () {
            this.parentNode.className = 'text-box text-box-on';
            this.value = this.value == '评论…' ? '' : this.value;
            this.onkeyup();
        }

        //评论失去焦点
        textArea.onblur = function () {
            var me = this;
            var val = me.value;
            if (val == '') {
                timer = setTimeout(function () {
                    me.value = '评论…';
                    me.parentNode.className = 'text-box';
                }, 200);
            }
        }

        //评论按键事件
        textArea.onkeyup = function () {
            var val = this.value;
            var len = val.length;
            var els = this.parentNode.children;
            var btn = els[1];
            var word = els[2];
            if (len <=0 || len > 140) {
                btn.className = 'btn btn-off';
            }
            else {
                btn.className = 'btn';
            }
            word.innerHTML = len + '/140';
        }

    }
}
*/
