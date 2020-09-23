module Purlin.Scripts
  ( build
  , format
  , module Purlin.Scripts.Test
  ) where

import Prelude
import CrossSpawn (Command(..), SpawnSyncOptions(..), SpawnSyncResult(..), spawnSync)
import Data.Array (concat)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Node.Process as Process
import Purlin (ModuleName(..), resolveBin)
import Purlin.Scripts.Test (test)

format :: Array String -> Effect Unit
format args = do
  purty <- resolveBin { cwd: Nothing } (ModuleName "purty")
  case purty of
    Right purty' -> do
      (SpawnSyncResult result) <-
        spawnSync (Command purty')
          (Just [ "--write", "src/" ])
          (Just $ SpawnSyncOptions { stdio: "inherit" })
      Process.exit result.status
    Left err -> log err

build :: Array String -> Effect Unit
build args = do
  spago <- resolveBin { cwd: Nothing } (ModuleName "spago")
  case spago of
    Right spago' -> do
      let
        args' = concat [ [ "build" ], args ]
      (SpawnSyncResult result) <-
        spawnSync (Command spago')
          (Just args')
          (Just $ SpawnSyncOptions { stdio: "inherit" })
      Process.exit result.status
    Left err -> log err
