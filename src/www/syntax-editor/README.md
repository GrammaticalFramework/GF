<!DOCTYPE html>
<html>
<head>
<title>About the syntax editor</title>
<link rel=stylesheet type="text/css" href="../minibar/minibar.css">
<link rel=stylesheet type="text/css" href="editor.css">
<meta charset="UTF-8">
</head>
<body class="about">

# GF web-based syntax editor

John J. Camilleri  
January 2013

A tool for building and manipulating abstract syntax trees in GF.
This is meant as improved replacement of the [old syntax editor][old].

[old]:http://www.grammaticalframework.org/~meza/restWiki/editor.html

## Example usage

If you want to use the tool in your own application, everything you need in the source
files `editor.html` and `editor_online.js`. Contact the [GF developer mailing list][gf-dev]
if you have any problems.

[gf-dev]:http://groups.google.com/group/gf-dev

## Available startup options

### Grammar Manager

| Options             | Description                                                             | Default           |
|---------------------+-------------------------------------------------------------------------+-------------------|
| `initial.grammar`   | Initial grammar URL, e.g. `"http://localhost:41296/grammars/Foods.pgf"` |                   |
| `initial.startcat`  | Initial startcat                                                        | (grammar default) |
| `initial.languages` | Initial linearisation languages, e.g. `["Eng","Swe","Mlt"]`             | (all)             |


### Editor

| Options              | Description                                                                     | Default  |
|----------------------+---------------------------------------------------------------------------------+----------|
| `target`             |                                                                                 | "editor" |
| `initial.abstr`      | Initial abstract tree (as string), e.g. `"Pred (That Fish) Expensive"`          |          |
| `lin_action`         | Function called when clicking on the language button beside each linearisation. |          |
| `lin_action_tooltip` | Tooltip for the button beside each linearisation.                               |          |
| `show_grammar_menu`  | Show grammar menu?                                                              | True     |
| `show_startcat_menu` | Show startcat menu?                                                             | True     |
| `show_to_menu`       | Show languages menu?                                                            | True     |
| `show_random_button` | Show random button?                                                             | True     |
| `show_import`        | Show import button/panel?                                                       | True     |
| `show_export`        | Show export button?                                                             | True     |

## Notes

- Tested with latest Chrome and Firefox (only).

## To do/feature requests

- Compatibility with grammars with dependent category types
- Clicking on tokens to select tree node
- Clipboard of trees
- Usage of printnames
- Enter string/float/int literals
- more prominence to Disamb-linearizations
- show all resulting linearization variants
- undo/redo (or back/forward) navigation
- structure fridge magnets more (eg newline before the magnet whose first letter is different)

## Known bugs

- Change startcat doesn't work when given an initial startcat 

</body>
</html>
