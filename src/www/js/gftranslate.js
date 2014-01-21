
/* --- GF wide coverage translation interface ------------------------------- */

var gftranslate = {}

gftranslate.jsonurl="/robust/Translate8.pgf"
gftranslate.grammar="Translate" // the name of the grammar
gftranslate.languages="Bul Chi Eng Fin Fre Ger Hin Swe".split(" ")
                    // hardwired for now

gftranslate.call=function(querystring,cont) {
    http_get_json(gftranslate.jsonurl+querystring,cont)
}

// Translate a sentence to the given target language
gftranslate.translate=function(source,from,to,cont) {
    var encsrc=encodeURIComponent(source)
    var g=gftranslate.grammar
    function extract(result) {
	cont(result[0].translations[0].linearizations[0].text)
    }
    if(encsrc.length<200) // match limit in runtime/c/utils/pgf-server.c
	gftranslate.call("?command=c-translate&input="+encsrc
		      +"&from="+g+from+"&to="+g+to+"&limit=1",extract)
    else cont("[GF robust parser: sentence too long]")
}

// Get functions to test which source and target langauges are supported
gftranslate.get_support=function(cont) {
    if(!gftranslate.targets) gftranslate.targets=toSet(gftranslate.languages)
    function ssupport(code) { return gftranslate.targets[code] }
    function tsupport(code) { return gftranslate.targets[code] }
    cont(ssupport,tsupport)
}
