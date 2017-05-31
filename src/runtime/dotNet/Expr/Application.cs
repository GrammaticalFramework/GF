using System;
using System.Runtime.InteropServices;
using System.Collections.Generic;
using System.Linq;

namespace PGFSharp
{
	public class ApplicationExpr : Expr
	{
		public override R Accept<R> (IVisitor<R> visitor)
		{
			var args = new List<Expr> ();
			var expr = this;
			while (expr.Function is ApplicationExpr) {
				args.Add (expr.Argument);
				expr = expr.Function as ApplicationExpr;
			}
			args.Add (expr.Argument);
			if (!(expr.Function is FunctionExpr))
				throw new ArgumentException ();

			args.Reverse ();
			return visitor.VisitApplication ((expr.Function as FunctionExpr).Name, args.ToArray());
		}
		
		[StructLayout(LayoutKind.Sequential)]
		private struct PgfExprApp {
			public IntPtr Function;
			public IntPtr Argument;
		}

		private PgfExprApp Data => Marshal.PtrToStructure<PgfExprApp>(DataPtr);

		public Expr Function => Expr.FromPtr(Data.Function, _pool);
		public Expr Argument => Expr.FromPtr(Data.Argument, _pool);

		internal ApplicationExpr(IntPtr ptr, NativeGU.NativeMemoryPool pool) : base(ptr, pool) {	}
		public ApplicationExpr(string fname, IEnumerable<Expr> args)
		{
			_pool = new NativeGU.NativeMemoryPool();
			MkStringVariant((byte)PgfExprTag.PGF_EXPR_FUN, fname, ref _ptr);
			foreach (var arg in args) {
				var fun = _ptr;
				var exprApp = NativeGU.gu_alloc_variant((byte)PgfExprTag.PGF_EXPR_APP,
					(UIntPtr)Marshal.SizeOf<PgfExprApp>(), UIntPtr.Zero, ref _ptr, _pool.Ptr);

				Native.EditStruct<PgfExprApp> (exprApp, (ref PgfExprApp app) => {
					app.Function = fun;
					app.Argument = arg.Ptr;
				});
			}


		}
	}
}

