--# -path=.:../abstract:../../prelude

concrete TestResourceNumEng of TestResourceNum = TestResourceEng, NumeralsEng ** {

  lin UseNumeral n = {s = \\_ => n.s} ; ---- Case

} ;
