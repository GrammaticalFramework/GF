--# -path=.:../Common:alltenses

concrete StopsFin of Stops = open Prelude, CatFin, GodisLangFin, ParadigmsFin in {

lincat Stop = NP;

lin
Angered = sing_NP ["angeredia"];
AxelDahlstromsTorg = sing_NP ["axel_dahlstroms_torgia"];
Bergsjon = sing_NP ["bergsjönia"];
Biskopsgarden = sing_NP ["biskopsgardenia"];
Botaniska = singNP (nTalo ["botaniska"]);
Broplatsen =  sing_NP ["broplatsenia"];
Brunnsbotorget = sing_NP ["brunnsbotorgetia"];
Brunnsparken = sing_NP ["brunnsparkenia"];
Centralstationen = sing_NP ["centralstationenia"];
Chalmers = sing_NP ["chalmersia"];
Eriksberg = sing_NP ["eriksbergia"];
Frihamnen = sing_NP ["frihamnenia"];
FrolundaTorg = sing_NP ["frölunda_torgia"];
Gamlestadstorget = sing_NP ["gamlestadstorgetia"];
Gronsakstorget = sing_NP ["grönsakstorgetia"];
Guldheden = sing_NP ["guldhedenia"];
Hagakyrkan = sing_NP ["hagakyrkania"];
Harlanda = singNP (nTalo ["härlanda"]);
Hinnebacksgatan = sing_NP ["hinnebäcksgatania"];
HjBrantingsplatsen = sing_NP ["hjalmar_brantingsplatsenia"];
Jarntorget = sing_NP ["järntorgetia"];
Kalleback = sing_NP ["kallebäckia"];
Karralundsgatan = sing_NP ["kärralundsgatania"];
Klareberg = sing_NP ["klarebergia"]; --- ä
Klippan = sing_NP ["klippania"];
Korkarlensgata = singNP (nTalo ["körkarlens_gata"]);
Korsvagen = sing_NP ["korsvägenia"];
Kortedala = sing_NP ["kortedalaia"];
Kungssten = sing_NP ["kungsstenia"];
Lansmansgarden = sing_NP ["länsmansgardenia"];
LillaBommen = sing_NP ["lilla_bommenia"];
Lindholmen = sing_NP ["lindholmenia"];
Linneplatsen = sing_NP ["linnéplatsenia"];
LundbyStrand = sing_NP ["lundby_strandia"];
Mariaplan = sing_NP ["mariaplania"];
Marklandsgatan = sing_NP ["marklandsgatania"];
Nordstan = sing_NP ["nordstania"];
Olivedalsgatan = sing_NP ["olivedalsgatania"];
Olskrokstorget = sing_NP ["olskrokstorgetia"];
OstraSjukhuset = sing_NP ["östra_sjukhusetia"];
Pilbagsgatan = sing_NP  ["pilbågsgatania"];
Redbergsplatsen = sing_NP ["redbergsplatsenia"];
Rosenlund = sing_NP ["rosenlundia"];
Sahlgrenska = singNP (nTalo ["sahlgrenska"]);
Saltholmen = sing_NP ["saltholmenia"];
SanktSigfridsplan = sing_NP ["sankt_sigfrids_plania"];
Sannaplan = sing_NP ["sannaplania"];
Skogome = singNP (nTalo ["skogome"]);
Sorgardsskolan = sing_NP ["sorgardsskolania"];
Stigbergstorget = sing_NP ["stigbergstorgetia"];
Tagene = singNP (nTalo ["tagene"]);
Torp = sing_NP ["torpia"];
Tynnered = sing_NP ["tynneredia"];
Ullevi = singNP (nTalo ["ullevi"]);
Valand = sing_NP ["valandia"];
VasaViktoriagatan = sing_NP ["vasa_viktoriagatania"];
Vasaplatsen = sing_NP ["vasaplatsenia"];
WavrinskysPlats = sing_NP ["wavrinskys_platsia"];

oper

singNP : N -> NP = \n -> mkNP n singular ;

}
