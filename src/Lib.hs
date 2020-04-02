module Lib (serve) where

import Web.Scotty
import Network.Wai.Middleware.Static


serve :: IO ()
serve = do
  let cachingStrategy = CustomCaching $ const [("cache-control", "no-cache")]
  cacheContainer <- initCaching cachingStrategy
  scotty 8080 $ server cacheContainer

server :: CacheContainer -> ScottyM ()
server cacheContainer = do
  middleware $ staticPolicy' cacheContainer $ addBase staticDirectory
  get (function (const $ Just [])) $ file $ staticDirectory ++ "/index.html"

staticDirectory :: String
staticDirectory = "web/target"
