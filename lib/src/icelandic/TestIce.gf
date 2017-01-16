concrete TestIce of Test = GrammarIce ** open ParadigmsIce,Prelude in {
	lin
		--Some prefabricated nouns:
		man_N = mkN "maður" "mann" "manni" "manns" "menn" "menn" "mönnum" "manna" masculine;
		woman_N = mkN "kona" "konu" "konu" "konu" "konur" "konur" "konum" "kvenna" feminine;
		house_N = mkN "hús" "hús" "húsi" "húss" "hús" "hús" "húsum" "húsa" neuter;
		tree_N = mkN "tré" "tré" "tré" "trés" "tré" "tré" "trjáum" "trjáa" neuter;

		--Some prefabricated adjectives:
		big_A = mkA "stór" "stóran" "stórum" "stórs" "stór" "stóra" "stórri" "stórrar" "stórt" "stórt" "stóru" "stórs" "stórir" "stóra" "stórum" "stórra" "stórar" "stórar" "stórum" "stórra" "stór" "stór" "stórum" "stórra" "stóri" "stóra" "stóra" "stóru" "stóra" "stóru" True;
		small_A = mkA "lítill" "lítinn" "litlum" "lítils" "lítil" "litla" "lítilli" "lítillar" "lítið" "lítið" "litlu" "lítils" "litlir" "litla" "litlum" "lítilla" "litlar" "litlar" "litlum" "lítilla" "lítil" "lítil" "litlum" "lítilla" "litli" "litla" "litla" "litlu" "litla" "litlu" True;
		green_A = mkA "grænn" "grænan" "grænum" "grænans" "græn" "græna" "grænni" "grænnar" "grænt" "grænt" "grænu" "græns" "grænir" "græna" "grænum" "grænna" "grænar" "grænar" "grænum" "grænna" "græn" "græn" "grænum" "grænna" "græni" "græna" "græna" "grænu" "græna" "grænu" True; 

		--Some prefabricated verbs:
		walk_V = mkV "ganga" "geng" "gengur" "gengur" "göngum" "gangið" "ganga" "gekk" "gekkst" "gekk" "gengum" "genguð" "gengu" "gengið";
		arrive_V = mkV "koma" "kem" "kemur" "kemur" "komum" "komið" "koma" "kom" "komst" "kom" "komum" "komuð" "komu" "komið";

		--Some prefabricated two-place verbs (the acc is taken, as far as I know that is the "unmarked" case that verbs inlfect? on the subject):
		love_V2 = mkV2 "elska" "elska" "elskar" "elskar" "elskum" "elskið" "elska" "elskaði" "elskaðir" "elskaði" "elskuðum" "elskuðuð" "elskuðu" "elskað" accusative;
		please_V2 = mkV2 "gleðja" "gleð" "gleður" "gleður" "gleðjum" "gleðjið" "gleðja" "gladdi" "gladdir" "gladdi" "glöddum" "glödduð" "glöddu" "glatt" accusative;
}
