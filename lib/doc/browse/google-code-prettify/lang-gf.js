/*
  GF language
  Customised from lang-hs.js (Haskell)
*/
PR.registerLangHandler(PR.createSimpleLexer([
    ["pln", /^[\t-\r ]+/, null, "\t\n\r "],
    ["str", /^"(?:[^\n\f\r"\\]|\\[\S\s])*(?:"|$)/, null, '"'],
//    ["str", /^'(?:[^\n\f\r'\\]|\\[^&])'?/, null, "'"],
    ["lit", /^(?:0o[0-7]+|0x[\da-f]+|\d+(?:\.\d+)?(?:e[+-]?\d+)?)/i, null, "0123456789"]
], [
    ["com", /^(?:--[^\n\f\r]*|{-(?:[^-]|-+[^}-])*-})/],
    ["kwd", /^(?:abstract|case|cat|concrete|data|def|flags|fun|in|incomplete|instance|interface|let|lin|lincat|lindef|of|open|oper|param|pre|printname|resource|strs|table|transfer|variants|where|with)(?=[^\d'A-Za-z_]|$)/, null],
    ["pln", /^(?:[A-Z][\w']*\.)*[A-Za-z][\w']*/],
    ["pun", /^[^\d\t-\r "'A-Za-z]+/]
]), ["gf"]);
