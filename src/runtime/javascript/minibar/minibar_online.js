// minibar_demo.js, assumes that minibar.js and pgf_online.js have been loaded.

var online_options={
  //grammars_url: "http://www.grammaticalframework.org/grammars/",
  //grammars_url: "http://tournesol.cs.chalmers.se:41296/grammars/",
  //grammars_url: "http://localhost:41296/grammars/",
  //grammar_list: ["Foods.pgf"], // leave undefined to get list from server
}


if(/^\?\/tmp\//.test(location.search)) {
  online_options.grammars_url=location.search.substr(1);
}

var server=pgf_online(online_options);

var minibar_options= {
  show_abstract: true,
  show_trees: true,
  show_grouped_translations: false,
  default_source_language: "Eng",
//feedback_url: "feedback.html",
  try_google: true
}
var minibar=new Minibar(server,minibar_options,"minibar");
