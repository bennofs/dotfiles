{-# LANGUAGE NoMonomorphismRestriction #-}
{-# OPTIONS_GHC -fno-warn-type-defaults -fno-warn-missing-signatures #-}
import           Data.List
import           Data.Monoid
import           Control.Applicative
import           Control.Monad
import           XMonad
import           XMonad.Actions.CycleRecentWS
import           XMonad.Actions.CycleWS
import           XMonad.Actions.Search        (SearchEngine, intelligent, multi,  promptSearchBrowser, searchEngine, selectSearchBrowser , (!>))
import           XMonad.Actions.WindowGo
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.Column
import           XMonad.Layout.Drawer
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

windowH :: ManageHook
windowH = composeAll $
  [ title    <=? "weechat"     --> doShift (ws 4)
  , title    <=? "IRC"         --> doShift (ws 4)
  , className =? "Thunderbird" --> doShift (ws 5)
  , className =? "Skype"       --> doShift (ws 6)
  , className =? "Chromium"    --> doShift (ws 1)
  , className =? "Gimp"        --> doShift (ws 8)
  , className =? "Gimp"        --> fmap (Endo . W.sink) ask
  ]

manageH :: ManageHook -> ManageHook
manageH s = manageDocks <+> windowH <+> s

layoutH s = avoidStruts $ irc $ gimp $ skype $ s ||| Grid
  where skype = onWorkspace (ws 6) skypeLayout
        skypeLayout = flip onLeft Grid $ simpleDrawer 0.1 0.2 $ Title "bennofs - Skype™"
        gimp = onWorkspace (ws 8) gimpLayout
        gimpLayout = onLeft gimpToolbox $ (onRight gimpDock Grid)
        gimpToolbox = simpleDrawer 0.025 0.15 $ Role "gimp-toolbox"
        gimpDock = simpleDrawer 0.05 0.2 $ Role "gimp-dock"
        irc = onWorkspace (ws 4) $ Full ||| Column 1.3

logH :: X () -> X ()
logH _ = dynamicLogString defaultPP >>= xmonadPropLog

hayoo :: SearchEngine
hayoo = searchEngine "hayoo" "http://holumbus.fh-wedel.de/hayoo/hayoo.html?query="

dictcc :: SearchEngine
dictcc = searchEngine "dictcc" "http://www.dict.cc/?=DEEN&s="

promptSearchB :: XPConfig -> SearchEngine -> X ()
promptSearchB = flip promptSearchBrowser "chromium"

selectSearchB :: SearchEngine -> X ()
selectSearchB = selectSearchBrowser "chromium"

bindings =
    [ ("<XF86AudioLowerVolume>", spawn "volume.sh -d 5")
    , ("<XF86AudioRaiseVolume>", spawn "volume.sh -i 5")
    , ("<XF86AudioMute>"       , spawn "volume.sh -t"  )
    , ("M-<Up>"                , nextWS                )
    , ("M-<Down>"              , prevWS                )
    , ("M-b"                   , raiseMaybe (spawn "chromium" >> windows (W.greedyView $ ws 1)) $ className =? "Chromium")
    , ("M-x"                   , sendMessage ToggleStruts)
    , ("C-<Tab>"               , cycleRecentWS [xK_Control_L] xK_Tab xK_grave)
    , ("M-s"                   , promptSearchB defaultXPConfig $ intelligent $ hayoo !> dictcc !> multi)
    , ("M-S-s"                 , selectSearchB multi)
    , ("M-g"                   , promptSearchB defaultXPConfig hayoo)
    , ("M-S-g"                 , selectSearchB hayoo)
    , ("M-d"                   , promptSearchB defaultXPConfig dictcc)
    , ("M-f"                   , spawn "thunar")
    , ("M-c"                   , runOrRaiseNext "emacs" $ className =? "Emacs")
    , ("M-S-d"                 , selectSearchB dictcc)
    , ("<Print>"               , spawn "scrot '%y-%m-%d-%T.png' -e 'mv -b \"$f\" /home/benno/Screenshots'")
    , ("M-<Print>"             , spawn "scrot '%y-%m-%d-%T.png' -s -e 'mv -b \"$f\" /home/benno/Screenshots'")
    ] ++ zipWith (\n w -> ("M-<F" ++ show n ++ ">", windows $ W.greedyView w)) [1..] myWorkspaces
      ++ zipWith (\n w -> ("M-S-<F" ++ show n ++ ">", windows $ W.shift w)) [1..] myWorkspaces

conf = withUrgencyHook FocusHook $ ewmh $ defaultConfig
       { manageHook = manageH $ manageHook defaultConfig
       , layoutHook = layoutH $ layoutHook defaultConfig
       , logHook = logH $ logHook defaultConfig
       , modMask = mod4Mask
       , terminal = "konsole"
       , workspaces = myWorkspaces
       } `additionalKeysP` bindings

main :: IO ()
main = xmonad conf { startupHook = startupHook conf >> setWMName "LG3D" }
