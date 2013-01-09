// Assumes that Services.js has been loaded

function pgf_offline(options) {
    var server = {
	// State variables (private):
	grammars_url: "",
	other_grammars_urls: [],
	grammar_list: ["Foods.pgf"],
	current_grammar_url: null,
	pgf : null,
	
	// Methods:
	switch_grammar: function(grammar_url,cont) {
	    var new_grammar_url=this.grammars_url+grammar_url;
	    this.switch_to_other_grammar(new_grammar_url,cont)
	},
	add_grammars_url: function(grammars_url,cont) {
	    this.other_grammars_urls.push(grammars_url);
	    if(cont) cont();
	},
	switch_to_other_grammar: function(new_grammar_url,cont) {
	    //debug("switch_grammar ");
	    var self=this;
	    var update_pgf=function(pgfbinary) {
		debug("Got "+new_grammar_url+", length="
 		 			   +pgfbinary.length+", parsing... ");
		self.pgf = {v: Services_decodePGF.v({v:pgfbinary}) }
		//debug("done")
		self.current_grammar_url=new_grammar_url;
		if(cont) cont();
	    }
	    ajax_http_get_binary(new_grammar_url+"?command=download",update_pgf);
	},
	get_grammarlist: function(cont,err) {
	    if(this.grammar_list) cont(this.grammar_list)
	    else http_get_json(this.grammars_url+"grammars.cgi",cont,err);
	},
	get_grammarlists: function(cont,err) { // May call cont several times!
	    var ds=this.other_grammars_urls;
	    var n=1+ds.length;
	    function pair(dir) {
		return function(grammar_list){cont(dir,grammar_list,n)}
	    }
	    function ignore_error(err) { console.log(err) }
	    this.get_grammarlist(pair(this.grammars_url),err)
	    for(var i in ds)
		http_get_json(ds[i]+"grammars.cgi",pair(ds[i]),ignore_error);
	},
	
	get_languages: function(cont) {
	    cont(fromJSValue(Services_grammar.v(this.pgf)))
	},
	grammar_info: function(cont) {
	    cont(fromJSValue(Services_grammar.v(this.pgf)))
	},

	get_random: function(cont) {
	    alert("Random generation not supported yet in the offline version");
	},
	linearize: function(args,cont) {
	    cont(fromJSValue(Services_linearize.v(this.pgf)(v(args.tree))(v(args.to))));
	},
	complete: function(args,cont) {
	    cont(fromJSValue(Services_complete.v(this.pgf)(v(args.from))(v(args.input))));
	},
	parse: function(args,cont) {
	    cont(fromJSValue(Services_parse.v(this.pgf)(v(args.from))(v(args.input))));
	},
	translate: function(args,cont) {
          cont(fromJSValue(Services_translate.v(this.pgf)(v(args.from))(v(args.input))));
	},
	translategroup: function(args,cont) {
	    cont(fromJSValue(Services_translategroup.v(this.pgf)(v(args.from))(v(args.input))));
	}
    };
    for(var o in options) server[o]=options[o];
    return server;
};



// See https://developer.mozilla.org/En/XMLHttpRequest/Using_XMLHttpRequest
function ajax_http_get_binary(url,callback) {
  var http=GetXmlHttpObject()
  if (http==null) {
    alert ("Browser does not support HTTP Request")
    return
  } 
  var statechange=function() {
      if (http.readyState==4 || http.readyState=="complete") {
	  if(http.status==200) {
	      var buffer=http.mozResponseArrayBuffer;
	      if(buffer) callback(bufferToString(buffer)) // Gecko 2 (Firefox 4)
	      else callback(http.responseText); // other browsers
	  }
	  else alert("Request for "+url+" failed: "
		     +http.status+" "+http.statusText);
      }
  }
  http.onreadystatechange=statechange;
  http.open("GET",url,true);
  http.overrideMimeType('text/plain; charset=x-user-defined');
  http.send(null);
  //dump("http get "+url+"\n")
  return http;
}

function bufferToString(buffer) {
    // This function converts to the current representation of ByteString,
    // but it would be better to use binary buffers for ByteStrings as well.
    debug("bufferToString");
    var u=new Uint8Array(buffer);
    var a=new Array(u.length);
    for(var i=0;i<u.length;i++)
	a[i]=String.fromCharCode(u[i]);
    return a.join("");
}
