module CrossSpawn
  ( spawnSync
  , Command(..)
  , SpawnSyncOptions(..)
  , SpawnSyncResult(..)
  ) where

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Effect.Uncurried (EffectFn3, runEffectFn3)

newtype Command
  = Command String

type Args
  = Array String

newtype SpawnSyncOptions
  = SpawnSyncOptions
  { stdio :: String
  }

newtype SpawnSyncResult
  = SpawnSyncResult
  { status :: Int
  }

foreign import spawnSyncImpl :: EffectFn3 String (Nullable Args) (Nullable SpawnSyncOptions) SpawnSyncResult

spawnSync :: Command -> Maybe Args -> Maybe SpawnSyncOptions -> Effect SpawnSyncResult
spawnSync (Command command) args options =
  runEffectFn3 spawnSyncImpl
    command
    (toNullable args)
    (toNullable options)
