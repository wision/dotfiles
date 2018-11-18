import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed	-- tabbed layout
import XMonad.Layout.ShowWName	-- shows workspace name
import XMonad.Layout.Grid -- shows workspace name
import XMonad.Actions.CycleWS
import XMonad.Actions.SwapWorkspaces
import Graphics.X11.ExtraTypes.XF86

--import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.SetWMName
--import DBus.Client.Simple
--mport System.Taffybar.XMonadLog (dbusLogWithPP, taffybarPP)
import System.IO
import System.Exit
import System.Process

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Util.Run(spawnPipe)

myTerminal      = "uxterm"
myBorderWidth   = 1
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces    = ["1","2","3","4","5","6","7","8","9","10"]

-- Border colors for unfocused and focused windows, respectively.
--
--myNormalBorderColor  = "#bd96bd"
--myFocusedBorderColor = "#ff208c"
myNormalBorderColor  = "#111"
myFocusedBorderColor = "#555"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask  , xK_Return ), spawn $ XMonad.terminal conf)			  -- launch a terminal
--    , ((modMask                , xK_p      ), spawn "gmrun")					  -- launch gmrun
    , ((modMask                , xK_F2     ), spawn "exe=`dmenu_run`  && eval \"exec $exe\"")	  -- launch dmenu
    , ((modMask .|. shiftMask  , xK_c      ), kill)						  -- Close focused window 
    , ((modMask                , xK_space  ), sendMessage NextLayout)				  -- Rotate through the available layout algorithms
    , ((modMask .|. shiftMask  , xK_space  ), setLayout $ XMonad.layoutHook conf)		  -- Reset the layouts on the current workspace to default
    , ((modMask                , xK_n      ), refresh)						  -- Resize viewed windows to the correct size
    , ((modMask                , xK_Tab    ), windows W.focusDown)				  -- Move focus to the next window
    , ((modMask                , xK_j      ), windows W.focusDown)				  -- Move focus to the next window
    , ((modMask                , xK_k      ), windows W.focusUp)				  -- Move focus to the previous window
    , ((modMask .|. shiftMask  , xK_Tab    ), windows W.focusUp)				  -- Move focus to the previous window
    , ((modMask                , xK_m      ), windows W.focusMaster)				  -- Move focus to the master window
    , ((modMask                , xK_Return ), windows W.swapMaster)				  -- Swap the focused window and the master window
    , ((modMask .|. shiftMask  , xK_j      ), windows W.swapDown)				  -- Swap the focused window with the next window
    , ((modMask .|. shiftMask  , xK_k      ), windows W.swapUp)					  -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask  , xK_Right  ), windows W.swapDown)				  -- Swap the focused window with the next window
    , ((modMask .|. shiftMask  , xK_Left   ), windows W.swapUp)					  -- Swap the focused window with the previous window
    , ((modMask                , xK_h      ), sendMessage Shrink)				  -- Shrink the master area
    , ((modMask                , xK_l      ), sendMessage Expand)				  -- Expand the master area
    , ((modMask                , xK_t      ), withFocused $ windows . W.sink)			  -- Push window back into tiling
--    , ((modMask                , xK_comma  ), sendMessage (IncMasterN 1))			  -- Increment the number of windows in the master area
--    , ((modMask                , xK_period ), sendMessage (IncMasterN (-1)))			  -- Deincrement the number of windows in the master area
    , ((modMask                , xK_q      ), restart "xmonad" True)                              -- XMonad restart
    , ((modMask                , xK_Left   ), prevWS)                              -- switch to previous workspace
    , ((modMask                , xK_Right  ), nextWS)                              -- switch to next workspace
--    , ((modMask .|. shiftMask  , xK_q      ), io (exitWith ExitSuccess))                          -- XMonad quit
    , ((0                      , xF86XK_AudioMute        ), spawn "pactl set-sink-mute 2 toggle")     -- mute volume
    , ((0                      , xF86XK_AudioLowerVolume ), spawn "pactl set-sink-volume 2 -10%")     -- decrease volume
    , ((0                      , xF86XK_AudioRaiseVolume ), spawn "pactl set-sink-volume 2 +10%")     -- increase volume

    , ((0                      , xF86XK_MonBrightnessDown ), spawn "xbacklight -dec 10")     -- lower brightness
    , ((0                      , xF86XK_MonBrightnessUp   ), spawn "xbacklight -inc 10")     -- higher brightness
    , ((modMask                , xK_x      ), spawn "xscreensaver-command -lock")                 -- lock session with xscreensaver
--    , ((0                      , 0x1008ff2f), spawn "sudo hibernate-ram &> /dev/null")            -- hibernate
--    , ((modMask                , xK_w      ), spawn "wpa_cli scan reassociate")                   -- scan for wi-fi networks and reassociate
    , ((modMask .|. shiftMask  , xK_v      ), spawn "pavucontrol-qt &> /dev/null")                   -- run pavucontrol
    , ((modMask                , xK_Print  ), spawn "scrot -q 100 /tmp/screen_%Y-%m-%d.png -d 1") -- Take screenshot
    -- Audio control: lower,raise,mute
--    , ((0                      , 0x1008FF11), spawn "pacmd dump|awk --non-decimal-data '$1~/set-sink-volume/{system (\"pacmd \"$1\" \"$2\" \"$3-1000)}'")
--    , ((0                      , 0x1008FF13), spawn "pacmd dump|awk --non-decimal-data '$1~/set-sink-volume/{system (\"pacmd \"$1\" \"$2\" \"$3+1000)}'")
--    , ((0                      , 0x1008FF12), spawn "pacmd dump|awk --non-decimal-data '$1~/set-sink-mute/{system (\"pacmd \"$1\" \"$2\" \"($3==\"yes\"?\"no\":\"yes\"))}'")
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++

    [((controlMask .|. modMask, k), windows $ swapWithCurrent i)
        | (i, k) <- zip myWorkspaces [xK_1 ..]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))	-- mod-button1, Set the window to floating mode and move by dragging
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))	-- mod-button2, Raise the window to the top of the stack
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))	-- mod-button3, Set the window to floating mode and resize by dragging
    ]

------------------------------------------------------------------------
-- Layouts:
myLayout = Mirror tiled ||| tiled ||| smartBorders Full ||| simpleTabbed ||| Grid
  where
     tiled	= Tall nmaster delta ratio	-- default tiling algorithm partitions the screen into two panes
     nmaster	= 1				-- The default number of windows in the master pane
     ratio	= 3/4				-- Default proportion of screen occupied by master pane
     delta	= 25/1000			-- Percent of screen to increment by when resizing panes

------------------------------------------------------------------------
-- Window rules:
myManageHook = composeAll
    [ className =? "MPlayer"			--> doFloat	-- Mplayer
    , title     =? "Firefox Preferences"	--> doFloat	-- Firefox Preferences
    , title     =? "Firefox Add-on Updates"	--> doFloat	-- Firefox Add-ons
    , title     =? "Clear Private Data"		--> doFloat	-- Firefox Clear private data
    , title     =? "Certificate Manager"	--> doFloat	-- Firefox Certificate manager
    , className =? "Gimp"			--> doFloat	-- Gimp
    , className =? "serverpropertiesdialog"	--> doFloat	-- Opera Site Preferences
    , className =? "ApacheDirectoryStudio"	--> doFloat	-- Apache Directory Studio splash
	, className =? "jetbrains-idea-ce"	--> doFloat
    , resource  =? "desktop_window"		--> doIgnore
    , resource  =? "kdesktop"			--> doIgnore 
    , className =? "opera"			--> doShift "1"  -- Start opera at 1st desktop
	]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

------------------------------------------------------------------------
-- Status bars and logging
myLogHook = dynamicLogWithPP $ xmobarPP { 
               ppTitle = xmobarColor "blue" "" . shorten 350,
               ppHiddenNoWindows = xmobarColor "grey" "" 
             }
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.

--myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
-- main = xmonad defaults
-- myBar = "xmobar"
main = xmonad =<< xmobar defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
defaults = defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
        layoutHook         = showWName myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook,
        startupHook        = setWMName "LG3D"
    }
