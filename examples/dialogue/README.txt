Dialogue system grammars using GF resource.

AR 16/5/2006

==Functionality and purpose==

Dialogue system abstract syntax + concrete syntaxes for
different languages. One of them is Prolog (with some resemblance to
dialogue moves in GoDiS).

The purpose is to show how new systems can be built for new domains just
by specifying just two things:
- a domain ontology in abstract syntax
- a domain terminologies in concrete syntaxes


This is based on two library elements
- base dialogue grammars
- resource grammar libraries


In general, the only kind of elements that need to be added are
constants (0-place fun's) of the following categories from Dialogue.gf.
```
  Kind ;             -- e.g. Room
  Object Kind ;      -- e.g. Kitchen
  Oper0 ;            -- e.g. Stop
  Oper1 Kind ;       -- e.g. Play
  Oper2 Kind Kind ;  -- e.g. Add
  Move ;             -- e.g. MorningMode
```


==Files in this directory==

Files (for X = Eng, Fin, Fre, Prolog, Swe):

Files provided as library to build on:
```
  Dialogue.gf   -- base dialogue grammar
  DialogueX.gf  -- implementation instance
  DialogueI.gf  -- implementation functor

  ResProlog.gf  -- help constructs for Prolog terms

  Weekday.gf    -- untility grammar with weekdays
  WeekdayX.gf

  AuxDialogue.gf-- interface of auxiliary resource-defined opers
  AuxX.gf       -- instances for different languages
```
Files implementing two examples.
```
  Agenda.gf     -- application grammar for agenda
  AgendaX.gf

  Lights.gf     -- application grammar for lights
  Lights.gf
```

==Files needed to build a new application==

To build a new application for domain Dom, you thus need
```
  Dom.gf        -- introduce fun's in Kind, Object, Oper0, Oper1, Oper2
  DomX.gf       -- concrete syntax of the new fun's for language X
```

==Some tests==

You first need to do, with the latest resource grammar version,
- ``make present`` in ``lib/resource-1.0``

To test an application in GF, do e.g.
- ``make lights`` to make a package with all the Lights grammars
- ``make engcorpus`` to generate an English corpus
- ``make swecorpus`` to generate a Swedish corpus



Here are some other commands:
- ``i LightsEng.gf`` in current dir, to load a grammar 
- ``gr | l -all`` to random-generate
- ``gt -depth=4 | pt -transform=typecheck | l -all`` to generate a corpus
- ``p "switch off all lights in the kitchen"`` to parse
- ``i LightsProlog.gf`` to load the Prolog version
- ``pg -printer=gsl -startcat=Move`` to print a Nuance grammar
- ``p -lang=LightsEng "switch off all lights" | pt -transform=solve | l -lang=LightsProlog`` 
to translate from English to Prolog
- ``si -tr -lang=LightsEng | p -cat=Move -lang=LightsEng | pt -transform=solve | l -lang=LightsProlog``
to translate English speech into Prolog


The last one is the coolest - but you may need to enable the ``speech_input`` command by installing ATK
and recompiling GF.

