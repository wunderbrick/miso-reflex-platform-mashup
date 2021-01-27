module Backend.Server where

import Common.Common

server :: IO ()
server = putStrLn $ commonVal ++ " I'm being served by backend code!"