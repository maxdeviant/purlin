module Which
  ( whichSync
  ) where

import Prelude
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)

foreign import whichSyncImpl :: EffectFn1 String (Nullable String)

whichSync :: String -> Effect (Maybe String)
whichSync command = do
  result <- runEffectFn1 whichSyncImpl command
  pure $ toMaybe result
