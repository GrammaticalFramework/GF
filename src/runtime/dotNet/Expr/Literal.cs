using System;
using System.Runtime.InteropServices;
using System.Text;

namespace PGFSharp
{
    public class LiteralStringExpr : LiteralExpr
    {
        internal LiteralStringExpr(IntPtr expr, NativeGU.NativeMemoryPool pool) : base(expr, pool) { }
        public LiteralStringExpr(string s) : base()
        {
            _pool = new NativeGU.NativeMemoryPool();

            var exprTag = (byte)(int)PgfExprTag.PGF_EXPR_LIT;
            IntPtr litPtr = NativeGU.gu_alloc_variant(exprTag,
                (UIntPtr)Marshal.SizeOf<NativePgfExprLit>(), UIntPtr.Zero, ref _ptr, _pool.Ptr);

            Native.EditStruct<NativePgfExprLit>(litPtr, (ref NativePgfExprLit lit) => {
                MkStringVariant((byte)PgfLiteralTag.PGF_LITERAL_STR, s, ref lit.lit);
            });
        }

        public override R Accept<R>(IVisitor<R> visitor)
        {
            return visitor.VisitLiteralString(Value);
        }

        public string Value => Native.NativeString.StringFromNativeUtf8(LitDataPtr);
    }

    public class LiteralIntExpr : LiteralExpr
    {
        internal LiteralIntExpr(IntPtr expr, NativeGU.NativeMemoryPool pool) : base(expr, pool) { }
        public LiteralIntExpr(int val) : base()
        {
            Initialize<NativePgfLiteralInt>(PgfLiteralTag.PGF_LITERAL_INT,
                (ref NativePgfLiteralInt ilit) => ilit.val = val);
        }

        public override R Accept<R>(IVisitor<R> visitor)
        {
            return visitor.VisitLiteralInt(Value);
        }

        public int Value => Marshal.PtrToStructure<NativePgfLiteralInt>(LitDataPtr).val;
        
		[StructLayout(LayoutKind.Sequential)]
		private struct NativePgfLiteralInt { public int val;    }
    }

    public class LiteralFloatExpr : LiteralExpr
    {
        internal LiteralFloatExpr(IntPtr expr, NativeGU.NativeMemoryPool pool) : base(expr, pool) { }
        public LiteralFloatExpr(double val) : base()
        {
            Initialize<NativePgfLiteralFlt>(PgfLiteralTag.PGF_LITERAL_FLT,
                (ref NativePgfLiteralFlt flit) => flit.val = val);
        }

        public override R Accept<R>(IVisitor<R> visitor)
        {
            return visitor.VisitLiteralFloat(Value);
        }

        public double Value => Marshal.PtrToStructure<NativePgfLiteralFlt>(LitDataPtr).val;
        
   		[StructLayout(LayoutKind.Sequential)]
		private struct NativePgfLiteralFlt { public double val; }
    }

	public abstract class LiteralExpr : Expr
    {
        internal LiteralExpr(IntPtr expr, NativeGU.NativeMemoryPool pool) : base(expr, pool) { }
        internal LiteralExpr() { }

        internal new static Expr FromPtr(IntPtr expr, NativeGU.NativeMemoryPool pool)
        {
            var dataPtr = NativeGU.gu_variant_open(expr).Data; // PgfExprLit* 
            var data = Marshal.PtrToStructure<NativePgfExprLit>(dataPtr);
            var literalTag = (PgfLiteralTag)NativeGU.gu_variant_open(data.lit).Tag;

            switch(literalTag)
            {
                case PgfLiteralTag.PGF_LITERAL_STR:
                    return new LiteralStringExpr(expr, pool);
                case PgfLiteralTag.PGF_LITERAL_INT:
                    return new LiteralIntExpr(expr, pool);
                case PgfLiteralTag.PGF_LITERAL_FLT:
                    return new LiteralFloatExpr(expr, pool);
                default:
                    throw new ArgumentException();
            }
        }

        internal void Initialize<TNative>(PgfLiteralTag litTag, Native.StructAction<TNative> setValue, UIntPtr? size = null) {
            _pool = new NativeGU.NativeMemoryPool();

            var exprTag = (byte)(int)PgfExprTag.PGF_EXPR_LIT;
			IntPtr litPtr = NativeGU.gu_alloc_variant ( exprTag,
				(UIntPtr)Marshal.SizeOf<NativePgfExprLit>(), UIntPtr.Zero, ref _ptr, _pool.Ptr);

			Native.EditStruct<NativePgfExprLit> (litPtr, (ref NativePgfExprLit lit) => {
				IntPtr ilitPtr = NativeGU.gu_alloc_variant ((byte)litTag,
					(UIntPtr)Marshal.SizeOf<TNative> (), UIntPtr.Zero, ref lit.lit, _pool.Ptr);

				Native.EditStruct<TNative>(ilitPtr, setValue); 
			});
		}

		// Deref DatPtr to det PgfExprLit.
		private NativePgfExprLit Data => Marshal.PtrToStructure<NativePgfExprLit>(DataPtr);

		private PgfLiteralTag LiteralTag => (PgfLiteralTag) NativeGU.gu_variant_open(Data.lit).Tag;
		internal IntPtr LitDataPtr => NativeGU.gu_variant_open(Data.lit).Data;

		internal enum PgfLiteralTag {
			PGF_LITERAL_STR,
			PGF_LITERAL_INT,
			PGF_LITERAL_FLT,
			PGF_LITERAL_NUM_TAGS
		}

		[StructLayout(LayoutKind.Sequential)]
		internal struct NativePgfExprLit    { public IntPtr lit; }
	}
}

