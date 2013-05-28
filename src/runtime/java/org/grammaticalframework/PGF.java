package org.grammaticalframework;

public class PGF {
	static native PGF readPGF(String path); 

	private int pool;
	private int gr;
	
	private PGF(int pool, int gr) {
		this.pool = pool;
		this.gr   = gr;
	}
	
	static { 
         System.loadLibrary("jpgf");
    }
    
    public void test() {
		System.out.println("pool="+pool+", gr="+gr);
	}
	
    public static void main(String[] args) {
		readPGF("/home/krasimir/www.grammaticalframework.org/treebanks/PennTreebank/ParseEngAbs.pgf").test();
	}
}
