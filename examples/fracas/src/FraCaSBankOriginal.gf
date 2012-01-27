--# -path=.:alltenses:prelude

concrete FraCaSBankOriginal of FraCaSBank = open Prelude in {

lincat FraCaSPhrase = SS;

-- Sentences

lin s_001_1_p = ss "an Italian became the world's greatest tenor";
lin s_001_2_q = ss "was there an Italian who became the world's greatest tenor";
lin s_001_3_h = ss "there was an Italian who became the world's greatest tenor";

lin s_002_1_p = ss "every Italian man wants to be a great tenor";
lin s_002_2_p = ss "some Italian men are great tenors";
lin s_002_3_q = ss "are there Italian men who want to be a great tenor";
lin s_002_4_h = ss "there are Italian men who want to be a great tenor";

lin s_003_1_p = ss "all Italian men want to be a great tenor";
lin s_003_2_p = ss "some Italian men are great tenors";
lin s_003_3_q = ss "are there Italian men who want to be a great tenor";
lin s_003_4_h = ss "there are Italian men who want to be a great tenor";

lin s_004_1_p = ss "each Italian tenor wants to be great";
lin s_004_2_p = ss "some Italian tenors are great";
lin s_004_3_q = ss "are there Italian tenors who want to be great";
lin s_004_4_h = ss "there are Italian tenors who want to be great";

lin s_005_1_p = ss "the really ambitious tenors are Italian";
lin s_005_2_q = ss "are there really ambitious tenors who are Italian";
lin s_005_3_h = ss "there are really ambitious tenors who are Italian";

lin s_006_1_p = ss "no really great tenors are modest";
lin s_006_2_q = ss "are there really great tenors who are modest";
lin s_006_3_h = ss "there are really great tenors who are modest";

lin s_007_1_p = ss "some great tenors are Swedish";
lin s_007_2_q = ss "are there great tenors who are Swedish";
lin s_007_3_h = ss "there are great tenors who are Swedish";

lin s_008_1_p = ss "many great tenors are German";
lin s_008_2_q = ss "are there great tenors who are German";
lin s_008_3_h = ss "there are great tenors who are German";

lin s_009_1_p = ss "several great tenors are British";
lin s_009_2_q = ss "are there great tenors who are British";
lin s_009_3_h = ss "there are great tenors who are British";

lin s_010_1_p = ss "most great tenors are Italian";
lin s_010_2_q = ss "are there great tenors who are Italian";
lin s_010_3_h = ss "there are great tenors who are Italian";

lin s_011_1_p = ss "a few great tenors sing popular music";
lin s_011_2_p = ss "some great tenors like popular music";
lin s_011_3_q = ss "are there great tenors who sing popular music";
lin s_011_4_h = ss "there are great tenors who sing popular music";

lin s_012_1_p = ss "few great tenors are poor";
lin s_012_2_q = ss "are there great tenors who are poor";
lin s_012_3_h = ss "there are great tenors who are poor";

lin s_013_1_p = ss "both leading tenors are excellent";
lin s_013_2_p = ss "leading tenors who are excellent are indispensable";
lin s_013_3_q = ss "are both leading tenors indispensable";
lin s_013_4_h = ss "both leading tenors are indispensable";

lin s_014_1_p = ss "neither leading tenor comes cheap";
lin s_014_2_p = ss "one of the leading tenors is Pavarotti";
lin s_014_3_q = ss "is Pavarotti a leading tenor who comes cheap";
lin s_014_4_h = ss "Pavarotti is a leading tenor who comes cheap";

lin s_015_1_p = ss "at least three tenors will take part in the concert";
lin s_015_2_q = ss "are there tenors who will take part in the concert";
lin s_015_3_h = ss "there are tenors who will take part in the concert";

lin s_016_1_p = ss "at most two tenors will contribute their fees to charity";
lin s_016_2_q = ss "are there tenors who will contribute their fees to charity";
lin s_016_3_h = ss "there are tenors who will contribute their fees to charity";

lin s_017_1_p = ss "an Irishman won the Nobel prize for literature";
lin s_017_2_q = ss "did an Irishman win a Nobel prize";
lin s_017_3_h = ss "an Irishman won a Nobel prize";

lin s_018_1_p = ss "every European has the right to live in Europe";
lin s_018_2_p = ss "every European is a person";
lin s_018_3_p = ss "every person who has the right to live in Europe can travel freely within Europe";
lin s_018_4_q = ss "can every European travel freely within Europe";
lin s_018_5_h = ss "every European can travel freely within Europe";

lin s_019_1_p = ss "all Europeans have the right to live in Europe";
lin s_019_2_p = ss "every European is a person";
lin s_019_3_p = ss "every person who has the right to live in Europe can travel freely within Europe";
lin s_019_4_q = ss "can all Europeans travel freely within Europe";
lin s_019_5_h = ss "all Europeans can travel freely within Europe";

lin s_020_1_p = ss "each European has the right to live in Europe";
lin s_020_2_p = ss "every European is a person";
lin s_020_3_p = ss "every person who has the right to live in Europe can travel freely within Europe";
lin s_020_4_q = ss "can each European travel freely within Europe";
lin s_020_5_h = ss "each European can travel freely within Europe";

lin s_021_1_p = ss "the residents of member states have the right to live in Europe";
lin s_021_2_p = ss "all residents of member states are individuals";
lin s_021_3_p = ss "every individual who has the right to live in Europe can travel freely within Europe";
lin s_021_4_q = ss "can the residents of member states travel freely within Europe";
lin s_021_5_h = ss "the residents of member states can travel freely within Europe";

lin s_022_1_p = ss "no delegate finished the report on time";
lin s_022_2_q = ss "did no delegate finish the report";
lin s_022_3_h = ss "no delegate finished the report";

lin s_023_1_p = ss "some delegates finished the survey on time";
lin s_023_2_q = ss "did some delegates finish the survey";
lin s_023_3_h = ss "some delegates finished the survey";

lin s_024_1_p = ss "many delegates obtained interesting results from the survey";
lin s_024_2_q = ss "did many delegates obtain results from the survey";
lin s_024_3_h = ss "many delegates obtained results from the survey";

lin s_025_1_p = ss "several delegates got the results published in major national newspapers";
lin s_025_2_q = ss "did several delegates get the results published";
lin s_025_3_h = ss "several delegates got the results published";

lin s_026_1_p = ss "most Europeans are resident in Europe";
lin s_026_2_p = ss "all Europeans are people";
lin s_026_3_p = ss "all people who are resident in Europe can travel freely within Europe";
lin s_026_4_q = ss "can most Europeans travel freely within Europe";
lin s_026_5_h = ss "most Europeans can travel freely within Europe";

lin s_027_1_p = ss "a few committee members are from Sweden";
lin s_027_2_p = ss "all committee members are people";
lin s_027_3_p = ss "all people who are from Sweden are from Scandinavia";
lin s_027_4_q = ss "are at least a few committee members from Scandinavia";
lin s_027_5_h = ss "at least a few committee members are from Scandinavia";

lin s_028_1_p = ss "few committee members are from Portugal";
lin s_028_2_p = ss "all committee members are people";
lin s_028_3_p = ss "all people who are from Portugal are from southern Europe";
lin s_028_4_q = ss "are there few committee members from southern Europe";
lin s_028_5_h = ss "there are few committee members from southern Europe";

lin s_029_1_p = ss "both commissioners used to be leading businessmen";
lin s_029_2_q = ss "did both commissioners used to be businessmen";
lin s_029_3_h = ss "both commissioners used to be businessmen";

lin s_030_1_p = ss "neither commissioner spends a lot of time at home";
lin s_030_2_q = ss "does neither commissioner spend time at home";
lin s_030_3_h = ss "neither commissioner spends time at home";

lin s_031_1_p = ss "at least three commissioners spend a lot of time at home";
lin s_031_2_q = ss "do at least three commissioners spend time at home";
lin s_031_3_h = ss "at least three commissioners spend time at home";

lin s_032_1_p = ss "at most ten commissioners spend a lot of time at home";
lin s_032_2_q = ss "do at most ten commissioners spend time at home";
lin s_032_3_h = ss "at most ten commissioners spend time at home";

lin s_033_1_p = ss "an Irishman won a Nobel prize";
lin s_033_2_q = ss "did an Irishman win the Nobel prize for literature";
lin s_033_3_h = ss "an Irishman won the Nobel prize for literature";

lin s_034_1_p = ss "every European can travel freely within Europe";
lin s_034_2_p = ss "every European is a person";
lin s_034_3_p = ss "every person who has the right to live in Europe can travel freely within Europe";
lin s_034_4_q = ss "does every European have the right to live in Europe";
lin s_034_5_h = ss "every European has the right to live in Europe";

lin s_035_1_p = ss "all Europeans can travel freely within Europe";
lin s_035_2_p = ss "every European is a person";
lin s_035_3_p = ss "every person who has the right to live in Europe can travel freely within Europe";
lin s_035_4_q = ss "do all Europeans have the right to live in Europe";
lin s_035_5_h = ss "all Europeans have the right to live in Europe";

lin s_036_1_p = ss "each European can travel freely within Europe";
lin s_036_2_p = ss "every European is a person";
lin s_036_3_p = ss "every person who has the right to live in Europe can travel freely within Europe";
lin s_036_4_q = ss "does each European have the right to live in Europe";
lin s_036_5_h = ss "each European has the right to live in Europe";

lin s_037_1_p = ss "the residents of member states can travel freely within Europe";
lin s_037_2_p = ss "all residents of member states are individuals";
lin s_037_3_p = ss "every individual who has the right to live anywhere in Europe can travel freely within Europe";
lin s_037_4_q = ss "do the residents of member states have the right to live anywhere in Europe";
lin s_037_5_h = ss "the residents of member states have the right to live anywhere in Europe";

lin s_038_1_p = ss "no delegate finished the report";
lin s_038_2_q = ss "did any delegate finish the report on time";
lin s_038_3_h = ss "some delegate finished the report on time";

lin s_039_1_p = ss "some delegates finished the survey";
lin s_039_2_q = ss "did some delegates finish the survey on time";
lin s_039_3_h = ss "some delegates finished the survey on time";

lin s_040_1_p = ss "many delegates obtained results from the survey";
lin s_040_2_q = ss "did many delegates obtain interesting results from the survey";
lin s_040_3_h = ss "many delegates obtained interesting results from the survey";

lin s_041_1_p = ss "several delegates got the results published";
lin s_041_2_q = ss "did several delegates get the results published in major national newspapers";
lin s_041_3_h = ss "several delegates got the results published in major national newspapers";

lin s_042_1_p = ss "most Europeans can travel freely within Europe";
lin s_042_2_p = ss "all Europeans are people";
lin s_042_3_p = ss "all people who are resident in Europe can travel freely within Europe";
lin s_042_4_q = ss "are most Europeans resident in Europe";
lin s_042_5_h = ss "most Europeans are resident in Europe";

lin s_043_1_p = ss "a few committee members are from Scandinavia";
lin s_043_2_p = ss "all committee members are people";
lin s_043_3_p = ss "all people who are from Sweden are from Scandinavia";
lin s_043_4_q = ss "are at least a few committee members from Sweden";
lin s_043_5_h = ss "at least a few committee members are from Sweden";

lin s_044_1_p = ss "few committee members are from southern Europe";
lin s_044_2_p = ss "all committee members are people";
lin s_044_3_p = ss "all people who are from Portugal are from southern Europe";
lin s_044_4_q = ss "are there few committee members from Portugal";
lin s_044_5_h = ss "there are few committee members from Portugal";

lin s_045_1_p = ss "both commissioners used to be businessmen";
lin s_045_2_q = ss "did both commissioners used to be leading businessmen";
lin s_045_3_h = ss "both commissioners used to be leading businessmen";

lin s_046_1_p = ss "neither commissioner spends time at home";
lin s_046_2_q = ss "does either commissioner spend a lot of time at home";
lin s_046_3_h = ss "one of the commissioners spends a lot of time at home";

lin s_047_1_p = ss "at least three commissioners spend time at home";
lin s_047_2_q = ss "do at least three commissioners spend a lot of time at home";
lin s_047_3_h = ss "at least three commissioners spend a lot of time at home";

lin s_048_1_p = ss "at most ten commissioners spend time at home";
lin s_048_2_q = ss "do at most ten commissioners spend a lot of time at home";
lin s_048_3_h = ss "at most ten commissioners spend a lot of time at home";

lin s_049_1_p = ss "a Swede won a Nobel prize";
lin s_049_2_p = ss "every Swede is a Scandinavian";
lin s_049_3_q = ss "did a Scandinavian win a Nobel prize";
lin s_049_4_h = ss "a Scandinavian won a Nobel prize";

lin s_050_1_p = ss "every Canadian resident can travel freely within Europe";
lin s_050_2_p = ss "every Canadian resident is a resident of the North American continent";
lin s_050_3_q = ss "can every resident of the North American continent travel freely within Europe";
lin s_050_4_h = ss "every resident of the North American continent can travel freely within Europe";

lin s_051_1_p = ss "all Canadian residents can travel freely within Europe";
lin s_051_2_p = ss "every Canadian resident is a resident of the North American continent";
lin s_051_3_q = ss "can all residents of the North American continent travel freely within Europe";
lin s_051_4_h = ss "all residents of the North American continent can travel freely within Europe";

lin s_052_1_p = ss "each Canadian resident can travel freely within Europe";
lin s_052_2_p = ss "every Canadian resident is a resident of the North American continent";
lin s_052_3_q = ss "can each resident of the North American continent travel freely within Europe";
lin s_052_4_h = ss "each resident of the North American continent can travel freely within Europe";

lin s_053_1_p = ss "the residents of major western countries can travel freely within Europe";
lin s_053_2_p = ss "all residents of major western countries are residents of western countries";
lin s_053_3_q = ss "do the residents of western countries have the right to live in Europe";
lin s_053_4_h = ss "the residents of western countries have the right to live in Europe";

lin s_054_1_p = ss "no Scandinavian delegate finished the report on time";
lin s_054_2_q = ss "did any delegate finish the report on time";
lin s_054_3_h = ss "some delegate finished the report on time";

lin s_055_1_p = ss "some Irish delegates finished the survey on time";
lin s_055_2_q = ss "did any delegates finish the survey on time";
lin s_055_3_h = ss "some delegates finished the survey on time";

lin s_056_1_p = ss "many British delegates obtained interesting results from the survey";
lin s_056_2_q = ss "did many delegates obtain interesting results from the survey";
lin s_056_3_h = ss "many delegates obtained interesting results from the survey";

lin s_057_1_p = ss "several Portuguese delegates got the results published in major national newspapers";
lin s_057_2_q = ss "did several delegates get the results published in major national newspapers";
lin s_057_3_h = ss "several delegates got the results published in major national newspapers";

lin s_058_1_p = ss "most Europeans who are resident in Europe can travel freely within Europe";
lin s_058_2_q = ss "can most Europeans travel freely within Europe";
lin s_058_3_h = ss "most Europeans can travel freely within Europe";

lin s_059_1_p = ss "a few female committee members are from Scandinavia";
lin s_059_2_q = ss "are at least a few committee members from Scandinavia";
lin s_059_3_h = ss "at least a few committee members are from Scandinavia";

lin s_060_1_p = ss "few female committee members are from southern Europe";
lin s_060_2_q = ss "are few committee members from southern Europe";
lin s_060_3_h = ss "few committee members are from southern Europe";

lin s_061_1_p = ss "both female commissioners used to be in business";
lin s_061_2_q = ss "did both commissioners used to be in business";
lin s_061_3_h = ss "both commissioners used to be in business";

lin s_062_1_p = ss "neither female commissioner spends a lot of time at home";
lin s_062_2_q = ss "does either commissioner spend a lot of time at home";
lin s_062_3_h = ss "one of the commissioners spends a lot of time at home";

lin s_063_1_p = ss "at least three female commissioners spend time at home";
lin s_063_2_q = ss "do at least three commissioners spend time at home";
lin s_063_3_h = ss "at least three commissioners spend time at home";

lin s_064_1_p = ss "at most ten female commissioners spend time at home";
lin s_064_2_q = ss "do at most ten commissioners spend time at home";
lin s_064_3_h = ss "at most ten commissioners spend time at home";

lin s_065_1_p = ss "a Scandinavian won a Nobel prize";
lin s_065_2_p = ss "every Swede is a Scandinavian";
lin s_065_3_q = ss "did a Swede win a Nobel prize";
lin s_065_4_h = ss "a Swede won a Nobel prize";

lin s_066_1_p = ss "every resident of the North American continent can travel freely within Europe";
lin s_066_2_p = ss "every Canadian resident is a resident of the North American continent";
lin s_066_3_q = ss "can every Canadian resident travel freely within Europe";
lin s_066_4_h = ss "every Canadian resident can travel freely within Europe";

lin s_067_1_p = ss "all residents of the North American continent can travel freely within Europe";
lin s_067_2_p = ss "every Canadian resident is a resident of the North American continent";
lin s_067_3_q = ss "can all Canadian residents travel freely within Europe";
lin s_067_4_h = ss "all Canadian residents can travel freely within Europe";

lin s_068_1_p = ss "each resident of the North American continent can travel freely within Europe";
lin s_068_2_p = ss "every Canadian resident is a resident of the North American continent";
lin s_068_3_q = ss "can each Canadian resident travel freely within Europe";
lin s_068_4_h = ss "each Canadian resident can travel freely within Europe";

lin s_069_1_p = ss "the residents of western countries can travel freely within Europe";
lin s_069_2_p = ss "all residents of major western countries are residents of western countries";
lin s_069_3_q = ss "do the residents of major western countries have the right to live in Europe";
lin s_069_4_h = ss "the residents of major western countries have the right to live in Europe";

lin s_070_1_p = ss "no delegate finished the report on time";
lin s_070_2_q = ss "did any Scandinavian delegate finish the report on time";
lin s_070_3_h = ss "some Scandinavian delegate finished the report on time";

lin s_071_1_p = ss "some delegates finished the survey on time";
lin s_071_2_q = ss "did any Irish delegates finish the survey on time";
lin s_071_3_h = ss "some Irish delegates finished the survey on time";

lin s_072_1_p = ss "many delegates obtained interesting results from the survey";
lin s_072_2_q = ss "did many British delegates obtain interesting results from the survey";
lin s_072_3_h = ss "many British delegates obtained interesting results from the survey";

lin s_073_1_p = ss "several delegates got the results published in major national newspapers";
lin s_073_2_q = ss "did several Portuguese delegates get the results published in major national newspapers";
lin s_073_3_h = ss "several Portuguese delegates got the results published in major national newspapers";

lin s_074_1_p = ss "most Europeans can travel freely within Europe";
lin s_074_2_q = ss "can most Europeans who are resident outside Europe travel freely within Europe";
lin s_074_3_h = ss "most Europeans who are resident outside Europe can travel freely within Europe";

lin s_075_1_p = ss "a few committee members are from Scandinavia";
lin s_075_2_q = ss "are at least a few female committee members from Scandinavia";
lin s_075_3_h = ss "at least a few female committee members are from Scandinavia";

lin s_076_1_p = ss "few committee members are from southern Europe";
lin s_076_2_q = ss "are few female committee members from southern Europe";
lin s_076_3_h = ss "few female committee members are from southern Europe";

lin s_077_1_p = ss "both commissioners used to be in business";
lin s_077_2_q = ss "did both female commissioners used to be in business";
lin s_077_3_h = ss "both female commissioners used to be in business";

lin s_078_1_p = ss "neither commissioner spends a lot of time at home";
lin s_078_2_q = ss "does either female commissioner spend a lot of time at home";
lin s_078_3_h = ss "one of the female commissioners spends a lot of time at home";

lin s_079_1_p = ss "at least three commissioners spend time at home";
lin s_079_2_q = ss "do at least three male commissioners spend time at home";
lin s_079_3_h = ss "at least three male commissioners spend time at home";

lin s_080_1_p = ss "at most ten commissioners spend time at home";
lin s_080_2_q = ss "do at most ten female commissioners spend time at home";
lin s_080_3_h = ss "at most ten female commissioners spend time at home";

lin s_081_1_p = ss "Smith , Jones and Anderson signed the contract";
lin s_081_2_q = ss "did Jones sign the contract";
lin s_081_3_h = ss "Jones signed the contract";

lin s_082_1_p = ss "Smith , Jones and several lawyers signed the contract";
lin s_082_2_q = ss "did Jones sign the contract";
lin s_082_3_h = ss "Jones signed the contract";

lin s_083_1_p = ss "either Smith , Jones or Anderson signed the contract";
lin s_083_2_q = ss "did Jones sign the contract";
lin s_083_3_h = ss "Jones signed the contract";

lin s_084_1_p = ss "either Smith , Jones or Anderson signed the contract";
lin s_084_2_q = ss "if Smith and Anderson did not sign the contract , did Jones sign the contract";
lin s_084_3_h = ss "if Smith and Anderson did not sign the contract , Jones signed the contract";

lin s_085_1_p = ss "exactly two lawyers and three accountants signed the contract";
lin s_085_2_q = ss "did six lawyers sign the contract";
lin s_085_3_h = ss "six lawyers signed the contract";

lin s_086_1_p = ss "exactly two lawyers and three accountants signed the contract";
lin s_086_2_q = ss "did six accountants sign the contract";
lin s_086_3_h = ss "six accountants signed the contract";

lin s_087_1_p = ss "every representative and client was at the meeting";
lin s_087_2_q = ss "was every representative at the meeting";
lin s_087_3_h = ss "every representative was at the meeting";

lin s_088_1_p = ss "every representative and client was at the meeting";
lin s_088_2_q = ss "was every representative at the meeting";
lin s_088_3_h = ss "every representative was at the meeting";

lin s_089_1_p = ss "every representative or client was at the meeting";
lin s_089_2_q = ss "was every representative and every client at the meeting";
lin s_089_3_h = ss "every representative and every client was at the meeting";

lin s_090_1_p = ss "the chairman read out the items on the agenda";
lin s_090_2_q = ss "did the chairman read out every item on the agenda";
lin s_090_3_h = ss "the chairman read out every item on the agenda";

lin s_091_1_p = ss "the people who were at the meeting voted for a new chairman";
lin s_091_2_q = ss "did everyone at the meeting vote for a new chairman";
lin s_091_3_h = ss "everyone at the meeting voted for a new chairman";

lin s_092_1_p = ss "all the people who were at the meeting voted for a new chairman";
lin s_092_2_q = ss "did everyone at the meeting vote for a new chairman";
lin s_092_3_h = ss "everyone at the meeting voted for a new chairman";

lin s_093_1_p = ss "the people who were at the meeting all voted for a new chairman";
lin s_093_2_q = ss "did everyone at the meeting vote for a new chairman";
lin s_093_3_h = ss "everyone at the meeting voted for a new chairman";

lin s_094_1_p = ss "the inhabitants of Cambridge voted for a Labour MP";
lin s_094_2_q = ss "did every inhabitant of Cambridge vote for a Labour MP";
lin s_094_3_h = ss "every inhabitant of Cambridge voted for a Labour MP";

lin s_095_1_p = ss "the Ancient Greeks were noted philosophers";
lin s_095_2_q = ss "was every Ancient Greek a noted philosopher";
lin s_095_3_h = ss "every Ancient Greek was a noted philosopher";

lin s_096_1_p = ss "the Ancient Greeks were all noted philosophers";
lin s_096_2_q = ss "was every Ancient Greek a noted philosopher";
lin s_096_3_h = ss "every Ancient Greek was a noted philosopher";

lin s_097_1_p = ss "software faults were blamed for the system failure";
lin s_097_2_q = ss "was the system failure blamed on one or more software faults";
lin s_097_3_h = ss "the system failure was blamed on one or more software faults";

lin s_098_1_p = ss "software faults were blamed for the system failure";
lin s_098_2_p = ss "Bug # 32-985 is a known software fault";
lin s_098_3_q = ss "was Bug # 32-985 blamed for the system failure";
lin s_098_4_h = ss "Bug # 32-985 was blamed for the system failure";

lin s_099_1_p = ss "clients at the demonstration were all impressed by the system's performance";
lin s_099_2_p = ss "Smith was a client at the demonstration";
lin s_099_3_q = ss "was Smith impressed by the system's performance";
lin s_099_4_h = ss "Smith was impressed by the system's performance";

lin s_100_1_p = ss "clients at the demonstration were impressed by the system's performance";
lin s_100_2_q = ss "were most clients at the demonstration impressed by the system's performance";
lin s_100_3_h = ss "most clients at the demonstration were impressed by the system's performance";

lin s_101_1_p = ss "university graduates make poor stock-market traders";
lin s_101_2_p = ss "Smith is a university graduate";
lin s_101_3_q = ss "is Smith likely to make a poor stock market trader";
lin s_101_4_h = ss "Smith is likely to make a poor stock market trader";

lin s_102_1_p = ss "university graduates make poor stock-market traders";
lin s_102_2_p = ss "Smith is a university graduate";
lin s_102_3_q = ss "will Smith make a poor stock market trader";
lin s_102_4_h = ss "Smith will make a poor stock market trader";

lin s_103_1_p = ss "all APCOM managers have company cars";
lin s_103_2_p = ss "Jones is an APCOM manager";
lin s_103_3_q = ss "does Jones have a company car";
lin s_103_4_h = ss "Jones has a company car";

lin s_104_1_p = ss "all APCOM managers have company cars";
lin s_104_2_p = ss "Jones is an APCOM manager";
lin s_104_3_q = ss "does Jones have more than one company car";
lin s_104_4_h = ss "Jones has more than one company car";

lin s_105_1_p = ss "just one accountant attended the meeting";
lin s_105_2_q = ss "did no accountants attend the meeting";
lin s_105_3_h = ss "no accountants attended the meeting";

lin s_106_1_p = ss "just one accountant attended the meeting";
lin s_106_2_q = ss "did no accountant attend the meeting";
lin s_106_3_h = ss "no accountant attended the meeting";

lin s_107_1_p = ss "just one accountant attended the meeting";
lin s_107_2_q = ss "did any accountants attend the meeting";
lin s_107_3_h = ss "some accountants attended the meeting";

lin s_108_1_p = ss "just one accountant attended the meeting";
lin s_108_2_q = ss "did any accountant attend the meeting";
lin s_108_3_h = ss "some accountant attended the meeting";

lin s_109_1_p = ss "just one accountant attended the meeting";
lin s_109_2_q = ss "did some accountants attend the meeting";
lin s_109_3_h = ss "some accountants attended the meeting";

lin s_110_1_p = ss "just one accountant attended the meeting";
lin s_110_2_q = ss "did some accountant attend the meeting";
lin s_110_3_h = ss "some accountant attended the meeting";

lin s_111_1_p = ss "Smith signed one contract";
lin s_111_2_p = ss "Jones signed another contract";
lin s_111_3_q = ss "did Smith and Jones sign two contracts";
lin s_111_4_h = ss "Smith and Jones signed two contracts";

lin s_112_1_p = ss "Smith signed two contracts";
lin s_112_2_p = ss "Jones signed two contracts";
lin s_112_3_q = ss "did Smith and Jones sign two contracts";
lin s_112_4_h = ss "Smith and Jones signed two contracts";

lin s_113_1_p = ss "Smith signed two contracts";
lin s_113_2_p = ss "Jones also signed them";
lin s_113_3_q = ss "did Smith and Jones sign two contracts";
lin s_113_4_h = ss "Smith and Jones signed two contracts";

lin s_114_1_p = ss "Mary used her workstation";
lin s_114_2_q = ss "was Mary's workstation used";
lin s_114_3_h = ss "Mary's workstation was used";

lin s_115_1_p = ss "Mary used her workstation";
lin s_115_2_q = ss "does Mary have a workstation";
lin s_115_3_h = ss "Mary has a workstation";

lin s_116_1_p = ss "Mary used her workstation";
lin s_116_2_q = ss "is Mary female";
lin s_116_3_h = ss "Mary is female";

lin s_117_1_p = ss "every student used her workstation";
lin s_117_2_p = ss "Mary is a student";
lin s_117_3_q = ss "did Mary use her workstation";
lin s_117_4_h = ss "Mary used her workstation";

lin s_118_1_p = ss "every student used her workstation";
lin s_118_2_p = ss "Mary is a student";
lin s_118_3_q = ss "does Mary have a workstation";
lin s_118_4_h = ss "Mary has a workstation";

lin s_119_1_p = ss "no student used her workstation";
lin s_119_2_p = ss "Mary is a student";
lin s_119_3_q = ss "did Mary use a workstation";
lin s_119_4_h = ss "Mary used a workstation";

lin s_120_1_p = ss "Smith attended a meeting";
lin s_120_2_p = ss "she chaired it";
lin s_120_3_q = ss "did Smith chair a meeting";
lin s_120_4_h = ss "Smith chaired a meeting";

lin s_121_1_p = ss "Smith delivered a report to ITEL";
lin s_121_2_p = ss "she also delivered them an invoice";
lin s_121_3_p = ss "and she delivered them a project proposal";
lin s_121_4_q = ss "did Smith deliver a report , an invoice and a project proposal to ITEL";
lin s_121_5_h = ss "Smith delivered a report , an invoice and a project proposal to ITEL";

lin s_122_1_p = ss "every committee has a chairman";
lin s_122_2_p = ss "he is appointed by its members";
lin s_122_3_q = ss "does every committee have a chairman appointed by members of the committee";
lin s_122_4_h = ss "every committee has a chairman appointed by members of the committee";

lin s_123_1_p = ss "ITEL has sent most of the reports Smith needs";
lin s_123_2_p = ss "they are on her desk";
lin s_123_3_q = ss "are there some reports from ITEL on Smith's desk";
lin s_123_4_h = ss "there are some reports from ITEL on Smith's desk";

lin s_124_1_p = ss "two out of ten machines are missing";
lin s_124_2_p = ss "they have been removed";
lin s_124_3_q = ss "have two machines been removed";
lin s_124_4_h = ss "two machines have been removed";

lin s_125_1_p = ss "two out of ten machines are missing";
lin s_125_2_p = ss "they have been removed";
lin s_125_3_q = ss "have eight machines been removed";
lin s_125_4_h = ss "eight machines have been removed";

lin s_126_1_p = ss "two out of ten machines are missing";
lin s_126_2_p = ss "they were all here yesterday";
lin s_126_3_q = ss "were ten machines here yesterday";
lin s_126_4_h = ss "ten machines were here yesterday";

lin s_127_1_p = ss "Smith took a machine on Tuesday , and Jones took a machine on Wednesday";
lin s_127_2_p = ss "they put them in the lobby";
lin s_127_3_q = ss "did Smith and Jones put two machines in the lobby";
lin s_127_4_h = ss "Smith and Jones put two machines in the lobby";

lin s_128_1_p = ss "John and his colleagues went to a meeting";
lin s_128_2_p = ss "they hated it";
lin s_128_3_q = ss "did John's colleagues hate the meeting";
lin s_128_4_h = ss "John's colleagues hated the meeting";

lin s_129_1_p = ss "John and his colleagues went to a meeting";
lin s_129_2_p = ss "they hated it";
lin s_129_3_q = ss "did John hate the meeting";
lin s_129_4_h = ss "John hated the meeting";

lin s_130_1_p = ss "John and his colleagues went to a meeting";
lin s_130_2_p = ss "they hated it";
lin s_130_3_q = ss "did John hate the meeting";
lin s_130_4_h = ss "John hated the meeting";

lin s_131_1_p = ss "each department has a dedicated line";
lin s_131_2_p = ss "they rent them from BT";
lin s_131_3_q = ss "does every department rent a line from BT";
lin s_131_4_h = ss "every department rents a line from BT";

lin s_132_1_p = ss "each department has a dedicated line";
lin s_132_2_p = ss "the sales department rents it from BT";
lin s_132_3_q = ss "does the sales department rent a line from BT";
lin s_132_4_h = ss "the sales department rents a line from BT";

lin s_133_1_p = ss "GFI owns several computers";
lin s_133_2_p = ss "ITEL maintains them";
lin s_133_3_q = ss "does ITEL maintain all the computers that GFI owns";
lin s_133_4_h = ss "ITEL maintains all the computers that GFI owns";

lin s_134_1_p = ss "every customer who owns a computer has a service contract for it";
lin s_134_2_p = ss "MFI is a customer that owns exactly one computer";
lin s_134_3_q = ss "does MFI have a service contract for all its computers";
lin s_134_4_h = ss "MFI has a service contract for all its computers";

lin s_135_1_p = ss "every customer who owns a computer has a service contract for it";
lin s_135_2_p = ss "MFI is a customer that owns several computers";
lin s_135_3_q = ss "does MFI have a service contract for all its computers";
lin s_135_4_h = ss "MFI has a service contract for all its computers";

lin s_136_1_p = ss "every executive who had a laptop computer brought it to take notes at the meeting";
lin s_136_2_p = ss "Smith is an executive who owns five different laptop computers";
lin s_136_3_q = ss "did Smith take five laptop computers to the meeting";
lin s_136_4_h = ss "Smith took five laptop computers to the meeting";

lin s_137_1_p = ss "there are 100 companies";
lin s_137_2_p = ss "ICM is one of the companies and owns 150 computers";
lin s_137_3_p = ss "it does not have service contracts for any of its computers";
lin s_137_4_p = ss "each of the other 99 companies owns one computer";
lin s_137_5_p = ss "they have service contracts for them";
lin s_137_6_q = ss "do most companies that own a computer have a service contract for it";
lin s_137_7_h = ss "most companies that own a computer have a service contract for it";

lin s_138_1_p = ss "every report has a cover page";
lin s_138_2_p = ss "R-95-103 is a report";
lin s_138_3_p = ss "Smith signed the cover page";
lin s_138_4_q = ss "did Smith sign the cover page of R-95-103";
lin s_138_5_h = ss "Smith signed the cover page of R-95-103";

lin s_139_1_p = ss "a company director awarded himself a large payrise";
lin s_139_2_q = ss "has a company director awarded and been awarded a payrise";
lin s_139_3_h = ss "a company director has awarded and been awarded a payrise";

lin s_140_1_p = ss "John said Bill had hurt himself";
lin s_140_2_q = ss "did John say Bill had been hurt";
lin s_140_3_h = ss "John said Bill had been hurt";

lin s_141_1_p = ss "John said Bill had hurt himself";
lin s_141_2_q = ss "did anyone say John had been hurt";
lin s_141_3_h = ss "someone said John had been hurt";

lin s_142_1_p = ss "John spoke to Mary";
lin s_142_2_p = ss "so did Bill";
lin s_142_3_q = ss "did Bill speak to Mary";
lin s_142_4_h = ss "Bill spoke to Mary";

lin s_143_1_p = ss "John spoke to Mary";
lin s_143_2_p = ss "so did Bill";
lin s_143_3_p = ss "John spoke to Mary at four o'clock";
lin s_143_4_q = ss "did Bill speak to Mary at four o'clock";
lin s_143_5_h = ss "Bill spoke to Mary at four o'clock";

lin s_144_1_p = ss "John spoke to Mary at four o'clock";
lin s_144_2_p = ss "so did Bill";
lin s_144_3_q = ss "did Bill speak to Mary at four o'clock";
lin s_144_4_h = ss "Bill spoke to Mary at four o'clock";

lin s_145_1_p = ss "John spoke to Mary at four o'clock";
lin s_145_2_p = ss "and Bill did [..] at five o'clock";
lin s_145_3_q = ss "did Bill speak to Mary at five o'clock";
lin s_145_4_h = ss "Bill spoke to Mary at five o'clock";

lin s_146_1_p = ss "John has spoken to Mary";
lin s_146_2_p = ss "Bill is going to [..]";
lin s_146_3_q = ss "will Bill speak to Mary";
lin s_146_4_h = ss "Bill will speak to Mary";

lin s_147_1_p = ss "John spoke to Mary on Monday";
lin s_147_2_p = ss "Bill didn't [..]";
lin s_147_3_q = ss "did Bill speak to Mary on Monday";
lin s_147_4_h = ss "Bill spoke to Mary on Monday";

lin s_148_1_p = ss "has John spoken to Mary";
lin s_148_2_p = ss "Bill has [..]";
lin s_148_3_q = ss "has Bill spoken to Mary";
lin s_148_4_h = ss "Bill has spoken to Mary";

lin s_149_1_p = ss "John has spoken to Mary";
lin s_149_2_p = ss "the students have [..] too";
lin s_149_3_q = ss "have the students spoken to Mary";
lin s_149_4_h = ss "the students have spoken to Mary";

lin s_150_1_p = ss "John went to Paris by car , and Bill [..] by train";
lin s_150_2_q = ss "did Bill go to Paris by train";
lin s_150_3_h = ss "Bill went to Paris by train";

lin s_151_1_p = ss "John went to Paris by car , and Bill [..] by train to Berlin";
lin s_151_2_q = ss "did Bill go to Berlin by train";
lin s_151_3_h = ss "Bill went to Berlin by train";

lin s_152_1_p = ss "John went to Paris by car , and Bill [..] to Berlin";
lin s_152_2_q = ss "did Bill go to Berlin by car";
lin s_152_3_h = ss "Bill went to Berlin by car";

lin s_153_1_p = ss "John is going to Paris by car , and the students [..] by train";
lin s_153_2_q = ss "are the students going to Paris by train";
lin s_153_3_h = ss "the students are going to Paris by train";

lin s_154_1_p = ss "John went to Paris by car";
lin s_154_2_p = ss "Bill [..] by train";
lin s_154_3_q = ss "did Bill go to Paris by train";
lin s_154_4_h = ss "Bill went to Paris by train";

lin s_155_1_p = ss "John owns a car";
lin s_155_2_p = ss "Bill owns one too";
lin s_155_3_q = ss "does Bill own a car";
lin s_155_4_h = ss "Bill owns a car";

lin s_156_1_p = ss "John owns a car";
lin s_156_2_p = ss "Bill owns one too";
lin s_156_3_q = ss "is there a car that John and Bill own";
lin s_156_4_h = ss "there is a car that John and Bill own";

lin s_157_1_p = ss "John owns a red car";
lin s_157_2_p = ss "Bill owns a blue one";
lin s_157_3_q = ss "does Bill own a blue car";
lin s_157_4_h = ss "Bill owns a blue car";

lin s_158_1_p = ss "John owns a red car";
lin s_158_2_p = ss "Bill owns a blue one";
lin s_158_3_q = ss "does Bill own a red car";
lin s_158_4_h = ss "Bill owns a red car";

lin s_159_1_p = ss "John owns a red car";
lin s_159_2_p = ss "Bill owns a fast one";
lin s_159_3_q = ss "does Bill own a fast car";
lin s_159_4_h = ss "Bill owns a fast car";

lin s_160_1_p = ss "John owns a red car";
lin s_160_2_p = ss "Bill owns a fast one";
lin s_160_3_q = ss "does Bill own a fast red car";
lin s_160_4_h = ss "Bill owns a fast red car";

lin s_161_1_p = ss "John owns a red car";
lin s_161_2_p = ss "Bill owns a fast one";
lin s_161_3_q = ss "does Bill own a fast red car";
lin s_161_4_h = ss "Bill owns a fast red car";

lin s_162_1_p = ss "John owns a fast red car";
lin s_162_2_p = ss "Bill owns a slow one";
lin s_162_3_q = ss "does Bill own a slow red car";
lin s_162_4_h = ss "Bill owns a slow red car";

lin s_163_1_p = ss "John had his paper accepted";
lin s_163_2_p = ss "Bill doesn't know why [..]";
lin s_163_3_q = ss "does Bill know why John had his paper accepted";
lin s_163_4_h = ss "Bill knows why John had his paper accepted";

lin s_164_1_p = ss "John spoke to Mary";
lin s_164_2_p = ss "and to Sue";
lin s_164_3_q = ss "did John speak to Sue";
lin s_164_4_h = ss "John spoke to Sue";

lin s_165_1_p = ss "John spoke to Mary";
lin s_165_2_p = ss "on Friday";
lin s_165_3_q = ss "did John speak to Mary on Friday";
lin s_165_4_h = ss "John spoke to Mary on Friday";

lin s_166_1_p = ss "John spoke to Mary on Thursday";
lin s_166_2_p = ss "and on Friday";
lin s_166_3_q = ss "did John speak to Mary on Friday";
lin s_166_4_h = ss "John spoke to Mary on Friday";

lin s_167_1_p = ss "twenty men work in the sales department";
lin s_167_2_p = ss "but only one woman";
lin s_167_3_q = ss "do two women work in the sales department";
lin s_167_4_h = ss "two women work in the sales department";

lin s_168_1_p = ss "five men work part time";
lin s_168_2_p = ss "and forty five women";
lin s_168_3_q = ss "do forty five women work part time";
lin s_168_4_h = ss "forty five women work part time";

lin s_169_1_p = ss "John found Mary before Bill";
lin s_169_2_q = ss "did John find Mary before Bill found Mary";
lin s_169_3_h = ss "John found Mary before Bill found Mary";

lin s_170_1_p = ss "John found Mary before Bill";
lin s_170_2_q = ss "did John find Mary before John found Bill";
lin s_170_3_h = ss "John found Mary before John found Bill";

lin s_171_1_p = ss "John wants to know how many men work part time";
lin s_171_2_p = ss "and women";
lin s_171_3_q = ss "does John want to know how many women work part time";
lin s_171_4_h = ss "John wants to know how many women work part time";

lin s_172_1_p = ss "John wants to know how many men work part time , and which [..] [..]";
lin s_172_2_q = ss "does John want to know which men work part time";
lin s_172_3_h = ss "John wants to know which men work part time";

lin s_173_1_p = ss "Bill spoke to everyone that John did [..]";
lin s_173_2_p = ss "John spoke to Mary";
lin s_173_3_q = ss "did Bill speak to Mary";
lin s_173_4_h = ss "Bill spoke to Mary";

lin s_174_1_p = ss "Bill spoke to everyone that John did [..]";
lin s_174_2_p = ss "Bill spoke to Mary";
lin s_174_3_q = ss "did John speak to Mary";
lin s_174_4_h = ss "John spoke to Mary";

lin s_175_1_p = ss "John said Mary wrote a report , and Bill did [..] too";
lin s_175_2_q = ss "did Bill say Mary wrote a report";
lin s_175_3_h = ss "Bill said Mary wrote a report";

lin s_176_1_p = ss "John said Mary wrote a report , and Bill did [..] too";
lin s_176_2_q = ss "did John say Bill wrote a report";
lin s_176_3_h = ss "John said Bill wrote a report";

lin s_177_1_p = ss "John said that Mary wrote a report , and that Bill did [..] too";
lin s_177_1_p_NEW = ss "John said that Mary wrote a report , and said that Bill did [..] too";
lin s_177_2_q = ss "did Bill say Mary wrote a report";
lin s_177_3_h = ss "Bill said Mary wrote a report";

lin s_178_1_p = ss "John wrote a report , and Bill said Peter did [..] too";
lin s_178_2_q = ss "did Bill say Peter wrote a report";
lin s_178_3_h = ss "Bill said Peter wrote a report";

lin s_179_1_p = ss "if John wrote a report , then Bill did [..] too";
lin s_179_2_p = ss "John wrote a report";
lin s_179_3_q = ss "did Bill write a report";
lin s_179_4_h = ss "Bill wrote a report";

lin s_180_1_p = ss "John wanted to buy a car , and he did [..]";
lin s_180_2_q = ss "did John buy a car";
lin s_180_3_h = ss "John bought a car";

lin s_181_1_p = ss "John needed to buy a car , and Bill did [..]";
lin s_181_2_q = ss "did Bill buy a car";
lin s_181_3_h = ss "Bill bought a car";

lin s_182_1_p = ss "Smith represents his company and so does Jones";
lin s_182_2_q = ss "does Jones represent Jones' company";
lin s_182_3_h = ss "Jones represents Jones' company";

lin s_183_1_p = ss "Smith represents his company and so does Jones";
lin s_183_2_q = ss "does Jones represent Smith's company";
lin s_183_3_h = ss "Jones represents Smith's company";

lin s_184_1_p = ss "Smith represents his company and so does Jones";
lin s_184_2_q = ss "does Smith represent Jones' company";
lin s_184_3_h = ss "Smith represents Jones' company";

lin s_185_1_p = ss "Smith claimed he had costed his proposal and so did Jones";
lin s_185_2_q = ss "did Jones claim he had costed his own proposal";
lin s_185_3_h = ss "Jones claimed he had costed his own proposal";

lin s_186_1_p = ss "Smith claimed he had costed his proposal and so did Jones";
lin s_186_2_q = ss "did Jones claim he had costed Smith's proposal";
lin s_186_3_h = ss "Jones claimed he had costed Smith's proposal";

lin s_187_1_p = ss "Smith claimed he had costed his proposal and so did Jones";
lin s_187_2_q = ss "did Jones claim Smith had costed Smith's proposal";
lin s_187_3_h = ss "Jones claimed Smith had costed Smith's proposal";

lin s_188_1_p = ss "Smith claimed he had costed his proposal and so did Jones";
lin s_188_2_q = ss "did Jones claim Smith had costed Jones' proposal";
lin s_188_3_h = ss "Jones claimed Smith had costed Jones' proposal";

lin s_189_1_p = ss "John is a man and Mary is a woman";
lin s_189_2_p = ss "John represents his company and so does Mary";
lin s_189_3_q = ss "does Mary represent her own company";
lin s_189_4_h = ss "Mary represents her own company";

lin s_190_1_p = ss "John is a man and Mary is a woman";
lin s_190_2_p = ss "John represents his company and so does Mary";
lin s_190_3_q = ss "does Mary represent John's company";
lin s_190_4_h = ss "Mary represents John's company";

lin s_191_1_p = ss "Bill suggested to Frank's boss that they should go to the meeting together , and Carl [..] to Alan's wife";
lin s_191_2_q = ss "if it was suggested that Bill and Frank should go together , was it suggested that Carl and Alan should go together";
lin s_191_3_h = ss "if it was suggested that Bill and Frank should go together , it was suggested that Carl and Alan should go together";

lin s_192_1_p = ss "Bill suggested to Frank's boss that they should go to the meeting together , and Carl [..] to Alan's wife";
lin s_192_2_q = ss "if it was suggested that Bill and Frank should go together , was it suggested that Carl and Alan's wife should go together";
lin s_192_3_h = ss "if it was suggested that Bill and Frank should go together , it was suggested that Carl and Alan's wife should go together";

lin s_193_1_p = ss "Bill suggested to Frank's boss that they should go to the meeting together , and Carl [..] to Alan's wife";
lin s_193_2_q = ss "if it was suggested that Bill and Frank's boss should go together , was it suggested that Carl and Alan's wife should go together";
lin s_193_3_h = ss "if it was suggested that Bill and Frank's boss should go together , it was suggested that Carl and Alan's wife should go together";

lin s_194_1_p = ss "Bill suggested to Frank's boss that they should go to the meeting together , and Carl [..] to Alan's wife";
lin s_194_2_q = ss "if it was suggested that Bill and Frank's boss should go together , was it suggested that Carl and Alan should go together";
lin s_194_3_h = ss "if it was suggested that Bill and Frank's boss should go together , it was suggested that Carl and Alan should go together";

lin s_195_1_p = ss "Bill suggested to Frank's boss that they should go to the meeting together , and Carl [..] to Alan's wife";
lin s_195_2_q = ss "if it was suggested that Bill , Frank and Frank's boss should go together , was it suggested that Carl , Alan and Alan's wife should go together";
lin s_195_3_h = ss "if it was suggested that Bill , Frank and Frank's boss should go together , it was suggested that Carl , Alan and Alan's wife should go together";

lin s_196_1_p = ss "a lawyer signed every report , and so did an auditor";
lin s_196_2_p = ss "that is , there was one lawyer who signed all the reports";
lin s_196_3_q = ss "was there one auditor who signed all the reports";
lin s_196_4_h = ss "there was one auditor who signed all the reports";

lin s_197_1_p = ss "John has a genuine diamond";
lin s_197_2_q = ss "does John have a diamond";
lin s_197_3_h = ss "John has a diamond";

lin s_198_1_p = ss "John is a former university student";
lin s_198_2_q = ss "is John a university student";
lin s_198_3_h = ss "John is a university student";

lin s_199_1_p = ss "John is a successful former university student";
lin s_199_2_q = ss "is John successful";
lin s_199_3_h = ss "John is successful";

lin s_200_1_p = ss "John is a former successful university student";
lin s_200_2_q = ss "is John successful";
lin s_200_3_h = ss "John is successful";

lin s_201_1_p = ss "John is a former successful university student";
lin s_201_2_q = ss "is John a university student";
lin s_201_3_h = ss "John is a university student";

lin s_202_1_p = ss "every mammal is an animal";
lin s_202_2_q = ss "is every four-legged mammal a four-legged animal";
lin s_202_3_h = ss "every four-legged mammal is a four-legged animal";

lin s_203_1_p = ss "Dumbo is a four-legged animal";
lin s_203_2_q = ss "is Dumbo four-legged";
lin s_203_3_h = ss "Dumbo is four-legged";

lin s_204_1_p = ss "Mickey is a small animal";
lin s_204_2_q = ss "is Mickey a large animal";
lin s_204_3_h = ss "Mickey is a large animal";

lin s_205_1_p = ss "Dumbo is a large animal";
lin s_205_2_q = ss "is Dumbo a small animal";
lin s_205_3_h = ss "Dumbo is a small animal";

lin s_206_1_p = ss "Fido is not a small animal";
lin s_206_2_q = ss "is Fido a large animal";
lin s_206_3_h = ss "Fido is a large animal";

lin s_207_1_p = ss "Fido is not a large animal";
lin s_207_2_q = ss "is Fido a small animal";
lin s_207_3_h = ss "Fido is a small animal";

lin s_208_1_p = ss "Mickey is a small animal";
lin s_208_2_p = ss "Dumbo is a large animal";
lin s_208_3_q = ss "is Mickey smaller than Dumbo";
lin s_208_4_h = ss "Mickey is smaller than Dumbo";

lin s_209_1_p = ss "Mickey is a small animal";
lin s_209_2_p = ss "Dumbo is a large animal";
lin s_209_3_q = ss "is Mickey larger than Dumbo";
lin s_209_4_h = ss "Mickey is larger than Dumbo";

lin s_210_1_p = ss "all mice are small animals";
lin s_210_2_p = ss "Mickey is a large mouse";
lin s_210_3_q = ss "is Mickey a large animal";
lin s_210_4_h = ss "Mickey is a large animal";

lin s_211_1_p = ss "all elephants are large animals";
lin s_211_2_p = ss "Dumbo is a small elephant";
lin s_211_3_q = ss "is Dumbo a small animal";
lin s_211_4_h = ss "Dumbo is a small animal";

lin s_212_1_p = ss "all mice are small animals";
lin s_212_2_p = ss "all elephants are large animals";
lin s_212_3_p = ss "Mickey is a large mouse";
lin s_212_4_p = ss "Dumbo is a small elephant";
lin s_212_5_q = ss "is Dumbo larger than Mickey";
lin s_212_6_h = ss "Dumbo is larger than Mickey";

lin s_213_1_p = ss "all mice are small animals";
lin s_213_2_p = ss "Mickey is a large mouse";
lin s_213_3_q = ss "is Mickey small";
lin s_213_4_h = ss "Mickey is small";

lin s_214_1_p = ss "all legal authorities are law lecturers";
lin s_214_2_p = ss "all law lecturers are legal authorities";
lin s_214_3_q = ss "are all fat legal authorities fat law lecturers";
lin s_214_4_h = ss "all fat legal authorities are fat law lecturers";

lin s_215_1_p = ss "all legal authorities are law lecturers";
lin s_215_2_p = ss "all law lecturers are legal authorities";
lin s_215_3_q = ss "are all competent legal authorities competent law lecturers";
lin s_215_4_h = ss "all competent legal authorities are competent law lecturers";

lin s_216_1_p = ss "John is a fatter politician than Bill";
lin s_216_2_q = ss "is John fatter than Bill";
lin s_216_3_h = ss "John is fatter than Bill";

lin s_217_1_p = ss "John is a cleverer politician than Bill";
lin s_217_2_q = ss "is John cleverer than Bill";
lin s_217_3_h = ss "John is cleverer than Bill";

lin s_218_1_p = ss "Kim is a clever person";
lin s_218_2_q = ss "is Kim clever";
lin s_218_3_h = ss "Kim is clever";

lin s_219_1_p = ss "Kim is a clever politician";
lin s_219_2_q = ss "is Kim clever";
lin s_219_3_h = ss "Kim is clever";

lin s_220_1_p = ss "the PC-6082 is faster than the ITEL-XZ";
lin s_220_2_p = ss "the ITEL-XZ is fast";
lin s_220_3_q = ss "is the PC-6082 fast";
lin s_220_4_h = ss "the PC-6082 is fast";

lin s_221_1_p = ss "the PC-6082 is faster than the ITEL-XZ";
lin s_221_2_q = ss "is the PC-6082 fast";
lin s_221_3_h = ss "the PC-6082 is fast";

lin s_222_1_p = ss "the PC-6082 is faster than the ITEL-XZ";
lin s_222_2_p = ss "the PC-6082 is fast";
lin s_222_3_q = ss "is the ITEL-XZ fast";
lin s_222_4_h = ss "the ITEL-XZ is fast";

lin s_223_1_p = ss "the PC-6082 is faster than the ITEL-XZ";
lin s_223_2_p = ss "the PC-6082 is slow";
lin s_223_3_q = ss "is the ITEL-XZ fast";
lin s_223_4_h = ss "the ITEL-XZ is fast";

lin s_224_1_p = ss "the PC-6082 is as fast as the ITEL-XZ";
lin s_224_2_p = ss "the ITEL-XZ is fast";
lin s_224_3_q = ss "is the PC-6082 fast";
lin s_224_4_h = ss "the PC-6082 is fast";

lin s_225_1_p = ss "the PC-6082 is as fast as the ITEL-XZ";
lin s_225_2_q = ss "is the PC-6082 fast";
lin s_225_3_h = ss "the PC-6082 is fast";

lin s_226_1_p = ss "the PC-6082 is as fast as the ITEL-XZ";
lin s_226_2_p = ss "the PC-6082 is fast";
lin s_226_3_q = ss "is the ITEL-XZ fast";
lin s_226_4_h = ss "the ITEL-XZ is fast";

lin s_227_1_p = ss "the PC-6082 is as fast as the ITEL-XZ";
lin s_227_2_p = ss "the PC-6082 is slow";
lin s_227_3_q = ss "is the ITEL-XZ fast";
lin s_227_4_h = ss "the ITEL-XZ is fast";

lin s_228_1_p = ss "the PC-6082 is as fast as the ITEL-XZ";
lin s_228_2_q = ss "is the PC-6082 faster than the ITEL-XZ";
lin s_228_3_h = ss "the PC-6082 is faster than the ITEL-XZ";

lin s_229_1_p = ss "the PC-6082 is as fast as the ITEL-XZ";
lin s_229_2_q = ss "is the PC-6082 slower than the ITEL-XZ";
lin s_229_3_h = ss "the PC-6082 is slower than the ITEL-XZ";

lin s_230_1_p = ss "ITEL won more orders than APCOM did [..]";
lin s_230_2_q = ss "did ITEL win some orders";
lin s_230_3_h = ss "ITEL won some orders";

lin s_231_1_p = ss "ITEL won more orders than APCOM did [..]";
lin s_231_2_q = ss "did APCOM win some orders";
lin s_231_3_h = ss "APCOM won some orders";

lin s_232_1_p = ss "ITEL won more orders than APCOM did [..]";
lin s_232_2_p = ss "APCOM won ten orders";
lin s_232_3_q = ss "did ITEL win at least eleven orders";
lin s_232_4_h = ss "ITEL won at least eleven orders";

lin s_233_1_p = ss "ITEL won more orders than APCOM";
lin s_233_2_q = ss "did ITEL win some orders";
lin s_233_3_h = ss "ITEL won some orders";

lin s_234_1_p = ss "ITEL won more orders than APCOM";
lin s_234_2_q = ss "did APCOM win some orders";
lin s_234_3_h = ss "APCOM won some orders";

lin s_235_1_p = ss "ITEL won more orders than APCOM";
lin s_235_2_p = ss "APCOM won ten orders";
lin s_235_3_q = ss "did ITEL win at least eleven orders";
lin s_235_4_h = ss "ITEL won at least eleven orders";

lin s_236_1_p = ss "ITEL won more orders than the APCOM contract";
lin s_236_2_q = ss "did ITEL win the APCOM contract";
lin s_236_3_h = ss "ITEL won the APCOM contract";

lin s_237_1_p = ss "ITEL won more orders than the APCOM contract";
lin s_237_2_q = ss "did ITEL win more than one order";
lin s_237_3_h = ss "ITEL won more than one order";

lin s_238_1_p = ss "ITEL won twice as many orders than APCOM";
lin s_238_2_p = ss "APCOM won ten orders";
lin s_238_3_q = ss "did ITEL win twenty orders";
lin s_238_4_h = ss "ITEL won twenty orders";

lin s_239_1_p = ss "ITEL won more orders than APCOM lost [..]";
lin s_239_2_q = ss "did ITEL win some orders";
lin s_239_3_h = ss "ITEL won some orders";

lin s_240_1_p = ss "ITEL won more orders than APCOM lost [..]";
lin s_240_2_q = ss "did APCOM lose some orders";
lin s_240_3_h = ss "APCOM lost some orders";

lin s_241_1_p = ss "ITEL won more orders than APCOM lost [..]";
lin s_241_2_p = ss "APCOM lost ten orders";
lin s_241_3_q = ss "did ITEL win at least eleven orders";
lin s_241_4_h = ss "ITEL won at least eleven orders";

lin s_242_1_p = ss "the PC-6082 is faster than 500 MIPS";
lin s_242_2_p = ss "the ITEL-ZX is slower than 500 MIPS";
lin s_242_3_q = ss "is the PC-6082 faster than the ITEL-ZX";
lin s_242_4_h = ss "the PC-6082 is faster than the ITEL-ZX";

lin s_243_1_p = ss "ITEL sold 3000 more computers than APCOM";
lin s_243_2_p = ss "APCOM sold exactly 2500 computers";
lin s_243_3_q = ss "did ITEL sell 5500 computers";
lin s_243_4_h = ss "ITEL sold 5500 computers";

lin s_244_1_p = ss "APCOM has a more important customer than ITEL";
lin s_244_2_q = ss "does APCOM have a more important customer than ITEL is [..]";
lin s_244_3_h = ss "APCOM has a more important customer than ITEL is [..]";

lin s_245_1_p = ss "APCOM has a more important customer than ITEL";
lin s_245_2_q = ss "does APCOM have a more important customer than ITEL has [..]";
lin s_245_3_h = ss "APCOM has a more important customer than ITEL has [..]";

lin s_246_1_p = ss "the PC-6082 is faster than every ITEL computer";
lin s_246_2_p = ss "the ITEL-ZX is an ITEL computer";
lin s_246_3_q = ss "is the PC-6082 faster than the ITEL-ZX";
lin s_246_4_h = ss "the PC-6082 is faster than the ITEL-ZX";

lin s_247_1_p = ss "the PC-6082 is faster than some ITEL computer";
lin s_247_2_p = ss "the ITEL-ZX is an ITEL computer";
lin s_247_3_q = ss "is the PC-6082 faster than the ITEL-ZX";
lin s_247_4_h = ss "the PC-6082 is faster than the ITEL-ZX";

lin s_248_1_p = ss "the PC-6082 is faster than any ITEL computer";
lin s_248_2_p = ss "the ITEL-ZX is an ITEL computer";
lin s_248_3_q = ss "is the PC-6082 faster than the ITEL-ZX";
lin s_248_4_h = ss "the PC-6082 is faster than the ITEL-ZX";

lin s_249_1_p = ss "the PC-6082 is faster than the ITEL-ZX and the ITEL-ZY";
lin s_249_2_q = ss "is the PC-6082 faster than the ITEL-ZX";
lin s_249_3_h = ss "the PC-6082 is faster than the ITEL-ZX";

lin s_250_1_p = ss "the PC-6082 is faster than the ITEL-ZX or the ITEL-ZY";
lin s_250_2_q = ss "is the PC-6082 faster than the ITEL-ZX";
lin s_250_3_h = ss "the PC-6082 is faster than the ITEL-ZX";

lin s_251_1_p = ss "ITEL has a factory in Birmingham";
lin s_251_2_q = ss "does ITEL currently have a factory in Birmingham";
lin s_251_3_h = ss "ITEL currently has a factory in Birmingham";

lin s_252_1_p = ss "since 1992 ITEL has been in Birmingham";
lin s_252_2_p = ss "it is now 1996";
lin s_252_3_q = ss "was ITEL in Birmingham in 1993";
lin s_252_4_h = ss "ITEL was in Birmingham in 1993";

lin s_253_1_p = ss "ITEL has developed a new editor since 1992";
lin s_253_2_p = ss "it is now 1996";
lin s_253_3_q = ss "did ITEL develop a new editor in 1993";
lin s_253_4_h = ss "ITEL developed a new editor in 1993";

lin s_254_1_p = ss "ITEL has expanded since 1992";
lin s_254_2_p = ss "it is now 1996";
lin s_254_3_q = ss "did ITEL expand in 1993";
lin s_254_4_h = ss "ITEL expanded in 1993";

lin s_255_1_p = ss "since 1992 ITEL has made a loss";
lin s_255_2_p = ss "it is now 1996";
lin s_255_3_q = ss "did ITEL make a loss in 1993";
lin s_255_4_h = ss "ITEL made a loss in 1993";

lin s_256_1_p = ss "ITEL has made a loss since 1992";
lin s_256_2_p = ss "it is now 1996";
lin s_256_3_q = ss "did ITEL make a loss in 1993";
lin s_256_4_h = ss "ITEL made a loss in 1993";

lin s_257_1_p = ss "ITEL has made a loss since 1992";
lin s_257_2_p = ss "it is now 1996";
lin s_257_3_q = ss "did ITEL make a loss in 1993";
lin s_257_4_h = ss "ITEL made a loss in 1993";

lin s_258_1_p = ss "in March 1993 APCOM founded ITEL";
lin s_258_2_q = ss "did ITEL exist in 1992";
lin s_258_3_h = ss "ITEL existed in 1992";

lin s_259_1_p = ss "the conference started on July 4th , 1994";
lin s_259_2_p = ss "it lasted 2 days";
lin s_259_3_q = ss "was the conference over on July 8th , 1994";
lin s_259_4_h = ss "the conference was over on July 8th , 1994";

lin s_260_1_p = ss "yesterday APCOM signed the contract";
lin s_260_2_p = ss "today is Saturday , July 14th";
lin s_260_3_q = ss "did APCOM sign the contract Friday , 13th";
lin s_260_4_h = ss "APCOM signed the contract Friday , 13th";

lin s_261_1_p = ss "Smith left before Jones left";
lin s_261_2_p = ss "Jones left before Anderson left";
lin s_261_3_q = ss "did Smith leave before Anderson left";
lin s_261_4_h = ss "Smith left before Anderson left";

lin s_262_1_p = ss "Smith left after Jones left";
lin s_262_2_p = ss "Jones left after Anderson left";
lin s_262_3_q = ss "did Smith leave after Anderson left";
lin s_262_4_h = ss "Smith left after Anderson left";

lin s_263_1_p = ss "Smith was present after Jones left";
lin s_263_2_p = ss "Jones left after Anderson was present";
lin s_263_3_q = ss "was Smith present after Anderson was present";
lin s_263_4_h = ss "Smith was present after Anderson was present";

lin s_264_1_p = ss "Smith left";
lin s_264_2_p = ss "Jones left";
lin s_264_3_p = ss "Smith left before Jones left";
lin s_264_4_q = ss "did Jones leave after Smith left";
lin s_264_5_h = ss "Jones left after Smith left";

lin s_265_1_p = ss "Smith left";
lin s_265_2_p = ss "Jones left";
lin s_265_3_p = ss "Smith left after Jones left";
lin s_265_4_q = ss "did Jones leave before Smith left";
lin s_265_5_h = ss "Jones left before Smith left";

lin s_266_1_p = ss "Smith left";
lin s_266_2_p = ss "Jones left";
lin s_266_3_p = ss "Jones left before Smith left";
lin s_266_4_q = ss "did Smith leave after Jones left";
lin s_266_5_h = ss "Smith left after Jones left";

lin s_267_1_p = ss "Jones revised the contract";
lin s_267_2_p = ss "Smith revised the contract";
lin s_267_3_p = ss "Jones revised the contract before Smith did [..]";
lin s_267_4_q = ss "did Smith revise the contract after Jones did [..]";
lin s_267_5_h = ss "Smith revised the contract after Jones did [..]";

lin s_268_1_p = ss "Jones revised the contract";
lin s_268_2_p = ss "Smith revised the contract";
lin s_268_3_p = ss "Jones revised the contract after Smith did [..]";
lin s_268_4_q = ss "did Smith revise the contract before Jones did [..]";
lin s_268_5_h = ss "Smith revised the contract before Jones did [..]";

lin s_269_1_p = ss "Smith swam";
lin s_269_2_p = ss "Jones swam";
lin s_269_3_p = ss "Smith swam before Jones swam";
lin s_269_4_q = ss "did Jones swim after Smith swam";
lin s_269_5_h = ss "Jones swam after Smith swam";

lin s_270_1_p = ss "Smith swam to the shore";
lin s_270_2_p = ss "Jones swam to the shore";
lin s_270_3_p = ss "Smith swam to the shore before Jones swam to the shore";
lin s_270_4_q = ss "did Jones swim to the shore after Smith swam to the shore";
lin s_270_5_h = ss "Jones swam to the shore after Smith swam to the shore";

lin s_271_1_p = ss "Smith was present";
lin s_271_2_p = ss "Jones was present";
lin s_271_3_p = ss "Smith was present after Jones was present";
lin s_271_4_q = ss "was Jones present before Smith was present";
lin s_271_5_h = ss "Jones was present before Smith was present";

lin s_272_1_p = ss "Smith was present";
lin s_272_2_p = ss "Jones was present";
lin s_272_3_p = ss "Smith was present before Jones was present";
lin s_272_4_q = ss "was Jones present after Smith was present";
lin s_272_5_h = ss "Jones was present after Smith was present";

lin s_273_1_p = ss "Smith was writing a report";
lin s_273_2_p = ss "Jones was writing a report";
lin s_273_3_p = ss "Smith was writing a report before Jones was writing a report";
lin s_273_4_q = ss "was Jones writing a report after Smith was writing a report";
lin s_273_5_h = ss "Jones was writing a report after Smith was writing a report";

lin s_274_1_p = ss "Smith was writing a report";
lin s_274_2_p = ss "Jones was writing a report";
lin s_274_3_p = ss "Smith was writing a report after Jones was writing a report";
lin s_274_4_q = ss "was Jones writing a report before Smith was writing a report";
lin s_274_5_h = ss "Jones was writing a report before Smith was writing a report";

lin s_275_1_p = ss "Smith left the meeting before he lost his temper";
lin s_275_2_q = ss "did Smith lose his temper";
lin s_275_3_h = ss "Smith lost his temper";

lin s_276_1_p = ss "when they opened the M25 , traffic increased";

lin s_277_1_p = ss "Smith lived in Birmingham in 1991";
lin s_277_2_q = ss "did Smith live in Birmingham in 1992";
lin s_277_3_h = ss "Smith lived in Birmingham in 1992";

lin s_278_1_p = ss "Smith wrote his first novel in 1991";
lin s_278_2_q = ss "did Smith write his first novel in 1992";
lin s_278_3_h = ss "Smith wrote his first novel in 1992";

lin s_279_1_p = ss "Smith wrote a novel in 1991";
lin s_279_2_q = ss "did Smith write it in 1992";
lin s_279_3_h = ss "Smith wrote it in 1992";

lin s_280_1_p = ss "Smith wrote a novel in 1991";
lin s_280_2_q = ss "did Smith write a novel in 1992";
lin s_280_3_h = ss "Smith wrote a novel in 1992";

lin s_281_1_p = ss "Smith was running a business in 1991";
lin s_281_2_q = ss "was Smith running it in 1992";
lin s_281_3_h = ss "Smith was running it in 1992";

lin s_282_1_p = ss "Smith discovered a new species in 1991";
lin s_282_2_q = ss "did Smith discover it in 1992";
lin s_282_3_h = ss "Smith discovered it in 1992";

lin s_283_1_p = ss "Smith discovered a new species in 1991";
lin s_283_2_q = ss "did Smith discover a new species in 1992";
lin s_283_3_h = ss "Smith discovered a new species in 1992";

lin s_284_1_p = ss "Smith wrote a report in two hours";
lin s_284_2_p = ss "Smith started writing the report at 8 am";
lin s_284_3_q = ss "had Smith finished writing the report by 11 am";
lin s_284_4_h = ss "Smith had finished writing the report by 11 am";

lin s_285_1_p = ss "Smith wrote a report in two hours";
lin s_285_2_q = ss "did Smith spend two hours writing the report";
lin s_285_3_h = ss "Smith spent two hours writing the report";

lin s_286_1_p = ss "Smith wrote a report in two hours";
lin s_286_2_q = ss "did Smith spend more than two hours writing the report";
lin s_286_3_h = ss "Smith spent more than two hours writing the report";

lin s_287_1_p = ss "Smith wrote a report in two hours";
lin s_287_2_q = ss "did Smith write a report in one hour";
lin s_287_3_h = ss "Smith wrote a report in one hour";

lin s_288_1_p = ss "Smith wrote a report in two hours";
lin s_288_2_q = ss "did Smith write a report";
lin s_288_3_h = ss "Smith wrote a report";

lin s_289_1_p = ss "Smith discovered a new species in two hours";
lin s_289_2_q = ss "did Smith spend two hours discovering the new species";
lin s_289_3_h = ss "Smith spent two hours discovering the new species";

lin s_290_1_p = ss "Smith discovered a new species in two hours";
lin s_290_2_q = ss "did Smith discover a new species";
lin s_290_3_h = ss "Smith discovered a new species";

lin s_291_1_p = ss "Smith discovered many new species in two hours";
lin s_291_2_q = ss "did Smith spend two hours discovering new species";
lin s_291_3_h = ss "Smith spent two hours discovering new species";

lin s_292_1_p = ss "Smith was running his own business in two years";
lin s_292_2_q = ss "did Smith spend two years running his own business";
lin s_292_3_h = ss "Smith spent two years running his own business";

lin s_293_1_p = ss "Smith was running his own business in two years";
lin s_293_2_q = ss "did Smith spend more than two years running his own business";
lin s_293_3_h = ss "Smith spent more than two years running his own business";

lin s_294_1_p = ss "Smith was running his own business in two years";
lin s_294_2_q = ss "did Smith run his own business";
lin s_294_3_h = ss "Smith ran his own business";

lin s_295_1_p = ss "in two years Smith owned a chain of businesses";
lin s_295_2_q = ss "did Smith own a chain of business for two years";
lin s_295_3_h = ss "Smith owned a chain of business for two years";

lin s_296_1_p = ss "in two years Smith owned a chain of businesses";
lin s_296_2_q = ss "did Smith own a chain of business for more than two years";
lin s_296_3_h = ss "Smith owned a chain of business for more than two years";

lin s_297_1_p = ss "in two years Smith owned a chain of businesses";
lin s_297_2_q = ss "did Smith own a chain of business";
lin s_297_3_h = ss "Smith owned a chain of business";

lin s_298_1_p = ss "Smith lived in Birmingham for two years";
lin s_298_2_q = ss "did Smith live in Birmingham for a year";
lin s_298_3_h = ss "Smith lived in Birmingham for a year";

lin s_299_1_p = ss "Smith lived in Birmingham for two years";
lin s_299_2_q = ss "did Smith live in Birmingham for exactly a year";
lin s_299_3_h = ss "Smith lived in Birmingham for exactly a year";

lin s_300_1_p = ss "Smith lived in Birmingham for two years";
lin s_300_2_q = ss "did Smith live in Birmingham";
lin s_300_3_h = ss "Smith lived in Birmingham";

lin s_301_1_p = ss "Smith ran his own business for two years";
lin s_301_2_q = ss "did Smith run his own business for a year";
lin s_301_3_h = ss "Smith ran his own business for a year";

lin s_302_1_p = ss "Smith ran his own business for two years";
lin s_302_2_q = ss "did Smith run his own business";
lin s_302_3_h = ss "Smith ran his own business";

lin s_303_1_p = ss "Smith wrote a report for two hours";
lin s_303_2_q = ss "did Smith write a report for an hour";
lin s_303_3_h = ss "Smith wrote a report for an hour";

lin s_304_1_p = ss "Smith wrote a report for two hours";
lin s_304_2_q = ss "did Smith write a report";
lin s_304_3_h = ss "Smith wrote a report";

lin s_305_1_p = ss "Smith discovered a new species for an hour";

lin s_306_1_p = ss "Smith discovered new species for two years";
lin s_306_2_q = ss "did Smith discover new species";
lin s_306_3_h = ss "Smith discovered new species";

lin s_307_1_p = ss "in 1994 ITEL sent a progress report every month";
lin s_307_2_q = ss "did ITEL send a progress report in July 1994";
lin s_307_3_h = ss "ITEL sent a progress report in July 1994";

lin s_308_1_p = ss "Smith wrote to a representative every week";
lin s_308_2_q = ss "is there a representative that Smith wrote to every week";
lin s_308_3_h = ss "there is a representative that Smith wrote to every week";

lin s_309_1_p = ss "Smith left the house at a quarter past five";
lin s_309_2_p = ss "she took a taxi to the station and caught the first train to Luxembourg";

lin s_310_1_p = ss "Smith lost some files";
lin s_310_2_p = ss "they were destroyed when her hard disk crashed";

lin s_311_1_p = ss "Smith had left the house at a quarter past five";
lin s_311_2_p = ss "then she took a taxi to the station";
lin s_311_3_q = ss "did Smith leave the house before she took a taxi to the station";
lin s_311_4_h = ss "Smith left the house before she took a taxi to the station";

lin s_312_1_p = ss "ITEL always delivers reports late";
lin s_312_2_p = ss "in 1993 ITEL delivered reports";
lin s_312_3_q = ss "did ITEL deliver reports late in 1993";
lin s_312_4_h = ss "ITEL delivered reports late in 1993";

lin s_313_1_p = ss "ITEL never delivers reports late";
lin s_313_2_p = ss "in 1993 ITEL delivered reports";
lin s_313_3_q = ss "did ITEL deliver reports late in 1993";
lin s_313_4_h = ss "ITEL delivered reports late in 1993";

lin s_314_1_p = ss "Smith arrived in Paris on the 5th of May , 1995";
lin s_314_2_p = ss "today is the 15th of May , 1995";
lin s_314_3_p = ss "she is still in Paris";
lin s_314_4_q = ss "was Smith in Paris on the 7th of May , 1995";
lin s_314_5_h = ss "Smith was in Paris on the 7th of May , 1995";

lin s_315_1_p = ss "when Smith arrived in Katmandu she had been travelling for three days";
lin s_315_2_q = ss "had Smith been travelling the day before she arrived in Katmandu";
lin s_315_3_h = ss "Smith had been travelling the day before she arrived in Katmandu";
lin s_315_3_h_NEW = ss "Smith had been travelling on the day before she arrived in Katmandu";

lin s_316_1_p = ss "Jones graduated in March and has been employed ever since";
lin s_316_2_p = ss "Jones has been unemployed in the past";
lin s_316_3_q = ss "was Jones unemployed at some time before he graduated";
lin s_316_4_h = ss "Jones was unemployed at some time before he graduated";

lin s_317_1_p = ss "every representative has read this report";
lin s_317_2_p = ss "no two representatives have read it at the same time";
lin s_317_3_p = ss "no representative took less than half a day to read the report";
lin s_317_4_p = ss "there are sixteen representatives";
lin s_317_5_q = ss "did it take the representatives more than a week to read the report";
lin s_317_6_h = ss "it took the representatives more than a week to read the report";

lin s_318_1_p = ss "while Jones was updating the program , Mary came in and told him about the board meeting";
lin s_318_2_p = ss "she finished [..] before he did [..]";
lin s_318_3_q = ss "did Mary's story last as long as Jones' updating the program";
lin s_318_4_h = ss "Mary's story lasted as long as Jones' updating the program";

lin s_319_1_p = ss "before APCOM bought its present office building , it had been paying mortgage interest on the previous one for 8 years";
lin s_319_2_p = ss "since APCOM bought its present office building it has been paying mortgage interest on it for more than 10 years";
lin s_319_3_q = ss "has APCOM been paying mortgage interest for a total of 15 years or more";
lin s_319_4_h = ss "APCOM has been paying mortgage interest for a total of 15 years or more";

lin s_320_1_p = ss "when Jones got his job at the CIA , he knew that he would never be allowed to write his memoirs";
lin s_320_2_q = ss "is it the case that Jones is not and will never be allowed to write his memoirs";
lin s_320_3_h = ss "it is the case that Jones is not and will never be allowed to write his memoirs";
lin s_320_3_h_NEW = ss "it is the case that Jones is not [..] and never will be allowed to write his memoirs";

lin s_321_1_p = ss "Smith has been to Florence twice in the past";
lin s_321_2_p = ss "Smith will go to Florence twice in the coming year";
lin s_321_3_q = ss "two years from now will Smith have been to Florence at least four times";
lin s_321_4_h = ss "two years from now Smith will have been to Florence at least four times";

lin s_322_1_p = ss "last week I already knew that when , in a month's time , Smith would discover that she had been duped she would be furious";
lin s_322_1_p_NEW = ss "last week I already knew that when in a month's time , Smith would discover that she had been duped , she would be furious";
lin s_322_2_q = ss "will it be the case that in a few weeks Smith will discover that she has been duped; and will she be furious";
lin s_322_3_h = ss "it will be the case that in a few weeks Smith will discover that she has been duped; and she will be furious";

lin s_323_1_p = ss "no one gambling seriously stops until he is broke";
lin s_323_1_p_NEW = ss "no one who is gambling seriously stops until he is broke";
lin s_323_2_p = ss "no one can gamble when he is broke";
lin s_323_3_q = ss "does everyone who starts gambling seriously stop the moment he is broke";
lin s_323_4_h = ss "everyone who starts gambling seriously stops the moment he is broke";
lin s_323_4_h_NEW = ss "everyone who starts gambling seriously stops at the moment when he is broke";

lin s_324_1_p = ss "no one who starts gambling seriously stops until he is broke";
lin s_324_2_q = ss "does everyone who starts gambling seriously continue until he is broke";
lin s_324_3_h = ss "everyone who starts gambling seriously continues until he is broke";

lin s_325_1_p = ss "nobody who is asleep ever knows that he is asleep";
lin s_325_2_p = ss "but some people know that they have been asleep after they have been asleep";
lin s_325_3_q = ss "do some people discover that they have been asleep";
lin s_325_4_h = ss "some people discover that they have been asleep";

lin s_326_1_p = ss "ITEL built MTALK in 1993";
lin s_326_2_q = ss "did ITEL finish MTALK in 1993";
lin s_326_3_h = ss "ITEL finished MTALK in 1993";

lin s_327_1_p = ss "ITEL was building MTALK in 1993";
lin s_327_2_q = ss "did ITEL finish MTALK in 1993";
lin s_327_3_h = ss "ITEL finished MTALK in 1993";

lin s_328_1_p = ss "ITEL won the contract from APCOM in 1993";
lin s_328_2_q = ss "did ITEL win a contract in 1993";
lin s_328_3_h = ss "ITEL won a contract in 1993";

lin s_329_1_p = ss "ITEL was winning the contract from APCOM in 1993";
lin s_329_2_q = ss "did ITEL win a contract in 1993";
lin s_329_3_h = ss "ITEL won a contract in 1993";

lin s_330_1_p = ss "ITEL owned APCOM from 1988 to 1992";
lin s_330_2_q = ss "did ITEL own APCOM in 1990";
lin s_330_3_h = ss "ITEL owned APCOM in 1990";

lin s_331_1_p = ss "Smith and Jones left the meeting";
lin s_331_2_q = ss "did Smith leave the meeting";
lin s_331_3_h = ss "Smith left the meeting";

lin s_332_1_p = ss "Smith and Jones left the meeting";
lin s_332_2_q = ss "did Jones leave the meeting";
lin s_332_3_h = ss "Jones left the meeting";

lin s_333_1_p = ss "Smith , Anderson and Jones met";
lin s_333_2_q = ss "was there a group of people that met";
lin s_333_3_h = ss "there was a group of people that met";

lin s_334_1_p = ss "Smith knew that ITEL had won the contract in 1992";
lin s_334_2_q = ss "did ITEL win the contract in 1992";
lin s_334_3_h = ss "ITEL won the contract in 1992";

lin s_335_1_p = ss "Smith believed that ITEL had won the contract in 1992";
lin s_335_2_q = ss "did ITEL win the contract in 1992";
lin s_335_3_h = ss "ITEL won the contract in 1992";

lin s_336_1_p = ss "ITEL managed to win the contract in 1992";
lin s_336_2_q = ss "did ITEL win the contract in 1992";
lin s_336_3_h = ss "ITEL won the contract in 1992";

lin s_337_1_p = ss "ITEL tried to win the contract in 1992";
lin s_337_2_q = ss "did ITEL win the contract in 1992";
lin s_337_3_h = ss "ITEL won the contract in 1992";

lin s_338_1_p = ss "it is true that ITEL won the contract in 1992";
lin s_338_2_q = ss "did ITEL win the contract in 1992";
lin s_338_3_h = ss "ITEL won the contract in 1992";

lin s_339_1_p = ss "it is false that ITEL won the contract in 1992";
lin s_339_2_q = ss "did ITEL win the contract in 1992";
lin s_339_3_h = ss "ITEL won the contract in 1992";

lin s_340_1_p = ss "Smith saw Jones sign the contract";
lin s_340_2_p = ss "if Jones signed the contract , his heart was beating";
lin s_340_3_q = ss "did Smith see Jones' heart beat";
lin s_340_4_h = ss "Smith saw Jones' heart beat";

lin s_341_1_p = ss "Smith saw Jones sign the contract";
lin s_341_2_p = ss "when Jones signed the contract , his heart was beating";
lin s_341_3_q = ss "did Smith see Jones' heart beat";
lin s_341_4_h = ss "Smith saw Jones' heart beat";

lin s_342_1_p = ss "Smith saw Jones sign the contract";
lin s_342_2_q = ss "did Jones sign the contract";
lin s_342_3_h = ss "Jones signed the contract";

lin s_343_1_p = ss "Smith saw Jones sign the contract";
lin s_343_2_p = ss "Jones is the chairman of ITEL";
lin s_343_3_q = ss "did Smith see the chairman of ITEL sign the contract";
lin s_343_4_h = ss "Smith saw the chairman of ITEL sign the contract";

lin s_344_1_p = ss "Helen saw the chairman of the department answer the phone";
lin s_344_2_p = ss "the chairman of the department is a person";
lin s_344_3_q = ss "is there anyone whom Helen saw answer the phone";
lin s_344_4_h = ss "there is someone whom Helen saw answer the phone";

lin s_345_1_p = ss "Smith saw Jones sign the contract and [..] his secretary make a copy";
lin s_345_2_q = ss "did Smith see Jones sign the contract";
lin s_345_3_h = ss "Smith saw Jones sign the contract";

lin s_346_1_p = ss "Smith saw Jones sign the contract or [..] [..] cross out the crucial clause";
lin s_346_2_q = ss "did Smith either see Jones sign the contract or see Jones cross out the crucial clause";
lin s_346_3_h = ss "Smith either saw Jones sign the contract or saw Jones cross out the crucial clause";

}
