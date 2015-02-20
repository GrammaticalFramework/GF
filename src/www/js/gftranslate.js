
/* --- GF wide coverage translation interface ------------------------------- */

var gftranslate = {}

gftranslate.jsonurl="/robust/App14.pgf"
gftranslate.grammar="App" // the name of the grammar

gftranslate.call=function(querystring,cont,errcont) {
    http_get_json(gftranslate.jsonurl+querystring,cont,errcont)
}

function enc_langs(g,to) {
    return Array.isArray(to)
             ? to.map(function(l){return g+l}).join("+")
	     : g+to
}

function unspace_translations(g,trans) {
    var langs=[g+"Chi",g+"Jpn",g+"Tha"]
    for(var i=0;i<trans.length;i++) {
	var lins=trans[i].linearizations
	if(lins) {
	    for(var j=0;j<lins.length;j++) {
		var lin=lins[j]
		if(elem(lin.to,langs)) {
		    //console.log(i,j,"space",lin.to,lin.text)
		    lin.text=lin.text.split(" ").join("")
		    //console.log(i,j,"unspace",lin.to,lin.text)
		}
	    }
	}
    }
    return trans
}

function length_limit(lang) {
    switch(lang) {
    case "Bul":
    case "Chi":
    case "Eng":
    case "Swe":
	return 500
    default:
	return 200
    }
}

// Translate a sentence
gftranslate.translate=function(source,from,to,start,limit,cont) {
    var g=gftranslate.grammar
    var lexer="&lexer=text"
    if(from=="Chi") lexer="",source=source.split("").join(" ")
    var encsrc=encodeURIComponent(source)
    function errcont(text,code) { cont([{error:code+" "+text}]) }
    function extract(result) {
	cont(unspace_translations(g,result[0].translations))
    }
    if(encsrc.length<length_limit(from))
	gftranslate.call("?command=c-translate&input="+encsrc
		      +lexer+"&unlexer=text&from="+g+from+"&to="+enc_langs(g,to)
		      +"&start="+start+"&limit="+limit,extract,errcont)
    else cont([{error:"sentence too long"}])
}

// Translate a sentence word for word (if all else fails...)
gftranslate.wordforword=function(source,from,to,cont) {
    var g=gftranslate.grammar
    var lexer="&lexer=text"
    if(from=="Chi") lexer="",source=source.split("").join(" ")
    var encsrc=encodeURIComponent(source)
    function errcont(text,code) { cont([{error:code+" "+text}]) }
    function extract(result) {
	cont(unspace_translations(g,result[0].translations))
    }
    var enc_to = enc_langs(g,to)
    if(encsrc.length<length_limit(from))
	gftranslate.call("?command=c-wordforword&input="+encsrc
			 +lexer+"&unlexer=text&from="+g+from+"&to="+enc_to
			 ,extract,errcont)
    else cont([{error:"sentence too long"}])
}

// Get list of supported languages
gftranslate.waiting=[]
gftranslate.get_languages=function(cont,errcont) {
    function init2(grammar_info) {
	var ls=grammar_info.languages
	gftranslate.grammar=grammar_info.name
	var langs=[], pre=gftranslate.grammar, n=pre.length
	for(var i=0;i<ls.length;i++)
	    if(ls[i].name.substr(0,n)==pre) langs.push(ls[i].name.substr(n))
	gftranslate.targetlist=langs
	var w=gftranslate.waiting
	for (var i=0;i<w.length;i++) w[i].cont(langs)
	gftranslate.waiting=[]
    }
    function init2error(text,status,ct) {
	var w=gftranslate.waiting
	for (var i=0;i<w.length;i++) {
	    var e=w[i].errcont
	    if(e) e(text,status,ct)
	}
	gftranslate.waiting=[]
    }
    if(gftranslate.targetlist) cont(gftranslate.targetlist)
    else {
	gftranslate.waiting.push({cont:cont,errcont:errcont})
	if(gftranslate.waiting.length<2) 
	    gftranslate.call("?command=c-grammar",init2,init2error)
    }
}

// Get functions to test which source and target langauges are supported
gftranslate.get_support=function(cont,errcont) {
    function support(code) { return gftranslate.targets[code] }
    function init2(langs) {
	gftranslate.targets=toSet(langs)
	cont(support,support)
    }
    if(gftranslate.targets) cont(support,support)
    else gftranslate.get_languages(init2,errcont)
}

// trans_text_quality : String -> {quality:String, text:String}
function trans_text_quality(text) {
    var quality="default_quality"
    switch(text[0]) {
    case '+': text=text.substr(1).trimLeft(); quality="high_quality"; break;
    case '*': text=text.substr(1).trimLeft(); quality="low_quality"; break;
    }
    return {quality:quality,text:text}
}

// find_to :: Lang -> [{to:Lang,...}] -> Int
function find_to(to,lins) {
    for(var i=0;i<lins.length;i++)
	if(lins[i].to==to) return i
    return -1 // Hmm....
}

function trans_quality(r,to) {
    var ix=to ? find_to(to,r.linearizations) : 0
    if(ix<0) return null
    else {
	var text=r.linearizations[ix].text
	if(r.prob==0) return {quality:"high_quality",text:text}
	else if(r.prob<0) return {quality:"bad_quality",text:text}
	else {
	    var t=trans_text_quality(text)
	    if(t.quality=="default_quality" && r.tree && r.tree[0]=="?")
		t.quality="low_quality"
	    return t
	}
    }
}
