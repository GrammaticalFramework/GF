package org.grammaticalframework.pgf;

public class NercLiteralCallback implements LiteralCallback {
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
			Expr expr = new Expr(sbuilder.toString());
			expr = new Expr("MkSymb", expr);
			return new CallbackResult(new ExprProb(expr, 0), end_offset);
		}

		return null;
	}
}
