package org.grammaticalframework.pgf;

import java.util.Collections;
import java.util.Iterator;

public class NercLiteralCallback implements LiteralCallback {
	private PGF pgf;
	private Concr concr;

	public NercLiteralCallback(PGF pgf, Concr concr) {
		this.pgf   = pgf;
		this.concr = concr;
	}

	public CallbackResult match(int lin_idx, String sentence, int offset) {
		StringBuilder sbuilder = new StringBuilder();

		int i = 0;
		int end_offset = offset;
		while (offset < sentence.length() &&
			   Character.isUpperCase(sentence.charAt(offset))) {
			if (i > 0)
				sbuilder.append(' ');
			i++;

			while (offset < sentence.length() &&
			       !Character.isWhitespace(sentence.charAt(offset))) {
				sbuilder.append(sentence.charAt(offset));
				offset++;
			}

			end_offset = offset;
			while (offset < sentence.length() &&
			       Character.isWhitespace(sentence.charAt(offset))) {
				offset++;
			}
		}

		if (i > 0) {
			String name = sbuilder.toString();
			String lemma = null;
			double prob = 0;
			for (MorphoAnalysis an : concr.lookupMorpho(name)) {
				if ("PN".equals(pgf.getFunctionType(an.getLemma()).getCategory()) &&
					prob < an.getProb()) {
					lemma = an.getLemma();
					prob  = an.getProb();
				}
			}

			Expr expr;
			if (lemma == null) {
				expr = new Expr(name);
				expr = new Expr("MkSymb", expr);
				expr = new Expr("SymbPN", expr);
			} else {
				expr = new Expr(lemma, new Expr[0]);
			}

			return new CallbackResult(new ExprProb(expr, 0), end_offset);
		}

		return null;
	}
	
	public Iterator<TokenProb> predict(int lin_idx, String prefix) {
		return Collections.<TokenProb>emptyList().iterator();
	}
}
