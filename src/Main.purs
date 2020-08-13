module Main where

import Prelude
import Data.Array (drop, head, tail)
import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import Effect.Console (log)
import Node.Process as Process
import Purlin.Scripts (build, format)

main :: Effect Unit
main = do
  args <- map (drop 2) Process.argv
  let
    command = head args
  let
    commandArgs = maybe [] identity $ tail args
  case command of
    Just "format" -> do
      log "Running format"
      format commandArgs
    Just "build" -> do
      log "Running build"
      build commandArgs
    _ -> log "Command not found"
