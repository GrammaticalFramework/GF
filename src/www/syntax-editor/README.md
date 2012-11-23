# GF web-based syntax editor

John J. Camilleri  
November 2012

An improved version of the [old syntax editor][1].

[1]:http://www.grammaticalframework.org/~meza/restWiki/editor.html

## Notes

- Tested with latest Chrome and Firefox (only).

## Available startup options

    var editor_options = {
        target: "editor",
            initial: {
                grammar: "http://localhost:41296/grammars/Foods.pgf",
                startcat: "Kind",
                languages: ["Eng","Swe","Mlt"],
                abstr: "Pred (That Fish) Expensive"
            },
            show: {
                grammar_menu: true,
                startcat_menu: true,
                to_menu: true,
                random_button: true
            }
        }

## TODO

- Wrap a subtree
- Compatibility with grammars with dependent category types
- Clicking on tokens to select tree node
- try to retain subtree when replacing node
- Use local caching
- Clipboard of trees
- Usage of printnames
- Enter string/float/int literals
- more prominence to Disamb-linearizations
- ambiguity: (optionally) parse all the resulting linearizations/variants and point out those which are ambiguous
- add undo/redo (or back/forward) navigation
- structure fridge magnets some more (eg newline before the magnet whose first letter is different)
