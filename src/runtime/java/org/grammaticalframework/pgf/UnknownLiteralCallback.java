package org.grammaticalframework.pgf;

import java.util.Collections;
import java.util.Iterator;

public class UnknownLiteralCallback implements LiteralCallback {
	private Concr concr;

	public UnknownLiteralCallback(PGF pgf, Concr concr) {
		this.concr = concr;
	}

	public CallbackResult match(int lin_idx, String sentence, int offset) {
		if (!Character.isUpperCase(sentence.charAt(offset))) {
			int start_offset = offset;
			while (offset < sentence.length() &&
			       !Character.isWhitespace(sentence.charAt(offset))) {
				offset++;
			}
			int end_offset = offset;
			String word = sentence.substring(start_offset,end_offset);
			
			if (concr.lookupMorpho(word).size() == 0) {
				Expr expr = new Expr("MkSymb", new Expr(word));
				return new CallbackResult(new ExprProb(expr, 0), end_offset);
			}
		}

		return null;
	}
	
	public Iterator<TokenProb> predict(int lin_idx, String prefix) {
		return Collections.<TokenProb>emptyList().iterator();
	}
}
