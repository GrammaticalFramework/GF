/* --- Accessing document elements ------------------------------------------ */

function element(id) {
  return document.getElementById(id);
}

/* --- JavaScript tricks ---------------------------------------------------- */

// To be able to object methods that refer to "this" as callbacks
// See section 3.3 of https://github.com/spencertipping/js-in-ten-minutes/raw/master/js-in-ten-minutes.pdf
function bind(f, this_value) {
    return function () {return f.apply (this_value, arguments)};
};

/* --- JSONP ---------------------------------------------------------------- */

// Inspired by the function jsonp from 
//          http://www.west-wind.com/Weblog/posts/107136.aspx
// See also http://niryariv.wordpress.com/2009/05/05/jsonp-quickly/
//          http://en.wikipedia.org/wiki/JSON#JSONP
function jsonp(url,callback)
{                
    if (url.indexOf("?") > -1)
        url += "&jsonp=" 
    else
        url += "?jsonp=" 
    url += callback;
    //url += "&" + new Date().getTime().toString(); // prevent caching        
    
    var script = empty("script");        
    script.setAttribute("src",url);
    script.setAttribute("type","text/javascript");                
    document.body.appendChild(script);
}

var json = {next:0};

// Like jsonp, but instead of passing the name of the ballback function, you 
// pass the callback function directly, making it possible to use anonymous
// functions.
function jsonpf(url,callback)
{
    var name="callback"+(json.next++);
    json[name]=function(x) { delete json[name]; callback(x); }
    jsonp(url,"json."+name);
}

/* --- AJAX ----------------------------------------------------------------- */

function GetXmlHttpObject(handler)
{ 
  var objXMLHttp=null
  if (window.XMLHttpRequest)
  {
    objXMLHttp=new XMLHttpRequest()
  }
  else if (window.ActiveXObject)
  {
    objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP")
  }
  return objXMLHttp
}

function ajax_http_get(url,callback) {
    var http=GetXmlHttpObject()
    if (http==null) {
	alert ("Browser does not support HTTP Request")
	return
    } 
    var statechange=function() {
	if (http.readyState==4 || http.readyState=="complete") {
	    if(http.status==200) callback(http.responseText);
	    else alert("Request for "+url+" failed: "
		       +http.status+" "+http.statusText);
	}
    }
    http.onreadystatechange=statechange;
    http.open("GET",url,true)
    http.send(null)
    //dump("http get "+url+"\n")
    return http
}

// JSON via AJAX
function ajax_http_get_json(url,cont) {
    ajax_http_get(url,function(txt) { cont(eval("("+txt+")")); });
}

function sameOrigin(url) {
    return hasPrefix(url,location.protocol+"//"+location.host+"/");
}

// Use AJAX when possible, fallback to JSONP
function http_get_json(url,cont) {
    if(sameOrigin(url)) ajax_http_get_json(url,cont);
    else jsonpf(url,cont);
}


/* --- HTML construction ---------------------------------------------------- */
function text(s) { return document.createTextNode(s); }

function node(tag,as,ds) {
    var n=document.createElement(tag);
    for(var a in as) n.setAttribute(a,as[a]);
    for(var i in ds) n.appendChild(ds[i]);
    return n;
}

function empty(tag,name,value) {
    var el=node(tag,{},[])
    if(name && value) el.setAttribute(name,value);
    return el;
}

function empty_id(tag,id) { return empty(tag,"id",id); }
function empty_class(tag,cls) { return empty(tag,"class",cls); }

function div_id(id) { return empty_id("div",id); }
function span_id(id) { return empty_id("span",id); }

function wrap(tag,contents) { return node(tag,{},[contents]); }

function wrap_class(tag,cls,contents) {
  var el=empty_class(tag,cls);
  if(contents) el.appendChild(contents);
  return el;
}

function span_class(cls,contents) { return wrap_class("span",cls,contents); }
function div_class(cls,contents)  { return wrap_class("div",cls,contents); }

function p(contents) { return wrap("p",contents); }
function dt(contents) { return wrap("dt",contents); }
function li(contents) { return wrap("li",contents); }

function th(contents) { return wrap("th",contents); }
function td(contents) { return wrap("td",contents); }

function tr(cells) { return node("tr",{},cells); }

//modified for quiz (id added)
function button(label,action,key ,id) {
    var el=node("input",{"type":"button","value":label},[]);
    if(typeof action=="string") el.setAttribute("onclick",action);
    else el.onclick=action;
    if(key) el.setAttribute("accesskey",key);
	if(id) el.setAttribute("id",id);
    return el;
}

//added for quiz
function submit_button(label, id) {
  var el=empty("input","type","submit");
  el.setAttribute("value",label);
  if(id) el.setAttribute("id", id);
  return el;
}

function option(label,value) {
    return node("option",{"value":value},[text(label)]);
}

function appendChildren(el,ds) {
    for(var i in ds) el.appendChild(ds[i]);
    return el;
}

function insertFirst(parent,child) {
    parent.insertBefore(child,parent.firstChild);
}

function tda(cs) { return node("td",{},cs); }

function img(src) { return empty("img","src",src); }

/* --- Debug ---------------------------------------------------------------- */

function debug(s) {
    var d=element("debug");
    if(d) d.appendChild(text(s+"\n"))
}

function show_props(obj, objName) {
   var result = "";
   for (var i in obj) {
      result += objName + "." + i + " = " + obj[i] + "<br>";
   }
   return result;
}

function field_names(obj) {
   var result = "";
   for (var i in obj) {
      result += " " + i;
   }
   return result;
}

/* --- Data manipulation ---------------------------------------------------- */
function swap(a,i,j) { // Note: this doesn't work on strings.
  var tmp=a[i];
  a[i]=a[j];
  a[j]=tmp;
  return a;
}

function sort(a) {
// https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/Array/sort
  return a.sort();
  /* // Note: this doesn't work on strings.
  for(var i=0;i<a.length-1;i++) {
    var min=i;
    for(var j=i+1;j<a.length;j++)
      if(a[j]<a[min]) min=j;
    if(min!=i) swap(a,i,min);
  }
  return a;
  */
}

function filter(p,xs) {
  var ys=[];
  for(var i=0;i<xs.length;i++)
    if(p(xs[i])) ys[ys.length]=xs[i];
  return ys;
}

function implode(cs) { // array of strings to string
  /*
  var s="";
  for(var i=0;i<cs.length;i++)
    s+=cs[i];
  return s;
  */
  return cs.join("");
}

function hasPrefix(s,pre) { return s.substr(0,pre.length)==pre; }

function commonPrefix(s1,s2) {
    for(var i=0;i<s1.length && i<s2.length && s1[i]==s2[i];i++);
    return s1.substr(0,i);
}

/*
function all(p,xs) {
  for(var i=0;i<xs.length;i++)
    if(!p(xs[i])) return false;
  return true;
}
*/

function map(f,xs) {
  var ys=[];
  for(var i=0;i<xs.length;i++) ys[i]=f(xs[i]);
  return ys;
}

// map in continuation passing style 
function mapc(f,xs,cont) { mapc_from(f,xs,0,[],cont); }

function mapc_from(f,xs,i,ys,cont) {
  if(i<xs.length)
    f(xs[i],function(y){ys[i]=y;mapc_from(f,xs,i+1,ys,cont)});
  else
    cont(ys);
}

function overlaps(as,bs) {
    for(var i=0;i<as.length;i++)
	if(elem(as[i],bs)) return true;
    return false;
}

function elem(a,as) {
    for(var i=0;i<as.length;i++)
	if(a==as[i]) return true;
    return false;
}

function shuffle(a) {
    for(i=0;i<a.length;i++) swap(a,i,Math.floor(Math.random()*a.length))
    return a;
}
