{-# LANGUAGE NoMonomorphismRestriction #-}
{-# OPTIONS_GHC -fno-warn-type-defaults -fno-warn-missing-signatures #-}
import           Control.Monad
import           Data.List hiding (group)
import           Data.Monoid
import           Data.Ratio
import           System.Exit
import           XMonad
import           XMonad.Actions.CycleRecentWS
import           XMonad.Prompt.Shell
import           XMonad.Actions.CycleWS
import qualified XMonad.Actions.Search as S
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
import           XMonad.Layout.Groups
import qualified XMonad.Layout.Groups.Helpers as Group
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Tabbed
import           XMonad.Prompt
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig
import           XMonad.Util.XSelection
import           XMonad.Util.Themes
import           XMonad.Util.Cursor

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
-- where the appliction crashes when the "signing in" window is unmapped.
hideMappedWindow :: Query ()
hideMappedWindow = ask >>= \w -> liftX . tileWindow w $ Rectangle 0 0 0 0

manageH :: ManageHook -> ManageHook
manageH s = manageDocks <+> windowH <+> s

browserLayout = group (tabbed shrinkText (theme wfarrTheme)) layouts where
  tiled = Tall 1 (3/100) (1/2)
  layouts = Grid ||| tiled ||| Mirror tiled ||| Full

layoutH s = avoidStruts $ browser $ irc $ gimp $ skype $ s ||| Grid
  where skype = onWorkspace (ws 6) skypeLayout
        skypeLayout = flip onLeft Grid $ simpleDrawer 0.2 0.2 $ Title "bennofs - Skype™"
        gimp = onWorkspace (ws 8) gimpLayout
        gimpLayout = onLeft gimpToolbox $ onRight gimpDock Grid
        gimpToolbox = simpleDrawer 0.025 0.15 $ Role "gimp-toolbox"
        gimpDock = simpleDrawer 0.05 0.2 $ Role "gimp-dock"
        irc = onWorkspace (ws 4) $ tabbed shrinkText (theme wfarrTheme)
        browser = onWorkspace (ws 1) browserLayout

logH :: X () -> X ()
logH _ = dynamicLogString defaultPP >>= xmonadPropLog

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

promptSearchRaise engines = S.promptSearch promptConfig engines >> raise browserP
selectSearchRaise engines = S.selectSearch engines >> raise browserP

layoutKeys :: [(String, X ())]
layoutKeys =
  [ ("M-j"           , Group.focusUp)
  , ("M-S-j"         , Group.swapUp)
  , ("M-u"           , Group.focusGroupUp)
  , ("M-S-u"         , Group.moveToGroupUp False)
  , ("M-S-<Tab>"     , Group.focusUp)
  , ("M-k"           , Group.focusDown)
  , ("M-S-k"         , Group.swapDown)
  , ("M-i"           , Group.focusGroupDown)
  , ("M-S-i"         , Group.moveToGroupDown False)
  , ("M-<Tab>"       , Group.focusDown)
  , ("M-<Return>"    , Group.swapMaster)
  , ("M-<Backspace>" , Group.swapGroupMaster)
  , ("M-m"           , Group.focusMaster)
  , ("M-S-m"         , Group.focusGroupMaster)
  , ("M-h"           , sendMessage Shrink)
  , ("M-l"           , sendMessage Expand)
  , ("M-S-h"         , sendMessage (ToEnclosing $ SomeMessage Shrink))
  , ("M-S-l"         , sendMessage (ToEnclosing $ SomeMessage Expand))
  , ("M-t"           , withFocused $ windows . W.sink)
  , ("M-S-t"         , Group.toggleFocusFloat)
  , ("M-<Space>"     , sendMessage NextLayout)
  , ("M-S-<Space>"   , sendMessage (ToEnclosing $ SomeMessage NextLayout))
  , ("M-,"           , sendMessage (IncMasterN 1))
  , ("M-S-,"         , sendMessage (ToEnclosing $ SomeMessage $ IncMasterN 1))
  , ("M-."           , sendMessage (IncMasterN (-1)))
  , ("M-S-."         , sendMessage (ToEnclosing $ SomeMessage $ IncMasterN (-1)))
  , ("M-S-c"         , kill)
  ]

workspaceKeys :: [(String, X ())]
workspaceKeys =
  [ ("M-<Up>", nextWS)
  , ("M-<Down>", prevWS)
  , ("M-<Right>", nextScreen)
  , ("M-<Left>", prevScreen)
  , ("M-y", moveTo Next EmptyWS)
  , ("C-<Tab>", cycleRecentWS [xK_Control_L] xK_Tab xK_grave)
  ] ++ zipWith (\n w -> ("M-<F" ++ show n ++ ">", windows $ W.greedyView w)) [1..] myWorkspaces
    ++ zipWith (\n w -> ("M-" ++ show n, windows $ W.greedyView w)) [1..9] myWorkspaces
    ++ zipWith (\n w -> ("M-S-<F" ++ show n ++ ">", windows $ W.shift w)) [1..] myWorkspaces
    ++ zipWith (\n w -> ("M-S-" ++ show n, windows $ W.shift w)) [1..9] myWorkspaces

mediaKeys :: [(String, X ())]
mediaKeys =
  [ ("<XF86AudioLowerVolume>", spawn "amixer set Master 1-")
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 1+")
  , ("<XF86AudioMute>"       , spawn "amixer set Master toggle")
  , ("<XF86AudioPlay>"       , spawn "mpc toggle")
  , ("<XF86AudioPrev>"       , spawn "mpc prev")
  , ("<XF86AudioNext>"       , spawn "mpc next")
  ]

spawnKeys :: [(String, X ())]
spawnKeys =
  [ ("M-S-<Return>", spawn $ terminal conf)
  , ("M-S-o", promptSelection "xdg-open")
  , ("M-S-o", prompt "xdg-open" promptConfig)
  , ("M-p", shellPrompt promptConfig)
  , ("M-f", spawn "thunar")
  , ("M-e", runOrRaiseNext "emacs" $ className =? "Emacs")
  , ("M-b", runOrRaiseNext "uzbl-browser" browserP)
  , ("<Print>", spawn "scrot '%y-%m-%d-%T.png' -e 'mv -b \"$f\" /data/pics/screen'")
  , ("M-<Print>", spawn "scrot '%y-%m-%d-%T.png' -s -e 'mv -b \"$f\" /data/pics/screen'")
  ]


miscKeys :: [(String, X ())]
miscKeys =
  [ ("M-S-q"                 , io (exitWith ExitSuccess))
  , ("M-q"                   , spawn "xmonad --recompile && xmonad --restart")
  , ("M-x"                   , sendMessage ToggleStruts)
  ]

searchKeys :: [(String, S.SearchEngine)]
searchKeys =
  [ ("s", S.google)
  , ("d", S.searchEngine "dictcc" "http://www.dict.cc/?=DEEN&s=")
  , ("y", S.searchEngine "hayoo" "http://hayoo2.fh-wedel.de/?query=")
  , ("h", S.searchEngine "hackage" "http://hackage.haskell.org/packages/search?terms=")
  , ("p", S.hackage) -- direct package lookup, doesn't search
  , ("c", S.searchEngine "code" "https://searchcode.com/q?=")
  , ("t", S.searchEngine "thesaurus" "http://www.thesaurus.com/browse/")
  , ("g", S.searchEngine "github" "http://www.github.com/")
  ]

bindings :: [(String, X ())]
bindings = layoutKeys ++ workspaceKeys ++ mediaKeys ++ spawnKeys ++ miscKeys
  ++ [("M-s " ++ k, promptSearchRaise e) | (k,e) <- searchKeys]
  ++ [("M-S-s " ++ k, selectSearchRaise e) | (k,e) <- searchKeys]

conf = withUrgencyHook FocusHook $ ewmh $ defaultConfig
       { manageHook = manageH $ manageHook defaultConfig
       , layoutHook = layoutH $ layoutHook defaultConfig
       , logHook = logH $ logHook defaultConfig
       , modMask = mod4Mask
       , terminal = "urxvtc"
       , workspaces = myWorkspaces
       , handleEventHook = fullscreenEventHook
       , keys = \c -> mkKeymap c bindings
       }

startup :: X ()
startup = do
  setWMName "LG3D"
  setDefaultCursor xC_left_ptr

main :: IO ()
main = xmonad conf { startupHook = startupHook conf >> startup }
