package org.grammaticalframework.pgf;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Arrays;

public class Expr implements Serializable {
		private static final long serialVersionUID = 1148602474802492674L;
	
		private Pool pool;
		private Object master;
		private long ref;

		Expr(Pool pool, Object master, long ref) {
			this.pool   = pool;
			this.master = master;
			this.ref    = ref;
		}

		public Expr(String s) {
			this.pool   = new Pool();
			this.master = null;
			this.ref    = initStringLit(s, pool.ref);  
		}

		public Expr(String fun, Expr... args) {
			this.pool   = new Pool();
			this.master = Arrays.copyOf(args, args.length);
			this.ref    = initApp(fun, args, pool.ref);
		}

		public String toString() {
			return showExpr(ref);
		}

		public static native Expr readExpr(String s) throws PGFError;

		public native boolean equals(Expr e);

		private static native String showExpr(long ref);

		private static native long initStringLit(String s, long pool);
		private static native long initApp(String fun, Expr[] args, long pool);

		private void writeObject(ObjectOutputStream out) throws IOException {
			out.writeObject(showExpr(ref));
		}
		
		private void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException {
			Expr e = readExpr((String) in.readObject());
			pool   = e.pool;
			master = e.master;
			ref    = e.ref;
		}
}
