
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
	conc.example_lang=g.concretes[0].langcode;
	reload_grammar(g);
    }
    
    exb_call(g,ci,"possibilities",{},show_poss)
}

function exb_extra(g,ci) {
    var conc=g.concretes[ci];
    function stop_exb() {
	conc.example_based=false;
	reload_grammar(g);
    }

    function exblangmenu() {
	function opt(conc) { return option(conc.langcode,conc.langcode); }
	// skip target language
	var m =node("select",{},map(opt,g.concretes));
	m.onchange=function() { conc.example_lang=m.value }
	return m
    }

    function ask_poss() { ask_possibilities(g,ci) }

    if(navigator.onLine && conc.example_based && !example_based[ci]) ask_poss();
    return conc.langcode=="Eng"
	? indent([text("Example based editing: "),
		  conc.example_based
		  ? node("span",{},[button("Stop",stop_exb),
				    text(" Example language: "),
				    exblangmenu()
				   ])
		  : button("Start",ask_poss)])
	: text("")
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
	    var t=function_type(g,fun);
	    var abscat=t[t.length-1]
	    var cat=cat_lincat(conc,abscat)
	    exb_output.innerHTML="...";
	    //server.parse({from:"ParseEng",cat:cat,input:s},fill_example)
	    exb_call(g,ci,"abstract_example",
		     {cat:cat,input:s,
		      params:"["+f.args.join(",")+"]",
		      abstract:example[0]},
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
	    exb_call(g,ci,"test_function",{fun:fun},show_test)
	}
    }
    var buttons=[];
    if(conc.example_based && eb) {
	if(eb.exready[fun])
	    buttons.push(button("By example",by_example))
	if(eb.testable[fun] && f.eb_lin) {
	    var b=button("Test it",test_it);
	    buttons.push(b)
	}
	var exb_output=node("span",{"class":"exb_output"},[]);
	buttons.push(exb_output)
    }
    return buttons
}
