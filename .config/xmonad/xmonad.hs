import XMonad
import XMonad.Config.Desktop (desktopConfig, desktopLayoutModifiers)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Layout.NoBorders (smartBorders, withBorder)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (hPutStrLn, spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import GHC.IO.Handle (Handle)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myKeys conf@(XConfig { modMask = modm }) =
    M.fromList $ [
        ((modm, xK_Return),             scratchpad "term"),
        ((modm, xK_d),                  spawn "rofi -show combi"),
        ((modm, xK_n),                  spawn "networkmanager_dmenu"),
        ((modm, xK_p),                  spawn "flameshot gui"),
        ((modm, xK_q),                  spawn "~/.config/rofi/powermenu"),
        ((modm .|. shiftMask, xK_q),    kill),
        ((modm .|. shiftMask, xK_r),    spawn "xmonad --restart"),
        ((0, xF86XK_AudioMute),         mute),
        ((0, xF86XK_AudioLowerVolume),  lower),
        ((0, xF86XK_AudioRaiseVolume),  raise),
        ((0, xF86XK_MonBrightnessDown), spawn "xbacklight - 10 &"),
        ((0, xF86XK_MonBrightnessUp),   spawn "xbacklight + 10 &")
    ] ++ [
        ((mod .|. modm, num), fn ws) |
            (ws, num) <- zip (workspaces conf) [xK_1 .. xK_9],
            (mod, fn) <- [(0, switchWorkspace), (shiftMask, moveToWorkspace)]
    ]
      where
        mute       = spawn "amixer -D pulse sset Master toggle &"
        lower      = spawn "amixer -D pulse sset Master 5%-"
        raise      = spawn "amixer -D pulse sset Master 5%+"
        scratchpad = namedScratchpadAction scratchpads
        switchWorkspace workspace =
            windows $ W.greedyView workspace
        moveToWorkspace workspace =
            (windows $ W.shift workspace) >> (windows $ W.greedyView workspace)

myLayoutHook =
    tiled ||| full
      where
        tiled   = smartBorders $ Tall nmaster delta ratio
        full    = withBorder 1 Full
        nmaster = 1
        ratio   = 1 / 2
        delta   = 3 / 100

scratchpads =
    [NS "term" "alacritty --title 'term'" (title =? "term") floating]
      where
        floating = customFloating $ W.RationalRect left top width height
        height   = 0.75
        width    = 0.60
        left     = 0.20
        top      = 0.00

myManageHook =
    composeAll [
        className =? "Slack"             --> doShift "msg",
        className =? "firefox"           --> doShift "web",
        className =? "jetbrains-idea"    --> doShift "txt",
        className =? "jetbrains-toolbox" --> doShift "txt"
    ] <> namedScratchpadManageHook scratchpads

myStartupHook = do
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    spawnOnce "xsetroot -solid '#282828'"
    spawnOnce "xfce4-power-manager"
    spawnOnce "xset s 300 5"
    spawnOnce "xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock"
    spawnOnce "setxkbmap -option ctrl:nocaps; xcape"

buildXmobarPP :: Handle -> PP
buildXmobarPP xmobarProcess =
    xmobarPP {
        ppOutput          = hPutStrLn xmobarProcess,
        ppCurrent         = xmobarColor "#d79921" "",
        ppHidden          = xmobarColor "#a89984" "",
        ppHiddenNoWindows = xmobarColor "#504945" "",
        ppUrgent          = xmobarColor "#cc241d" "",
        ppTitle           = xmobarColor "#a89984" "" . shorten 100
    }

main = do
    xmobarProcess <- spawnPipe "xmobar -d"
    xmonad desktopConfig {
        clickJustFocuses   = False,
        focusFollowsMouse  = False,
        modMask            = mod4Mask,
        focusedBorderColor = "#a89984",
        normalBorderColor  = "#282828",
        terminal           = "alacritty",
        workspaces         = ["msg", "web", "txt", "a", "b", "c"],
        startupHook        = startupHooks,
        layoutHook         = layoutHooks,
        logHook            = dynamicLogWithPP $ buildXmobarPP(xmobarProcess),
        manageHook         = manageHooks,
        handleEventHook    = eventHooks,
        keys               = allKeys
    }
      where
        startupHooks = myStartupHook <> startupHook desktopConfig
        layoutHooks  = desktopLayoutModifiers myLayoutHook
        manageHooks  = myManageHook <> manageHook desktopConfig
        eventHooks   = fullscreenEventHook <> handleEventHook desktopConfig
        allKeys      = \c -> myKeys c `M.union` keys def c
