import XMonad
import XMonad.Config.Desktop (desktopConfig, desktopLayoutModifiers)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce (spawnOnce)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myKeys conf@(XConfig { XMonad.modMask = modm }) =
    M.fromList $ [
        ((modm, xK_Return),             scratchpad "term"),
        ((modm, xK_d),                  spawn "rofi -show combi"),
        ((modm, xK_n),                  spawn "networkmanager_dmenu"),
        ((modm, xK_p),                  spawn "flameshot gui"),
        ((modm, xK_q),                  spawn "~/.config/rofi/powermenu"),
        ((modm .|. shiftMask, xK_q),    kill),
        ((modm .|. shiftMask, xK_r),    spawn "xmonad --restart"),
        ((0, xF86XK_AudioMute),         spawn "amixer set Master toggle &"),
        ((0, xF86XK_AudioLowerVolume),  spawn "amixer sset Master 5%-"),
        ((0, xF86XK_AudioRaiseVolume),  spawn "amixer sset Master 5%+"),
        ((0, xF86XK_MonBrightnessDown), spawn "xbacklight - 10 &"),
        ((0, xF86XK_MonBrightnessUp),   spawn "xbacklight + 10 &")
    ]
      where
        scratchpad = namedScratchpadAction scratchpads

myLayoutHook =
    smartBorders $ avoidStruts $ tiled ||| Full
      where
        tiled   = Tall nmaster delta ratio
        nmaster = 1
        ratio   = 1 / 2
        delta   = 3 / 100

scratchpads =
    [NS "term" "alacritty --title 'term'" (title =? "term") floating]
      where
        floating = customFloating $ W.RationalRect l t w h
        h = 0.75 -- terminal height
        w = 0.60 -- terminal width
        t = 0.00 -- distance from top edge
        l = 0.20 -- distance from left edge

myManageHook =
    composeAll [
        className =? "Slack"             --> doShift "msg",
        className =? "firefox"           --> doShift "web",
        className =? "jetbrains-idea"    --> doShift "txt",
        className =? "jetbrains-toolbox" --> doShift "txt"
    ] <> namedScratchpadManageHook scratchpads

myStartupHook = do
    spawnOnce "$XDG_CONFIG_HOME/polybar/launch"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    spawnOnce "xsetroot -solid '#282828'"
    spawnOnce "xfce4-power-manager"
    spawnOnce "xset s 300 5"
    spawnOnce "xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock"
    spawnOnce "setxkbmap -option ctrl:nocaps; xcape"

main = do
    xmonad $ desktopConfig {
        terminal           = "alacritty",
        focusFollowsMouse  = False,
        clickJustFocuses   = False,
        focusedBorderColor = "#ebdbb2",
        normalBorderColor  = "#282828",
        modMask            = mod4Mask,
        workspaces         = ["msg", "web", "txt", "a", "b", "c"],
        keys               = allKeys,
        layoutHook         = layoutHooks,
        manageHook         = manageHooks,
        handleEventHook    = eventHooks,
        startupHook        = startupHooks
    }
      where
        allKeys      = \c -> myKeys c `M.union` keys def c
        layoutHooks  = desktopLayoutModifiers $ myLayoutHook
        manageHooks  = myManageHook <> manageHook desktopConfig
        eventHooks   = fullscreenEventHook <> handleEventHook desktopConfig
        startupHooks = myStartupHook <> startupHook desktopConfig
