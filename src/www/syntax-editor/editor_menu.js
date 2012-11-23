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
        debug_toggle: button("⚙", function(){
            var sel = element("debug");
            if (sel.classList.contains("hidden"))
                sel.classList.remove("hidden")
            else
                sel.classList.add("hidden")
        }),
    };
    if (t.options.show.grammar_menu) {
	appendChildren(t.container, [text(" Grammar: "), t.ui.grammar_menu]);
    	t.ui.grammar_menu.onchange = function(){
            var grammar_url = t.ui.grammar_menu.value;
            t.gm.change_grammar(grammar_url);
        }
    }
    if (t.options.show.startcat_menu) {
	appendChildren(t.container, [text(" Startcat: "), t.ui.startcat_menu]);
        t.ui.startcat_menu.onchange = function(){
            var startcat = t.ui.startcat_menu.value;
            t.gm.change_startcat(startcat);
        }
    }
    if (t.options.show.to_menu) {
        appendChildren(t.container, [text(" To: "), t.ui.to_toggle, t.ui.to_menu]);
        t.ui.to_menu.onchange = function(){
            var languages = new Array();
            for (i in t.ui.to_menu.options) {
                var opt = t.ui.to_menu.options[i];
                if (opt.selected)
                    languages.push(opt.value);
            }
            t.gm.change_languages(languages);
        }
    }
    appendChildren(t.container, [t.ui.clear_button]);
    if (t.options.show.random_button) {
        appendChildren(t.container, [t.ui.random_button]);
    }
    appendChildren(t.container, [t.ui.debug_toggle]);

    /* --- Client state initialisation -------------------------------------- */
    this.editor = editor;
    this.gm = editor.gm;
    this.server = editor.server;

    /* --- Register Grammar Manager hooks ----------------------------------- */
    this.gm.register_action("onload", bind(this.hook_onload, this));
    this.gm.register_action("change_grammar", bind(this.hook_change_grammar, this));
    // this.gm.register_action("change_startcat", bind(this.hook_change_startcat, this));
    // this.gm.register_action("change_languages", bind(this.hook_change_languages, this));

}

/* --- Grammar menu --------------------------------------------------------- */

// show the grammar list
EditorMenu.prototype.hook_onload=function(dir,grammar_names,dir_count) {
    debug("EditorMenu: onload");
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
//	t.change_grammar();
    }
    // Wait at most 1.5s before showing the grammar menu.
    if(first_time) t.timeout=setTimeout(pick_first_grammar,1500);
    if(t.grammar_dirs.length>=dir_count) pick_first_grammar();
}

// Copied from minibar.js
EditorMenu.prototype.hook_change_grammar=function() {
    debug("EditorMenu: change grammar");
    var t=this;
    var grammar_url = t.ui.grammar_menu.value;
    t.server.switch_to_other_grammar(grammar_url, function() {
	t.server.grammar_info(function(grammar){
            t.update_startcat_menu(grammar);
            t.update_language_menu(t.ui.to_menu, grammar);
        });
    });
}

/* --- Start category menu -------------------------------------------------- */

// Called from hook_change_grammar
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

/* --- Langugage (to) menu -------------------------------------------------- */

// Called from hook_change_grammar
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

