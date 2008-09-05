--1 Catalan auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.


instance ResCat of ResRomance = DiffCat ** open CommonRomance, Prelude in {

  flags optimize=noexpand ;

} ;
