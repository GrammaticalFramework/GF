
/* --- Auxiliary functions -------------------------------------------------- */

function langpart(conc,abs) { // langpart("FoodsEng","Foods") == "Eng"
    return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
}


// Lookup language codes (from "flags language = ..." in the source grammar)
function langCode(grammar,conc) {
    if(!grammar.langCode) {
	var ls=grammar.languages
	var langCode={}
	for(var i=0;i<ls.length;i++)
	    if(ls[i].languageCode)
		langCode[ls[i].name]=ls[i].languageCode
	grammar.langCode=langCode
    }
    return grammar.langCode[conc]
}

// Words are separated by spaces (for now). GF has other lexers/unlexers.
function gf_lex(s) { return s.split(" "); }
function gf_unlex(ws) { return ws.join(" "); }

function update_language_menu(menu,grammar) {
    // Replace the options in the menu with the languages in the grammar
    var lang=grammar.languages;
    menu.innerHTML="";
	
    for(var i=0; i<lang.length; i++) {
	var ln=lang[i].name;
	if(!hasPrefix(ln,"Disamb")) {
	    var lp=langpart(ln,grammar.name);
	    menu.appendChild(option(lp,ln));
	}
    }
}

function button_img(url,action) {
    var i=node("img",{"class":"button","src":url});
    i.onclick=action;
    return i;
}

function toggle_img(i) {
  var tmp=i.src;
  i.src=i.other;
  i.other=tmp;
}

function setField(form,name,value) {
    form[name].value=value;
    var el=element(name);
    if(el) el.innerHTML=value;
}

function open_popup(url,target) {
    var w=window.open(url,target,'toolbar=no,location=no,status=no,menubar=no');
    w.focus();
}

function opener_element(id) { with(window.opener) return element(id); }

function supportsSVG() {
    return document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#BasicStructure", "1.1")
}

function speech_buttons(to3,to2,txt) {
    var voices = window.speechSynthesis && window.speechSynthesis.getVoices() || []
    var dvs = voices.filter(function(v){return v.default})
    function pick2dash(v) { return hasPrefix(v.lang,to2dash) }
    if(to2)
	var pick=function (v) { return v.lang==to2 }
    else if(to3.length==3) {
	var to2dash=alangcode(to3)+"-"
	var pick=pick2dash
    }
    else {
	// Maybe the name of the concrete syntax is the name of the language
	// like in Numerals.pgf
	var lang=to3.substr(0,1).toUpperCase()+to3.substr(1).toLowerCase()
	var codes=langcode[lang]
	var to2dash=(codes ? codes.code2 : to3)+"-"
	var pick=pick2dash
    }
    function btn(v) {
	var u=new SpeechSynthesisUtterance(txt)
	u.lang=v.lang // how to use v.voiceURI or v.name?

	function speak() {
	    speechSynthesis.cancel()
	    speechSynthesis.speak(u)
	}
	return button(v.lang,speak)
    }
    //console.log(voices.length,"voices")
    var vs=dvs.filter(pick)
    if(vs.length==0) vs=voices.filter(pick)
    //console.log(vs.length,"voices for "+to3+" "+to2)
    var btns=vs.map(btn)
    //console.log(btns.length,"voice buttons")
    return wrap("span",btns)
}
