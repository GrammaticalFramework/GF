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
    if(opts) for(var o in opts) this.options[o]=opts[o];

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
    this.hide = function() {
        this.minibar.style.display="none";
    }
    this.show = function() {
        this.minibar.style.display="block";
    }

    /* --- Minibar client state initialisation ------------------------------ */
    this.grammar=null;

    this.server=server;

    /* --- Main program, this gets things going ----------------------------- */
    with(this) {
	server.get_grammarlists(bind(show_grammarlist,this));
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
		insertFirst(t.menubar,button("i",bind(t.show_grammarinfo,t)))
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
    this.translations.main.innerHTML=""
    var g=this.grammar;
    appendChildren(this.translations.main,
		   [wrap("h3",text(g.name)),
		    node("dl",{},
			 [dt(text("Start category")),
			  dd(text(g.startcat || "")),
			  dt(text("Categories")),
			  dd(text(g.categories.join(", "))),
			  dt(text("Functions")),
			  dd(text(g.functions.join(", ")))])])
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
