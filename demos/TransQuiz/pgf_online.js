
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
	    for(var arg in args) url+="&"+arg+"="+encodeURIComponent(args[arg]);
	    http_get_json(url,cont);
	},
	
	get_languages: function(cont) {
	    this.pgf_call("grammar",{},cont);
	},
	
	get_random: function(cont) {
	    this.pgf_call("random",{random:Math.random()},cont);
	},
	linearize: function(tree,to,cont) {
	    this.pgf_call("linearize",{tree:tree,to:to},cont);
	},
	linearizeAll: function(tree,to,cont) {
	    this.pgf_call("linearizeAll",{tree:tree,to:to},cont);
    },
	complete: function(from,input,cont) {
	    this.pgf_call("complete",{from:from,input:input},cont);
	},
	parse: function(from,input,cont) {
	    this.pgf_call("parse",{from:from,input:input},cont);
	},
	translate: function(from,input,cont) {
	    this.pgf_call("translate",{from:from,input:input},cont);
	},
	translategroup: function(from,input,cont) {
	    this.pgf_call("translategroup",{from:from,input:input},cont);
	}
	
    };
    for(var o in options) server[o]=options[o];
    if(server.grammar_list && server.grammar_list.length>0)
	server.switch_grammar(server.grammar_list[0]);
    return server;
}