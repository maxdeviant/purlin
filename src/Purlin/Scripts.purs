module Purlin.Scripts where

import Prelude
import CrossSpawn (Command(..), SpawnSyncOptions(..), SpawnSyncResult(..), spawnSync)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Node.Process as Process
import Purlin (ModuleName(..), resolveBin)

format :: Effect Unit
format = do
  purty <- resolveBin { cwd: Nothing } (ModuleName "purty")
  (SpawnSyncResult result) <-
    spawnSync (Command purty)
      (Just [ "--write", "src/" ])
      (Just $ SpawnSyncOptions { stdio: "inherit" })
  Process.exit result.status
