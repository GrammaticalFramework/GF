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

- Link to jump into minibar
- Compatibility with grammars with dependent category types
- Clicking on tokens to select tree node
- Use local caching
- Enter string/float/int literals
- UI issue with DisambPhrasebookEng
- more prominence to Disamb-linearizations
- ambiguity: (optionally) parse all the resulting linearizations/variants and point out those which are ambiguous
- try to retain subtree when replacing node
- add undo/redo (or back/forward) navigation
- structure fridge magnets some more (eg newline before the magnet whose first letter is different)
- The formal-looking funs and cats are not linked/aligned to the linearizations.
Maybe a possible UI could be where the user is
clicking on the linearization (in a chosen language) and the tree is
drawn under it (from top to bottom, not from left to right as
currently). So that the alignment of words to functions is always
explicit. But maybe this is not doable.
