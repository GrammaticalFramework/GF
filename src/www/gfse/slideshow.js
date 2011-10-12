
var internet_explorer=navigator.appName=="Microsoft Internet Explorer";

/* How to change opacity in IE:
http://joseph.randomnetworks.com/archives/2006/08/16/css-opacity-in-internet-explorer-ie/
*/

var set_opacity =
  internet_explorer
    ? function(el,o) { el.style.filter="alpha(opacity="+Math.round(o*100)+")";}
    : function(el,o) { el.style.opacity=o; };

function start_slideshow(img,options) {
    var p=img.parentNode;
    if(p.tagName=="A") p=p.parentNode;
    var is=p.getElementsByTagName("img");
    if(is.length>1) {
	var cur=0;
	var w=img.width;
	var h=img.height;
	//p.style.position="relative";
	p.style.minWidth=w+"px";
	p.style.minHeight=h+"px";
	var images=[];
	for(var i=0;i<is.length;i++) {
	    images[i]=is[i];
	    var c=images[i];
	    if(internet_explorer) c.style.zoom=1;
	    c.style.position="absolute";
	}
	var timeout=1000*(options.delay || 5);
	var ft=options.fade==null ? 1 : options.fade;
	var tick=function() {
	    var c=images[cur];
	    cur= (cur+1) % images.length;
	    var n=images[cur];
	    set_opacity(n,0);
	    //n.style.position="static";
	    n.style.zIndex=1;
	    n.className="";
	    if(n.width>w) { w=n.width; p.style.minWidth=w+"px"; }
	    if(n.height>h) { h=n.height; p.style.minHeight=h+"px"; }
	    c.style.position="absolute";
	    c.style.zIndex=0;
	    fade(n,0,1,ft,function() {
		if(c.width>n.width || c.height>n.height) fade(c,1,0,ft,null);
		else set_opacity(c,0); });
	    //debug.innerHTML=w+"x"+h;
	    //for(var i=0;i<images.length;i++)
		//debug.appendChild(text(" "+images[i].style.position));
	}
	//var debug=document.createElement("div");
	//p.parentNode.insertBefore(debug,p);
	//debug.innerHTML=w+"x"+h;
	setInterval(tick,timeout);
    }
    //else alert("No slideshow!");
}

function fade(el,start,stop,t,after) {
  // el: which element to fade
  // start: starting opacity [0..1]
  // stop: ending opacity [0..1]
  // t: duration of fade (in seconds), default 1s
  // after: function to call when done fading, optional
  var dt=40; // Animation granularity, 1/40ms = 25fps
  el.step=(stop-start)*dt/(1000*(t==null ? 1 : t));
  el.stop=stop;
  //alert("fade "+start+" "+stop+" "+el.step);
  var done=function() {
      clearInterval(el.timer);
      el.timer=null;
      if(after) after();
  }
  var f=function() {
     var next=el.current+el.step;
     if(next>=1) { next=1; done(); }
     if(next<=0) { next=0; done(); }
     set_opacity(el,next);
     el.current=next
  }
  if(!el.timer) {
      el.current=start;
      el.timer=setInterval(f,dt);
  }
}
