--# -path=.:RGLExt:alltenses:src/english
-- --# -path=.:RGLExt:../../lib/src/abstract:../../lib/src/english:../../lib/src/common
concrete SUMOEng of SUMO =
        BasicEng,
        MergeEng,
        Mid_level_ontologyEng,
        mondialEng,
        elementsEng,
        HigherOrderEng

** {

flags unlexer = text ; lexer = text ;

} ;
