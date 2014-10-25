{-# LANGUAGE NoMonomorphismRestriction #-}
{-# OPTIONS_GHC -fno-warn-type-defaults -fno-warn-missing-signatures #-}
import           Control.Monad
import           Data.List
import           Data.Monoid
import           Data.Ratio
import           XMonad
import           XMonad.Actions.CycleRecentWS
import           XMonad.Prompt.Shell
import           XMonad.Actions.CycleWS
import           XMonad.Actions.Search        (SearchEngine, intelligent, multi,  promptSearch, searchEngine, selectSearch , (!>))
import           XMonad.Actions.WindowGo
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.Column
import           XMonad.Layout.Drawer
import           XMonad.Layout.Grid
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Tabbed
import           XMonad.Prompt
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig
import           XMonad.Util.XSelection
import           XMonad.Util.Themes

myWorkspaces :: [String]
myWorkspaces = zipWith (++) (map show [1..]) ["emacs","web","free", "free", "chat","hipchat","skype","music","gimp","free", "free", "free"]

ws :: Int -> String
ws = (myWorkspaces !!)

(<=?) :: Eq a => Query [a] -> [a] -> Query Bool
q <=? x = fmap (x `isPrefixOf`) q

(*=?) :: Eq a => Query [a] -> [a] -> Query Bool
q *=? x = fmap (x `isInfixOf`) q

windowH :: ManageHook
windowH = composeAll
  [ title    <=? "weechat"     --> doShift (ws 4)
  , title    <=? "IRC"         --> doShift (ws 4)
  , title     *=? "[ Zed ]"    --> doShift (ws 0)
  , title     =? "Zed Project Picker" --> doShift (ws 0)
  , className =? "Thunderbird" --> doShift (ws 5)
  , className =? "Skype"       --> doShift (ws 6)
  , className =? "Chromium"    --> doShift (ws 1)
  , browserP                   --> doShift (ws 1)
  , className =? "Gimp"        --> doShift (ws 8)
  , className =? "Gimp"        --> fmap (Endo . W.sink) ask
  , className =? "HipChat"     --> doShift (ws 5)
  -- Hide HipChat "Signing in ..." window.
  , className =? "HipChat" <&&> isDialog <&&> title =? "HipChat" --> hideMappedWindow >> doIgnore
  ]

-- | Hide a window, without unmapping it. This is needed to work around a bug in hipchat
-- where the appliction crashes when the signing in window is unmapped.
hideMappedWindow :: Query ()
hideMappedWindow = ask >>= \w -> liftX . tileWindow w $ Rectangle 0 0 0 0

manageH :: ManageHook -> ManageHook
manageH s = manageDocks <+> windowH <+> s

layoutH s = avoidStruts $ browser $ irc $ gimp $ skype $ s ||| Grid
  where skype = onWorkspace (ws 6) skypeLayout
        skypeLayout = flip onLeft Grid $ simpleDrawer 0.2 0.2 $ Title "bennofs - Skype™"
        gimp = onWorkspace (ws 8) gimpLayout
        gimpLayout = onLeft gimpToolbox $ onRight gimpDock Grid
        gimpToolbox = simpleDrawer 0.025 0.15 $ Role "gimp-toolbox"
        gimpDock = simpleDrawer 0.05 0.2 $ Role "gimp-dock"
        irc = onWorkspace (ws 4) $ tabbed shrinkText (theme wfarrTheme)
        browser = onWorkspace (ws 1) $ tabbed shrinkText (theme wfarrTheme)

logH :: X () -> X ()
logH _ = dynamicLogString defaultPP >>= xmonadPropLog

hayoo :: SearchEngine
hayoo = searchEngine "hayoo" "http://hayoo2.fh-wedel.de/?query="

hackage :: SearchEngine
hackage = searchEngine "hackage" "http://hackage.haskell.org/packages/search?terms="

dictcc :: SearchEngine
dictcc = searchEngine "dictcc" "http://www.dict.cc/?=DEEN&s="

browserP :: Query Bool
browserP = stringProperty "WM_WINDOW_ROLE" =? "browser"

promptConfig :: XPConfig
promptConfig = defaultXPConfig
  { font = "xft:Source Code Pro-8"
  , fgColor = "#f5f5f5"
  , bgColor = "#001e20"
  , bgHLight = "#002525"
  , fgHLight = "#ffc125"
  , borderColor = "#004466"
  }

promptSearchRaise engines = promptSearch promptConfig engines >> raise browserP
selectSearchRaise engines = selectSearch engines >> raise browserP

bindings =
    [ ("<XF86AudioLowerVolume>", spawn "amixer set Master 1-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 1+")
    , ("<XF86AudioMute>"       , spawn "amixer set Master toggle"  )
    , ("M-<Up>"                , nextWS                )
    , ("M-<Down>"              , prevWS                )
    , ("M-<Right>"             , nextScreen            )
    , ("M-<Left>"              , prevScreen            )
    , ("M-y"                   , moveTo Next EmptyWS   )
    , ("M-j"                   , windows W.focusUp     )
    , ("M-k"                   , windows W.focusDown   )
    , ("M-b"                   , raiseMaybe (spawn "uzbl-browser") browserP)
    , ("M-x"                   , sendMessage ToggleStruts)
    , ("C-<Tab>"               , cycleRecentWS [xK_Control_L] xK_Tab xK_grave)
    , ("M-s"                   , promptSearchRaise $ intelligent $ hayoo !> dictcc !> hackage !> multi)
    , ("M-S-s"                 , selectSearchRaise multi)
    , ("M-g"                   , promptSearchRaise hayoo)
    , ("M-S-g"                 , selectSearchRaise hayoo)
    , ("M-d"                   , promptSearchRaise dictcc)
    , ("M-S-d"                 , selectSearchRaise dictcc)
    , ("M-S-o"                 , promptSelection "xdg-open")
    , ("M-f"                   , spawn "thunar")
    , ("M-p"                   , shellPrompt promptConfig)
    , ("M-c"                   , runOrRaiseNext "emacs" $ className =? "Emacs")
    , ("<Print>"               , spawn "scrot '%y-%m-%d-%T.png' -e 'mv -b \"$f\" /data/pics/screen'")
    , ("M-<Print>"             , spawn "scrot '%y-%m-%d-%T.png' -s -e 'mv -b \"$f\" /data/pics/screen'")
    ] ++ zipWith (\n w -> ("M-<F" ++ show n ++ ">", windows $ W.greedyView w)) [1..] myWorkspaces
      ++ zipWith (\n w -> ("M-S-<F" ++ show n ++ ">", windows $ W.shift w)) [1..] myWorkspaces

conf = withUrgencyHook FocusHook $ ewmh $ defaultConfig
       { manageHook = manageH $ manageHook defaultConfig
       , layoutHook = layoutH $ layoutHook defaultConfig
       , logHook = logH $ logHook defaultConfig
       , modMask = mod4Mask
       , terminal = "urxvtc"
       , workspaces = myWorkspaces
       , handleEventHook = fullscreenEventHook
       } `additionalKeysP` bindings

main :: IO ()
main = xmonad conf { startupHook = startupHook conf >> setWMName "LG3D" }
