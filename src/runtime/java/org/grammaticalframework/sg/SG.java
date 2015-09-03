package org.grammaticalframework.sg;

import java.io.Closeable;
import org.grammaticalframework.pgf.Expr;

public class SG implements Closeable {
	public static native SG openSG(String path);
	public native void close();
	public native TripleResult queryTriple(Expr subj, Expr pred, Expr obj);

	//////////////////////////////////////////////////////////////////
	// private stuff
	private long ref;

	private SG(long ref) {
		this.ref  = ref;
	}

	static {
		System.loadLibrary("jpgf");
	}
}
