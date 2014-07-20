{-# LANGUAGE NoMonomorphismRestriction #-}
{-# OPTIONS_GHC -fno-warn-type-defaults -fno-warn-missing-signatures #-}
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
import           XMonad.Layout.Column
import           XMonad.Layout.Drawer
import           XMonad.Layout.IM
import           XMonad.Layout.Grid
import           XMonad.Layout.PerWorkspace
import           XMonad.Prompt
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig

myWorkspaces :: [String]
myWorkspaces = zipWith (++) (map show [1..]) ["emacs","web","free", "free", "chat","mail","skype","music","gimp","free", "free", "free"]

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
  , className *=? "dwb"        --> doShift (ws 1)
  , className =? "Gimp"        --> doShift (ws 8)
  , className =? "Gimp"        --> fmap (Endo . W.sink) ask
  ]

manageH :: ManageHook -> ManageHook
manageH s = manageDocks <+> windowH <+> s

layoutH s = avoidStruts $ emacs $ irc $ gimp $ skype $ s ||| Grid
  where skype = onWorkspace (ws 6) skypeLayout
        skypeLayout = flip onLeft Grid $ simpleDrawer 0.1 0.2 $ Title "bennofs - Skype™"
        gimp = onWorkspace (ws 8) gimpLayout
        gimpLayout = onLeft gimpToolbox $ onRight gimpDock Grid
        gimpToolbox = simpleDrawer 0.025 0.15 $ Role "gimp-toolbox"
        gimpDock = simpleDrawer 0.05 0.2 $ Role "gimp-dock"
        emacs = withIM (1%6) (Title "Speedbar 1.0")
        irc = onWorkspace (ws 4) $ Full ||| Column 1.3

logH :: X () -> X ()
logH _ = dynamicLogString defaultPP >>= xmonadPropLog

hayoo :: SearchEngine
hayoo = searchEngine "hayoo" "http://hayoo2.fh-wedel.de/?query="

hoogle :: SearchEngine
hoogle = searchEngine "hoogle" "http://www.haskell.org/hoogle/?hoogle="

dictcc :: SearchEngine
dictcc = searchEngine "dictcc" "http://www.dict.cc/?=DEEN&s="

dwbP :: Query Bool
dwbP = className *=? "dwb"

promptConfig :: XPConfig
promptConfig = defaultXPConfig
  { font = "xft:Source Code Pro-8"
  , fgColor = "#f5f5f5"
  , bgColor = "#1f2f2f"
  , bgHLight = "#1f2f2f"
  , fgHLight = "#ffc125"
  , borderColor = "#000010"
  }

promptSearchRaise engines = promptSearch promptConfig engines >> raise dwbP
selectSearchRaise engines = selectSearch engines >> raise dwbP

bindings =
    [ ("<XF86AudioLowerVolume>", spawn "volume.sh -d 5")
    , ("<XF86AudioRaiseVolume>", spawn "volume.sh -i 5")
    , ("<XF86AudioMute>"       , spawn "volume.sh -t"  )
    , ("M-<Up>"                , nextWS                )
    , ("M-<Down>"              , prevWS                )
    , ("M-b"                   , raiseMaybe (spawn "dwb") dwbP)
    , ("M-x"                   , sendMessage ToggleStruts)
    , ("C-<Tab>"               , cycleRecentWS [xK_Control_L] xK_Tab xK_grave)
    , ("M-s"                   , promptSearchRaise $ intelligent $ hayoo !> dictcc !> multi)
    , ("M-S-s"                 , selectSearchRaise multi)
    , ("M-g"                   , promptSearchRaise hayoo)
    , ("M-S-g"                 , selectSearchRaise hayoo)
    , ("M-d"                   , promptSearchRaise dictcc)
    , ("M-S-d"                 , selectSearchRaise dictcc)
    , ("M-u"                   , promptSearchRaise hoogle)
    , ("M-S-u"                 , selectSearchRaise hoogle)
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
