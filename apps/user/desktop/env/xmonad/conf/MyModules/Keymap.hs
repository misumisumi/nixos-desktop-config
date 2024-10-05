import Data.default

import qualified XMonad.Actions.CycleWS as CWS
import qualified XMonad.Actions.DynamicWorkspaceOrder as DWSO
import qualified XMonad.Actions.PhysicalScreens as PS
import qualified XMonad.Actions.WindowNavigation as WN
import qualified XMonad.Operations as O
import qualified XMonad.StackSet as W --hiding (focusMaster, workspaces)
import qualified XMonad.Layout.MultiToggle.Instances as MTI
import qualified XMonad.Layout.ToggleLayouts as TL
import qualified XMonad.Terminal as T
import XMonad (mod4Mask, shiftMask, controlMask)
import XMonad (
    xK_Tab,
    xK_Return,
    xK_space,
    xK_h,
    xK_j,
    xK_k,
    xK_l,
    xK_n,
    xK_p,
    xK_q,
    xK_f,
    xK_c,
    xK_m,
    xK_a,
    xK_v,
    xK_r,
    xK_e,
    xK_comma,
    xK_period,
    xK_Print
)
import qualified WorkspacePerMonitor as WPM
import qualified Params as P


toggleFloat x w = O.windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5) s))


modm = mod4Mask  --Super Key

keymap = [
    -- Operate window in workspace
      ((modm,                    xK_h), O.sendMessage $ WN.Go WN.L)
    , ((modm,                    xK_j), O.sendMessage $ WN.Go WN.D)
    , ((modm,                    xK_k), O.sendMessage $ WN.Go WN.U)
    , ((modm,                    xK_l), O.sendMessage $ WN.Go WN.R)
    , ((modm .|. shiftMask,      xK_h), O.sendMessage $ WN.Swap WN.L)
    , ((modm .|. shiftMask,      xK_j), O.sendMessage $ WN.Swap WN.D)
    , ((modm .|. shiftMask,      xK_k), O.sendMessage $ WN.Swap WN.U)
    , ((modm .|. shiftMask,      xK_l), O.sendMessage $ WN.Swap WN.R)
    , ((modm .|. controlMask   xK_c), O.kill)
     -- Operate window between workspaces
    , ((modm .|. controlMask,    xK_h), DWSO.moveTo CWS.Prev WPM.spacesOnCurrentScreen)
    , ((modm .|. controlMask,    xK_l), DWSO.moveTo CWS.Next WPM.spacesOnCurrentScreen)
    , ((modm .|. controlMask,    xK_j), DWSO.shiftTo CWS.Prev WPM.spacesOnCurrentScreen
                                        >> DWSO.moveTo CWS.Prev WPM.spacesOnCurrentScreen)
    , ((modm .|. controlMask,    xK_k), DWSO.shiftTo CWS.Next WPM.spacesOnCurrentScreen
    -- Operate screen
    , ((modm,                  xK_n), PS.onNextNeighbour def W.view)
    , ((modm .|. shiftMask,    xK_n), PS.onNextNeighbour def W.shift)
    , ((modm,                  xK_p), PS.onPrevNeighbour def W.view)
    , ((modm .|. shiftMask,    xK_p), PS.onPrevNeighbour def W.shift)
    -- Toggle float and FullScreen
    , ((modm,                  xK_space), O.sendMessage $ TL.Toggle MTI.NBFULL)
    , ((modm,                  xK_f), O.sendMessage $ TL.Toggle MTI.NBFULL)
    , ((modm .|. shiftMask,    xK_f), O.withFocused $ ToggleFloat)
    -- Exit and Reload
    , ((modm .|. controlMask,  xK_e), io exitSuccess)
    , ((modm .|. controlMask,  xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    -- Launch rofi
    , ((modm,                  xK_m), spawn "rofi -combi-modi window,drun -show combi")
    , ((modm .|. shiftMask,    xK_m), spawn "rofi -show run")
    , ((modm .|. controlMask,  xK_m), spawn "rofi -show mower-menu -modi mower-menu:rofi-mower-menu")
    -- Lock screen
    , ((modm .|. controlMask,  xK_b), spawn "i3lock -n -t -i " ++ P.screenSaver)
    -- Screenshot
    , ((modm,                  xK_Print), spawn "flameshot full -p " ++ P.capturePath)
    , ((modm .|. shiftMask,    xK_Print), spawn "flameshot screen -c")
    , ((modm .|. controlMask,  xK_Print), spawn "flameshot screen -p " ++ P.capturePath)
    -- Show copyq and calculator
    , ((modm,                  xK_s), spawn "copyq toggle")
    , ((modm .|. shiftMask,    xK_s), spawn "rofi -show calc -modi calc -no-show-match -no-sort")
]

functionMap = [
      ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ("<XF86AudioPlay>", spawn "playerctl play-play")
    , ("<XF86AudioPause>", spawn "playerctl play-pause")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    , ("<XF86MonBrightnessUp>", spawn "light -A 5")
    , ("<XF86MonBrightnessDown>", spawn "light -U 5")
    , ("<XF86KbdBrightnessUp>", spawn "light -Ars 'sysfs/leds/asus::kbd_backlight' 1")
    , ("<XF86KbdBrightnessDown>", spawn "light -Urs 'sysfs/leds/asus::kbd_backlight' 1")
    , ("<XF86Launch1>", spawn "sh -c "/home/sumi/bin/swich_gpu_mode")
    , ("<XF86Launch4>", spawn "asusctl profile -n")
]
