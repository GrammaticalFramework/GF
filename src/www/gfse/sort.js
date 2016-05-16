
function initialize_sorting(tagList,classList) {
    /*
    var debugoutput=empty("pre");
    document.body.appendChild(debugoutput)
    function jsdebug(txt) {
	//clear(debugoutput)
	debugoutput.appendChild(text(txt+"\n"))
    }
    */
    function listToSet(list) {
	var set={}
	for(var i in list) set[list[i]]=true
	return set;
    }
    var sortable_tag=listToSet(tagList)
    var sortable_class=listToSet(classList)

    function sortable(elem) {
	return elem && elem.tagName!="INPUT" && elem.tagName!="BUTTON"
	    && (sortable_tag[elem.tagName]
		? sortable_class[elem.className]
		? elem
		: null
		: sortable(elem.parentNode))
    }

    function move_element(elem,x,y) {
	elem.style.left=x+"px";
	elem.style.top=y+"px";
	elem.delta={x:x,y:y};
    }

    function adjust_refs(elem,dy) {
	//jsdebug("dy="+dy);
	move_element(elem,elem.delta.x,elem.delta.y-dy);
	elem.downAt.y+=dy;
	elem.range.lo-=dy;
	elem.range.hi-=dy;
    }

    function move_up(elem) {
	var prev=elem.previousElementSibling;
	if(prev) {
	    var top=elem.offsetTop;
	    var mid=prev.offsetTop+prev.offsetHeight/2;
	    if(top<mid) {
		elem.parentNode.insertBefore(elem,prev);
		adjust_refs(elem,elem.offsetTop-top)
	    }
	    //else jsdebug("not yet, top="+top+", mid="+mid);
	}
	//else jsdebug("at top");
    }

    function move_down(elem) {
	var next=elem.nextElementSibling;
	if(next) {
	    var top=elem.offsetTop;
	    var bot=top+elem.offsetHeight;
	    var mid=next.offsetTop+next.offsetHeight/2;
	    if(bot>mid) {
		next.parentNode.insertBefore(next,elem);
		adjust_refs(elem,elem.offsetTop-top)
	    }
	    //else jsdebug("not yet, top="+top+", bot="+bot+", mid="+mid);
	}
	//else jsdebug("at bottom");
    }

    function swap(elem,dy) {
	if(dy>0) move_down(elem);
	else if(dy<0) move_up(elem);
    }

    function restrictTo(range,y) {
	return Math.min(range.hi,Math.max(range.lo,y));
    }

    // -------------------------------------------------------------------------
    // These functions isolate the difference between mouse interfaces and touch
    // interfaces

    function eventPosition(event) {
	var p=event
	if(event.touches) p=event.touches[0]
	return {x:p.screenX,y:p.screenY}
    }

    function setStartHandler(ondown) {
	if("ontouchstart" in window) document.ontouchstart=ondown
	else document.onmousedown=ondown
    }

    function setDragHandlers(onmove,onend) {
	if("ontouchstart" in window) {
	    document.ontouchmove=onmove;
	    document.ontouchend=onend;
	}
	else {
	    document.onmousemove=onmove;
	    document.onmouseup=onend;
	}
    }
    // -------------------------------------------------------------------------
    
    function startDrag(event,elem) {
	//jsdebug("Start dragging");
	elem.style.position="relative";
	elem.delta || (elem.delta={x:0,y:0});
	var p=eventPosition(event)
	elem.downAt={x:p.x-elem.delta.x,y:p.y-elem.delta.y};
	var list=elem.parentNode;
	// elem and list must have the same offsetParent for this to work!!
	var top=list.offsetTop-elem.offsetTop+elem.delta.y;
	elem.range={lo:top,hi:top+list.offsetHeight-elem.offsetHeight};
	elem.style.zIndex=1;
	//console.log("Start dragging",elem.id,list.offsetTop,elem.offsetTop,elem.range.lo,elem.range.hi)
	function dragMove(event) {
	    var p=eventPosition(event)
	    var dx=0/*p.x-elem.downAt.x*/;
	    var dy=restrictTo(elem.range,p.y-elem.downAt.y);
	    //jsdebug("dragging to "+dx+" "+dy+" "+show_props(elem.range,"range"));
	    //console.log("dragging to ",dy);
	    move_element(elem,dx,dy);
	    //jsdebug("dragging to "+elem.offsetLeft+" "+elem.offsetTop);
	    swap(elem,dy)
	    return false;
	}
	function dragEnd() {
	    //jsdebug("dropped");
	    elem.style.zIndex=0;
	    move_element(elem,0,0);
	    setDragHandlers(null,null)
	    return false;
	}
	setDragHandlers(dragMove,dragEnd)
	return false;
    }

    function mousedown(event) {
	var elem=sortable(event.target);
	if(elem) return startDrag(event,elem);
	//else jsdebug("Clicked outside"/*+taglist(event.target)/*+show_props(event,"event")*/);
    }

    //var jsdebug=debug;

    function init() {
	setStartHandler(mousedown)
	//var d=element("javascriptdebug");
	//if(d) jsdebug=function(msg) { d.innerHTML=msg; }
    }
    init();
}

//Inspired by http://tool-man.org/examples/sorting.html
