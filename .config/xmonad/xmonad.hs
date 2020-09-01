import XMonad
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Config.Xfce (xfceConfig)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Layout.NoBorders (noBorders, smartBorders, withBorder)
import XMonad.Layout.NoFrillsDecoration (noFrillsDeco, shrinkText)
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
        ((modm, xK_q),                  spawn "xfce4-session-logout"),
        ((modm .|. shiftMask, xK_q),    kill),
        ((modm .|. shiftMask, xK_r),    spawn "xmonad --restart"),
        ((modm, xK_p),                  spawn "flameshot gui"),
        ((modm, xK_d),                  spawn "rofi -show run"),
        ((modm, xK_space),              sendMessage NextLayout),
        ((modm, xK_j),                  windows W.focusDown),
        ((modm, xK_k),                  windows W.focusUp),
        ((modm .|. shiftMask, xK_j),    windows W.swapDown),
        ((modm .|. shiftMask, xK_k),    windows W.swapUp),
        ((modm, xK_h),                  sendMessage Shrink),
        ((modm, xK_l),                  sendMessage Expand),
        ((modm, xK_t),                  withFocused $ windows . W.sink)
    ] ++ [
        ((mod .|. modm, num), fn ws) |
            (ws, num) <- zip (workspaces conf) [xK_1 .. xK_9],
            (mod, fn) <- [(0, switchWorkspace), (shiftMask, moveToWorkspace)]
    ]
      where
        scratchpad = namedScratchpadAction scratchpads
        switchWorkspace workspace =
            windows $ W.greedyView workspace
        moveToWorkspace workspace =
            (windows $ W.shift workspace) >> (windows $ W.greedyView workspace)

myLayoutHook =
    tiled ||| fullDeco (noBorders Full)
      where
        tiled      = smartBorders $ Tall nmaster delta ratio
        fullDeco l = noFrillsDeco shrinkText def l
        nmaster    = 1
        ratio      = 1 / 2
        delta      = 3 / 100

scratchpads =
    [NS "term" "alacritty --title 'term'" (title =? "term") floating]
      where
        floating = customFloating $ W.RationalRect left top width height
        height   = 0.80
        width    = 0.80
        left     = 0.10
        top      = 0.10

myManageHook =
    composeAll [
        className =? "Slack"             --> doShift "msg",
        className =? "firefox"           --> doShift "web",
        className =? "jetbrains-idea"    --> doShift "txt",
        className =? "jetbrains-toolbox" --> doShift "txt"
    ] <> namedScratchpadManageHook scratchpads

main = do
    xmonad xfceConfig {
        clickJustFocuses   = False,
        focusFollowsMouse  = False,
        modMask            = mod4Mask,
        focusedBorderColor = "#a89984",
        normalBorderColor  = "#282828",
        terminal           = "alacritty",
        workspaces         = ["msg", "web", "txt"],
        startupHook        = startupHooks,
        layoutHook         = layoutHooks,
        manageHook         = manageHooks,
        handleEventHook    = eventHooks,
        keys               = allKeys
    }
      where
        startupHooks = startupHook xfceConfig
        layoutHooks  = desktopLayoutModifiers myLayoutHook
        manageHooks  = myManageHook <> manageHook xfceConfig
        eventHooks   = fullscreenEventHook <> handleEventHook xfceConfig
        allKeys      = \c -> myKeys c `M.union` def c
