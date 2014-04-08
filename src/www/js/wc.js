var wc={}
wc.cnl="Phrasebook" // try this controlled natural language first
wc.f=document.forms[0]
wc.o=element("output")
wc.e=element("extra")
wc.p=element("pick")
wc.serial=0
wc.os=[]

wc.delayed_translate=function() {
    function restart(){ if(wc.f.input.value!=wc.translating) wc.translate() }
    if(wc.timer) clearTimeout(wc.timer);
    wc.timer=setTimeout(restart,500)
    var h=wc.f.input.scrollHeight,bh=document.body.clientHeight
    if(h>bh) h=bh
    if(wc.f.input.clientHeight<h) wc.f.input.style.height=h+15+"px"
}

wc.translate=function() {
    var current= ++wc.serial
    var f=wc.f, e=wc.e, p=wc.p
    var selected= -1

    function disable(yes) {
	f.translate.disabled=yes
	f.to.disabled=yes
	if(f.swap) f.swap.disabled=yes
    }
    disable(true)
    clear(wc.o)
    wc.os=[]
    clear(e)
    clear(p)


    function split_punct(s) {
	return s.split(/([.!?]+[ \t\n]+|\n\n+|[ \t\n]*[-•*+#]+[ \t\n]+)/)
    }
    function trans_quality(r) {
	var text=r.text
	if(r.prob==0) return {quality:"high_quality",text:text}
	else {
	    var quality="default_quality"
	    switch(text[0]) {
	    case '+': text=text.substr(1); quality="high_quality"; break;
	    case '*': text=text.substr(1); quality="low_quality"; break;
	    default:
		if(r.tree[0]=="?") quality="low_quality"
	    }
	    if(text[0]==" ") text=text.substr(1)
	    return {quality:quality,text:text}
	}
    }

    function translate_segment(si) {
	var rs=[]
	var current_pick=0
	var get_more
	var output=wc.os[si].target

	function show_error(msg) {
	    //if(e) e.innerHTML="<span class=low_quality>Translation problem: "+msg+"</span>"
	    //else
	    {
		replaceChildren(output,text("["+msg+"]"))
		output.className="error"
	    }
	    disable(false)
	}
	function show_pick(i) { return function() { show_trans(i); return false; } }
	function show_picks() {
	    clear(p)
	    for(var i=0;i<rs.length;i++) {
		p.appendChild(text(" "))
		var pick=text(i+1) // +"⃝"
		if(i!=current_pick) {
		    var pick=node("a",{href:"#"},[pick])
		    pick.onclick=pick.onmouseover=show_pick(i)
		}
		var q=trans_quality(rs[i]).quality
		p.appendChild(span_class("pick "+q,pick))
	    }
	    /*
	    p.appendChild(wrap_class("small","pick",
				     node("a",{href:wc.google_translate_url(),
					       target:"google_translate"},
					  [text("Google Translate")])))
	    */
	}
	function show_more() {
	    selected=si
	    var r=rs[current_pick]
	    if(e) e.innerHTML=(r.prob||"")+"<br>"+r.tree
	    if(wc.p /*&& rs.length>1*/) show_picks()
	    //if(f.speak.checked) wc.speak(t.text,f.to.value)
	    if(get_more) {
		var f=get_more
		get_more=null
		f()
	    }
	}
	output.onclick=show_more

	function show_trans(i) {
	    var r=rs[i]
	    var t=trans_quality(r)
	    replaceChildren(output,text(t.text))
	    wc.os[si].text=t.text
	    output.className=t.quality
	    current_pick=i
	    if(selected==si) show_more()
	}

	function showit(r,text) {
	    text=text.trimRight()
	    rs.push(r)
	    var j=rs.length-1
	    rs[j].text=text
	    if(current_pick==j) show_trans(j)
	    else if(selected==si) show_picks()
	    disable(false)
	}
	function trans(text,i) {
	    function step3(tra) {
		if(wc.serial==current) {
		    if(tra.length>=1) {
			var r=tra[0]
			if(r.error!=undefined) show_error(tra[0].error)
			else if(r.linearizations) {
			    r.text=r.linearizations[0].text
			    unlextext(r.text,function(text){showit(r,text)})
			    if(wc.p && i<9) {
				if(si==selected) trans(text,i+1)
				else get_more=function() { trans(text,i+1) }
			    }
			}
			else show_error("no linearizations")
		    }
		    else if(i==0) show_error("Unable to translate")
		}
	    }
	    gftranslate.translate(text,f.from.value,f.to.value,i,1,step3)
	}
	function step2(text) { trans(text,0) }
	function step2cnl(text) {
	    function step3cnl(results) {
		var trans=results[0].translations
		if(trans && trans.length>=1) {
		    var r=trans[0]
		    r.text=r.linearizations[0].text
		    r.prob=0
		    unlextext(r.text,function(text){showit(r,text)})
		}
		step2(text)
	    }
	    wc.pgf_online.translate({from:wc.cnl+f.from.value,
				     to:wc.cnl+f.to.value,
				     input:text},
				    step3cnl,
				    function(){step2(text)})
	}
	lextext(is[si],wc.cnl ? step2cnl : step2)
    }
    wc.translating=f.input.value
    var is=wc.is=split_punct(wc.translating+"\n")
    for(var i=0;i<is.length;i++) {
	wc.os[i]={text:is[i]}
	if(i&1) { // punctuation
	    wc.o.appendChild(span_class("punct",text(is[i])))
	}
	else { // segment
	    var o=wc.os[i].target=span_class("placeholder",text(is[i]))
	    wc.o.appendChild(o)
	    translate_segment(i)
	}
    }
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

wc.swap=function() {
    var f=wc.f
    function txt(r) { return r.text }
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
/*
wc.try_google=function() {
    var w=window.open(wc.google_translate_url(),
		      "google_translate")
    w.focus()
}
*/

// Update language selection menus with the languages supported by the grammar
function init_languages() {
    function init2(langs) {
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
    gftranslate.get_languages(init2)
}

function init_speech() {
    var speak=element("speak")
    if(speak) {
	wc.speech=window.speechSynthesis && window.speechSynthesis.getVoices().length>0
	if(wc.speech) speak.style.display="inline"
    }
}

init_languages()
init_speech()
setTimeout(init_speech,500) // A hack for Chrome.
if(wc.cnl) {
    wc.pgf_online=pgf_online({});
    wc.pgf_online.switch_grammar(wc.cnl+".pgf")
}
wc.f.input.focus()
