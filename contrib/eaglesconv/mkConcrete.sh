#!/bin/sh

echo "--# -path=.:../prelude:../abstract:../common

concrete DictRus of DictRusAbs = CatRus ** 
  open ParadigmsRus, Prelude, StructuralRus, MorphoRus in {
flags 
  optimize=values ;
  coding=utf8 ;
"
cat $1
echo "}"
