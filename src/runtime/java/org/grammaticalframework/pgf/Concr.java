package org.grammaticalframework.pgf;

public class Concr {

	public native String getName();

	//////////////////////////////////////////////////////////////////
	// private stuff
	
	private PGF gr;
	private long concr;

	private Concr(PGF gr, long concr) {
		this.gr    = gr;
		this.concr = concr;
	}
}
