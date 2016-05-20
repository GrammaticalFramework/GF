package org.grammaticalframework.pgf;

import java.util.Collections;
import java.util.Iterator;

/** A callback for recognizing words that are not in the lexicon.
 * For such words the callback returns the expression (MkSymb "&lt;word&gt;").
 */
public class UnknownLiteralCallback implements LiteralCallback {
	private Concr concr;
	private String sentence;

	public UnknownLiteralCallback(Concr concr, String sentence) {
		this.concr = concr;
		this.sentence = sentence;
	}

	public CallbackResult match(int lin_idx, int offset) {
		if (offset < sentence.length() &&
		    !Character.isUpperCase(sentence.charAt(offset))) {
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
