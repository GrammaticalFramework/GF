package org.grammaticalframework.pgf;

import java.util.Iterator;

class Lexicon implements Iterable<FullFormEntry> {
	private Concr concr;
	private String prefix;
	private FullFormIterator iter;

	public Lexicon(Concr concr, String prefix) {
		this.concr    = concr;
		this.prefix   = prefix;
		this.iter     = lookupWordPrefix(concr, prefix);
	}

	public Iterator<FullFormEntry> iterator() {
		if (iter == null) {
			// If someone has asked for a second iterator over
			// the same parse results then we have to parse again.
			return lookupWordPrefix(concr, prefix);
		} else {
			FullFormIterator tmp_iter = iter;
			iter = null;
			return tmp_iter;
		}
	}

	static private native FullFormIterator lookupWordPrefix(Concr concr, String prefix);
}
