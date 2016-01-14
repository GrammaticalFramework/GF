package org.grammaticalframework.sg;

import java.io.Closeable;
import org.grammaticalframework.pgf.Expr;

/** This class is used to iterate over a list of triples.
 * To move to the next triple, call {@link TripleResult#hasNext}.
 * When you do not need the iterator anymore then call {@link TripleResult#close}
 * to release the allocated resources.
 */
public class TripleResult implements Closeable {
	public native boolean hasNext();
	
	/** Closes the iterator and releases the allocated resources. */
	public native void close();

	/** Each triple has an unique integer key. You can get the key for
	 * the current triple by calling {@link TripleResult#getKey}.
	 */
	public long getKey() {
		return key;
	}

	/** This is the first element of the current triple. */
	public Expr getSubject() {
		return subj;
	}

	/** This is the second element of the current triple. */
	public Expr getPredicate() {
		return pred;
	}

	/** This is the third element of the current triple. */
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
