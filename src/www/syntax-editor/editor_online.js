var server_options = {
    // grammars_url: "http://www.grammaticalframework.org/grammars/",
    // grammars_url: "http://localhost:41296/grammars/",
}
var editor_options = {
    target: "editor",
    // initial: {
    //     grammar: "http://localhost:41296/grammars/Phrasebook.pgf",
    //     startcat: "Proposition",
    //     languages: ["Eng","Swe","Ita"],
    //     abstr: "PropOpenDate (SuperlPlace TheMostExpensive School) Tomorrow",
    //     node_id: null
    // },
    show: {
        grammar_menu: true,
        startcat_menu: true,
        to_menu: true,
        random_button: true
    }
}
if(window.Minibar) // Minibar loaded?
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
                input: s.split(" ") // is it that easy?
            },
            // get us back to the editor!
            abstract_action: function(tree) {
                var minibar=this;
                // how to get hold of new minibar?
                var editor_options = {
                    target: "editor",
                    initial: {
                        grammar: editor.minibar.grammar_menu.value, // hmm
                        startcat: editor.minibar.input.startcat_menu.value, // hmm
                        abstr: tree
                    }
                }
                minibar.hide();
                minibar.editor.show();
            }
        }
        editor.hide();
        editor.minibar=new Minibar(server,minibar_options);
        editor.minibar.editor = editor; // :S
    }
if(/^\?\/tmp\//.test(location.search)) {
    var args=decodeURIComponent(location.search.substr(1)).split(" ")
    if(args[0]) server_options.grammars_url=args[0];
}
var server = pgf_online(server_options);
var editor = new Editor(server, editor_options);


