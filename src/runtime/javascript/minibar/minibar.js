// minibar.js, assumes that support.js has also been loaded

var default_server="http://www.grammaticalframework.org:41296"
var tree_icon=default_server+"/translate/se.chalmers.cs.gf.gwt.TranslateApp/tree-btn.png";

function start_minibar(server,opts,target) {
    // Typically called when the HTML document is loaded

    /* --- Configuration ---------------------------------------------------- */

    // default values for options:
    var options={
	show_abstract: false,
	show_trees: false,
	show_grouped_translations: true,
	delete_button_text: "⌫",
	default_source_language: null,
	try_google: true,
	feedback_url: null,
	random_button: true,
	help_url: null
    }

    /* --- Creating user interface elements --------------------------------- */

    if(opts) for(var o in opts) options[o]=opts[o];

    var surface=div_id("surface");
    var extra=div_id("extra");
    var menubar=div_id("menubar");
    var words=div_id("words");
    var translations=div_id("translations");

    var minibar=element(target || "minibar");
    minibar.innerHTML="";
    appendChildren(minibar,[menubar,surface,words,translations,extra]);

    // Added later:
    var language_menu=empty_id("select","language_menu");
    var to_menu=empty_id("select","to_menu");

    /* --- Minibar client state initialisation ------------------------------ */
    var current={from: null, input: ""};
    var previous=null;

    /* --- Auxiliary functions ---------------------------------------------- */

    function show_grammarlist(grammars) {
	//debug("show_grammarlist ")
	menubar.innerHTML="";
	if(grammars.length>1) {
	    var menu=empty("select");
	    for(var i=0;i<grammars.length;i++) {
		var opt=empty("option");
		opt.setAttribute("value",grammars[i]);
		opt.innerHTML=grammars[i];
		menu.appendChild(opt);
	    }
    	    menu.onchange=function() {
		select_grammar(menu.options[menu.selectedIndex].value);
	    };
	    menubar.innerHTML="Grammar: ";
	    menubar.appendChild(menu);
	}
	appendChildren(menubar,
		       [text(" From: "), language_menu,
			text(" To: "), to_menu,
			button(options.delete_button_text,delete_last,"H"),
			button("Clear",clear_all,"L")]);
	if(options.random_button)
	    menubar.appendChild(button("Random",generate_random,"R"));
	if(options.help_url)
	    menubar.appendChild(button("Help",open_help));
	select_grammar(grammars[0]);
    }

    function select_grammar(grammar_name) {
	//debug("select_grammar ");
	function get_languages() { server.get_languages(show_languages); }
	server.switch_grammar(grammar_name,get_languages);
    }

    function show_languages(grammar) {
	//debug("show_languages ");
	var r="";
	var lang=grammar.languages;
	var menu=language_menu;
	menu.grammar=grammar;
	var new_language=function () {
	    var ix=menu.options[menu.selectedIndex].value;
	    var langname=grammar.languages[ix].name;
	    current.from=langname;
	    clear_all();
	}
	menu.onchange=new_language;

	menu.innerHTML="";
	
	for(var i=0; i<lang.length; i++)
	    if(!hasPrefix(lang[i].name,"Disamb"))
		menu.appendChild(option(langpart(lang[i].name,grammar.name),""+i));
	set_initial_language(options,menu,grammar)
	to_menu.onchange=get_translations

	to_menu.innerHTML="";
	to_menu.appendChild(option("All","-1"));
	for(var i=0; i<lang.length; i++)
	    if(!hasPrefix(lang[i].name,"Disamb"))
		to_menu.appendChild(option(langpart(lang[i].name,grammar.name),lang[i].name));
	new_language();
    }

    function clear_all1() {
	remove_typed_input();
	current.input="";
	previous=null;
	surface.innerHTML="";
	translations.innerHTML="";
    }

    function clear_all() {
	clear_all1();
	get_completions();
    }

    function get_completions() {
	//debug("get_completions ");
	words.innerHTML="...";
	server.complete(current.from,current.input,show_completions);
    }

    function show_completions(complete_output) {
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

    function add_completions(completions) {
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

    function filter_completions(t,dim) {
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
    
    function get_translations() {
	var c=current;
	if(options.show_grouped_translations)
	    server.translategroup(c.from,c.input,show_groupedtranslations);
	else
	    server.translate(c.from,c.input,show_translations);
    }

    function target_lang() {
	return langpart(to_menu.options[to_menu.selectedIndex].value,
			language_menu.grammar.name);
    }

    function add_typed_input() {
	var inp;
	if(surface.typed) inp=surface.typed;
	else {
	    inp=empty("input","type","text");
	    inp.value="";
	    inp.setAttribute("accesskey","t");
	    inp.style.width="10em";
	    inp.onkeyup=complete_typed;
	    surface.appendChild(inp);
	    surface.typed=inp;
	}
	inp.focus();
    }

    function remove_typed_input() {
	if(surface.typed) {
	    surface.typed.parentNode.removeChild(surface.typed);
	    surface.typed=null;
	}
    }

    function complete_typed(event) {
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

    function generate_random() {

	function show_random(random) {
	    clear_all1();
	    var menu=language_menu;
	    add_words(random[0].text);
	}

	function lin_random(abs) {
	    server.linearize(abs[0].tree,current.from,show_random);
	}
	server.get_random(lin_random);
    }

    function add_words(s) {
	var words=s.split(" ");
	for(var i=0;i<words.length;i++)
	    add_word1(words[i]+" ");
	get_completions();
    }

    function word(s) { 
	function click_word() {
	    if(surface.typed) surface.typed.value="";
	    add_word(s);
	}
	return button(s,click_word);
    }

    function add_word(s) {
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
    
    function add_word1(s) {
	previous={ input: current.input, previous: previous };
	current.input+=s;
	var w=span_class("word",text(s));
	if(surface.typed) surface.insertBefore(w,surface.typed);
	else surface.appendChild(w);
    }

    function delete_last() {
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
	    get_completions();
	}
    }

    function tdt(tree_btn,txt) {
	return options.show_trees ? tda([tree_btn,txt]) : td(txt);
    }

    function show_translations(translationResults) {
	var trans=translations;
	var grammar=language_menu.grammar;
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
			if(to=="-1" || lin[i].to==to)
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
    
    function show_groupedtranslations(translationsResult) {
	var trans=translations;
	var grammar=language_menu.grammar;
	var to=target_lang();
	//var to=to_menu.value // wrong
	var cnt=translationsResult.length;
	//trans.translations=translationsResult;
	trans.single_translation=[];
	trans.innerHTML="";
	for(p=0;p<cnt;p++) {
	    var t=translationsResult[p];
	    if(to=="-1" || t.to==to) {
		var lin=t.linearizations;
		var tbody=empty("tbody");
		if(to=="-1") tbody.appendChild(tr([th(text(t.to+":"))]));
		for(var i=0;i<lin.length;i++) {
		    if(to!="-1") trans.single_translation[i]=lin[i].text;
		    tbody.appendChild(tr([td(text(lin[i].text))]));
		    if (lin.length > 1) tbody.appendChild(tr([td(text(lin[i].tree))]));
		}
		trans.appendChild(wrap("table",tbody));
	    }
	}
    }

    function append_extra_buttons(extra,options) {
	if(options.try_google)
	    extra.appendChild(button("Try Google Translate",try_google));
	if(options.feedback_url)
	    appendChildren(extra,[text(" "),button("Feedback",open_feedback)]);
    }

    function try_google() {
	var to=target_lang();
	var grammar=language_menu.grammar;
	var s=current.input;
	if(surface.typed) s+=surface.typed.value;
	var url="http://translate.google.com/?sl="
	        +langpart(current.from,grammar.name);
	if(to!="-1") url+="&tl="+to;
	url+="&q="+encodeURIComponent(s);
	window.open(url);
    }

    function open_help() { open_popup(options.help_url,"help"); }
    function open_feedback() {
	language_menu.current=current;
	open_popup(options.feedback_url,'feedback');
    }
    
    /* --- Main program, this gets things going ----------------------------- */
    append_extra_buttons(extra,options);

    if(server.grammar_list) show_grammarlist(server.grammar_list);
    else server.get_grammarlist(show_grammarlist);
}

function commonPrefix(s1,s2) {
    for(var i=0;i<s1.length && i<s2.length && s1[i]==s2[i];i++);
    return s1.substr(0,i);
}

function set_initial_language(options,menu,grammar) {
    if(grammar.userLanguage) {
	for(var i=0;i<menu.options.length;i++) {
	    var ix=menu.options[i].value;
	    var l=grammar.languages[ix].name;
	    if(l==grammar.userLanguage) menu.selectedIndex=i;
	}
    }
    else if(options.default_source_language) {
	for(var i=0;i<menu.options.length;i++) {
	    var ix=menu.options[i].value;
	    var l=langpart(grammar.languages[ix].name,grammar.name);
	    if(l==options.default_source_language) menu.selectedIndex=i;
	}
    }
}

function langpart(conc,abs) { // langpart("FoodsEng","Food") == "Eng"
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

function prefill_feedback_form() {
    var to_menu=opener_element("to_menu");
    var trans=opener_element("translations");
    var menu=opener_element("language_menu")
    var grammar=menu.grammar;
    var gn=grammar.name;
    var form=document.forms.namedItem("feedback");
    var from=langpart(menu.current.from,gn);
    var to=langpart(to_menu.options[to_menu.selectedIndex].value,gn);

    setField(form,"grammar",gn);
    setField(form,"from",from);
    setField(form,"input",menu.current.input);
    setField(form,"to",to=="-1" ? "All" : to);
    if(to=="-1") 
	element("translation_box").style.display="none";
    else 
	setField(form,"translation",trans.single_translation.join(" / "));

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
