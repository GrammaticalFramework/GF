// minibar.js, assumes that support.js has also been loaded

/* --- Configuration -------------------------------------------------------- */


var default_server="http://www.grammaticalframework.org:41296"
var tree_icon=default_server+"/translate/se.chalmers.cs.gf.gwt.TranslateApp/tree-btn.png";

// default values for options:
var options={
    server: default_server,
    grammars_url: null, // if left null, start_minibar() fills in server+"/grammars/"
    grammar_list: null, // if left null, start_minibar() will fetch a list from the server
    show_abstract: false,
    show_trees: false,
    show_grouped_translations: true,
    delete_button_text: "⌫",
    default_source_language: null,
    try_google: true,
    feedback_url: null,
    help_url: null
}

/* --- Grammar access object ------------------------------------------------ */

var server = {
    // State variables (private):
    current_grammar_url: options.grammars_url+"Foods.pgf",
    // Methods:
    switch_grammar: function(grammar_name) {
	this.current_grammar_url=options.grammars_url+grammar_name;
    },
    get_grammarlist: function(cont) {
	http_get_json(options.grammars_url+"grammars.cgi",cont);
    },
    get_languages: function(cont) {
	http_get_json(this.current_grammar_url,cont);
    },
    pgf_call: function(cmd,args,cont) {
	var url=this.current_grammar_url+"?command="+cmd;
	for(var arg in args) url+="&"+arg+"="+encodeURIComponent(args[arg]);
	http_get_json(url,cont);
    },

    get_random: function(cont) {
	//jsonpf(this.current_grammar_url+"?command=random&random="+Math.random(),cont);
	this.pgf_call("random",{random:Math.random()},cont);
    },
    linearize: function(tree,to,cont) {
	jsonpf(this.current_grammar_url+"?command=linearize&tree="
	       +encodeURIComponent(tree)+"&to="+to,cont)
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

/* --- Initialisation ------------------------------------------------------- */

function start_minibar(opts) {
  // Typically called when the HTML document is loaded
    if(opts) for(var o in opts) options[o]=opts[o];
    var surface=div_id("surface");
    var extra=div_id("extra");
    //surface.setAttribute("onclick","add_typed_input(this)");
    var minibar=element("minibar");
    minibar.innerHTML="";
    appendChildren(minibar,
		   [div_id("menubar"),
		    surface,
		    div_id("words"),
		    div_id("translations"),
		    extra]);
    append_extra_buttons(extra);
    if(!options.grammars_url) options.grammars_url=options.server+"/grammars/";
    if(options.grammar_list) show_grammarlist(options.grammar_list);
    else server.get_grammarlist(show_grammarlist);
}


/* --- Functions ------------------------------------------------------------ */

function show_grammarlist(grammars) {
    var menubar=element("menubar");
    menubar.innerHTML="";
    if(grammars.length>1) {
	var menu=empty("select");
	for(var i=0;i<grammars.length;i++) {
	    var opt=empty("option");
	    opt.setAttribute("value",grammars[i]);
	    opt.innerHTML=grammars[i];
	    menu.appendChild(opt);
	}
	menu.setAttribute("onchange","new_grammar(this)");
	menubar.innerHTML="Grammar: ";
	menubar.appendChild(menu);
    }
    appendChildren(menubar,
		   [text(" From: "), empty_id("select","language_menu"),
		    text(" To: "), empty_id("select","to_menu"),
		    button(options.delete_button_text,"delete_last()"),
		    button("Clear","clear_all()"),
		    button("Random","generate_random()")]);
    if(options.help_url)
	menubar.appendChild(button("Help","open_help()"));
    select_grammar(grammars[0]);
}

function new_grammar(menu) {
  select_grammar(menu.options[menu.selectedIndex].value);
}

function select_grammar(grammar_name) {
    server.switch_grammar(grammar_name);
    server.get_languages(show_languages);
}

function langpart(conc,abs) { // langpart("FoodsEng","Food") == "Eng"
    return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
}

function show_languages(grammar) {
    var r="";
    var lang=grammar.languages;
    var menu=element("language_menu");
    menu.setAttribute("onchange","new_language(this)");
    menu.grammar=grammar;
    menu.innerHTML="";

    for(var i=0; i<lang.length; i++)
	if(/*lang[i].canParse &&*/ !hasPrefix(lang[i].name,"Disamb"))
	    menu.appendChild(option(langpart(lang[i].name,grammar.name),""+i));
    if(options.default_source_language) {
	for(var i=0;i<menu.options.length;i++) {
	    var ix=menu.options[i].value;
	    var l=langpart(menu.grammar.languages[ix].name,menu.grammar.name);
	    if(l==options.default_source_language) menu.selectedIndex=i;
	}
    }
    var to=element("to_menu");
    to.langmenu=menu;
    to.setAttribute("onchange","change_tolang(this)");
    to.innerHMTL="";
    to.appendChild(option("All","-1"));
    for(var i=0; i<lang.length; i++)
	if(!hasPrefix(lang[i].name,"Disamb"))
	    to.appendChild(option(langpart(lang[i].name,grammar.name),lang[i].name));
    new_language(menu);
}

function new_language(menu) {
  var ix=menu.options[menu.selectedIndex].value;
  var langname=menu.grammar.languages[ix].name;
  menu.current={from: langname, input: ""};
  clear_all();
}

function change_tolang(to_menu) {
    get_translations(to_menu.langmenu)
}

function clear_all1() {
    var menu=element("language_menu");
    menu.current.input="";
    menu.previous=null;
    var surface=element("surface");
    surface.innerHTML="";
    surface.typed=null;
    element("translations").innerHTML="";
    return menu;
}

function clear_all() {
  get_completions(clear_all1());
}

function delete_last() {
  var menu=element("language_menu");
  if(menu.previous) {
    menu.current.input=menu.previous.input;
    menu.previous=menu.previous.previous;
    var s=element("surface");
    if(s.typed) {
	s.removeChild(s.typed.previousSibling);
	s.typed.focus();
    }
    else
	s.removeChild(s.lastChild);
    element("translations").innerHTML="";
    get_completions(menu);
  }
}

function add_typed_input(surface) {
    if(surface.typed)
	inp=surface.typed;
    else {
	var inp=empty("input","type","text");
	inp.setAttribute("accesskey","t");
	inp.setAttribute("onkeyup","complete_typed(this)");
	inp.setAttribute("onchange","finish_typed(this)");
	surface.appendChild(inp);
	surface.typed=inp;
    }
    inp.focus();
}

function remove_typed_input(surface) {
    if(surface.typed) {
	surface.typed.parentNode.removeChild(surface.typed);
	surface.typed=null;
    }
}

function complete_typed(inp) {
    var menu=element("language_menu");
    var c=menu.current;
    if(!inp.completing || inp.completing!=inp.value) {
	inp.completing=inp.value;
	server.complete(c.from,c.input+inp.value,show_completions);
    }
}

function finish_typed(inp) {
    //alert("finish_typed "+inp.value);
    var box=element("words");
    var w=inp.value+" ";
    if(box.completions.length==1)
	add_word(box.completions[0]);
    else if(elem(w,box.completions))
	add_word(w);
}

function generate_random() {
    server.get_random(lin_random);
}

function lin_random(abs) {
  var menu=element("language_menu");
  var lang=menu.current.from;
  server.linearize(abs[0].tree,lang,show_random);
}

function show_random(random) {
  var menu=clear_all1();
  var words=random[0].text.split(" ");
  for(var i=0;i<words.length;i++)
    add_word1(menu,words[i]+" ");
  element("words").innerHTML="...";
  get_completions(menu);
}

function get_completions(menu) {
  var c=menu.current;
  server.complete(c.from,c.input,show_completions);
}

function word(s) {
  //var w=div_class("word",text(s));
  //w.setAttribute("onclick",'add_word("'+s+'")');
  //return w;
  return button(s,'add_word("'+s+'")');
}

function add_word1(menu,s) {
    menu.previous={ input: menu.current.input, previous: menu.previous };
    menu.current.input+=s;
    var w=span_class("word",text(s));
    var surface=element("surface");
    if(surface.typed) {
	surface.typed.value="";
	surface.insertBefore(w,surface.typed);
    }
    else
	surface.appendChild(w);
}

function add_word(s) {
  var menu=element("language_menu");
  add_word1(menu,s+" ");
  element("words").innerHTML="...";
  get_completions(menu);
}

function show_completions(complete_output) {
  var box=element("words");
  var menu=element("language_menu");
  var prefixlen=menu.current.input.length;
  var emptycnt=0;
  var completions=complete_output[0].completions;
  box.innerHTML="";
  box.completions=[];
  for(var i=0;i<completions.length;i++) {
    var s=completions[i];
    box.completions[i]=s;
    if(s.length>0) box.appendChild(word(s));
    else emptycnt++;
  }
  if(true/*emptycnt>0*/) get_translations(menu);
  else element("translations").innerHTML="";
  var surface=element("surface");
  if(surface.typed && emptycnt==completions.length) {
      if(surface.typed.value=="") remove_typed_input(surface);
  }
  else add_typed_input(surface);
}

function get_translations(menu) {
    var c=menu.current;
    if(options.show_grouped_translations)
	server.translategroup(c.from,c.input,show_groupedtranslations);
    else
	server.translate(c.from,c.input,show_translations);
}

function tdt(tree_btn,txt) {
    return options.show_trees ? tda([tree_btn,txt]) : td(txt);
}

function target_lang() {
    var to_menu=element("to_menu");
    var grammar=element("language_menu").grammar;
    return langpart(to_menu.options[to_menu.selectedIndex].value,grammar.name);
}

function show_translations(translationResults) {
  var trans=element("translations");
  var grammar=element("language_menu").grammar;
  var to=target_lang();
  var cnt=translationResults.length;
  //trans.translations=translations;
  trans.single_translation=[];
  trans.innerHTML="";
  trans.appendChild(wrap("h3",text(cnt<1 ? "No translations?" :
				   cnt>1 ? ""+cnt+" translations:":
				   "One translation:")));
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
  }
}

function show_groupedtranslations(translations) {
    var trans=element("translations");
    var grammar=element("language_menu").grammar;
    var to=target_lang();
    var cnt=translations.length;
    //trans.translations=translations;
    trans.single_translation=[];
    trans.innerHTML="";
    for(p=0;p<cnt;p++) {
	var t=translations[p];
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

function append_extra_buttons(extra) {
    if(options.try_google)
	extra.appendChild(button("Try Google Translate","try_google()"));
    if(options.feedback_url)
	appendChildren(extra,[text(" "),button("Feedback","open_feedback()")]);
}

function try_google() {
    var menu=element("language_menu");
    var trans=element("translations");
    var surface=element("surface");
    var to=target_lang();
    var grammar=menu.grammar;
    var c=menu.current;
    var s=c.input;
    if(surface.typed) s+=surface.typed.value;
    var url="http://translate.google.com/?sl="+langpart(c.from,grammar.name);
    if(to!="-1") url+="&tl="+to;
    url+="&q="+encodeURIComponent(s);
    window.open(url);
}

function open_popup(url,target) {
    var w=window.open(url,target,'toolbar=no,location=no,status=no,menubar=no');
    w.focus();
}

function open_help() { open_popup(options.help_url,"help"); }
function open_feedback() { open_popup(options.feedback_url,'feedback'); }

function setField(form,name,value) {
    form[name].value=value;
    var el=element(name);
    if(el) el.innerHTML=value;
}

function opener_element(id) { with(window.opener) return element(id); }

function prefill_feedback_form() {
    var to_menu=opener_element("to_menu");
    var trans=opener_element("translations");
    var menu=to_menu.langmenu;
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
