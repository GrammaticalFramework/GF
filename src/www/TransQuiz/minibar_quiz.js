// Copyright © Elnaz Abolahrar and Thomas Hallgren, 2011

// minibar.js, assumes that support.js has also been loaded

var tree_icon="tree-btn.png";

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

function Minibar(server,opts,target) {
    // Typically called when the HTML document is loaded

    /* --- Configuration ---------------------------------------------------- */

    // default values for options:
    this.options={
	show_abstract: false,
	show_trees: false,
	show_grouped_translations: true,
	delete_button_text: "⌫",
	default_source_language: null,
	
	//modified for quiz
	try_google: false,
	
	feedback_url: null,
	
	//modified for quiz
	random_button: false,
	
	help_url: null
    }

    // Apply supplied options
    if(opts) for(var o in opts) this.options[o]=opts[o];

    /* --- Creating user interface elements --------------------------------- */

    this.surface=div_id("surface");
    this.extra=div_id("extra");
    this.menubar=div_id("menubar");
	this.quizbar=div_id("quizbar");
    this.words=div_id("words");
    this.translations=div_id("translations");

    this.minibar=element(target || "minibar");
	this.minibar_contin=element("minibar_contin");
    this.minibar_buttons=element("minibar_buttons");
    this.minibar.innerHTML="";
	
	//modified for quiz
    with(this) {
	appendChildren(minibar,[menubar, quizbar]);
	appendChildren(minibar_contin,[surface,words]);
	append_extra_buttons(extra,options);
    }

    // Filled in and added to minibar later:
    this.grammar_menu=empty_id("select","grammar_menu");
    this.from_menu=empty_id("select","from_menu");
    this.to_menu=empty_id("select","to_menu");
	

    /* --- Minibar client state initialisation ------------------------------ */
    this.grammar=null;
	
	//modified for quiz
    this.current={from: null, to:null, input: ""};
	
    this.previous=null;

    this.server=server;

    /* --- Main program, this gets things going ----------------------------- */
    with(this) {
	if(server.grammar_list) show_grammarlist(server.grammar_list);
	else server.get_grammarlist(bind(show_grammarlist,this));
    }
}

/* --- Auxiliary functions ---------------------------------------------- */


Minibar.prototype.show_grammarlist=function(grammars) {
    debug(this)
    with(this) {
	//debug("show_grammarlist ")
	menubar.innerHTML="";
	if(grammars.length>0) {
	    function opt(g) { return option(g,g); }
	    appendChildren(grammar_menu,map(opt,grammars));
    	    grammar_menu.onchange=
		bind(function() { select_grammar(grammar_menu.value); },this);
	    appendChildren(menubar,[text("Grammar: "),grammar_menu]);
	}
	//modified for quiz
	appendChildren(menubar,
		       [text(" From: "), from_menu,
			    text(" To: "), to_menu]);
	//modified for quiz
	appendChildren(minibar_buttons,
			[button(options.delete_button_text,bind(delete_last,this),"H"),
			button("Clear",bind(clear_all,this),"L")]);
					
	if(options.random_button)
	    menubar.appendChild(button("Random",bind(generate_random,this),"R"));
	if(options.help_url)
	    menubar.appendChild(button("Help",bind(open_help,this)));
		
	select_grammar(grammars[0]);
    }
}

Minibar.prototype.select_grammar=function(grammar_name) {
    var t=this;
    //debug("select_grammar ");
    function get_languages() {
	t.server.get_languages(bind(t.show_languages,t));
    }
    t.server.switch_grammar(grammar_name,get_languages);
}

Minibar.prototype.show_languages=function(grammar_info) {
    var t=this;
    with(t) {
	//debug("show_languages ");
	grammar=grammar_info;

	var new_language=function () {
	    current.from=from_menu.value;
		
		//modified for quiz
	    //clear_all();
	}
	
	//added for quiz
	var change_tolang=function () {
	    current.to=to_menu.value;
		
		//var langname = element("to_menu").value;
	    //to_menu.current={to: langname, input: ""};
		//clear_all();
	}
	
	from_menu.onchange=bind(new_language,t);
	update_language_menu(from_menu,grammar);
	set_initial_language(options,from_menu,grammar);
    
	//modified and added for quiz
	//to_menu.onchange=bind(get_translations,t);
    to_menu.onchange=bind(change_tolang,t);
	
	update_language_menu(to_menu,grammar);
	
	//modified for quiz
	//insertFirst(to_menu,option("All","All"));
	//to_menu.value="All";

	new_language();
	
	//added for quiz
	change_tolang();
    }
}

Minibar.prototype.clear_all1=function() {
    with(this) {
	remove_typed_input();
	current.input="";
	previous=null;
	surface.innerHTML="";
	translations.innerHTML="";
    }
	
	//added for quiz
	document.answer.answer_text.value = "";
	document.explanation.explanation_text.value= "";	
	document.getElementById("hint_txt").innerHTML = "";
}

Minibar.prototype.clear_all=function() {
    with(this) {
	clear_all1();
	get_completions();
    }
}

Minibar.prototype.get_completions=function() {
	  
    with(this) {
	//debug("get_completions ");
	words.innerHTML="...";
	
	//modified for quiz
	server.complete(current.to,current.input,bind(show_completions,this));
    }
}

Minibar.prototype.show_completions=function(complete_output) {
    with(this) {
	//debug("show_completions ");
	var completions=complete_output[0].completions;
	var emptycnt=add_completions(completions)
	if(true/*emptycnt>0*/) get_translations();
	else translations.innerHTML="";
	if(surface.typed && emptycnt==completions.length) {
	    if(surface.typed.value=="") remove_typed_input();
	}
	else add_typed_input();
    }
	
	//added for quiz :updates the hint and prevents the check_notEmpty alert in show_hint when all words are deleted
    if (!(document.answer.answer_text.value == null || document.answer.answer_text.value ==""))
	  { if (hint_times > 0  && hint_times < max_hint_times)
	    show_hint();
		}	  
    else 
	  document.getElementById("hint_txt").innerHTML = "";
}

Minibar.prototype.add_completions=function(completions) {
    with(this) {
	if(words.timeout) clearTimeout(words.timeout),words.timeout=null;
	words.innerHTML="";
	words.completions=completions;
	words.word=[];
	var t=surface.typed ? surface.typed.value : "";
	var emptycnt=0;
	for(var i=0;i<completions.length;i++) {
	    var s=completions[i];
	    if(s.length>0) {
		var w=word(s);
		words.appendChild(w);
		words.word[i]=w;
	    }
	    else emptycnt++;
	}
	filter_completions(t,true);
	return emptycnt;
    }
}

Minibar.prototype.filter_completions=function(t,dim) {
    with(this) {
	if(words.timeout) clearTimeout(words.timeout),words.timeout=null;
	words.filtered=t;
	//if(dim) debug('filter "'+t+'"');
	var w=words.word;
	words.count=0;
	var dimmed=0;
	var prefix=""; // longest common prefix, for completion
	for(var i=0;i<w.length;i++) {
	    var s=words.completions[i];
	    var keep=hasPrefix(s,t);
	    if(keep) {
		if(words.count==0) prefix=s;
		else prefix=(commonPrefix(prefix,s));
		words.count++;
	    }
	    if(dim) {
		w[i].style.opacity= keep ? "1" : "0.5";
		if(keep) w[i].style.display="inline";
		else dimmed++;
	    }
	    else 
		w[i].style.display=keep ? "inline" : "none";
	}
	words.theword=prefix;
	if(dimmed>0)
	    words.timeout=setTimeout(function(){ filter_completions(t,false)},1000);
    }
}
 
Minibar.prototype.get_translations=function() {
    with(this) {
	var c=current;
	if(options.show_grouped_translations)
	    server.translategroup(c.from,c.input,bind(show_groupedtranslations,this));
	else
	    server.translate(c.from,c.input,bind(show_translations,this));
    }
}

Minibar.prototype.target_lang=function() {
    with(this) return langpart(to_menu.value,grammar.name);
}

Minibar.prototype.add_typed_input=function() {
    with(this) {
	var inp;
	if(surface.typed) inp=surface.typed;
	else {
	    inp=empty("input","type","text");
	    inp.value="";
	    inp.setAttribute("accesskey","t");
	    inp.style.width="10em";
	    inp.onkeyup=bind(complete_typed,this);
	    surface.appendChild(inp);
	    surface.typed=inp;
	}
	inp.focus();
    }
}

Minibar.prototype.remove_typed_input=function() {
    with(this) {
	if(surface.typed) {
	    surface.typed.parentNode.removeChild(surface.typed);
	    surface.typed=null;
	}
    }
}

Minibar.prototype.complete_typed=function(event) {
    with(this) {
	//element("debug").innerHTML=show_props(event,"event");
	var inp=surface.typed;
	//debug('"'+inp.value+'"');
	var s=inp.value;
	var ws=s.split(" ");
	if(ws.length>1 || event.keyCode==13) {
	    if(ws[0]!=words.filtered) filter_completions(ws[0],true);
	    if(words.count==1) add_word(words.theword);
	    else if(elem(ws[0],words.completions)) add_word(ws[0]);
	    else if(words.theword.length>ws[0].length) inp.value=words.theword;
	}
	else if(s!=words.filtered) filter_completions(s,true)
    }
}

Minibar.prototype.generate_random=function() {
    var t=this;
    function show_random(random) {
	t.clear_all1();
	t.add_words(random[0].text);
    }
    
    function lin_random(abs) {
	t.server.linearize(abs[0].tree,t.current.from,show_random);
    }
    t.server.get_random(lin_random);
}

Minibar.prototype.add_words=function(s) {
    with(this) {
	var ws=s.split(" ");
	for(var i=0;i<ws.length;i++)
	    add_word1(ws[i]+" ");
	get_completions();
    }
	//added for quiz
    document.answer.answer_text.value += s+" ";	
}

Minibar.prototype.word=function(s) { 
    var t=this;
    function click_word() {
	if(t.surface.typed) t.surface.typed.value="";
	t.add_word(s);
    }
    return button(s,click_word);
}

Minibar.prototype.add_word=function(s) {
    with(this) {
	add_word1(s+" ");
	if(surface.typed) {
	    var s2;
	    if(hasPrefix(s2=surface.typed.value,s)) {
		s2=s2.substr(s.length);
		while(s2.length>0 && s2[0]==" ") s2=s2.substr(1);
		surface.typed.value=s2;
	    }
	    else surface.typed.value="";
	}
	get_completions();
    }
	
	//added for quiz
    document.answer.answer_text.value += s+" ";
}

Minibar.prototype.add_word1=function(s) {
    with(this) {
	previous={ input: current.input, previous: previous };
	current.input+=s;
	var w=span_class("word",text(s));
	if(surface.typed) surface.insertBefore(w,surface.typed);
	else surface.appendChild(w);
    }
}

Minibar.prototype.delete_last=function() {
    with(this) {
	if(surface.typed && surface.typed.value!="")
	    surface.typed.value="";
	else if(previous) {
	    current.input=previous.input;
	    previous=previous.previous;
	    if(surface.typed) {
		surface.removeChild(surface.typed.previousSibling);
		surface.typed.focus();
	    }
	    else surface.removeChild(surface.lastChild);
	    translations.innerHTML="";
		
		//added for quiz (to update the user answer area)
	    var last_answer= document.answer.answer_text.value ;
	    document.answer.answer_text.value = remove_last(last_answer);
		
	    get_completions();
	}
    }
}

	//added for quiz
    function remove_last(txt){
      var str = remove_unwanted_characters(txt);
      var ls= str.lastIndexOf(" ");
      if (ls > -1)
	    return str.substring(0,ls ) + " ";
      else
        return "";
    }

Minibar.prototype.tdt=function(tree_btn,txt) {
    with(this) {
	return options.show_trees ? tda([tree_btn,txt]) : td(txt);
    }
}

Minibar.prototype.show_translations=function(translationResults) {
    with(this) {
	var trans=translations;
	//var to=target_lang(); // wrong
	var to=to_menu.value;
	var cnt=translationResults.length;
	//trans.translations=translations;
	trans.single_translation=[];
	trans.innerHTML="";
	/*
	  trans.appendChild(wrap("h3",text(cnt<1 ? "No translations?" :
	  cnt>1 ? ""+cnt+" translations:":
	  "One translation:")));
	*/
	for(p=0;p<cnt;p++) {
	    var tra=translationResults[p];
	    if (tra.translations != null) {
		for (q = 0; q < tra.translations.length; q++) {
		    var t = tra.translations[q];
		    var lin=t.linearizations;
		    var tbody=empty("tbody");
		    if(options.show_abstract && t.tree)
			tbody.appendChild(tr([th(text("Abstract: ")),
					      tdt(abstree_button(t.tree),text(" "+t.tree))]));
		    for(var i=0;i<lin.length;i++) 
			if(to=="All" || lin[i].to==to)
			    tbody.appendChild(tr([th(text(langpart(lin[i].to,grammar.name)+": ")),
						  tdt(parsetree_button(t.tree,lin[i].to),
						      text(lin[i].text))]));
		    trans.appendChild(wrap("table",tbody));
		}
	    }
	    else if(tra.typeErrors) {
		var errs=tra.typeErrors;
		for(var i=0;i<errs.length;i++)
		    trans.appendChild(wrap("pre",text(errs[i].msg)))
	    }
	}
    }
}

Minibar.prototype.show_groupedtranslations=function(translationsResult) {
    with(this) {
	var trans=translations;
	var to=target_lang();
	//var to=to_menu.value // wrong
	var cnt=translationsResult.length;
	//trans.translations=translationsResult;
	trans.single_translation=[];
	trans.innerHTML="";
	for(p=0;p<cnt;p++) {
	    var t=translationsResult[p];
	    if(to=="All" || t.to==to) {
		var lin=t.linearizations;
		var tbody=empty("tbody");
		if(to=="All") tbody.appendChild(tr([th(text(t.to+":"))]));
		for(var i=0;i<lin.length;i++) {
		    if(to!="All") trans.single_translation[i]=lin[i].text;
		    tbody.appendChild(tr([td(text(lin[i].text))]));
		    if (lin.length > 1) tbody.appendChild(tr([td(text(lin[i].tree))]));
		}
		trans.appendChild(wrap("table",tbody));
	    }
	}
    }
}

Minibar.prototype.append_extra_buttons=function(extra,options) {
    with(this) {
	if(options.try_google)
	    extra.appendChild(button("Try Google Translate",bind(try_google,this)));
	if(options.feedback_url)
	    appendChildren(extra,[text(" "),button("Feedback",bind(open_feedback,this))]);
    }
}

Minibar.prototype.try_google=function() {
    with(this) {
	var to=target_lang();
	var s=current.input;
	if(surface.typed) s+=surface.typed.value;
	var url="http://translate.google.com/?sl="
	        +langpart(current.from,grammar.name);
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
	minibar.state={grammar:grammar,current:current,to:to_menu.value,
		       translations:translations};
	open_popup(options.feedback_url,'feedback');
    }
}

function update_language_menu(menu,grammar) {
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
}

function set_initial_language(options,menu,grammar) {
    if(grammar.userLanguage) menu.value=grammar.userLanguage;
    else if(options.default_source_language) {
	for(var i=0;i<menu.options.length;i++) {
	    var o=menu.options[i].value;
	    var l=langpart(o,grammar.name);
	    if(l==options.default_source_language) menu.value=o;
	}
    }
}

function langpart(conc,abs) { // langpart("FoodsEng","Foods") == "Eng"
    return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
}

function abstree_button(abs) {
  var i=img(tree_icon);
  i.setAttribute("onclick","toggle_img(this)");
  i.other=server.current_grammar_url+"?command=abstrtree&tree="+encodeURIComponent(abs);
  return i;
}

function parsetree_button(abs,lang) {
  var i=img(tree_icon);
  i.setAttribute("onclick","toggle_img(this)");
  i.other=server.current_grammar_url
          +"?command=parsetree&from="+lang+"&tree="+encodeURIComponent(abs);
  return i;
}

function toggle_img(i) {
  var tmp=i.src;
  i.src=i.other;
  i.other=tmp;
}

function open_popup(url,target) {
    var w=window.open(url,target,'toolbar=no,location=no,status=no,menubar=no');
    w.focus();
}

function setField(form,name,value) {
    form[name].value=value;
    var el=element(name);
    if(el) el.innerHTML=value;
}

function opener_element(id) { with(window.opener) return element(id); }

// This function is called from feedback.html
function prefill_feedback_form() {
    var state=opener_element("minibar").state;
    var trans=state.translations;
    var gn=state.grammar.name
    var to=langpart(state.to,gn);

    var form=document.forms.namedItem("feedback");
    setField(form,"grammar",gn);
    setField(form,"from",langpart(state.current.from,gn));
    setField(form,"input",state.current.input);
    setField(form,"to",to);
    if(to=="All") element("translation_box").style.display="none";
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
