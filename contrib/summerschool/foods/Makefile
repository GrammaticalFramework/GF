
all:: Foods.pgf

Foods.pgf: Foods???.gf
	gf -make -s -optimize-pgf Foods???.gf

exper: Foods???.gf
	gf -make -s -optimize-pgf Foods???.gf FoodsThai.gf

clean:
	rm -rf *.gfo Foods.pgf
