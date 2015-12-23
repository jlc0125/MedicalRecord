// revision
      $(function(){
            
            function showBombBox(){
               
                var height = $("body").height();
                $(".mask").css("height",height);
                $(".mask").show();
                $(".bomb-box").show();
                
            }

            function hideBombBox(){
                $(".bomb-box").hide();
                $(".mask").hide();
            }

            $(".revision-span").click(function(){
               
                showBombBox();
                $("body").click(function(event){
                    var toElement = event.toElement;
                    if(toElement == $(".revision-span")[0]){
                        return;
                    }
                
                    var x = event.clientX;
                    var scrollY = document.documentElement.scrollTop || document.body.scrollTop;
                    var y = event.clientY + scrollY;
                    var top = $(".bomb-box").offset().top;
                    var left = $(".bomb-box").offset().left;
                    var width = $(".bomb-box").width();
                    var height = $(".bomb-box").height();
                    // console.log([x,y,top,left,width,height]);
                    if(x < left || y < top || x > left + width || y > top + height){
                        hideBombBox();
                        $("body").unbind();
                    }
                })

            });

            $(".revision-btn").click(function(){
                hideBombBox();
                var id = getUrlParam("recordId");
                var e1 = $(".rec-advise-div input")[0].value;
                var e2 = $(".rec-advise-div input")[1].value;
                var comment = $(".rec-comment-div textarea").val();
                dataJson = {
                    e1 : e1,
                    e2 : e2,
                    c: comment
                }

                url = "revision/association_rule";
                $.ajax({
                  type: "GET",
                  url: url,
                  data: dataJson,
                  success: successCB,
                  error: errorCB,
                  dataType:"text"
                });
            })

            function successCB(data){
                console.log("success");
            }

            function errorCB(){
                alert("revision error");
            }

        })