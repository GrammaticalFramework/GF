

var editor=element("editor");

/* -------------------------------------------------------------------------- */
function div_id(id,cs) { return node("div",{id:id},cs); }
function div_class(cls,cs) { return node("div",{"class":cls},cs); }
function a(url,linked) { return node("a",{href:url},linked); }
function ul(lis) { return node("ul",{},lis); }
function li(xs) { return node("li",{},xs); }
function table(rows) { return node("table",{},rows); }
function td_right(cs) { return node("td",{"class":"right"},cs); }
function jsurl(js) { return "javascript:"+js; }

function insertAfter(el,ref) {
    ref.parentNode.insertBefore(el,ref.nextSibling);
}
/* -------------------------------------------------------------------------- */

function initial_view() {
    var current=local.get("current");
    if(current>0) open_grammar(current-1);
    else draw_grammar_list();
    //debug(local.get("dir","no server directory yet"));
}

function draw_grammar_list() {
    local.put("current",0);
    editor.innerHTML="";
    editor.appendChild(node("h3",{},[text("Your grammars")]));
    var gs=ul([]);
    function del(i) { return function () { delete_grammar(i); } }
    for(var i=0;i<local.count;i++) {
	var grammar=local.get(i,null);
	if(grammar && grammar.basename) {
	    var link=a(jsurl("open_grammar("+i+")"),[text(grammar.basename)]);
	    gs.appendChild(
		li([deletable(del(i),link,"Delete this grammar")]))
	}
    }
    if(local.get("count",null)==null)
	editor.appendChild(text("You have not created any grammars yet."));
    else if(local.count==0)
	editor.appendChild(text("Your grammar list is empty."));
    editor.appendChild(gs);

    editor.appendChild(
	ul([li([a(jsurl("new_grammar()"),[text("New grammar")])])]));
    //editor.appendChild(text(local.count));
}

function new_grammar() {
    var g={basename:"Unnamed",
	   abstract:{cats:[],funs:[]},
	   concretes:[]}
    edit_grammar(g);
}

function delete_grammar(i) {
    var g=local.get(i);
    var ok=confirm("Do you really want to delete the grammar "+g.basename+"?")
    if(ok) {
	local.remove(i);
	while(local.count>0 && !local.get(local.count-1))
	    local.count--;
	initial_view();
    }
}

function open_grammar(i) {
    var g=local.get(i);
    g.index=i;
    local.put("current",i+1);
    edit_grammar(g);
}

function close_grammar(g) { save_grammar(g); draw_grammar_list(); }
function reload_grammar(g) { save_grammar(g);  edit_grammar(g); }

function save_grammar(g) {
    if(g.index==null) g.index=local.count++;
    local.put(g.index,g);
}

function edit_grammar(g) {
    editor.innerHTML="";
    editor.appendChild(draw_grammar(g));
}


function draw_grammar(g) {
    var files=div_class("files",[draw_filebar(g),draw_file(g)]);
    return div_class("grammar",[draw_namebar(g,files),files])

}

function draw_namebar(g,files) {
    return div_class("namebar",
		  [table([tr([td(draw_name(g)),
			      td_right([draw_plainbutton(g,files),
					upload_button(g),
					draw_closebutton(g)])])])])
}

function draw_name(g) {
    return editable("h3",text(g.basename),g,edit_name,"Rename grammar");
}

function draw_closebutton(g) {
    var b=button("X",function(){close_grammar(g);});
    b.title="Save and Close this grammar";
    return b;
}

function draw_plainbutton(g,files) {
    var b2;
    function show_editor() { edit_grammar(g); }
    function show_plain() {
	files.innerHTML="<pre class=plain>"+show_grammar(g)+"</pre>"
	b.style.display="none";
	if(b2) b2.style.display="";
	else {
	    b2=button("Show editor",show_editor);
	    insertAfter(b2,b);
	}
    }
    var b=button("Show plain",show_plain);
    b.title="Show plain text representaiton of the grammar";
    return b;
}

function upload_button(g) {
    var b=button("Upload",function(){upload(g);});
    b.title="Upload the grammar to the server to check it in GF and test it in the minibar";
    return b;
}

function lang(code,name) { return { code:code, name:name} }
function lang1(name) {
    var ws=name.split("/");
    return ws.length==1 ? lang(name.substr(0,3),name) : lang(ws[0],ws[1]);
}
var languages =
    map(lang1,"Amharic Arabic Bulgarian Catalan Danish Dutch English Finnish French German Hindi Ina/Interlingua Italian Latin Norwegian Polish Ron/Romanian Russian Spanish Swedish Thai Turkish Urdu".split(" "));
//languages.push(lang("Other","Other"));

var langname={};
//for(var i=0;i<languages.length;i++)
for(var i in languages)
    langname[languages[i].code]=languages[i].name

function add_concrete(g,el) {
    var file=element("file");
    file.innerHTML="";
    var dc={};
//  for(var i=0;i<g.concretes.length;i++)
    for(var i in g.concretes)
	dc[g.concretes[i].langcode]=true;
    var list=[]
//  for(var i=0;i<languages.length;i++) {
    for(var i in languages) {
	var l=languages[i], c=l.code;
	if(!dc[c])
	    list.push(li([a(jsurl("add_concrete2("+g.index+",'"+c+"')"),
			    [text(l.name)])]));
    }
    file.appendChild(text("Pick a language for the new concrete syntax:"));
    file.appendChild(node("ul",{},list));
}

function new_concrete(code) {
    return { langcode:code,params:[],lincats:[],opers:[],lins:[] };
}

function add_concrete2(ix,code) {
    var g=local.get(ix);
    var cs=g.concretes;
    var i;
    for(var i=0;i<cs.length;i++) if(cs[i].langcode==code) break;
    if(i==cs.length) cs.push(new_concrete(code))
    save_grammar(g);
    open_concrete(g,i);
}

function open_abstract(g) { g.current=0; reload_grammar(g); }
function open_concrete(g,i) { g.current=i+1; reload_grammar(g); }

function td_gap(c) {return wrap_class("td","gap",c); }
function gap() { return td_gap(text(" ")); }

function tab(active,link) {
    return  wrap_class("td",active ? "active" : "inactive",link);
}

function delete_concrete(g,ci) {
    var c=g.concretes[ci];
    var ok=c.params.length==0 && c.lincats.length==0 && c.opers.length==0
	   && c.lins.length==0
	|| confirm("Do you really want to delete the concrete syntax for "+
		   langname[c.langcode]+"?");
    if(ok) {
	g.concretes=delete_ix(g.concretes,ci)
	if(g.current && g.current-1>=ci) g.current--;
	reload_grammar(g);
    }
}

function draw_filebar(g) {
    var cur=(g.current||0)-1;
    var filebar = empty_class("tr","extensible")
    filebar.appendChild(gap());
    filebar.appendChild(
	tab(cur== -1,button("Abstract",function(){open_abstract(g);})));
    var cs=g.concretes;
    function del(ci) { return function() { delete_concrete(g,ci); }}
    function open_conc(i) { return function() {open_concrete(g,1*i); }}
//  for(var i=0;i<cs.length;i++)
    for(var i in cs) {
	filebar.appendChild(gap());
	filebar.appendChild(
	    tab(i==cur,deletable(del(i),button(langname[cs[i].langcode],open_conc(i)),"Delete this concrete syntax")));
    }
    filebar.appendChild(td_gap(more(g,add_concrete,"Add a concrete syntax")));
    return wrap_class("table","tabs",filebar);
}

function draw_file(g) {
    return g.current>0 // && g.current<=g.concretes.length
	? draw_concrete(g,g.current-1)
	: draw_abstract(g);
}

function draw_startcat(g) {
    var abs=g.abstract;
    var startcat = abs.startcat || abs.cats[0];
    function opt(cat) { return option(cat,cat); }
    var m= node("select",{},map(opt,abs.cats));
    m.value=startcat;
    m.onchange=function() { abs.startcat=m.value; save_grammar(g); }
    return indent([kw("flags startcat"),sep(" = "),m]);
}

function draw_abstract(g) {
    var kw_cat = kw("cat");
    kw_cat.title = "The categories (nonterminals) of the grammar are enumerated here.";
    var kw_fun = kw("fun");
    kw_fun.title = "The functions (productions) of the grammar are enumerated here.";
    var flags=g.abstract.startcat || g.abstract.cats.length>1
	? draw_startcat(g)
	: text("");
    return div_id("file",
		  [kw("abstract "),ident(g.basename),sep(" = "),
		   flags,
		   indent([extensible([kw_cat,
				       indent(draw_cats(g))]),
			   extensible([kw_fun,
				       indent(draw_funs(g))])])]);
}

function add_cat(g,el) {
    function add(s) {
	var cats=s.split(/\s*(?:\s|[;])\s*/); // allow separating spaces or ";"
	if(cats.length>0 && cats[cats.length-1]=="") cats.pop();
	for(var i in cats) {
	    var err=check_name(cats[i],"Category");
	    if(err) return err;
	}
	for(var i in cats) g.abstract.cats.push(cats[i]);
	reload_grammar(g);
	return null;
    }
    string_editor(el,"",add);
}

function delete_ix(old,ix) {
    var a=[];
//  for(var i=0;i<old.length;i++) if(i!=ix) a.push(old[i]);
    for(var i in old) if(i!=ix) a.push(old[i]);
    return a;
}

function delete_cat(g,ix) {
    with(g.abstract) cats=delete_ix(cats,ix);
    reload_grammar(g);
}

function rename_cat(g,el,cat) {
    function ren(newcat) {
	if(newcat!="" && newcat!=cat) {
	    var err=check_name(newcat,"Category");
	    if(err) return err;
	    var dc=defined_cats(g);
	    if(dc[newcat]) return newcat+" is already in use";
	    g=rename_category(g,cat,newcat);
	    reload_grammar(g);
	}
	return null;
    }
    string_editor(el,cat,ren);
}

function draw_cats(g) {
    var cs=g.abstract.cats;
    var es=[];
    var defined={};
    function eident(cat) {
	function ren(g,el) { rename_cat(g,el,cat); }
	return editable("span",ident(cat),g,ren,"Rename category");
    }
    function check(cat,el) {
	return ifError(defined[cat],"Same category named twice",el);
    }
    function del(i) { return function() { delete_cat(g,i); }}
//  for(var i=0; i<cs.length;i++) {
    for(var i in cs) {
	es.push(deletable(del(i),check(cs[i],eident(cs[i])),"Delete this category"));
	defined[cs[i]]=true;
	es.push(sep("; "));
    }
    es.push(more(g,add_cat,"Add more categories"));
    return es;
}

function add_fun(g,el) {
    function add(s) {
	var p=parse_fun(s);
	if(p.ok) {
	    g.abstract.funs.push(p.ok);
	    reload_grammar(g);
	    return null;
	}
	else
	    return p.error
    }
    string_editor(el,"",add);
}

function edit_fun(i) {
    return function (g,el) {
	function replace(s) {
	    var p=parse_fun(s);
	    if(p.ok) {
		var old=g.abstract.funs[i];
		g.abstract.funs[i]=p.ok;
		if(p.ok.name!=old.name) g=rename_function(g,old.name,p.ok.name);
		if(show_type(p.ok.type)!=show_type(old.type))
		    g=change_lin_lhs(g,p.ok);
		reload_grammar(g);
		return null;
	    }
	    else
		return p.error;
	}
	string_editor(el,show_fun(g.abstract.funs[i]),replace);
    }
}

function delete_fun(g,ix) {
    with(g.abstract) funs=delete_ix(funs,ix);
    reload_grammar(g);
}

function draw_funs(g) {
    var funs=g.abstract.funs;
    var es=[];
    var dc=defined_cats(g);
    var df={};
    function del(i) { return function() { delete_fun(g,i); }}
    function draw_efun(i,df) {
	return editable("span",draw_fun(funs[i],dc,df),g,edit_fun(i),"Edit this function");
    }
//  for(var i=0;i<funs.length;i++) {
    for(var i in funs) {
	es.push(div_class("fun",[deletable(del(i),draw_efun(i,df),"Delete this function")]));
	df[funs[i].name]=true;
    }
    es.push(more(g,add_fun,"Add a new function"));
    return es;
}

function draw_fun(fun,dc,df) {
    function check(el) {
	return ifError(dc[fun.name],
		       "Function names must be distinct from category names",
		       ifError(df[fun.name],"Same function defined twice",el));
    }
    return node("span",{},
		[check(ident(fun.name)),sep(" : "),draw_type(fun.type,dc)]);
}

function draw_type(t,dc) {
    var el=empty("span");
    function check(t,el) {
	return ifError(!dc[t],"Undefined category",el);
    }
//  for(var i=0;i<t.length;i++) {
    for(var i in t) {
	if(i>0) el.appendChild(sep(" → "));
	el.appendChild(check(t[i],ident(t[i])));
    }
    return el;
}

function edit_name(g,el) {
    function change_name(name) {
	if(name!=g.basename && name!="") {
	    var err=check_name(name,"Grammar");
	    if(err) return err;
	    g.basename=name
	    reload_grammar(g);
	}
	return null;
    }
    string_editor(el,g.basename,change_name)
}
/* -------------------------------------------------------------------------- */

function draw_concrete(g,i) {
    var conc=g.concretes[i];
    return div_id("file",
		  [kw("concrete "),ident(g.basename+conc.langcode),
		   kw(" of "),ident(g.basename),sep(" = "),
		   indent([extensible([kw("param"),draw_params(g,i)])]),
		   indent([kw("lincat"),draw_lincats(g,i)]),
		   indent([extensible([kw("oper"),draw_opers(g,i)])]),
		   indent([kw("lin"),draw_lins(g,i)])
		  ])
}


function draw_param(p,dp) {
    function check(el) {
	return ifError(dp[p.name],"Same parameter type defined twice",el);
    }
    return node("span",{},[check(ident(p.name)),sep(" = "),text(p.rhs)]);
}

function add_param(g,ci,el) {
    function add(s) {
	var p=parse_param(s);
	if(p.ok) {
	    g.concretes[ci].params.push(p.ok);
	    reload_grammar(g);
	    return null;
	}
	else
	    return p.error
    }
    string_editor(el,"",add);
}

function edit_param(ci,i) {
    return function (g,el) {
	function replace(s) {
	    var p=parse_param(s);
	    if(p.ok) {
		g.concretes[ci].params[i]=p.ok;
		reload_grammar(g);
		return null;
	    }
	    else
		return p.error;
	}
	string_editor(el,show_param(g.concretes[ci].params[i]),replace);
    }
}


function delete_param(g,ci,ix) {
    with(g.concretes[ci]) params=delete_ix(params,ix);
    reload_grammar(g);
}

function draw_params(g,ci) {
    var conc=g.concretes[ci];
    conc.params || (conc.params=[]);
    var params=conc.params;
    var es=[];
    var dp={};
    function del(i) { return function() { delete_param(g,ci,i); }}
    function draw_eparam(i,dp) {
	return editable("span",draw_param(params[i],dp),g,edit_param(ci,i),"Edit this parameter type");
    }
    for(var i in params) {
	es.push(div_class("param",[deletable(del(i),draw_eparam(i,dp),"Delete this parameter type")]));
	dp[params[i].name]=true;
    }
    es.push(more(g,function(g,el) { return add_param(g,ci,el)},
		 "Add a new parameter type"));
    return indent(es);
}

function delete_lincat(g,ci,cat) {
    var i;
    var c=g.concretes[ci];
    for(i=0;i<c.lincats.length && c.lincats[i].cat!=cat;i++);
    if(i<c.lincats.length) c.lincats=delete_ix(c.lincats,i);
    reload_grammar(g);
}

function draw_lincats(g,i) {
    var conc=g.concretes[i];
    function edit(c) {
	return function(g,el) {
	    function ok(s) {
		if(c.template) conc.lincats.push({cat:c.cat,type:s});
		else c.type=s;
		reload_grammar(g);
		return null;
	    }
	    string_editor(el,c.type,ok)
	}
    }
    function del(c) { return function() { delete_lincat(g,i,c); } }
    function dlc(c,cls) {
	var t=editable("span",text(c.type),g,edit(c),"Edit lincat for "+c.cat);
	return node("span",{"class":cls},
		    [ident(c.cat),sep(" = "),t]);
    }
    var dc=defined_cats(g);
    function draw_lincat(c) {
	var cat=c.cat;
	var err=!dc[cat];
	var l1=dlc(c,"lincat");
	var l2= err ? deletable(del(cat),l1,"Delete this lincat") : l1;
	var l=ifError(err,"lincat for undefined category",l2);
	delete dc[cat];
	return wrap("div",l);
    }
    function dtmpl(c) {	
	return wrap("div",dlc({cat:c,type:"",template:true},"template")); }
    var lcs=map(draw_lincat,conc.lincats);
    for(var c in dc)
	lcs.push(dtmpl(c));
    return indent(lcs);
}

/* -------------------------------------------------------------------------- */

function draw_oper(p,dp) {
    function check(el) {
	return ifError(dp[p.name],"Same operator definition defined twice",el);
    }
    return node("span",{},[check(ident(p.name)),text(" "),text(p.rhs)]);
}

function add_oper(g,ci,el) {
    function add(s) {
	var p=parse_oper(s);
	if(p.ok) {
	    g.concretes[ci].opers.push(p.ok);
	    reload_grammar(g);
	    return null;
	}
	else
	    return p.error
    }
    string_editor(el,"",add);
}

function edit_oper(ci,i) {
    return function (g,el) {
	function replace(s) {
	    var p=parse_oper(s);
	    if(p.ok) {
		g.concretes[ci].opers[i]=p.ok;
		reload_grammar(g);
		return null;
	    }
	    else
		return p.error;
	}
	string_editor(el,show_oper(g.concretes[ci].opers[i]),replace);
    }
}


function delete_oper(g,ci,ix) {
    with(g.concretes[ci]) opers=delete_ix(opers,ix);
    reload_grammar(g);
}

function draw_opers(g,ci) {
    var conc=g.concretes[ci];
    conc.opers || (conc.opers=[]);
    var opers=conc.opers;
    var es=[];
    var dp={};
    function del(i) { return function() { delete_oper(g,ci,i); }}
    function draw_eoper(i,dp) {
	return editable("span",draw_oper(opers[i],dp),g,edit_oper(ci,i),"Edit this operator definition");
    }
    for(var i in opers) {
	es.push(div_class("oper",[deletable(del(i),draw_eoper(i,dp),"Delete this operator definition")]));
	dp[opers[i].name]=true;
    }
    es.push(more(g,function(g,el) { return add_oper(g,ci,el)},
		 "Add a new operator definition"));
    return indent(es);
}

function delete_lin(g,ci,fun) {
    var i;
    var c=g.concretes[ci];
    for(i=0;i<c.lins.length && c.lins[i].fun!=fun;i++);
    if(i<c.lins.length) c.lins=delete_ix(c.lins,i);
    reload_grammar(g);
}

/* -------------------------------------------------------------------------- */
function arg_names(type) {
    function lower(s) { return s.toLowerCase(); }
    var names=map(lower,type);
    names.pop(); // remove result type
    var n,count={},use={};
    for(var i in names) n=names[i],count[n]=0,use[n]=0;
    for(var i in names) count[names[i]]++;
    function unique(n) {
	return count[n]>1 ? n+(++use[n]) : n;
    }
    return map(unique,names);
}

function draw_lins(g,i) {
    var conc=g.concretes[i];
    function edit(f) {
	return function(g,el) {
	    function ok(s) {
		if(f.template)
		    conc.lins.push({fun:f.fun,args:f.args,lin:s});
		else f.lin=s;
		reload_grammar(g);
		return null;
	    }
	    string_editor(el,f.lin,ok)
	}
    }
    function del(fun) { return function () { delete_lin(g,i,fun); } }
    function dl(f,cls) {
	var l=[ident(f.fun)]
	for(var i in f.args) {
	    l.push(text(" "));
	    l.push(ident(f.args[i]));
	}
	l.push(sep(" = "));
	var t=editable("span",text(f.lin),g,edit(f),"Edit lin for "+f.fun);
	l.push(t);
	return node("span",{"class":cls},l);
    }
    var df=defined_funs(g);
    function draw_lin(f) {
	var fun=f.fun;
	var err= !df[fun];
	var l= err ? deletable(del(fun),dl(f,"lin"),"Delete this function") : dl(f,"lin")
	var l=ifError(err,"Function "+fun+" is not part of the abstract syntax",l);
	delete df[fun];
	return wrap("div",l);
    }
    function largs(f) {
	var funs=g.abstract.funs;
	for(var i=0;i<funs.length && funs[i].name!=f;i++);
	return arg_names(funs[i].type);
    }
    function dtmpl(f) {	
	return wrap("div",
		    dl({fun:f,args:largs(f),lin:"",template:true},"template"));
    }
    var ls=map(draw_lin,conc.lins);
    for(var f in df)
	ls.push(dtmpl(f));
    return indent(ls);
}

/* -------------------------------------------------------------------------- */

function upload(g) {
    var dir=local.get("dir","");
    if(dir) upload2(g,dir);
    else ajax_http_get("upload.cgi?dir",
		       function(dir) {
			   local.put("dir",dir);
			   upload2(g,dir);
		       });
}

function upload2(g,dir) {
    var form=node("form",{method:"post",action:"upload.cgi"+dir},
		  [hidden(g.basename,show_abstract(g))])
    for(var i in g.concretes)
	form.appendChild(hidden(g.basename+g.concretes[i].langcode,
				show_concrete(g.basename)(g.concretes[i])));
    editor.appendChild(form);
    form.submit();
    form.parentNode.removeChild(form);
}

function hidden(name,value) {
    return node("input",{type:"hidden",name:name,value:value},[])
}

/* -------------------------------------------------------------------------- */

function string_editor(el,init,ok) {
    var p=el.parentNode;
    function restore() {
	e.parentNode.removeChild(e);
	el.style.display="";
    }
    function done() {
	var edited=e.it.value;
	restore();
	var msg=ok(edited);
	if(msg) start(msg);
	return false;
    }
    function start(msg) {
	el.style.display="none";
	m.innerHTML=msg;
	p.insertBefore(e,el);
	e.it.focus();
    }
    var m=empty_class("span","error_message");
    var i=node("input",{name:"it",value:init},[]);
    if(init.length>10) i.size=init.length+5;
    var e=node("form",{},
	       [i,
		node("input",{type:"submit",value:"OK"},[]),
		button("Cancel",restore),
		text(" "),
		m])
    e.onsubmit=done
    start("");
}

function ifError(b,msg,el) { return b ? inError(msg,el) : el; }

function inError(msg,el) {
    return node("span",{"class":"inError",title:msg},[el]);
}

function kw(txt) { return wrap_class("span","kw",text(txt)); }
function sep(txt) { return wrap_class("span","sep",text(txt)); }
function ident(txt) { return wrap_class("span","ident",text(txt)); }
function indent(cs) { return div_class("indent",cs); }

function extensible(cs) { return div_class("extensible",cs); }

function more(g,action,hint) {
    var b=node("span",{"class":"more","title":hint || "Add more"},
	       [text(" + ")]);
    b.onclick=function() { action(g,b); }
    return b;
}

function editable(tag,cs,g,f,hint) {
    var b=edit_button(function(){f(g,e)},hint);
    var e=node(tag,{"class":"editable"},[cs,b]);
    return e;
}

function edit_button(action,hint) {
    var b=node("span",{"class":"edit","title":hint || "Edit"},[text("%")]);
    b.onclick=action;
    return b;
}

function deletable(del,el,hint) {
    var b=node("span",{"class":"delete",title:hint || "Delete"},[text("×")])
    b.onclick=del;
    return node("span",{"class":"deletable"},[b,el])
}

function touch_edit() {
    var b=node("input",{type:"checkbox"},[]);
    function touch() {
	document.body.className=b.checked ? "nohover" : "hover";
    }
    b.onchange=touch;
    insertAfter(b,editor);
    insertAfter(wrap("small",text("Enable editing on touch devices. ")),b);
    
}

/* --- Initialization ------------------------------------------------------- */

//document.body.appendChild(empty_id("div","debug"));

initial_view();
touch_edit();
