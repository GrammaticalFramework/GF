--1 French auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--

instance ResFre of ResRomance = DiffFre ** open CommonRomance, Prelude in {

flags optimize=all ;

} ;
