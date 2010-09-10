/* --- Accessing document elements ------------------------------------------ */

function element(id) {
  return document.getElementById(id);
}

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
      if (http.readyState==4 || http.readyState=="complete")
	  callback(http.responseText)
  }
  http.onreadystatechange=statechange
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

function empty(tag,name,value) {
  var el=document.createElement(tag);
  if(name && value) el.setAttribute(name,value);
  return el;
}

function empty_id(tag,id) { return empty(tag,"id",id); }
function empty_class(tag,cls) { return empty(tag,"class",cls); }

function div_id(id) { return empty_id("div",id); }
function span_id(id) { return empty_id("span",id); }

function wrap(tag,contents) {
  var el=empty(tag);
  el.appendChild(contents);
  return el;
}

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

function tr(cells) {
  var tr=empty("tr");
  for(var i=0;i<cells.length;i++)
    tr.appendChild(cells[i]);
  return tr;
}

function button(label,action,key) {
  var el=empty("input","type","button");
  el.setAttribute("value",label);
  el.setAttribute("onclick",action);
  if(key) el.setAttribute("accesskey",key);
  return el;
}

function option(label,value) {
    var el=empty("option","value",value);
    el.innerHTML=label;
    return el;
}

function appendChildren(el,cs) {
  for(var i=0;i<cs.length;i++)
    el.appendChild(cs[i]);
  return el;
}

function tda(cs) { return appendChildren(empty("td"),cs); }

function img(src) { return empty("img","src",src); }

/* --- Debug ---------------------------------------------------------------- */

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
