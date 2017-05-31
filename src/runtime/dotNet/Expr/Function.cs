using System;
using System.Linq;
using System.Collections.Generic;

namespace PGFSharp
{
	public class FunctionExpr : Expr
	{
		public override R Accept<R> (IVisitor<R> visitor)
		{
			return visitor.VisitApplication (Name, new Expr[] {});
		}
		
		internal FunctionExpr (IntPtr expr, NativeGU.NativeMemoryPool pool) : base(expr,pool) {}
		public string Name => Native.NativeString.StringFromNativeUtf8(DataPtr);
	}
}

