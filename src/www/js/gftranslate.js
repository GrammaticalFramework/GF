
/* --- GF wide coverage translation interface ------------------------------- */

var gftranslate = {}

gftranslate.jsonurl="/robust/Translate11.pgf"
gftranslate.grammar="Translate" // the name of the grammar

gftranslate.call=function(querystring,cont) {
    function errcont(text,code) {
	cont([{translations:[{error:code+" "+text}]}])
    }
    http_get_json(gftranslate.jsonurl+querystring,cont,errcont)
}

// Translate a sentence
gftranslate.translate=function(source,from,to,start,limit,cont) {
    var g=gftranslate.grammar
    var lexer="&lexer=text"
    if(from=="Chi") lexer="",source=source.split("").join(" ")
    var encsrc=encodeURIComponent(source)
    function extract(result) { cont(result[0].translations) }
    if(encsrc.length<500)
	gftranslate.call("?command=c-translate&input="+encsrc
		      +lexer+"&unlexer=text&from="+g+from+"&to="+g+to
		      +"&start="+start+"&limit="+limit,extract)
    else cont([{error:"sentence too long"}])
}

// Translate a sentence word for word (if all else fails...)
gftranslate.wordforword=function(source,from,to,cont) {
    var g=gftranslate.grammar
    var lexer="&lexer=text"
    if(from=="Chi") lexer="",source=source.split("").join(" ")
    var encsrc=encodeURIComponent(source)
    function extract(result) { cont(result[0].translations) }
    if(encsrc.length<500)
	gftranslate.call("?command=c-wordforword&input="+encsrc
			 +lexer+"&unlexer=text&from="+g+from+"&to="+g+to
			 ,extract)
    else cont([{error:"sentence too long"}])
}

// Get list of supported languages
gftranslate.get_languages=function(cont) {
    function init2(grammar_info) {
	var ls=grammar_info.languages
	gftranslate.grammar=grammar_info.name
	var langs=[], pre=gftranslate.grammar, n=pre.length
	for(var i=0;i<ls.length;i++)
	    if(ls[i].name.substr(0,n)==pre) langs.push(ls[i].name.substr(n))
	gftranslate.targetlist=langs
	cont(langs)
    }
    if(gftranslate.targetlist) cont(gftranslate.targetlist)
    else gftranslate.call("?command=c-grammar",init2)
}

// Get functions to test which source and target langauges are supported
gftranslate.get_support=function(cont) {
    function support(code) { return gftranslate.targets[code] }
    function init2(langs) {
	gftranslate.targets=toSet(langs)
	cont(support,support)
    }
    if(gftranslate.targets) cont(support,support)
    else gftranslate.get_languages(init2)
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

function trans_quality(r) {
    var text=r.linearizations[0].text
    if(r.prob==0) return {quality:"high_quality",text:text}
    else {
	var t=trans_text_quality(text)
	if(t.quality=="default_quality" && r.tree[0]=="?")
	    t.quality="low_quality"
	return t
    }
}
