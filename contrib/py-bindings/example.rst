Using the GF python bindings
============================

This is how to use some of the functionalities of the GF shell inside Python.

Loading a pgf file
------------------
First you must import the library:

>>> import gf

then load a PGF file, like this tiny example:

>>> pgf = gf.read_pgf("Query.pgf")

We could ask for the supported languages:

>>> pgf.languages()
[QueryEng, QuerySpa]

The *start category* of the PGF module is:

>>> pgf.startcat()
Question

Parsing and linearizing
-----------------------

Let's us save the languages for later:

>>> eng,spa = pgf.languages()

These are opaque objects, not strings:

>>> type(eng)
<type 'gf.lang'>

and must be used when parsing:

>>> pgf.parse(eng, "is 42 prime")
[Prime (Number 42)]

Yes, I know it should have a '?' at the end, but there is not support for other lexers at this time.

Notice that parsing returns a list of gf trees.
Let's save it and linearize it in Spanish:

>>> t = pgf.parse(eng, "is 42 prime")
>>> pgf.linearize(spa, t[0])
'42 es primo'

(which is not, but there is a '?' lacking at the end, remember?)


Getting parsing completions
---------------------------
One of the good things of the GF shell is that it suggests you which tokens can continue the line you are composing.

We got this also in the bindings. 
Suppose we have no idea on how to start:

>>> pgf.complete(eng, "")
['is']

so, there is only a sensible thing to put in. Let's continue:

>>> pgf.complete(eng, "is ")
[]

Is it important to note the blank space at the end, otherwise we get it again:

>>> pgf.complete(eng, "is")
['is']

But, how come that nothing is suggested at "is "? 
At the current point, a literal integer is expected so GF would have to present an infinite list of alternatives. I cannot blame it for refusing to do so.

>>> pgf.complete(eng, "is 42 ")
['even', 'odd', 'prime']

Good. I will go for 'even', just to be in the safe side:

>>> pgf.complete(eng, "is 42 even ")
[]

Nothin again, but this time the phrase is complete. Let us check it by parsing:

>>> pgf.parse(eng, "is 42 even")
[Even (Number 42)]

Deconstructing gf trees
-----------------------
We store the last result and ask for its type:

>>> t = pgf.parse(eng, "is 42 even")[0]
>>> type(t)
<type 'gf.tree'>

What's inside this tree? We use ``unapply`` for that:

>>> t.unapply()
[Even, Number 42]

This method returns a list with the head of the **fun** judgement and its arguments:

>>> map(type, _)
[<type 'gf.cid'>, <type 'gf.expr'>]


Notice the argument is again a tree (``gf.tree`` or ``gf.expr``, it is all the same here.)

>>> t.unapply()[1]
Number 42


We will repeat the trick with it now:

>>> t.unapply()[1].unapply()
[Number, 42]

and again, the same structure shows up:

>>> map(type, _)             
[<type 'gf.cid'>, <type 'gf.expr'>]

One more time, just to get to the bottom of it:

>>> t.unapply()[1].unapply()[1].unapply()
42

but now it is an actual number:

>>> type(_)
<type 'int'>

We ended with a full decomposed **fun** judgement.


Note
----

This file can be used to test the bindings: ::

    python -m doctest example.rst



