import Xmonad.Core (X, ScreenId, WindowSpace)
import XMonad.Actions.CycleWS (WSType, WSIs)
import qualified XMonad.StackSet as W    -- hiding (focusMaster, workspaces)


isOnScreen :: ScreenId -> WindowSpace -> Bool
isOnScreen s ws = s == unmarshallS (W.tag ws)

currentScreen :: X ScreenId
currentScreen = gets (W.screen . W.current . windowset)

spacesOnCurrentScreen :: WSType
spacesOnCurrentScreen = WSIs (isOnScreen <$> currentScreen)
