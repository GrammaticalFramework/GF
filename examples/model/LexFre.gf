instance LexFre of Lex = open GrammarFre, ParadigmsFre in {

  oper
    even_A = regA "pair" ;
    odd_A = regA "impair" ;
    zero_PN = regPN "zéro" ;

}
