{ name = "purlin"
, dependencies =
  [ "argonaut"
  , "console"
  , "effect"
  , "node-fs"
  , "node-path"
  , "node-process"
  , "npm-package-json"
  , "psci-support"
  , "stringutils"
  , "which"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
