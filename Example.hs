module Main where

import Prelude
import Data.Set qualified as Set
import Codec.Compression.Zlib (compress, decompress)
import Prelude ((.), putStrLn)

main = print (Set.singleton "Hello from rules_haskell!")

slowId = decompress . compress
