// minibar_online.js, assumes that minibar.js and pgf_online.js have been loaded.

var online_options={
  //grammars_url: "http://www.grammaticalframework.org/grammars/",
  //grammars_url: "http://tournesol.cs.chalmers.se:41296/grammars/",
  //grammars_url: "http://localhost:41296/grammars/",
  //grammar_list: ["Foods.pgf"], // leave undefined to get list from server
}

var minibar_options= {
    show_abstract: true,
    show_trees: true,
    tree_img_format: "png", // or "svg"
    show_grouped_translations: false,
    show_brackets: true,
    word_replacements: true,
    default_source_language: "Eng",
    //feedback_url: "feedback.html",
    try_google: true
}


if(window.Editor) // Syntax editor loaded?
    minibar_options.abstract_action=function(tree) {
	var editor_options = {
	    target: "editor",
	    initial: { grammar: minibar.grammar_menu.value, // hmm
		       startcat: minibar.input.startcat_menu.value, // hmm
		       languages: minibar.translations.toLangs, // hmm
		       abstr: tree
		     },
	    lin_action: function(new_input,langFrom) {
		var grammar_url=editor.menu.ui.grammar_menu.value // hmm
		var startcat=editor.menu.ui.startcat_menu.value // hmm
		var toLangs=multiMenuSelections(editor.menu.ui.to_menu) // hmm
		minibar.input.set_input_for(grammar_url,
					    {from:langFrom,
					     startcat:startcat,
					     input:gf_lex(new_input)})
		minibar.translations.set_toLangs_for(grammar_url,toLangs)

		//Easier: delete the editor and create a new one next time:
		clear(editor.container)
		editor=null;

		//Better: keep editor around and reactivate it next time:
		//editor.container.style.display="none"

		// Even if the grammar is the same as before, this call is
		// what eventually triggers the new_input to be loaded:
		minibar.select_grammar(grammar_url)

		// Make the minibar visible again
		minibar.minibar.style.display=""
	    }
	}
	minibar.minibar.style.display="none" // Hide the minibar
        var gm = new GrammarManager(server,editor_options);
	var editor=new Editor(gm,editor_options)
    }

if(/^\?\/tmp\//.test(location.search)) {
    var args=decodeURIComponent(location.search.substr(1)).split(" ")
    if(args[0]) online_options.grammars_url=args[0];
    if(args[1]) minibar_options.initial_grammar=args[1];
}
else if(window.localStorage) {
    var s=window.localStorage["gf.editor.simple.grammardir"]
    if(s) var editor_dir=JSON.parse(s);
}

var server=pgf_online(online_options);
if(editor_dir) server.add_grammars_url(editor_dir+"/");

var minibar=new Minibar(server,minibar_options);
