module Which
  ( whichSync
  , whichAllSync
  ) where

import Prelude
import Data.Array.NonEmpty (NonEmptyArray, fromArray)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)

foreign import whichSyncImpl :: EffectFn1 String (Nullable String)

whichSync :: String -> Effect (Maybe String)
whichSync command = do
  result <- runEffectFn1 whichSyncImpl command
  pure $ toMaybe result

foreign import whichAllSyncImpl :: EffectFn1 String (Nullable (Array String))

whichAllSync :: String -> Effect (Maybe (NonEmptyArray String))
whichAllSync command = do
  result <- runEffectFn1 whichAllSyncImpl command
  pure
    $ toMaybe result
    >>= fromArray
