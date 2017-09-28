using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace PGFSharp
{
    internal class UnsupportedExpr : Expr
    {
        internal UnsupportedExpr(IntPtr expr, NativeGU.NativeMemoryPool pool) : base(expr, pool) { }
        public override R Accept<R>(IVisitor<R> visitor)
        {
            throw new NotImplementedException();
        }
    }

	/// <summary>
	/// A representation for an abstract syntax tree.
	/// </summary>
    public abstract class Expr
    {
        internal IntPtr DataPtr => NativeGU.gu_variant_open(_ptr).Data; // PgfExprLit* 
        internal PgfExprTag Tag => (PgfExprTag)NativeGU.gu_variant_open(_ptr).Tag;

        internal IntPtr MkStringVariant(byte tag, string s, ref IntPtr out_)
        {
            var size = Encoding.UTF8.GetByteCount(s);
            IntPtr slitPtr = NativeGU.gu_alloc_variant(tag,
                (UIntPtr)(size + 1), UIntPtr.Zero, ref out_, _pool.Ptr);
            Native.NativeString.CopyToPreallocated(s, slitPtr);
            return slitPtr;
        }

        /// <summary>
        /// Read expression from string.
        /// </summary>
        /// <param name="exprStr"></param>
        /// <returns></returns>
        public static Expr ReadExpr(string exprStr)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);
            var result_pool = new NativeGU.NativeMemoryPool();
            using (var strNative = new Native.NativeString(exprStr))
            {
                var in_ = NativeGU.gu_data_in(strNative.Ptr, strNative.Size, tmp_pool.Ptr);
                var expr = Native.pgf_read_expr(in_, result_pool.Ptr, tmp_pool.Ptr, exn.Ptr);
                if (exn.IsRaised || expr == IntPtr.Zero)
                {
                    throw new PGFError();
                }
                else
                {
                    return Expr.FromPtr(expr, result_pool);
                }
            }
        }

        internal enum PgfExprTag
        {
            PGF_EXPR_ABS,
            PGF_EXPR_APP,
            PGF_EXPR_LIT,
            PGF_EXPR_META,
            PGF_EXPR_FUN,
            PGF_EXPR_VAR,
            PGF_EXPR_TYPED,
            PGF_EXPR_IMPL_ARG,
            PGF_EXPR_NUM_TAGS // not used
        };

        public interface IVisitor<R>
        {
            R VisitLiteralInt(int value);
            R VisitLiteralFloat(double value);
            R VisitLiteralString(string value);
            R VisitApplication(string fname, Expr[] args);

            //R VisitMetaVariable (int id); Dont' care about this for now...

            // Remove this, Function objects use VisitApplication with empty args instead.
            //R VisitFunction (string fname); // Will this be used?
        }

        public class Visitor<R> : IVisitor<R>
        {
            public Func<int, R> fVisitLiteralInt { get; set; } = null;
            public R VisitLiteralInt(int x1) => fVisitLiteralInt(x1);
            public Func<double, R> fVisitLiteralFlt { get; set; } = null;
            public R VisitLiteralFloat(double x1) => fVisitLiteralFlt(x1);
            public Func<string, R> fVisitLiteralStr { get; set; } = null;
            public R VisitLiteralString(string x1) => fVisitLiteralStr(x1);
            public Func<string, Expr[], R> fVisitApplication { get; set; } = null;
            public R VisitApplication(string x1, Expr[] x2) => fVisitApplication(x1, x2);
        }

        public abstract R Accept<R>(IVisitor<R> visitor);

        internal IntPtr _ptr = IntPtr.Zero;
        internal NativeGU.NativeMemoryPool _pool;
        internal IntPtr Ptr => _ptr;

        internal Expr() { }
        internal Expr(IntPtr ptr, NativeGU.NativeMemoryPool pool)
        {
            _ptr = ptr; _pool = pool;
        }

        // Factories
        private static Dictionary<PgfExprTag, Func<IntPtr, NativeGU.NativeMemoryPool, Expr>> factories =
            new Dictionary<PgfExprTag, Func<IntPtr, NativeGU.NativeMemoryPool, Expr>>{

            { PgfExprTag.PGF_EXPR_LIT, (e, p) => LiteralExpr.FromPtr (e, p) },
            { PgfExprTag.PGF_EXPR_APP, (e, p) => new ApplicationExpr (e, p) },
            { PgfExprTag.PGF_EXPR_FUN, (e, p) => new FunctionExpr (e, p) },
            { PgfExprTag.PGF_EXPR_META, (e, p) => new MetaVariableExpr (e, p) }
        };

        internal static Expr FromPtr(IntPtr expr, NativeGU.NativeMemoryPool pool)
        {
            var Tag = (PgfExprTag)NativeGU.gu_variant_open(expr).Tag;
            if (factories.ContainsKey(Tag))
            {
                return factories[Tag](expr, pool);
            }
            else
                return new UnsupportedExpr(expr, pool);
        }

        public override string ToString() =>
            Native.ReadString((output,exn) => Native.pgf_print_expr(_ptr, IntPtr.Zero, 0, output, exn.Ptr));

    }
}
