
var offline_options = {
  grammars_url: "/~hallgren/hs2js/test/",
  grammar_list: ["Foods.pgf","Smart.pgf","Phrasebook.pgf"]
}

var server=pgf_offline(offline_options);

var minibar_options= {
  show_abstract: true,
  show_trees: false,
  show_grouped_translations: false,
  default_source_language: "Eng",
  try_google: true,
  random_button: false
}

var minibar1=new Minibar(server,minibar_options);
