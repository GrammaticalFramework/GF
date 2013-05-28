package org.grammaticalframework;

public class PGF {
	public  static native PGF readPGF(String path); 
	
	public void close() {
		if (pool != 0) {
			free(pool);
			pool = 0;
			gr = 0;
		}
	}

	private static native void free(long pool);

	private long pool;
	private long gr;
	
	private PGF(long pool, long gr) {
		this.pool = pool;
		this.gr   = gr;
	}
	
	protected void finalize () throws Throwable {
		close();
	}
	
	static { 
         System.loadLibrary("jpgf");
    }
}
