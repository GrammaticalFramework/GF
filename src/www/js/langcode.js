// Language names and ISO-639 codes (both 3-letter and 2-letter codes)
// See http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

var languages =
    function() {
	function lang1(namecode2) {
	    function lang(code,name,code2) {
		return {code:code, name:name, code2:code2}
	    }
	    var nc=namecode2.split(":")
	    var name=nc[0]
	    var ws=name.split("/")
	    var code2=nc.length>1 ? nc[1] : ""
	    return ws.length==1 ? lang(name.substr(0,3),name,code2)
	                        : lang(ws[0],ws[1],code2)
	}

	return map(lang1,
		// [ISO-639-2 code "/"] language name ":" ISO 639-1 code
		["Amharic:am","Arabic:ar","Bulgarian:bg","Catalan:ca",
	        "Chinese:zh","Danish:da","Dutch:nl","English:en","Estonian:et",
	        "Finnish:fi","French:fr","German:de","Greek:el","Hindi:hi",
	        "Ina/Interlingua:ia","Italian:it","Jpn/Japanese:ja","Latin:la",
	        "Norwegian:nb","Pes/Persian:fa","Polish:pl","Pnb/Punjabi:pa",
	        "Ron/Romanian:ro","Russian:ru","Spanish:es","Swedish:sv",
	        "Thai:th","Turkish:tr","Urdu:ur"])
	        // GF uses nonstd 3-letter codes? Pes/Persian:fa, Pnb/Punjabi:pa
    }()

var langname={}
var langcode2={}
var langcode3={}
for(var i in languages) {
    langname[languages[i].code]=languages[i].name
    langcode2[languages[i].code]=languages[i].code2
    langcode3[languages[i].code2]=languages[i].code
}

function concname(code) { return langname[code] || code; }
function alangcode(code) { return langcode2[code] || code; }

// Add a country code to the language code
function add_country(code) {
    switch(code) {
    case "en": return "en-US"  // "en-scotland" // or "en-GB"
    case "sv": return "sv-SE"
    case "fr": return "fr-FR"
    case "de": return "de-DE"
    case "fi": return "fi-FI"
    case "zh": return "zh-CN"
    case "hi": return "hi-IN"
    case "es": return "es-ES"
    case "it": return "it-IT"
    case "bg": return "bg-BG" // ?
    case "da": return "da-DK"
    case "nb": return "nb-NO"
    case "nl": return "nl-NL"
    case "ja": return "ja-JP"
    case "ro": return "ja-RO"
    case "el": return "el-GR"
    case "th": return "th-TH"
    // ...
    default: return code
    }
}
