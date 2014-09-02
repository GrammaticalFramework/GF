-- | Isolate dependencies on the problematic cgi package to this module
module CGI(module C) where
import Network.CGI as C(
       CGI,ContentType(..),Accept(..),Language(..),
       getVarWithDefault,readInput,negotiate,requestAcceptLanguage,getInput,
       setHeader,output,outputFPS,outputError,
       handleErrors,catchCGI,throwCGI,
       liftIO)
import Network.CGI.Protocol as C(CGIResult(..),CGIRequest(..),Input(..),
                                 Headers,HeaderName(..))
import Network.CGI.Monad as C(runCGIT)
