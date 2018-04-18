<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html> 
<html lang="en"> 
<head> 
<meta charset="UTF-8">
 <title>大图滚动</title>
<style type="text/css">
    *{ margin: 0; padding: 0; text-decoration: none;}
    body { padding: 20px;}
    #slider { margin:auto;width: 350px; height: 180px;  overflow: hidden; position: relative;}
    #slider_list { width: 4200px; height: 180px; position: absolute; z-index: 1;}
    #slider_list img { float: left;}
    #buttons { position: absolute; height: 10px; width: 100px; z-index: 2; bottom: 20px; left: 250px;}
    #buttons span { cursor: pointer; float: left; border: 1px solid #fff; width: 10px; height: 10px; border-radius: 50%; background: #333; margin-right: 5px;}
    #buttons .on {  background: orangered;}
    .arrow { cursor: pointer; display: none; line-height: 39px; text-align: center; font-size: 18px; font-weight: bold; width: 20px; height: 40px;  position: absolute; z-index: 2; top: 50%; background-color: RGBA(0,0,0,.3); color: #fff;}
    .arrow:hover { background-color: RGBA(0,0,0,.7);}
    #slider:hover .arrow { display: block;}
    #prev { left: 0px;}
    #next { right: 0px;}
</style>
</head>
<body>
	<div id="slider">
    <div id="slider_list" style="left: -350px;">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img01.jpg" alt="1">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img01.jpg" alt="1">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img02.jpg" alt="2">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img01.jpg" alt="3">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img02.jpg" alt="4">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img01.jpg" alt="5">
        <img src="${pageContext.request.contextPath}/resources/img/outdoor_item_img01.jpg" alt="5">
    </div>
    <div id="buttons">
        <span index="1" class="on"></span>
        <span index="2" class=""></span>
        <span index="3" class=""></span>
        <span index="4" class=""></span>
        <span index="5" class=""></span>
    </div>
    <a href="javascript:;" id="prev" class="arrow">&lt;</a>
    <a href="javascript:;" id="next" class="arrow">&gt;</a>
</div>

<script>
 window.onload=function(){


        var container=document.getElementById('slider')//获取容器id
        var list=document.getElementById('slider_list')//获取img容器
        var buttons=document.getElementById('buttons').getElementsByTagName('span')//获取点
        var prev=document.getElementById('prev')//左按钮
        var next=document.getElementById('next')//右按钮
        var animated=false
        var index=1;//小圆点
        var timer;//定时器


        //小圆点
        function showButton(){
            //对点点循环，去除已经有的on
            for(var i=0;i<buttons.length;i++){
                if(buttons[i].className=='on'){
                    buttons[i].className=''
                    break//退出循环
                }
            }
            buttons[index-1].className='on'
        }
        function animate(offset){
//            快速点击时，会出现小圆点和图片不对应的情况，解决方案是当图片处于动画状态时，直接屏蔽掉点击事件
            animated=true// 快速点击时，会出现小圆点和图片不对应的情况，解决方案是当图片处于动画状态时，直接屏蔽掉点击事件
            var newLeft=parseInt(list.style.left)+offset

            //焦点图轮播
            var time=300;//位移总时间
            var interval=10;//位移间隔时间
            var speed=offset/(time/interval)//每次位移量
            
            function go(){
                if(speed<0&&parseInt(list.style.left)>newLeft||(speed>0&&parseInt(list.style.left)<newLeft)){
                    list.style.left=parseInt(list.style.left)+speed+'px'
                    setTimeout(go,interval)
                }else{
                    animated=false;// 快速点击时，会出现小圆点和图片不对应的情况，解决方案是当图片处于动画状态时，直接屏蔽掉点击事件
                    list.style.left=newLeft +'px' //转成数字350
                    //判断是否l滚动到辅助图,图片滚动在-350和-1750之间,解决空白问题
                    if(newLeft>-350){
                        list.style.left=-1750+'px'
                    }
                    if(newLeft<-1750){
                        list.style.left=-350+'px'
                    }
                }
            }
            go()

        }
        //自动切换
        function play(){
            timer=setInterval(function(){
                next.onclick()
            },3000);
        }
        //停止切换
        function stop(){
            clearInterval(timer)
        }
        //右箭头
        next.onclick=function(){
            //判断点点是否是最后一个或者第一个
/*            if(index==5){
                index=1;
            }else{
                index+=1;
            }*/
            index += 1;
            index = index > 5 ? 1 : index;
            showButton()
            //+600和-600当做参数传给animate
//            list.style.left=parseInt(list.style.left)-600 +'px' //把字符串变为整数值，paresInt()只保留字符串中的数字
            if(!animated){
                animate(-350)
            }
        }
        //左箭头
        prev.onclick=function(){
           /* if(index==1){
                index=5;
            }else{
                index-=1;
            }*/
            index -= 1;
            index = index < 1 ? 5 : index;
            showButton()
//            list.style.left=parseInt(list.style.left)+600+'px'
            if(!animated){
                animate(350)
            }
        }
        //小圆点加事件
        for(var i=0;i<buttons.length;i++){
            buttons[i].onclick=function(){
//                if(this.className=='on'){
//                    return;
//                }
                var myIndex=parseInt(this.getAttribute('index'))//获取当前点点的index
                var offset=-350*(myIndex-index) //移动的距离：当前的index-之前的index
                //恢复小圆点位置
                index=myIndex
                showButton()
                if(!animate){
                    animate(offset)
                }
            }
        }
        //鼠标移上去，触发自动切换事件
        container.onmouseover=stop;//不要加括号，
        container.onmouseout=play
        //自动切换
        play()
    }
 </script>
 
<!--  <script> -->
 	window.onload=function(){
 		var focus_slider=document.getElementById('focus');
 		slider(focus_slider,true);
 	}
 	
 	function slider(obj,isAuto){//obj轮播对象，isAuto是否自动轮播
 		 var slider_list=obj.getElementsByClassName('slider_list')[0]//获取轮播list容器
 		 var slider_wrapper=obj.getElementsByClassName('slider_wrapper')[0]//获取轮播item容器
 		 
 		 var prev=obj.getElementsByClassName('slider_control_prev')[0]//左按钮
         var next=obj.getElementsByClassName('slider_control_next')[0]//右按钮
         
         var slider_indicators=obj.getElementsByClassName('slider_indicators')[0]//获取索引点容器
         var slider_indicators_btn=obj.getElementsByClassName('slider_indicators_btn');
         
         var p_distance=obj.offsetWidth;
         var totalIndex=obj.getElementsByClassName('slider_item').length;
 		 var index=1;//当前索引值
         var timer;//定时器
         var animated=false;
         //焦点图轮播参数
         var time=400;//位移总时间
         var interval=15;//位移间隔时间
         
         //初始化处理
         slider_wrapper.style.left="0px";
 		 slider_wrapper.style.width=100*(totalIndex+3)+"%";
 		 var flag_slider_item=obj.getElementsByClassName('slider_item')[0];
 		 //console.log(flag_slider_item);
 		 //slider_wrapper.appendChild(flag_slider_item);
         
         
       //右箭头  轮播一步逻辑
         next.onclick=function(){

             index ++;
             index = index > totalIndex ? 1 : index;
             init_circle();
             if(!animated){
            	 console.log(index);
           		 animate(-p_distance);
           		 
             } 
         }
       
         //左箭头  轮播一步逻辑
         prev.onclick=function(){

             index --;
             index = index < 1 ? totalIndex : index;
             init_circle();   
             
             if(!animated){
            	 console.log(index);
                 animate(p_distance);
                 
             }
         }
         
        
         function animate(distance,callback){
        	 animated=true;// 快速点击时，会出现小圆点和图片不对应的情况，解决方案是当图片处于动画状态时，直接屏蔽掉点击事件
        	
        	 var newLeft=parseInt(slider_wrapper.style.left)+distance;
        	 var speed=distance/(time/interval)//每次位移量
        	 
        	 
        	 function go(){
        		 if(speed<0&&parseInt(slider_wrapper.style.left)>newLeft||(speed>0&&parseInt(slider_wrapper.style.left)<newLeft)){
            		 slider_wrapper.style.left=parseInt(slider_wrapper.style.left)+speed+'px';
                     setTimeout(go,interval);
                 }else{
                     animated=false;// 快速点击时，会出现小圆点和图片不对应的情况，解决方案是当图片处于动画状态时，直接屏蔽掉点击事件
                     slider_wrapper.style.left=newLeft +'px' ;
                     //判断是否图片滚动在0和-p_distance*totalIndex之间
                     if(newLeft>-p_distance){
                    	 slider_wrapper.style.left=-p_distance*totalIndex+'px';
                     }
                     if(newLeft<-p_distance*totalIndex){
                    	 slider_wrapper.style.left='0px';
                     }
                 }
        	 } 
        	 go();
        	 
             
             
        	 callback&&callback();
         }
         //自动切换
         function play(){
        	 if(isAuto){
        		 timer=setInterval(function(){
                     next.onclick();
                 },3000); 
             }
         }
         
         //停止切换
         function stop(){
             clearInterval(timer);
         }
         
         slider_list.onmouseover=stop;
         slider_list.onmouseout=play;
         
         
         function init_circle(){
             //对点点循环，去除已经有的on
             for(var i=0;i<totalIndex;i++){
                 if(slider_indicators_btn[i].classList.contains('slider_indicators_btn_active') ){
                	 slider_indicators_btn[i].classList.remove("slider_indicators_btn_active") ;
                     break//退出循环
                 }
             }
             slider_indicators_btn[index-1].classList.add("slider_indicators_btn_active") ;
         }
         
         play();
 	}
 </script>
</body> 
</html>
