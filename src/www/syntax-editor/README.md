# GF web-based syntax editor

John J. Camilleri  
December 2012

An improved version of the [old syntax editor][1].

[1]:http://www.grammaticalframework.org/~meza/restWiki/editor.html

## Notes

- Tested with latest Chrome and Firefox (only).

## Available startup options

|Options|Description|Default|
|-------|-----------|-------|
|target |           |"editor"|
|initial.grammar|Initial grammar URL, e.g. `"http://localhost:41296/grammars/Foods.pgf"`|-|
|initial.startcat|Initial startcat|-|
|initial.languages|Initial linearisation languages, e.g. `["Eng","Swe","Mlt"]`|-|
|initial.abstr|Initial abstract tree (as string), e.g. `"Pred (That Fish) Expensive"`|-|
|show.grammar_menu|Show grammar menu?|true|
|show.startcat_menu|Show start category menu?|true|
|show.to_menu|Show languages menu?|true|
|show.random_button|Show random button?|true|

## Example usage

See `editor.html` and `editor_online.js`.

## Bugs

- Change startcat doesn't work when given an initial startcat 

## TODO

- Import AST from text field
- Compatibility with grammars with dependent category types
- Clicking on tokens to select tree node
- Clipboard of trees
- Usage of printnames
- Enter string/float/int literals
- more prominence to Disamb-linearizations
- show all resulting linearizations/variants
- undo/redo (or back/forward) navigation
- structure fridge magnets more (eg newline before the magnet whose first letter is different)

