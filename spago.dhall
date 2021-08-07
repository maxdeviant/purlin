{ name = "purlin"
, dependencies =
  [ "aff"
  , "argonaut"
  , "arrays"
  , "bifunctors"
  , "console"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "maybe"
  , "newtype"
  , "node-buffer"
  , "node-fs"
  , "node-path"
  , "node-process"
  , "npm-package-json"
  , "nullable"
  , "ordered-collections"
  , "prelude"
  , "psci-support"
  , "spec"
  , "strings"
  , "stringutils"
  , "which"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
