let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.14.3-20210722/packages.dhall sha256:1ceb43aa59436bf5601bac45f6f3781c4e1f0e4c2b8458105b018e5ed8c30f8c

let overrides = {=}

let additions =
      { npm-package-json =
        { dependencies =
          [ "argonaut"
          , "control"
          , "either"
          , "foreign-object"
          , "maybe"
          , "ordered-collections"
          , "prelude"
          ]
        , repo = "https://github.com/maxdeviant/purescript-npm-package-json.git"
        , version = "89beafabfd0ab1edd0bc11f3140b9b75037d2a98"
        }
      , which =
        { dependencies =
          [ "arrays"
          , "effect"
          , "foreign"
          , "maybe"
          , "nullable"
          , "options"
          , "prelude"
          ]
        , repo = "https://github.com/maxdeviant/purescript-which.git"
        , version = "1ae31e6f80a0d91171206a56ee0d9b68ec50d671"
        }
      }

in  upstream // overrides // additions
