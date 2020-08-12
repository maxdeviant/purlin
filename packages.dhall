let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200724/packages.dhall sha256:bb941d30820a49345a0e88937094d2b9983d939c9fd3a46969b85ce44953d7d9

let overrides = {=}

let additions =
  { npm-package-json =
    { dependencies =
        [ "argonaut"
        ]
    , repo = "https://github.com/maxdeviant/purescript-npm-package-json.git"
    , version = "52f51084f08527e69232b8c9ece8dfd1a172c049"
    }
  }

in  upstream // overrides // additions
