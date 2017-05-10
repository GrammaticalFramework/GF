package org.grammaticalframework.pgf;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Arrays;

/** This class is a representation of an abstract syntax tree.
 */
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

		/** Constructs an expression which represents a string literal */
		public Expr(String s) {
			if (s == null)
				throw new IllegalArgumentException("s == null");

			this.pool   = new Pool();
			this.master = null;
			this.ref    = initStringLit(s, pool.ref);  
		}

		/** Constructs an expression which is a function application
		 * @param fun The name of the top-level function.
		 * @param args the arguments for the function.
		 */
		public Expr(String fun, Expr... args) {
			if (fun == null)
				throw new IllegalArgumentException("fun == null");
			for (int i = 0; i < args.length; i++) {
				if (args[i] == null)
					throw new IllegalArgumentException("the "+(i+1)+"th argument is null");
			}

			this.pool   = new Pool();
			this.master = args;
			this.ref    = initApp(fun, args, pool.ref);
		}

		/** Constructs an expression which is an application
		 * of the first expression to a list of arguments.
		 */
		public static Expr apply(Expr fun, Expr... args) {
			if (fun == null)
				throw new IllegalArgumentException("fun == null");
			for (int i = 0; i < args.length; i++) {
				if (args[i] == null)
					throw new IllegalArgumentException("the "+(i+1)+"th argument is null");
			}

			Object[] master = new Object[args.length+1];
			master[0] = fun;
			for (int i = 0; i < args.length; i++) {
				master[i+1] = args[i].master;
			}

            Pool pool = new Pool();
			return new Expr(pool, master, initApp(fun, args, pool.ref));
		}

		/** Returns the expression as a string in the GF syntax */
		public String toString() {
			return showExpr(ref);
		}

		/** Reads a string in the GF syntax for abstract expressions
		 * and returns an object representing the expression. */
		public static native Expr readExpr(String s) throws PGFError;

		/** Compares the current expression with another expression by value. 
		 * @return True if the expressions are equal. */
		public native boolean equals(Expr e);

		private static native String showExpr(long ref);

		private static native long initStringLit(String s, long pool);
		private static native long initApp(Expr   fun, Expr[] args, long pool);
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
		
		static { 
			System.loadLibrary("jpgf");
		}
}
