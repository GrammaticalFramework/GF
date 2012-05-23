

/* --- Translator object ---------------------------------------------------- */

function Translator() {
    this.local=tr_local();
    this.view=element("document")
    if(!supports_html5_storage()) {
	var warning=span_class("error",text("It appears that localStorage is unsupported or disabled in this browser. Documents will not be preserved after you leave or reload this page!"))
	insertAfter(warning,this.view)
    }
    this.current=this.local.get("current")
    this.document=this.current && this.current!="/" && this.local.get("/"+this.current) || empty_document()
    this.server=pgf_online({})
    this.server.get_grammarlist(bind(this.extend_methods,this))
    update_language_menu(this,"source")
    update_language_menu(this,"target")
    this.redraw();
}

function update_language_menu(t,id) {
    var dl=element(id);
    clear(dl);
    for(var i in languages) {
	var l=languages[i]
	dl.appendChild(wrap("dt",radiobutton(id,l.code,l.name,bind(t.change,t))))
    }
}

Translator.prototype.redraw=function() {
    var t=this;
    if(t.current=="/") t.browse()
    else {
	t.drawing=t.draw_document()
	clear(t.view)
	appendChildren(t.view,t.drawing.doc)
	var o=t.document.options
	update_radiobutton("method",o.method)
	update_radiobutton("source",o.from)
	update_radiobutton("target",o.to)
	if(o.method!="Manual") {
	    function cont2(gr_info) {
		t.grammar_info=gr_info
		t.update_translations()
	    }
	    function cont1() { t.server.grammar_info(cont2)}
	    t.server.switch_grammar(o.method,cont1)
	}
	else
	    t.update_translations()
    }
}

Translator.prototype.update_translations=function() {
    var t=this
    var doc=t.document
    var o=doc.options
    var ss=doc.segments
    var ds=t.drawing.segments

    function supported(concname) {
	var l=t.grammar_info.languages
	for(var i in l) if(l[i].name==concname) return true
	return false
    }

    function update_translation(i) {
	var segment=ss[i]
	function replace(sd) {
	    var old=ds[i]
	    ds[i]=sd
	    replaceNode(sd,old)
	}
	function upd3(txt) {
	    segment.target=txt;
	    segment.options=JSON.parse(JSON.stringify(o)) // no sharing!
	    replace(t.draw_segment(segment,i))
	}
	function upd2(ts) {
	    switch(ts.length) {
	    case 1: gfshell('ps -unlextext "'+ts[0]+'"',upd3); break;
	    case 0: upd3("[no translation]");break;
	    default: upd3("[ambiguous translation]")
	    }
	}
	function upd1(translate_output) {
	    //console.log(translate_output)
	    upd2(collect_texts(translate_output[0].translations))
	}
	function upd0(source) {
	    t.server.translate({from:gfrom,to:gto,input:source},upd1)
	}
	var fs=supported(gfrom)
	var ts=supported(gto)
	if(fs && ts) {
	    if(segment.options.method!="Manual" 
	       && JSON.stringify(segment.options)!=JSON.stringify(o))
		gfshell('ps -lextext "'+segment.source+'"',upd0)
	}
	else {
	    var fn=concname(o.from)
	    var tn=concname(o.to)
	    var unsup=" is not supported by the grammar"
	    var sup=" is supported by the grammar"
	    var msg= fs ? tn+unsup : ts ? fn+unsup :
		          "Neither "+fn+" nor "+tn+sup
	    upd3("["+msg+"]")
	}
    }

    if(doc.options.method!="Manual") {
	var gname=t.grammar_info.name
	var gfrom=gname+o.from
	var gto=gname+o.to
	for(var i in ss) update_translation(i)
    }
}

Translator.prototype.extend_methods=function(grammars) {
    this.grammars=grammars
    var dl=element("methods")
    if(dl) for(var i in grammars) {
	dl.appendChild(wrap("dt",radiobutton("method",grammars[i],
					     "GF: "+grammars[i],
					     bind(this.change,this))))
    }
    update_radiobutton("method",this.document.options.method)
}

Translator.prototype.change=function(el) {
    var t=this
    var o=t.document.options;
    function update(field) {
	if(el.value!=o[field]) {
	    o[field]=el.value
	    t.redraw()
	}
    }
    switch(el.name) {
    case "method": update("method"); break;
    case "source": update("from"); break;
    case "target": update("to"); break;
    }
}

Translator.prototype.new=function(el) {
    hide_menu(el);
    this.current=null;
    this.local.put("current",null)
    this.document=empty_document()
    this.redraw();
}

Translator.prototype.browse=function(el) {
    hide_menu(el);
    var t=this
    function browse() {
	var files=t.local.ls("/")
	var ul=empty_class("ul","files")
	for(var i in files) {
	    var name=files[i]
	    var link=a(jsurl("translator.open('"+name+"')"),[text(name)])
	    ul.appendChild(li(link))
	}
	clear(t.view)
	t.view.appendChild(wrap("h2",text("Your translator documents")))
	t.view.appendChild(ul)
	t.current="/"
	t.local.put("current","/")
    }
    setTimeout(browse,100) // leave time to hide the menu first
}

Translator.prototype.open=function(name) {
    var t=this
    if(name) {
	var path="/"+name
	var document=t.local.get(path);
	if(document) {
	    t.current=name;
	    t.local.put("current",name)
	    t.document=document;
	    t.redraw();
	}
	else alert("No such document: "+name)
    }
}

Translator.prototype.save=function(el) {
    hide_menu(el);
    if(this.current!="/") {
	if(this.current) this.local.put("/"+this.current,this.document)
	else this.saveAs()
    }
}

Translator.prototype.saveAs=function(el) {
    hide_menu(el);
    if(this.current!="/") {
	var name=prompt("File name?")
	if(name) {
	    this.current=this.document.name=name;
	    this.local.put("current",name)
	    this.save();
	    this.redraw();
	}
    }
}

Translator.prototype.close=function(el) {
    hide_menu(el);
    this.browse();
}

Translator.prototype.import=function(el) {
    hide_menu(el);
    var t=this
    function imp() {
	var text=prompt("Text segment to import?")
	if(text) {
	    t.document.segments.push(new_segment(text))
	    t.redraw();
	}
    }
    setTimeout(imp,100)
}
Translator.prototype.remove=function(el) {
    hide_menu(el);
    var t=this
    function rm() {
	if(t.document && t.document.segments.length>0) {
	    t.document.segments.pop();
	    t.redraw();
	}
    }
    setTimeout(rm,100)
}

Translator.prototype.edit_translation=function(i) {
    var t=this
    var ds=t.drawing.segments
    
    function replace_segment(sd) {
	var old=ds[i]
	ds[i]=sd
	replaceNode(sd,old)
    }

    function edit_segment(s) {
	function restore() { replace_segment(t.draw_segment(s,i)) }
	function done() {
	    s.options.method="Manual"
	    s.options.from=t.document.options.from
	    s.options.to=t.document.options.to
	    s.target=inp.value // side effect, updating the document in-place
	    restore();
	    return false;
	}
	var inp=node("input",{name:"it",value:s.target})
	var e=wrap("form",[inp, submit(), button("Cancel",restore)])
	var target=wrap_class("td","target",e)
	var edit=t.draw_segment_given_target(s,target)
	replace_segment(edit)
	e.onsubmit=done
	inp.focus();
    }
    edit_segment(t.document.segments[i])
}

function hide_menu(el) {
    function disp(s) { el.parentNode.style.display=s; }
    if(el) {
	disp("none")
	setTimeout(function(){disp("")},500)
    }
}

/* --- Documents ------------------------------------------------------------ */

/*
type Document = { name:String, options: Options, segments:[Segment] }
type Segment = { source:String, target:String, options:Options }
type Options = {from: Lang, to: Lang, method:Method}
type Lang = String // Eng, Swe, Ita, etc
type Method = "Manual" | GrammarName
type GrammarName = String // e.g. "Foods.pgf"
*/

Translator.prototype.draw_document=function() {
    var t=this
    var doc=t.document
    var o=doc.options;
    var segments=mapix(bind(t.draw_segment,t),doc.segments)
    var drawing=[node("h2",{},[text(doc.name),text(" "),
			       wrap("small",draw_translation(o))]),
		 wrap_class("table","segments",segments)]
    return {doc:drawing,segments:segments}
}

Translator.prototype.draw_segment=function(s,i) {
    var t=this
    var dopt=t.document.options
    var opt=s.options
    var txt=text(s.target)
    if(opt.from!=dopt.from || opt.to!=dopt.to) txt=span_class("error",txt)
    var target=wrap_class("td","target",txt)
    function edit() { t.edit_translation(i) }
    target.onclick=edit
    return t.draw_segment_given_target(s,target)
}

Translator.prototype.draw_segment_given_target=function(s,target) {
    var t=this

    function draw_options2(o) {
	function change(el) {
	    o.method=el.value // side effect, updating the document in-place
	    t.update_translations()
	}
	var manual=o.method=="Manual"
	var autoB=radiobutton("method","Auto","Auto",change,!manual)
	var manualB=radiobutton("method","Manual","Manual",change,manual)
	return wrap("form",
		    [wrap("dt",autoB),
		     wrap("dt",manualB),
		     wrap("dt",draw_translation(o))])
    }

    function draw_options(o) {
	return wrap("div",[span_class("arrow",text(" ⇒ ")),
			   wrap("dl",draw_options2(o))])
    }

    return wrap_class("tr","segment",
		      [wrap_class("td","source",text(s.source)),
		       wrap_class("td","options",draw_options(s.options)),
		       target])
}

function empty_document() {
    return { name:"Unnamed",
	     options: {from:"Eng", to:"Swe", method:"Manual"},
	     segments:[] }
}

function new_segment(source) {
    return { source:source, target:"", options:{} } // leave options empty
}

function draw_translation(o) {
    return text("("+concname(o.from||"?")+" → "+concname(o.to||"?")+")")
}

/* --- Auxiliary functions -------------------------------------------------- */

function lang(code,name) { return { code:code, name:name} }
function lang1(name) {
    var ws=name.split("/");
    return ws.length==1 ? lang(name.substr(0,3),name) : lang(ws[0],ws[1]);
}
var languages =
    map(lang1,"Amharic Arabic Bulgarian Catalan Danish Dutch English Finnish French German Hindi Ina/Interlingua Italian Japanese Latin Norwegian Polish Ron/Romanian Russian Spanish Swedish Thai Turkish Urdu".split(" "));

var langname={};
for(var i in languages)
    langname[languages[i].code]=languages[i].name

function concname(code) { return langname[code] || code; }


function tr_local() {
    /*
    function dummy() {
	return {
	    get: function(name,def) { return def },
	    put: function(name,value) { }
	    ls: function() { return [] }
	}
    }
    */
    function real(storage) {
	var appPrefix="gf.translator."
	return {
	    get: function (name,def) {
		var id=appPrefix+name
		return storage[id] ? JSON.parse(storage[id]) : def;
	    },
	    put: function (name,value) {
		var id=appPrefix+name;
		storage[id]=JSON.stringify(value);
	    },
	    ls: function(prefix) {
		var pre=appPrefix+prefix
		var files=[]
		for(var i in storage)
		    if(hasPrefix(i,pre)) files.push(i.substr(pre.length))
		files.sort()
		return files
	    }
	}
    }
    return supports_html5_storage() ? real(localStorage) : real([])
}

// Collect alternative texts in the output from PGF service translate command
function collect_texts(ts) {
    var list=[]
    for(var i in ts)
	for(var j in ts[i].linearizations) {
	    var t=ts[i].linearizations[j].text
	    if(!elem(t,list)) list.push(t) // avoid duplicates
	}
    return list
}

function mapix(f,xs) {
    var ys=[];
    for(var i in xs) ys.push(f(xs[i],i))
    return ys;
}

/* --- DOM Support ---------------------------------------------------------- */

function a(url,linked) { return node("a",{href:url},linked); }
function li(xs) { return wrap("li",xs); }
function jsurl(js) { return "javascript:"+js; }

function replaceNode(node,ref) { ref.parentNode.replaceChild(node,ref) }

function radiobutton(name,value,label,change,checked) {
    var b=node("input",{type:"radio",name:name,value:value})
    if(change) b.onchange=function(event) { return change(event.target) }
    if(checked) b.checked=true
    return wrap("label",[b,text(label)])
}

function update_radiobutton(name,value) {
    var bs=document.forms.options[name]
    if(bs.length)
	for(var i in bs) if(bs[i].value==value) bs[i].checked=true
}

function submit(label) {
    return node("input",{type:"submit",value:label||"OK"})
}
