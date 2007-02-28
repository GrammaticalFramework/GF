instance LexEng of Lex = open GrammarEng, ParadigmsEng in {

  oper
    even_A = regA "even" ;
    odd_A = regA "odd" ;
    zero_PN = regPN "zero" ;

}
