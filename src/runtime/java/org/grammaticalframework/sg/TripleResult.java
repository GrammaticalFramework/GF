package org.grammaticalframework.sg;

import java.io.Closeable;
import org.grammaticalframework.pgf.Expr;

public class TripleResult implements Closeable {
	public native boolean hasNext();
	public native void close();

	public long getKey() {
		return key;
	}

	public Expr getSubject() {
		return subj;
	}

	public Expr getPredicate() {
		return pred;
	}

	public Expr getObject() {
		return obj;
	}
	
	//////////////////////////////////////////////////////////////////
	// private stuff
	private long ref;
	private long key;
	private Expr subj;
	private Expr pred;
	private Expr obj;

	private TripleResult(long ref, Expr subj, Expr pred, Expr obj) {
		this.ref  = ref;
		this.subj = subj;
		this.pred = pred;
		this.obj  = obj;
	}
}
