module Purlin where

import Prelude
import Data.Argonaut (decodeJson, parseJson, printJsonDecodeError)
import Data.Either (Either(..))
import Data.Map as Map
import Data.Maybe (Maybe(..), maybe)
import Data.String (Pattern(..), Replacement(..), replace)
import Effect (Effect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync as Fs
import Node.Globals (requireResolve)
import Node.Path as Path
import Node.Process as Process
import Npm.PackageJson (PackageJson(..), Bin(..))

newtype ModuleName
  = ModuleName String

type ResolveBinOptions
  = { cwd :: Maybe String
    }

resolveBin :: ResolveBinOptions -> ModuleName -> Effect String
resolveBin { cwd: customCwd } (ModuleName moduleName) = do
  cwd <- maybe Process.cwd pure customCwd
  modulePackageJsonPath <- requireResolve $ moduleName <> "/package.json"
  let
    moduleDirectory = Path.dirname modulePackageJsonPath
  packageJson <- Fs.readTextFile UTF8 modulePackageJsonPath
  case parseJson packageJson >>= decodeJson of
    Right (PackageJson packageJson') ->
      let
        fullPathToBin =
          packageJson'.bin
            >>= case _ of
                BinPath bin -> Just bin
                BinPaths paths -> Map.lookup moduleName paths
            # map (\binPath -> Path.concat [ moduleDirectory, binPath ])
            # maybe "" identity
      in
        pure $ fullPathToBin # replace (Pattern cwd) (Replacement ".")
    Left err -> pure $ printJsonDecodeError err
