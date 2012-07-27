

/* --- Translator object ---------------------------------------------------- */

function Translator() {
    var t=this
    t.local=tr_local();
    t.view=element("document")
    if(!supports_html5_storage()) {
	var warning=span_class("error",text("It appears that localStorage is unsupported or disabled in this browser. Documents will not be preserved after you leave or reload this page!"))
	insertAfter(warning,t.view)
    }
    t.current=t.local.get("current")
    t.document=t.current && t.current!="/" && t.local.get("/"+t.current) || empty_document()
    t.servers={}; //The API is stateful, use one pgf_online object per grammar
    t.grammar_info={};
    pgf_online({}).get_grammarlist(bind(t.extend_methods,t))
    update_language_menu(t,"source")
    update_language_menu(t,"target")
    if(apertium) t.add_apertium()
    //initialize_sorting(["TR"],["segment"])
    t.redraw();
}

function update_language_menu(t,id) {
    var dl=element(id);
    clear(dl);
    for(var i in languages) {
	var l=languages[i]
	dl.appendChild(dt(radiobutton(id,l.code,l.name,bind(t.change,t))))
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
	var form=document.forms.options
	update_radiobutton(form,"method",o.method)
	update_radiobutton(form,"source",o.from)
	update_radiobutton(form,"target",o.to)
	update_radiobutton(form,"view",o.view || "segmentbysegment")
	update_checkbox("cloud",o.cloud  || false)
	t.update_language_menus()
	t.update_translations()
    }
}

Translator.prototype.switch_grammar=function(grammar,cont) {
    var t=this
    var gi=t.grammar_info[grammar]
    if(gi) cont(gi)
    else {
	var pgf=t.servers[grammar]
	if(pgf) pgf.waiting.push(cont)
	else {
	    pgf=t.servers[grammar]=pgf_online({})
	    pgf.waiting=[cont]
	    function cont2(gr_info) {
		t.grammar_info[grammar]=gr_info
		//console.log("Passing grammar info for "+grammar+" to "+pgf.waiting.length+" clients")
		while(pgf.waiting.length>0) pgf.waiting.pop()(gr_info)
	    }
	    function cont1() { pgf.grammar_info(cont2)}
	    pgf.switch_grammar(grammar,cont1)
	}
    }
}

Translator.prototype.update_language_menus=function() {
    var t=this
    var o=t.document.options
    var method=o.method+(o.method=="Apertium"?"/"+o.from:"")
    if(t.menus_for==method) return;
    t.menus_for=method
    function mark_menu(name,supported) {
	var menu=document.forms.options[name]
	for(var i=0;i<menu.length;i++)
	    menu[i].parentNode.parentNode.className=
	      (supported(menu[i].value)?"":"un")+"supported"
    }
    function mark_menus(ssupport,tsupport) {
	mark_menu("source",ssupport)
	mark_menu("target",tsupport)
    }
    switch(o.method) {
    case "Manual":
	function yes(code) { return true; }
	mark_menus(yes,yes)
	break;
    case "Apertium":
	function ssupport(code) {
	    return apertium.isTranslatable(alangcode(code))
	}
	function tsupport(code) {
	  return apertium.isTranslatablePair(alangcode(o.from),alangcode(code))
	}
	mark_menus(ssupport,tsupport)
	break;
    default: // GF
	function cont() {
	    function gfsupport(code) { return t.gf_supported(o.method,code) }
	    mark_menus(gfsupport,gfsupport)
	}
	t.switch_grammar(o.method,cont)
    }
}

Translator.prototype.gf_supported=function(grammar,langcode) {
    var t=this;
    var concname=t.grammar_info[grammar].name+langcode
    var l=t.grammar_info[grammar].languages
    for(var i in l) if(l[i].name==concname) return true
    return false
}

Translator.prototype.update_translations=function() {
    var t=this
    for(var i in t.document.segments) t.update_translation(i)
}

Translator.prototype.update_translation=function(i) {
    var t=this
    var doc=t.document
    var o=doc.options
    var ss=doc.segments
    var ds=t.drawing.segments
    var ts=t.drawing.targets
    var segment=ss[i]

    function draw_update() {
	if(ds) {
	    var sd=t.draw_segment(segment,i)
	    var old=ds[i]
	    ds[i]=sd
	    replaceNode(sd,old)
	}
	else if(ts) {
	    clear(ts[i])
	    ts[i].appendChild(text(segment.target+" "))
	}
    }
    function update_segment(m,txts) {
	segment.target=txts[0];
	segment.options={method:m,from:o.from,to:o.to} // no sharing!
	if(txts.length>1) segment.choices=txts
	else delete segment.choices
	draw_update()
    }
    function update_apertium_translation() {
	var afrom=alangcode(o.from), ato=alangcode(o.to)

	function upd3(txts) { update_segment("Apertium",txts) }

	function upd1(res) {
	    //console.log(translate_output)
	    if(res.translation) upd3([res.translation])
	    else upd3(["["+res.error.message+"]"])
	}

	function upd0(source) { apertium.translate(source,afrom,ato,upd1) }

	if(apertium.isTranslatablePair(afrom,ato)) {
	    if(!eq_options(segment.options,o)) upd0(segment.source)
	}
	else
	    upd3(["[Apertium does not support "+show_translation(o)+"]"])
    }

    function update_gf_translation(grammar,gfrom,gto) {
	var server=t.servers[grammar]
	function upd3(txts) { update_segment(grammar,txts) }
	function upd2(ts) {
	    function unlex(txt,cont) { gfshell('ps -unlextext "'+txt+'"',cont) }

	    switch(ts.length) {
	    case 0: upd3(["[no translation]"]);break;
	    default: mapc(unlex,ts,upd3); break;
	    }
	}
	function upd1(translate_output) {
	    //console.log(translate_output)
	    upd2(collect_texts(translate_output[0].translations))
	}
	function upd0(source) {
	    server.translate({from:gfrom,to:gto,input:source},upd1)
	}
	var fls=t.gf_supported(grammar,o.from)
	var tls=t.gf_supported(grammar,o.to)
	if(fls && tls) {
	    var want={from:o.from, to:o.to, method:grammar}
	    if(!eq_options(segment.options,want)) {
		//console.log("Updating "+i)
		gfshell('ps -lextext "'+segment.source+'"',upd0)
	    }
	    //else console.log("No update ",want,segment.options)
	}
	else {
	    var fn=concname(o.from)
	    var tn=concname(o.to)
	    var sup="supported by the grammar"
	    var isnot=" is not "+sup
	    var is=" is "+sup
	    var msg= fls ? tn+isnot : tls ? fn+isnot :
		      "Neither "+fn+" nor "+tn+is
	    upd3(["["+msg+"]"])
	}
    }

    var m= ss[i].options.method || doc.options.method
    var d=ss[i].use_default
    if(d || d==null) m=doc.options.method
    switch(m) {
    case "Manual":  /* Nothing to do */ break;
    case "Apertium": update_apertium_translation(); break;
    default: // GF
	function upd00(grammar_info) {
	    var gname=grammar_info.name
	    var gfrom=gname+o.from, gto=gname+o.to
	    update_gf_translation(m,gfrom,gto)
	}
	t.switch_grammar(m,upd00)
    }
}

Translator.prototype.add_apertium=function() {
    var dl=element("methods")
    if(dl) add_apertium_to_menu(dl,bind(this.change,this))
}

function add_apertium_to_menu(dl,action) {
    dl.appendChild(dt(radiobutton("method","Apertium","Apertium",action)))
}

Translator.prototype.extend_methods=function(grammars) {
    this.grammars=grammars
    var dl=element("methods")
    if(dl) this.extend_methods_menu(dl,bind(this.change,this))
    update_radiobutton(document.forms.options,"method",this.document.options.method)
    this.redraw()
}

Translator.prototype.extend_methods_menu=function(dl,action) {
    var grammars=this.grammars
    if(dl) for(var i in grammars) {
	dl.appendChild(dt(radiobutton("method",grammars[i],
				      "GF: "+grammars[i],
				      action)))
    }
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
    function update_checkbox(field) {
	if(el.checked!=o[field]) {
	    o[field]=el.checked
	    t.redraw()
	}
    }
    switch(el.name) {
    case "method": update("method"); break;
    case "source": update("from"); break;
    case "target": update("to"); break;
    case "view"  : update("view"); break;
    case "cloud" : update_checkbox("cloud"); break;
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
    function ls(files,op) {
	var ul=empty_class("ul","files")
	for(var i in files) {
	    var name=files[i]
	    var link=a(jsurl(op+"('"+name+"')"),[text(name)])
	    ul.appendChild(li(link))
	}
	return ul
    }
    function browse() {
	clear(t.view)
	t.view.appendChild(wrap("h2",text("Your translator documents")))
	var files=t.local.ls("/")
	if(files.length>0) {
	    t.view.appendChild(wrap("h3",text("Local documents")))
	    t.view.appendChild(ls(files,"translator.open"))
	}
	function lscloud(result) {
	    var filenames=JSON.parse(result)
	    var files=map(strip_cloudext,filenames)
	    if(files.length>0) {
		t.view.appendChild(wrap("h3",text("Documents in the cloud")))
		t.view.appendChild(ls(files,"translator.open_from_cloud"))
	    }
	}
	if(navigator.onLine) gfcloud("ls",{ext:cloudext},lscloud)
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
	if(document) t.load(name,document)
	else alert("No such document: "+name)
    }
}

Translator.prototype.load=function(name,document) {
    var t=this
    t.current=name;
    t.local.put("current",name)
    t.document=document;
    t.redraw();
}

Translator.prototype.open_from_cloud=function(name) {
    var t=this
    var filename=name+cloudext
    function ok(result) {
	var document=JSON.parse(result)
	if(document) t.load(name,document)
    }
    gfcloud("download",{file:encodeURIComponent(filename)},ok);
}

Translator.prototype.save=function(el) {
    var t=this
    hide_menu(el);
    if(t.current!="/") {
	if(t.current) {
	    var path="/"+t.current
	    if(t.document.options.cloud) {
		function done() { /*t.local.remove(path)*/ }
		save_in_cloud(t.current+cloudext,t.document,done)
	    }
	    else
		t.local.put(path,t.document)
	}
	else t.saveAs()
    }
}

Translator.prototype.saveAs=function(el) {
    var t=this
    hide_menu(el);
    if(t.current!="/") {
	var name=prompt("File name?")
	if(name) {
	    t.current=t.document.name=name;
	    t.local.put("current",name)
	    t.save();
	    t.redraw();
	}
    }
}

Translator.prototype.close=function(el) {
    hide_menu(el);
    this.browse();
}
/*
Translator.prototype.add_segment1=function(el) {
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
*/
Translator.prototype.add_segment=function(el) {
    hide_menu(el);
    var t=this
    function imp() {
	var n=t.document.segments.length
	t.insert_segment(n)
    }
    if(t.current!="/") setTimeout(imp,100)
}

Translator.prototype.insert_segment=function(i) {
    var t=this
    function restore() {
	t.redraw()
    }
    function done() {
	var text=inp.value
	if(text) {
	    var newseg=new_segment(text)
	    t.document.segments=insert_ix(t.document.segments,i,newseg)
	}
	restore()
	return false
    }
    var inp=node("input",{name:"it",value:""})
    var e=wrap("form",[inp, submit(), button("Cancel",restore)])
    var source=wrap_class("td","source",e)
    var edit=wrap_class("tr","segment",[td([]),source])
    
    var ss=t.drawing.segments
    var n=ss ? ss.length : 0
    if(n>0) {
	if(i==0) insertBefore(edit,ss[0])
	else insertAfter(edit,ss[i-1])
    }
    else t.view.appendChild(wrap_class("table","segments",edit))
    
    e.onsubmit=done
    inp.focus();
}

Translator.prototype.import=function(el) {
    hide_menu(el);
    var t=this
    function imp() {
	function restore() {
	    t.redraw()
	}
	function done() {
	    function add_segments(text) {
	    	var ls=text.split("\n")
		var segs= punct.firstChild.checked 
	            ? split_punct(text,punctchars.value)
		    : paras.firstChild.checked 
		    ? join_paragraphs(ls)
		    : ls
		for(var i in segs)
		    t.document.segments.push(new_segment(segs[i]))
	    }
	    function import_text(text2) {
		var text=inp.value
		add_segments(text2)
		add_segments(text)
		restore()
	    }
	    function import_file(ev) { import_text(ev.target.result) }
	    if(files.files && files.files.length>0) {
		var file=files.files[0]
		var r=new FileReader()
		r.onload=import_file
		r.readAsText(file)
	    }
	    else import_text("")
	    return false
	}
	var inp=node("textarea",{name:"it",value:"",rows:"10"})
	var punct=radiobutton("separator","punct",
			      "Punctuation indicates where segments end: ",null,true)
	var lines=radiobutton("separator","lines",
			      "Segments are separated by line breaks",null,false)
	var paras=radiobutton("separator","paras",
			      "Segments are separated by blank lines",null,false)
	var punctchars=node("input",{name:"punctchars",value:".?!",size:"5"})
	var lang=concname(t.document.options.from)
	var e=node("form",{class:"import"},
		   [wrap("h3",text("Import text ("+lang+")")),
		    inp,
		    wrap("dl",[dt([punct,punctchars]),dt(lines),dt(paras)]),
		    submit(), button("Cancel",restore)])

	if(window.File && window.FileList && window.FileReader) {
	    // Allow import from local files, if the browers supports it.
	    // See http://www.html5rocks.com/en/tutorials/file/dndfiles/
	    var files=node("input",{name:"files","type":"file"})
	    var extra=wrap("label",[text("Choose a file: "),
				   files,
				   text(" and/or enter text to import below.")])
	    e.insertBefore(extra,inp)
	}
	t.view.appendChild(e)
	e.onsubmit=done
	inp.focus();
    }
    if(t.current!="/") setTimeout(imp,100)
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
    if(t.current!="/") setTimeout(rm,100)
}

Translator.prototype.remove_segment=function(i) {
    var t=this
    if(t.document && t.document.segments.length>i) {
	t.document.segments=delete_ix(t.document.segments,i)
	t.redraw();
    }
}

Translator.prototype.replace_segment=function(i,sd) {
    var t=this;
    var ds=t.drawing.segments;

    if(ds) {
	var old=ds[i]
	ds[i]=sd
	replaceNode(sd,old)
    }
}

Translator.prototype.pick_translation=function(i,txt) {
    var t=this
    var s=t.document.segments[i]
    set_manual(s)
    s.target=txt // side effect, updating the document in-place
    t.replace_segment(i,t.draw_segment(s,i))
}

Translator.prototype.edit_source=function(source,i) {
    var t=this
    var s=t.document.segments[i]

    function restore() { t.replace_segment(i,t.draw_segment(s,i)) }
    function done() {
	s.source=inp.value // side effect, updating the document in-place
	restore();
	if(s.options.method!="Manual") {
	    s.options.to="" // hack to force an update
	    t.update_translation(i)
	}
	return false;
    }

    var inp=node("input",{name:"it",value:s.source})
    var e=wrap("form",[inp, submit(), button("Cancel",restore)])
    clear(source)
    source.appendChild(e)
    e.onsubmit=done
    inp.focus()
}

Translator.prototype.edit_translation=function(i) {
    var t=this
    var s=t.document.segments[i]
 
    function restore() { t.replace_segment(i,t.draw_segment(s,i)) }
    function done() {
	set_manual(s)
	s.options.from=t.document.options.from
	s.options.to=t.document.options.to
	s.target=inp.value // side effect, updating the document in-place
	restore();
	return false;
    }

    var inp=node("input",{name:"it",value:s.target})
    var e=wrap("form",[inp, submit(), button("Cancel",restore)])
    var target=wrap_class("td","target",e)
    var edit=t.draw_segment_given_target(s,target,i)
    t.replace_segment(i,edit)
    e.onsubmit=done
    inp.focus();
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
type Document = { name:String, options:DocOptions, segments:[Segment] }
type Segment = { source:String, target:String, options:Options }
type DocOptions = Options & { view:View }
type Options = {from: Lang, to: Lang, method:Method}
type Lang = String // Eng, Swe, Ita, etc
type Method = "Manual" | "Apertium" | GFGrammarName
type View = "segmentbysegment" | "paralleltexts"
type GFGrammarName = String // e.g. "Foods.pgf"
*/

function eq_options(o1,o2) {
    return o1.method==o2.method && o1.from==o2.from && o1.to==o2.to
}

Translator.prototype.draw_document=function() {
    var t=this
    var doc=t.document
    var o=doc.options;
    var hdr=wrap("h2",[text(doc.name),text(" "),
		       wrap("small",draw_translation(o))])
    switch(o.view || "segmentbysegment") {
    case "paralleltexts":
	function src(seg) { return seg.source }
	function trg(seg) { return seg.target }
	function fmt(txt,i) {
	    var sd=span_class("segment",text(txt+" "))
	    function setclass(cls) {
		return function() {
		    targets[i].className=sources[i].className=cls
		}
	    }
	    sd.onmouseover=setclass("current_segment")
	    sd.onmouseout=setclass("segment")
	    return sd
	}
	var sources=mapix(fmt,map(src,doc.segments))
	var targets=mapix(fmt,map(trg,doc.segments))
	var drawing=[hdr,wrap_class("table","paralleltexts",
				    tr([wrap_class("td","source",sources),
					wrap_class("td","target",targets)]))]
	return {doc:drawing,sources:sources,targets:targets}
    default:
	var segments=mapix(bind(t.draw_segment,t),doc.segments)
	var drawing=[hdr,wrap_class("table","segments",segments)]
	return {doc:drawing,segments:segments}
    }
}

Translator.prototype.draw_segment=function(s,i) {
    var t=this
    var dopt=t.document.options
    var opt=s.options
    var txt=text(s.target)
    if(opt.from!=dopt.from || opt.to!=dopt.to) txt=span_class("error",txt)
    var target=wrap_class("td","target",txt)
    function edit() { t.edit_translation(i) }
    function pick(txt) { t.pick_translation(i,txt) }
    target.onclick=edit
    if(s.choices) appendChildren(target,draw_choices(s.choices,pick))
    return t.draw_segment_given_target(s,target,i)
}

function draw_choices(txts,onclick) {
    function opt(txt) { 
	var o=dt(text(txt))
	o.onclick=function(ev) { ev.stopPropagation(); onclick(txt) }
	return o
    }
    return [span_class("choices",text("+")),
	    wrap_class("dl","popupmenu",map(opt,txts))]
}

Translator.prototype.draw_segment_given_target=function(s,target,i) {
    var t=this

    function draw_options2() {
	var o=s.options
	function change(el) {
	    s.use_default = el.value=="Default"
	    var m = s.use_default ? t.document.options.method : el.value
	    if(m!=o.method) {
		o.method=m // side effect, updating the document in-place
		o.to="" // hack to force an update
		//console.log("Method changed to "+m)
		t.update_translation(i)
	    }
	}
	var autoB=radiobutton("method","Default","Default",change)
	var manualB=radiobutton("method","Manual","Manual",change)
	var dl=wrap_class("dl","popupmenu",
			  [dt(autoB),
			   dt([manualB,text(" "),draw_translation(o)])])
	if(apertium) add_apertium_to_menu(dl,change)
	t.extend_methods_menu(dl,change)
	var form=wrap("form",dl)
	var d = s.use_default
	var m = d || d==null ? "Default" : o.method || "Default"
	update_radiobutton(form,"method",m)
	return form
    }
    function draw_options() {
	return wrap("div",[span_class("arrow",text(" ⇒ ")),draw_options2()])
    }

    var insertB=dt(text("Insert a new segment"))
    insertB.onclick=function() { t.insert_segment(i) }
    var removeB=dt(text("Remove this segment"))
    removeB.onclick=function() { t.remove_segment(i) }
    var actions=wrap_class("td","actions",
			   wrap("div",[span_class("actions",text("◊")),
				       wrap_class("dl","popupmenu",
						  [insertB,removeB])]))
    var source=wrap_class("td","source",text(s.source))
    source.onclick=function() { t.edit_source(source,i); }
    var options=wrap_class("td","options",draw_options())

    return node("tr",{"class":"segment",id:i},[actions,source,options,target])
}

/* --- Document constructor ------------------------------------------------- */

function empty_document() {
    return { name:"Unnamed",
	     options: {from:"Eng", to:"Swe", method:"Manual"},
	     segments:[] }
}

/* --- Segments ------------------------------------------------------------- */

function new_segment(source) {
    return { source:source, target:"", options:{} } // leave options empty
}

function set_manual(segment) {
    segment.options.method="Manual"
    segment.use_default=false
}

/* -------------------------------------------------------------------------- */

function draw_translation(o) { return text(show_translation(o)) }

function show_translation(o) {
    return "("+concname(o.from||"?")+" → "+concname(o.to||"?")+")"
}

/* --- Auxiliary functions -------------------------------------------------- */

function lang(code,name,code2) { return {code:code, name:name, code2:code2} }
function lang1(namecode2) {
    var nc=namecode2.split(":");
    var name=nc[0]
    var ws=name.split("/");
    var code2=nc.length>1 ? nc[1] : ""
    return ws.length==1 ? lang(name.substr(0,3),name,code2)
	                : lang(ws[0],ws[1],code2);
}

var languages = // [ISO-639-2 code "/"] language name ":" ISO 639-1 code
    map(lang1,"Amharic:am Arabic:ar Bulgarian:bg Catalan:ca Danish:da Dutch:nl English:en Finnish:fi French:fr German:de Hindi:hi Ina/Interlingua:ia Italian:it Jpn/Japanese:ja Latin:la Norwegian:nb Polish:pl Ron/Romanian:ro Russian:ru Spanish:es Swedish:sv Thai:th Turkish:tr Urdu:ur".split(" "));

var langname={};
var langcode2={}
for(var i in languages) {
    langname[languages[i].code]=languages[i].name
    langcode2[languages[i].code]=languages[i].code2
}
function concname(code) { return langname[code] || code; }
function alangcode(code) { return langcode2[code] || code; }

function tr_local() {
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
	    remove: function(name) {
		var id=appPrefix+name;
		delete storage[id]
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

function delete_ix(old,ix) {
    var a=[];
    for(var i in old) if(i!=ix) a.push(old[i]);
    return a;
}

function insert_ix(old,ix,x) {
    var a=[];
    for(var i in old) {
	if(i==ix) a.push(x);
	a.push(old[i])
    }
    return a;
}

// Convert array of lines to array of paragraphs
function join_paragraphs(lines) {
    var paras=[]
    var current="";
    for(var i in lines)
	if(lines[i]=="") paras.push(current),current=""
	else current+=" "+lines[i]
    if(current) paras.push(current)
    return paras
}

function split_punct(text,punct) {
    var ss=text.split(new RegExp("(["+punct+"])"))
    var segs=[];
    for(var i=0;i<ss.length;i+=2) segs.push((ss[i]+(ss[i+1]||"")).trim())
    if(segs.length>0 && segs[segs.length-1]=="") segs.pop();
    return segs
}

/* --- Cloud Support -------------------------------------------------------- */


var cloudext=".gfstdoc"
function strip_cloudext(s) { return s.substr(0,s.length-cloudext.length) }

function save_in_cloud(filename,document,cont) {
    function save(dir) {
	var form={dir:dir}
	form[filename]=JSON.stringify(document);
	ajax_http_post("/cloud","command=upload"+encodeArgs(form),cont)
    }
    with_dir(save)
}


/* --- DOM Support ---------------------------------------------------------- */

function a(url,linked) { return node("a",{href:url},linked); }
function jsurl(js) { return "javascript:"+js; }

function replaceNode(node,ref) { ref.parentNode.replaceChild(node,ref) }

function radiobutton(name,value,label,change,checked) {
    var b=node("input",{type:"radio",name:name,value:value})
    if(change) b.onchange=function(event) { return change(event.target) }
    if(checked) b.checked=true
    return wrap("label",[b,text(label)])
}

function update_radiobutton(form,name,value) {
    var bs=form[name]
    if(bs.length)
	for(var i in bs) if(bs[i].value==value) bs[i].checked=true
}

function update_checkbox(name,checked) {
    document.forms.options[name].checked=checked
}

function submit(label) {
    return node("input",{type:"submit",value:label||"OK"})
}
