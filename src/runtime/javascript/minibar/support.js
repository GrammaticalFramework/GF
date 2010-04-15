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

function th(contents) { return wrap("th",contents); }
function td(contents) { return wrap("td",contents); }

function tr(cells) {
  var tr=empty("tr");
  for(var i=0;i<cells.length;i++)
    tr.appendChild(cells[i]);
  return tr;
}

function button(label,action) {
  var el=empty("input");
  el.setAttribute("type","button");
  el.setAttribute("value",label);
  el.setAttribute("onclick",action);
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

function sort(a) { // Note: this doesn't work on strings.
  for(var i=0;i<a.length-1;i++) {
    var min=i;
    for(var j=i+1;j<a.length;j++)
      if(a[j]<a[min]) min=j;
    if(min!=i) swap(a,i,min);
  }
  return a;
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
