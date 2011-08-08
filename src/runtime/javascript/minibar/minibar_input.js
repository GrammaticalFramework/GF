
/* --- Input object --------------------------------------------------------- */

function Input(server,options,translations) {
    // Input object constructor
    this.options=options;
    this.server=server;
    this.translations=translations;
    this.main=empty("div");
    this.menus=empty("span");
    this.buttons=empty("span");
    this.surface=div_id("surface");
    this.words=div_id("words");
    this.from_menu=empty("select");

    with(this) {
	appendChildren(main,[surface,words]);
	appendChildren(menus,[text(" From: "),from_menu])
	appendChildren(buttons,
		       [button(options.delete_button_text,bind(delete_last,this),"H"),
			button("Clear",bind(clear_all,this),"L")]);
	if(options.random_button)
	    buttons.appendChild(button("Random",bind(generate_random,this),"R"));
    }

    /* --- Input client state initialization --- */
    this.current={from: null, input: ""};
    this.previous=null;

    this.from_menu.onchange=bind(this.change_language,this);
}

Input.prototype.change_grammar=function (grammar) {
    update_language_menu(this.from_menu,grammar);
    set_initial_language(this.options,this.from_menu,grammar);
    this.change_language();
}

Input.prototype.change_language=function () {
    this.current.from=this.from_menu.value;
    this.clear_all();
}


Input.prototype.clear_all1=function() {
    with(this) {
	remove_typed_input();
	current.input="";
	previous=null;
	surface.innerHTML="";
	translations.clear();
    }
}

Input.prototype.clear_all=function() {
    with(this) {
	clear_all1();
	get_completions();
    }
}

Input.prototype.get_completions=function() {
    with(this) {
	//debug("get_completions ");
	words.innerHTML="...";
	server.complete({from:current.from,input:current.input},
			bind(show_completions,this));
    }
}

Input.prototype.show_completions=function(complete_output) {
    with(this) {
	//debug("show_completions ");
	var completions=complete_output[0].completions;
	var emptycnt=add_completions(completions)
	if(true/*emptycnt>0*/) translations.translateFrom(current);
	else translations.clear();
	if(surface.typed && emptycnt==completions.length) {
	    if(surface.typed.value=="") remove_typed_input();
	}
	else add_typed_input();
    }
}

Input.prototype.add_completions=function(completions) {
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

Input.prototype.filter_completions=function(t,dim) {
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


Input.prototype.add_typed_input=function() {
    with(this) {
	if(!surface.typed) {
	    var inp=empty("input","type","text");
	    inp.value="";
	    inp.setAttribute("accesskey","t");
	    inp.style.width="10em";
	    inp.onkeyup=bind(complete_typed,this);
	    surface.appendChild(inp);
	    surface.typed=inp;
	    inp.focus();
	}
    }
}

Input.prototype.remove_typed_input=function() {
    with(this) {
	if(surface.typed) {
	    surface.typed.parentNode.removeChild(surface.typed);
	    surface.typed=null;
	}
    }
}

Input.prototype.complete_typed=function(event) {
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

Input.prototype.generate_random=function() {
    var t=this;
    function show_random(random) {
	t.clear_all1();
	t.add_words(random[0].text);
    }
    
    function lin_random(abs) {
	t.server.linearize({tree:abs[0].tree,to:t.current.from},show_random);
    }
    t.server.get_random({},lin_random);
}

Input.prototype.add_words=function(s) {
    with(this) {
	var ws=s.split(" ");
	for(var i=0;i<ws.length;i++)
	    add_word1(ws[i]+" ");
	get_completions();
    }
}

Input.prototype.word=function(s) { 
    var t=this;
    function click_word() {
	if(t.surface.typed) t.surface.typed.value="";
	t.add_word(s);
    }
    return button(s,click_word);
}

Input.prototype.add_word=function(s) {
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
}

Input.prototype.add_word1=function(s) {
    with(this) {
	previous={ input: current.input, previous: previous };
	current.input+=s;
	var w=span_class("word",text(s));
	if(surface.typed) surface.insertBefore(w,surface.typed);
	else surface.appendChild(w);
    }
}

Input.prototype.delete_last=function() {
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
	    translations.clear();
	    get_completions();
	}
    }
}

/* --- Auxiliary functions -------------------------------------------------- */

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
