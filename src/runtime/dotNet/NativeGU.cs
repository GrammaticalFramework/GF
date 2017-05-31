using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace PGFSharp
{
    internal static class NativeGU
    {

        const string LIBNAME = "gu.dll";
        const CallingConvention CC = CallingConvention.Cdecl;

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_new_pool();

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_new_exn(IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern void gu_pool_free(IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr get_gu_null_variant();

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_string_buf_out(IntPtr sbuf);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_new_string_buf(IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_data_in(IntPtr str, int len, IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_string_buf_freeze(IntPtr sbuf, IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        [return: MarshalAs(UnmanagedType.I1)]
        public static extern bool gu_exn_is_raised(IntPtr err);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern void gu_enum_next(IntPtr enum_, ref IntPtr outPtr, IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern GuVariantInfo gu_variant_open(IntPtr variant);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_alloc_variant(byte tag, UIntPtr size, UIntPtr align, ref IntPtr out_, IntPtr pool);

        [DllImport(LIBNAME, CallingConvention = CC)]
        public static extern IntPtr gu_make_variant(byte tag, UIntPtr size, UIntPtr align, ref IntPtr init, IntPtr pool);

        [StructLayout(LayoutKind.Sequential)]
        public struct GuVariantInfo
        {
            public int Tag;
            public IntPtr Data;
        }


        [StructLayout(LayoutKind.Sequential)]
        public struct GuSeq
        {
            public UIntPtr length;
        }

        public static uint SeqLength(IntPtr seqptr)
        {
            var seq = Marshal.PtrToStructure<GuSeq>(seqptr);
            return (uint)seq.length;
        }

        public static T gu_seq_index<T>(IntPtr seq, int index)
        {
            var dataPtr = seq + Marshal.SizeOf<GuSeq>();
            var hypoPtr = dataPtr + index * Marshal.SizeOf<T>();
            var hypo = Marshal.PtrToStructure<T>(hypoPtr);
            return hypo;
        }

        public class NativeMemoryPool
        {
            private IntPtr _ptr;
            internal IntPtr Ptr => _ptr;

            public NativeMemoryPool()
            {
                _ptr = gu_new_pool();
                if (_ptr == IntPtr.Zero) throw new Exception();
            }

            ~NativeMemoryPool()
            {
                gu_pool_free(_ptr);
                _ptr = IntPtr.Zero;
            }
        }

        public class NativeExceptionContext
        {
            private IntPtr _ptr;
            internal IntPtr Ptr => _ptr;

            public NativeExceptionContext(NativeMemoryPool pool)
            {
                _ptr = gu_new_exn(pool.Ptr);
                if (_ptr == IntPtr.Zero) throw new Exception();
            }

            public bool IsRaised => gu_exn_is_raised(_ptr);
        }

        public static IEnumerable<IntPtr> IteratorToIEnumerable(IntPtr iterator, IntPtr pool)
        {
            IntPtr ptr = IntPtr.Zero;
            NativeGU.gu_enum_next(iterator, ref ptr, pool);
            while (ptr != IntPtr.Zero)
            {
                yield return ptr;
                NativeGU.gu_enum_next(iterator, ref ptr, pool);
            }
        }
    }
}
