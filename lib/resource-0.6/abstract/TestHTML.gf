abstract TestHTML = Structural ** {

-- a random sample of lexicon to test resource grammar with

cat HTMLdoc; HTMLtag;

fun
  htmlText: HTMLtag -> HTMLtag -> HTMLdoc;
  head, body: HTMLtag; 

} ;

