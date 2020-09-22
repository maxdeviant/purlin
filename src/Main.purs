module Main where

import Prelude
import Data.Array (drop, head, tail)
import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import Effect.Console (log)
import Node.Process as Process
import Purlin.Scripts (build, format, test)

main :: Effect Unit
main = do
  args <- map (drop 2) Process.argv
  let
    command = head args
  let
    commandArgs = maybe [] identity $ tail args
  case command of
    Just "format" -> do
      format commandArgs
    Just "build" -> do
      build commandArgs
    Just "test" -> do
      test commandArgs
    Just unknownCommand -> log $ "Command \"" <> unknownCommand <> "\" not found"
    Nothing -> log "No command provided"
