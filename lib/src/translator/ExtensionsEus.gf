--# -path=.:../abstract:../basque

concrete ExtensionsEus of Extensions = 
  CatEus ** open ResEus, ParamEus, ParadigmsEus, ExtraEus, SentenceEus, Prelude in {

lincat
  VPI,VPS = SS ;

lin

  -- : Temp -> Pol -> VP -> VPS ;  -- had walked
  MkVPS t p vp = 
   let emptyCl = clFromVP empty_NP vp ;
       emptyS = UseCl t p emptyCl ;
    in { s = linS emptyS.s } ;

  -- : NP -> VPS -> S ;            -- I had walked and drank beer
  PredVPS np vps = lin S {
   s = { beforeAux = np.s ! Erg ++ vps.s ;
         aux = { indep, stem = [] } ;
         afterAux = [] } } ; -- TODO: make VPS actually not lose all this info >__>


   UttAdV adv = adv ;


  --GerundCN    : VP -> CN ;          -- publishing of the document (can get a determiner)
  --GerundNP    : VP -> NP ;          -- publishing the document (by nature definite)
  --GerundAdv   : VP -> Adv ;         -- publishing the document (prepositionless adverb)

  --ByVP        : VP -> Adv ;         -- by publishing the document  
  -- asko ibiltzeaz

  -- WithoutVP   : VP -> Adv ;         -- without publishing the document  
  -- Artzain zaharra  atera zen  mendirantz       inori      ezer     esan gabe.
  -- shepherd old     went       mountain.toward  to.nobody  nothing  said without
  WithoutVP vp = { s = complOrder vp Neg
                    ++ vp.prc ! Past    -- eman 
                    ++ "gabe" } ;       -- gabe

  -- : VP -> Adv ;         -- (in order) to publish the document
  -- hemen ibiltzeko ‘in order to walk here’,
  -- ongi hiltzeko ‘in order to die well’, ona izateko ‘in order to be good’.
  -- haurra noratzen zuten ikusteko ‘in order to see where they took the child’.]
  -- corresponding interrogative is zertarako ‘what for’
  InOrderToVP vp = { s = complOrder vp Pos 
					            ++ glue vp.nstem "ko" } ; --emateko 


oper

  complOrder : VP -> Polarity -> Str = \vp,pol ->
    vp.adv ++  -- gaur
    vp.iobj.s ++  -- mutilari
    vp.dobj.s ! pol ++  -- garagardoa 
    vp.comp ! Hau ;

}
