var server_options = {
    // grammars_url: "http://www.grammaticalframework.org/grammars/",
    // grammars_url: "http://localhost:41296/grammars/",
}
var editor_options = {
    target: "editor",
    initial: {
//        abstr: "PropOpenDate (SuperlPlace TheMostExpensive School) Tomorrow"
    },
    show: {
        grammar_menu: true,
        startcat_menu: true,
        to_menu: true,
        random_button: true
    }
}
var gm_options = {
    initial: {
        // grammar: "http://localhost:41296/grammars/Smart.pgf",
        // startcat: "Command",
        // languages: ["Eng","Swe"]
    }
}
if(window.Minibar) // Minibar loaded?
    editor_options.lin_action_tooltip="Load sentence in Minibar";
    editor_options.lin_action=function(s,langFrom) {
        var editor=this;
        var minibar_options = {
            target: "minibar",
            show_abstract: true,
            show_trees: true,
            show_grouped_translations: false,
            show_brackets: true,
            word_replacements: true,
            initial_grammar: editor.menu.ui.grammar_menu.value, // hmm
            initial: {
                from: langFrom,
                input: s.split(" "), // is it that easy?
		startcat: editor.menu.ui.startcat_menu.value // hmm
            },
	    initial_toLangs: multiMenuSelections(editor.menu.ui.to_menu), // hmm

            // get us back to the editor!
            abstract_action: function(tree) {
                var opts = {
                    abstr: tree
                }
                editor.initialize_from(opts);
                editor.minibar.hide();
                editor.show();
            }
        }
        editor.hide();
        editor.minibar=new Minibar(server,minibar_options);
        //editor.minibar.editor = editor; // :S
	editor.minibar.show();
    }
if(/^\?\/tmp\//.test(location.search)) {
    var args=decodeURIComponent(location.search.substr(1)).split(" ")
    if(args[0]) server_options.grammars_url=args[0];
}
var server = pgf_online(server_options);
var gm = new GrammarManager(server, gm_options);
var editor = new Editor(gm, editor_options);

