package org.grammaticalframework.pgf;

import java.io.*;
import java.util.*;

public class PGF {
	public static native PGF readPGF(String path) throws FileNotFoundException; 

	public native String getAbstractName();

	public native Map<String,Concr> getLanguages();

	public native List<String> getCategories();
	
	public native String getStartCat();
	
	public native List<String> getFunctions();
	
	public native List<String> getFunctionsByCat(String cat);
	
	public native Type getFunctionType(String fun);

	public native Iterator<ExprProb> generate(Type type);

	public native Expr compute(Expr expr);

	//////////////////////////////////////////////////////////////////
	// private stuff
	
	private static native void free(long pool);

	private long pool;
	private long ref;

	private PGF(long pool, long ref) {
		this.pool = pool;
		this.ref  = ref;
	}

	protected void finalize () throws Throwable {
		if (pool != 0) {
			free(pool);
			pool = 0;
			ref = 0;
		}
	}
	
	static { 
         System.loadLibrary("jpgf");
    }
}
