/* --- Translations object -------------------------------------------------- */

var tree_icon="../minibar/tree-btn.png";
var alignment_icon="../minibar/align-btn.png";

function Translations(server,opts) {
    this.server=server;

    // Default values for options:
    this.options={
	show_abstract: false,
	abstract_action: null, // action when selecting the abstracy syntax tree
	show_trees: false, // add buttons to show abstract syntax trees,
	                   // parse trees & word alignment
	tree_img_format: supportsSVG() ? "svg" : "png",
	                 // format for trees & alignment images,
	                 // can be "gif", "png" or "svg"
	show_grouped_translations: true,
	to_multiple: true, // allow selection of multiple target languages
	show_brackets: false, // show bracketed string
	speech: true, // enable speech synthesis buttons
	translate_limit: 25 // maximum number of parse trees to retrieve
    }

    // Apply supplied options
    if(opts) for(var o in opts) this.options[o]=opts[o];

    this.main=empty("div");
    this.menus=empty("span");

    var tom_opts={id:"to_menu"}
    if(this.options.to_multiple)
	tom_opts.multiple=true,tom_opts.size=8,
        tom_opts.style="position: absolute";
    var tom=this.to_menu=node("select",tom_opts,[]);
    if(this.options.to_multiple) {
	tom.style.display="none"
	function toggle_tom() {
	    tom.style.display= tom.style.display=="none" ? "" : "none"
	}
	appendChildren(this.menus,[button("To:",toggle_tom),tom,text(" ... ")])
    }
    else appendChildren(this.menus,[text(" To: "),tom])
    tom.onchange=bind(this.change_language,this);
    var o=this.options
    if(o.initial_grammar && o.initial_toLangs)
	this.set_toLangs_for(o.initial_grammar,o.initial_toLangs)

    /* // This seems triggers weird scrolling behavior in Firefox and Chrome:
    tom.onmouseover=function() { var n=tom.options.length;
				 tom.size=n<12 ? n : 12; }
    tom.onmouseout=function() { var n=tom.options.length;
				tom.size=n<4 ? n : 4; }
    */
}

Translations.prototype.change_grammar=function(grammar) {
    var t=this
    t.grammar=grammar;

    t.local=mt_local(t.server.current_grammar_url)

    update_language_menu(t.to_menu,grammar);
    insertFirst(t.to_menu,option("All","All"));
    t.to_menu.value="All";
    var toLangs=t.local.get("toLangs")
    if(toLangs && toLangs.length>0) {
	t.toLangs=toLangs
	t.toSet=toSet(toLangs)
	updateMultiMenu(t.to_menu,toLangs)
    }
    else {
	t.toLangs=["All"]
	t.toSet={"All":true}
    }
}

Translations.prototype.clear=function() {
    this.main.innerHTML="";
}

Translations.prototype.set_toLangs_for=function(grammar_url,toLangs) {
    var local=mt_local(grammar_url)
    local.put("toLangs",toLangs)
}

Translations.prototype.change_language=function() {
    var t=this
    t.toLangs=multiMenuSelections(t.to_menu)
    t.toSet=toSet(t.toLangs)
    t.local.put("toLangs",t.toLangs)
    t.get_translations();
}

Translations.prototype.translateFrom=function(current,startcat,lin_action) {
    this.current=current;
    this.startcat=startcat;
    this.lin_action=lin_action;
    this.get_translations();
}

Translations.prototype.get_translations=function() {
    with(this) {
	var c=current;
	var args={from:c.from,input:gf_unlex(c.input),cat:startcat}
	if(options.translate_limit) args.limit=options.translate_limit
	if(options.show_grouped_translations)
	    server.translategroup(args,bind(show_groupedtranslations,this));
	else
	    server.translate(args,bind(show_translations,this));
    }
}

Translations.prototype.target_lang=function() {
    with(this) return langpart(to_menu.value,grammar.name);
}

Translations.prototype.show_translations=function(translationResults) {
    var self=this;
    function abs_tdt(tree) {
	var as = self.options.show_trees
	    ? [self.abstree_button(tree),
	       self.alignment_button(tree,to=="All",self.toLangs),
	       text(" ")]
	    : []
	as.push(text(tree))
	return td(as)
    }
    function text_speech(langcode,to,txt,lin) {
	var langcode2=langCode(self.grammar,to)
	return wrap("span",[txt,speech_buttons(langcode,langcode2,lin)])
    }
    function lin_tdt(tree,to,langcode,lin) {
	var txt=wrap("span",text("▸ "+lin))
	var ts = text_speech(langcode,to,txt,lin)
	var as = wrap("span",
		    self.options.show_trees
		    ? [self.parsetree_button(tree,to),text(" "),ts]
		    : [ts])
	as.active=txt
	as.swap=ts
	return as
    }
    function act(lin) {
	return self.lin_action ? function() { self.lin_action(lin) } : null
    }
    function atext(s,act) {
	var txt=wrap("span",text(s))
	txt.onclick=act
	return txt
    }
    function show_lin(langcode,lin,tree) {
	function draw_table(lintable,action) {
	    function draw_texts(texts) {
		function text1(s) {
		    var txt=atext(s,action)
		    return wrap("div",text_speech(langcode,lin.to,txt,s))
		}
		return texts.map(text1)
	    }
	    function draw_row(row) {
		return tr([td(atext(row.params,action)),td(draw_texts(row.texts))])
	    } // ▼ ▾
	    return wrap("span",
			[atext("▾ ",action),
			 wrap_class("table","lintable",lintable.map(draw_row))])
	}
	function get_tabular() {
	    function show_table(lins) {
		if(lins.length==1) {
		    function restore() { replaceNode(one.swap,all) }
		    var all=draw_table(lins[0].table,restore)
		    replaceNode(all,one.swap)
		    one.active.onclick=function() { replaceNode(all,one.swap) }
		}
	    }
	    self.server.pgf_call("linearizeTable",{"tree":tree,"to":lin.to},
				 show_table)
	}
	var one= lin_tdt(tree,lin.to,langcode,lin.text) // ▶
	one.active.onclick=get_tabular
	return td(one)
    }
    with(self) {
	var trans=main;
	//var to=target_lang(); // wrong
	var to=to_menu.value;
	var toLangs=self.toLangs
	var toSet=self.toSet
	var cnt=translationResults.length; // cnt==1 usually
	//trans.translations=translations;
	trans.single_translation=[];
	trans.innerHTML="";
	/*
	  trans.appendChild(wrap("h3",text(cnt<1 ? "No translations?" :
	  cnt>1 ? ""+cnt+" translations:":
	  "One translation:")));
	*/
	for(var p=0;p<cnt;p++) {
	    var tra=translationResults[p];
	    var bra=tra.brackets;
	    if (tra.translations != null) {
		for (q = 0; q < tra.translations.length; q++) {
		    var t = tra.translations[q];
		    var lin=t.linearizations;
		    var tbody=empty("tbody");
		    if(options.show_abstract && t.tree) {
			function abs_act() {
			    self.options.abstract_action(t.tree)
			}
			var abs_hdr = options.abstract_action 
		                      ? title("Edit the syntax tree",
				              button("Abstract",abs_act))
			              : text("Abstract: ")
			tbody.appendChild(tr([th(abs_hdr),abs_tdt(t.tree)]));
		    }
		    for(var i=0;i<lin.length;i++) {
			if(lin[i].to==to && toLangs.length==1)
			    trans.single_translation.push(lin[i].text);
			if(lin[i].to==current.from && lin[i].brackets)
			    bra=lin[i].brackets;
			if(to=="All" || toSet[lin[i].to]) {
			    var langcode=langpart(lin[i].to,grammar.name)
		          //var hdr=text(langcode+": ")
			    var hdr=title("Switch input language to "+langcode,
					  button(langcode,act(lin[i])))
			    //hdr.disabled=lin[i].to==current.from
			    var btn=parsetree_button(t.tree,lin[i].to)
			    tbody.appendChild(
				tr([th(hdr),show_lin(langcode,lin[i],t.tree)]));
			}
		    }
		    trans.appendChild(wrap("table",tbody));
		}
	    }
	    else if(tra.typeErrors) {
		    var errs=tra.typeErrors;
		    for(var i=0;i<errs.length;i++)
			trans.appendChild(wrap("pre",text(errs[i].msg)))
	    }
	    if(options.show_brackets)
		trans.appendChild(div_class("brackets",draw_bracketss(bra)));

	}
    }
}

Translations.prototype.show_groupedtranslations=function(translationsResult) {
    with(this) {
	var trans=main;
	var to=target_lang();
	//var to=to_menu.value // wrong
	var cnt=translationsResult.length;
	//trans.translations=translationsResult;
	trans.single_translation=[];
	trans.innerHTML="";
	for(var p=0;p<cnt;p++) {
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

Translations.prototype.abstree_button=function(abs) {
  var f=this.options.tree_img_format;
  var img=this.server.current_grammar_url+"?command=abstrtree&format="+f+"&tree="+encodeURIComponent(abs)
    var btn=tree_button(img,"&nocat=true");
  btn.title="Click to display abstract syntax tree"
  return btn
}

Translations.prototype.alignment_button=function(abs,all,toLangs) {
  var f=this.options.tree_img_format;
  var i=button_img(alignment_icon,function(){toggle_img(i)});
  var to= all ? "" : "&to="+encodeURIComponent(toLangs.join(" "))
  i.title="Click to display word alignment"
  i.other=this.server.current_grammar_url+"?command=alignment&format="+f+"&tree="+encodeURIComponent(abs)+to;
  return i;
}

Translations.prototype.parsetree_button=function(abs,lang) {
  var f=this.options.tree_img_format;
  var img=this.server.current_grammar_url
          +"?command=parsetree&format="+f+"&nodefont=arial"
	  +"&from="+lang+"&tree="+encodeURIComponent(abs);
  var btn=tree_button(img)
  btn.title="Click to display parse tree. Click again to show function names."
  return btn;
}

/* --- Auxiliary functions -------------------------------------------------- */

function mt_local(grammar_url) {
    return appLocalStorage("gf.minibar_translations."+grammar_url+".")
}

function tree_button(img_url,opt) {
    var imgs=[tree_icon,img_url+(opt||"&nofun=true"),img_url]
    var current=0;
    function cycle() {
	current++;
	if(current>=imgs.length) current=0;
	i.src=imgs[current]
    }
    var i=button_img(tree_icon,cycle);
    return i
}

function draw_brackets(b) {
    return b.token
	? span_class("token",text(b.token))
	: node("span",{"class":"brackets",
		       title:(b.fun||"_")+":"+b.cat+" "+b.fid+":"+b.index},
	       b.children.map(draw_brackets))
}

function draw_bracketss(bs) {
    return Array.isArray(bs)
	? bs.map(draw_brackets)  //with gf>3.5, in some cases
	: draw_brackets(bs) // with gf<=3.5
}

function supportsSVG() {
    return document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#BasicStructure", "1.1")
}

function speech_buttons(to3,to2,txt) {
    var voices = window.speechSynthesis && window.speechSynthesis.getVoices() || []
    var dvs = voices.filter(function(v){return v.default})
    if(to2)
	var pick=function (v) { return v.lang==to2 }
    else {
	var to2dash=alangcode(to3)+"-"
	var pick=function(v) { return hasPrefix(v.lang,to2dash) }
    }
    function btn(v) {
	var u=new SpeechSynthesisUtterance(txt)
	u.lang=v.lang // how to use v.voiceURI or v.name?

	function speak() {
	    speechSynthesis.cancel()
	    speechSynthesis.speak(u)
	}
	return button(v.lang,speak)
    }
    //console.log(voices.length,"voices")
    var vs=dvs.filter(pick)
    if(vs.length==0) vs=voices.filter(pick)
    //console.log(vs.length,"voices for "+to3+" "+to2)
    var btns=vs.map(btn)
    //console.log(btns.length,"voice buttons")
    return wrap("span",btns)
}
