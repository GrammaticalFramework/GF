package org.grammaticalframework.pgf;

import java.util.*;

class Parser implements Iterable<ExprProb> {
	private Concr concr;
	private String s;
	private String startCat;
	private double heuristics;
	private Map<String,LiteralCallback> callbacks;
	private ExprIterator iter;

	public Parser(Concr concr, String startCat, String s,
			      double heuristics,
			      Map<String,LiteralCallback> callbacks) throws ParseError {
		this.concr    = concr;
		this.startCat = startCat;
		this.s        = s;
		this.heuristics = heuristics;
		this.callbacks = callbacks;
		this.iter     = doParse();
	}

	public Iterator<ExprProb> iterator() {
		if (iter == null) {
			// If someone has asked for a second iterator over
			// the same parse results then we have to parse again.
			try {
				return doParse();
			} catch (ParseError e) {
				return null;
			}
		} else {
			ExprIterator tmp_iter = iter;
			iter = null;
			return tmp_iter;
		}
	}

	private ExprIterator doParse() throws ParseError
	{
		Pool pool = new Pool();
		long callbacksRef = newCallbacksMap(concr, pool);
		if (callbacks != null) {
			for (Map.Entry<String, LiteralCallback> entry : callbacks.entrySet()) {
				addLiteralCallback(concr, callbacksRef, 
								   entry.getKey(), entry.getValue(),
								   pool);
			}
		}
		return parseWithHeuristics(concr, startCat, s, heuristics, callbacksRef, pool);
	}

	static native long newCallbacksMap(Concr concr, Pool pool);
	static native void addLiteralCallback(Concr concr, long callbacksRef, String cat, LiteralCallback callback, Pool pool);
	static native ExprIterator parseWithHeuristics(Concr concr, String startCat, String s, double heuristics, long callbacksRef, Pool pool) throws ParseError;
}
