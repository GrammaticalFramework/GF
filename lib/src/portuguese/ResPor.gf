--1 Portuguese auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--

instance ResPor of ResRomance = DiffPor ** open CommonRomance, Prelude in {
  oper
    vowel : pattern Str = #("a" | "e" | "i" | "o" | "u") ;
} ;
