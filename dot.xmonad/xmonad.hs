import XMonad hiding (Tall)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad (scratchpadManageHook, scratchpadSpawnActionCustom)
import XMonad.Util.NamedScratchpad
import XMonad.Layout.LayoutHints
import XMonad.Layout.Tabbed
import XMonad.Layout.HintedTile
import XMonad.Layout.Spiral
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import System.IO
import Solarized
import XMonad.Actions.Promote
import XMonad.Actions.UpdatePointer
import XMonad.Actions.Warp
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Util.Run (spawnPipe)

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Ratio
import System.IO (hPutStrLn)
import GHC.IOBase (Handle)

myTerminal :: String
myTerminal = "/usr/bin/gnome-terminal"

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect (0) (1/50) (1) (3/4))
scratchPad = scratchpadSpawnActionCustom myTerminal

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/pimeys/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = myManageHook
        , layoutHook = myLayout
        , terminal = myTerminal
        , workspaces = ["1:code", "2:web", "3:chat", "4:music", "5:tests", "6:gimp", "7:misc", "8:misc", "9:misc"]
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
          gimpLayout = withIM (11/64) (Role "gimp-toolbox") $ ResizableTall 2 (1/118) (11/20) [1]
          myLayout = avoidStruts $ onWorkspace "*" gimpLayout $ layoutHook defaultConfig
                                 ||| tabbed shrinkText myTheme ||| Grid
          myManageHook = manageDocks <+> manageScratchPad
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
              , ((mod4Mask, xK_p), spawn "dmenu_dark")
              , ((mod4Mask .|. shiftMask, xK_p), scratchPad)
              ]
