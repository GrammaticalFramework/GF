# Simple tests

## Morphology of synthetic verbs

Some tests found in `ukanDu.gfs`, `ukanZaio.gfs` and `ukanDio.gfs`. I test the forms against Apertium morphological analyser, you can use your favourite Basque morphological analyser.

In this directory I run it like this:

```
gf --run < ukanDio.gfs > /tmp/Dio.txt
```

And in the directory with Apertium, I run this:

```
cat /tmp/Dio.txt | lt-proc -w eus.automorf.bin | egrep -o "\*(.*)$"  | sort -u
*didagu$
...
*zatzaie$
*zintzaizkizuekete$
```

The output is forms that the GF grammar generates but the Apertium analyser doesn't recognise. Some of them are due to overgeneration: forms like "I <some V2> me" don't exist, you should use reflexive instead. So *didagu*  is wrong in the sense that it doesn't exist, but there is no other form that would be more correct. For that reason, I decided to keep these forms and not replace them with an empty string or `nonExist`. 
If an application grammarian needs to say "I see myself", they can just use  `ReflVP` in `VerbEus`.

Some of the non-existing forms are genuine mistakes, like *zatzaie*, which should be *zatza__zki__e* instead. Then you just go to `AditzTrinkoak.gf` and fix the relevant functions.