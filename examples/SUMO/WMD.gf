abstract WMD = MidLevelOntology ** {

  -- An extremely toxic protein found in the seeds of the rosary pea. Its mechanism, symptoms, 
  -- and treatment are very similar to those of RicinToxin. 
  -- However, AbrinToxin is roughly 75 times more toxic than RicinToxin.
  fun AbrinToxin : Class ;
  fun AbrinToxin_Class : SubClass AbrinToxin (both Protein Toxin);

  -- A BiochemicalAgent that has been divided into particles so minute that
  -- they can be easily dispersed in the air and inhaled by Humans or Animals. 
  -- AerosolizedAgents tend to be more lethal and to affect a larger area.
  fun AerosolizedAgent : Class ;
  fun AerosolizedAgent_Class : SubClass AerosolizedAgent BiochemicalAgent ;

  -- Also known as weaponized anthrax. These are spores of BacillusAnthracis that 
  -- have been separated to the point that they can be dispersed in the air and 
  -- easily inhaled by crowds.
  fun AerosolizedBacillusAnthracis : Class ;
  fun AerosolizedBacillusAnthracis_Class : SubClass AerosolizedBacillusAnthracis (both AerosolizedAgent BacillusAnthracis);

  -- The disease has rarely been observed in humans, 
  -- but it can cause severe damage to the liver, 
  -- including cirrhosis and liver cancer, in a large number of animal species.
  fun Aflatoxicosis : Ind LifeThreateningDisease ;

  -- Toxins produced by fungi of the strains 
  -- Aspergillus Flavus and Aspergillus Parasiticus. 
  -- There are four varieties of Aflatoxin, viz. B1, B2, G1, and G2. 
  -- B1 is most common and most toxic.
  fun Aflatoxin : Class ;
  fun Aflatoxin_Class : SubClass Aflatoxin Mycotoxin ;

  -- The disease caused by BacillusAnthracis. 
  -- Victims of the disease may experience a brief, apparent recovery before death.
  fun Anthrax : Ind BacterialDisease ;

  -- A disease that attacks the immune system and that is caused by the HIVVirus. 
  -- Patients are usually infected through blood or semen.
  fun AquiredImmunoDeficiencySyndrome : Class ;
  fun AquiredImmunoDeficiencySyndrome_Class : SubClass AquiredImmunoDeficiencySyndrome DiseaseOrSyndrome ;

  -- Symptoms of the disease are flu_like in the initial stages. 
  -- As the disease progresses, symptoms include bleeding from the nose and gums and blood spots.
  fun ArgentinianHemorrhagicFever : Ind HemorrhagicFever ;

  -- A very toxic form of arsenic that is 2 and a half times denser than air.
  -- Victims who die after exposure to Arsine generally die from renal failure.
  fun Arsine : Class ;
  fun Arsine_Class : SubClass Arsine BloodAgent ;

  -- An anticholinergic agent.
  fun Atropine : Class ;
  fun Atropine_Class : SubClass Atropine BiologicallyActiveSubstance ;

  -- Stockpiled for a time by both NATO and the Warsaw Pact countries, 
  -- BZGas is a psychoactive agent that is heaver than air and
  -- reputedly ten times more powerful than LSD. 
  -- Effects of the gas are not well understood, but they include vomiting, 
  -- lethargy, loss of motor co_ordination, and cognitive incapacity.
  fun BZGas : Class ;
  fun BZGas_Class : SubClass BZGas IncapacitatingAgent ;

  -- The Bacterium which causes the disease Anthrax. 
  -- Humans may become infected with Anthrax via contamination
  -- of a wound or by inhaling the Bacterium. When it is inhaled, 
  -- the disease is often fatal if not treated early (see InhalationalAnthrax).
  fun BacillusAnthracis : Class ;
  fun BacillusAnthracis_Class : SubClass BacillusAnthracis BacterialAgent ;

  -- A Bacterium that is closely related to and often found near BacillusAnthracis,
  -- the Bacterium that causes Anthrax. BacillusCereus causes two forms of food poisoning,
  -- one characterized by diarrhea and the other by vomiting. In most cases the disease is not
  -- life_threatening.
  fun BacillusCereus : Class ;
  fun BacillusCereus_Class : SubClass BacillusCereus BacterialAgent ;

  -- A common topical antibiotic.
  fun Bacitracin : Class ;
  fun Bacitracin_Class : SubClass Bacitracin TopicalAntibiotic ;

  -- BiologicalAgents that are instances of Bacterium.
  fun BacterialAgent : Class ;
  fun BacterialAgent_Class : SubClass BacterialAgent (both Bacterium ToxicOrganism);

  -- A Toxin produced by some species of Frogs.
  fun Batrachotoxin : Class ;
  fun Batrachotoxin_Class : SubClass Batrachotoxin (both BodySubstance Toxin);

  -- A BiologicalAgent or a ChemicalAgent.
  fun BiochemicalAgent : Class ;
  fun BiochemicalAgent_Class : SubClass BiochemicalAgent BiologicallyActiveSubstance ;

  -- Attacks in which a BiochemicalWeapon is used against an Organism.
  fun BiochemicalAttack : Class ;
  fun BiochemicalAttack_Class : SubClass BiochemicalAttack Attack ;

  -- A WeaponOfMassDestruction that is either a BiologicalWeapon or a ChemicalWeapon,
  -- i.e. not a RadioactiveWeapon.
  fun BiochemicalWeapon : Class ;
  fun BiochemicalWeapon_Class : SubClass BiochemicalWeapon WeaponOfMassDestruction ;

  -- A naturally occurring Substance, or a synthetic analogue of 
  -- such a substance or an Organism that is capable of 
  -- inflicting severe harm on other Organisms. 
  -- All BiologicalWeapons contain a BiologicalAgent.
  fun BiologicalAgent : Class ;
  fun BiologicalAgent_Class : SubClass BiologicalAgent BiochemicalAgent ;

  -- Weapons which contain a sample of ToxicOrganism or a BiologicallyActiveSubstance 
  -- that is produced by a ToxicOrganism (or a synthetic analogue of the latter).
  fun BiologicalWeapon : Class ;
  fun BiologicalWeapon_Class : SubClass BiologicalWeapon BiochemicalWeapon ;

  -- ChemicalAgents that affect eyes, lungs, and skin. 
  -- BlisterAgents are so named because they cause blistering of the skin. 
  -- They may also cause blindness and respiratory damage.
  fun BlisterAgent : Class ;
  fun BlisterAgent_Class : SubClass BlisterAgent ChemicalAgent ;

  -- A CompoundSubstance that prevents the normal use of oxygen by bodily tissues. 
  -- BloodAgents are highly volatile and disperse easily in the open air.
  fun BloodAgent : Class ;
  fun BloodAgent_Class : SubClass BloodAgent ChemicalAgent ;

  -- Symptoms of the disease are flu_like in the initial stages. 
  -- As the disease progresses, symptoms include bleeding from the nose and gums and blood spots.
  fun BolivianHemorrhagicFever : Ind HemorrhagicFever ;

  -- The Bacterium that causes Pertussis.
  fun BordetellaPertussis : Class ;
  fun BordetellaPertussis_Class : SubClass BordetellaPertussis BacterialAgent ;

  -- A Toxin produced by the bacterium ClostridiumBotulinum. It paralyzes muscles if ingested, and one billionth of a pound is sufficient to cause death.
  fun BotulinumToxin : Class ;
  fun BotulinumToxin_Class : SubClass BotulinumToxin (both BodySubstance (both LifeThreateningAgent Toxin));

  -- A paralytic disease caused by BotulinumToxin, 
  -- a Toxin produced by the bacterium ClostridiumBotulinum.
  fun Botulism : Ind (both BacterialDisease (both LifeThreateningDisease VaccinatableDisease)) ;

  -- Symptoms of the disease are flu_like in the initial stages. 
  -- As the disease progresses, symptoms include bleeding from the nose and gums and blood spots.
  fun BrazilianHemorrhagicFever : Ind HemorrhagicFever ;

  -- The Bacterium which is responsible for the disease Brucellosis. 
  -- This class covers Brucella Abortus (which infects humans and cattle), 
  -- Brucella Melitensis (which infects sheep, goats, and humans), 
  -- and Brucella Suis (which infects pigs).
  fun BrucellaBacterium : Class ;
  fun BrucellaBacterium_Class : SubClass BrucellaBacterium BacterialAgent ;

  -- Infectious disease caused by BrucellaBacterium. 
  -- It is also known as undulant fever and malta fever, 
  -- depending on the strain of BrucellaBacterium that is reponsible for the infection.
  fun Brucellosis : Ind BacterialDisease ;

  -- A variant of the Plague which results in large swellings, called buboes.
  fun BubonicPlague : Ind (both BacterialDisease VaccinatableDisease) ;

  -- The Bacterium that causes the disease Glanders. 
  -- It is transmitted to humans by direct contact with infected animals. 
  -- The bacteria enter the body through the skin and the mucosal surfaces of the eyes and nose.
  fun BurkholderiaMallei : Class ;
  fun BurkholderiaMallei_Class : SubClass BurkholderiaMallei BacterialAgent ;

  -- Formerly known as Pseudomonas Pseudomallei, this is the Bacterium that causes Melioidosis.
  fun BurkholderiaPseudomallei : Class ;
  fun BurkholderiaPseudomallei_Class : SubClass BurkholderiaPseudomallei BacterialAgent ;

  fun CSGas : Class ;
  fun CSGas_Class : SubClass CSGas IncapacitatingAgent ;

  -- Synthetic compounds that are not an analogue of anything occurring naturally
  -- and that can result in serious burns, paralysis, and death to Organisms.
  fun ChemicalAgent : Class ;
  fun ChemicalAgent_Class : SubClass ChemicalAgent (both BiochemicalAgent (both BiologicallyActiveSubstance CompoundSubstance));

  -- Weapons that damage or destroy Organisms by means of a ChemicalAgent.
  fun ChemicalWeapon : Class ;
  fun ChemicalWeapon_Class : SubClass ChemicalWeapon BiochemicalWeapon ;

  -- The Bacterium that causes Psittacosis.
  fun ChlamydiaPsittaci : Class ;
  fun ChlamydiaPsittaci_Class : SubClass ChlamydiaPsittaci BacterialAgent ;

  -- A poisonous gas.
  fun ChlorineGas : Class ;
  fun ChlorineGas_Class : SubClass ChlorineGas ChokingAgent ;

  -- Poisonous gas which has effects similar to tear gas. 
  -- If ingested, the gas causes gastroenteritis.
  fun Chloropicrin : Class ;
  fun Chloropicrin_Class : SubClass Chloropicrin ChokingAgent ;

  -- ChemicalAgents designed to cause the lungs to fill with fluid, 
  -- which can result in the victim choking to death. 
  -- ChokingAgents are heavy gases that are less effective than
  -- other ChemicalAgents because they can be easily dissipated by a slight wind.
  fun ChokingAgent : Class ;
  fun ChokingAgent_Class : SubClass ChokingAgent ChemicalAgent ;

  -- A diarrheal disease that is caused by a Toxin secreted by the Bacterium VibrioCholera. 
  -- Death may result from severe dehydration caused by the disease. 
  -- There is little if any fever and abdominal pain with this illness.
  fun Cholera : Ind (both BacterialDisease (both VaccinatableDisease LifeThreateningDisease)) ;

  -- An OralAntibiotic that is often used to prevent complications from 
  -- AquiredImmunoDeficiencySyndrome. Recommended for prevention of inhalational
  -- Anthrax in subjects who may have been exposed to aeresolized BacillusAnthracis.
  fun Ciprofloxacin : Class ;
  fun Ciprofloxacin_Class : SubClass Ciprofloxacin OralAntibiotic ;

  -- The Bacterium that produces BotulinumToxin.
  fun ClostridiumBotulinum : Class ;
  fun ClostridiumBotulinum_Class : SubClass ClostridiumBotulinum BacterialAgent ;

  -- Bacterium often found in the intestines of Animals. 
  -- Ingesting this Bacterium can result in Perfringens food poisoning, 
  -- which can attack internal organs and lead to gangrene.
  fun ClostridiumPerfringens : Class ;
  fun ClostridiumPerfringens_Class : SubClass ClostridiumPerfringens BacterialAgent ;

  -- The Bacterium that causes the disease Tetanus.
  fun ClostridiumTetani : Class ;
  fun ClostridiumTetani_Class : SubClass ClostridiumTetani BacterialAgent ;

  -- A recently discovered Fungus that is related to 
  -- CoccidioidesImmitis and that also causes RiftValleyFever.
  fun CoccidiodesPosadasii : Class ;
  fun CoccidiodesPosadasii_Class : SubClass CoccidiodesPosadasii (both FungalAgent LifeThreateningAgent);

  -- A Fungus that causes RiftValleyFever, 
  -- an illness whose symptoms include fever, chills, 
  -- and coughing and which may result in death.
  fun CoccidioidesImmitis : Class ;
  fun CoccidioidesImmitis_Class : SubClass CoccidioidesImmitis (both FungalAgent LifeThreateningAgent);

  -- A class of neurotoxins that are produced by the Pacific cone snails. 
  -- The lethality of these toxins varies widely, and it would be impractical to
  -- manufacture them on a large scale.
  fun Conotoxin : Class ;
  fun Conotoxin_Class : SubClass Conotoxin (both BodySubstance (both CompoundSubstance Toxin));

  -- The Bacterium that secretes a Toxin that causes Diphtheria.
  fun CorynebacteriumDiphtheriae : Class ;
  fun CorynebacteriumDiphtheriae_Class : SubClass CorynebacteriumDiphtheriae BacterialAgent ;

  -- The Bacterium that causes QFever.
  fun CoxiellaBurnetii : Class ;
  fun CoxiellaBurnetii_Class : SubClass CoxiellaBurnetii RickettsialAgent ;

  -- A widespread disease which was initially identified in 
  -- the Crimea and the Congo, which accounts for its name. 
  -- The disease has a high mortality rate for humans, 
  -- but infection of humans occurs infrequently.
  fun CrimeanCongoHemorrhagicFever : Ind (both HemorrhagicFever LifeThreateningDisease) ;

  -- The Virus that causes CrimeanCongoHemorrhagicFever.
  fun CrimeanCongoHemorrhagicFeverVirus : Class ;
  fun CrimeanCongoHemorrhagicFeverVirus_Class : SubClass CrimeanCongoHemorrhagicFeverVirus ViralAgent ;

  -- Used in mining and metalurgy, it is very similar to HydrogenCyanide. 
  -- However, it is less volatile than HydrogenCyanide, and its effects on the eyes, 
  -- respiratory tract, and lungs is similar to Phosgene and ChorineGas.
  fun CyanogenChloride : Class ;
  fun CyanogenChloride_Class : SubClass CyanogenChloride BloodAgent ;

  -- Integrating a WeaponOfMassDestruction with a conventional weapon, 
  -- so that the former can be delivered to its target.
  fun DeliveringWeaponOfMassDestruction : Class ;
  fun DeliveringWeaponOfMassDestruction_Class : SubClass DeliveringWeaponOfMassDestruction Making ;

  -- The less serious disease caused by the DengueFeverVirus. 
  -- Symptoms include fever and severe headache.
  fun DengueFever : Ind ViralDisease ;

  -- Any of four related but distinct virus serotypes that are carried by 
  -- the Aedes Aegypti mosquito and that can cause DengueFever and DengueHemorrhagicFever.
  fun DengueFeverVirus : Class ;
  fun DengueFeverVirus_Class : SubClass DengueFeverVirus ViralAgent ;

  -- The more serious disease caused by the & %DengueFeverVirus. 
  -- Symptoms include bleeding from the nose, mouth, and gums, and 
  -- excessive thirst and difficulty breathing.
  fun DengueHemorrhagicFever : Ind (both HemorrhagicFever LifeThreateningDisease) ;

  -- Positioning a chemical, biological or radioactive weapon for 
  -- the purpose of bringing about harm of some kind.
  fun DeployingWeaponOfMassDestruction : Class ;
  fun DeployingWeaponOfMassDestruction_Class : SubClass DeployingWeaponOfMassDestruction (both IntentionalProcess Putting);

  -- Making instances of WeaponOfMassDestruction.
  fun DevelopingWeaponOfMassDestruction : Class ;
  fun DevelopingWeaponOfMassDestruction_Class : SubClass DevelopingWeaponOfMassDestruction Making ;

  -- A Micotoxin that is found in grains and products made from grains. 
  -- Symptoms include diarrhea, necrotic lesions, and hemorrhaging.
  fun Diacetoxyscirpenol : Class ;
  fun Diacetoxyscirpenol_Class : SubClass Diacetoxyscirpenol Mycotoxin ;

  -- A chelating agent often used to treat Lewisite, as well as Lead Poisoning.
  fun Dimercaprol : Class ;
  fun Dimercaprol_Class : SubClass Dimercaprol BiologicallyActiveSubstance ;

  -- A poisonous gas that irritates the lungs and that is similar to Phosgene.
  fun Diphosgene : Class ;
  fun Diphosgene_Class : SubClass Diphosgene ChokingAgent ;

  -- The disease can infect almost any mucous membrane. It causes fever, chills, headache, and nausea. 
  -- In severe cases it may affect heart rhythm and motor coordination.
  fun Diphtheria : Ind (both BacterialDisease LifeThreateningDisease) ;

  -- Dismantling a Weapon of Mass Destruction, i.e. destroying the weapon or removing it from active deployment.
  fun DismantlingWeaponOfMassDestruction : Class ;
  fun DismantlingWeaponOfMassDestruction_Class : SubClass DismantlingWeaponOfMassDestruction IntentionalProcess ;

  -- An OralAntibiotic that is used to treat a wide variety of BacterialDiseases, 
  -- including traveler's diarrhea. Recommended for prevention of inhalational Anthrax 
  -- in subjects who may have been exposed to aeresolized BacillusAnthracis.
  fun Doxycycline : Class ;
  fun Doxycycline_Class : SubClass Doxycycline OralAntibiotic ;

  -- In mile cases, symptoms are flu_like. In more severe cases, 
  -- the disease may result in encephalitis, coma, and death.
  fun EasternEquineEncephalitis : Ind (both ViralDisease LifeThreateningDisease) ;

  -- The Virus that causes EasternEquineEncephalitis. 
  -- Mosquitoes carry this virus, which is then transmitted to humans, when the insects bite them.
  fun EasternEquineEncephalitisVirus : Class ;
  fun EasternEquineEncephalitisVirus_Class : SubClass EasternEquineEncephalitisVirus ViralAgent ;

  -- A very serious HemorrhagicFever, which often results in death.
  fun EbolaHemorrhagicFever : Ind HemorrhagicFever ;

  -- A Virus that causes a form of hemorrhagic fever.
  fun EbolaVirus : Class ;
  fun EbolaVirus_Class : SubClass EbolaVirus ViralAgent ;

  -- A Toxin produced by the bacterium ClostridiumPerfringens 
  -- that causes a mild form of food poisoning that lasts one to two days.
  fun EpsilonToxin : Class ;
  fun EpsilonToxin_Class : SubClass EpsilonToxin (both BodySubstance Toxin);

  -- One of hundreds of strains of the Escherichia Coli Bacterium. 
  -- This strain lives in the intestines of healthy cattle, 
  -- but it can cause severe illness when ingested by humans.
  fun EscherichiaColi0157H7 : Class ;
  fun EscherichiaColi0157H7_Class : SubClass EscherichiaColi0157H7 BacterialAgent ;

  -- A Virus that that is responsible for a hemorrhagic fever found in South America.
  fun FlexalVirus : Class ;
  fun FlexalVirus_Class : SubClass FlexalVirus ViralAgent ;

  -- A Virus that is smaller than YellowFeverVirus.
  fun FootAndMouthVirus : Class ;
  fun FootAndMouthVirus_Class : SubClass FootAndMouthVirus ViralAgent ;

  -- The Bacterium that causes the disease Tularemia. Also known as Pasturella Tularensis.
  -- The Bacterium has two strains, Jellison type A (F. tularensis biovar tularensis) and type B 
  -- strains (F tularensis biovar palaearctica), and it is infectious with a dose as small as 
  -- 50 cells per milliliter.
  fun FrancisellaTularensis : Class ;
  fun FrancisellaTularensis_Class : SubClass FrancisellaTularensis BacterialAgent ;

  -- Any BiologicalAgent that is also a Fungus.
  fun FungalAgent : Class ;
  fun FungalAgent_Class : SubClass FungalAgent (both Fungus ToxicOrganism);

  -- One of the G_series nerve agents.
  fun GF : Class ;
  fun GF_Class : SubClass GF GSeriesNerveAgent ;

  -- Earliest sort of NerveAgent (developed in the 1930's).
  -- This subclass of NerveAgents tends to be less persistent, 
  -- more volatile, and less toxic than VSeriesNerveAgents, 
  -- which were developed later. GSeriesNerveAgents include Tabun, Sarin, and Soman.
  fun GSeriesNerveAgent : Class ;
  fun GSeriesNerveAgent_Class : SubClass GSeriesNerveAgent NerveAgent ;

  -- Inflammation of the gastrointestinal tract, i.e. 
  -- the stomach and small and large intestines. 
  -- The symptoms include diarrhea, vomiting, and abdominal pain.
  fun Gastroenteritis : Ind DiseaseOrSyndrome ;

  -- The class of Organisms that are not found originally in nature, but are produced 
  -- in a laboratory by manipulating the genes of naturally occurring organisms.
  fun GeneticallyEngineeredOrganism : Class ;
  fun GeneticallyEngineeredOrganism_Class : SubClass GeneticallyEngineeredOrganism Organism ;

  -- A Bacterium that causes Gastroenteritis. It is present in many streams and lakes,
  -- and it is carried by beavers and other animals.
  fun GiardiaLamblia : Class ;
  fun GiardiaLamblia_Class : SubClass GiardiaLamblia BacterialAgent ;

  -- A disease caused by BurkholderiaMallei. Primary symptoms of Glanders include fever,
  -- muscle aches, chest pain, muscle tightness, and headache. Additional symptoms include 
  -- tearing of the eyes, light sensitivity, and diarrhea. There is no vaccine for this disease.
  fun Glanders : Ind BacterialDisease ;

  -- A disease caused by the bacterium NeisseriaGonorrhoeae.
  fun Gonorrhea : Ind BacterialDisease ;

  -- The Virus that causes VenezuelanHemorrhagicFever.
  fun GuanaritoVirus : Class ;
  fun GuanaritoVirus_Class : SubClass GuanaritoVirus ViralAgent ;

  -- The Virus that causes AquiredImmunoDeficiencySyndrome.
  fun HIVVirus : Class ;
  fun HIVVirus_Class : SubClass HIVVirus ViralAgent ;

  -- A severe syndrome that affects multiple organs of the body. Typically, 
  -- the vascular system is damaged, and the body's ability to regulate itself is impaired.
  fun HemorrhagicFever : Class ;
  fun HemorrhagicFever_Class : SubClass HemorrhagicFever ViralDisease ;

  -- A Virus found in Australia and Papua New Guinea that infects humans and horses.
  -- The natural host of the virus appears to be fruit bats. Not much is known about 
  -- the disease caused by the HendraVirus, but it seems to begin with fever and then
  -- progress to drowsiness and coma.
  fun HendraVirus : Class ;
  fun HendraVirus_Class : SubClass HendraVirus ViralAgent ;

  -- A class of ViralDiseases that attack the liver.
  fun Hepatitis : Class ;
  fun Hepatitis_Class : SubClass Hepatitis ViralDisease ;

  -- A disease that attacks the liver and causes jaundice as well as flu_like symptoms. 
  -- There is no chronic infection with this disease, and anyone who has recovered from 
  -- it will have life_time immunity to the disease.
  fun HepatitisA : Ind (both Hepatitis VaccinatableDisease) ;

  -- The Virus that causes HepatitisA.
  fun HepatitisAVirus : Class ;
  fun HepatitisAVirus_Class : SubClass HepatitisAVirus HepatitisVirus ;

  -- Like other forms of hepatitis, HepatitisB attacks the liver of the victim. 
  -- The disease may result in death from chronic liver disease.
  fun HepatitisB : Ind (both Hepatitis (both VaccinatableDisease LifeThreateningDisease)) ;

  -- The Virus that causes HepatitisB.
  fun HepatitisBVirus : Class ;
  fun HepatitisBVirus_Class : SubClass HepatitisBVirus HepatitisVirus ;

  -- Like other forms of hepatitis, HepatitisC attacks the liver of the victim.
  -- The disease often results in chronic infection and chronic liver disease, 
  -- although the mortality rate of this disease is lower than that of HepatitisB. 
  -- Most cases of HepatitisC are due to injections of illegal drugs.
  fun HepatitisC : Ind (both Hepatitis LifeThreateningDisease) ;

  -- The Virus that causes HepatitisC.
  fun HepatitisCVirus : Class ;
  fun HepatitisCVirus_Class : SubClass HepatitisCVirus HepatitisVirus ;

  -- Viruses that cause Hepatitis.
  fun HepatitisVirus : Class ;
  fun HepatitisVirus_Class : SubClass HepatitisVirus ViralAgent ;

  -- The disease caused by HerpesBVirus.
  fun HerpesB : Ind (both ViralDisease LifeThreateningDisease) ;

  -- A virus which is carried by Macaque monkeys and which does not harm these primates,
  -- but which causes the very serious HerpesB disease in humans.
  fun HerpesBVirus : Class ;
  fun HerpesBVirus_Class : SubClass HerpesBVirus ViralAgent ;

  -- A ChemicalAgent that was widely used by the Nazis in extermination camps. 
  -- A low dose can cause headache, disorientation, and vomiting, while a high dose
  -- can rapidly result in respiratory and/or cardiac arrest.
  fun HydrogenCyanide : Class ;
  fun HydrogenCyanide_Class : SubClass HydrogenCyanide BloodAgent ;

  -- ChemicalAgents that are designed to cause temporary disability in victims.
  fun IncapacitatingAgent : Class ;
  fun IncapacitatingAgent_Class : SubClass IncapacitatingAgent ChemicalAgent ;

  -- A contagious disease caused by a large number of Viruses.
  fun Influenza : Class ;
  fun Influenza_Class : SubClass Influenza (both VaccinatableDisease ViralDisease);

  -- Almost 100% fatal if left untreated for more than 24 hours.
  fun InhalationalAnthrax : Ind (both BacterialDisease LifeThreateningDisease) ;

  -- Most people who are infected with this disease will suffer only mild symptoms.
  -- However, in severe cases, the disease attacks the central nervous system and may result in death.
  fun JapaneseEncephalitis : Ind (both ViralDisease (both LifeThreateningDisease VaccinatableDisease)) ;

  -- The Virus that causes JapaneseEncephalitis. 
  -- Mosquitoes in agricultural areas of Asia carry this virus, 
  -- which is then transmitted to humans, when the insects bite them.
  fun JapaneseEncephalitisVirus : Class ;
  fun JapaneseEncephalitisVirus_Class : SubClass JapaneseEncephalitisVirus ViralAgent ;

  -- This Virus derives its name from the Junin area of Argentina,
  -- where occurrences have so far been restricted.
  fun JuninVirus : Class ;
  fun JuninVirus_Class : SubClass JuninVirus ViralAgent ;

  -- A cephalosporin for treating bacterial infections.
  fun Keflex : Class ;
  fun Keflex_Class : SubClass Keflex OralAntibiotic ;

  -- A tick_borne encephalitis that is largely restricted to the Shimoga and Kanara district of Karnataka, India.
  fun KyasanurForestDisease : Ind TickBorneEncephalitis ;

  -- The Virus that carries KyasanurForestDisease.
  fun KyasanurForestDiseaseVirus : Class ;
  fun KyasanurForestDiseaseVirus_Class : SubClass KyasanurForestDiseaseVirus TickBorneEncephalitisVirus ;

  -- Encephalitis caused by the LaCrosseVirus. In its most severe cases, 
  -- the disease may result in seizure and/or coma, but most infections are relatively mild.
  fun LaCrosseEncephalitis : Ind ViralDisease ;

  -- The Virus that causes LaCrossEncephalitis. It is carried by the 
  -- Aedes Triseriatus mosquito, as well as various woodlands rodents.
  fun LaCrosseVirus : Class ;
  fun LaCrosseVirus_Class : SubClass LaCrosseVirus ViralAgent ;

  -- A viral, rodent_carried disease found in West Africa. 
  -- The symptoms of the disease are wide_ranging and can be life_threatening.
  -- The disease can lead to permanent neurological problems, including deafness.
  fun LassaFever : Ind (both ViralDisease LifeThreateningDisease) ;

  -- The Virus that causes LassaFever.
  fun LassaVirus : Class ;
  fun LassaVirus_Class : SubClass LassaVirus ViralAgent ;

  -- The Bacterium that causes Legionellosis, which is known as LegionnairesDisease
  -- (when it infects the lungs) and PontiacFever (when it doesn't affect the lungs).
  fun Legionella : Class ;
  fun Legionella_Class : SubClass Legionella BacterialAgent ;

  -- The disease caused by the Bacterium Legionella.
  fun Legionellosis : Ind BacterialDisease ;

  -- The most severe form of Legionellosis. It is characterized by pneumonia.
  fun LegionnairesDisease : Ind (both BacterialDisease LifeThreateningDisease) ;

  -- Besides being a BlisterAgent, Lewisite causes systemic poisoning. 
  -- Its symptoms include pulmonary edema, diarrhea, reduced body temperature and blood pressure. 
  -- When large quantities of Lewisite are inhaled, it can cause death in as little as 10 minutes.
  fun Lewisite : Class ;
  fun Lewisite_Class : SubClass Lewisite BlisterAgent ;

  -- A BiochemicalAgent that has been observed to cause the death of Humans.
  fun LifeThreateningAgent : Class ;
  fun LifeThreateningAgent_Class : SubClass LifeThreateningAgent BiochemicalAgent ;

  -- A DiseaseOrSyndrome that has been observed to cause the death of Humans.
  fun LifeThreateningDisease : Class ;
  fun LifeThreateningDisease_Class : SubClass LifeThreateningDisease DiseaseOrSyndrome ;

  -- The only rickettsial disease which is capable of causing widespread human epidemics. 
  -- The initial symptoms of the disease are flu_like, but on the fifth or sixth day of infection
  -- a macular eruption appears on the upper trunk of the body and then spreads to the rest of the body.
  fun LouseBorneTyphus : Ind BacterialDisease ;

  -- The Virus that causes BolivianHemorrhagicFever.
  fun MachupoVirus : Class ;
  fun MachupoVirus_Class : SubClass MachupoVirus ViralAgent ;

  -- A disease that destroys red blood cells. It is caused by a Microorganism (see MalarialPlasmodium) 
  -- that is carried by the Anopheles Gambiae mosquito.
  fun Malaria : Ind (both InfectiousDisease LifeThreateningDisease) ;

  -- Any of four strains of Plasmodium that are known to cause Malaria.
  fun MalarialPlasmodium : Class ;
  fun MalarialPlasmodium_Class : SubClass MalarialPlasmodium (both BiologicalAgent Microorganism);

  -- Extremely serious disease caused by the MarburgVirus. Symptoms include high fever,
  -- myalgias, vomiting, and diarrhea. Typically involves major organs, including the central nervous system.
  fun MarburgDisease : Ind (both ViralDisease LifeThreateningDisease) ;

  -- The Virus that causes MarburgDisease.
  fun MarburgVirus : Class ;
  fun MarburgVirus_Class : SubClass MarburgVirus ViralAgent ;

  -- Also known as Whitmore's disease, it is similar to Glanders. Unlike Glanders, however, 
  -- the disease is found predominantly in Southeast Asia. The disease may be a localized infection or 
  -- it may involve the bloodstream, the lungs or other organs of the body.
  fun Melioidosis : Ind BacterialDisease ;

  -- A Virus that is infectious to rabbits and may cause blindness and death in these Rodents.
  fun Mixomatosis : Class ;
  fun Mixomatosis_Class : SubClass Mixomatosis ViralAgent ;

  -- A viral disease that is very similar to Smallpox. It is seen sporadically in parts of Africa.
  fun Monkeypox : Ind ViralDisease ;

  -- The Virus that causes Monkeypox.
  fun MonkeypoxVirus : Class ;
  fun MonkeypoxVirus_Class : SubClass MonkeypoxVirus ViralAgent ;

  -- A BlisterAgent that was commonly used in World War I to incapacitate troops. 
  -- It is chemically stable, persistent, and is capable of attacking the eyes, the skin, 
  -- and the respiratory tract. There is no accepted treatment or preventive measure for MustardGas.
  fun MustardGas : Class ;
  fun MustardGas_Class : SubClass MustardGas BlisterAgent ;

  -- The Bacterium that causes Tuberculosis.
  fun MycobacteriumTuberculosis : Class ;
  fun MycobacteriumTuberculosis_Class : SubClass MycobacteriumTuberculosis BacterialAgent ;

  -- A Toxin that is produced by a FungalAgent.
  fun Mycotoxin : Class ;
  fun Mycotoxin_Class : SubClass Mycotoxin (both BodySubstance Toxin);

  -- A BacterialDisease caused by StreptococcusA where the Bacterium rapidly attacks soft tissue.
  fun NecrotizingFaciitis : Ind (both BacterialDisease LifeThreateningDisease) ;

  -- The Bacterium that causes Gonorrhea.
  fun NeisseriaGonorrhoeae : Class ;
  fun NeisseriaGonorrhoeae_Class : SubClass NeisseriaGonorrhoeae BacterialAgent ;

  -- These ChemicalAgents are easily absorbed into the mucous membranes of humans and inactivate 
  -- the essential enzyme acetylcholinesterase, bringing about paralysis of the respiratory and central nervous systems.
  fun NerveAgent : Class ;
  fun NerveAgent_Class : SubClass NerveAgent ChemicalAgent ;

  -- Closely related to HendraVirus. Like the HendraVirus, the natural host of NipahVirus
  -- appears to be fruit bats. Not much is known about the disease, but its symptoms include high fever, 
  -- muscle pain, and eventually encephalitis, convulsions, and coma.
  fun NipahVirus : Class ;
  fun NipahVirus_Class : SubClass NipahVirus ViralAgent ;

  -- A kind of mustard gas. Also known as HN.
  fun NitrogenMustardGas : Class ;
  fun NitrogenMustardGas_Class : SubClass NitrogenMustardGas MustardGas ;

  -- Facilities where NuclearWeapons are built.
  fun NuclearWeaponProductionFacility : Class ;
  fun NuclearWeaponProductionFacility_Class : SubClass NuclearWeaponProductionFacility WMDWeaponsProductionFacility ;

  -- Research facilities that perform research on technology related to NuclearWeapons.
  fun NuclearWeaponResearchFacility : Class ;
  fun NuclearWeaponResearchFacility_Class : SubClass NuclearWeaponResearchFacility WMDWeaponsResearchFacility ;

  -- An Antibiotic that is administered orally, e.g. Penicillin.
  fun OralAntibiotic : Class ;
  fun OralAntibiotic_Class : SubClass OralAntibiotic Antibiotic ;

  -- The syndrome where some or all of an Animal's muscles cannot be moved voluntarily.
  fun Paralysis : Ind DiseaseOrSyndrome ;

  -- A very serious disease requiring immediate medical attention. There is no vaccine for this disease.
  fun ParalyticShellfishPoisoning : Ind LifeThreateningDisease ;

  -- An ingestible antibiotic which kills many kinds of bacteria.
  fun Penicillin : Class ;
  fun Penicillin_Class : SubClass Penicillin OralAntibiotic ;

  -- The BacterialDisease caused by BordetellaPertussis. 
  -- Its symptoms include severe coughing (hence the colloquial name of whooping cough) 
  -- and flu-like symptoms.
  fun Pertussis : Ind (both BacterialDisease VaccinatableDisease) ;

  -- A colorless, extremely toxic gas. It is regarded as the most dangerous of the ChemicalAgents. 
  -- Deaths resulting from exposure to this ChemicalAgent generally occur in 24 to 48 hours.
  fun Phosgene : Class ;
  fun Phosgene_Class : SubClass Phosgene ChokingAgent ;

  -- One of the most painful and destructive chemical compounds in existence. Recovery from this ChemicalAgent requires one to three months.
  fun PhosgeneOxime : Class ;
  fun PhosgeneOxime_Class : SubClass PhosgeneOxime BlisterAgent ;

  -- The disease caused by the Bacterium YersiniaPestis. Plague has two forms depending on
  -- the location of the infection within the body, BubonicPlague and PneumonicPlague.
  fun Plague : Ind (both BacterialDisease VaccinatableDisease) ;

  -- One of four strains of Plasmodium that are known to cause Malaria. 
  -- It can cause severe anemia and kidney failure or it can constrict 
  -- small blood vessels and cause cerebral malaria.
  fun PlasmodiumFalciparum : Class ;
  fun PlasmodiumFalciparum_Class : SubClass PlasmodiumFalciparum MalarialPlasmodium ;

  -- Also known as pulmonary plague, a variant of the Plague which attacks 
  -- the lungs and is spread between humans by oral bodily fluids.
  fun PneumonicPlague : Ind (both BacterialDisease VaccinatableDisease) ;

  -- A flu_like illness which is caused by Legionella, but which does not involve pneumonia.
  fun PontiacFever : Ind BacterialDisease ;

  -- A serious disease caused by ChlamydiaPsittaci that affects both birds and humans. 
  -- In humans the symptoms include fever, chills, headache, muscle aches, and a dry cough. 
  -- The disease may give rise to pneumonia in extreme cases.
  fun Psittacosis : Ind BacterialDisease ;

  -- A substance that has been shown to protect lower primates from the lethal effects of Soman. 
  -- Although there is no proof that it does the same for humans, it was administered to soldiers in the Gulf War.
  fun PyridostigmineBromide : Class ;
  fun PyridostigmineBromide_Class : SubClass PyridostigmineBromide BiologicallyActiveSubstance ;

  -- A disease caused by the rickettsia CoxiellaBurnetii. Causes headache, chills, coughing, hallucinations, 
  -- fever up to 104 degrees, facial pain, speech impairment, heart inflammation and congestive heart failure.
  fun QFever : Ind BacterialDisease ;

  -- Conducting research on the development of Weapons of Mass Destruction.
  fun ResearchingWeaponOfMassDestruction : Class ;
  fun ResearchingWeaponOfMassDestruction_Class : SubClass ResearchingWeaponOfMassDestruction Investigating ;

  -- An extremely toxic protein found in the castor bean plant (ricinus communis). 
  -- It is 200 times more toxic than cyanide, and it has no known antidote, and it causes vomiting, high fever, weakness, and death.
  fun RicinToxin : Class ;
  fun RicinToxin_Class : SubClass RicinToxin (both Protein Toxin);

  -- The Bacterium that causes LouseBorneTyphus.
  fun RickettsiaProwazekii : Class ;
  fun RickettsiaProwazekii_Class : SubClass RickettsiaProwazekii RickettsialAgent ;

  -- The Bacterium that causes RockyMountainSpottedFever.
  fun RickettsiaRickettsii : Class ;
  fun RickettsiaRickettsii_Class : SubClass RickettsiaRickettsii RickettsialAgent ;

  -- BiologicalAgents that are rickettsial organisms, i.e. gram_negative bacteria that infect mammals and arthropods.
  fun RickettsialAgent : Class ;
  fun RickettsialAgent_Class : SubClass RickettsialAgent BacterialAgent ;

  -- A ViralDisease that causes chills, bleeding, and stupor.
  fun RiftValleyFever : Class ;
  fun RiftValleyFever_Class : SubClass RiftValleyFever ViralDisease ;

  -- A very serious disease that is caused RickettsiaRickettsii, which is carried by ticks. 
  -- The most distinctive symptom of the disease is a rash of black dots.
  fun RockyMountainSpottedFever : Ind (both BacterialDisease LifeThreateningDisease) ;

  -- There are three types of Rotavirus: Group A, Group B, and Group C. They cause an acute form of gastroenteritis, known as RotavirusGastroenteritis.
  fun Rotavirus : Class ;
  fun Rotavirus_Class : SubClass Rotavirus ViralAgent ;

  -- A disease caused by instances of Rotavirus, and characterized by vomiting, diarrhea, and fever.
  fun RotavirusGastroenteritis : Ind ViralDisease ;

  -- The Virus that causes BrazilianHemorrhagicFever.
  fun SabiaVirus : Class ;
  fun SabiaVirus_Class : SubClass SabiaVirus ViralAgent ;

  -- In mild cases, symptoms are flu_like. In more severe cases, symptoms may include disorientation, coma, tremors, hemorrhage, and convulsions.
  fun SaintLouisEncephalitis : Ind (both ViralDisease LifeThreateningDisease) ;

  -- The Virus that causes SaintLouisEncephalitis. Mosquitoes carry this virus, 
  -- which is then transmitted to humans, when the insects bite them.
  fun SaintLouisEncephalitisVirus : Class ;
  fun SaintLouisEncephalitisVirus_Class : SubClass SaintLouisEncephalitisVirus ViralAgent ;

  -- Causes a less severe illness than SalmonellaTyphimurium.
  fun SalmonellaPartyphi : Class ;
  fun SalmonellaPartyphi_Class : SubClass SalmonellaPartyphi BacterialAgent ;

  -- The Bacterium that causes TyphoidFever.
  fun SalmonellaTyphi : Class ;
  fun SalmonellaTyphi_Class : SubClass SalmonellaTyphi BacterialAgent ;

  -- A bacterium that can cause death in young, elderly or immunodeficient people. It appears in the stool of infected people.
  fun SalmonellaTyphimurium : Class ;
  fun SalmonellaTyphimurium_Class : SubClass SalmonellaTyphimurium BacterialAgent ;

  -- Also known as GB, one of the G_series nerve agents.
  fun Sarin : Class ;
  fun Sarin_Class : SubClass Sarin GSeriesNerveAgent ;

  -- A class of chemically related neurotoxins that are produced by marine dinoflagellates and carried by Mollusks.
  fun Saxitoxin : Class ;
  fun Saxitoxin_Class : SubClass Saxitoxin (both BodySubstance (both CompoundSubstance Toxin));

  -- A serious disease that may arise if StrepThroat is left untreated.
  fun ScarletFever : Ind BacterialDisease ;

  -- A Bacterium that can cause death in infected Humans.
  fun SerratiaMarcenscens : Class ;
  fun SerratiaMarcenscens_Class : SubClass SerratiaMarcenscens (both BacterialAgent LifeThreateningAgent);

  -- The Toxin produced by the Bacterium ShigellaDysenteriae.
  fun ShigaToxin : Class ;
  fun ShigaToxin_Class : SubClass ShigaToxin Toxin ;

  -- Causes severe dysentery (even when as little as 100 bacteria are ingested). 
  -- This form of dysentery results in death in 10_20 percent of infections.
  fun ShigellaDysenteriae : Class ;
  fun ShigellaDysenteriae_Class : SubClass ShigellaDysenteriae BacterialAgent ;

  -- A highly contagious and dangerous disease. It causes blood loss, 
  -- cardiovascular collapse, secondary infections, skin pustules, 
  -- and often leaves survivors scarred and blinded. 
  -- Approximately 500 million people died from Smallpox in the nineteenth century. 
  -- The disease can live on objects for several days, and it incubates for 
  -- twelve days before showing symptoms.
  fun Smallpox : Ind ViralDisease ;

  -- Also known as GD, one of the G_series nerve agents.
  fun Soman : Class ;
  fun Soman_Class : SubClass Soman GSeriesNerveAgent ;

  -- A common cause of food poisoning. It has been studied as a BiologicalAgent, 
  -- because it is stable, can be converted to aerosol form, and can be lethal when inhaled.
  fun StaphylococcalEnterotoxinB : Class ;
  fun StaphylococcalEnterotoxinB_Class : SubClass StaphylococcalEnterotoxinB (both LifeThreateningAgent Toxin);

  -- A bacterium that secretes StaphylococcalEnterotoxicB. 
  -- It causes chills, headache, muscle pain, coughing (which may last for weeks), 
  -- and sudden fever of up to 106 degrees (which may last for days). 
  -- It occasionally causes nausea, vomiting, and diarrhea.
  fun StaphyylococcusAureus : Class ;
  fun StaphyylococcusAureus_Class : SubClass StaphyylococcusAureus BacterialAgent ;

  -- Manufacturing a significant quantity of instances of a WeaponOfMassDestruction, i.e. 
  -- the weapons are not produced at the scale of a single laboratory or a pilot program. 
  -- These weapons may or may not be deployed (see DeployingWeaponOfMassDestruction).
  fun StockpilingWeaponOfMassDestruction : Class ;
  fun StockpilingWeaponOfMassDestruction_Class : SubClass StockpilingWeaponOfMassDestruction (both DevelopingWeaponOfMassDestruction Manufacture);

  -- A BacterialDisease whose symptoms include a very sore throat, difficulty swallowing, high fever, white spots and/or pus on or near the tonsils, and swollen lymph nodes. If left untreated, StrepThroat can progress to ScarletFever.
  fun StrepThroat : Ind BacterialDisease ;

  -- The Bacterium that causes strep throat, scarlet fever, and necrotizing faciitis (flesh_eating bacteria).
  fun StreptococcusA : Class ;
  fun StreptococcusA_Class : SubClass StreptococcusA BacterialAgent ;

  -- A kind of mustard gas. Also known as Yperite and HD. 
  -- This is regarded b some as the most effective BlisterAgent because it is persistent.
  fun SulphurMustardGas : Class ;
  fun SulphurMustardGas_Class : SubClass SulphurMustardGas MustardGas ;

  -- A Micotoxin that is found in grains and products made from grains. 
  -- Symptoms include diarrhea, necrotic lesions, and hemorrhaging.
  fun T2Toxin : Class ;
  fun T2Toxin_Class : SubClass T2Toxin Mycotoxin ;

  -- Also known as GA, one of the G_series nerve agents. 
  -- It is about half as toxic as Sarin, but it is more irritating to the eyes than Sarin.
  fun Tabun : Class ;
  fun Tabun_Class : SubClass Tabun GSeriesNerveAgent ;

  -- Also known as lockjaw, a BacterialDisease that affects the nervous system. A subject is infected with the disease by a puncture of the skin that becomes infected with the ClostridiumTetani bacterium. Symptoms of the disease include muscular stiffness (especially in the jaw and neck), difficulty swallowing, spasms, sweating, and fever.
  fun Tetanus : Ind (both BacterialDisease VaccinatableDisease) ;

  -- A Toxin produced by the pufferfish and several other (widely varying) species. 
  -- The initial symptoms include numbness in the lips and tongue, which spreads throughout the body.
  -- The next phase of the poisoning is paralysis, which again spreads throughout the body.
  fun Tetrodotoxin : Class ;
  fun Tetrodotoxin_Class : SubClass Tetrodotoxin (both BodySubstance (both CompoundSubstance Toxin));

  -- Any of various forms of encephalitis that are carried by ticks. 
  -- The diseases have three phases. The first consists of flu_like symptoms, 
  -- the second is asymptomatic, and the third involves the central nervous system.
  fun TickBorneEncephalitis : Class ;
  fun TickBorneEncephalitis_Class : SubClass TickBorneEncephalitis (both VaccinatableDisease ViralDisease);

  -- Any Virus whose host is a tick and which carries an instance of TickBorneEncephalitis.
  fun TickBorneEncephalitisVirus : Class ;
  fun TickBorneEncephalitisVirus_Class : SubClass TickBorneEncephalitisVirus (both LifeThreateningAgent ViralAgent);

  -- An Antibiotic that is administered topically, e.g. Bacitracin.
  fun TopicalAntibiotic : Class ;
  fun TopicalAntibiotic_Class : SubClass TopicalAntibiotic Antibiotic ;

  -- The Class of Organisms which are poisonous to other Organisms.
  fun ToxicOrganism : Class ;
  fun ToxicOrganism_Class : SubClass ToxicOrganism (both BiologicalAgent Organism);

  -- BiologicalAgents that are a toxic BiologicallyActiveSubstance produced by
  -- an Organism or that are the synthetic analogue of a toxic
  -- BiologicallyActiveSubstance produced by an Organism.
  fun Toxin : Class ;
  fun Toxin_Class : SubClass Toxin (both BiologicalAgent BiologicallyActiveSubstance);

  -- A disease associated with fever, chills, coughing and Tularemia skin lesions (ulcers up to an inch wide).
  fun Tularemia : Ind BacterialDisease ;

  -- A life_threatening disease that is caused by SalmonellaTyphi.
  fun TyphoidFever : Class ;
  fun TyphoidFever_Class : SubClass TyphoidFever DiseaseOrSyndrome ;

  -- More advanced sort of NerveAgent (developed in the 1950's).
  -- This subclass of NerveAgents tends to be more persistent and toxic than
  -- GSeriesNerveAgents, which were developed earlier. VSeriesNerveAgents include VE, VG, VM, VS, and VX.
  fun VSeriesNerveAgent : Class ;
  fun VSeriesNerveAgent_Class : SubClass VSeriesNerveAgent NerveAgent ;

  -- One of the V_series nerve agents.
  fun VX : Class ;
  fun VX_Class : SubClass VX VSeriesNerveAgent ;

  -- A disease for which there is an effective vaccine for Humans.
  fun VaccinatableDisease : Class ;
  fun VaccinatableDisease_Class : SubClass VaccinatableDisease InfectiousDisease ;

  -- A Virus that causes Smallpox. Also known as the smallpox virus.
  fun VariolaMajor : Class ;
  fun VariolaMajor_Class : SubClass VariolaMajor ViralAgent ;

  -- A Virus that causes Smallpox. Also known as Alastrim.
  fun VariolaMinor : Class ;
  fun VariolaMinor_Class : SubClass VariolaMinor ViralAgent ;

  -- Also known as Venezuelan equine encephalomyelitis. 
  -- Caused by any one of eight distinct Viruses. 
  -- Symptoms of the disease include severe headache, high fever (up to 105 degrees), 
  -- sensitivity to light (photophobia), nausea, coughing, and diarrhea. 
  -- The disease results in central nervous system infection in 1 of 25 children.
  fun VenezuelanEquineEncephalitis : Class ;
  fun VenezuelanEquineEncephalitis_Class : SubClass VenezuelanEquineEncephalitis (both VaccinatableDisease ViralDisease);

  -- The Virus that causes VenezuelanEquineEncephalitis.
  fun VenezuelanEquineEncephalitisVirus : Class ;
  fun VenezuelanEquineEncephalitisVirus_Class : SubClass VenezuelanEquineEncephalitisVirus ViralAgent ;

  -- Symptoms of the disease are flu_like in the initial stages. 
  -- As the disease progresses, symptoms include bleeding from the nose and gums and blood spots.
  fun VenezuelanHemorrhagicFever : Ind HemorrhagicFever ;

  -- The Bacterium that is responsible for Cholera.
  fun VibrioCholera : Class ;
  fun VibrioCholera_Class : SubClass VibrioCholera BacterialAgent ;

  -- BiologicalAgents that are also a Virus.
  fun ViralAgent : Class ;
  fun ViralAgent_Class : SubClass ViralAgent (both ToxicOrganism Virus);

  -- A highly lethal, weaponized form of BacillusAnthracis developed by the United States government.
  fun Vollum1B : Class ;
  fun Vollum1B_Class : SubClass Vollum1B AerosolizedBacillusAnthracis ;

  -- Facilities where instances of WeaponOfMassDestruction are built.
  fun WMDWeaponsProductionFacility : Class ;
  fun WMDWeaponsProductionFacility_Class : SubClass WMDWeaponsProductionFacility StationaryArtifact ;

  -- Facilities where research on instances of WeaponOfMassDestruction is performed.
  fun WMDWeaponsResearchFacility : Class ;
  fun WMDWeaponsResearchFacility_Class : SubClass WMDWeaponsResearchFacility StationaryArtifact ;

  -- A flu_like disease that is caused by the WestNileVirus. 
  -- The disease is generally not life_threatening. 
  -- However, it can be very serious if it progresses to West Nile Encephalitis, 
  -- West Nile Meningitis or West Nile Meningoencephalitis, 
  -- all of which are inflammations of the brain and/or spinal cord.
  fun WestNileFever : Ind ViralDisease ;

  -- A flavivirus that causes WestNileFever.
  fun WestNileVirus : Class ;
  fun WestNileVirus_Class : SubClass WestNileVirus ViralAgent ;

  -- A Virus that can result in chills, fever, stomach bleeding, and YellowSkin.
  fun YellowFeverVirus : Class ;
  fun YellowFeverVirus_Class : SubClass YellowFeverVirus ViralAgent ;

  -- Is caused by liver failure, 
  -- which results in an accumulation of bile. It is caused by YellowFeverVirus.
  fun YellowSkin : Ind ViralDisease ;

  -- The Bacterium that causes Plague.
  fun YersiniaPestis : Class ;
  fun YersiniaPestis_Class : SubClass YersiniaPestis (both BacterialAgent LifeThreateningAgent);

  -- Causes a disease whose symptoms include 
  -- diarrhea, fever, headache, skin ulcers, and post_infectious arthritis.
  fun YersiniaPseudotuberculosis : Class ;
  fun YersiniaPseudotuberculosis_Class : SubClass YersiniaPseudotuberculosis BacterialAgent ;

  -- (biochemicalAgentAntidote ?AGENT ?SUBSTANCE ?PROCESS) means that
  -- the BiologicallyActiveSubstance ?SUBSTANCE has been shown to be effective
  -- in treating someone who has been exposed to the BiochemicalAgent ?AGENT 
  -- when the ?SUBSTANCE is administered via the Process ?PROCESS.
  fun biochemicalAgentAntidote: El BiochemicalAgent -> Desc BiologicallyActiveSubstance -> Desc Process -> Formula ;

  -- (biochemicalAgentDelivery ?AGENT ?PROCESS) means that the Process ?PROCESS is 
  -- capable of infecting an organism with the BiochemicalAgent ?AGENT when 
  -- the organism is the experiencer and the ?AGENT the patient of an instance of ?PROCESS.
  fun biochemicalAgentDelivery: Desc BiochemicalAgent -> Desc Process -> Formula ;

  -- Relates a subclass of BiochemicalAgent to a DiseaseOrSyndrome that is caused by or 
  -- often associated with the BiochemicalAgent.
  fun biochemicalAgentSyndrome: Desc BiochemicalAgent -> El DiseaseOrSyndrome -> Formula ;

  -- (biologicalAgentCarrier ?AGENT ?ORGANISM) means that the subclass of Organism ?ORGANISM
  -- is a carrier of the subclass of BiologicalAgent ?AGENT.
  fun biologicalAgentCarrier: Desc BiologicalAgent -> Desc Organism -> Formula ;

  -- A predicate that specifies the time frame for the incubation of a DiseaseOrSyndrome. 
  -- (diseaseIncubation ?DISEASE ?TIME1 ?TIME2) means that the DiseaseOrSyndrome ?DISEASE 
  -- will appear between ?TIME1 and ?TIME2 after the subject has been infected with
  -- the BiologicalAgent causing ?DISEASE.
  fun diseaseIncubation: El DiseaseOrSyndrome -> Desc TimeDuration -> Desc TimeDuration -> Formula ;

  -- (diseaseMortality ?DISEASE ?NUMBER) means that DiseaseOrSyndrome ?DISEASE has a Mortality rate of ?NUMBER.
  fun diseaseMortality : El DiseaseOrSyndrome -> El RealNumber -> Formula ;

  -- (diseaseSymptom ?DISEASE ?SYMPTOM) means that DiseaseOrSyndrome ?DISEASE is often associated with 
  -- the DiseaseOrSyndrome ?SYMPTOM, i.e. an Organism which suffers from ?DISEASE is more likely
  -- to suffer from ?SYMPTOM than one which does not.
  fun diseaseSymptom : El DiseaseOrSyndrome -> El DiseaseOrSyndrome -> Formula ;

  -- (diseaseTreatment ?DISEASE ?SUBSTANCE ?PROCESS) means that the BiologicallyActiveSubstance ?SUBSTANCE is 
  -- effective in the treatment of the DiseaseOrSyndrome ?DISEASE when administered via the Process ?PROCESS,
  -- i.e. it has been demonstrated (in a significant sample of patients) to cure the ?DISEASE or
  -- at least reduce the severity of symptoms associated with the ?DISEASE.
  fun diseaseTreatment: El DiseaseOrSyndrome -> Desc BiologicallyActiveSubstance -> Desc Process -> Formula ;

  -- (effectiveDose ?AGENT ?QUANTITY) means that ?QUANTITY is the effective dose, or ED50,
  -- for the BiochemicalAgent ?AGENT. This is the dose that would incapacitate 50% of 
  -- the exposed human population. Note that ?QUANTITY is generally expressed in micrograms per kilogram (mcg/kg).
  fun effectiveDose: Desc BiochemicalAgent -> El FunctionQuantity -> Formula ;

  -- (lethalDose ?AGENT ?QUANTITY) means that ?QUANTITY is the lethal dose, 
  -- or LD50, for the BiochemicalAgent ?AGENT. 
  -- This is the dose that would result in death for 50% of the exposed human population. 
  -- Note that ?QUANTITY is generally expressed in micrograms per kilogram (mcg/kg).
  fun lethalDose: Desc BiochemicalAgent -> El FunctionQuantity -> Formula ;

  -- (secretesToxin ?ORGANISM ?TOXIN) means that the
  -- subclass of Organism ?ORGANISM produces the subclass of Toxin ?TOXIN.
  fun secretesToxin: Desc Organism -> Desc Toxin -> Formula ;

  -- A predicate that is used to specify a side effect of 
  -- a substance used in a medical treatment. 
  -- (sideEffect ?SUBSTANCE ?SYNDROME) means that
  -- the BiologicallyActiveSubstance ?SUBSTANCE has the side effect ?SYNDROME.
  fun sideEffect : El BiologicallyActiveSubstance -> El DiseaseOrSyndrome -> Formula ;

}
