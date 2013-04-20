/* Abstract syntax for a small subset of GF grammars in JavaScript */

/*
type UniqueId = String --persistent unique grammar identifier used by the editor
type Id   = String -- all sorts of identifiers in grammars
type ModId = Id -- module name
type Cat  = Id -- category name
type FunId = Id -- function name
type Type = [Cat] -- [Cat_1,...,Cat_n] means Cat_1 -> ... -> Cat_n

type Grammar  = { basename: ModId,
                  comment: String,
                  extends: [ModId], -- in 1-to-1 correspondence with uextends
		  uextends: [UniqueId], -- added 2012-10-16
                  abstract: Abstract,
                  concretes: [Concrete] }

type Abstract = { startcat: Cat, cats: [Cat], funs: [Fun] }
type Fun      = { name: FunId, type: Type }

type Concrete = { langcode: Id,
                  opens: [ModId],
		  params: [{name: Id, rhs: String}],
		  lincats : [{ cat: Cat, type: Term}],
		  opers: [{name: Lhs, rhs: Term}],
		  lins: [Lin]
		}
type Lin = {fun: FunId, args: [Id], lin: Term}

type Lhs = String -- name and type of oper,
                  -- e.g "regN : Str -> { s:Str,g:Gender} ="
type Term = String -- arbitrary GF term (not parsed by the editor)
type LinType = [Term]
*/

// locally_defined_cats :: Grammar -> {Cat=>ModId} -> {Cat=>ModId} // destr upd
function locally_defined_cats(g,dc) {
    with(g.abstract)
	for(var i in cats) dc[cats[i]]=g.basename;
    return dc;
}

// predefined_cats :: () -> {Cat=>ModId}
function predefined_cats() {
    var pd = "Predef"
    return { "Int":pd, "Float":pd, "String":pd}
}

// all_defined_cats :: Grammar -> [Grammar] -> {Cat=>ModId}
function all_defined_cats(g,igs) {
    return all_inherited_cats(igs,locally_defined_cats(g,predefined_cats()))
}
// all_inherited_cats :: [Grammar] -> {Cat=>ModId} -> {Cat=>ModId} // destr upd
function all_inherited_cats(igs,dc) {
    for(var i in igs) dc=locally_defined_cats(igs[i],dc)
    return dc;
}

// locally_defined_funs :: [Grammar] -> {FunId=>ModId} -> {Id=>ModId} // destr upd
function locally_defined_funs(g,df) {
    with(g.abstract)
	for(var i in funs) df[funs[i].name]=g.basename;
    return df;
}

// all_defined_funs :: Grammar -> [Grammar] -> {FunId=>ModId}
function all_defined_funs(g,igs) {
    return all_inherited_funs(igs,locally_defined_funs(g,{}))
}
// all_inherited_funs :: [Grammar] -> {FunId=>ModId} -> {FunId=>ModId} // destr upd
function all_inherited_funs(igs,df) {
    for(var i in igs) df=locally_defined_funs(igs[i],df)
    return df;
}

// Return the index of the function the given name in the abstract syntax
// fun_index :: Grammar -> FunId -> (Int|null)
function fun_index(g,fun) {
    with(g.abstract)
	for(var i in funs) if(funs[i].name==fun) return i
    return null;
}

// Return the type of a named function in the abstract syntax
// function_type :: Grammar -> FunId -> (Type|null)
function function_type(g,fun) {
    var ix=fun_index(g,fun)
    return ix==null ? null : g.abstract.funs[ix].type
}

// Return the lincat defined in a given concrete syntax for an abstract category
// cat_lincat :: Concrete -> Cat -> (Term|null)
function cat_lincat(conc,cat) {
    with(conc)
	for(var i in lincats) if(lincats[i].cat==cat) return lincats[i].type
    return null;
}

// Return the index of the lin in a given concrete syntax for an abstract function
// lin_index :: Concrete -> FunId -> (Int|null)
function lin_index(conc,fun) {
    with(conc) for(var i in lins) if(lins[i].fun==fun) return i
    return null;
}

// Return the lin defined in a given concrete syntax for an abstract function
// fun_lin :: Concrete -> FunId -> (Lin|null)
function fun_lin(conc,fun) {
    var i=lin_index(conc,fun)
    if(i!=null) return conc.lins[i]
    return null;
}

// Return the index of the concrete syntax with a given langcode
// conc_index :: Grammar -> Id -> (Int|null)
function conc_index(g,langcode) {
    var c=g.concretes;
    for(var ix=0;ix<c.length;ix++)
	if(c[ix].langcode==langcode) return ix
    return null;
}

// rename_category :: Grammar -> Cat -> Cat -> Grammar  // destructive update
function rename_category(g,oldcat,newcat) {
    function rename_cats(cats) {
	for(var i in cats) if(cats[i]==oldcat) cats[i]=newcat;
    }
    function rename_type(t) {
	for(var i in t) if(t[i]==oldcat) t[i]=newcat;
    }
    function rename_funs(funs) {
	for(var i in funs) rename_type(funs[i].type)
    }
    function rename_abstract(a) {
	rename_cats(a.cats);
	rename_funs(a.funs);
    }
    function rename_lincat(lc) {
	if(lc.cat==oldcat) lc.cat=newcat;
    }
    function rename_concrete(c) {
	for(var i in c.lincats) rename_lincat(c.lincats[i]);
    }
    function rename_concretes(cs) {
	for(var i in cs) rename_concrete(cs[i]);
    }
    rename_abstract(g.abstract)
    rename_concretes(g.concretes);
    return g;
}

// rename_function :: Grammar -> FunId -> FunId -> Grammar // destructive update
function rename_function(g,oldfun,newfun) {
    function rename_concrete(c) {
	var i=lin_index(c,oldfun)
	if(i!=null) c.lins[i].fun=newfun;
    }
    for(var i in g.concretes) rename_concrete(g.concretes[i]);
    return g;
}

// change_lin_lhs :: Grammar -> Fun -> Grammar // destructive update
function change_lin_lhs(g,fun) {
    function change_concrete(c) {
	var i=lin_index(c,fun.name)
	if(i!=null) c.lins[i].args=arg_names(fun.type);
    }
    for(var i in g.concretes) change_concrete(g.concretes[i]);
    return g;
}

/* --- Parsing -------------------------------------------------------------- */

// GF idenfifier syntax:
var lex_id=/^[A-Za-z][A-Za-z0-9_']*$/
// See https://developer.mozilla.org/en/JavaScript/Guide/Regular_Expressions

function check_id(s) { return lex_id.test(s); }

function check_name(s,kind) {
    return check_id(s)
	? null
	: s+"? "+kind+" names must start with a letter and can contain letters, digits, _ and '"
}

// parse_fun :: String -> {error:String} + {ok:Fun}
function parse_fun(s) {
    var ws=s.split(/\s+/);
    var fun={name:"",type:[]};
    /* Use a state machine to parse function definitions */
    /* f : T1 -> ... -> Tn */
    var state="name";
    var ok=true;
    for(var i=0;ok && i<ws.length;i++) {
	if(ws[i]!="") {
	    switch(state) {
	    case "name": fun.name=ws[i]; state=":"; break;
	    case ":": ok=ws[i]==":"; state="type"; break;
	    case "type": fun.type.push(ws[i]); state="->"; break;
	    case "->": ok=ws[i]=="->"; state="type"; break;
	    }
	}
    }
    var err=check_name(fun.name,"Function");
    if(err) return {error: err};
    return ok && state=="->"
           ? {ok:fun}
           : { error : "Fun : Cat<sub>1</sub>  -> ...  -> Cat<sub>n</sub>" }
}


// parse_param :: String -> {error:String} + { ok:{name:Id,rhs:String} }
function parse_param(s) {
    var ws=s.split("=");
    if(ws.length==2) {
	var name=ws[0].trim();
	var err=check_name(name,"Parameter type");
	return err ? { error:err } : { ok: { name:name,rhs:ws[1].trim() } }
    }
    else
	return { error: "P = C1 | ... | Cn" }
}

// parse_oper :: String -> {error:String} + {ok:{name:Lhs, rhs:Term}}
function parse_oper(s) {
    var i=s.indexOf(" ");
    var operr = { error: "op = expr" }
    if(i>0 && i<s.length-1) {
	var name=s.substr(0,i).trim();
	var rhs=s.substr(i).trim();
	var err=check_name(name,"Operator");
	return err 
	    ? {error:err}
	    : rhs!="" ? {ok: {name:name, rhs:rhs}} 
	              : operr
    }
    else return operr
    
}

/* --- Print as plain text (normal GF source syntax) ------------------------ */

// show_type :: Type -> String
function show_type(t) {
    var s="";
    for(var i in t) {
	if(i>0) s+=" -> ";
	s+=t[i];
    }
    return s;
}

// show_lintype :: LinType -> String
function show_lintype(t) {
    var s="";
    for(var i in t) {
	if(i>0) s+=" -> ";
	s+= check_id(t[i]) ? t[i] : "("+t[i]+")";
    }
    return s;
}

// show_fun :: Fun -> String
function show_fun(fun) {
    return fun.name+" : "+show_type(fun.type);
}

// show_grammar :: Grammar -> String
function show_grammar(g) {
    return show_abstract(g)+"\n"+show_concretes(g)
}

function show_abstract(g) {
//  var startcat= g.abstract.cats.length==1 ? g.abstract.cats[0] : g.abstract.startcat;
    var startcat= g.abstract.startcat || g.abstract.cats[0];
    return "abstract "+g.basename+" = "
        +show_extends(g.extends)
        +"{\n\n"
	+"flags coding = utf8 ;\n\n"
	+show_startcat(startcat)
        +show_cats(g.abstract.cats)
        +show_funs(g.abstract.funs)
	+"}\n";
}

function show_extends(exts) {
    return exts && exts.length>0 ? exts.join(", ")+" ** " : "";
}

function show_startcat(startcat) {
    return startcat && startcat!="-"
	? "flags startcat = "+startcat+";\n\n"
	: "";
}

function show_cats(cats) {
    return cats.length>0 ? "cat\n   "+cats.join("; ")+";\n\n" : "";
}

function show_funs(funs) { return show_list("fun",show_fun,funs); }

function show_concretes(g) {
    return map(show_concrete(g),g.concretes).join("\n\n");
}

function conc_extends(conc) { return function(m) { return m+conc.langcode; }}

function show_concrete(g) {
    return function(conc) {
	return "" // "--# -path=.:present\n"
            + "concrete "+g.basename+conc.langcode+" of "+g.basename+" = "
	    +show_extends((g.extends || []).map(conc_extends(conc)))
            +show_opens(conc.opens)
	    +"{\n\nflags coding = utf8 ;\n\n"
	    +show_lincats(conc.lincats)
	    +show_lins(conc.lins)
	    +show_params(conc.params)
	    +show_opers(conc.opers)
	    +"}\n"
    }
}

function show_list(kw,show1,list) {
    return list.length>0 
	? kw+"\n    "+map(show1,list).join(";\n    ")+";\n\n"
	: ""
}

function show_opens(opens) {
    return opens && opens.length>0 ? "\n\nopen "+opens.join(", ")+" in " : ""
}

function show_params(params) { return show_list("param",show_param,params); }
function show_lincats(lincats) { return show_list("lincat",show_lincat,lincats); }
function show_opers(opers) { return show_list("oper",show_oper,opers); }
function show_lins(lins) { return show_list("lin",show_lin,lins); }


function show_param(p) { return p.name + " = " + p.rhs; }
function show_oper(p) { return p.name + " " + p.rhs; }
function show_lincat(p) { return p.cat + " = " + p.type; }

function show_lin(lin) {
    return lin.fun + " " + lin.args.join(" ")+ " = " + lin.lin;
}