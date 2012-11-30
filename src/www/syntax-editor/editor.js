/* --- Main Editor object --------------------------------------------------- */
function Editor(gm,opts) {
    var t = this;
    /* --- Configuration ---------------------------------------------------- */

    // default values for options:
    this.options={
	target: "editor",
        initial: {
            grammar: null,
            startcat: null,
            languages: null,
            abstr: null,
            node_id: null
        },
        show: {
            grammar_menu: true,
            startcat_menu: true,
            to_menu: true,
            random_button: true
        }
    }

    // Apply supplied options
    if(opts) for(var o in opts) this.options[o]=opts[o];

    /* --- Creating UI components ------------------------------------------- */
    this.container = document.getElementById(this.options.target);
    this.container.classList.add("editor");
    this.ui = {
        menubar: div_class("menu"),
        tree: div_id("tree"),
        refinements: div_id("refinements"),
        lin: div_id("linearisations")
    };
    appendChildren(this.container, [
        this.ui.menubar,
        this.ui.tree,
        this.ui.refinements,
        this.ui.lin
    ]);

    /* --- Client state initialisation -------------------------------------- */
    this.gm = gm;
    this.server = gm.server;
    this.ast = null;

    /* --- Register Grammar Manager hooks ----------------------------------- */
    this.hook_change_grammar = function(grammar){
        debug("Editor: change grammar");
        var args = {
            format: "json"
        };
        var cont = function(data){
            t.grammar_constructors = data;
            t.start_fresh();
        };
        t.server.browse(args, cont);
    };
    this.hook_change_startcat = function(startcat){
        debug("Editor: change startcat");
        t.startcat = startcat;
        t.start_fresh();
    };
    this.hook_change_languages = function(languages){
        debug("Editor: change languages");
        t.update_linearisation();
    };
    this.gm.register_action("change_grammar",this.hook_change_grammar);
    this.gm.register_action("change_startcat",this.hook_change_startcat);
    this.gm.register_action("change_languages",this.hook_change_languages);

    /* --- Main program, this gets things going ----------------------------- */
    this.menu = new EditorMenu(this, this.options);

    /* --- Other basic stuff ------------------------------------------------ */
    this.shutdown = function() {
        t.gm.unregister_action("change_grammar",t.hook_change_grammar);
        t.gm.unregister_action("change_startcat",t.hook_change_startcat);
        t.gm.unregister_action("change_languages",t.hook_change_languages);
        clear(t.container);
        t.container.classList.remove("editor");
    }
    this.hide = function() {
        t.container.style.display="none";
    }
    this.show = function() {
        t.container.style.display="block";
    }

}

/* --- API for getting and setting state ------------------------------------ */

Editor.prototype.get_ast=function() {
    return this.ast.toString();
}

Editor.prototype.get_startcat=function() {
    return this.gm.startcat;
}

Editor.prototype.initialize_from=function(opts) {
    var t=this;
    if (opts.abstr)
        t.import_ast(opts.abstr);
}

// Called after changing grammar or startcat
Editor.prototype.start_fresh=function () {
    var t = this;
    t.ast = new AST(null, t.get_startcat());
    if (t.options.initial.abstr) {
        t.import_ast(t.options.initial.abstr);
    }
    t.update_current_node();
    clear(t.ui.lin);
}

/* --- Functions for handling tree manipulation ----------------------------- */

// Show refinements for given cat (usually that of current node)
Editor.prototype.get_refinements=function(cat) {
    var t = this;
    t.ui.refinements.innerHTML = "...";
    if (cat == undefined)
        cat = t.ast.getCat();
    var args = {
        id: cat,
        format: "json"
    };
    var cont = function(data){
        clear(t.ui.refinements);
        for (pi in data.producers) {
            var fun = data.producers[pi];
            var opt = span_class("refinement", text(fun));
            opt.onclick = bind(function(){
                t.select_refinement(this.innerHTML)
            }, opt);

            // If refinement would be destructive, disable it
            var blank = t.ast.is_writable();
            var def = t.grammar_constructors.funs[fun].def;
            var typeobj = AST.parse_type_signature(def);
            var inplace = t.ast.fits_in_place(typeobj);
            if (!blank && !inplace) {
                opt.classList.add("disabled");
            }

            t.ui.refinements.appendChild(opt);
        }
    };
    var err = function(data){
        clear(t.ui.refinements);
        alert("Error");
    };
    t.server.browse(args, cont, err);
}

// Editor.prototype.select_refinement=function(fun) {
//     var t = this;
//     t.ui.refinements.innerHTML = "...";
//     t.ast.removeChildren();
//     t.ast.setFun(fun);
//     var args = {
//         id: fun,
//         format: "json"
//     };
//     var err = function(data){
//         alert("Error");
//     };
//     t.server.browse(args, bind(t.complete_refinement,this), err);
// }

// Editor.prototype.complete_refinement=function(data) {
//     if (!data) return;

//     with (this) {
//         // Parse out function arguments
//         var def = data.def;
//         def = def.substr(def.lastIndexOf(":")+1);
//         var fun_args = map(function(s){return s.trim()}, def.split("->"))
//         fun_args = fun_args.slice(0,-1);

//         if (fun_args.length > 0) {
//             // Add placeholders
//             for (ci in fun_args) {
//                 ast.add(null, fun_args[ci]);
//             }
//         }
        
//         // Update ui
//         redraw_tree();
//         update_linearisation();

//         // Select next hole & get its refinements
//         ast.toNextHole();
//         update_current_node();
//     }
// }

// Select refinement now by default replaces "in-place"
// Case 1: current node is blank/no kids
// Case 2: kids have all same types, perform an in-place replacement
// Case 3: kids have diff types/number, prevent replacement (must clear first)
Editor.prototype.select_refinement=function(fun) {
    var t = this;
    
    // Check if current node is blank or childless (case 1)
    var blank = t.ast.is_writable();

    // Check if we can replace in-place (case 2)
    var def = t.grammar_constructors.funs[fun].def;
    var typeobj = AST.parse_type_signature(def);
    var inplace = !blank && t.ast.fits_in_place(typeobj);

    if (!blank && !inplace) {
        alert("use clear first if you want to replace the subtree");
        return;
    }

    t.ast.setFun(fun);

    if (blank) {
        t.ast.removeChildren();

        // Get new function arguments
        var def = t.grammar_constructors.funs[fun].def;
        var typeobj = AST.parse_type_signature(def);

        // Add dependent type placeholders
        if (typeobj.deps.length > 0) {
            alert("the syntax editor current doesn't support dependent types");
            // for (var i in typeobj.deps) {
            //     t.ast.addDep(typeobj.deps[i].id, typeobj.deps[i].type);
            // }
        }
        // Add function argument placeholders
        if (typeobj.args.length > 0) {
            for (var i in typeobj.args) {
                t.ast.add(null, typeobj.args[i]);
            }
        }
    }

    // Update ui
    t.redraw_tree();
    t.update_linearisation();

    // Select next hole & get its refinements
    t.ast.toNextHole();
    t.update_current_node();
}

Editor.prototype.update_current_node=function(newID) {
    with(this) {
        if (newID)
            ast.current = new NodeID(newID);
        redraw_tree();
        get_refinements();
    }
}

Editor.prototype.redraw_tree=function() {
    var t = this;
    var elem = node; // function from support.js
    function visit(container, id, node) {
        var container2 = empty_class("div", "node");
        var label =
            ((node.fun) ? node.fun : "?") + " : " +
            ((node.cat) ? node.cat : "?");
        var current = id.equals(t.ast.current);
        var element = elem("a", {class:(current?"current":"")}, [text(label)]);
        element.onclick = function() {
            t.update_current_node(id);
        }
        container2.appendChild( element );

        for (i in node.children) {
            var newid = new NodeID(id);
            newid.add(parseInt(i));
            visit(container2, newid, node.children[i]);
        }

        container.appendChild(container2);
    }
    with(this) {
        clear(ui.tree);
        visit(ui.tree, new NodeID(), ast.root);
    }
}

Editor.prototype.update_linearisation=function(){
    var t = this;
    function langpart(conc,abs) { // langpart("FoodsEng","Foods") == "Eng"
        return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
    }
    function row(lang, lin) {
        var langname = langpart(lang, t.gm.grammar.name);
        var btn = button(langname, function(){
            bind(t.options.lin_action,t)(lin,lang);
        });
        var c1 = th(btn);
        var c2 = td(text(lin));
        var row = tr([c1,c2]);
        return row;
    }
    var args = {
        tree: t.ast.toString()
    };
    t.server.linearize(args, function(data){
        clear(t.ui.lin);
	var tbody=empty("tbody");
        for (i in data) {
            var lang = data[i].to;
            if (t.gm.languages.length < 1 || elem(lang, t.gm.languages)) {
                tbody.appendChild(row(lang, data[i].text))
            }
        }
        t.ui.lin.appendChild(wrap("table",tbody));
    });
}

// Clear current node and all its children
Editor.prototype.clear_node = function() {
    var t = this;
    t.ast.removeChildren();
    t.ast.setFun(null);
    t.redraw_tree();
//    t.get_refinements();
}

// Generate random subtree from current node
Editor.prototype.generate_random = function() {
    var t = this;
    t.ast.removeChildren();
    var args = {
        cat: t.ast.getCat(),
        limit: 1
    };
    if (!args.cat) {
        alert("Missing category at current node");
        return;
    }
    var cont = function(data){
        var tree = data[0].tree;
        t.import_ast(tree);
    };
    var err = function(data){
        alert("Error");
    };
    server.get_random(args, cont, err);
}

// Import AST from string representation, setting at current node
Editor.prototype.import_ast = function(abstr) {
    var t = this;
    var args = {
        tree: abstr
    };
    var cont = function(tree){
        // Build tree of just fun, then populate with cats
        t.ast.setSubtree(tree);
        /// TODO: traverse only subtree, not everything!
        t.ast.traverse(function(node){
            if (!node.fun) return;
            var info = t.lookup_fun(node.fun);
            node.cat = info.cat;
        });
        t.redraw_tree();
        t.update_linearisation();
    };
    server.pgf_call("abstrjson", args, cont);
}

// Look up information for a function
Editor.prototype.lookup_fun = function(fun) {
    var t = this;
    var def = t.grammar_constructors.funs[fun].def;
    var typeobj = AST.parse_type_signature(def);
    return {
        cat: typeobj.ret
    }
}

