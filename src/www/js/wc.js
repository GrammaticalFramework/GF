
/* --- Wide Coverage Translation Demo web app ------------------------------- */

var wc={}
wc.selected_cnls=[] // list of grammar names
wc.cnls={} // maps grammars names to {pgf_online:...,grammar_info:{...}}
wc.f=document.forms[0]
wc.o=element("output")
wc.e=element("extra")
wc.i=element("grammarinfo")
wc.p=element("pick")
wc.grammarbox=element("grammarbox")
wc.os=[] /* output segment list
	    [{input,text:String; from,to::Lang;
	      target:Node;
	      rs::[TranslationResults];
	      current_pick::Int // index into rs or -1
	     }] */
wc.cache={} // output segment cache, indexed by source text
wc.translating=""

wc.delayed_translate=function() {
    function restart(){
	if(wc.f.input.value!=wc.translating) wc.translate()
	var h=wc.f.input.scrollHeight,bh=document.body.clientHeight
	if(h>bh) h=bh
	if(wc.f.input.clientHeight<h) wc.f.input.style.height=h+15+"px"
    }
    if(wc.timer) clearTimeout(wc.timer);
    wc.timer=setTimeout(restart,500)
}

wc.clear=function() {
    wc.f.input.value=""
    wc.f.input.style.height=""
    clear(wc.o)
    wc.delayed_translate()
}

wc.save=function() {
    if(wc.local) {
	var f=wc.f
	wc.local.put("from",f.from.value)
	wc.local.put("to",f.to.value)
	wc.local.put("input",f.input.value)
	wc.local.put("colors",f.colors.checked)
	wc.local.put("cnls",wc.selected_cnls)
    }
}

wc.load=function() {
    if(wc.local) {
	var f=wc.f
	f.input.value=wc.local.get("input",f.input.value)
	f.from.value=wc.local.get("from",f.from.value)
	f.to.value=wc.local.get("to",f.to.value)
	f.colors.checked=wc.local.get("colors",f.colors.checked)
	wc.selected_cnls=wc.local.get("cnls",wc.selected_cnls)
	wc.colors()
	wc.delayed_translate()
    }
}

wc.translate=function() {
    var f=wc.f, e=wc.e, p=wc.p

    /*
    function disable(yes) {
	f.translate.disabled=yes
	f.to.disabled=yes
	if(f.swap) f.swap.disabled=yes
    }
    */

    function split_punct(s) {
	return s.split(/([.!?]+[ \t\n]+|\n\n+|[ \t\n]*[-•*+#]+[ \t\n]+)/)
    }

    function find_pick(rs) {
	for(var i=0;i<rs.length && !rs[i].t;i++)
	    ;
	return i
    }

    function translate_segment(so) { // so = segment output
	so.rs=[] // list of alternative translations for this segment
	so.current_pick= -1 // index of currently selected alternative

	function show_error(msg) {
	    //if(e) e.innerHTML="<span class=low_quality>Translation problem: "+msg+"</span>"
	    //else
	    {
		replaceChildren(so.target,text("["+msg+"]"))
		so.target.className="error"
	    }
	    //disable(false)
	}
	function show_pick(i) { return function() { show_trans(i); return false; } }
	function show_picks() {
	    clear(p)
	    for(var i=0;i<so.rs.length;i++) {
		if(so.rs[i].t) {
		    var pick=text(i+1) // +"⃝"
		    if(i!=so.current_pick) {
			var pick=node("a",{href:"#"},[pick])
			pick.onclick=pick.onmouseover=show_pick(i)
		    }
		    var q=so.rs[i].t.quality
		    p.appendChild(text(" "))
		    p.appendChild(span_class("pick "+q,pick))
		}
	    }
	    if(!so.got_more) p.appendChild(text("..."))
	    /*
	    p.appendChild(wrap_class("small","pick",
				     node("a",{href:wc.google_translate_url(),
					       target:"google_translate"},
					  [text("Google Translate")])))
	    */
	}
	function treetext(tree) {
	    function inflect(w,wcls) {
		function show_inflections(lins) {
		    if(wc.e2) wc.e2.innerHTML=lins[0].text
		}
		function get_inflections() {
		    var tree="MkDocument+%22%22+(Inflection"+wcls+"+"+w+")+%22%22"
		    var l=gftranslate.grammar+f.to.value
		    gftranslate.call("?command=c-linearize&to="+l+"&tree="+tree,show_inflections)
		}
		var wn=wrap_class("span","inflect",text(w))
		if(wc.e2) wn.onclick=get_inflections
		return wn
	    }
	    function word(w) {
		var ps=w.split("_")
		var n=ps.length
		return ps.length>1 && elem(ps[n-1],gftranslate.documented_classes)
		        ? inflect(w,ps[n-1]) : text(w)
	    }
	    return tree.split(/([ ()]+)/).map(word)
	}
	function show_more() {
	    wc.selected=so
	    var r=so.rs[so.current_pick]
	    var prob=r.prob<=0 ? "" : r.prob || ""
	    if(e) {
		clear(e)
		var speak_from=speech_buttons(so.from,"",so.input)
		var speak_to=speech_buttons(so.to,"",so.text)
		speak_to.className=speak_from.className="speech_buttons"
		e.appendChild(wrap("div",[speak_from,
					  text(so.input+" → "+so.text),
					  speak_to]))
		e.appendChild(wrap("div",text(prob)))
		if(r.tree) {
		    wc.e2=node("div",{id:"tree-container","class":"e2"})
		    e.appendChild(wrap("span",treetext(r.tree)))
		    /*
		    var g=gftranslate.jsonurl
		    var u="format=svg&tree="+encodeURIComponent(r.tree)
		    var from="&from="+r.grammar+f.to.value
		    r.imgurls=[g+"?command=c-abstrtree&"+u,
			       g+"?command=c-parsetree&"+u+from]
		    if(!r.img) {
			r.img=node("img",{src:r.imgurls[0]},[])
			r.img_ix=0
			r.img.onclick=function() {
			    r.img_ix=1-r.img_ix
			    r.img.src=r.imgurls[r.img_ix]
			}
		    }
		    else if(r.img.src!=r.imgurls[r.img_ix]) // language change?
			r.img.src=r.imgurls[r.img_ix]
		    wc.e2.appendChild(r.img)
		    */
		    e.appendChild(wc.e2)
		    if(window.d3 && window.d3Tree) window.d3Tree(wc.bracketsToD3(r.jsontree))
		}
	    }
	    if(wc.p /*&& so.rs.length>1*/) show_picks()
	    //if(f.speak.checked) wc.speak(t.text,f.to.value)
	    if(!so.got_more) {
		so.got_more=true
		if(so.rs.length<10)
		    trans(so.input,so.rs.length,10-so.rs.length)
	    }
	}
	so.target.onclick=show_more

	function show_trans(i) {
	    var r=so.rs[i]
	    if(!r.t) {
		i=find_pick(so.rs)
		r=so.rs[i]
	    }
	    if(r && r.t) {
		replaceChildren(so.target,text(r.t.text))
		so.text=r.t.text
		so.target.className=r.t.quality
		so.current_pick=i
		if(wc.selected==so) show_more()
	    }
	}
	function showit(r,grammar) {
	    r.grammar=grammar
	    r.t=trans_quality(r,grammar+f.to.value)
	    so.rs.push(r)
	    var j=so.rs.length-1
	    if(so.current_pick<0 || so.current_pick==j) show_trans(j)
	    else if(wc.selected==so) show_picks()
	    //disable(false)
	}

	function word_for_word(text,cont) {
	    function step3(tra) {
		if(tra.length>=1) {
		    var r=tra[0]
		    r.prob = -1
		    if(r.linearizations) showit(r,gftranslate.grammar)
		    else if(r.error!=undefined)
			show_error(r.error)
		}
		else if(so.rs.length==0)
		    show_error("Unable to translate")
	    }
	    gftranslate.wordforword(text,f.from.value,wc.languages || f.to.value,step3)
	}

	function trans(text,i,count) {
	    function step3(tra) {
		if(tra.length>=1) {
		    var r=tra[0]
		    if(r.error!=undefined) {
			if(i==0 && so.rs.length==0) {
			    //show_error(r.error)
			    word_for_word(text)
			}
		    }
		    else {
			function cmp(a,b) { return a.prob-b.prob; }
			tra=tra.sort(cmp)
			for(var ti=0;ti<tra.length;ti++) {
			    var r=tra[ti]
			    if(r.linearizations) showit(r,gftranslate.grammar)
			    //else show_error("no linearizations")
			}
		    }
		}
		else if(i==0 && so.rs.length==0)
		    show_error("Unable to translate")
	    }
	    gftranslate.translate(text,f.from.value,wc.languages || f.to.value,i,count,step3)
	}
	function step2(text) { trans(text,0,10) }
	function step2cnl(text,ix) {
	    function step3cnl(results) {
		var trans=results[0].translations
		if(trans && trans.length>=1) {
		    for(var i=0;i<trans.length;i++) {
			var r=trans[i]
			r.prob=0
			showit(r,cnl)
		    }
		}
		step2cnl(text,ix+1)
	    }
	    if(ix<wc.selected_cnls.length) {
		var g=wc.cnls[wc.selected_cnls[ix]]
		var cnl=g.grammar_info.name
		g.pgf_online.translate({from:cnl+f.from.value,
					//to:cnl+f.to.value,
					lexer:"text",unlexer:"text",
					jsontree:true,input:text},
					step3cnl,
				       function(){step2cnl(text,ix+1)})
	    }
	    else step2(text)
	}
	if(wc.selected_cnls) step2cnl(so.input,0)
	else step2(so.input)
    }

    function change_segment_to(so,to) {
	var rs=so.rs
	if(rs) {
	    for(var i=0;i<rs.length;i++)
		rs[i].t=trans_quality(rs[i],rs[i].grammar+to)
	    var i=so.current_pick
	    if(!rs[i].t) {
		i=find_pick(rs)
		//console.log("Change pick",so.current_pick,i)
		so.current_pick=i
		clear(p)
		wc.selected=null
	    }
	    var r=rs[i]
	    so.text=r.t.text
	    replaceChildren(so.target,text(r.t.text))
	    so.target.className=r.t.quality
	}
	so.to=to
    }

    //disable(true)
    clear(wc.o)
    clear(e)
    clear(p)


    var old=wc.cache
    var old_selected=wc.selected
    wc.selected=null
    for(var i=0;i<wc.os.length;i++) old[wc.os[i].input]=wc.os[i] 
       // could also keep all copies if the same text occurs more than once...
    wc.os=[]

    wc.translating=f.input.value
    var is=split_punct(wc.translating+"\n")

    for(var i=0;i<is.length;i++) {
	var same=old[is[i]]
	if(same /*&& same.to==f.to.value*/ && same.from==f.from.value) {
	    // reuse an unchanged segment
	    wc.os[i]=same
	    wc.o.appendChild(same.target)
	    if(same==old_selected) wc.selected=same
	    delete old[is[i]] // can't use the same node twice
	    if(same.to!=f.to.value) change_segment_to(same,f.to.value)
	}
	else {
	    // create a new output segment
	    var o=wc.os[i]={input:is[i],text:is[i],
			    from:f.from.value,to:f.to.value}
	    if(i&1) { // punctuation
		o.target=span_class("punct",text(is[i]))
		wc.o.appendChild(o.target)
	    }
	    else { // text segment to be translated
		o.target=span_class("placeholder",text(is[i]))
		wc.o.appendChild(o.target)
		translate_segment(o)
	    }
	}
    }
    wc.save()
    return false;
}

wc.speak=function(text,lang) {
    if(wc.speech) {
	var u=new SpeechSynthesisUtterance(text)
	u.lang=add_country(alangcode(lang))
	speechSynthesis.cancel()
	speechSynthesis.speak(u)
    }
}

wc.colors=function() {
  document.body.className=wc.f.colors.checked ? "colors" : ""
  wc.local.put("colors",wc.f.colors.checked)
}

wc.swap=function() {
    var f=wc.f
    function txt(so) { return so.text }
    f.input.value=wc.os.map(txt).join("").trimRight()
    var from=f.from.value
    f.from.value=f.to.value
    f.to.value=from
    wc.translate()
}

wc.google_translate_url=function() {
    return "http://translate.google.com/"
	+"#"+alangcode(wc.f.from.value)
	+"/"+alangcode(wc.f.to.value)
	+"/"+encodeURIComponent(wc.f.input.value)
}

wc.try_google=function() {
    var w=window.open(wc.google_translate_url(),
		      "google_translate")
    w.focus()
}

wc.bracketsToD3=function(bs) {
    if(bs.token) return {name:bs.token}
    else if(bs.other) return {name:bs.other}
    else if(bs.fun) {
	var t={name:bs.fun}
	if(bs.children/* && bs.children.length>0*/)
	    t.children=bs.children.map(wc.bracketsToD3)
	return t
    }
    else return {name:"??"}
}

// Update language selection menus with the languages supported by the grammar
wc.init_languages=function () {
    function init2(langs) {
	replaceInnerHTML(wc.i,"Enter text to translate above")
	wc.languages=langs
	var langset=toSet(langs)
	function update_menu(m) {
	    var l=m.value
	    clear(m)
	    for(var i=0;i<langs.length;i++)
		m.appendChild(option(concname(langs[i]),langs[i]))
	    if(langset[l]) m.value=l
	}
	update_menu(wc.f.from)
	update_menu(wc.f.to)
    }
    function initerror(errortext,status,ct) {
	var msg = status==404 ? "The wide cover translation grammar was not found on the server" : "Server problem "+status
	replaceChildren(wc.i,text(msg))
	if(wc.i) wc.i.className="error"
    }
    replaceInnerHTML(wc.i,"Loading the wide coverage translation grammar, please wait...")
    gftranslate.get_languages(init2,initerror)
}

wc.init_speech=function() {
    var speak=element("speak")
    if(speak) {
	wc.speech=window.speechSynthesis && window.speechSynthesis.getVoices().length>0
	if(wc.speech) speak.style.display="inline"
    }
}


wc.show_grammarbox=function() {
    wc.grammarbox.parentNode.style.display="block";
}

wc.hide_grammarbox=function() {
    wc.grammarbox.parentNode.style.display="";
    clear(wc.grammarbox)
}

wc.init_cnl=function(grammar) {
    var g
    if(wc.cnls[grammar]) g=wc.cnls[grammar]
    else g=wc.cnls[grammar]={}
    g.pgf_online=pgf_online({})
    g.pgf_online.switch_grammar(grammar)
    g.pgf_online.grammar_info(function(info){g.grammar_info=info})
}

wc.init_cnls=function() {
    var gs=wc.selected_cnls
    for(var i=0;i<gs.length;i++) wc.init_cnl(gs[i])
}

wc.select_grammars=function() {
    function done() {
	wc.hide_grammarbox()
	var gs=[]
	var glist=list.children
	for(var i=0;i<glist.length;i++)
	    if(glist[i].cb.checked) gs.push(glist[i].grammar)
	wc.selected_cnls=gs
	wc.local.put("cnls",wc.selected_cnls)
    }
    function cancel() {
	wc.hide_grammarbox()
    }
    function remove(x,xs) {
	function other(y) { return y!=x; }
	return filter(other,xs)
    }
    function checkbox(grammar,checked) {
	var vb=node("input",{type:"checkbox"})
	vb.checked=checked
	return vb
    }
    function grammar_pick(grammar,checked) {
	var cb=checkbox(grammar,checked)
	var p=[cb,text(" "+grammar.split(".pgf")[0])]
	var dt=node("dt",{class:"grammar_pick"},p)
	dt.cb=cb
	dt.grammar=grammar
	return dt
    }
    function show_list(grammars) {
	var sg=wc.selected_cnls
	for(var i=0;i<sg.length;i++) {
	    if(elem(sg[i],grammars))
		list.appendChild(grammar_pick(sg[i],true))
	    else
		remove(sg[i],wc.selected_cnls)
	}
	for(var i=0;i<grammars.length;i++)
	    if(!elem(grammars[i],wc.selected_cnls))
		list.appendChild(grammar_pick(grammars[i],false))
    }
    
    clear(wc.grammarbox)
    wc.grammarbox.appendChild(wrap("h2",text("Select which domain-specific grammars to use")))
    wc.grammarbox.appendChild(text("These grammars are tried before the wide-coverage grammar. They can give higher quality translations within their respective domains."))
    var list=empty("dl")
    wc.grammarbox.appendChild(list)
    wc.grammarbox.appendChild(button("OK",done))
    wc.grammarbox.appendChild(button("Cancel",cancel))
    wc.show_grammarbox()
    wc.pgf_online.get_grammarlist(show_list)
}

wc.initialize=function(grammar_name,grammar_url) {
    if(grammar_name && grammar_url) {
	gftranslate.grammar=grammar_name
	gftranslate.jsonurl=grammar_url
    }
    wc.init_languages()
    //init_speech()
    setTimeout(wc.init_speech,500) // A hack for Chrome.
    wc.pgf_online=pgf_online({});
    wc.local=appLocalStorage("gf.wc."+gftranslate.grammar+".")
    wc.load()
    wc.init_cnls()
    initialize_sorting(["DT"],["grammar_pick"])
    wc.f.input.focus()
}
