package org.grammaticalframework.pgf;

public class NercLiteralCallback implements LiteralCallback {
	public int match(Concr concr, int lin_idx, ExprBuilder builder, String sentence, int start_offset) {
		return start_offset;
	}
}
