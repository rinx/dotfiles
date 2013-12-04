import XMonad
import XMonad.Config.Desktop

import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Magnifier

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Actions.GridSelect

import qualified Data.Map as M


main = xmonad myConfig

myConfig = desktopConfig 
            { terminal = "urxvt"
            , modMask = mod4Mask 
            , layoutHook = desktopLayoutModifiers $ myLayout
            , borderWidth = 0
            , normalBorderColor = "#333333"
            , focusedBorderColor = "#33ccff"
            , keys = myKeys <+> keys desktopConfig
            , handleEventHook = fullscreenEventHook
            , manageHook = myManageHook <+> manageHook desktopConfig
            }

myLayout = withBorder 1 ( tiled ||| magnifier tiled ||| Grid) ||| Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 5/100

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    , ((modm, xK_g), goToSelected defaultGSConfig)
    , ((modm, xK_b), sendMessage ToggleStruts)
    ]

myManageHook = composeAll
    [ className =? "Xfce4-notifyd" --> doIgnore
    , className =? "Gimp-2.8" --> doFloat ]
    <+> composeOne
        [ isFullscreen -?> doFullFloat ]
