

var editor=element("editor");
var compiler_output=element("compiler_output")

/* -------------------------------------------------------------------------- */

// grammar_cache :: [Grammar]
// grammarlist   :: {Int=>{unique_name:String,basename:ModId}}
var grammar_cache=[]
var grammarlist={}

function reget_grammar(ix) { return grammar_cache[ix]=local.get(ix) }
function get_grammar(ix)   {
    return fix_extends(grammar_cache[ix] || reget_grammar(ix))
}

function put_grammar(ix,g) {
    grammarlist[ix]={unique_name:g.unique_name,basename:g.basename}
    grammar_cache[ix]=g;
    local.put(ix,g)
    local.put(".grammarlist",grammarlist)
}

function remove_grammar(ix) {
    delete grammar_cache[ix];
    delete grammarlist[ix];
    local.remove(ix);
    local.put(".grammarlist",grammarlist)
}

function my_grammar(unique_name) {
    for(var ix in grammarlist)
	if(grammarlist[ix].unique_name==unique_name)
	    return ix
    return null
}

function find_grammar(basename) {
    for(var ix in grammarlist)
	if(grammarlist[ix].basename==basename)
	    return ix
    return null
}

// For sorting grammars alphabetically by name
function byBasename(a,b) {
    return a.basename<b.basename ? -1 : a.basename>b.basename ? 1 : 0;
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
    clear(editor);
    var uploaded=local.get("dir") && local.get("json_uploaded");
    var cloud_upload=
	a(jsurl("upload_json()"),
	  [node("img",{"class":"cloud",
		       src:"P/1306856253_weather_06.png",alt:"[Up Cloud]",
		       title: uploaded
		               ? "Click to upload grammar updates to the cloud"
		               : "Click to store your grammars in the cloud"},
		    [])]);
    var userlist=td(wrap("h3",[text("Your grammars  "),cloud_upload]))
    if(uploaded) {
	var cloud_download=
	    a(jsurl("download_json()"),
	      [node("img",{"class":"cloud",
			   src:"P/1343909216_weather_03.png",alt:"[Down Cloud]",
			   title:"Click to download grammar updates from the cloud"},
		    [])]);
	insertAfter(cloud_download,cloud_upload);
    }
    function edtr(cs) { return wrap_class("tr","extensible deletable",cs); }
    function del(i) { return function () { delete_grammar(i); } }
    function clone(i) { return function () { clone_grammar(i); } }
//  function new_extension(i) { return function (g,b) { new_grammar([g]) }}
    function item(i,gid) {
	//var i=my_grammar(gid.unique_name)
	var link=a(jsurl("open_grammar("+i+")"),[text(gid.basename)]);
	if(!navigator.onLine) pubspan=[]
	else {
	    function publish() {
		pub.disabled=true
		publish_json(get_grammar(i),draw_grammar_list)
	    }
	    var pub=attr({class:"public",
			  title:"Publish a copy of this grammar."},
			 button("Publish",publish))
	    var pubspan=[span_class("more",pub)]
	}
	return edtr([td(delete_button(del(i),"Delete this grammar")),
		     td(title(gid.unique_name || "",link)),
		     td(more(clone(i),"Clone this grammar")),
		     td(pubspan)
		    ])
    }
    if(local.get("count",null)==null)
	userlist.appendChild(text("You have not created any grammars yet."));
    else if(local.count==0)
	userlist.appendChild(text("Your grammar list is empty."));
    else {
	//var ls=[];
	//for(var ix in grammarlist) ls.push(grammarlist[ix])
	//ls.sort(byBasename)
	var rows=[];
	for(var ix in grammarlist) rows.push(item(ix,grammarlist[ix]))
	userlist.appendChild(node("table",{"class":"grammar_list"},rows));
    }

    userlist.appendChild(ul(li(a(jsurl("new_grammar()"),[text("New grammar")]))));
    //editor.appendChild(text(local.count));
    var publiclist=empty_class("td","public_grammars")
    function no_public() {
	userlist.className="no_publish"
    }
    function show_public(files) {
	function rmpublic(file) {
	    return function() { remove_public(file,draw_grammar_list) }
	}
	var h=wrap("h3",text("Public grammars"))
	var ordermenu=wrap("select",[option("Newest first","byAge"),
				     option("Alphabetical","byName")])
	ordermenu.value=local.get("publicOrder","byAge")
	ordermenu.onchange=function(){
	    local.put("publicOrder",ordermenu.value)
	    if(n>1) show_grammars()
	}
	var n=files.length
	var count=n==1 ? " (One grammar)" : " ("+n + " grammars)"
	var t=table(tr([td(h),td(text(count)),td(ordermenu)]))
	publiclist.appendChild(t)
	for(var i in files) {
	    var file=files[i]
	    file.t=new Date(file.time)
	    file.s=file.t.getTime()
	}
	function sort_grammars() {
	    switch(ordermenu.value) {
	    case "byAge":
		files.sort((f1,f2)=>f2.s-f1.s)
		break;
	    case "byName":
		files.sort((f1,f2)=>(f1.path>f2.path)-(f1.path<f2.path))
	    }
	}
	var gt=empty_class("table","grammar_list")
	publiclist.appendChild(gt)
	function show_grammars() {
	    clear(gt)
	    if(files.length>0) {
		sort_grammars()
		var unique_id=local.get("unique_id","-")
		for(var i in files) {
		    var file=files[i].path
		    var parts=file.split(/[-.]/)
		    var basename=parts[0]
		    var unique_name=parts[1]+"-"+parts[2]
		    var mine = my_grammar(unique_name)!=null
		    var from_me = parts[1] == unique_id
		    var del = from_me || mine
			? delete_button(rmpublic(file),"Remove this public grammar")
			: []
		    var tip = mine
			? "This is a copy of your grammar"
			: "Click to download a copy of this grammar"
		    var modt=new Date(files[i].time)
		    var fmtmodt=modt.toDateString()+", "+modt.toTimeString().split(" ")[0]
		    var when=wrap_class("small","modtime",text(" "+fmtmodt))
		    gt.appendChild(edtr([td(del),
					 td(title(tip,
						  a(jsurl('open_public("'+file+'")'),
						    [text(basename)]))),
					 td(when)]))
		}
	    }
	else
	    publiclist.appendChild(p(text("No public grammars are available.")))
	    // This is outside the table so it won't be cleared,
	    // but show_grammars is only called once then there is less
	    // than 2 grammars, so it's OK.
	}
	show_grammars()
    }
    if(navigator.onLine)
	gfcloud_public_json("ls-l",{},show_public,no_public)
    var home=div_class("home",table(tr([userlist,publiclist])))
    home.appendChild(empty_id("div","sharing"));
    editor.appendChild(home)
}

function new_grammar() {
    var g={basename:"Unnamed",
	   comment:"",
	   extends:[],
	   uextends:[],
	   abstract:{cats:[],funs:[]},
	   concretes:[]/*empty_concretes_extending(gs)*/}
    edit_grammar(g);
}
/*
function empty_concretes_extending(gs) {
    var concs=[]
    var langs=[];
    for(var i in gs) {
	var g=gs[i];
	for(var ci in g.concretes) {
	    var conc=g.concretes[ci];
	    var code=conc.langcode;
	    if(!langs[code])
		langs[code]=true,concs.push(new_concrete(code))
	}
    }
    return concs
}
*/
function remove_local_grammar(i) {
    remove_grammar(i);
    while(local.count>0 && !local.get(local.count-1))
	local.count--;
}

function delete_grammar(ix) {
    var g=get_grammar(ix);
    var ok=confirm("Do you really want to delete the grammar "+g.basename+"?")
    if(ok) {
	remove_local_grammar(ix)
	remove_cloud_grammar(g)
	initial_view();
    }
}

function clone_grammar(i) {
    var old=get_grammar(i);
    var g={basename:old.basename,
	   extends:old.extends || [], uextends:old.uextends || [],
	   abstract:old.abstract,concretes:old.concretes}
    save_grammar(g); // we rely on the serialization to eliminate sharing
    draw_grammar_list();
}

function open_grammar(i) {
    var g=get_grammar(i);
    if(g) {
      g.index=i;
      local.put("current",i+1);
      edit_grammar(g);
   }
   else {
     alert("Something went wrong: grammar at index "+i+" is not usable.")
     draw_grammar_list()
  }
}

function open_public(file) {
    function got_json(g) {
	delete g.index
	delete g.unique_name
	delete g.publishedAs
	if(!g.uextends) g.uextends=[]
	reload_grammar(g)
    }
    var parts=file.split(/[-.]/)
    var unique_name=parts[1]+"-"+parts[2]
    var ix=my_grammar(unique_name)
    console.log("open public",file,ix)
    if(ix!=null) open_grammar(ix)
    else gfcloud_public_json("download",{file:file},got_json)
}

function close_grammar(g) {
    clear(compiler_output);
    save_grammar(g);
    draw_grammar_list();
}
function reload_grammar(g) { save_grammar(g);  edit_grammar(g); }

function save_grammar(g) {
    if(g.index==null) g.index=local.count++;
    put_grammar(g.index,g);
}

function edit_grammar(g) {
    replaceChildren(editor,draw_grammar(g));
}

function draw_grammar(g) {
    switch(g.view) {
    case "matrix":
	var files=div_class("files",draw_matrix(g))
	break;
    case "row":
	var files=div_class("files",draw_row(g))
	break;
    default:
	g.view="column"
	var file=draw_file(g)
	var files=div_class("files",[draw_filebar(g,file),file]);
	break;
    }
    return div_class("grammar",[draw_namebar(g,files),files])
}

function draw_namebar(g,files) {
    var err_ind=empty("small"); // space for error indicator
    var cb=compile_button(g,err_ind);
    var mb=minibar_button(g,files,err_ind,cb);
    var qb=quiz_button(g,err_ind);
    //var pb=draw_plainbutton(g,files);

    var fb=draw_view_button(g,"column")
    var mxb=draw_view_button(g,"matrix")
    var rb=draw_view_button(g,"row")

    var xb=draw_closebutton(g);
    var center=[wrap("small",text("View: ")),fb,mxb,rb]
    var right=[err_ind,cb,mb,qb,xb]
    return div_class("namebar",
		     [table([tr([td(draw_name(g)),
				 td_center(center),
				 td_right(right)]),
			     tr([attr({colspan:"3"},td(draw_comment(g)))])
			    ])
		     ])
}

function draw_name(g) {
    return editable("h3",text(g.basename),g,edit_name,"Rename grammar");
}

function draw_closebutton(g) {
    return title("Save and Close this grammar",
		 button("X",function(){close_grammar(g);}))
}

function draw_view_button(g,view) {
    var b=title("Shitch to the "+view+" view of the grammar",
		button(view,function(){open_view(g,view);}))
    b.disabled=g.view==view
    return b;
}

/*
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
*/

function show_compile_error(res,err_ind) {
    var dst=compiler_output
    replaceInnerHTML(err_ind,res.errorcode=="OK" 
		     ? res.errorcode+" "
		     : "<span class=error_message>"+res.errorcode+" </span>")
    if(dst) {
	clear(dst);
	if(res.errorcode=="OK")
	    dst.appendChild(wrap("h3",text("OK")))
	else
	    appendChildren(dst,
			   [node("h3",{"class":"error_message"},
				 [text(res.errorcode)]),
			    wrap("pre",text(res.command)),
			    wrap("pre",text(res.output))])
    }
}

function compile_grammar(g,err_ind,cont) {
    function show_error(res) {
	show_compile_error(res,err_ind);
	if(cont) cont(res)
    }
    replaceInnerHTML(err_ind,"Compiling...");
    replaceInnerHTML(compiler_output,"<h3>Compiling...</h3>");
    upload(g,show_error);
}

function compile_button(g,err_ind) {
    function compile() { compile_grammar(g,err_ind) }
    return title("Upload the grammar to check it in GF for errors",
		 button("Compile",compile));
}

function minibar_button(g,files,err_ind,comp_btn) {
    var b2;
    var minibar_div=div_id("minibar");
    var editor_div= div_id("syntax_editor");

    function page_overlay(inner) {
	return wrap_class("table","page_overlay",tr(td(inner)))
    }

    function extend_grammar(cat0,fun_type0,update_minibar) {
	var fname0="New"+cat0;
	var fun=parse_fun(fname0+" : " + fun_type0).ok;
	var lins=[];
	var dc=defined_cats(g),df=inherited_funs(g);
	var cs=g.concretes
	var ext=div_class("grammar_extension")
	var form;
	var overlay=page_overlay(ext);

	/*
	function draw_extension_v1() { // version 1
	    var cat=fun.type[fun.type.length-1]
	    ext.innerHTML="<h4>Extending "+cat+"</h4>"
	    var ef=editable("span",draw_fun(g,fun,dc,df),g,edit_fun,
			    "Edit this function")
	    var tbl=empty_class("table","extension");
	    tbl.appendChild(tr([th(text("Abstract")),td([kw("fun "),ef])]));
	    var anames=arg_names(fun.type);
	    for(var i in cs) {
		var lc=cs[i].langcode;
		var l=[kw("lin "),ident(fun.name)];
		for(var j in anames) { l.push(text(" ")); l.push(ident(anames[j]));}
		l.push(sep(" = "))
		l.push(editable("span",text(lins[lc] || "..."),g,edit_lin(lc),
				"Edit this linearization"))
		tbl.appendChild(tr([th(text(concname(cs[i].langcode))),td(l)]));
	    }
	    ext.appendChild(tbl);
	    ext.appendChild(button("OK",save_extension))
	    ext.appendChild(button("Cancel",cancel_extension))
	}
	function edit_fun(g,el) {
	    function replace(s) {
		var p=parse_fun(s);
		if(p.ok) {
		    fun=p.ok;
		    draw_extension_v1();
		    return null;
		}
		else
		    return p.error;
	    }
	    string_editor(el,show_fun(fun),replace);
	}
	function edit_lin(lc) {
	    return function (g,el) {
		function check(s,cont) {
		    function replace() {
			lins[lc]=s;
			draw_extension_v1();
			return null;
		    }
		    function check2(msg) { if(msg) cont(msg); else replace(); }
		    check_exp(s,check2);
		}
		string_editor(el,lins[lc] || "",check,true);
	    }
	}
	*/
	function draw_extension() { // version 2
	    var cat=fun.type[fun.type.length-1]
	    ext.innerHTML="<h4>Extending "+cat+"</h4>"
	    var fun_name_els=[];
	    function update_fun_name() {
		//console.log("update_fun_name")
		fun.name=fun_name.value;
		for(var fi in fun_name_els)
		    fun_name_els[fi].innerHTML=fun.name
	    }
	    var fun_name=node("input",{"class":"string_edit",
				       name:"Abstract",
				       value:fun.name})
	    fun_name.onchange=update_fun_name;
	    fun_name.onblur=update_fun_name;
	    var ef=wrap("span",[fun_name,sep(" : "),draw_type(fun.type,dc)])
	    var tbl=empty_class("table","extension");
	    tbl.appendChild(tr([th(text("Abstract")),td([kw("fun "),ef])]));
	    var anames=arg_names(fun.type);
	    for(var i in cs) {
		var lc=cs[i].langcode;
		var fn=ident(fun.name);
		fun_name_els.push(fn);
		var l=[kw("lin "),fn];
		for(var j in anames) { l.push(text(" ")); l.push(ident(anames[j]));}
		l.push(sep(" = "))
		l.push(node("input",{"class":"string_edit",
				     placeholder:"...",size:30,
				     name:lc,value:lins[lc] || ""}))
		tbl.appendChild(tr([th(text(concname(cs[i].langcode))),td(l)]));
	    }
	    form=node("form",{},[tbl])
	    form.onsubmit=save_extension;
	    form.appendChild(node("input",{type:"submit",value:"OK"}))
	    form.appendChild(button("Cancel",cancel_extension))
	    ext.appendChild(form);
	    // fun_name.focus(); // can't focus before adding it to the document
	    return fun_name;
	}
	function save_extension() {
	    //console.log("save_extension")
	    function extend_grammar(newg) {
		newg.abstract.funs.push(fun);
		var cs=newg.concretes
		for(var ci in cs) {
		    var lc=cs[ci].langcode
		    if(lins[lc]) {
			var lin={fun: fun.name, args: arg_names(fun.type),
				 lin: lins[lc]}
			cs[ci].lins.push(lin)
		    }
		}
	    }
	    function save_if_ok(res) {
		if(res.errorcode=="OK") {
		    extend_grammar(g);
		    save_grammar(g);
		    files.removeChild(overlay)
		    minibar_div.style.minHeight="0px";
		    if(update_minibar) update_minibar();
		    //goto_minibar();
		}
	    }
	    // Collect input from the form
	    fun.name=form["Abstract"].value;
	    for(var i in cs) {
		var lc=cs[i].langcode;
		lins[lc]=form[lc].value;
	    }
	    // This is not functional programming, so copy the grammar first...
	    var newg=JSON.parse(JSON.stringify(g));
	    extend_grammar(newg)
	    compile_grammar(newg,err_ind,save_if_ok);
	    return false; // prevent regular form submission
	}
	function cancel_extension() {
	    files.removeChild(overlay)
	    minibar_div.style.minHeight="0px";
	    //goto_minibar();
	}
	var fun_name=draw_extension();
	files.appendChild(overlay)
	fun_name.focus();
	// Hack to prevent the overlay from overflowing the minibar div:
	minibar_div.style.minHeight=overlay.clientHeight-11+"px"
	//overlay.onresize= ... // doesn't work :-(
    }

    function show_editor() {
	clear(minibar_div);
	edit_grammar(g);
    }

    function goto_minibar() {
	clear(files);
	appendChildren(files,[minibar_div,editor_div]);
	var online_options={grammars_url: local.get("dir")+"/",
			    grammar_list: [g.basename+".pgf"]}
	var pgf_server=pgf_online(online_options)
	var minibar_options= {
	    show_abstract: true,
	    show_trees: true,
	    show_grouped_translations: false,
	    show_brackets: true,
	    word_replacements: true,
	    extend_grammar: extend_grammar,
	    default_source_language: "Eng",
	    try_google: true
	}
	var minibar=new Minibar(pgf_server,minibar_options);
	b.style.display="none";
	comp_btn.disabled=true;
	if(b2) b2.style.display="";
	else {
	    b2=button("Show editor",show_editor);
	    insertAfter(b2,b);
	}
    }
    function goto_minibar_if_ok(res) { if(res.errorcode=="OK") goto_minibar(); }
    function compile() { compile_grammar(g,err_ind,goto_minibar_if_ok) }
    var b=button("Minibar",compile)
    return title("Upload the grammar and test it in the minibar",b)
}

function quiz_button(g,err_ind) {
    function goto_quiz(res) {
	if(res.errorcode=="OK")
	    location.href="../TransQuiz/translation_quiz.html?"+local.get("dir")+"/"
    }
    function compile() { compile_grammar(g,err_ind,goto_quiz) }
    return title("Upload the grammar and go to the translation quiz",
		 button("Quiz",compile))
}

function add_concrete(g,file) {
    clear(file);
    var dc={};
    for(var i in g.concretes)
	dc[g.concretes[i].langcode]=true;
    var list=[]
    function addconc(name,code) {
	if(!dc[code])
	    list.push(li([a(jsurl("add_concrete2("+g.index+",'"+code+"')"),
			    [text(name)])]));
    }
    for(var i in languages)
	addconc(languages[i].name,languages[i].code)
    addconc("Other","Other")
    var from= g.current>0 
	? "a copy of "+concname(g.concretes[g.current-1].langcode)
	:"scratch";
    file.appendChild(p(text("You are about to create a new concrete syntax by starting from "+from+".")));
    file.appendChild(p(text("Pick a language for the new concrete syntax:")));
    file.appendChild(node("ul",{"class":"languages"},list));
}

function new_concrete(code) {
    return { langcode:code,params:[],lincats:[],opers:[],lins:[] };
}

function adjust_opens(cnc,oldcode,code) {
    for(var oi in cnc.opens)
	for(var li in rgl_modules)
	    if(cnc.opens[oi]==rgl_modules[li]+oldcode)
		cnc.opens[oi]=rgl_modules[li]+code;
}

function add_concrete2(ix,code) {
    var g=get_grammar(ix);
    var cs=g.concretes;
    var ci;
    for(var ci=0;ci<cs.length;ci++) if(cs[ci].langcode==code) break;
    if(ci==cs.length) {
	if(g.current>0) {
	    cs.push(cs[g.current-1]); // old and new are shared at this point
	    save_grammar(g); // serialization loses sharing
	    g=reget_grammar(ix); // old and new are separate now
	    var oldcode=cs[g.current-1].langcode;
	    var cnc=g.concretes[ci];
	    cnc.langcode=code;
	    adjust_opens(cnc,oldcode,code);
	    timestamp(cnc)
	}
	else
	    cs.push(new_concrete(code))
	save_grammar(g);
    }
    open_concrete(g,ci);
}

function open_abstract(g) { g.view="column"; g.current=0; reload_grammar(g); }
function open_concrete(g,i) { g.view="column"; g.current=i+1; reload_grammar(g); }

function open_view(g,view) { g.view=view; reload_grammar(g); }

function open_matrix(g)    { open_view(g,"matrix") }
function open_row(g)       { open_view(g,"row") }
function open_column(g)    { open_view(g,"column") }

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
		   concname(c.langcode)+"?");
    if(ok) {
	g.concretes=delete_ix(g.concretes,ci)
	if(g.current && g.current-1>=ci) g.current--;
	reload_grammar(g);
    }
}

function abs_tab_button(g) {
    return button("Abstract",function(){open_abstract(g);})
}

function conc_tab_button(g,ci,no_delete) {
    var cs=g.concretes
    function del() { delete_concrete(g,ci); }
    function open_conc() {open_concrete(g,1*ci); }
    var b=button(concname(cs[ci].langcode),open_conc)
    return no_delete ? b : deletable(del,b,"Delete this concrete syntax")
}

function draw_filebar(g,file) {
    var cur=(g.current||0)-1;
    var filebar = empty_class("tr","extensible")
    filebar.appendChild(gap());
    filebar.appendChild(tab(cur== -1,abs_tab_button(g)));
    for(var i in g.concretes) {
	filebar.appendChild(gap());
	filebar.appendChild(tab(i==cur,conc_tab_button(g,i)));
    }
    function add_conc(el) { return add_concrete(g,file) }
    filebar.appendChild(td_gap(more(add_conc,"Add a concrete syntax")));
    return wrap_class("table","tabs",filebar);
}

function draw_file(g) {
    if(g.current>g.concretes.length) g.current=0; // bug resilience
    return g.current>0
	? draw_concrete(g,g.current-1)
	: draw_abstract(g);
}

function draw_startcat(g) {
    var abs=g.abstract;
    var startcat = abs.startcat || abs.cats[0];
    function opt(cat) { return option(cat,cat); }
    var opts = g.extends && g.extends.length>0 ? [opt("-")] : [];
    var dc=defined_cats(g);
    for(var cat in dc) if(dc[cat]!="Predef") opts.push(opt(cat));
    var m = node("select",{},opts);
    m.value=startcat;
    m.onchange=function() { 
	if(m.value!=abs.startcat) {
	    abs.startcat=m.value;
	    timestamp(abs);
	    save_grammar(g); 
	}
    }
    return indent([kw("flags startcat","This is the default start category for parsing, random generation, etc. [C.3.16, C.5.1]"),
		   sep(" = "),m]);
}

var extends_hint="This grammar is an extension of the grammars listed here. [C.2.1]"

function draw_conc_extends(g,conc) {
    var kw_extends=kw("extends ",extends_hint)
    var exts=(g.extends || []).map(conc_extends(conc))
    return exts.length>0
	? indent([kw_extends,ident(exts.join(", "))])
	: text("")
}

function draw_extends(g) {
    var kw_extends=kw("extends ",extends_hint)
    var exts= g.extends || [];
    var es=[exts.length>0 ? kw_extends : span_class("more",kw_extends)];
    function del(i) { return function() { delete_extends(g,i); }}
    for(var i=0;i<exts.length;i++) {
	if(i>0) es.push(sep(", "))
	es.push(deletable(del(i),ident(exts[i]),"Don't inherit from "+exts[i]));
    }
    var w= exts.length>0 ? "more" : "other"
    function add_exts(el) { return add_extends(g); }
    es.push(more(add_exts,"Inherit from "+w+" grammars"))
    return indent([extensible(es)])
}

function delete_extends(g,ix) {
    g.extends=delete_ix(g.extends,ix);
    g.uextends=delete_ix(g.uextends,ix);
    //timestamp(g);
    reload_grammar(g);
}

function add_extends(g) {
    var file=element("file");
    clear(file)
    var gs=grammarlist
    var list=[]
    for(var i in gs) {
	var ig=get_grammar(i)
	if(gs[i].unique_name && gs[i].basename!=g.basename
	   && !elem(gs[i].basename,g.extends || [])
	   && !elem(g.basename,ig.extends || [])
	   // should also exclude indirectly inherited grammars!!
	  )
	    list.push(li([a(jsurl("add_extends2("+g.index+","+i+")"),
			    [text(gs[i].basename)])]));
    }
    file.appendChild(p(text("Pick a grammar to inherit:")));
    file.appendChild(node("ul",{"class":"grammars"},list));
}

function add_extends2(gix,igix) {
    var g=get_grammar(gix);
    if(!g.extends) g.extends=[];
    g.extends.push(grammarlist[igix].basename);
    g.uextends.push(grammarlist[igix].unique_name);
    //timestamp(g)
    reload_grammar(g);
}

function draw_abstract(g) {
    var kw_abstract = kw("abstract ","A GF grammar must have one abstract syntax module. [C.2.1]")
    var kw_cat = kw("cat","The categories (nonterminals) of the grammar are enumerated here. [C.3.2]");
    var kw_fun = kw("fun","The functions (productions) of the grammar are enumerated here. [C.3.4]");

    var flags=g.abstract.startcat || g.abstract.cats.length>1
              || g.extends && g.extends.length>0
	? draw_startcat(g)
	: text("");
    function sort_funs() {
	g.abstract.funs=sort_list(this,g.abstract.funs,"name");
	timestamp(g.abstract);
	save_grammar(g);
    }
    var file=div_id("file",
		  [kw_abstract,ident(g.basename),sep(" = "),
		   /*draw_timestamp(g.abstract),*/
		   draw_extends(g),
		   flags,
		   indent([extensible([kw_cat,
				       indent(draw_cats(g))]),
			   extensible([kw_fun,
				       indent_sortable(draw_funs(g),sort_funs)])])]);
    if(navigator.onLine) {
	var mode_button=text_mode(g,file,0);
	insertBefore(mode_button,file.firstChild)
    }
    return file;
}

function draw_comment(g) {
    return div_class("comment",editable("span",text(g.comment || "…"),g,edit_comment,"Edit grammar description"));
}

function module_name(g,ix) {
    return ix==0 ? g.basename : g.basename+g.concretes[ix-1].langcode
}
function show_module(g,ix) {
    return ix==0 ? show_abstract(g) : show_concrete(g)(g.concretes[ix-1]);
}

function text_mode(g,file,ix) {
    var path=module_name(g,ix)+".gf"
    function switch_to_guided_mode() {
	clear(compiler_output);
	edit_grammar(g); // !!
    }
    function store_parsed(parse_results) {
	var dst=compiler_output;
	var msg=parse_results[path];
	clear(dst)
	//console.log(msg)
	if(dst && msg.error)
	    dst.appendChild(span_class("error_message",
				       text(msg.location+": "+msg.error)))
	else if(dst && msg.parsed)
	    dst.innerHTML=
	      "Accepted by GF, but not by this editor ("+msg.parsed+")"
	else if(msg.converted) {
	    if(ix==0) {
		var gnew=msg.converted;
		g.abstract=gnew.abstract;
		//g.extends=gnew.extends;
		timestamp(g.abstract);
		save_grammar(g);
	    }
	    else {
		var conc=g.concretes[ix-1];
		var cnew=msg.converted.concretes[0];
		conc.opens=cnew.opens;
		conc.params=cnew.params;
		conc.lincats=cnew.lincats;
		conc.opers=cnew.opers;
		conc.lins=cnew.lins;
		timestamp(conc);
		save_grammar(g);
	    }
	}
	else replaceInnerHTML(dst,"unexpected parse result");
    }
    var last_source=show_abstract(g);
    function parse(source) {
	if(source!=last_source) {
	    if(navigator.onLine) {
		//clear(compiler_output) // makes the page "jumpy"
		last_source=source;
		check_module(path,source,store_parsed)
	    }
	    else replaceInnerHTML(compiler_output,
				  "Offline, edits will not be saved")
	}
    }
    function switch_to_text_mode() {
	var ta=node("textarea",{class:"text_mode",rows:25,cols:80},
		    [text(show_module(g,ix))])
	var timeout;
	ta.onkeyup=function() {
	    if(timeout) clearTimeout(timeout);
	    timeout=setTimeout(function(){parse(ta.value)},400)
	}
	var mode_button=div_class("right",[button("Guided mode",switch_to_guided_mode)])
	clear(file)
	appendChildren(file,[mode_button,ta])
	//ta.style.height=ta.scrollHeight+"px";
	ta.focus();
    }
    var mode_button=div_class("right",[button("Text mode",switch_to_text_mode)])
    return mode_button;
}

function add_cat(g) {
    function add(s) {
	var cats=s.split(/\s*(?:\s|[;])\s*/); // allow separating spaces or ";"
	if(cats.length>0 && cats[cats.length-1]=="") cats.pop();
	for(var i in cats) {
	    var err=check_name(cats[i],"Category");
	    if(err) return err;
	}
	for(var i in cats) g.abstract.cats.push(cats[i]);
	timestamp(g.abstract);
	reload_grammar(g);
	return null;
    }
    return function(el) { string_editor(el,"",add); }
}

function delete_cat(g,ix) {
    with(g.abstract) cats=delete_ix(cats,ix);
    timestamp(g.abstract);
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
	    timestamp(g.abstract);
	    reload_grammar(g);
	}
	return null;
    }
    string_editor(el,cat,ren);
}

function duplicated(g,kind,orig) {
    return orig==g.basename
	? "Same "+kind+" defined twice in this module"
	: "Same "+kind+" already defined in "+orig
}

function draw_ecat(g,i,dc) { // modifies dc !!
    var cs=g.abstract.cats;
    var cat=cs[i]
    function ren(g,el) { rename_cat(g,el,cat); }
    var eident=editable("span",ident(cat),g,ren,"Rename category");
    var check=ifError(dc[cat],duplicated(g,"category",dc[cat]),eident);
    function del() { delete_cat(g,i); }
    var c=deletable(del,check,"Delete this category")
    dc[cs[i]]=g.basename;
    return c
}

function draw_cats(g) {
    var cs=g.abstract.cats;
    var es=[];
    var dc=inherited_cats(g);
    for(var i in cs) {
	es.push(draw_ecat(g,i,dc));
	es.push(sep("; "));
    }
    es.push(more(add_cat(g),"Add more categories"));
    return es;
}

function add_fun(g) {
    function add(s) {
	var p=parse_fun(s);
	if(p.ok) {
	    g.abstract.funs.push(p.ok);
	    timestamp(g.abstract);
	    reload_grammar(g);
	    return null;
	}
	else
	    return p.error
    }
    return function(el) { string_editor(el,"",add);}
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
		timestamp(g.abstract);
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
    timestamp(g.abstract);
    reload_grammar(g);
}

function draw_funs(g) {
    var funs=g.abstract.funs;
    var es=[];
    var dc=defined_cats(g);
    var df=inherited_funs(g);
    for(var i in funs) {
	es.push(node_sortable("fun",funs[i].name,[draw_efun(g,i,dc,df)]));
    }
    es.push(more(add_fun(g),"Add a new function"));
    return es;
}

function draw_efun(g,i,dc,df,click) { // modifies df !!
    var funs=g.abstract.funs;
    function del() { delete_fun(g,i); }
    var f=deletable(del,editable("span",draw_fun(g,funs[i],dc,df,click),g,edit_fun(i),"Edit this function"),"Delete this function");
    df[funs[i].name]=g.basename;
    return f
}

function draw_fun(g,fun,dc,df,click) {
    function check(el) {
	return ifError(dc[fun.name],
		       "Function names must be distinct from category names",
		       ifError(df[fun.name],duplicated(g,"function",df[fun.name]),el));
    }
    var d=node("span",{},
	       [check(ident(fun.name)),sep(" : "),draw_type(fun.type,dc)]);
    if(click) d.onclick=click;
    return d;
}

function draw_type(t,dc) {
    var el=empty("span");
    function check(t,el) {
	if(dc[t]) el.title=dc[t]+"."+t;
	return ifError(!dc[t],"Undefined category",el);
    }
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

function edit_comment(g,el) {
    function change_comment(comment) {
	g.comment=comment
	reload_grammar(g);
	return null;
    }
    string_editor(el,g.comment || "",change_comment)
}
/* -------------------------------------------------------------------------- */

function draw_concrete(g,i) {
    var conc=g.concretes[i];
    function edit_langcode(g,el) {
	function change_langcode(code) {
	    var err=check_name(g.basename+code,"Name of concrete syntax");
	    if(err) return err;
	    adjust_opens(conc,conc.langcode,code);
	    conc.langcode=code;
	    timestamp(conc);
	    reload_grammar(g);
	}
	string_editor(el,conc.langcode,change_langcode)
    }
    var kw_concrete=kw("concrete ", "A GF grammar can have any number of concrete syntax modules matching the abstract syntax [C.2.1]")
    var kw_open=kw("open ","Opening makes constants from other modules available in this module. [C.2.8]")
    var kw_lincat=kw("lincat","The linearization type for each catagory in the abstract syntax is given here. [C.3.8]")
    var kw_lin=kw("lin","The linearization function for each function in the abstract syntax is given here. [C.3.9]")
    var kw_param=kw("param","Parameter type definitions can be added here. [C.3.12]")
    var kw_oper=kw("oper","Operation definitions can be added here. [C.3.14]")
    var file=div_id("file",
		  [kw_concrete,
		   ident(g.basename),
		   editable("span",ident(conc.langcode),g,
			    edit_langcode,"Change language"),
		   kw(" of "),ident(g.basename),sep(" = "),
		   /*draw_timestamp(conc),*/
		   draw_conc_extends(g,conc),
		   indent([extensible([kw_open,draw_opens(g,i)])]),
		   indent([kw_lincat,draw_lincats(g,i)]),
		   indent([kw_lin,draw_lins(g,i)]),
		   indent([extensible([kw_param,draw_params(g,i)])]),
		   indent([extensible([kw_oper,draw_opers(g,i)])]),
		   exb_extra(g,i)
		  ])
    if(navigator.onLine) {
	var mode_button=text_mode(g,file,i+1);
	insertBefore(mode_button,file.firstChild)
    }
    return file;
}

var rgl_modules=["Syntax","Lexicon","Paradigms","Extra","Symbolic"];
var common_modules=["Prelude"];
var rgl_info = {
    Prelude: "Some facilities usable in all grammars",
    Paradigms: "Lexical categories (A, N, V, ...) and smart paradigms (mkA, mkN, mkV, ...) for turning raw strings into new dictionary entries.",
    Syntax: "Syntactic categories (Utt, Cl, V, NP, CN, AP, ...), structural words (this_Det, few_Det, ...) and functions for building phrases (mkUtt, mkCl, mkCN, mkVP, mkAP, ...)",
    Lexicon: "A multilingual lexicon with ~350 common words.",
    Extra: "Language-specific extra constructions not available via the common API.",
    Symbolic: "Functions for symbolic expressions (numbers and variables in mathematics)"
}

function add_open(g,ci) {
    return function (el) {
	var conc=g.concretes[ci];
	var os=conc.opens;
	var ds={};
	for(var i in os) ds[os[i]]=true;
	var list=[]
	function add_module(b,m) {
	    if(!ds[m]) {
		var info=rgl_info[b];
		var infotext=info ? text(" - "+info) : text("");
		list.push(li([a(jsurl("add_open2("+g.index+","+ci+",'"+m+"')"),
				[text(m)]),infotext]));
	    }
	}
	for(var i in rgl_modules) {
	    var b=rgl_modules[i];
	    add_module(b,b+conc.langcode)
	}
	for(var i in common_modules) {
	    var b=common_modules[i];
	    add_module(b,b)
	}
	if(list.length>0) {
	    var file=element("file");
	    clear(file)
	    file.appendChild(p(text("Pick a resource library module to open:")));
	    file.appendChild(node("ul",{},list));
	}
    }
}

function add_open2(ix,ci,m) {
    var g=get_grammar(ix);
    var conc=g.concretes[ci];
    conc.opens || (conc.opens=[]);
    conc.opens.push(m);
    timestamp(conc);
    save_grammar(g);
    open_concrete(g,ci);
}

function delete_open(g,ci,ix) {
    with(g.concretes[ci]) opens=delete_ix(opens,ix);
    timestamp(g.concretes[ci]);
    reload_grammar(g);
}

function draw_opens(g,ci) {
    var conc=g.concretes[ci];
    var os=conc.opens || [] ;
    var es=[];
    function del(i) { return function() { delete_open(g,ci,i); }}
    function show_opers(m) {
	return function(event) {
	    var link=event.target,dst=compiler_output
	    function cont2(opers) {
		clear(dst);
		var sheet=div_class("sheet",[wrap("h3",text(m)),
					     wrap("pre",text(opers))])
		var dy=dst.offsetTop-link.offsetTop-link.offsetHeight
		sheet.style.top="-"+dy+"px";
		insertFirst(dst,sheet)
		setTimeout(function(){sheet.style.top="0px";},1000)
	    }
	    function cont1() { gfshell("so",cont2) }
	    gfshell("i -retain alltenses/"+m+".gfo",cont1)
	}
    }
    var first=true;
    for(var i in os) {
	if(!first) es.push(sep(", "))
	var m=os[i];
	var b=m.substr(0,m.length-conc.langcode.length);
	var info=rgl_info[m] || rgl_info[b];
	var id=ident(m);
	if(info) id.title=info;
	id.onclick=show_opers(m)
	id.className="ident onclick"
	es.push(deletable(del(i),id,"Don't open this module"));
	first=false;
    }
    es.push(more(add_open(g,ci),"Open more modules"));
    return indent(es);
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
	    timestamp(g.concretes[ci]);
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
		timestamp(g.concretes[ci]);
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
    timestamp(g.concretes[ci]);
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
    es.push(more(function(el) { return add_param(g,ci,el)},
		 "Add a new parameter type"));
    return indent(es);
}

function delete_lincat(g,ci,cat) {
    var i;
    var c=g.concretes[ci];
    for(i=0;i<c.lincats.length && c.lincats[i].cat!=cat;i++);
    if(i<c.lincats.length) c.lincats=delete_ix(c.lincats,i);
    timestamp(c);
    reload_grammar(g);
}

function draw_lincats(g,i) {
    var conc=g.concretes[i];
    function edit(c) {
	return function(g,el) {
	    function check(s,cont) {
		function check2(msg) {
		    if(!msg) {
			if(c.template) conc.lincats.push({cat:c.cat,type:s});
			else c.type=s;
			reload_grammar(g);
		    }
		    cont(msg);
		}
		check_exp(s,check2);
	    }
	    string_editor(el,c.type,check,true)
	}
    }
    function del(c) { return function() { delete_lincat(g,i,c); } }
    function dlc(c,cls) {
	var t=editable("span",text_ne(c.type),g,edit(c),"Edit lincat for "+c.cat);
	return node("span",{"class":cls},
		    [ident(c.cat),sep(" = "),t]);
    }
    var dc=locally_defined_cats(g,{});
    function draw_lincat(c) {
	var cat=c.cat;
	var err=!dc[cat];
	var l1=dlc(c,"lincat");
	var l2= deletable(del(cat),l1,"Delete this lincat");
	var l=ifError(err,"lincat for undefined category",l2);
	delete dc[cat];
	return node_sortable("lincat",cat,[l]);
    }
    function dtmpl(c) {	
	return wrap("div",dlc({cat:c,type:"",template:true},"template")); }
    var lcs=map(draw_lincat,conc.lincats);
    for(var c in dc)
	lcs.push(dtmpl(c));
    function sort_lincats() {
	conc.lincats=sort_list(this,conc.lincats,"cat");
	timestamp(conc);
	save_grammar(g);
    }
    return indent_sortable(lcs,sort_lincats);
}

/* -------------------------------------------------------------------------- */

function draw_oper(p,dp) {
    function check(el) {
	return ifError(dp[p.name],"Same operator definition defined twice",el);
    }
    return node("span",{},[check(ident(p.name)),text(" "),text(p.rhs)]);
}

function check_oper(s,ok,err) {
    var p=parse_oper(s);
    function check2(msg) {
	if(msg) err(msg);
	else ok(p.ok)
    }
    if(p.ok) {
	// Checking oper syntax by checking an expression with a local
	// definition. Some valid opers will be rejected!!
	var e=p.ok.name+" where { "+p.ok.name+" "+p.ok.rhs+" }";
	check_exp(e,check2);
    }
    else
	err(p.error);
}

function add_oper(g,ci,el) {
    function check(s,cont) {
	function ok(oper) {
	    g.concretes[ci].opers.push(oper);
	    timestamp(g.concretes[ci]);
	    reload_grammar(g);
	    cont(null);
	}
	check_oper(s,ok,cont)
    }
    text_editor(el,"",check,true);
}

function edit_oper(ci,i) {
    return function (g,el) {
	function check(s,cont) {
	    function ok(oper) {
		g.concretes[ci].opers[i]=oper;
		timestamp(g.concretes[ci]);
		reload_grammar(g);
		cont(null);
	    }
	    check_oper(s,ok,cont)
	}
	text_editor(el,show_oper(g.concretes[ci].opers[i]),check,true);
    }
}

function delete_oper(g,ci,ix) {
    with(g.concretes[ci]) opers=delete_ix(opers,ix);
    timestamp(g.concretes[ci]);
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
	es.push(node_sortable("oper",opers[i].name,
			      [deletable(del(i),draw_eoper(i,dp),
					 "Delete this operator definition")]));
	dp[opers[i].name]=true;
    }
    es.push(more(function(el) { return add_oper(g,ci,el)},
		 "Add a new operator definition"));
    function sort_opers() {
	conc.opers=sort_list(this,conc.opers,"name");
	timestamp(conc);
	save_grammar(g);
    }
    return indent_sortable(es,sort_opers);
}

function delete_lin(g,ci,fun) {
    var c=g.concretes[ci];
    var i=lin_index(c,fun);
    if(i!=null) {
	c.lins=delete_ix(c.lins,i);
	timestamp(c);
	reload_grammar(g);
    }
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

function draw_elin(g,igs,ci,f,dc,df) {
    var fun=f.fun;
    var conc=g.concretes[ci];
    function edit(g,el) {
	function check(s,cont) {
	    function check2(msg) {
		if(!msg) {
		    if(f.template)
			conc.lins.push({fun:f.fun,args:f.args,lin:s});
		    else { f.lin=s; f.eb_lin=null; }
		    timestamp(conc);
		    reload_grammar(g);
		}
		cont(msg);
	    }
	    check_exp(s,check2);
	}
	text_editor(el,f.lin,check,true)
    }
    function dl(cls) {
	var fn=ident(f.fun)
	var fty=function_type(g,f.fun)
	var linty=fty && lintype(g,conc,igs,dc,fty)
	if(fty)
	    fn.title="fun "+f.fun+": "+show_type(fty)
                    +"\nlin "+f.fun+": "+show_lintype(linty)
	var l=[fn]
	for(var i=0; i<f.args.length;i++) {
	    l.push(text(" "));
	    var an=ident(f.args[i])
	    if(linty) an.title=f.args[i]+": "+linty[i]
	    l.push(an);
	}
	l.push(sep(" = "));
	var t=editable("span",text_ne(f.lin),g,edit,"Edit lin for "+f.fun);
	t.appendChild(exb_linbuttons(g,ci,f));
	l.push(t);
	return node("span",{"class":cls},l);
    }
    function del() { delete_lin(g,ci,fun); }
    var l=dl(f.template ? "template" : "lin")
    if(!f.template) {
	l=deletable(del,l,"Delete this linearization function")
	delete df[fun];
    }
    return l;
}

function lin_template(g,f) {
    var args=arg_names(function_type(g,f))
    return {fun:f,args:args,lin:"",template:true}
}

function draw_lins(g,ci) {
    var conc=g.concretes[ci];
    var igs=inherited_grammars(g)
    var dc=defined_cats(g);
    var df=locally_defined_funs(g,{});
    function draw_lin(f) {
	var err= !df[f.fun];
	var l=draw_elin(g,igs,ci,f,dc,df)
	var l=ifError(err,"Function "+f.fun+" is not part of the abstract syntax",l);
	return node_sortable("lin",f.fun,[l]);
    }
    function dtmpl(f) {	
	var lin=lin_template(g,f)
	return div_class("template",draw_elin(g,igs,ci,lin,dc,df))
    }
    function sort_lins() {
	conc.lins=sort_list(this,conc.lins,"fun");
	timestamp(conc);
	save_grammar(g);
    }
    var ls=map(draw_lin,conc.lins);
    for(var f in df)
	ls.push(dtmpl(f));
    return indent_sortable(ls,sort_lins);
}


// Return the linearization type for the given abtract type in the given 
// concrete syntax, taking into account that lincats may be defined in
// inherited grammars.
// lintype:: Grammar -> Concrete -> [Grammar] -> {Cat=>ModId} => Type -> LinType
function lintype(g,conc,igs,dc,type) {
    //console.log(dc)
    function ihcat_lincat(cat) {
	if(dc[cat]=="Predef") return "{s:Str}" // !!! Is this right?
	var ig=find_inherited_grammar_byname(igs,dc[cat])
	if(!ig) return "??"
	var iconc=ig.concretes[conc_index(ig,conc.langcode)]
	if(!iconc) return "??"
	return cat_lincat(iconc,cat) || "??"
    }
    function lincat(cat) {
	return dc[cat]
	    ? (dc[cat]==g.basename ? cat_lincat(conc,cat) : ihcat_lincat(cat))
	      || "??"
	    : cat+"??"
    }
    return type.map(lincat)
}

function find_inherited_grammar_byname(igs,name) {
    for(var i in igs) if(igs[i].basename==name) return igs[i]
    return null
}

/* -------------------------------------------------------------------------- */

function draw_matrix(g) {
    var row=[th(abs_tab_button(g))]
    var t=empty_class("table","matrixview")
    for(var ci in g.concretes)
	row.push(th(conc_tab_button(g,ci)))
    t.appendChild(tr(row))

    var dc=inherited_cats(g);
    var df=inherited_funs(g);

    for(var i in g.abstract.cats) {
	var cat=g.abstract.cats[i]
	var row=[td([kw("cat"),draw_ecat(g,i,dc)])] // modifies dc
	for(var ci in g.concretes) {
	    var conc=g.concretes[ci]
	    row.push(td(text(cat_lincat(conc,cat))))
	}
	t.appendChild(tr(row))
    }
    function openr(f) { return function() { g.row=f; open_row(g) } }
    for(var i in g.abstract.funs) {
	var fun=g.abstract.funs[i]
	var e=draw_efun(g,i,dc,df,openr(fun.name)) // modifies df
	var row=[td(e)]
	for(var ci in g.concretes) {
	    var conc=g.concretes[ci]
	    var lin=fun_lin(conc,fun.name)
	    var dl=lin ? simple_draw_lin(lin) : text(" ")
	    row.push(td(dl))
	}
	t.appendChild(tr(row))
    }
    return div_class("extensible",[t,more(add_fun(g),"Add a new function")])
}

function simple_draw_lin(f) {
    var l=[]
    if(f.args.length>0) {
	l.push(sep("\\")) /* λ */
	for(var i in f.args) {
	    l.push(text(" "));
	    l.push(ident(f.args[i]));
	}
	l.push(sep(" → "));
    }
    l.push(text_ne(f.lin));
    return wrap("span",l);
}

function draw_row(g) {
    var ix=null,fname=g.row
    if(fname) ix=fun_index(g,fname)
    if(ix==null) ix=0,fname=g.abstract.funs[0] && g.abstract.funs[0].name
    if(!fname) return text("No functions in the grammar")

    var igs=inherited_grammars(g)
    var dc=defined_cats(g);
    var df=inherited_funs(g);

    var t=empty_class("table","matrixview")

    var e=draw_efun(g,ix,dc,df) // modifies df
    t.appendChild(tr([th(abs_tab_button(g)),td(kw("fun")),td(e)]))

    var fun=g.abstract.funs[ix]

    var missing=[]
    for(var ci in g.concretes) 
	if(!fun_lin(g.concretes[ci],fname))
	    missing.push(ci)

    function copy_button(langcode,lin) {
	function copy() {
	    for(var i in missing) {
		var ci=missing[i]
		var conc=g.concretes[ci]
		// This is not functional programming, so copy the lin first...
		var lin2=JSON.parse(JSON.stringify(lin))
		conc.lins.push(lin2)
		timestamp(conc);
	    }
	    reload_grammar(g)
	}
	var b=button("Copy",copy)
	b.title="Copy lin "+fname+" from "+concname(langcode)
	         +" to languages that lack lin "+fname
	return b
    }

    for(var ci in g.concretes) {
	var conc=g.concretes[ci]
	var lin=fun_lin(conc,fname)
	var cp= lin && missing.length>0 ? [copy_button(conc.langcode,lin)] : []
	var dl=draw_elin(g,igs,ci,lin || lin_template(g,fname),dc,df)
	t.appendChild(tr([th(conc_tab_button(g,ci,true)),
			  td(kw("lin")),td(dl),td(cp)]))
    }
    var fbar=wrap_class("table","tabs",tr([gap(),tab(true,kw(fname)),gap()]))
    return [fbar,div_id("file",[t])]
}

/* -------------------------------------------------------------------------- */

function defined_cats(g) { return all_defined_cats(g,inherited_grammars(g)) }
function defined_funs(g) { return all_defined_funs(g,inherited_gramamrs(g)) }
function inherited_cats(g) {
    return all_inherited_cats(inherited_grammars(g),predefined_cats())
}
function inherited_funs(g) {return all_inherited_funs(inherited_grammars(g),{})}

function upload(g,cont) {
    var gs=inherited_grammars(g);
    gs.push(g);
    upload_grammars(gs,cont);
}

// inherited_grammars :: Grammar -> [Grammar]
function inherited_grammars(g) {
    var visited={};
    function exists(ix) { return ix!=null; }
    function ihgs(g) {
	if(visited[g.basename]) return []; // avoid cycles and diamonds
	else {
	    visited[g.basename]=true;
	    var igs=g.uextends.map(my_grammar).filter(exists).map(get_grammar);
	    var igss=igs.map(ihgs)
	    for(var i in igss) igs=igs.concat(igss[i]);
	    return igs;
	}
    }
    return ihgs(g)
}

/*
// cached_grammar__byname :: () -> (ModId->Grammar)
function cached_grammar_byname() {
    var gix=cached_grammar_array_byname()
    function grammar_byname(name) { return gix[name]; }
    return grammar_byname;
}

// cached_grammar_array_byname :: () -> {ModId=>Grammar}
function cached_grammar_array_byname() {
    var gix={};
    for(var i=0;i<local.count;i++) {
	var g=get_grammar(i,null);
	if(g) gix[g.basename]=g; // basenames are not necessarily unique!!
    }
    return gix
}
*/

/* -------------------------------------------------------------------------- */

function find_langcode(concs,langcode) {
    for(var ci in concs)
	if(concs[ci].langcode==langcode)
	    return concs[ci];
    return null;
}

function cleanup_deleted(files) {
    var keep={}
    for(var i in files) keep[files[i]]=true;
    //debug("cleanup_deleted "+JSON.stringify(files))
    //debug("keep "+JSON.stringify(keep))
    for(var i=0;i<local.count;i++) {
	var g=local.get(i,null)
	if(g && g.unique_name && !keep[g.unique_name+".json"]) {
	    debug("cleanup "+i+" "+g.unique_name);
	    remove_local_grammar(i)
	}
    }
}

function merge_grammar(i,newg) {
    var oldg=get_grammar(i);
    var keep="";
    debug("Merging at "+i);
    if(oldg) {
	oldg.basename=newg.basename;
	if(newg.abstract.timestamp<oldg.abstract.timestamp) {
	    newg.abstract=newg.abstract
	    keep+=" "+oldg.basename
	}
	for(var ci in newg.concretes) {
	    var conc=newg.concretes[ci];
	    var oldconc=find_langcode(oldg.concretes,conc.langcode);
	    if(oldconc && conc.timestamp<oldconc.timestamp) {
		newg.concretes[ci]=oldconc;
		keep+=" "+oldg.basename+conc.langcode;
	    }
	}
    }
    put_grammar(i,newg)
    return keep;
}

function timestamp(obj,prop) {
    obj[prop || "timestamp"]=Date.now();
}

function draw_timestamp(obj) {
    var t=obj.timestamp;
    return node("small",{"class":"modtime"},
		[text(t ? " -- "+new Date(t).toLocaleString() : "")]);
}

/* -------------------------------------------------------------------------- */

function delete_ix(old,ix) {
    var a=[];
    for(var i in old) if(i!=ix) a.push(old[i]);
    return a;
}

function sort_list(list,olditems,key) {
    var items=[];
    function find(fun) {
	for(var i=0;i<olditems.length;i++)
	    if(olditems[i][key]==fun) return olditems[i];
	return null;
    }
    for(var el=list.firstChild;el;el=el.nextSibling) {
	var name=el.getAttribute("ident")
	if(name) {
	    var old=find(name);
	    if(old) items.push(old)
	    else debug("Bug: did not find "+name+" while sorting");
	}
    }
    if(items.length==olditems.length)
	return items;
    else {
	debug("Bug: length changed while sorting")
	return olditems;
    }
}

function text_editor(el,init,ok,async) {
    string_editor(el,init,ok,async,true)
}

function string_editor(el,init,ok,async,multiline) {
    var p=el.parentNode;
    function restore() {
	e.parentNode.removeChild(e);
	el.style.display="";
    }
    function done() {
	var edited=e.it.value;
	restore();
	function cont(msg) { if(msg) start(msg); }
	if(async) ok(edited,cont)
	else cont(ok(edited));
	return false;
    }
    function start(msg) {
	el.style.display="none";
	m.innerHTML=msg;
	insertAfter(e,el);
	e.it.focus();
    }
    var m=empty_class("span","error_message");
    if(multiline || init.indexOf("\n")>=0) {
	var rows=init.split("\n").length+1
	var i=node("textarea",{"class":"string_edit",name:"it",
			       rows:rows,cols:"60"},
		   [text(init)]);
    }
    else {
	var i=node("input",{"class":"string_edit",name:"it",value:init},[]);
	if(init.length>10) i.size=init.length+5;
    }
    var e=node("form",{},
	       [i,
		text(" "),
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

function kw(txt,hint) {
    var w=wrap_class("span","kw",text(txt));
    if(hint) w.title=hint;
    return w;
}
function sep(txt) { return wrap_class("span","sep",text(txt)); }
function ident(txt) { return wrap_class("span","ident",text(txt)); }
function unimportant(txt) { return wrap_class("small","unimportant",text(txt)); }
function indent(cs) { return div_class("indent",cs); }

function indent_sortable(cs,sort) {
    var n= indent(cs);
    n.onsort=sort;
    return n;
}

function node_sortable(cls,name,ls) {
    return node("div",{"class":cls,"ident":name},ls);
}

function extensible(cs) { return div_class("extensible",cs); }

function more(action,hint,label) {
    var b=node("span",{"class":"more","title":hint || "Add more"},
	       [text(label || " + ")]);
    b.onclick=function() { action(b); }
    return b;
}

function text_ne(s) { // like text(s), but force it to be non-empty
    return text(s ? s : "\xa0\xa0\xa0")
}

function editable(tag,cs,g,edit,hint) {
    var b=edit_button(function(){edit(g,e)},hint);
    var e=node(tag,{"class":"editable"},[cs,b]);
    //e.onclick=b.onclick;
    return e;
}

function edit_button(action,hint) {
    var b=node("span",{"class":"edit","title":hint || "Edit"},[text("%")]);
    b.onclick=action;
    return b;
}

function deletable(del,el,hint) {
    var b=delete_button(del,hint)
    return node("span",{"class":"deletable"},[b,el])
}

function delete_button(action,hint) {
    var b=node("span",{"class":"delete",title:hint || "Delete"},[text("×")])
    b.onclick=action;
    return b;
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
/* --- DOM Support ---------------------------------------------------------- */

function a(url,linked) { return node("a",{href:url},linked); }
function ul(lis) { return wrap("ul",lis); }
function table(rows) { return wrap("table",rows); }
function td_right(cs) { return node("td",{"class":"right"},cs); }
function td_center(cs) { return node("td",{"class":"center"},cs); }
function jsurl(js) { return "javascript:"+js; }

/* -------------------------------------------------------------------------- */

function download_from_cloud() {
    var newdir="/tmp/"+location.hash.substr(1)

    function download2(olddir) {
	//debug("Starting grammar sharing in the cloud")
	if(newdir!=olddir) link_directories(newdir,download3)
	else download4()
    }
    function download3() {
	//debug("Uploading local grammars to cloud");
	local.put("dir",newdir);
	upload_json(download4)
    }
    function download4() {
	//debug("Downloading grammars from the cloud");
	download_json()
    }

    with_dir(download2)
}

/* --- Initialization ------------------------------------------------------- */

//document.body.appendChild(empty_id("div","debug"));

function fix_extends(g) {
    //console.log("fix_extends ",g)
    if(g) {
	g.extends=g.extends || []
	var es=[],us=[]
	if(g.uextends) {
	    // update inherited grammars (they might be renamed or removed)
	    for(var i in g.uextends) {
		var u=g.uextends[i]
		var gix=my_grammar(u)
		if(gix!=null) {
		    us.push(u)
		    es.push(grammarlist[gix].basename)
		}
	    }
	}
	else {
	    // add g.uextends to grammars created before 2012-10-16
	    for(var i in g.extends) {
		var e=g.extends[i]
		var gix=find_grammar(e)
		var u
		if(gix!=null) u=grammarlist[gix].unique_name
		if(u) { es.push(e); us.push(u); }
	    }
	}
	g.extends=es
	g.uextends=us
    }
    return g
}

function dir_bugfix() {
    // remove trailing newline caused by bug in older version
    var dir=local.get("dir");
    if(dir) {
	var n=dir.length;
	while(dir[dir.length-1]=="\n" || dir[dir.length-1]=="\r")
	    dir=dir.substr(0,dir.length-1)
	if(dir.length<n) {
	    debug("removing trailing newline")
	    local.put("dir",dir);
	}
	//debug("Server directory: "+JSON.stringify(dir))
    }
    else debug("No server directory yet")
}

function get_grammarlist() {
    var list=local.get(".grammarlist")
    if(list) grammarlist=list
    else if(local.get("count")!=null) {
	console.log("initializing grammarlist")
	grammarlist={}
	var n=local.count;
	for(var ix=0;ix<n;ix++) {
	    var g=local.get(ix,null);
	    if(g)
		grammarlist[ix]={unique_name:g.unique_name,basename:g.basename}
	}
	local.put(".grammarlist",grammarlist)
    }
}

if(editor) {
    if(supports_html5_storage()) {
	get_grammarlist();
	initial_view();
	touch_edit();
	dir_bugfix();
	initialize_sorting(["DIV","INPUT","TEXTAREA"],
			   ["fun","lin","lincat","oper"]);
    }
    else
	editor.innerHTML="<p>This browser does not appear to support localStorage, and the grammar editor does not work without it. Sorry!"
}

//console.log("hi")
