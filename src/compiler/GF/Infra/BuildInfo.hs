module GF.Infra.BuildInfo where
import System.Info
import Data.Version(showVersion)

buildInfo =
    "Built on "++os++"/"++arch
    ++" with "++compilerName++"-"++showVersion compilerVersion