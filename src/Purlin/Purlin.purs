module Purlin where

import Prelude
import Data.Argonaut (decodeJson, parseJson, printJsonDecodeError)
import Data.Bifunctor (bimap)
import Data.Either (Either, note)
import Data.Foldable (find)
import Data.Map as Map
import Data.Maybe (Maybe(..), maybe, maybe')
import Data.Newtype (class Newtype, unwrap)
import Data.String (Pattern(..), Replacement(..), replace)
import Data.String.Utils (startsWith)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Node.FS.Sync as Fs
import Node.Globals (requireResolve)
import Node.Path as Path
import Node.Process as Process
import Npm.PackageJson (PackageJson(..), Bin(..))
import Which (whichAllSync)

newtype ModuleName
  = ModuleName String

derive instance newtypeModuleName :: Newtype ModuleName _

newtype ResolvedPackageJson
  = ResolvedPackageJson
  { packageJson :: PackageJson
  , directory :: String
  }

resolvePackageJson :: ModuleName -> Effect (Either String ResolvedPackageJson)
resolvePackageJson (ModuleName moduleName) = do
  modulePackageJsonPath <- requireResolve $ moduleName <> "/package.json"
  let
    moduleDirectory = Path.dirname modulePackageJsonPath
  packageJsonContents <- Fs.readTextFile UTF8 modulePackageJsonPath
  pure
    $ bimap printJsonDecodeError
        ( \packageJson ->
            ResolvedPackageJson
              { packageJson
              , directory: moduleDirectory
              }
        )
    $ parseJson packageJsonContents
    >>= decodeJson

resolveBinFromPackageJson :: ResolvedPackageJson -> ModuleName -> Maybe String
resolveBinFromPackageJson (ResolvedPackageJson { directory: moduleDirectory, packageJson: (PackageJson packageJson) }) (ModuleName moduleName) =
  packageJson.bin
    >>= case _ of
        BinPath bin -> Just bin
        BinPaths paths -> Map.lookup moduleName paths
    # map (\binPath -> Path.concat [ moduleDirectory, binPath ])

type ResolveBinOptions
  = { cwd :: Maybe String
    }

resolveBin :: ResolveBinOptions -> ModuleName -> Effect (Either String String)
resolveBin { cwd: customCwd } moduleName = do
  pathsFromWhich <- whichAllSync Nothing $ unwrap moduleName
  let
    nixPath = pathsFromWhich >>= (find $ startsWith "/nix/store/")
  maybe' (\unit -> resolveFromPackageJson) (pure >>> pure) nixPath
  where
  resolveFromPackageJson = do
    cwd <- maybe Process.cwd pure customCwd
    packageJson <- resolvePackageJson moduleName
    pure
      $ packageJson
      # map
          ( \resolvedPackageJson ->
              resolveBinFromPackageJson resolvedPackageJson moduleName
          )
      >>= note "Failed to resolve bin"
      # map (replace (Pattern cwd) (Replacement "."))
