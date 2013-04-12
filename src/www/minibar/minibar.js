/* minibar.js
needs: minibar_support.js, minibar_input.js, minibar_translations.js, support.js
*/

/*
// This is essentially what happens when you call start_minibar:
if(server.grammar_list) grammars=server.grammar_list;
else grammars=server.get_grammarlist();
show_grammarlist(grammars)
select_grammar(grammars[0])
grammar_info=server.get_languages()
show_languages(grammar_info)
new_language()
complete_output=get_completions()
show_completions(complete_output)
*/

// For backward compatibility:
function start_minibar(server,opts,target) {
    if(target) opts.target=target;
    return new Minibar(server,opts);
}

/* --- Main Minibar object -------------------------------------------------- */
function Minibar(server,opts) {
    // Contructor, typically called when the HTML document is loaded

    /* --- Configuration ---------------------------------------------------- */

    // default values for options:
    this.options={
	target: "minibar",
	try_google: true,
	feedback_url: null,
	help_url: null,
	initial_grammar: null
    }

    // Apply supplied options
    this.server=server;
    if(opts) for(var o in opts) this.options[o]=opts[o];

    /* --- Syntax editor integration ---------------------------------------- */
    if(!this.options.abstract_action) this.integrate_syntax_editor()

    /* --- Creating the components of the minibar --------------------------- */
    this.translations=new Translations(server,this.options)
    this.input=new Input(server,this.translations,this.options)

    /* --- Creating user interface elements --------------------------------- */

    this.menubar=div_class("menubar");
    this.extra=div_id("extra");

    this.minibar=element(this.options.target);
    this.minibar.innerHTML="";
    with(this) {
	appendChildren(menubar,[input.menus,translations.menus,input.buttons])
	appendChildren(minibar,[menubar,input.main,translations.main,extra]);
	if(options.help_url)
	    menubar.appendChild(button("Help",bind(open_help,this)));
	append_extra_buttons(extra,options);
    }
    this.set_hidden = function(b) {
	this.hidden=b
	this.minibar.style.display= b ? "none" : ""
    }
    this.hide = function() { this.set_hidden(true); }
    this.show = function() { this.set_hidden(false); }

    /* --- Minibar client state initialisation ------------------------------ */
    this.grammar=null;

    /* --- Main program, this gets things going ----------------------------- */
    with(this) {
	server.get_grammarlists(bind(show_grammarlist,this));
    }
}

Minibar.prototype.integrate_syntax_editor=function() {
    var minibar=this
    var editor_target="syntax_editor"
    var e=element(editor_target)
    if(!e || !window.Editor) return

    e.style.display="none"
    minibar.options.abstract_action=function(tree) {
	var editor_options = {
	    target: editor_target,
	    show_startcat_menu: minibar.input.options.startcat_menu,
	    initial: { grammar: minibar.grammar_menu.value, // hmm
		       startcat: minibar.input.startcat_menu.value, // hmm
		       languages: minibar.translations.toLangs, // hmm
		       abstr: tree
		     },
	    lin_action: function(new_input,langFrom) {
		console.log(editor.menu.ui.grammar_menu.value)
		var grammar_url=editor.menu.ui.grammar_menu.value // hmm
		                || minibar.server.current_grammar_url // hmm
		var startcat=editor.get_startcat()
		             || minibar.input.startcat_menu.value // hmm
		var toLangs=gm.languages // hmm
		minibar.input.set_input_for(grammar_url,
					    {from:langFrom,
					     startcat:startcat,
					     input:gf_lex(new_input)})
		minibar.translations.set_toLangs_for(grammar_url,toLangs)

		//Better: keep editor around and reactivate it next time:
		editor.hide()
		// ...

		//Easier: delete the editor and create a new one next time:
		clear(editor.container)
		editor=minibar.editor=null;

		// Even if the grammar is the same as before, this call is
		// what eventually triggers the new_input to be loaded:
		minibar.select_grammar(grammar_url)

		// Make the minibar visible again
		minibar.show()
	    }
	}
	minibar.hide()
        var gm = new GrammarManager(minibar.server,editor_options);
	var editor=minibar.editor=new Editor(gm,editor_options)
	editor.show()
    }
}

Minibar.prototype.get_current_input=function(cont) {
    var t=this
    if(!t.hidden) cont(gf_unlex(t.input.current.input))
    else {
	var tree=t.editor.get_ast()
	function pick(lins) { cont(lins[0].text) }
	t.server.linearize({tree:tree,to:t.input.current.from},pick)
    }
}

Minibar.prototype.show_grammarlist=function(dir,grammar_names,dir_count) {
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
		insertFirst(t.menubar,title("Show grammar info",button("i",bind(t.show_grammarinfo,t))))
		insertFirst(t.menubar,t.grammar_menu);
		insertFirst(t.menubar,text("Grammar: "));
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

Minibar.prototype.select_grammar=function(grammar_url) {
    var t=this;
    //debug("select_grammar ");
    function change_grammar() {
	t.server.grammar_info(bind(t.change_grammar,t));
    }
    t.server.switch_to_other_grammar(grammar_url,change_grammar);
}

Minibar.prototype.change_grammar=function(grammar_info) {
    var t=this;
    with(t) {
	//debug("show_languages ");
	grammar=grammar_info;

	input.change_grammar(grammar)
	translations.change_grammar(grammar)
    }
}

Minibar.prototype.show_grammarinfo=function() {
    var t=this
    var g=this.grammar;
    function draw_cats(cats) {
	function draw_cat(cat) {
	    var i=cats[cat]
	    return tr([td(text(i.def)),
		       td(text(i.producers.join(", "))),
		       td(text(i.consumers.join(", ")))])
	}
	var table=wrap_class("table","browse",g.categories.map(draw_cat))
	var hdr=tr([th(text("Category")),
		    th(text("Producers")),
		    th(text("Consumers"))])
	insertFirst(table,hdr)
	return table
    }
    function draw_funs(funs) {
	function draw_fun(fun) {
	    var def=funs[fun].def.split(":")
	    return tr([td(text(def[0])),td(text(":")),td(text(def[1]||""))])
	}
	return div_class("browse",wrap("table",g.functions.map(draw_fun)))
    }
    function draw_more(info) {
	replaceChildren(cats,draw_cats(info.cats))
	replaceChildren(funs,draw_funs(info.funs))
	btn.disabled=true;
    }

    function more() { t.server.browse({},draw_more) }

    var cats=wrap("div",text(g.categories.join(", ")))
    var funs=wrap("div",text(g.functions.join(", ")))
    var btn=button("More info",more)

    clear(t.translations.main)
    appendChildren(this.translations.main,
		   [wrap("h3",text(g.name)),
		    btn,
		    wrap("h4",text("Start category")), text(g.startcat || ""),
		    wrap("h4",text("Categories")), cats,
		    wrap("h4",text("Functions")), funs])
}

Minibar.prototype.append_extra_buttons=function(extra,options) {
    with(this) {
	if(options.try_google)
	    extra.appendChild(button("Try Google Translate",bind(try_google,this)));
	if(options.feedback_url) {
	    var b=button("Feedback",bind(open_feedback,this));
	    b.title="Click to suggest improvements. Select a language in the To: menu first to suggest a better translation to that language."
	    appendChildren(extra,[text(" "),b]);
	}
    }
}

Minibar.prototype.try_google=function() {
    with(this) {
	var to=translations.target_lang();
	var s=gf_unlex(input.current.input);
	if(input.surface.typed) s+=" "+input.surface.typed.value;
	var url="http://translate.google.com/?sl="
	        +langpart(input.current.from,grammar.name);
	if(to!="All") url+="&tl="+to;
	url+="&q="+encodeURIComponent(s);
	window.open(url);
    }
}

Minibar.prototype.open_help=function() {
    with(this) open_popup(options.help_url,"help");
}

Minibar.prototype.open_feedback=function() {
    with(this) {
	// make the minibar state easily accessible from the feedback page:
	minibar.state={grammar:grammar,current:input.current,
		       to:translations.to_menu.value,
		       translations:translations.main};
	open_popup(options.feedback_url,'feedback');
    }
}

// This function is called from feedback.html
function prefill_feedback_form() {
    var state=opener_element("minibar").state;
    var trans=state.translations;
    var gn=state.grammar.name
    var to=langpart(state.to,gn);

    var form=document.forms.namedItem("feedback");
    setField(form,"grammar",gn);
    setField(form,"from",langpart(state.current.from,gn));
    setField(form,"input",gf_unlex(state.current.input));
    setField(form,"to",to);
    if(to=="All") element("translation_box").innerHTML=" To suggest a better translation to a particular language, select that language in the To: menu before pressing the Feedback button."
    else setField(form,"translation",trans.single_translation.join(" / "));
    
    // Browser info:
    form["inner_size"].value=window.innerWidth+"×"+window.innerHeight;
    form["outer_size"].value=window.outerWidth+"×"+window.outerHeight;
    form["screen_size"].value=screen.width+"×"+screen.height;
    form["available_screen_size"].value=screen.availWidth+"×"+screen.availHeight;
    form["color_depth"].value=screen.colorDepth;
    form["pixel_depth"].value=screen.pixelDepth;

    window.focus();
}
    

/*
se.chalmers.cs.gf.gwt.TranslateApp/align-btn.png

GET /grammars/Foods.pgf?&command=abstrtree&tree=Pred+(This+Fish)+(Very+Fresh)
GET /grammars/Foods.pgf?&command=parsetree&tree=Pred+(This+Fish)+Expensive&from=FoodsAfr
GET /grammars/Foods.pgf?&command=alignment&tree=Pred+(This+Fish)+Expensive
*/
