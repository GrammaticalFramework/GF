package org.grammaticalframework.pgf;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class Expr implements Serializable {
		private static final long serialVersionUID = 1148602474802492674L;
	
		private Pool pool;
		private PGF  gr;
		private long ref;

		Expr(Pool pool, PGF gr, long ref) {
			this.pool = pool;
			this.gr   = gr;
			this.ref  = ref;
		}

		public String toString() {
			return showExpr(ref);
		}

		public static native Expr readExpr(String s) throws PGFError;

		private static native String showExpr(long ref);
		
		private void writeObject(ObjectOutputStream out) throws IOException {
			out.writeObject(showExpr(ref));
		}
		
		private void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException {
			Expr e = readExpr((String) in.readObject());
			pool = e.pool;
			gr   = e.gr;
			ref  = e.ref;
		}
}
