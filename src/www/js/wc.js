var wc={}
wc.cnl="Phrasebook" // try this controlled natural language first
wc.f=document.forms[0]
wc.e=element("extra")
wc.p=element("pick")
wc.serial=0
wc.translate=function() {
    var current= ++wc.serial
    var f=wc.f, e=wc.e, p=wc.p

    function disable(yes) {
	f.translate.disabled=yes
	f.to.disabled=yes
	f.swap.disabled=yes
    }
    disable(true)
    f.output.value=""
    f.output.className=""
    wc.r=[]
    wc.current=0
    clear(e)
    clear(p)

    function show_error(msg) {
	if(e) e.innerHTML="<span class=low_quality>Translation problem: "+msg+"</span>"
	else {
	    f.output.value="["+msg+"]"
	    f.output.className="low_quality"
	}
	disable(false)
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
    function show_pick(i) { return function() { show_trans(i); return false; } }
    function show_picks() {
	clear(p)
	for(var i=0;i<wc.r.length;i++) {
	    p.appendChild(text(" "))
	    var pick=text(i+1) // +"⃝"
	    if(i!=wc.current) {
		var pick=node("a",{href:"#"},[pick])
		pick.onclick=pick.onmouseover=show_pick(i)
	    }
	    var q=trans_quality(wc.r[i]).quality
	    p.appendChild(span_class("pick "+q,pick))
	}
	p.appendChild(wrap_class("small","pick",
				 node("a",{href:wc.google_translate_url(),
					   target:"google_translate"},
				      [text("Google Translate")])))
    }
    function show_trans(i) {
	var r=wc.r[i]
	var t=trans_quality(r)
	f.output.value=t.text
	f.output.className=t.quality
	if(e) e.innerHTML=(r.prob||"")+"<br>"+r.tree
	wc.current=i
	if(wc.p /*&& wc.r.length>1*/) show_picks()
	if(f.speak.checked) wc.speak(t.text,f.to.value)
    }

    function showit(r,text) {
	wc.r.push(r)
	var j=wc.r.length-1
	wc.r[j].text=text
	if(wc.current==j) show_trans(j)
	else show_picks()
	disable(false)
    }
    function trans(text,i) {
	function step3(tra) {
	    if(wc.serial==current) {
		if(tra.length>=1) {
		    if(tra[0].error) show_error(tra[0].error)
		    else {
			var r=tra[0]
			r.text=r.linearizations[0].text
			// Two server requests in parallel:
			unlextext(r.text,function(text){showit(r,text)})
			if(wc.p && i<9) trans(text,i+1)
		    }
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
    lextext(f.input.value,wc.cnl ? step2cnl : step2)
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
    f.input.value=f.output.value;
    var from=f.from.value
    f.from.value=f.to.value
    f.to.value=from
    //wc.translate() // changing f.to.value is enough to start the translation
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
    wc.speech=window.speechSynthesis && window.speechSynthesis.getVoices().length>0
    if(wc.speech) element("speak").style.display="inline"
}

init_languages()
init_speech()
setTimeout(init_speech,500) // A hack for Chrome.
if(wc.cnl) {
    wc.pgf_online=pgf_online({});
    wc.pgf_online.switch_grammar(wc.cnl+".pgf")
}
