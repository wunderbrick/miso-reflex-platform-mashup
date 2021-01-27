module Main where

import           Frontend.Frontend

-- ghcide will complain about imports not found here but that's no big since everything we need to work with is in the library stuff
main :: IO ()
main = runApp