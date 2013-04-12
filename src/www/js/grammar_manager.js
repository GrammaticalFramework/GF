/* --- Grammar Manager object ----------------------------------------------- */
/*
This object stores the state for:
- grammar
- startcat
- languages

Hooks which actions can be hooked to:
- onload
- change_grammar
- change_startcat
- change_languages

*/
function GrammarManager(server,opts) {
    var t = this;
    /* --- Configuration ---------------------------------------------------- */

    // default values
    this.options = {
        initial: {}
    };
    this.actions = {
        onload: [
            function(gm){ debug("default action: onload"); }
        ],
        change_grammar: [
            function(grammar){ debug("default action: change grammar"); }
        ],
        change_startcat: [
            function(startcat){ debug("default action: change startcat"); }
        ],
        change_languages: [
            function(languages){ debug("default action: change languages"); }
        ]
    }

    // Apply supplied options
    if(opts) for(var o in opts) this.options[o]=opts[o];

    /* --- Client state initialisation -------------------------------------- */
    this.server = server;
    this.grammar = null; // current grammar
    this.grammars=[];
    this.grammar_dirs=[];
    this.startcat = null; // current startcat
    this.languages = this.options.initial.languages || [];
                     // current languages (empty means all langs)

    /* --- Main program, this gets things going ----------------------------- */
    this.init=function(){
        this.server.get_grammarlists(bind(this.onload,this));
    }
    this.init();
}

// 
//GrammarManager.prototype.update_grammar_list=function(dir,grammar_names,dir_count) {
GrammarManager.prototype.onload=function(dir,grammar_names,dir_count) {
    var t=this;
    t.grammars=[];
    t.grammar_dirs=[];
    t.grammar_dirs.push(dir);
    t.grammars=t.grammars.concat(grammar_names.map(function(g){return dir+g}));
    var grammar0=t.options.initial.grammar || t.grammars[0];
    t.change_grammar(grammar0);

    // Execute hooked actions
    t.run_actions("onload",dir,grammar_names,dir_count);
}

/* --- Registering / unregistering actions to hooks ------------------------- */

GrammarManager.prototype.register_action=function(hook,action) {
    var hookring = this.actions[hook];
    hookring.push(action);
}

GrammarManager.prototype.unregister_action=function(hook,action) {
    var hookring = this.actions[hook];
    for (var f=0; f < hookring.length; f++) {
        if (hookring[f] == action) {
            hookring = Array.remove(hookring, f);
        }
    }
}

// Execute actions for a given hook
// TODO: any number of arguments
GrammarManager.prototype.run_actions=function(hook,arg1,arg2,arg3) {
    var acts = this.actions[hook];
    for (f in acts) {
        acts[f](arg1,arg2,arg3);
    }
}

/* --- Grammar -------------------------------------------------------------- */

// API
GrammarManager.prototype.change_grammar=function(grammar_url) {
    var t=this;
    t.server.switch_to_other_grammar(grammar_url, function() {
	t.server.grammar_info(function(grammar){
            // Set internal state
            t.grammar = grammar;

            // Call internal functions
            t.update_startcat(grammar);
            t.update_language_list(grammar);

            // Execute hooked actions
            t.run_actions("change_grammar",grammar);
        });
    });
}

/* --- Start category ------------------------------------------------------- */

// Internal
// Sets default startcat for grammar
GrammarManager.prototype.update_startcat=function(grammar) {
    var t=this;
    var cats=grammar.categories;
    var startcat0 = t.options.initial.startcat;
    if (elem(startcat0, cats))
        t.startcat = startcat0;
    else
        t.startcat = grammar.startcat;
}

// API
GrammarManager.prototype.change_startcat=function(startcat) {
    var t = this;

    // Set internal state
    t.startcat = startcat;

    // Call internal functions
    // ...
    
    // Execute hooked actions
    t.run_actions("change_startcat",startcat);
}

/* --- Languages ------------------------------------------------------------ */

// Internal
// Sets default languages for grammar
GrammarManager.prototype.update_language_list=function(grammar) {
    var t = this;
    function langpart(conc,abs) { // langpart("FoodsEng","Foods") == "Eng"
        return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
    }
    // Replace the options in the menu with the languages in the grammar
    var langs=grammar.languages;
    for(var i=0; i<langs.length; i++) {
	var ln=langs[i].name; // "PhrasebookEng"
	if(!hasPrefix(ln,"Disamb")) {
	    var lp=langpart(ln,grammar.name); // "Eng"
            if (elem(lp, t.options.initial.languages)) {
                t.languages.push(ln);
            }
	}
    }
}

// API
GrammarManager.prototype.change_languages=function(languages) {
    var t = this;

    // Set internal state
    t.languages = languages;

    // Call internal functions
    // ...

    // Execute hooked actions
    t.run_actions("change_languages",languages);
}

