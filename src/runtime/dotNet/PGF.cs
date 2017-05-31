using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace PGFSharp
{
    /// <summary>
    /// This is the class for PGF grammars.
    /// </summary>
    public class PGF
    {
        private PGF() { }

        IntPtr _ptr;
        NativeGU.NativeMemoryPool pool;

        /// <summary>
        /// Reads a grammar with the specified file path.
        /// </summary>
        /// <param name="fn">The path to the file.</param>
        /// <returns>an object representing the grammar in memory.</returns>
        public static PGF ReadPGF(string fn)
        {
            var obj = new PGF();
            var exn = new NativeGU.NativeExceptionContext(new NativeGU.NativeMemoryPool());
            obj.pool = new NativeGU.NativeMemoryPool();
            obj._ptr = Native.pgf_read(fn, obj.pool.Ptr, exn.Ptr);
            if (exn.IsRaised)
            {
                throw new PGFError($"Could not read PGF from file {fn}. ({System.IO.Directory.GetCurrentDirectory()})");
            }
            return obj;
        }

        public override string ToString() => $"Grammar:{Name}, {String.Join(", ", Languages.Keys)}";

        /// <summary>
        /// Name of the abstract grammar.
        /// </summary>
        public string Name => Native.NativeString.StringFromNativeUtf8(Native.pgf_abstract_name(_ptr));

        /// <summary>
        /// Default category of the grammar.
        /// </summary>
        public Type StartCat => Type.FromPtr(Native.pgf_start_cat(_ptr, pool.Ptr), pool);

        /// <summary>
        /// All concrete grammars in the language.
        /// </summary>
        public Dictionary<string, Concr> Languages
        {
            get
            {
                var dict = new Dictionary<string, Concr>();
                Native.MapIter(Native.pgf_iter_languages, _ptr, (k, v) => dict[k] = Concr.FromPtr(this, dereference(v)));
                return dict;
            }
        }

        private IntPtr dereference(IntPtr ptr)
        {
            return (IntPtr)Marshal.PtrToStructure(ptr, typeof(IntPtr));
        }

        /// <summary>
        /// All categories in the abstract grammar.
        /// </summary>
        public IEnumerable<string> Categories => GetStringList(Native.pgf_iter_categories);

        /// <summary>
        /// All functions in the abstract grammar.
        /// </summary>
        public IEnumerable<string> Functions => GetStringList(Native.pgf_iter_functions);

        /// <summary>
        /// Returns a list with all functions with a given return category.
        /// </summary>
        /// <param name="catName">The name of the return category.</param>
        public IEnumerable<string> FunctionByCategory(string catName)
        {
            using (var str = new Native.NativeString(catName))
            {
                return GetStringList(new Native.IterFuncCurryName(Native.pgf_iter_functions_by_cat, str.Ptr).IterFunc);
            }
        }

        /// <summary>
        /// Returns the type of the function with the given name.
        /// </summary>
        /// <param name="funName">The name of the function.</param>
        /// <returns></returns>
        public Type FunctionType(string funName)
        {
            using (var str = new Native.NativeString(funName))
            {
                var typePtr = Native.pgf_function_type(_ptr, str.Ptr);
                if (typePtr == IntPtr.Zero) throw new NullReferenceException();
                return Type.FromPtr(typePtr, pool);
            }
        }

        /// <summary>
        /// Normalizes an expression to its normal form by using the 'def' rules in the grammar.
        /// </summary>
        /// <param name="expr">the original expression.</param>
        /// <returns>the normalized expression.</returns>
        public Expr Compute(Expr expr)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);
            var result_pool = new NativeGU.NativeMemoryPool();
            var newExpr = Native.pgf_compute(_ptr, expr.Ptr, exn.Ptr, pool.Ptr, result_pool.Ptr);

            if (exn.IsRaised || newExpr == IntPtr.Zero)
            {
                throw new PGFError("Could not reduce expression.");
            }
            else
            {
                return Expr.FromPtr(newExpr, result_pool);
            }
        }

        /// <summary>
        /// Returns an enumerable over the set of all expression in
        /// the given category. The expressions are enumerated in decreasing
        /// probability order.
        /// </summary>
        /// <param name="cat">the start category.</param>
        /// <returns></returns>
        public IEnumerable<Expr> GenerateAll(Type cat = null)
        {
            cat = cat ?? StartCat;
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);
            var result_pool = new NativeGU.NativeMemoryPool();
            IntPtr ptr = IntPtr.Zero;
            var iterator = Native.pgf_generate_all(this._ptr, cat.Ptr, exn.Ptr, tmp_pool.Ptr, result_pool.Ptr);

            return NativeGU.IteratorToIEnumerable(iterator, tmp_pool.Ptr).Select(p =>
            {
                var exprProb = Marshal.PtrToStructure<Native.PgfExprProb>(ptr);
                return Expr.FromPtr(exprProb.expr, result_pool);

            });
        }

        private IEnumerable<string> GetStringList(Native.MapIterFunc f)
        {
            var c = new List<string>();
            Native.MapIter(f, _ptr, (k, v) => c.Add(k));
            return c;
        }
    }
}
