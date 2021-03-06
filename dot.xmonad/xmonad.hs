import XMonad hiding (Tall)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.LayoutHints
import XMonad.Layout.Tabbed
import XMonad.Layout.HintedTile
import XMonad.Layout.Spiral
import System.IO
import Solarized
import XMonad.Actions.Promote
import XMonad.Actions.UpdatePointer
import XMonad.Actions.Warp
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.NamedWindows

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import Data.Ratio
import System.IO (hPutStrLn)


data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)
instance UrgencyHook LibNotifyUrgencyHook where
  urgencyHook LibNotifyUrgencyHook w = do
    name <- getName w
    wins <- gets windowset
    whenJust (W.findTag w wins) (flash name)
    where flash name index = spawn $ "notify-send " ++ "'Workspace "    ++ index     ++ "' "
                                                    ++ "'Activity in: " ++ show name ++ "' "
                                                    ++ "--icon=notification-gpm-monitor"

myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
  spawn "compton -f -I 0.95 -O 0.95"
  spawn "notify-send 'Xmonad Started/Recompiled' --icon=emblem-system"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/pimeys/.xmobarrc"
    xmonad $ ewmh $ withUrgencyHook LibNotifyUrgencyHook $ defaultConfig
        { manageHook = manageDocks
        , layoutHook = myLayout
        , handleEventHook = mconcat
                          [ docksEventHook
                          , handleEventHook defaultConfig ]
        , startupHook = myStartupHook
        , terminal = "/usr/bin/roxterm"
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppCurrent = xmobarColor solarizedBase03 solarizedOrange . wrap "|" "|"
                        , ppTitle = xmobarColor solarizedGreen "" . shorten 50
                        } <+> fadeInactiveLogHook 0.6
        , modMask = mod4Mask
        , keys = \c -> myKeys c `M.union` keys defaultConfig c
        , normalBorderColor = lightBackgroundColor
        , focusedBorderColor = focusColor
        }
        where
          myLayout = avoidStruts $ layoutHook defaultConfig
                                 ||| tabbed shrinkText myTheme
          hintedTile = HintedTile nmaster delta ratio TopLeft
          nmaster = 1
          ratio   = 1/2
          delta   = 3/100

          myTheme :: Theme
          myTheme = defaultTheme
              { activeColor = lightBackgroundColor
              , inactiveColor = backgroundColor
              , urgentColor = backgroundColor
              , activeBorderColor = textColor
              , inactiveTextColor = textColor
              , urgentTextColor = textColor
              , inactiveBorderColor = lightBackgroundColor
              , urgentBorderColor = urgentColor
              , activeTextColor = lightTextColor
              , fontName = myFont
              }

          myFont = "xft:inconsolata:size=10:antialias=true"
          focusColor = solarizedBase00
          textColor = solarizedBase00
          lightTextColor = solarizedBase00
          backgroundColor = solarizedBase03
          lightBackgroundColor = solarizedBase02
          urgentColor = solarizedRed

          myKeys conf@(XConfig {XMonad.modMask = modMask, workspaces = ws}) = M.fromList $
              [
                ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") -- meta shift z
              , ((mod4Mask .|. shiftMask, xK_a), spawn "gvim ~/code/ruby") -- meta shift z
              , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s") -- print --> screenshot
              , ((mod4Mask, xK_i), spawn "amixer -c 1 sset Master 0")
              , ((mod4Mask, xK_u), spawn "amixer -c 1 sset Master 1dB-")
              , ((mod4Mask, xK_o), spawn "amixer -c 1 sset Master 1dB")
              , ((mod4Mask, xK_p), spawn "dmenu_run")
              ]
