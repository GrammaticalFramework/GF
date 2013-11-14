
var example_based=[];

/*
--            cat  lincat  fun  lin       fun  cat    cat
environ :: ([(CId, CId)],[(CId, Expr)],[((CId, CId), [CId])]) -> Environ
*/
function exb_state(g,ci) {
    var conc=g.concretes[ci]
    function show_list(show1,xs) {
	return "["+map(show1,xs).join(",")+"]";
    }
    function show_fun(fun) {
	var t=fun.type
	var res=t[t.length-1]
	var args=t.slice(0,length-1);
	return "(("+fun.name+","+res+"),["+args.join(",")+"])"
    }
    function show_lincat(lincat) {
	return "("+lincat.cat+","+lincat.type+")"
    }
    function show_lin(lin) {
	return "("+lin.fun+","+(lin.eb_lin||"?")+")"
    }
    function show_funs(funs) { return show_list(show_fun,funs) }
    function show_lincats(lincats) { return show_list(show_lincat,lincats); }
    function show_lins(lins) { return show_list(show_lin,lins) }
    return "("+show_lincats(conc.lincats)
	+","+show_lins(conc.lins)
	+","+show_funs(g.abstract.funs)+")"
}

function exb_call(g,ci,command,args,cont) {
    var url=window.exb_url || "exb/exb.fcgi";
    var q=encodeArgs(args);
    var cmd="?command="+command+"&state="+encodeURIComponent(exb_state(g,ci))+q;
    http_get_json(url+cmd,cont)
}

function ask_possibilities(g,ci) {
    var conc=g.concretes[ci];

    function show_poss(poss) {
	//debug("possibilities: "+JSON.stringify(poss))
	var exready={}
	for(var i in poss[0]) exready[poss[0][i]]=true;
	var testable={}
	for(var i in poss[1]) testable[poss[1][i]]=true;
	example_based[ci]={exready:exready,testable:testable}
	conc.example_based=true;
	if(!conc.example_lang) conc.example_lang=g.concretes[0].langcode;
	reload_grammar(g);
    }
    var exci=conc_index(g,conc.example_lang);
    if(!conc.example_lang || !exci)
	conc.example_lang=g.concretes[ci==0 ? 1 : 0].langcode;
    var exci=conc_index(g,conc.example_lang);
    exb_call(g,ci,"possibilities",{example_state:exb_state(g,exci)},show_poss)
}

var parser = { Eng: "ParseEngAbs.pgf",
	       Swe: "ParseSwe.pgf"
	     }

function exb_extra(g,ci) {
    var conc=g.concretes[ci];
    function stop_exb() {
	conc.example_based=false;
	reload_grammar(g);
    }

    function exblangmenu() {
	function opt(conc) {
	    return option(concname(conc.langcode),conc.langcode);
	}
	function skip_target(c) { return c.langcode!=conc.langcode; }
	var m =node("select",{},map(opt,filter(skip_target,g.concretes)));
	if(conc.example_lang) m.value=conc.example_lang;
	m.onchange=function() { conc.example_lang=m.value; save_grammar(g); }
	return m
    }

    function ask_poss() { ask_possibilities(g,ci) }

    if(navigator.onLine && g.concretes.length>1 && conc.example_based && !example_based[ci]) ask_poss();
    var sb=button("Start",ask_poss)
    if(parser[conc.langcode] && g.concretes.length>1)
	return indent([wrap("small",text("Example-based editing: ")),
		       conc.example_based
		         ? node("span",{},
				[button("Stop",stop_exb),
				 wrap("small",text(" Example language: ")),
				 exblangmenu()
				])
		         : sb])
    else {
	sb.disabled=true;
	var why= g.concretes.length>1
	    ? " ("+concname(conc.langcode)+" is not supported yet)"
	    : " (Add another language to take examples from first.)"
	return indent([unimportant("Example-based editing: "), sb,
	          unimportant(why)])
    }
}

function fun_lincat(g,conc,fun) {
    var t=function_type(g,fun);
    var abscat=t[t.length-1]
    return cat_lincat(conc,abscat)
}

function exb_linbuttons(g,ci,f) {
    var conc=g.concretes[ci];
    var fun=f.fun;
    var eb=example_based[ci];
    var exb_output;
    function fill_example(maybetree) {
	var tree=maybetree.Just
	if(tree) {
	    if(f.template)
		conc.lins.push({fun:f.fun,args:f.args,
				lin:tree[0],eb_lin:tree[1]});
	    else {
		f.lin=tree[0];
		f.eb_lin=tree[1];
	    }
	    ask_possibilities(g,ci)
	}
	else exb_output.innerHTML="Bug: no tree found"
    }
    function show_example(example){
	exb_output.innerHTML="";
	var s=prompt(example[1]);
	if(s) {
	    var cat=fun_lincat(g,conc,fun)
	    exb_output.innerHTML="...";
	    //server.parse({from:"ParseEng",cat:cat,input:s},fill_example)
	    exb_call(g,ci,"abstract_example",
		     {cat:cat,input:s,
		      parser:parser[conc.langcode],
		      params:"["+f.args.join(",")+"]",
		      "abstract":example[0]},
		     fill_example)
	}
    }
    function by_example() {
	var dir=local.get("dir")
	if(dir) {
	    if(exb_output) {
		exb_output.innerHTML="...";
		exb_call(g,ci,"provide_example",
			 {lang:g.basename+conc.example_lang,
			  parser:parser[conc.langcode],
			  fun:fun,
			  grammar:dir+"/"+g.basename+".pgf"},
			 show_example)
	    }
	}
	else exb_output.innerHTML="Compile the grammar first!"
    }
    function show_test(txt) {
	exb_output.innerHTML="";
	exb_output.appendChild(text(txt))
    }
    function test_it(b) {
	if(exb_output) {
	    exb_output.innerHTML="...";
	    exb_call(g,ci,"test_function",
		     {fun:fun,parser:parser[conc.langcode]},
		     show_test)
	}
    }
    var buttons=[];
    if(conc.example_based && eb) {
	if(f.template) {
	    var byex=button("By example",by_example);
	    if(!(eb.exready[fun] && fun_lincat(g,conc,fun)))
		byex.disabled=true
	    buttons.push(byex)
	}
	else {
	    var b=button("Test it",test_it);
	    if(!eb.testable[fun] || !f.eb_lin) b.disabled=true;
	    buttons.push(b)
	}
	var exb_output=node("span",{"class":"exb_output"},[]);
	buttons.push(exb_output)
    }
    return node("span",{"class":"exb_linbuttons"},buttons)
}
