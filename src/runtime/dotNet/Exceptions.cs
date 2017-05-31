using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PGFSharp
{

    [Serializable]
    public class PGFError : Exception
    {
        public PGFError() { }
        public PGFError(string message) : base(message) { }
        public PGFError(string message, Exception inner) : base(message, inner) { }
        protected PGFError(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context)
        { }
    }


    [Serializable]
    public class ParseError : Exception
    {
        public ParseError() { }
        public ParseError(string message) : base(message) { }
        public ParseError(string message, Exception inner) : base(message, inner) { }
        protected ParseError(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context)
        { }
    }

    [Serializable]
    public class TypeError : Exception
    {
        public TypeError() { }
        public TypeError(string message) : base(message) { }
        public TypeError(string message, Exception inner) : base(message, inner) { }
        protected TypeError(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context)
        { }
    }
}
