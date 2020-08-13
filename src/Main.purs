module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Purlin.Scripts (format)

main :: Effect Unit
main = do
  log "Running format"
  format
