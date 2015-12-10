

/* --- Translator object ---------------------------------------------------- */

function Translator() {
    var t=this

    t.local=appLocalStorage("gf.translator.")
    t.view=element("document")
    t.filebox=element("filebox")
    if(!supports_html5_storage()) {
	var warning=span_class("error",text("It appears that localStorage is unsupported or disabled in this browser. Local documents will not be preserved after you leave or reload this page!"))
	insertAfter(warning,t.view)
    }
    if(!supports_local_files()) {
	var item=element("import_globalsight")
	if(item) item.style.display="none"
    }
    t.servers={}; //The API is stateful, use one pgf_online object per grammar
    t.grammar_info={};
    pgf_online({}).get_grammarlist(bind(t.extend_methods,t))

    function update_language_menu(t,id) {
	var dl=element(id);
	clear(dl);
	for(var i in languages) {
	    var l=languages[i]
	    dl.appendChild(dt(radiobutton(id,l.code,l.name,bind(t.change,t))))
	}
    }

    update_language_menu(t,"source")
    update_language_menu(t,"target")
    if(window.apertium) t.add_apertium()
    //initialize_sorting(["TR"],["segment"])
    t.document=empty_document();
    t.current=t.local.get("current")
    if(t.current && t.current!="/") {
	if(t.local.get("current_in_cloud")) t.open_from_cloud(t.current)
	else t.open(t.current)
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
	t.update_edit_menu()
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
	    pgf=t.servers[grammar]=pgf_online({grammar_list:[grammar]})
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

Translator.prototype.update_edit_menu=function() {
    var t=this
    function set_class(id,name) {
	var e=element(id)
	if(e) e.className=name
    }

    var able= t.document.globalsight ? "disabled" : ""
    set_class("edit_import",able)
    set_class("edit_add_segment",able)
    set_class("edit_remove_segment",able)
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
    function yes(code) { return true; }
    function no(code) { return false; }
    switch(o.method) {
    case "Manual":
	mark_menus(yes,yes)
	break;
    case "GFRobust":
	if(window.gftranslate) gftranslate.get_support(mark_menus)
	else mark_menus(no,no)
	break;
    case "Apertium":
	function ssupport(code) {
	    return apertium.isTranslatable(alangcode(code))
	}
	function tsupport(code) {
	  return apertium.isTranslatablePair(alangcode(o.from),alangcode(code))
	}
	if(window.apertium) mark_menus(ssupport,tsupport)
	else mark_menus(no,no)
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
	    ts[i].appendChild(qtext(segment.target))
	    ts[i].appendChild(text(" "))
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

	function upd3s(txt) { upd3([{quality:"error",text:txt}]) }

	function upd1(res) {
	    //console.log(translate_output)
	    if(res.translation) upd3([res.translation])
	    else upd3s("["+res.error.message+"]")
	}

	function upd0(source) { apertium.translate(source,afrom,ato,upd1) }

	if(!window.apertium)
	    upd3s("[Apertium is not available]")
	else if(apertium.isTranslatablePair(afrom,ato)) {
	    if(!eq_options(segment.options,o)) upd0(segment.source)
	}
	else
	    upd3s("[Apertium does not support "+show_translation(o)+"]")
    }
    function update_gfrobust_translation() {
	function upd3(trans,sp,qf) {
	    var ts=[]
	    for(var i=0;i<trans.length;i++) {
		var t=trans[i].linearizations[0].text
		if(sp.punct) t=t+sp.punct
		if(!elem(t,ts)) ts.push(t)
	    }
	    update_segment("GFRobust",ts.map(qf || trans_text_quality))
	}

	function upd3s(txt) {
	    update_segment("GFRobust",[{quality:"error",text:txt}])
	}

	function upd2b(trans,sp) {
	    function badq(txt) { return {quality:"bad_quality",text:txt} }
	    if(trans.length==0) upd3s("[no translation]")
	    else upd3(trans,sp,badq)
	}

	// upd0b :: {txt:String,punct:String} -> ()
	function upd0b(sp) {
	    function upd1b(translate_output) {
		//console.log(translate_output)
		upd2b(translate_output,sp)
	    }
	    gftranslate.wordforword(sp.txt,o.from,o.to,upd1b)
	}

	function upd2(trans,sp) {
	    if(trans.length==0) upd0b(sp) // upd3s("[no translation]")
	    else if(trans[0].error!=undefined)
		//upd3s("[GF robust translation problem: "+trans[0].error+"]")
		upd0b(sp)
	    else upd3(trans,sp)
	}
	// upd0 :: {txt:String,punct:String} -> ()
	function upd0(sp) {
	    function upd1(translate_output) {
		//console.log(translate_output)
		upd2(translate_output,sp)
	    }
	    gftranslate.translate(sp.txt,o.from,o.to,0,10,upd1)
	}
	if(!window.gftranslate)
		upd3s("[GF robust parser is not available]")
	else {
	    function check_support(ssupport,tsupport) {
		var fls=ssupport(o.from)
		var tls=tsupport(o.to)
		if(fls && tls) {
		    var want={from:o.from, to:o.to, method:"GFRobust"}
		    if(!eq_options(segment.options,want)) {
			//console.log("Updating "+i)
			//lexgfrobust(segment.source,upd0)
			upd0(rmpunct(segment.source))
		    }
		    //else console.log("No update ",want,segment.options)
		}
		else {
		    var fn=" from "+concname(o.from)
		    var tn=" to "+concname(o.to)
		    var msg="The GF robust translation service: not supported:"
		    if(!fls) msg+=fn+(tls ? "." : ", ")
		    if(!tls) msg+=tn+"."
		    upd3s("["+msg+"]")
		}
	    }
	    function no_support(text,status,ct) {
		upd3s("[GF Robust translation service error: "+status+"]")
	    }
	    gftranslate.get_support(check_support,no_support)
	}
    }

    function update_gf_translation(grammar,gfrom,gto) {
	var server=t.servers[grammar]
	function upd3(txts) { update_segment(grammar,txts) }
	function upd3s(txt) { upd3([{quality:"error",text:txt}]) }
	function upd2(ts) {
	    switch(ts.length) {
	    case 0: upd3s("[no translation]");break;
	    default:
		//mapc(unlextext,ts,upd3);
		upd3(ts)
		break;
	    }
	}
	function upd1(translate_output) {
	    //console.log(translate_output)
	    upd2(collect_texts(translate_output[0].translations))
	}
	function upd0(source) {
	    server.translate({from:gfrom,to:gto,lexer:"text",unlexer:"text",
			      input:source},upd1)
	}
	var fls=t.gf_supported(grammar,o.from)
	var tls=t.gf_supported(grammar,o.to)
	if(fls && tls) {
	    var want={from:o.from, to:o.to, method:grammar}
	    if(!eq_options(segment.options,want)) {
		//console.log("Updating "+i)
		//lextext(segment.source,upd0)
		upd0(segment.source)
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
	    upd3s("["+msg+"]")
	}
    }

    var m=segment_method(doc,ss[i])
    switch(m) {
    case "Manual":  /* Nothing to do */ break;
    case "Apertium": update_apertium_translation(); break;
    case "GFRobust": update_gfrobust_translation(); break;
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
    function ls(files,open,del) {
	var ul=empty_class("ul","files")
	for(var i in files) {
	    var name=files[i]
	    var link=a(jsurl(open+"('"+name+"')"),[text(name)])
	    ul.appendChild(li(deletable(del(name),link)))
	}
	return ul
    }
    function delete_local(name) {
	return function() {
	    if(confirm("Are you sure you want to delete the local document "+name+"?")) {
		t.local.remove("/"+name)
		browse();
	    }
	}
    }
    function delete_from_cloud(name) {
	return function() {
	    if(confirm("Are you sure you want to delete the cloud document "+name+"?")) {
		gfcloud("rm",{file:name+cloudext},browse)
	    }
	}
    }
    function browse() {
	var list=empty("div")
	clear(t.filebox)
	t.filebox.appendChild(list)
	list.appendChild(wrap("h2",text("Open...")))
	var files=t.local.ls("/")
	if(files.length>0) {
	    list.appendChild(wrap("h3",text("Local documents")))
	    list.appendChild(ls(files,"translator.open",delete_local))
	}
	function lscloud(result) {
	    var filenames=JSON.parse(result)
	    var files=map(strip_cloudext,filenames)
	    if(files.length>0) {
		list.appendChild(wrap("h3",[text("Documents in the cloud "),
					      img("../P/cloud.png")]))
		list.appendChild(ls(files,"translator.open_from_cloud",delete_from_cloud))
	    }
	}
	if(navigator.onLine) gfcloud("ls",{ext:cloudext},lscloud)
	/*
	t.current="/"
	t.local.put("current","/")
	*/
	
	t.filebox.appendChild(button("Cancel",function () { t.hide_filebox() }))
	t.show_filebox()
    }
    setTimeout(browse,100) // leave time to hide the menu first
}

Translator.prototype.open=function(name) {
    var t=this
    if(name) {
	var path="/"+name
	var document=t.local.get(path);
	if(document) t.load(name,document,false)
	else alert("No such document: "+name)
    }
}

Translator.prototype.show_filebox=function() {
    this.filebox.parentNode.style.display="block";
}

Translator.prototype.hide_filebox=function() {
    var t=this
    t.filebox.parentNode.style.display="";
    clear(t.filebox)
}

Translator.prototype.load=function(name,document,in_cloud) {
    var t=this
    t.current=name;
    t.current_in_cloud=in_cloud;
    t.local.put("current",name)
    t.local.put("current_in_cloud",in_cloud)
    t.document=document;
    t.hide_filebox();
    t.redraw();
}

Translator.prototype.open_from_cloud=function(name) {
    var t=this
    var filename=name+cloudext
    function ok(result) {
	var document=JSON.parse(result)
	if(document) t.load(name,document,true)
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
		function done() {
		    //t.local.remove(path)
		    t.local.put("current_in_cloud",true)
		    t.local.put("current",t.current)
		}
		save_in_cloud(t.current+cloudext,t.document,done)
	    }
	    else {
		t.local.put(path,t.document)
		t.local.put("current",t.current)
	    }
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
    var t=this
    if(t.document.globalsight) return
    hide_menu(el);
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
    var e=form({},[inp, submit(), button("Cancel",restore)])
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
    var t=this
    if(t.document.globalsight) return // disabled
    hide_menu(el);
    function imp() {
	function restore() {
	    t.redraw()
	}
	function done() {
	    function add_segments(text) {
	    	var ls=window.lines(text)
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
	var e=form({class:"import"},
		   [wrap("h3",text("Import text ("+lang+")")),
		    inp,
		    wrap("dl",[dt([punct,punctchars]),dt(lines),dt(paras)]),
		    submit(), button("Cancel",restore)])

	if(supports_local_files()) {
	    // Allow import from local files, if the browers supports it.
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

Translator.prototype.export_globalsight=function() {
    t=this

    /*
      Taken from this discussion on saving to local files:
      http://stackoverflow.com/questions/2897619/using-html5-javascript-to-generate-and-save-a-file
    */
    open("data:application/octet-stream,"
	 +encodeURIComponent(export_globalsight_download_file(t.document)),
	 t.document.name
	 /*,'toolbar=no,location=no,status=no'*/);

/*
  Also consider: FileSaver saveAs()

  Not directly support in browsers:
  http://www.w3.org/TR/file-writer-api/#the-filesaver-interface

  Alternative implementation: FileSaver.js:
  https://github.com/eligrey/FileSaver.js
  http://eligrey.com/blog/post/saving-generated-files-on-the-client-side
*/
}

Translator.prototype.import_globalsight=function(el) {
    hide_menu(el);
    var t=this
    function imp() {
	function done() {
	    function import_text(name,text) {
		var ls=lines(text)
		if(ls.length>0 && ls[0]=="# GlobalSight Download File") {
		    t.current=null;
		    t.local.put("current",null)
		    t.document=import_globalsight_download_file(ls)
		    t.current=t.document.name=name
		    t.hide_filebox();
		    t.redraw();
		}
		else alert("Not a GlobalSight Download File") // !! improve
	    }
	    function import_file(name,ev) { import_text(name,ev.target.result) }
	    if(files.files && files.files.length>0) {
		var file=files.files[0]
		var r=new FileReader()
		r.onload=function(ev) { import_file(file.name,ev); }
		r.readAsText(file)
	    }
	    return false
	}

	clear(t.filebox)
	t.filebox.appendChild(wrap("h2",text("Import")))
	function restore() { t.hide_filebox() }
	var cancel_button=button("Cancel",restore)
	if(supports_local_files()) {
	    // Allow import from local files, if the browers supports it.
	    var files=node("input",{name:"files","type":"file"})
	    var inp=wrap("p",wrap("label",[text("Choose a file: "),files]))
	    var e=form({class:"import"},
		       [wrap("h3",text("Import a GlobalSight Download File")),
			inp, submit(), cancel_button])
	    t.filebox.appendChild(e)
	    e.onsubmit=done
	}
	else {
	    t.filebox.appendChild(wrap("p",[text("Support for readling local files is missing in this browser.")]))
	    t.filebox.appendChild(cancel_button)
	}
	t.show_filebox();
    }
    setTimeout(imp,100) // leave time to hide the menu first
}

Translator.prototype.open_in_wc=function(el) {
    var t=this
    hide_menu(el)
    var doc=t.document
    var sourcetext=doc.segments.map(function(s){return s.source}).join(" ")
    var wc=appLocalStorage("gf.wc."+gftranslate.grammar+".")
    wc.put("from",doc.options.from)
    wc.put("to",doc.options.to)
    wc.put("input",sourcetext)
    var w=window.open("../wc.html","wc")
    w.focus()
}

Translator.prototype.remove=function(el) {
    var t=this
    if(t.document.globalsight) return
    hide_menu(el);
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
    var doc=t.document
    var s=doc.segments[i]

    function restore() { t.replace_segment(i,t.draw_segment(s,i)) }
    function change(str) {
	s.source=str // side effect, updating the document in-place
	restore();
	if(s.options.method!="Manual") {
	    s.options.to="" // hack to force an update
	    t.update_translation(i)
	}
    }
    function done() { change(inp.value); return false; }

    function goto_minibar() {
	function cont(grammar_info) {
	    var gname=grammar_info.name
	    var gfrom=gname+doc.options.from
	    var gto=gname+doc.options.to
	    var pgf_server=t.servers[grammarname]
	    function cont2(source) {
		function ok() {
		    function cont(input) { unlextext(input,change) }
		    minibar.get_current_input(cont)
		    t.hide_filebox()
		}
		function cancel() {
		    restore()
		    t.hide_filebox()
		}
		var minibar_options= {
		    startcat_menu: false,
		    random_button: false,
		    try_google: false,
		    show_abstract: true,
		    show_trees: true,
		    show_grouped_translations: false,
		    word_replacements: true,
		    default_source_language: "Eng",
		    initial_grammar: pgf_server.current_grammar_url,
		    initial:{from:gfrom,
			     startcat:grammar_info.startcat,
			     input:source.split(" ")},
		    initial_toLangs: [gfrom,gto]
		}
		clear(t.filebox)
		appendChildren(t.filebox,[empty_id("div","minibar"),
					  empty_id("div","syntax_editor")])
		var minibar=new Minibar(pgf_server,minibar_options)
		appendChildren(t.filebox,[button("OK",ok),
					  button("Cancel",cancel)])
		t.show_filebox()
	    }
	    lextext(s.source,cont2)

	}
	t.switch_grammar(grammarname,cont)
    }

    var inp=node("input",{name:"it",value:s.source})
    var e=form({},[inp, submit(), button("Cancel",restore),text(" ")])
    var grammarname=uses_gf(doc,s)
    if(grammarname) e.appendChild(button("Minibar",goto_minibar))
    replaceChildren(source,e)
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
	s.target={quality:"manual_quality",text:inp.value}
	         // side effect, updating the document in-place
	restore();
	return false;
    }

    var inp=node("input",{name:"it",value:qstring(s.target)})
    var e=form({},[inp, submit(), button("Cancel",restore)])
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
type Document = { name:String, options:DocOptions, segments:[Segment],
                  globalsight : GlobalSight|null }
type Segment = { source:String, target:QText, options:Options }
               & ( {} | { choices:[QText] } )
type QText = { quality:Quality, text:String }
             | String  // mostly for backward compatibility
type Quality = "default_quality" | "low_quality" | "high_quality" 
             | "manual_quality"
type DocOptions = Options & { view:View, cloud:Bool }
type Options = {from: Lang, to: Lang, method:Method}
type Lang = String // Eng, Swe, Ita, etc
type Method = "Manual" | "Apertium" | "GFRobust" | GFGrammarName
type View = "segmentbysegment" | "paralleltexts"
type GFGrammarName = String // e.g. "Foods.pgf"

type GlobalSight = { header: [String], segments:[[String]] }
*/

function eq_options(o1,o2) {
    return o1.method==o2.method && o1.from==o2.from && o1.to==o2.to
}

Translator.prototype.draw_document=function() {
    var t=this
    var doc=t.document
    var o=doc.options;
    function draw_globalsight() {
	function gs_export() { t.export_globalsight(); }
	return doc.globalsight
	    ? wrap("span",[text(" (from GlobalSight) "),
			   button("Export",gs_export)])
	    : text("")
    }
    var hdr=wrap("h2",[text(doc.name),text(" "),
		       wrap("small",[draw_translation(o),draw_globalsight()])])
    if(doc.options.cloud) insertFirst(hdr,img("../P/cloud.png"))
    switch(o.view || "segmentbysegment") {
    case "paralleltexts":
	function src(seg) { return seg.source }
	function trg(seg) { return seg.target }
	function fmt(txt,i) {
	    var sd=span_class("segment",[qtext(txt),text(" ")])
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
    var txt=qtext(s.target)
    if(opt.from!=dopt.from || opt.to!=dopt.to) txt=span_class("error",txt)
    var target=wrap_class("td","target",txt)
    function edit() { t.edit_translation(i) }
    function pick(txt) { t.pick_translation(i,txt) }
    target.onclick=edit
    if(s.choices) appendChildren(target,draw_choices(s.choices,pick))
    return t.draw_segment_given_target(s,target,i)
}

function qtext(t) {
    switch(typeof(t)) {
    case "string": return text(t)
    default: return span_class(t.quality||"",text(t.text))
    }
}

function qstring(t) {
    switch(typeof(t)) {
    case "string": return t
    default: return t.text
    }
}

function draw_choices(txts,onclick) {
    function opt(txt) { 
	var o=dt(qtext(txt))
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
	var gfrobustB=radiobutton("method","GFRobust","GF Wide Coverage Translation",change)
	var dl=wrap_class("dl","popupmenu",
			  [dt(autoB),
			   dt([manualB,text(" "),draw_translation(o)]),
			   dt(gfrobustB)])
	if(window.apertium) add_apertium_to_menu(dl,change)
	t.extend_methods_menu(dl,change)
	var form=wrap("form",dl)
	var d = s.use_default
	var m = d || d==null ? "Default" : o.method || "Default"
	update_radiobutton(form,"method",m)
	return form
    }
    function draw_options() {
	return wrap("div",[span_class("arrow",hovertext(" ⇒ ")),draw_options2()])
    }
    if(t.document.globalsight)
	var actions=empty_class("td","actions")
    else {
	var insertB=dt(text("Insert a new segment"))
	insertB.onclick=function() { t.insert_segment(i) }
	var removeB=dt(text("Remove this segment"))
	removeB.onclick=function() { t.remove_segment(i) }
	var actions=wrap_class("td","actions",
			       wrap("div",[span_class("actions",hovertext("◊")),
					   wrap_class("dl","popupmenu",
						      [insertB,removeB])]))
    }
    var txt=wrap("span",text(s.source))
    var source=wrap_class("td","source",txt)
    if(!t.document.globalsight)
	txt.onclick=function() { t.edit_source(source,i); }
    /*
    if(window.gftranslate && segment_method(t.document,s)=="GFRobust") {
	function add_button(src) {
	    var btn=img("../minibar/tree-btn.png")
	    btn.className="right"
	    btn.other=gftranslate.parsetree_url(src)
	    btn.title="Click to toggle parse tree view."
	    btn.onclick=function() { toggle_img(btn) }
	    source.appendChild(btn)
	}
	lexgfrobust(s.source,add_button)
    }
    */
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

// Return the name of the grammar if the segment uses GF for translation
function uses_gf(doc,segment) {
    var m= segment_method(doc,segment)
    return /\.pgf$/.test(m) ? m : null
}

// Return the translation method use by a segment
function segment_method(doc,segment) {
    var m= segment.options.method || doc.options.method
    var d=segment.use_default
    if(d || d==null) m=doc.options.method
    return m
}

/* -------------------------------------------------------------------------- */

function draw_translation(o) { return text(show_translation(o)) }

function show_translation(o) {
    return "("+concname(o.from||"?")+" → "+concname(o.to||"?")+")"
}

/* --- Auxiliary functions -------------------------------------------------- */

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
    var done=false;
    for(var i in old) {
	if(i==ix) { a.push(x); done=true; }
	a.push(old[i])
    }
    if(!done) a.push(x)
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

// Break a string into lines
function lines(text) {
    var ls=text.split("\r\n") // DOS
    if(ls.length<=1) ls=text.split(/\n|\r/) // Unix | Mac
    return ls
}

function supports_local_files() {
    // See http://www.html5rocks.com/en/tutorials/file/dndfiles/
    return window.File && window.FileList && window.FileReader
}

/* --- GlobalSight support -------------------------------------------------- */

function import_globalsight_download_file(ls) {
    var doc=empty_document()
    doc.globalsight={header:[],segments:[]}
    var i=0;

    // Scan header and pick up source & target locale
    for(;i<ls.length && ls[i][0]=="#";i++) {
	doc.globalsight.header.push(ls[i])
	var hdr=ls[i].split(":");
	if(hdr.length==2) {
	    function setlang(opt) {
		var code2=hdr[1].trim().split("_")[0] // pick en from en_UK
		var code3=langcode3[code2]
		if(code3) doc.options[opt]=code3;
		// Should notify the user about unsupported language codes!!
	    }
	    switch(hdr[0]) {
	    case "# Source Locale": setlang("from"); break;
	    case "# Target Locale": setlang("to");break;
	    }
	}
    }
    // skip blank lines
    for(;i<ls.length && ls[i].length==0;i++)
	doc.globalsight.header.push(ls[i])

    while(i<ls.length) {
	var seghdr=[]
	// skip segment header
	for(;i<ls.length && ls[i][0]=="#";i++) seghdr.push(ls[i])
	var seg=""
	// extract segment text
	for(;i<ls.length && ls[i][0]!="#";i++)
	    if(ls[i]!="") seg = seg=="" ? ls[i] : seg+" "+ls[i];
	if(seg!="") doc.segments.push(new_segment(seg.trim()))
	doc.globalsight.segments.push(seghdr)
    }
    return doc;
}

function export_globalsight_download_file(doc) {
    var ls=[].concat(doc.globalsight.header)

    var gs=doc.globalsight.segments
    var ss=doc.segments
    for(var i=0;i<gs.length && i<ss.length;i++)
	ls=ls.concat(gs[i],qstring(ss[i].target))

    ls.push("")
    ls.push("# END GlobalSight Download File")
    ls.push("")
    return ls.join("\n")
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

/*
// Like lextext, but separate punctuation from the end
function lexgfrobust(txt,cont) {
    function rmpunct(txt) {
	var ts=gf_lex(txt)
	var n=ts.length
	var punct=""
	if(n>0 && /[.?!]/.test(ts[n-1])) { punct=ts[n-1]; ts.pop()}
	cont(gf_unlex(ts),punct)
    }
    lextext(txt,rmpunct)
}
*/
// rmpunct :: String -> {txt:String,punct:String}
function rmpunct(txt) {
    function ispunct(c) {
	switch(c) {
	case ' ':
	case '\t':
	case '\n':
	case '.':
	case '?':
	case '!':
	    return true
	default:
	    return false
	}
    }
    var i=txt.length-1
    while(i>=0 && ispunct(txt[i])) i--
    i++
    return {txt:txt.substr(0,i),punct:txt.substr(i)}
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

function form(attrs,fields) { return node("form",attrs,fields) }

function submit(label) {
    return node("input",{type:"submit",value:label||"OK"})
}


function deletable(del,el,hint) {
    var b=delete_button(del,hint)
    return node("span",{"class":"deletable"},[b,el])
}

function delete_button(action,hint) {
    var b=node("span",{"class":"delete",title:hint || "Delete"},[text("×")])
    b.onclick=action;
    return b;
}

function hovertext(txt) {
    return node("span",{onclick:""},[text(txt)])
}
