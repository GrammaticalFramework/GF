package org.grammaticalframework.sg;

import java.io.Closeable;
import org.grammaticalframework.pgf.*;

/** This class represents a connection to a semantic graph database.
 * The semantic graph is a graph represented as a set of tripples
 * of abstract expressions. The graph can be used for instance to store
 * semantic information for entities in a GF grammar.
 */
public class SG implements Closeable {
	/** Opens a new database file. */
	public static native SG openSG(String path) throws SGError;
	
	/** Closes an already opened database. */
	public native void close() throws SGError;

	/** Reads a triple in the format &lt;expr,expr,expr&gt; and returns it as an array. */
	public static native Expr[] readTriple(String s) throws PGFError;

	/** Simple triple queries.
	 * Each of the arguments subj, pred and obj could be null. 
	 * A null argument is interpreted as a wild card.
	 * If one of the arguments is not null then only triples with matching values
	 * will be retrieved.  
	 * 
	 * @return An iterator over the matching triples.
	 */
	public native TripleResult queryTriple(Expr subj, Expr pred, Expr obj) throws SGError;

	/** Starts a new transaction. */
	public native void beginTrans() throws SGError;
	
	/** Commits the transaction. */
	public native void commit() throws SGError;
	
	/** Rollbacks all changes made in the current transaction. */
	public native void rollback() throws SGError;

	/** Inserts a new triple.
	 * @return an unique id that identifies this triple in the database
	 */
	public native long insertTriple(Expr subj, Expr pred, Expr obj) throws SGError;

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
