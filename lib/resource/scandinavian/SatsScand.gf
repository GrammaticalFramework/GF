--1 Topological structure of Scandinavian sentences.
--
-- This is an alternative, more 'native' analysis than $Clause$ and
-- $Verbphrase$, due to Diderichsen.
--
-- Sources:
--   N. Jörgensen & J. Svensson, "Nusvensk grammatik" (Gleerups, 2001);
--   R. Zola Christensen, "Dansk grammatik for svenskere"
--   (Studentlitteratur 1999).

incomplete concrete SatsScand of Sats = CategoriesScand ** 
  open Prelude, SyntaxScand in {

  flags optimize=parametrize ;

-- The analysis is based on the notions of fundament, nexus, and
-- content ("innehåll") fields. Nexus and content are both divided into
-- two subfields - a verb, a noun phrase, and an adverbial.
-- In addition, there is a field for an extraposed sentence.
-- Each of these subfields can in a main clause be 'moved' to the
-- sentence-initial fundament position.

  lincat 
    Sats = {
      s1 : SForm => Str ;   -- V1 har
      s2 : Str ;            -- N1 jag
      s3 : Bool => Str ;    -- A1 inte
      s4 : SForm => Str ;   -- V2 sett
      s5 : Str ;            -- N2 dig
      s6 : Str ;            -- A2 idag
      s7 : Str ;            -- S  att... (extraposed sentence)
      e3,e4,e5,e6,e7 : Bool -- indicate if the field exists
      } ;

-- Thus the fundament is not a part of the $Sats$, but it is only
-- created when the $Sats$ is used as a $Main$ clause.
-- In an $Inv$erted clause, no fundament is created.
-- In a $Sub$ordinate clause, the order is rigid as well.

  lin
    ClSats sats = {s = \\b,cf =>
      let
        osf  = cl2s cf ;
        har  = sats.s1 ! osf.sf ;
        jag  = sats.s2 ;
        inte = sats.s3 ! b ;
        sagt = sats.s4 ! osf.sf ;
        dig  = sats.s5 ;
        idag = sats.s6 ;
        exts = sats.s7
      in case osf.o of {
      Main => variants {
               jag  ++ har ++ inte ++ sagt ++ dig  ++ idag ++ exts ;
        onlyIf (orB sats.e3 (notB b)) 
               (inte ++ har ++ jag  ++ sagt ++ dig  ++ idag ++ exts) ;
        onlyIf (orB sats.e4 (isCompoundClForm cf))
               (sagt ++ har ++ jag  ++ inte ++ dig  ++ idag ++ exts) ;
        onlyIf sats.e5 
               (dig  ++ har ++ jag  ++ inte ++ sagt ++ idag ++ exts) ;
        onlyIf sats.e6 
               (idag ++ har ++ jag  ++ inte ++ sagt ++ dig  ++ exts) ;
        onlyIf sats.e7 
               (exts ++ har ++ jag  ++ inte ++ sagt ++ dig  ++ idag)
        } ;
      Inv => 
        har ++ jag  ++ inte ++ sagt ++ dig ++ idag ++ exts ;
      Sub => 
        jag ++ inte ++ har  ++ sagt ++ dig ++ idag ++ exts
      }
    } ;

-- The following rules show how the fields are filled in a
-- predication, with different subcategorization patterns.

    SatsV = mkSats ;

    SatsV2 subj verb obj = 
      mkSatsObject subj verb (verb.s2 ++ obj.s ! PAcc) ;

    SatsV3 subj verb obj1 obj2 = 
      mkSatsObject subj verb (verb.s2 ++ obj1.s ! PAcc ++ verb.s3 ++ obj2.s ! PAcc) ;

    SatsReflV2 subj verb = 
      mkSatsObject subj verb (verb.s2 ++ reflPron subj.n subj.p) ;

    SatsVS subj verb sent = 
      insertExtrapos (mkSats subj verb) (optStr infinAtt ++ sent.s ! Sub) ;

    SatsVQ subj verb quest = 
      insertExtrapos (mkSats subj verb) (quest.s ! IndirQ) ;

    SatsV2S subj verb obj sent = 
      insertExtrapos 
        (mkSatsObject subj verb (verb.s2 ++ obj.s ! PAcc)) 
        (optStr infinAtt ++ sent.s ! Sub) ;

    SatsV2Q subj verb obj quest = 
      insertExtrapos 
        (mkSatsObject subj verb (verb.s2 ++ obj.s ! PAcc)) 
        (quest.s ! IndirQ) ;

    SatsAP subj adj = 
      mkSatsCopula subj (adj.s ! predFormAdj subj.g subj.n ! Nom) ;

    SatsCN subj cn = 
      mkSatsCopula subj (indefNoun subj.n cn) ;

    SatsNP subj np = 
      mkSatsCopula subj (np.s ! PNom) ;

    SatsAdv subj adv = 
      mkSatsCopula subj adv.s ;

-- No problem to insert a verb-complement verb:
---- (another rule needed for complement in perfect: "jag vill ha gått")

    VVSats sats vv = 
     let 
       harvelat = verbSForm vv Act 
     in 
     {s1 = \\sf => (harvelat sf).fin ;
      s2 = sats.s2 ;
      s3 = sats.s3 ;
      s4 = \\sf => (harvelat sf).inf ++ sats.s4 ! VInfinit Simul ;
      s5 = sats.s5 ;
      s6 = sats.s6  ;
      s7 = sats.s7  ;
      e3 = sats.e3 ;
      e4 = True ;
      e5 = sats.e5 ;
      e6 = sats.e6 ;
      e7 = sats.e7
      } ;

-- This is where sentence adverbials are inserted.

    AdVSats sats adv = {
      s1 = sats.s1 ;
      s2 = sats.s2 ;
      s3 = \\b => sats.s3 ! b ++ adv.s ;
      s4 = sats.s4 ;
      s5 = sats.s5 ;
      s6 = sats.s6 ;
      s7 = sats.s7 ;
      e3 = True ;
      e4 = sats.e4 ;
      e5 = sats.e5 ;
      e6 = sats.e6 ;
      e7 = sats.e7
      } ;

-- This is where other adverbials ('TSR') are inserted. There is an
-- operation for this, since this place is used for many more things
-- than the sentence adverbial place

    AdvSats sats adv = insertAdverb sats adv.s ;

-- with proper means in GF, this would become even nicer:

---    AdVSats sats adv = sats ** {s3 = sats.s3 ++ adv.s ; e3 = True} ;

}
