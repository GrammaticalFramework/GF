concrete ConstructionSlv of Construction = CatSlv ** 
  open ParadigmsSlv, ResSlv in {

flags
  coding=utf8;

lincat
  Weekday = N ;
  Month = N ; 

lin
  weekdayN w = w ;
  monthN m = m ;

lin
  monday_Weekday = mkN "ponedeljek" "ponedeljka" "ponedeljku" "ponedeljek" "ponedeljku" "ponedeljkom" "ponedeljka" "ponedeljkov" "ponedeljkoma" "ponedeljka" "ponedeljkih" "ponedeljkoma" "ponedeljki" "ponedeljkov" "ponedeljkom" "ponedeljke" "ponedeljkih" "ponedeljki" masculine ;
  tuesday_Weekday = mkN "torek" "torka" "torku" "torek" "torku" "torkom" "torka" "torkov" "torkoma" "torka" "torkih" "torkoma" "torki" "torkov" "torkom" "torke" "torkih" "torki" masculine ;
  wednesday_Weekday = mkN "sreda" "srede" "sredi" "sredo" "sredi" "sredo" "sredi" "sred" "sredama" "sredi" "sredah" "sredama" "srede" "sred" "sredam" "srede" "sredah" "sredami" feminine ;
  thursday_Weekday = mkN "četrtek" "četrtka" "četrtku" "četrtek" "četrtku" "četrtkom" "četrtka" "četrtkov" "četrtkoma" "četrtka" "četrtkih" "četrtkoma" "četrtki" "četrtkov" "četrtkom" "četrtke" "četrtkih" "četrtki" masculine ;
  friday_Weekday = mkN "petek" "petka" "petku" "petek" "petku" "petkom" "petka" "petkov" "petkoma" "petka" "petkih" "petkoma" "petki" "petkov" "petkom" "petke" "petkih" "petki" masculine ;
  saturday_Weekday = mkN "sobota" "sobote" "soboti" "soboto" "soboti" "soboto" "soboti" "sobot" "sobotama" "soboti" "sobotah" "sobotama" "sobote" "sobot" "sobotam" "sobote" "sobotah" "sobotami" feminine ;
  sunday_Weekday = mkN "nedelja" "nedelje" "nedelji" "nedeljo" "nedelji" "nedeljo" "nedelji" "nedelj" "nedeljama" "nedelji" "nedeljah" "nedeljama" "nedelje" "nedelj" "nedeljam" "nedelje" "nedeljah" "nedeljami" feminine ;

  january_Month = mkN "januar" "januarja" "januarju" "januar" "januarju" "januarjem" "januarja" "januarjev" "januarjema" "januarja" "januarjih" "januarjema" "januarji" "januarjev" "januarjem" "januarje" "januarjih" "januarji" masculine ;
  february_Month = mkN "februar" "februarja" "februarju" "februar" "februarju" "februarjem" "februarja" "februarjev" "februarjema" "februarja" "februarjih" "februarjema" "februarji" "februarjev" "februarjem" "februarje" "februarjih" "februarji" masculine ;
  march_Month = mkN "marec" "marca" "marcu" "marec" "marcu" "marcem" "marca" "marcev" "marcema" "marca" "marcih" "marcema" "marci" "marcev" "marcem" "marce" "marcih" "marci" masculine ;
  april_Month = mkN "april" "aprila" "aprilu" "april" "aprilu" "aprilom" "aprila" "aprilov" "apriloma" "aprila" "aprilih" "apriloma" "aprili" "aprilov" "aprilom" "aprile" "aprilih" "aprili" masculine ;
  may_Month = mkN "maj" "maja" "maju" "maj" "maju" "majem" "maja" "majev" "majema" "maja" "majih" "majema" "maji" "majev" "majem" "maje" "majih" "maji" masculine ;
  june_Month = mkN "junij" "junija" "juniju" "junij" "juniju" "junijem" "junija" "junijev" "junijema" "junija" "junijih" "junijema" "juniji" "junijev" "junijem" "junije" "junijih" "juniji" masculine ;
  july_Month = mkN "julij" "julija" "juliju" "julij" "juliju" "julijem" "julija" "julijev" "julijema" "julija" "julijih" "julijema" "juliji" "julijev" "julijem" "julije" "julijih" "juliji" masculine ;
  august_Month = mkN "avgust" "avgusta" "avgustu" "avgust" "avgustu" "avgustom" "avgusta" "avgustov" "avgustoma" "avgusta" "avgustih" "avgustoma" "avgusti" "avgustov" "avgustom" "avguste" "avgustih" "avgusti" masculine ;
  september_Month = mkN "september" "septembra" "septembru" "september" "septembru" "septembrom" "septembra" "septembrov" "septembroma" "septembra" "septembrih" "septembroma" "septembri" "septembrov" "septembrom" "septembre" "septembrih" "septembri" masculine ;
  october_Month = mkN "oktober" "oktobra" "oktobru" "oktober" "oktobru" "oktobrom" "oktobra" "oktobrov" "oktobroma" "oktobra" "oktobrih" "oktobroma" "oktobri" "oktobrov" "oktobrom" "oktobre" "oktobrih" "oktobri" masculine ;
  november_Month = mkN "november" "novembra" "novembru" "november" "novembru" "novembrom" "novembra" "novembrov" "novembroma" "novembra" "novembrih" "novembroma" "novembri" "novembrov" "novembrom" "novembre" "novembrih" "novembri" masculine ;
  december_Month = mkN "december" "decembra" "decembru" "december" "decembru" "decembrom" "decembra" "decembrov" "decembroma" "decembra" "decembrih" "decembroma" "decembri" "decembrov" "decembrom" "decembre" "decembrih" "decembri" masculine ;

  weekdayPunctualAdv w = {s = "v" ++ w.s ! Acc ! Sg} ; ----AR
  weekdayHabitualAdv w = {s = "ob" ++ w.s ! Loc ! Pl} ; ----AR
  weekdayNextAdv w = {s = "naslednjo" ++ w.s ! Acc ! Sg} ; ----AR
  weekdayLastAdv w = {s = "prejšnjo" ++ w.s ! Acc ! Sg} ; ----AR

  monthAdv w = {s = "v" ++ w.s ! Loc ! Sg} ; ----AR

  --hungry_VP = UseComp (mkComp "lačen") ; --AE

}
