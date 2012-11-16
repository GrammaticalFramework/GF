# GF web-based syntax editor

John J. Camilleri  
November 2012

An improved version of the [old syntax editor][1].

[1]:http://www.grammaticalframework.org/~meza/restWiki/editor.html

## Notes

Tested with latest Chrome and Firefox.

## TODO

- Clicking on tokens to select tree node
- Use local caching
- Enter string/float/int literals
- UI issue with DisambPhrasebookEng
- more prominence to Disamb-linearizations
- ambiguity: (optionally) parse all the resulting linearizations/variants and point out those which are ambiguous
- random-generate a non-empty tree as a starting point
- try to retain subtree when replacing node
- add undo/redo (or back/forward) navigation
- structure the set of fridge magnets some more. Even though they
are alphabetically sorted, it's difficult to find the one that I want,
maybe put a newline before the magnet whose first letter is different
with respect to the previous magnet
- The formal-looking funs and cats are not linked/aligned to the linearizations.
Maybe a possible UI could be where the user is
clicking on the linearization (in a chosen language) and the tree is
drawn under it (from top to bottom, not from left to right as
currently). So that the alignment of words to functions is always
explicit. But maybe this is not doable.
