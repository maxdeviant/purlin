module Purlin.Scripts.Test
  ( test
  ) where

import Prelude
import CrossSpawn (Command(..), SpawnSyncOptions(..), SpawnSyncResult(..), spawnSync)
import Data.Array (concat)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Node.Process as Process
import Purlin (ModuleName(..), resolveBin)

test :: Array String -> Effect Unit
test args = do
  spago <- resolveBin { cwd: Nothing } (ModuleName "spago")
  let
    args' = concat [ [ "test" ], args ]
  (SpawnSyncResult result) <-
    spawnSync (Command spago)
      (Just args')
      (Just $ SpawnSyncOptions { stdio: "inherit" })
  Process.exit result.status
