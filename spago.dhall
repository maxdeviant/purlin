{ name = "my-project"
, dependencies =
  [ "argonaut"
  , "console"
  , "effect"
  , "node-fs"
  , "node-path"
  , "node-process"
  , "npm-package-json"
  , "psci-support"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
