-- (c) Krasimir Angelov
--
-- The L-System is a grammar formalism which is used to describe 
-- graftals (recursive graphical objects). It is interesting
-- coincidence that every L-System grammar could be redefined
-- as PMCFG grammar. This demo shows how to generate graftals
-- using GF. The output from every concrete syntax is in postscript
-- format.

abstract Graftal = {
cat N; S;
fun z : N ;
    s : N -> N ;
    c : N -> S ;
}