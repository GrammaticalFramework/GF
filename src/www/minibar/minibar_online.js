// minibar_online.js, assumes that minibar.js and pgf_online.js have been loaded.

var online_options={
  //grammars_url: "http://www.grammaticalframework.org/grammars/",
  //grammars_url: "http://tournesol.cs.chalmers.se:41296/grammars/",
  //grammars_url: "http://localhost:41296/grammars/",
  //grammar_list: ["Foods.pgf"], // leave undefined to get list from server
}

if(window.grammar_list) online_options.grammar_list=grammar_list

var minibar_options= {
    show_abstract: true,
    show_trees: true,
//  tree_img_format: "png", // or "svg"
    show_grouped_translations: false,
    show_brackets: true,
    word_replacements: true,
    default_source_language: "Eng",
    //feedback_url: "feedback.html",
    try_google: true
}

if(/^\?\/tmp\//.test(location.search)) {
    var args=decodeURIComponent(location.search.substr(1)).split(" ")
    if(args[0]) online_options.grammars_url=args[0];
    if(args[1]) minibar_options.initial_grammar=args[1];
}
else if(supports_html5_storage()) {
    var s=window.localStorage["gf.editor.simple.grammardir"]
    if(s) var editor_dir=JSON.parse(s);
}

var server=pgf_online(online_options);
if(editor_dir) server.add_grammars_url(editor_dir+"/");

var minibar=new Minibar(server,minibar_options);
