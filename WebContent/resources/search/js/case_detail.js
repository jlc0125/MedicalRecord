function initFront() {
			getCaseDetail();
		}
		
		function getCaseDetail()
		{
			var dataJson = {
				"casename" : decodeURI(getUrlParam("casename"))
				};
			var methodType = "POST";
			var url = "./casedetailinfo";
			var contentType = "application/json;charset=utf-8";
			$.ajax({
				type: 'POST',
				url: url,
				data: dataJson,
				success: getCaseDetailSuccessCB,
				error: getCaseDetailErrorCB,
				dataType:'text'
			});
		}
		
		function getCaseDetailSuccessCB(data,textStatus,jqXHR)
		{
		    data=eval('(' + data + ')');
		    var pageNo=getUrlParam("pageNo");
		    var subCase=data.list[pageNo-1];
			var table = "";
			var f1=ToHtmlString(subCase);
			console.log(subCase)		
			if(subCase) table += "<tr><td>医案</td><td class='list_field' id='casedetail_list'>" + f1 + "</td></tr>";
			$("#case_detail_list_info").html(table);
			
			if(data.count>1){
				jQuery("#case_detail_pagincation").pagination(
						{
							items : parseInt(data.count),
							itemsOnPage : 1,
							cssStyle : 'light-theme',
							hrefTextPrefix : '#',
							onPageClick : function(pageNumber, event) {
								window.location.href = "./casedetail?casename="
									+ decodeURI(getUrlParam("casename")) + "&pageNo="
									+ pageNumber;
			
										
			
							},
							prevText : "上一例",
							nextText : "下一例",
							currentPage : getUrlParam("pageNo")
						});
			}
		}
		
		function getCaseDetailErrorCB()
		{
			alert("Error");
		}
		
		
		//Html结构转字符串形式显示 支持<br>换行
		function ToHtmlString(htmlStr) {
		    return toTXT(htmlStr).replace(/\&lt\;br[\&ensp\;|\&emsp\;]*[\/]?\&gt\;|\r\n|\n/g, "<br/>");
		}
		//Html结构转字符串形式显示
		function toTXT(str) {
		    var RexStr = /\<|\>|\"|\'|\&|　| /g
		    str = str.replace(RexStr,
		    function (MatchStr) {
		        switch (MatchStr) {
		            case "<":
		                return "&lt;";
		                break;
		            case ">":
		                return "&gt;";
		                break;
		            case "\"":
		                return "&quot;";
		                break;
		            case "'":
		                return "&#39;";
		                break;
		            case "&":
		                return "&amp;";
		                break;
		            case " ":
		                return "&ensp;";
		                break;
		            case "　":
		                return "&emsp;";
		                break;
		            default:
		                break;
		        }
		    }
		    )
		    return str;
		}