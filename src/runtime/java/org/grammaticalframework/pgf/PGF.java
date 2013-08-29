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
	private Pool pool;
	private long ref;

	private PGF(long pool, long ref) {
		this.pool = new Pool(pool);
		this.ref  = ref;
	}
	
	static { 
         System.loadLibrary("jpgf");
    }
}
