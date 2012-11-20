
/* --- Grammar access object ------------------------------------------------ */

function pgf_online(options) {
    var server = {
	// State variables (private):
	grammars_url: "/grammars/",
	other_grammars_urls: [],
	grammar_list: null,
	current_grammar_url: null,

	// Methods:
	switch_grammar: function(grammar_url,cont) {
 	    this.current_grammar_url=this.grammars_url+grammar_url;
	    if(cont) cont();
	},
	add_grammars_url: function(grammars_url,cont) {
	    this.other_grammars_urls.push(grammars_url);
	    if(cont) cont();
	},
	switch_to_other_grammar: function(grammar_url,cont) {
 	    this.current_grammar_url=grammar_url;
	    if(cont) cont();
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
	pgf_call: function(cmd,args,cont,err) {
	    var url=this.current_grammar_url+"?command="+cmd+encodeArgs(args)
	    http_get_json(url,cont,err);
	},
	
	get_languages: function(cont,err) {
	    this.pgf_call("grammar",{},cont,err);
	},
	grammar_info: function(cont,err) {
	    this.pgf_call("grammar",{},cont,err);
	},
	
	get_random: function(args,cont,err) { // cat, limit
	    args.random=Math.random(); // side effect!!
	    this.pgf_call("random",args,cont,err);
	},
	linearize: function(args,cont,err) { // tree, to
	    this.pgf_call("linearize",args,cont,err);
	},
	complete: function(args,cont,err) { // from, input, cat, limit
	    this.pgf_call("complete",args,cont,err);
	},
	parse: function(args,cont,err) { // from, input, cat
	    this.pgf_call("parse",args,cont,err);
	},
	translate: function(args,cont,err) { // from, input, cat, to
	    this.pgf_call("translate",args,cont,err);
	},
	translategroup: function(args,cont,err) { // from, input, cat, to
	    this.pgf_call("translategroup",args,cont,err);
	},
	browse: function(args,cont,err) { // id, format
	    if(!args.format) args.format="json"; // sife effect!!
	    this.pgf_call("browse",args,cont,err);
	}
    };
    for(var o in options) server[o]=options[o];
    if(server.grammar_list && server.grammar_list.length>0)
	server.switch_grammar(server.grammar_list[0]);
    return server;
}
