<!DOCTYPE html>
<html>
<head>
<title>About the syntax editor</title>
<link rel=stylesheet type="text/css" href="../minibar/minibar.css">
<link rel=stylesheet type="text/css" href="editor.css">
<meta charset="UTF-8">
</head>
<body class="syntax-editor">

# GF web-based syntax editor

John J. Camilleri  
December 2012

An improved version of the [old syntax editor][1].

[1]:http://www.grammaticalframework.org/~meza/restWiki/editor.html

## Example usage

See `editor.html` and `editor_online.js`.

## Available startup options

+---------------------+--------------------------------------------------+--------+
|Options              |Description                                       |Default |
+=====================+==================================================+========+
|target               |                                                  |"editor"|
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+
|initial.grammar      |Initial grammar URL,                              |        |
|                     |e.g. `"http://localhost:41296/grammars/Foods.pgf"`|        |
+---------------------+--------------------------------------------------+--------+
|initial.startcat     |Initial startcat                                  |(grammar|
|                     |                                                  |default)|
+---------------------+--------------------------------------------------+--------+
|initial.languages    |Initial linearisation languages,                  |(all)   |
|                     |e.g. `["Eng","Swe","Mlt"]`                        |        |
+---------------------+--------------------------------------------------+--------+
|initial.abstr        |Initial abstract tree (as string), e.g. `"Pred    |        |
|                     |(That Fish) Expensive"`                           |        |
+---------------------+--------------------------------------------------+--------+
|show_grammar_menu    |Show grammar menu?                                |True    |
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+
|show_startcat_menu   |Show startcat menu?                               |True    |
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+
|show_to_menu         |Show languages menu?                              |True    |
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+
|show_random_button   |Show random button?                               |True    |
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+
|show_import          |Show import button/panel?                         |True    |
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+
|show_export          |Show export button?                               |True    |
|                     |                                                  |        |
+---------------------+--------------------------------------------------+--------+

## Notes

- Tested with latest Chrome and Firefox (only).

## To do/feature requests

- Compatibility with grammars with dependent category types
- Clicking on tokens to select tree node
- Clipboard of trees
- Usage of printnames
- Enter string/float/int literals
- more prominence to Disamb-linearizations
- show all resulting linearizations/variants
- undo/redo (or back/forward) navigation
- structure fridge magnets more (eg newline before the magnet whose first letter is different)

## Known bugs

- Change startcat doesn't work when given an initial startcat 

</body>
</html>
