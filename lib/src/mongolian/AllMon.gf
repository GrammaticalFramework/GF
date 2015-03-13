--# -path=.:../abstract:../common

concrete AllMon of AllMonAbs = 
 LangMon,  -- - [bank_N, eye_N, hair_N, hand_N, hat_N, radio_N], -- also in DictMon
 ExtraMon
-- DictMon -- normally not in All AR
 ** { 
 flags coding=utf8 ;
 } ;
