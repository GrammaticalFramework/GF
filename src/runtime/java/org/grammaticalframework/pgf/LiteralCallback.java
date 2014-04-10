package org.grammaticalframework.pgf;

public interface LiteralCallback {
	public CallbackResult match(int lin_idx, String sentence, int start_offset);
	
	public static class CallbackResult {
		private ExprProb ep;
		private int offset;
		
		public CallbackResult(ExprProb ep, int offset) {
			this.ep     = ep;
			this.offset = offset;
		}
		
		public ExprProb getExprProb() {
			return ep;
		}
		
		public int getOffset() {
			return offset;
		}
	}
}
