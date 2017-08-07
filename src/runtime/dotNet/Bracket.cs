using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PGFSharp
{
	// Brackets should only be constructed from the Concrete class.
	// These classes just store the data, they do not own or use
	// unmanaged memory (except in the builder class).
	
	public interface IBracketChild {
		bool IsString {get;}
		string AsStringChild {get;}
		Bracket AsBracketChild {get;}
	}

	/// <summary>
	/// A representation for a syntactic constituent in the parse tree
    /// of a sentence.
    /// </summary>
	public class Bracket : IBracketChild
    {
		public class StringChildBracket : IBracketChild {

			string str;
			internal StringChildBracket(string str) {
				this.str = str;
			}

			public bool IsString => true;
			public string AsStringChild => str;
			public Bracket AsBracketChild {
				get {
					throw new NotImplementedException ();
				}
			}

			public override string ToString () => AsStringChild;
		}

		internal class BracketBuilder {
			internal Native.PgfLinFuncs LinFuncs { get; private set; }

			private Stack<Bracket> stack = new Stack<Bracket> ();
			private Bracket final = null;
			internal BracketBuilder() {
				LinFuncs = new Native.PgfLinFuncs {
					symbol_token = SymbolToken,
					begin_prase = BeginPhrase,
					end_phrase = EndPhrase,
					symbol_ne = null,
					symbol_bind = null,
					symbol_capit = null,
					symbol_meta = SymbolMeta
				};
			}

			// TODO: the Python wrapper discards begin/end phrase pairs
			// which don't have any tokens. Is this correct and/or necessary?
			private void SymbolToken(IntPtr self, IntPtr token) {
				var str = Native.NativeString.StringFromNativeUtf8 (token);
				stack.Peek ().AddChild (new StringChildBracket (str));
			}

			private void BeginPhrase(IntPtr self, IntPtr cat, int fid, int lindex, IntPtr fun) {
				stack.Push (new Bracket ());
			}

			private void EndPhrase(IntPtr self, IntPtr cat, int fid, int lindex, IntPtr fun) {
				var b = stack.Pop ();

				b.CatName = Native.NativeString.StringFromNativeUtf8 (cat);
				b.FunName = Native.NativeString.StringFromNativeUtf8 (fun);
				b.FId = fid;
				b.LIndex = lindex;

				if (stack.Count == 0)
					final = b;
				else 
					stack.Peek ().AddChild (b);
			}
			
			private void SymbolMeta(IntPtr self, int meta_id) {
				stack.Peek().AddChild(new StringChildBracket("?"));
			}

			public Bracket Build() {
				return final;
			}
		}

		private List<IBracketChild> _children = new List<IBracketChild> ();
		private Bracket() {
		}

		private void AddChild(IBracketChild c) {
			_children.Add(c);
		}

		public bool IsString => false;
		public Bracket AsBracketChild => this;
		public string AsStringChild {
			get {
				throw new NotImplementedException ();
			}
		}

		public IEnumerable<IBracketChild> Children { get { return _children; } }

		public string CatName { get; private set; }
		public string FunName { get; private set; }
		public int FId { get; private set; }
		public int LIndex { get; private set; }

		public override string ToString ()
		{
			return "(" + CatName + ":" + FId + " " + String.Join (" ", Children) + ")";
		}

		public string ToBracketsString =>  "{" + String.Join(" ", 
			Children.Select(c => (c is Bracket) ? ((Bracket)c).ToBracketsString : c.ToString() )
		 ) + "}";
    }


}
