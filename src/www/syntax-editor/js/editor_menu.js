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
        startcat_menu: empty("select"),
        to_toggle: button("...", function(){
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
	appendChildren(this.container, [text(" Startcat: "),startcat_menu]);
        appendChildren(this.container, [text(" To: "), to_toggle, to_menu]);
        appendChildren(this.container, [clear_button, random_button]);
        // appendChildren(this.container, [clear_button]);
        startcat_menu.onchange=bind(this.change_startcat,this);
        to_menu.onchange=bind(this.change_language,this);
    }

    /* --- Client state initialisation -------------------------------------- */
    this.editor = editor;
    this.server = editor.server;

    /* --- Main program, this gets things going ----------------------------- */
    with(this) {
	server.get_grammarlists(bind(show_grammarlist,this));
    }
}

// Copied from minibar.js
EditorMenu.prototype.show_grammarlist=function(dir,grammar_names,dir_count) {
    var t=this;
    var first_time= !t.grammar_menu
    if(first_time) {
	t.grammar_menu=empty_id("select","grammar_menu");
	t.grammars=[];
	t.grammar_dirs=[];
    }
    with(t) {
	grammar_dirs.push(dir);
	grammars=grammars.concat(grammar_names.map(function(g){return dir+g}))
	function glabel(g) {
	    return hasPrefix(dir,"/tmp/gfse.") ? "gfse: "+g : g
	}
	function opt(g) { return option(glabel(g),dir+g); }
	appendChildren(grammar_menu,map(opt,grammar_names));
	function pick() {
	    var grammar_url=grammar_menu.value
	    if(window.localStorage)
		localStorage["gf.minibar.last_grammar"]=grammar_url;
	    t.select_grammar(grammar_url);
	}
	function pick_first_grammar() {
	    if(t.timeout) clearTimeout(t.timeout),t.timeout=null;
	    if(t.grammar_menu.length>1 && !t.grammar_menu.parentElement) {
    		t.grammar_menu.onchange=pick;
//		insertFirst(t.menubar,button("i",bind(t.show_grammarinfo,t)))
		insertFirst(t.container,t.grammar_menu);
		insertFirst(t.container,text("Grammar: "));
	    }
	    var grammar0=t.options.initial_grammar
	    if(!grammar0 && window.localStorage) {
		var last_grammar=localStorage["gf.minibar.last_grammar"];
		if(last_grammar && elem(last_grammar,t.grammars))
		    grammar0=last_grammar;
	    }
	    if(!grammar0) grammar0=t.grammars[0];
	    t.grammar_menu.value=grammar0;
	    t.select_grammar(grammar0);
	}
	// Wait at most 1.5s before showing the grammar menu.
	if(first_time) t.timeout=setTimeout(pick_first_grammar,1500);
	if(t.grammar_dirs.length>=dir_count) pick_first_grammar();
    }
}

// Copied from minibar.js
EditorMenu.prototype.select_grammar=function(grammar_url) {
    var t=this;
    //debug("select_grammar ");
    t.server.switch_to_other_grammar(grammar_url, function() {
	t.server.grammar_info(function(grammar){
            t.update_language_menu(t.ui.to_menu, grammar);
            t.update_startcat_menu(grammar);

            // Call in main Editor object
            t.editor.change_grammar(grammar);
        });
    });
}

// Copied from minibar_input.js
EditorMenu.prototype.update_startcat_menu=function(grammar) {
    var menu=this.ui.startcat_menu;
    menu.innerHTML="";
    var cats=grammar.categories;
    for(var cat in cats) menu.appendChild(option(cats[cat],cats[cat]))
//    var startcat=this.local.get("startcat") || grammar.startcat;
    var startcat= grammar.startcat;
    if(startcat) menu.value=startcat;
    else {
	insertFirst(menu,option("Default",""));
	menu.value="";
    }
}

// 
EditorMenu.prototype.change_startcat=function () {
    var new_startcat = this.ui.startcat_menu.value;
    this.editor.change_startcat(new_startcat);
}

// 
EditorMenu.prototype.change_language=function () {
    this.editor.languages = new Array();
    for (i in this.ui.to_menu.options) {
        var opt = this.ui.to_menu.options[i];
        if (opt.selected)
            this.editor.languages.push(opt.value);
    }
    this.editor.update_linearisation();
}

// Copied from minibar_support.js
EditorMenu.prototype.update_language_menu=function(menu,grammar) {

    function langpart(conc,abs) { // langpart("FoodsEng","Foods") == "Eng"
        return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
    }

    // Replace the options in the menu with the languages in the grammar
    var lang=grammar.languages;
    menu.innerHTML="";
	
    for(var i=0; i<lang.length; i++) {
	var ln=lang[i].name;
	if(!hasPrefix(ln,"Disamb")) {
	    var lp=langpart(ln,grammar.name);
	    menu.appendChild(option(lp,ln));
	}
    }
    // insertFirst(menu,option("All","All"));
    // menu.value="All";
}



