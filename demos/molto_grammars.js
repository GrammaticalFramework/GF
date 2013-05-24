var online_options={
  grammars_url: "/grammars/molto/"
}

var minibar_options= {
    show_abstract: true,
    show_trees: true,
    tree_img_format: "svg", // or "png"
    show_grouped_translations: false,
    to_multiple: false,
    show_brackets: true,
    word_replacements: true,
    default_source_language: "Eng",
    feedback_url: "feedback.html",
    try_google: true
}

var server=pgf_online(online_options);
var minibar=new Minibar(server,minibar_options);
