package org.grammaticalframework.pgf;

import java.util.*;

class SentenceExtractor implements Iterable<ExprProb> {
	private Concr concr;
	private String s;
	private String startCat;
	private double heuristics;
	private Map<String,LiteralCallback> callbacks;
	private ExprIterator iter;

	public SentenceExtractor(Concr concr, String startCat, String s) {
		this.concr    = concr;
		this.startCat = startCat;
		this.s        = s;
		this.iter     = doExtract();
	}

	public Iterator<ExprProb> iterator() {
		if (iter == null) {
			// If someone has asked for a second iterator over
			// the same parse results then we have to parse again.
			return doExtract();
		} else {
			ExprIterator tmp_iter = iter;
			iter = null;
			return tmp_iter;
		}
	}

	private ExprIterator doExtract()
	{
		Pool pool = new Pool();
		return lookupSentence(concr, startCat, s, pool);
	}

	static native ExprIterator lookupSentence(Concr concr, String startCat, String s, Pool pool);
}
