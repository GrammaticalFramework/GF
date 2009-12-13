module GF.Command.Messages where

licenseMsg = unlines [
 "Copyright (c)", 
 "Krasimir Angelov, Bj\246rn Bringert, H\229kan Burden, Hans-Joachim Daniels,",
 "Markus Forsberg, Thomas Hallgren, Harald Hammarstr\246m, Kristofer Johannisson,",
 "Janna Khegai, Peter Ljungl\246f, Petri M\228enp\228\228, and", 
 "Aarne Ranta, 1998-2008, under GNU General Public License (GPL)",
 "see LICENSE in GF distribution, or http://www.gnu.org/licenses/gpl.html."
 ]

codingMsg = unlines [
  "The GF shell uses Unicode internally, but assumes user input to be UTF8",
  "and converts terminal and file output to UTF8. If your terminal is not UTF8", 
  "see 'help set_encoding."
 ]

changesMsg = unlines [
  "While GF 3.0 is backward compatible with source grammars, the shell commands", 
  "have changed from version 2.9. Below the most importand changes. Bug reports",
  "and feature requests should be sent to http://trac.haskell.org/gf/.",
  "",
  "af     use wf -append",
  "at     not supported",
  "eh     not yet supported", 
  "es     no longer supported; use javascript generation",
  "g      not yet supported", 
  "l      now by default multilingual",
  "ml     not yet supported", 
  "p      now by default multilingual",
  "pi     not yet supported", 
  "pl     not yet supported", 
  "pm     subsumed to pg",
  "po     not yet supported",
  "pt     not yet supported", 
  "r      not yet supported",
  "rf     changed syntax",
  "rl     not supported",
  "s      no longer needed",
  "sa     not supported",
  "sf     not supported",
  "si     not supported",
  "so     not yet supported", 
  "t      use pipe with l and p",
  "tb     use l -treebank",
  "tl     not yet supported", 
  "tq     changed syntax",
  "ts     not supported",
  "tt     use ps",
  "ut     not supported",
  "vg     not yet supported",
  "wf     changed syntax",
  "wt     not supported"
  ]
