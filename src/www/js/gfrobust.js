
/* --- GF robust parser interface ------------------------------------------- */

var gfrobust = {}

gfrobust.url="http://www.grammaticalframework.org:41296/robust-parser.cgi"
gfrobust.grammar="Parse" // the name of the grammar
gfrobust.targetlist=[] // do not use, exposed only for debugging

gfrobust.call=function(querystring,cont) {
    http_get_json(gfrobust.url+querystring,cont)
}

// Translate a sentence to the given target language
gfrobust.translate=function(source,to,cont) {
    var enc=encodeURIComponent
    gfrobust.call("?sentence="+enc(source)+"&to="+gfrobust.grammar+to,cont)
}

// Get functions to test which source and target langauges are supports
gfrobust.get_support=function(cont) {
    function ssupport(code) { return code=="Eng" }
    function tsupport(code) { return gfrobust.targets[code] }
    function init2(langstr) {
	var ls=langstr.split(" "); // ls probably contains an empty string here
	var langs=[], pre=gfrobust.grammar, n=pre.length
	for(var i=0;i<ls.length;i++)
	    if(ls[i].substr(0,n)==pre) langs.push(ls[i].substr(n))
	gfrobust.targetlist=langs
	gfrobust.targets=toSet(langs)
	cont(ssupport,tsupport)
    }
    if(gfrobust.target) cont(ssupport,tsupport)
    else gfrobust.call("",init2) // retrieve list of supported target languages
}
