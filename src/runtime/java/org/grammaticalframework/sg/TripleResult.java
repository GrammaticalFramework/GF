package org.grammaticalframework.sg;

import java.io.Closeable;
import org.grammaticalframework.pgf.Expr;

public class TripleResult implements Closeable {
	private Expr subj;
	private Expr pred;
	private Expr obj;

	public native boolean hasNext();
	public native void close();
	
	public Expr getSubject() {
		return subj;
	}

	public Expr getPredicate() {
		return pred;
	}

	public Expr getObject() {
		return obj;
	}
}
