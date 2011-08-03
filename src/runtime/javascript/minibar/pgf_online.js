
/* --- Grammar access object ------------------------------------------------ */

function pgf_online(options) {
    var server = {
	// State variables (private):
	grammars_url: "/grammars/",
	grammar_list: null,
	current_grammar_url: null,
	
	// Methods:
	switch_grammar: function(grammar_url,cont) {
 	    this.current_grammar_url=this.grammars_url+grammar_url;
	    if(cont) cont();
	},
	get_grammarlist: function(cont) {
	    http_get_json(this.grammars_url+"grammars.cgi",cont);
	},
	pgf_call: function(cmd,args,cont) {
	    var url=this.current_grammar_url+"?command="+cmd;
	    for(var arg in args)
		if(args[arg]!=undefined)
		    url+="&"+arg+"="+encodeURIComponent(args[arg]);
	    http_get_json(url,cont);
	},
	
	get_languages: function(cont) { this.pgf_call("grammar",{},cont); },
	grammar_info: function(cont) { this.pgf_call("grammar",{},cont); },
	
	get_random: function(args,cont) { // cat, limit
	    args.random=Math.random(); // side effect!!
	    this.pgf_call("random",args,cont);
	},
	linearize: function(args,cont) { // tree, to
	    this.pgf_call("linearize",args,cont);
	},
	complete: function(args,cont) { // from, input, cat, limit
	    this.pgf_call("complete",args,cont);
	},
	parse: function(args,cont) { // from, input, cat
	    this.pgf_call("parse",args,cont);
	},
	translate: function(args,cont) { // from, input, cat, to
	    this.pgf_call("translate",args,cont);
	},
	translategroup: function(args,cont) { // from, input, cat, to
	    this.pgf_call("translategroup",args,cont);
	}
	
    };
    for(var o in options) server[o]=options[o];
    if(server.grammar_list && server.grammar_list.length>0)
	server.switch_grammar(server.grammar_list[0]);
    return server;
}