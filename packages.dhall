let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200724/packages.dhall sha256:bb941d30820a49345a0e88937094d2b9983d939c9fd3a46969b85ce44953d7d9

let overrides = {=}

let additions =
  { npm-package-json =
    { dependencies =
        [ "argonaut"
        ]
    , repo = "https://github.com/maxdeviant/purescript-npm-package-json.git"
    , version = "94443a53c14f001425245d1bf6e060a70fc9f905"
    }
  , which =
    { dependencies =
      [ "arrays"
      , "nullable"
      ]
    , repo = "https://github.com/maxdeviant/purescript-which.git"
    , version = "1ae31e6f80a0d91171206a56ee0d9b68ec50d671"
    }
  }

in  upstream // overrides // additions
