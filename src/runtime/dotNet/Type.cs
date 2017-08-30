using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace PGFSharp
{
    /// <summary>
    /// A class for types in the abstract syntax of a grammar.
    /// </summary>
    public class Type
    {
        private IntPtr _ptr;
        internal IntPtr Ptr => _ptr;
        private NativeGU.NativeMemoryPool _pool;
        private Type() { }

        internal static Type FromPtr(IntPtr type, NativeGU.NativeMemoryPool pool)
        {
            var t = new Type();
            t._ptr = type;
            t._pool = pool;
            return t;
        }

        public override string ToString() =>
            Native.ReadString((output,exn) => Native.pgf_print_type(_ptr, IntPtr.Zero, 0, output, exn.Ptr));

        private PgfType Data => Marshal.PtrToStructure<PgfType>(_ptr);

        /// <summary>
        /// Read type from string.
        /// </summary>
        /// <param name="typeStr"></param>
        /// <returns></returns>
        public static Type ReadType(string typeStr)
        {
            var tmp_pool = new NativeGU.NativeMemoryPool();
            var exn = new NativeGU.NativeExceptionContext(tmp_pool);
            var result_pool = new NativeGU.NativeMemoryPool();
            using (var strNative = new Native.NativeString(typeStr))
            {
                var in_ = NativeGU.gu_data_in(strNative.Ptr, strNative.Size, tmp_pool.Ptr);
                var typ = Native.pgf_read_type(in_, result_pool.Ptr, exn.Ptr);
                if (exn.IsRaised || typ == IntPtr.Zero)
                {
                    throw new PGFError();
                }
                else
                {
                    return Type.FromPtr(typ, result_pool);
                }
            }
        }

        /// <summary>
        /// Get the hypotheses of a type (function argument types).
        /// </summary>
        public IEnumerable<Type> Hypotheses
        {
            get
            {
                var n_hypos = NativeGU.SeqLength(Data.hypos);
                for (int i = 0; i < n_hypos; i++)
                {
                    var hypo = NativeGU.gu_seq_index<PgfHypo>(Data.hypos, i);
                    var type = Type.FromPtr(hypo.type, this._pool);
                    yield return type;
                }
            }
        }

        [StructLayout(LayoutKind.Sequential)]
        internal struct PgfType
        {
            public IntPtr hypos; // GuSeq of PgfHypo
            public IntPtr cid;
            public UIntPtr n_exprs;
            public IntPtr exprs;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct PgfHypo
        {
            public int pgfBindType; // enum
            public IntPtr cid; // PgfCId (string)
            public IntPtr type; // PgfType*
        }
    }
}
