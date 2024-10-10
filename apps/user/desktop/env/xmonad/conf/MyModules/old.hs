{-
TODO: IndependentScreensに対応させたワークスペースごとの壁紙の設定
TODO: Polubarへの現在ウィンドウが開かれているワークスペースの通知
-}
{-# LANGUAGE LambdaCase #-}
import Control.Monad
import Data.List
import Data.Ratio
import Data.Default
import Data.Monoid
import Data.Ord
import qualified Data.Map as M
import System.Directory
import System.Posix.Files

import XMonad
import XMonad.Prompt
import XMonad.Prompt.Window

import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import qualified XMonad.Actions.DynamicWorkspaceOrder as DO
-- import XMonad.Actions.MouseResize
import XMonad.Actions.OnScreen
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.WorkspaceNames

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition -- set turn tile
import XMonad.Hooks.PositionStoreHooks
import XMonad.Hooks.WallpaperSetter

import XMonad.Layout.Accordion
import XMonad.Layout.BoringWindows --(boringWindows, focusUp, focusDown, focusMaster)
import XMonad.Layout.Combo
import XMonad.Layout.Decoration
import XMonad.Layout.DragPane
import XMonad.Layout.Drawer
import XMonad.Layout.Hidden
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.SubLayouts
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.StateFull

import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPanePersistent
import XMonad.Layout.WindowNavigation

import XMonad.Util.EZConfig
-- import XMonad.Util.Replace
import XMonad.Util.Run
import XMonad.Util.Run (spawnPipe) 
import XMonad.Util.WindowProperties

import qualified XMonad.StackSet as W --hiding (focusMaster, workspaces)


-- Color schemes (like Adapta-Nokto)
bgBase = "#222d32"
fgBase = "#475359"
black = "#01060e"
red = "#ff5252"
green = "#4db69f"
yellow = "#c9bc0E"
blue = "#008fc2"
magenta = "#cf00ac"
cyan = "#02adc7"
white = "#cfd8dc"

bblack = "#475359"
bred = "#ff4f4d"
bgreen = "#56d6ba"
byellow = "#c9c30e"
bblue = "#c9c30e"
bmagenta = "#9c0082"
bcyan = "#02b7c7"
bwhite = "#a7b0b5"

{-
spacingRaw:: smartSpace screenSpaceBorder screenSpaceBool windowSpaceBorder windowSpaceBool
border = screenSpaceBorder(top bottom right left) + windowSpaceBorder
smartSpace ==> no Border when there fewer than 2 windows.
-}
-- gaps (for screen)
sGapsT = 3
sGapsB = 2
sGapsR = 10
sGapsL = 10

-- gaps (for window)
wGapsT = 4
wGapsB = 4
wGapsR = 10
wGapsL = 10

borderSize = 2

myWorkspaces = ["1:Code", "2:Browse", "3:Paper", "4:Full", "5:SNS", "6:Media"]


myWallpaperDir :: IO FilePath
myWallpaperDir = (++ "/Pictures/wallpapers/") <$> getHomeDirectory

myWallpaper :: FilePath
myWallpaper = "main.jpg"

spWallpapers :: [FilePath]
spWallpapers = map (++ ".jpg") myWorkspaces

getWallpaper :: FilePath -> IO Wallpaper
getWallpaper spwPath = do
      (doesFileExist <$> (++ spwPath) =<< myWallpaperDir) >>= \case
         True  -> return $ WallpaperFix spwPath
         False -> return $ WallpaperFix myWallpaper

setWallpaper :: X ()
setWallpaper = do
    nScreens <- countScreens
    wp  <- io $ traverse getWallpaper spWallpapers
    wallpaperDir <- io $ myWallpaperDir
    let wallpapers' = concat $ map (\(x,y) -> [x,y]) (zip wp wp)
        ws = withScreens nScreens myWorkspaces
        wplist = WallpaperList $ zip ws wallpapers'
        wpconf = (WallpaperConf wallpaperDir) wplist
    wallpaperSetter wpconf

capturePath = "~/Pictures/screenshot/"

-- myWsBar = "xmobar $HOME/.xmonad/.xmobarrc"

myFont s = "xft:Ricty Diminished:size=" ++ show s ++":antialias=true"

myTabTheme = def 
           { activeColor = fgBase
           , inactiveColor = bgBase
           , urgentColor = byellow
           , activeBorderColor = bcyan
           , inactiveBorderColor = cyan
           , urgentBorderColor = magenta
           , activeTextColor = green
           , inactiveTextColor = bgreen
           , urgentTextColor = bgreen
           , fontName = myFont 10
           }

myShowWNameTheme = def
    { swn_font              = myFont 36
    , swn_fade              = 0.6
    , swn_bgcolor           = bgBase
    , swn_color             = green
    }

myXPConfig = def
            { font              = myFont 24
            , fgColor           = green
            , bgColor           = bgBase
            , borderColor       = cyan
            , height            = 80
            , promptBorderWidth = 0
            , autoComplete      = Just 500000
            , bgHLight          = bblack
            , fgHLight          = bcyan
            , position          = CenteredAt 0.3 0.5
            }

toggleFloat x w = windows (\s -> if M.member w (W.floating s) then W.sink w s
                                 else
                                     if x == R then (W.float w (W.RationalRect 0.5 0.015 0.5 1.0) s)
                                     else (W.float w (W.RationalRect 0.0 0.015 0.5 1.0) s))

isOnScreen :: ScreenId -> WindowSpace -> Bool
isOnScreen s ws = s == unmarshallS (W.tag ws)

currentScreen :: X ScreenId
currentScreen = gets (W.screen . W.current . windowset)

spacesOnCurrentScreen :: WSType
spacesOnCurrentScreen = WSIs (isOnScreen <$> currentScreen)

main :: IO ()
main = do 
    nScreens <- countScreens
--    replace
    xmonad $ ewmh def
        { borderWidth = borderSize
        , workspaces = withScreens nScreens myWorkspaces -- デュアルモニターでの使用
        , layoutHook = showWName' myShowWNameTheme myLayout
        , terminal = myTerminal
        , normalBorderColor = black
        , focusedBorderColor = blue
        , modMask = modm
        , logHook = myLogHook -- wsLogfile-- wsbar
        , startupHook = myStartupHook
        -- , mouseBindings = myMouseBindings
        , manageHook = insertPosition Above Newer <+> manageDocks <+> myManageHook
        , handleEventHook = fullscreenEventHook <+> docksEventHook <+> ewmhDesktopsEventHook
        , focusFollowsMouse = False
        , clickJustFocuses = True
        }
        `removeKeys` removekeys'
        `additionalKeys` keys'
        `additionalKeysP` keysP'

myStartupHook = do
    -- spawn "feh --bg-scale ~/Pictures/wallpapers/main.jpg"
    -- spawn "bash .config/polybar/launch.sh"
    spawn "nm-applet"
    spawn "blueman-applet"

myLogHook = do
    ewmhDesktopsLogHook
    setWallpaper
    -- io . appendFile h . (++ "\n") =<< getWsLog
    -- eventLogHook
    {-
    dynamicLogWithPP xmobarPP 
                        { ppOutput = hPutStrLn h
                        , ppSort = DO.getSortByOrder
                        }
    -}

myTerminal = "kitty"
-- myTerminal = "alacritty"
modm = mod4Mask
-- sModm = mod4Mask --sub mod mask
myManageHook = composeAll 
    [ 
      className =? "Code"                                       --> doShift (marshall 0 "1:Code")
    , className =? "krita"                                      --> doShift (marshall 0 "4:Full")
    , className =? "Gimp"                                       --> doShift (marshall 0 "4:Full")
    , className =? "Steam"                                      --> doShift (marshall 0 "4:Full")
    , stringProperty "WM_CLIENT_MACHINE" =? "steam"             --> doShift (marshall 0 "4:Full")
    , className =? "Slack"                                      --> doShift (marshall 0 "5:SNS")
    , className =? "discord"                                    --> doShift (marshall 0 "5:SNS")
    , className =? "Spotify"                                    --> doShift (marshall 0 "5:SNS")
    -- , stringProperty "WM_WINDOW_ROLE" =? "pop-up"               --> doShift (marshall 0 "5:SNS")
    , className =? "Light-locker-settings.py"                   --> doCenterFloat
    , className =? "Lxappearance"                               --> doCenterFloat
    , className =? "Font-manager"                               --> doCenterFloat
    , stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog" --> doCenterFloat
    , stringProperty "WM_ICON_NAME" =? "Visual Studio Code"     --> doCenterFloat
    , stringProperty "WM_ICON_NAME" =? "Launch Application"     --> doCenterFloat
    , stringProperty "WM_NAME" =? "WaveSurfer 1.8.8p5"          --> doCenterFloat
    , stringProperty "WM_NAME" =? "Hold on..."                  --> doCenterFloat
    ]

spaces = spacingRaw False (Border sGapsT sGapsB sGapsR sGapsL) True (Border wGapsT wGapsB wGapsR wGapsL) True

named w = renamed [(XMonad.Layout.Renamed.Replace w)]

wsLayout l = sideBar `onBottom` l

myLayout = windowNavigation
         $ avoidStruts
         $ lessBorders OnlyScreenFloat 
         $ onWorkspaces ["0_1:Code", "1_1:Code"] (wsLayout tall)
         -- $ onWorkspaces ["0_2:Browse", "1_2:Browse", "0_3:Paper", "1_3:Paper"] (wsLayout twoPane)
         $ onWorkspaces ["0_4:Full", "1_4:Full"] (wsLayout fullWindow ||| floatWindow)
         $ wsLayout twoPane
         -- $ onWorkspaces ["0_5:SNS", "1_5:SNS"] (wsLayout twoPane4SNS)
         -- $ tall

base = addTabs shrinkText myTabTheme
     $ subLayout [] (Simplest)
     $ boringWindows
     $ ResizableTall 1 (5/100) (1/2) [1, 1]

comboTall = named "Media&Coding"
          $ mkToggle (single NBFULL)
          $ hiddenWindows
          $ spaces
          $ combineTwo (Simplest) (base) (tabbed shrinkText myTabTheme)

tall = named "Coding"
     $ mkToggle (single NBFULL)
     $ hiddenWindows
     $ spaces
     $ base

twoPane = named "Browsing"
        $ mkToggle (single NBFULL)
        $ boringWindows
        $ hiddenWindows
        $ spaces
        $ reflectHoriz
        $ combineTwo (TwoPanePersistent Nothing 0.05 0.5) (tabbed shrinkText myTabTheme) (tabbed shrinkText myTabTheme)

fullWindow = named "Full"
           $ hiddenWindows
           $ noBorders StateFull
--data AllFloats = AllFloats deriving (Read, Show)

--instance SetsAmbiguous AllFloats
--    where
--        hiddens _ wset _ _ = M.keys $ W.floating wset

floatWindow = named "Float"
            $ hiddenWindows
            $ noBorders simpleFloat

threeCol = named "SNS"
         $ hiddenWindows
         $ spaces
         $ ThreeColMid 1 (0.05) (4/10)

sideBar = drawer 0.005 0.3 (ClassName "Blueman-manager" `Or` ClassName "Pavucontrol") $ Accordion
                                     
keys' = [ -- forcus keys
          ((modm,                  xK_Tab), windows W.focusUp)
        , ((modm .|. shiftMask,    xK_Tab), windows W.focusDown)
        , ((modm,                  xK_k), focusUp)
        , ((modm,                  xK_j), focusDown)
        , ((modm,                  xK_Return), focusMaster)
        , ((modm,                  xK_h), withFocused hideWindow)
        , ((modm .|. shiftMask,    xK_space), popNewestHiddenWindow) -- pop up latest hidden window
        , ((modm,                  xK_l), onGroup W.focusUp')

        -- swap keys
        , ((modm .|. shiftMask,    xK_k), windows W.swapUp)
        , ((modm .|. shiftMask,    xK_j), windows W.swapDown)
        , ((modm .|. controlMask,  xK_Return), windows W.swapMaster)
        -- tabbed keys
        , ((modm .|. controlMask,  xK_k), sendMessage $ pullGroup U)
        , ((modm .|. controlMask,  xK_j), sendMessage $ pullGroup D)

        , ((modm,                  xK_m), withFocused (sendMessage . MergeAll))
        , ((modm .|. shiftMask,    xK_m), withFocused (sendMessage . UnMergeAll))

        -- move keys (for combo mode)
        , ((modm,                  xK_u), sendMessage $ Move U)
        , ((modm,                  xK_i), sendMessage $ Move D)
        , ((modm,                  xK_y), sendMessage $ Move L)
        , ((modm,                  xK_o), sendMessage $ Move R)

        -- workspace keys
        , ((modm .|. controlMask,    xK_h), moveTo Prev spacesOnCurrentScreen)
        , ((modm .|. controlMask,    xK_l), moveTo Next spacesOnCurrentScreen)
        , ((modm .|. shiftMask,  xK_h), shiftTo Prev spacesOnCurrentScreen >> moveTo  Prev spacesOnCurrentScreen)
        , ((modm .|. shiftMask,  xK_l), shiftTo Next spacesOnCurrentScreen >> moveTo  Next spacesOnCurrentScreen)
        -- ((sModm .|. controlMask, xK_l), nextWS)
        -- apps
        , ((modm,                  xK_p), spawn "env LANG=en_US.UTF-8 rofi -modi combi -show combi -combi-modi window,drun -show-icons")
        , ((modm .|. shiftMask,    xK_p), spawn "rofi -show run")
        , ((0,                     xK_Print), spawn $ "flameshot full -p " ++ capturePath)
        , ((modm,                  xK_Print), spawn $ "flameshot screen -p " ++ capturePath)
        , ((modm .|. shiftMask,    xK_Print), spawn $ "flameshot screen -c ")
        , ((modm,                 xK_b), spawn "i3lock -i /home/sumi/Pictures/archlinux_resize.png -t")

        -- instead function + f1(f7)
        -- , ((modm,                  xK_F1), spawn $ "pactl set-sink-volume @DEFAULT_SINK@ toggle")
        -- , ((modm,                  xK_F7), spawn $ )
        , ((modm,                  xK_space), sendMessage $ Toggle NBFULL)

        -- for float
        --, ((modm,                  xK_Up), withFocused (toggleFloat U))
        , ((modm,                  xK_Right), withFocused (toggleFloat R))
        , ((modm,                  xK_Left), withFocused (toggleFloat L))
		-- Launch openbox
		-- , ((sModm .|. shiftMask,   xK_o), restart "/home/sumi/bin/obtoxmd" True)
        -- dual monitor swicher
        , ((modm,                  xK_n), onNextNeighbour def W.view)
        , ((modm .|. shiftMask,    xK_n), onNextNeighbour def W.shift)
        -- , ((modm,                  xK_p), onPrevNeighbour def W.view)
        -- , ((modm .|. shiftMask,    xK_p), onPrevNeighbour def W.shift)

        , ((modm,                  xK_f), windowPrompt myXPConfig Goto wsWindows)
        , ((modm,                  xK_s), windowPrompt myXPConfig Goto allWindows)
        , ((modm .|. shiftMask,    xK_s), windowPrompt myXPConfig Bring allWindows)

        -- , ((modm, xK_q), restart "xmonad" True)
        ]
        ++
        -- workspace swicher
        [ ((m .|. modm, k), windows $ onCurrentScreen f i)
              | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
              , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
        ]

-- Control PC
keysP' = [ ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
         , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
         , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
         , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
         , ("<XF86AudioPlay>", spawn "playerctl play-pause")
         , ("<XF86AudioNext>", spawn "playerctl next")
         , ("<XF86AudioPrev>", spawn "playerctl previous")
         , ("<XF86MonBrightnessUp>", spawn "light -A 5")
         , ("<XF86MonBrightnessDown>", spawn "light -U 5")
         , ("<XF86KbdBrightnessUp>", spawn "light -Ars 'sysfs/leds/asus::kbd_backlight' 1")
         , ("<XF86KbdBrightnessDown>", spawn "light -Urs 'sysfs/leds/asus::kbd_backlight' 1")
         , ("<XF86Launch1>", spawn "~/scripts/chgraphics.sh")
         , ("<XF86Launch4>", spawn "asusctl profile -n")
         ]

removekeys' = [(m .|. modm, n) | n <- [xK_1 .. xK_9], m <- [0, shiftMask]]
              ++
              [(m .|. modm, n) | n <- [xK_w, xK_e, xK_r], m <- [0, shiftMask]]
              ++
              [ (modm,             xK_slash)
              , (modm,             xK_question)
              , (modm,             xK_comma)
              , (modm,             xK_period)
              , (modm,             xK_b)
              ]


{-
withScreen :: ScreenId -- ^ ID of the target screen.  If such doesn't exist, this operation is NOOP
              -> (WorkspaceId -> WindowSet -> WindowSet)
              -> X ()
withScreen n f = screenWorkspace n >>= flip whenJust (windows . f)
-}