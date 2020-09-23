module Test.Main where

import Prelude
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Newtype (wrap)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Npm.PackageJson (Bin(..))
import Npm.PackageJson as PackageJson
import Purlin (ResolvedPackageJson(..), resolveBinFromPackageJson)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main = do
  launchAff_
    $ runSpec [ consoleReporter ] do
        describe "Purlin" do
          describe "resolveBinFromPackageJson" do
            it "works when there is a single binary" do
              let
                resolvedPackageJson =
                  ResolvedPackageJson
                    { packageJson:
                        PackageJson.fromNameAndVersion "prettier" "1.0.0"
                          # PackageJson.map
                              ( \json ->
                                  json
                                    { bin = Just $ BinPath "./bin-prettier.js"
                                    }
                              )
                    , directory: "/home/my-user/my-project/node_modules/prettier"
                    }
              resolveBinFromPackageJson resolvedPackageJson (wrap "prettier")
                `shouldEqual`
                  Just "/home/my-user/my-project/node_modules/prettier/bin-prettier.js"
            it "works when there are multiple binaries" do
              let
                resolvedPackageJson =
                  ResolvedPackageJson
                    { packageJson:
                        PackageJson.fromNameAndVersion "some-bin" "1.0.0"
                          # PackageJson.map
                              ( \json ->
                                  json
                                    { bin =
                                      Just $ BinPaths $ mempty
                                        # Map.insert "bin-a" "./a.js"
                                        # Map.insert "bin-b" "./b.js"
                                    }
                              )
                    , directory: "/home/my-user/my-project/node_modules/some-bin"
                    }
              resolveBinFromPackageJson resolvedPackageJson (wrap "bin-b")
                `shouldEqual`
                  Just "/home/my-user/my-project/node_modules/some-bin/b.js"
