/* --- Translations object -------------------------------------------------- */

var tree_icon="../minibar/tree-btn.png";
var alignment_icon="../minibar/align-btn.png";

function Translations(server,opts) {
    this.server=server;

    // Default values for options:
    this.options={
	show_abstract: false,
	show_trees: false, // add buttons to show abstract syntax trees,
	                   // parse trees & word alignment
	tree_img_format: "png", // format for trees & alignment images,
	                        // can be "gif", "png" or "svg"
	show_grouped_translations: true,
	show_brackets: false // show bracketed string
    }

    // Apply supplied options
    if(opts) for(var o in opts) this.options[o]=opts[o];

    this.main=empty("div");
    this.menus=empty("span");

    this.to_menu=empty_id("select","to_menu");

    appendChildren(this.menus,[text(" To: "), this.to_menu])
    this.to_menu.onchange=bind(this.get_translations,this);

}

Translations.prototype.change_grammar=function(grammar) {
    this.grammar=grammar;
    
    update_language_menu(this.to_menu,grammar);
    insertFirst(this.to_menu,option("All","All"));
    this.to_menu.value="All";
}

Translations.prototype.clear=function() {
    this.main.innerHTML="";
}

Translations.prototype.translateFrom=function(current,startcat) {
    this.current=current;
    this.startcat=startcat;
    this.get_translations();
}

Translations.prototype.get_translations=function() {
    with(this) {
	var c=current;
	if(options.show_grouped_translations)
	    server.translategroup({from:c.from,input:c.input,cat:startcat},
				  bind(show_groupedtranslations,this));
	else
	    server.translate({from:c.from,input:c.input,cat:startcat},
			     bind(show_translations,this));
    }
}

Translations.prototype.tdt=function(tree_btn,txt) {
    with(this) {
	return options.show_trees ? tda([tree_btn,txt]) : td(txt);
    }
}

Translations.prototype.target_lang=function() {
    with(this) return langpart(to_menu.value,grammar.name);
}

Translations.prototype.show_translations=function(translationResults) {
    with(this) {
	var trans=main;
	//var to=target_lang(); // wrong
	var to=to_menu.value;
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
		    if(options.show_abstract && t.tree)
			tbody.appendChild(
			    tr([th(text("Abstract: ")),
				tdt(node("span",{},[abstree_button(t.tree),
						    alignment_button(t.tree)]),
				    text(" "+t.tree))]));
		    for(var i=0;i<lin.length;i++) {
			if(lin[i].to==to)
			    trans.single_translation.push(lin[i].text);
			if(lin[i].to==current.from && lin[i].brackets)
			    bra=lin[i].brackets;
			if(to=="All" || lin[i].to==to)
			    tbody.appendChild(tr([th(text(langpart(lin[i].to,grammar.name)+": ")),
						  tdt(parsetree_button(t.tree,lin[i].to),
						      text(lin[i].text))]));
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
		trans.appendChild(div_class("brackets",draw_brackets(bra)));

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
  var i=button_img(tree_icon,"toggle_img(this)");
  i.title="Click to display abstract syntax tree"
  i.other=this.server.current_grammar_url+"?command=abstrtree&format="+f+"&tree="+encodeURIComponent(abs);
  return i;
}

Translations.prototype.alignment_button=function(abs) {
  var f=this.options.tree_img_format;
  var i=button_img(alignment_icon,"toggle_img(this)");
  i.title="Click to display word alignment"
  i.other=this.server.current_grammar_url+"?command=alignment&format="+f+"&tree="+encodeURIComponent(abs);
  return i;
}

Translations.prototype.parsetree_button=function(abs,lang) {
  var f=this.options.tree_img_format;
  var i=button_img(tree_icon,"toggle_img(this)");
  i.title="Click to display parse tree"
  i.other=this.server.current_grammar_url
          +"?command=parsetree&format="+f+"&from="+lang+"&tree="+encodeURIComponent(abs);
  return i;
}

function draw_brackets(b) {
    return b.token
	? span_class("token",text(b.token))
	: node("span",{"class":"brackets",
		       title:(b.fun||"_")+":"+b.cat+" "+b.fid+":"+b.index},
	       b.children.map(draw_brackets))
}
