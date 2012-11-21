/* --- Editor Menu object --------------------------------------------------- */
function EditorMenu(editor,opts) {
    var t = this;
    /* --- Configuration ---------------------------------------------------- */

    // default values for options:
    this.options={
	target: "editor"
    }

    // Apply supplied options
    if(opts) for(var o in opts) this.options[o]=opts[o];

    /* --- Creating UI components ------------------------------------------- */
    this.container = editor.ui.menubar;
    this.ui = {
	grammar_menu: empty_id("select","grammar_menu"),
        startcat_menu: empty("select"),
        to_toggle: button("Languages...", function(){
            var sel = t.ui.to_menu;
            if (sel.classList.contains("hidden"))
                sel.classList.remove("hidden")
            else
                sel.classList.add("hidden")
        }),
        to_menu: node("select",{
            id: "to_menu",
            multiple: "multiple",
            class: "hidden"
        }),
        clear_button: button("Clear", function(){
            t.editor.delete_refinement();
        }),
        random_button: button("Random", function(){
            t.editor.generate_random();
        }),
    };
    with(this.ui) {
        if (this.options.show.grammar_menu) {
	    appendChildren(this.container, [text(" Grammar: "), grammar_menu]);
    	    grammar_menu.onchange = bind(this.change_grammar,this);
        }
        if (this.options.show.startcat_menu) {
	    appendChildren(this.container, [text(" Startcat: "), startcat_menu]);
            startcat_menu.onchange = bind(this.change_startcat,this);
        }
        if (this.options.show.to_menu) {
            appendChildren(this.container, [text(" To: "), to_toggle, to_menu]);
            to_menu.onchange = bind(this.change_language,this);
        }
        appendChildren(this.container, [clear_button]);
        if (this.options.show.random_button) {
            appendChildren(this.container, [random_button]);
        }
    }

    /* --- Client state initialisation -------------------------------------- */
    this.editor = editor;
    this.server = editor.server;

    /* --- Main program, this gets things going ----------------------------- */
    this.server.get_grammarlists(bind(this.show_grammarlist,this));
}

/* --- Grammar menu --------------------------------------------------------- */

// Basically called once, when initializing
// Copied from minibar.js
EditorMenu.prototype.show_grammarlist=function(dir,grammar_names,dir_count) {
    var t=this;
    var first_time=t.ui.grammar_menu.options.length == 0;
    if(first_time) {
	t.grammars=[];
	t.grammar_dirs=[];
    }
    t.grammar_dirs.push(dir);
    t.grammars=t.grammars.concat(grammar_names.map(function(g){return dir+g}))
    function glabel(g) {
	return hasPrefix(dir,"/tmp/gfse.") ? "gfse: "+g : g
    }
    function opt(g) { return option(glabel(g),dir+g); }
    appendChildren(t.ui.grammar_menu, map(opt, grammar_names));
    function pick_first_grammar() {
	if(t.timeout) clearTimeout(t.timeout),t.timeout=null;
	var grammar0=t.options.initial.grammar;
	if(!grammar0) grammar0=t.grammars[0];
	t.ui.grammar_menu.value=grammar0;
	t.change_grammar();
    }
    // Wait at most 1.5s before showing the grammar menu.
    if(first_time) t.timeout=setTimeout(pick_first_grammar,1500);
    if(t.grammar_dirs.length>=dir_count) pick_first_grammar();
}

// Copied from minibar.js
EditorMenu.prototype.change_grammar=function() {
    var t=this;
    var grammar_url = t.ui.grammar_menu.value;
    t.server.switch_to_other_grammar(grammar_url, function() {
	t.server.grammar_info(function(grammar){
            t.update_startcat_menu(grammar);
            t.update_language_menu(t.ui.to_menu, grammar);

            // Call in main Editor object
            t.editor.change_grammar(grammar);
        });
    });
}

/* --- Start category menu -------------------------------------------------- */

// Called each time the current grammar is changed!
// Copied from minibar_input.js
EditorMenu.prototype.update_startcat_menu=function(grammar) {
    var t=this;
    var menu=this.ui.startcat_menu;
    menu.innerHTML="";
    var cats=grammar.categories;
    for(var cat in cats) menu.appendChild(option(cats[cat],cats[cat]))
//    var startcat=this.local.get("startcat") || grammar.startcat;
    var startcat0 = t.options.initial.startcat;
    if (elem(startcat0, cats))
        menu.value = startcat0;
    else
        menu.value = grammar.startcat;
    // else {
    //     insertFirst(menu,option("Default",""));
    //     menu.value="";
    // }
}

// 
EditorMenu.prototype.change_startcat=function() {
    var new_startcat = this.ui.startcat_menu.value;
    this.editor.change_startcat(new_startcat);
}

/* --- Langugage (to) menu -------------------------------------------------- */

// Called each time the current grammar is changed!
// Copied from minibar_support.js
EditorMenu.prototype.update_language_menu=function(menu,grammar) {
    var t = this;
    function langpart(conc,abs) { // langpart("FoodsEng","Foods") == "Eng"
        return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
    }
    // Replace the options in the menu with the languages in the grammar
    var langs=grammar.languages;
    menu.innerHTML="";
	
    for(var i=0; i<langs.length; i++) {
	var ln=langs[i].name;
	if(!hasPrefix(ln,"Disamb")) {
	    var lp=langpart(ln,grammar.name);
            var opt=option(lp,ln);
            if (elem(lp, t.options.initial.languages)) {
                opt.selected=true;
                t.editor.languages.push(opt.value);
            }
	    menu.appendChild(opt);
	}
    }
}

// 
EditorMenu.prototype.change_language=function() {
    this.editor.languages = new Array();
    for (i in this.ui.to_menu.options) {
        var opt = this.ui.to_menu.options[i];
        if (opt.selected)
            this.editor.languages.push(opt.value);
    }
    this.editor.update_linearisation();
}

