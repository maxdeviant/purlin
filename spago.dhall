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
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
