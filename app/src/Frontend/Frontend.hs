{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE CPP #-}

module Frontend.Frontend where

import           Miso
import           Miso.String

import           Control.Monad
import           Control.Lens

#ifndef __GHCJS__
import qualified Reflex.Dom as RD
#else
import           qualified Language.Javascript.JSaddle.Warp as W
#endif

import           qualified Language.Javascript.JSaddle as J
import qualified Data.Text as T

-- Type synonym for an application model
type Model = Int

-- Sum type for application events
data Action
  = AddOne
  | SubtractOne
  | SayHelloWorld
  | NoOp
  deriving (Show, Eq)

-- CPP won't work with brittany apparently, need to keep conditional code as isolated from main code we want to edit as possible if we want nice formatting.
#ifndef __GHCJS__
-- For local development with Warp as well as mobile builds.
runApp :: IO ()
runApp = RD.mainWidget $ do
  -- There's just too much going on with the Android setup to DIY this. 
  -- It'll be easier to figure out how to handle assets with GHCJS vs JSaddle and GHC.
  ctx <- RD.unJSContextSingleton <$> RD.askJSContext
  J.runJSaddle ctx app
#else
-- For compiling a web release with GHCJS.
runApp :: IO ()
runApp = W.run 3003 app
#endif

-- Entry point for a miso application
app :: JSM ()
app = startApp App {..}

  where
    initialAction = NoOp -- initial action to be executed on application load
    model  = 0                    -- initial model
    update = updateModel          -- update function
    view   = viewModel            -- view function
    events = defaultEvents        -- default delegated events
    subs   = []                   -- empty subscription list
    mountPoint = Nothing          -- mount point for application (Nothing defaults to 'body')
    logLevel = Off                -- used during prerendering to see if the VDOM and DOM are in synch (only used with `miso` function)

-- Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel AddOne m = noEff (m + 1)
updateModel SubtractOne m = noEff (m - 1)
updateModel NoOp m = noEff m
updateModel SayHelloWorld m =
  m <# do consoleLog "Hello World" >> pure NoOp

-- Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel model =
  div_ [ class_ "just-an-example-app-background" ] [
    button_ [ onClick AddOne ] [ text "+" ]
  , text (ms model)
  , button_ [ onClick SubtractOne ] [ text "-" ]
  , button_ [ onClick SayHelloWorld ] []
  ]