module Purlin.Scripts.Test
  ( test
  ) where

import Prelude
import CrossSpawn (Command(..), SpawnSyncOptions(..), SpawnSyncResult(..), spawnSync)
import Data.Array (concat)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import Effect.Console (log)
import Node.FS.Sync as Fs
import Node.Process as Process
import Purlin (ModuleName(..), resolveBin)

newtype TestConfig
  = TestConfig String

findTestConfig :: Effect (Maybe TestConfig)
findTestConfig = do
  let
    testConfigPath = "test/test.dhall"
  testConfigExists <- Fs.exists testConfigPath
  pure
    $ if testConfigExists then
        Just $ TestConfig testConfigPath
      else
        Nothing

test :: Array String -> Effect Unit
test args = do
  spago <- resolveBin { cwd: Nothing } (ModuleName "spago")
  case spago of
    Right spago' -> do
      testConfig <- findTestConfig
      let
        testConfigArgs =
          testConfig
            # maybe [] \(TestConfig config) -> [ "-x", config ]

        args' = concat [ testConfigArgs, [ "test" ], args ]
      (SpawnSyncResult result) <-
        spawnSync (Command spago')
          (Just args')
          (Just $ SpawnSyncOptions { stdio: "inherit" })
      Process.exit result.status
    Left err -> log err
