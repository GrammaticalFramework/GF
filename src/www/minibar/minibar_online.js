// minibar_demo.js, assumes that minibar.js and pgf_online.js have been loaded.

var online_options={
  //grammars_url: "http://www.grammaticalframework.org/grammars/",
  //grammars_url: "http://tournesol.cs.chalmers.se:41296/grammars/",
  //grammars_url: "http://localhost:41296/grammars/",
  //grammar_list: ["Foods.pgf"], // leave undefined to get list from server
}

var minibar_options= {
  show_abstract: true,
  show_trees: true,
  show_grouped_translations: false,
  default_source_language: "Eng",
//feedback_url: "feedback.html",
  try_google: true
}

if(/^\?\/tmp\//.test(location.search)) {
    var args=decodeURIComponent(location.search.substr(1)).split(" ")
    if(args[0]) online_options.grammars_url=args[0];
    if(args[1]) minibar_options.initial_grammar=args[1];
}

var server=pgf_online(online_options);
var minibar=new Minibar(server,minibar_options);
