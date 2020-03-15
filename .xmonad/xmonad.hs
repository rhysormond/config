import XMonad
import XMonad.Config.Desktop (desktopConfig, desktopLayoutModifiers)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Util.SpawnOnce (spawnOnce)
import Graphics.X11.ExtraTypes.XF86
import qualified Data.Map as M

myTerminal          = "alacritty"
myFocusFollowsMouse = False
myClickJustFocuses  = False

myModMask    = mod4Mask
myWorkspaces = ["msg","web","txt","a","b","c"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
        ((mod4Mask, xK_Return),          (spawn myTerminal)),
        ((mod4Mask, xK_d),               (spawn "rofi -show combi")),
        ((mod4Mask, xK_n),               (spawn "networkmanager_dmenu")),
        ((mod4Mask, xK_p),               (spawn "flameshot gui")),
        ((mod4Mask, xK_q),               (spawn "~/.config/rofi/powermenu")),
        ((mod4Mask .|. shiftMask, xK_q), kill),
        ((mod4Mask .|. shiftMask, xK_r), (spawn "xmonad --restart")),
        ((0, xF86XK_AudioMute),          (spawn "amixer set Master toggle &")),
        ((0, xF86XK_AudioLowerVolume),   (spawn "amixer -D pulse sset Master 5%-")),
        ((0, xF86XK_AudioRaiseVolume),   (spawn "amixer -D pulse sset Master 5%+")),
        ((0, xF86XK_MonBrightnessDown),  (spawn "xbacklight - 10 &")),
        ((0, xF86XK_MonBrightnessUp),    (spawn "xbacklight + 10 &"))
    ]

myLayoutHook = smartBorders $ avoidStruts $ tiled ||| Full
    where
        tiled   = Tall nmaster delta ratio
        nmaster = 1
        ratio   = 1/2
        delta   = 3/100

myManageHook = composeAll [
        className =? "Slack"             --> doShift "msg",
        className =? "firefox"           --> doShift "web",
        className =? "jetbrains-idea"    --> doShift "txt",
        className =? "jetbrains-toolbox" --> doShift "txt"
    ]

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
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        focusedBorderColor = "#ebdbb2",
        normalBorderColor  = "#282828",
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        keys               = \c -> myKeys c `M.union` keys XMonad.def c,
        layoutHook         = desktopLayoutModifiers $ myLayoutHook,
        manageHook         = myManageHook <+> manageHook desktopConfig,
        handleEventHook    = fullscreenEventHook <+> handleEventHook desktopConfig,
        startupHook        = myStartupHook <+> startupHook desktopConfig
    }
