var wc={}
wc.f=document.forms[0]
wc.e=element("extra")
wc.p=element("pick")
wc.translate=function() {
    var f=wc.f, e=wc.e, p=wc.p
    f.translate.disabled=true
    f.output.value=""
    f.output.className=""
    wc.r=[]
    wc.current=0
    clear(e)
    clear(p)

    function show_error(msg) {
	if(e) e.innerHTML="<span class=low_quality>"+msg+"</span>"
	else {
	    f.output.value="["+msg+"]"
	    f.output.className="low_quality"
	}
	f.translate.disabled=false
    }
    function trans_quality(r) {
	var text=r.text
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
	if(e) e.innerHTML=r.prob+"<br>"+r.tree
	wc.current=i
	if(wc.p /*&& wc.r.length>1*/) show_picks()
	if(f.speak.checked) wc.speak(t.text,f.to.value)
    }

    function trans(text,i) {
	function showit(result) {
	    wc.r[i].text=result
	    if(wc.current==i) show_trans(i)
	    else show_picks()
	    f.translate.disabled=false
	    if(wc.p && i<9) trans(text,i+1)
	}
	function step3(trans) {
	    if(trans.length>=1) {
		if(trans[0].error) show_error(trans[0].error)
		else {
		    var r=wc.r[i]=trans[0]
		    if(e && wc.current==i) e.innerHTML=r.prob+"<br>"+r.tree
		    unlextext(r.linearizations[0].text,showit)
		}
	    }
	    else if(i==0) show_error("Unable to translate")
	}
	gftranslate.translate(text,f.from.value,f.to.value,i,1,step3)
    }
    function step2(text) { trans(text,0) }
    lextext(f.input.value,step2)
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
    wc.speech=window.speechSynthesis && window.speechSynthesis.getVoices().length>0
    if(wc.speech) element("speak").style.display="inline"
}

init_languages()
init_speech()
setTimeout(init_speech,500) // A hack for Chrome.
