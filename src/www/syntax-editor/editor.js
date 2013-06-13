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

        tree_str: div_id("tree_str"),

        actionbar: div_id("actions"),
        clear_button: button("Clear", function(){
            t.clear_node();
        }),
        wrap_button: button("Wrap…", function(){
            t.wrap_candidates();
        }),
        unwrap_button: button("Unwrap", function(){
            t.unwrap();
        }),

        refinements: div_id("refinements"),

        lin: div_id("linearisations")
    };
    this.ui.clear_button.title = "Clear current node and all its children";
    this.ui.wrap_button.title = "Wrap the current node with a new function";
    this.ui.unwrap_button.title = "Replace parent of current node with current node (if possible)";

    appendChildren(this.container, [
        t.ui.menubar,
        t.ui.tree,
        t.ui.tree_str,
        t.ui.actionbar,
        t.ui.lin
    ]);
    appendChildren(this.ui.actionbar, [
        t.ui.clear_button,
        t.ui.wrap_button,
        t.ui.unwrap_button,
        t.ui.refinements
    ]);

    /* --- Client state initialisation -------------------------------------- */
    this.gm = gm;
    this.server = gm.server;
    this.ast = null;
    this.clear_on_change_startcat = true; // temp. false when wrapping

    /* --- Register Grammar Manager hooks ----------------------------------- */
    this.hook_change_grammar = function(grammar){
        debug("Editor: change grammar");
        var args = {
            format: "json"
        };
        var cont = function(data){
            t.process_grammar_constructors(data);
            t.start_fresh();
        };
        t.server.browse(args, cont);
    };
    this.hook_change_startcat = function(startcat){
        debug("Editor: change startcat");
        t.startcat = startcat;
        if (t.clear_on_change_startcat)
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

/* --- Pre-processed grammar information ------------------------------------ */

Editor.prototype.process_grammar_constructors=function(data) {
    var t = this;
    t.grammar_constructors=data;
    for (var fun in t.grammar_constructors.funs) {
        var def = t.grammar_constructors.funs[fun].def;
        var typeobj = AST.parse_type_signature(def);
        t.grammar_constructors.funs[fun] = typeobj;
    }
}

// Look up information for a category
Editor.prototype.lookup_cat = function(cat) {
    var t = this;
    return t.grammar_constructors.cats[cat];
}

// Look up information for a function
Editor.prototype.lookup_fun = function(fun) {
    var t = this;
    return t.grammar_constructors.funs[fun];
}

/* --- API for getting and setting state ------------------------------------ */

Editor.prototype.get_ast=function() {
    return this.ast.toString();
}

Editor.prototype.get_startcat=function() {
    return this.gm.startcat;
}

// Called from Minibar, for example
Editor.prototype.initialize_from=function(opts) {
    var t = this;
    if (opts.abstr) {
        t.ast = new AST(null, t.get_startcat());
        t.import_ast(opts.abstr);
    }
}

// Called after changing grammar or startcat
Editor.prototype.start_fresh=function () {
    var t = this;
    t.ast = new AST(null, t.get_startcat());
    if (t.options.initial.abstr) {
        t.import_ast(t.options.initial.abstr);
        t.options.initial.abstr = null; // don't use again
    }
    t.update_current_node();
    clear(t.ui.lin);
}

/* --- Functions for handling tree manipulation ----------------------------- */

// Add refinement to UI, returning object
Editor.prototype.add_refinement=function(fun,opts) {
    var t = this;
    options = {
        label: fun,
        disable_destructive: false
    };
    if (opts) for (var o in opts) options[o] = opts[o];
    var typeobj = t.lookup_fun(fun);

    // hide refinement if identical to current fun?

    var opt = span_class("refinement", text(options.label));
    opt.title = typeobj.signature;

    // If refinement would be destructive, disable it
    if (options.disable_destructive) {
        var blank = t.ast.is_writable();
        var inplace = t.ast.fits_in_place(typeobj);
        if (!blank && !inplace) {
            opt.classList.add("disabled");
        }
    }

    t.ui.refinements.appendChild(opt);
    return opt;
}

// Add a literal refinement to UI, e.g. String
Editor.prototype.add_literal_refinement=function() {
    var t = this;
    t.ui.refinements.innerHTML = "Enter string: ";
    var nde = t.ast.getCurrentNode();
    var val = (nde.string) ? nde.string : "";
    var input = node("input",{
        type:"text",
        value: val
    },[]);
    // TODO: Perhaps we should have an update button instead
    input.onkeyup = function() {
        nde.string = input.value;
        t.redraw_tree();
        t.update_linearisation();
    }
    t.ui.refinements.appendChild(input);
}

// Show refinements for given cat (usually that of current node)
Editor.prototype.get_refinements=function(cat) {
    var t = this;
    t.ui.refinements.innerHTML = "…";
    if (cat == undefined) cat = t.ast.getCat();

    // Special case when cat is "String"
    if (cat == "String") {
        t.add_literal_refinement();
        return;
    }

    var args = {
        id: cat,
        format: "json"
    };
    var cont = function(data){
        clear(t.ui.refinements);
        // t.ui.refinements.innerHTML = "Refinements: ";
        function addClickHandler(fun) {
            return function() {
                t.select_refinement.apply(t,[fun]);
            }
        }
        for (var pi in data.producers) {
            var fun = data.producers[pi];
            var ref = t.add_refinement(fun, {
                disable_destructive: true
            });
            ref.onclick = addClickHandler(fun);
        }
    };
    var err = function(data){
        clear(t.ui.refinements);
        alert("Error");
    };
    t.server.browse(args, cont, err);
}

// Select refinement now by default replaces "in-place"
// Case 1: current node is blank/no kids
// Case 2: kids have all same types, perform an in-place replacement
// Case 3: kids have diff types/number, prevent replacement (must clear first)
Editor.prototype.select_refinement=function(fun) {
    var t = this;

    // Check if current node is blank or childless (case 1)
    var blank = t.ast.is_writable();

    // Check if we can replace in-place (case 2)
    var typeobj = t.lookup_fun(fun);
    var inplace = !blank && t.ast.fits_in_place(typeobj);

    if (!blank && !inplace) {
        alert("Use 'Clear' first if you want to replace the subtree.");
        return;
    }

    t.ast.setFun(fun);

    if (blank) {
        t.ast.removeChildren();

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
            ast.setCurrentID(newID);
        redraw_tree();
        get_refinements();
    }
}

// Clear current node and all its children
Editor.prototype.clear_node = function() {
    var t = this;
    t.ast.removeChildren();
    t.ast.setFun(null);
    t.redraw_tree();
    t.get_refinements();
}

// Show wrap candidates
Editor.prototype.wrap_candidates = function() {
    var t = this;

    // we need to end with this
    var cat = t.ast.getCat();

    var refinements = [];
    for (var i in t.grammar_constructors.funs) {
        var obj = t.grammar_constructors.funs[i];
        if (elem(cat, obj.args)) {
            // if no parent, then cat can be anything
            // as long as the current tree fits somewhere
            if (!t.ast.hasParent() || obj.ret==cat) {
                refinements.push(obj);
            }
        }
    }

    if (refinements.length == 0) {
        alert("No functions exist which can wrap the selected node.");
        return;
    }

    // Display wrap refinements
    function addClickHandler(fun, child_ix) {
        return function() {
            t.wrap.apply(t,[fun, child_ix]);
        }
    }
    t.ui.refinements.innerHTML = "Wrap with: ";
    for (var i in refinements) {
        var typeobj = refinements[i];
        var fun = typeobj.name;

        // Find valid child ids
        var child_ixs = [];
        for (var a in typeobj.args) {
            if (typeobj.args[a] == cat) {
                child_ixs.push(a);
            }
        }

        // if (child_ixs.length < 2) {
        //     var ref = t.add_refinement(fun);
        //     ref.onclick = addClickHandler(typeobj.name, a);
        // } else {
            // Show a refinement for each potential child position
            for (var c in child_ixs) {
                var id = child_ixs[c];
                var label = fun;
                for (var a in typeobj.args) {
                    if (a == id)
                        if (t.ast.currentNode.hasChildren())
                            label += " ("+t.ast.currentNode.fun+" …)";
                        else
                            label += " "+t.ast.currentNode.fun;
                    else
                        label += " ?";
                }
                var ref = t.add_refinement(typeobj.name, {label: label});
                ref.onclick = addClickHandler(typeobj.name, id);
            }
        // }
    }
}

// Wrap the current node inside another function
Editor.prototype.wrap = function(fun, child_ix) {
    var t = this;
    var typeobj = t.grammar_constructors.funs[fun];

    // if we are at root node, potentially change startcat
    if (t.ast.atRoot() && t.get_startcat() != typeobj.ret) {
        var old_val = t.clear_on_change_startcat;
        t.clear_on_change_startcat = false;
        t.gm.change_startcat(typeobj.ret);
        t.clear_on_change_startcat = old_val;
    }

    // do actual replacement
    t.ast.wrap(typeobj, child_ix);

    // refresh stuff
    t.redraw_tree();
    t.update_linearisation();
    t.ast.toNextHole();
    t.update_current_node();
}

// Unwrap a node by deleting a fun with same input/output category
Editor.prototype.unwrap = function() {
    var t = this;
    var fun = t.ast.getFun();
    var typeobj = t.grammar_constructors.funs[fun];

    // Cannot unwrap when at root
    if (t.ast.atRoot()) {
        alert("It is not possible to unwrap the top node");
        return;
    }

    var child = t.ast.getCurrentNode();
    var parent = t.ast.getParent();

    // TODO: We can also unwrap when at level one and cats don't match

    // Check if unwrap is possible
    if (parent.children.length==1 &&
        (parent.cat==child.cat || parent==t.ast.getRoot())
       ) {

        // do actual unwrap
        t.ast.unwrap();

        // if root node changed, potentially change startcat
        var rootcat = t.ast.getRoot().cat;
        if (rootcat != t.get_startcat()) {
            var old_val = t.clear_on_change_startcat;
            t.clear_on_change_startcat = false;
            t.gm.change_startcat(rootcat);
            t.clear_on_change_startcat = old_val;
        }

        // refresh stuff
        t.redraw_tree();
        t.update_linearisation();
        // t.ast.toNextHole();
        // t.update_current_node();
    } else {
        alert("Cannot unwrap this node");
    }
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
    t.server.get_random(args, cont, err);
}

// Redraw tree
Editor.prototype.redraw_tree=function() {
    var t = this;
    var elem = node; // function from support.js
    function visit(container, id, node) {
        var container2 = empty_class("div", "node");
        if (id.get().length == 1)
            container2.classList.add("first");

        // Special case for String literal
        if (node.cat == "String") {
            var label =
                '"' + ((node.string) ? node.string : "") + '"' +
                " : String";
        } else {
            var label =
                ((node.fun) ? node.fun : "?") + " : " +
                ((node.cat) ? node.cat : "?");
        }

        var current = id.equals(t.ast.getCurrentID());
        var element = elem("a", {class:(current?"current":"")}, [text(label)]);
        element.onclick = function() {
            t.update_current_node(id);
        }
        container2.appendChild( element );

        for (var i in node.children) {
            var newid = new NodeID(id);
            newid.add(parseInt(i));
            visit(container2, newid, node.children[i]);
        }

        container.appendChild(container2);
    }
    with(this) {
        clear(ui.tree);
        ui.tree_str.innerText = ast.toString();
        visit(ui.tree, new NodeID(), ast.root);
    }
}

// Get and display linearisations for AST
Editor.prototype.update_linearisation=function(){
    var t = this;
    // langpart("FoodsEng","Foods") == "Eng"
    function langpart(conc,abs) {
        return hasPrefix(conc,abs) ? conc.substr(abs.length) : conc;
    }
    function row(lang, lin) {
        var langname = langpart(lang, t.gm.grammar.name);
        var btn = button(langname, function(){
            bind(t.options.lin_action,t)(lin,lang);
        });
        if (t.options.lin_action_tooltip) {
            btn.title = t.options.lin_action_tooltip;
        }
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
        for (var i in data) {
            var lang = data[i].to;
            if (t.gm.languages.length < 1 || elem(lang, t.gm.languages)) {
                tbody.appendChild(row(lang, data[i].text))
            }
        }
        t.ui.lin.appendChild(wrap("table",tbody));
    });
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
            var typeobj = t.lookup_fun(node.fun);
            node.cat = typeobj.ret;
        });
        t.redraw_tree();
        t.update_linearisation();
    };
    var err = function(tree){
        alert("Invalid abstract syntax tree");
    };
    t.server.pgf_call("abstrjson", args, cont, err);
}
