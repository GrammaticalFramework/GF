resource ParamScand = ParamX ** {

param
  Species = Indef | Def ;
  Case    = Nom | Gen ;
  Voice   = Act | Pass ;

  Order   = Main | Inv | Sub ;

  DetSpecies = DIndef | DDef Species ;

  GenNum  = SgUtr | SgNeutr | Plg ;

  AForm   = AF AFormGrad Case ;

  AFormGrad =
     APosit  AFormPos
   | ACompar  
   | ASuperl AFormSup ;

  AFormPos = Strong GenNum | Weak Number ;
  AFormSup = SupStrong | SupWeak ;

  VForm = 
     VF VFin
   | VI VInf ;

  VFin =
     VPres Voice
   | VPret Voice
   | VImper Voice ;

  VInf = 
     VInfin Voice
   | VSupin Voice
   | VPtPret AFormPos Case ;

  SForm = 
     VFinite Tense Anteriority
   | VImperat
   | VInfinit Anteriority ;

  NPForm = NPNom | NPAcc | NPGen GenNum ;
---  AdjPronForm = APron GenNum Case ;
---  AuxVerbForm = AuxInf | AuxPres | AuxPret | AuxSup ;

  CardOrd = NCard | NOrd ;

  RCase = RNom | RAcc | RGen | RPrep ;

  RAgr = RNoAg | RAg {gn : GenNum ; p : Person} ;

oper
  Agr : PType = {gn : GenNum ; p : Person} ;

}
