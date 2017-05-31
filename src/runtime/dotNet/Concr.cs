using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace PGFSharp
{
    /// <summary>
    /// The class for concrete syntaxes.
    /// </summary>
    public class Concr
    {
        internal IntPtr Ptr { get; private set; }

        /// <summary>
        /// Abstract grammar for this language.
        /// </summary>
        public PGF PGF { get; private set; }

        private Concr() { }

        internal static Concr FromPtr(PGF g, IntPtr ptr)
        {
            var concr = new Concr();
            concr.PGF = g;
            concr.Ptr = ptr;
            return concr;
        }

        /// <summary>
        /// Name of the grammar.
        /// </summary>
        public string Name => Native.NativeString.StringFromNativeUtf8(Native.pgf_concrete_name(Ptr));
        public override string ToString() => $"Concrete:{Name} of {PGF.Name}";

        /// <summary>
        /// Parse given input string in the concrete grammar.
        /// </summary>
        /// <param name="str">Input string to be parsed.</param>
        /// <param name="cat">Category (Type) to parse.</param>
        /// <param name="heuristics">Heuristic (see the GF C runtime docs).</param>
        /// <param name="Callback1">Callback function.</param>
        /// <param name="Callback2">Callback function.</param>
        /// <returns>Enumerates pairs of (abstract grammar) expressions and corresponding probability.</returns>
        public IEnumerable<Tuple<Expr, float>> Parse(string str, Type cat = null, double? heuristics = null,
            Action Callback1 = null, Action Callback2 = null)
        {
            var parse_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(parse_pool);
            cat = cat ?? PGF.StartCat;

            using (var nativeStr = new Native.NativeString(str))
            {
                var result_pool = new NativeGU.NativeMemoryPool();
                var callbackMap = Native.pgf_new_callbacks_map(this.Ptr, parse_pool.Ptr);

                var iterator = Native.pgf_parse_with_heuristics(this.Ptr, cat.Ptr,
                    nativeStr.Ptr, heuristics ?? -1, callbackMap,
                    exn.Ptr, parse_pool.Ptr, result_pool.Ptr);

                if (iterator == IntPtr.Zero || exn.IsRaised)
                {
                    throw new ParseError();
                }
                else
                {
                    foreach (var ptr in NativeGU.IteratorToIEnumerable(iterator, parse_pool.Ptr))
                    {
                        var exprProb = (Native.PgfExprProb)Marshal.PtrToStructure(ptr, typeof(Native.PgfExprProb));
                        yield return Tuple.Create(Expr.FromPtr(exprProb.expr, result_pool),
                                                  exprProb.prob);
                    }
                }
            }
        }

        /// <summary>
        /// Linearize expression, i.e. produce a string in the concrete grammar from an expression in the abstract grammar.
        /// </summary>
        /// <param name="e"></param>
        /// <returns></returns>
        public string Linearize(Expr e)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);

            var buf = NativeGU.gu_new_string_buf(tmp_pool.Ptr);
            var out_ = NativeGU.gu_string_buf_out(buf);

            Native.pgf_linearize(Ptr, e.Ptr, out_, exn.Ptr);
            if (exn.IsRaised)
            {
                throw new PGFError();
            }
            else
            {
                var cstr = NativeGU.gu_string_buf_freeze(buf, tmp_pool.Ptr);
                return Native.NativeString.StringFromNativeUtf8(cstr);
            }
        }

        /// <summary>
        /// Get all possible linearization for an expression (see <see cref="Linearize(Expression)"/>).
        /// </summary>
        /// <param name="e"></param>
        /// <returns></returns>
        public IEnumerable<string> LinearizeAll(Expr e)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);

            var cts = Native.pgf_lzr_concretize(Ptr, e.Ptr, exn.Ptr, tmp_pool.Ptr);
            if (exn.IsRaised || cts == IntPtr.Zero) throw new PGFError("Could not linearize the abstract tree.");

            return NativeGU.IteratorToIEnumerable(cts, tmp_pool.Ptr).Select(LinearizeCnc);
        }

        private string LinearizeCnc(IntPtr cnc)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);

            var sbuf = NativeGU.gu_new_string_buf(tmp_pool.Ptr);
            var out_ = NativeGU.gu_string_buf_out(sbuf);

            var wrapped = Native.pgf_lzr_wrap_linref(cnc, tmp_pool.Ptr);
            Native.pgf_lzr_linearize_simple(Ptr, wrapped, 0, out_, exn.Ptr, tmp_pool.Ptr);

            if (exn.IsRaised) throw new PGFError("Could not linearize abstract tree.");

            var cstr = NativeGU.gu_string_buf_freeze(sbuf, tmp_pool.Ptr);
            return Native.NativeString.StringFromNativeUtf8(cstr);
        }

        /// <summary>
        /// Get the bracketed (structured) linearization of an expression.
        /// </summary>
        /// <param name="e"></param>
        /// <returns></returns>
        public Bracket BracketedLinearize(Expr e)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);

            var cts = Native.pgf_lzr_concretize(Ptr, e.Ptr, exn.Ptr, tmp_pool.Ptr);

            var ctree = IntPtr.Zero;
            NativeGU.gu_enum_next(cts, ref ctree, tmp_pool.Ptr);

            if (ctree == IntPtr.Zero)
            {
                return null;
            }

            ctree = Native.pgf_lzr_wrap_linref(ctree, tmp_pool.Ptr);

            var builder = new Bracket.BracketBuilder();

            var mem = Marshal.AllocHGlobal(Marshal.SizeOf<Native.PgfLinFuncs>());
            Marshal.StructureToPtr<Native.PgfLinFuncs>(builder.LinFuncs, mem, false);

            Native.pgf_lzr_linearize(Ptr, ctree, 0, ref mem, tmp_pool.Ptr);

            var b = builder.Build();

            Marshal.FreeHGlobal(mem);

            return b;
        }
    }
}
