;(function($){
	$.fn.carousel = function(param){
		var sliderContainer = param.sliderContainer
		var carousel = param.carousel;
		var list = $(carousel).children(".slider_item");//轮播元素子项
		var indexContainer = param.indexContainer;//索引插件
		var prev = param.prev;//左按钮
		var next = param.next;//右按钮
		var timing = param.timing;//自动播放间隔
		var animateTime = param.animateTime;//动画时间
		var auto = param.auto;//是否自动播放
		var mode= param.mode
		var timer;
		//var animating=true;
		
		var w=$(carousel).width();
		//console.log(w)
		var index=0;
		var totalIndex=list.length-1;
		$(carousel).width(2*w*(totalIndex+1));
		
		var indexList = $(indexContainer).children(".slider_indicators_btn");
		$(list[0]).addClass("on");
		$(indexList[0]).addClass("slider_indicators_btn_active")
		if(auto){
			startTiming();
			/*鼠标进入停止计时，离开开始计时*/
			$(carousel+","+prev+","+next+","+indexContainer).hover(function(){
				window.clearInterval(timer);
			},function(){
				startTiming();
			});
		}

		/*开始轮播的计时器*/
		function startTiming(){
			timer = window.setInterval(nextStep,timing);
		};
		
		//左按钮事件
		function prevStep(){
			index--;
			$.switchImg(1);
		}
		$(prev).off("click").on("click",prevStep);
		
		//右按钮事件
		function nextStep(){
			index++;
			$.switchImg(-1);
		}
		$(next).off("click").on("click",nextStep);
		
		//索引点击事件
		$(indexList).off("click").on("click",function(){
			if (!$(this).hasClass("slider_indicators_btn_active")) {
				var on = $(carousel).children(".on");
				var i = $(this).index();
				$(indexList).removeClass("slider_indicators_btn_active");
				$(indexList[i]).addClass("slider_indicators_btn_active");
				on.stop(false,true).fadeOut(animateTime).removeClass("on");
				$(list[i]).stop(false,true).addClass("on").delay(animateTime/2).fadeIn(animateTime);
			}
		});

		/*切换当前索引*/
		$.extend({switchIndex:function(){
			if(index>totalIndex){
				index=0
			}else if(index<0){
				index=totalIndex;
			}
			$(indexList).removeClass("slider_indicators_btn_active");
			$(indexList[index]).addClass("slider_indicators_btn_active");
			

		}});
		for(var i=0;i<=totalIndex;i++){
			
			$(carousel).find(".slider_item").eq(i).attr("data-index",i);
			$(sliderContainer).find(".slider_indicators_btn").eq(i).attr("data-index",i);
		}
		//
		var listTemp=$(list).clone();
		
		
		function initSlider(i){
			if(i==0){
				//$(carousel).empty();
				var a=list.slice(totalIndex);
				var b=list.slice(0,totalIndex);
				
				list=$.merge(a,b);
				$(carousel).empty();
				$(carousel).append($(list))
				//console.log(i)
				
				$(carousel).css("left","0px");
			}else{
				//$(carousel).css("left","0px");
			}
			
		}
		
		/*切换图片*/
		$.extend({switchImg:function(cIndex){
			if(mode=="fade"){
				var on = $(carousel).children(".on");
				on.stop(false,true).fadeOut(animateTime).removeClass("on");
				if(on.next().is(".slider_item")){
					$.switchIndex();
					on.next().stop(false,true).addClass("on").delay(animateTime/2).fadeIn(animateTime);
				}else{
					$.switchIndex();
					$(list[0]).stop(false,true).addClass("on").delay(animateTime/2).fadeIn(animateTime);
				}
			}else if(mode=="slider"){
				var list=$(carousel).children(".slider_item");
				var l=parseInt($(carousel).css("left"));
				var targetLef=l+cIndex*w;
				if(targetLef<=0 && targetLef>=-w*(totalIndex-1)){	
					$(carousel).animate({left:targetLef},{ queue:true, duration:animateTime*3});
				}else if(targetLef<-w*(totalIndex-1)){
					$(list).eq(totalIndex).insertBefore($(list).eq(0));
					$(carousel).css("left","0px");
				}else{
					$(list).eq(0).insertAfter($(list).eq(4));
					$(carousel).css("left",-w*(totalIndex));
				}
				$.switchIndex();
			}
			
		}});
	}
})(jQuery);

if(index>totalIndex){
	index=0;
}else