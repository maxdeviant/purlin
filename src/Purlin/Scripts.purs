module Purlin.Scripts where

import Prelude
import CrossSpawn (Command(..), SpawnSyncOptions(..), SpawnSyncResult(..), spawnSync)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Node.Process as Process
import Purlin (ModuleName(..), resolveBin)

format :: Array String -> Effect Unit
format args = do
  purty <- resolveBin { cwd: Nothing } (ModuleName "purty")
  (SpawnSyncResult result) <-
    spawnSync (Command purty)
      (Just [ "--write", "src/" ])
      (Just $ SpawnSyncOptions { stdio: "inherit" })
  Process.exit result.status

build :: Array String -> Effect Unit
build args = do
  spago <- resolveBin { cwd: Nothing } (ModuleName "spago")
  (SpawnSyncResult result) <-
    spawnSync (Command spago)
      (Just [ "build" ])
      (Just $ SpawnSyncOptions { stdio: "inherit" })
  Process.exit result.status
