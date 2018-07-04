{-# LANGUAGE CPP #-}
module GF.Infra.BuildInfo where
import System.Info
import Data.Version(showVersion)

{-# NOINLINE buildInfo #-}
buildInfo =
    "Built on "++os++"/"++arch
    ++" with "++compilerName++"-"++showVersion compilerVersion
    ++", flags:"
#ifdef USE_INTERRUPT
    ++" interrupt"
#endif
#ifdef SERVER_MODE
    ++" server"
#endif
#ifdef NEW_COMP
    ++" new-comp"
#endif
#ifdef C_RUNTIME
    ++" c-runtime"
#endif
