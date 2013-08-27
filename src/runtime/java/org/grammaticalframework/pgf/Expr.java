package org.grammaticalframework.pgf;

public class Expr {
		private Pool pool;
		private long ref;

		public Expr(Pool pool, long ref) {
			this.pool = pool;
			this.ref  = ref;
		}
		
		public String toString() {
			return showExpr(ref);
		}

		private static native String showExpr(long ref);
}
