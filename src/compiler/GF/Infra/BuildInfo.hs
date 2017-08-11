{-# LANGUAGE CPP #-}
module GF.Infra.BuildInfo where
import System.Info
import Data.Version(showVersion)
import DarcsVersion_gf

{-# NOINLINE buildInfo #-}
buildInfo =
    {-details++"\n"++-}
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
  where
    details = either (const no_info) info darcs_info
    no_info = "No detailed version info available"
    info (otag,olast,changes,whatsnew) =
      (case changes of
         0 -> "No recorded changes"
         1 -> "One recorded change"
         _ -> show changes++" recorded changes")++
      (case whatsnew of
         0 -> ""
         1 -> " + one file with unrecorded changes"
         _ -> " + "++show whatsnew++" files with unrecorded changes")++
      (maybe "" (" since "++) otag)++
      (maybe "" ("\nLast recorded change: "++) olast)
