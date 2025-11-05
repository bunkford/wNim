# Dark Mode Support in wNim

wNim now supports Windows 10 dark mode for window title bars. This feature automatically detects and applies the user's system theme preference.

## Requirements

- Windows 10 build 17763 (version 1809) or later
- No additional dependencies required

## Features

- Automatic detection of system dark mode preference
- Dark title bars for wFrame windows when dark mode is enabled
- Automatic updates when the system theme changes
- Manual control over dark mode for individual windows

## Usage

### Automatic Dark Mode

wNim now **automatically** applies dark mode to both title bars and client area controls when the system is using dark theme:

```nim
import wNim

let app = App()
let frame = Frame(title="Dark Mode Window", size=(400, 300))
let panel = Panel(frame)
let button = Button(panel, label="Click Me", pos=(20, 20))
let textCtrl = TextCtrl(panel, pos=(20, 60))

# All controls automatically use appropriate colors based on system theme!
# No manual color configuration needed.

frame.show()
app.mainLoop()
```

**How it works:**
- When controls are created, they automatically receive dark or light colors based on the current system theme
- When the system theme changes (light ↔ dark), all controls automatically update via `WM_SETTINGCHANGE` messages
- Both the title bar and client area controls are themed automatically

### Check Dark Mode Support

You can check if dark mode is supported on the current system:

```nim
if app.isDarkModeSupported():
  echo "Dark mode is supported"
else:
  echo "Dark mode requires Windows 10 build 17763 or later"
```

### Check Current Theme

You can check if the user has enabled dark mode:

```nim
if app.isDarkModeEnabled():
  echo "System is using dark theme"
else:
  echo "System is using light theme"
```

### Manual Control

You can manually enable or disable dark mode for individual windows:

```nim
# Enable dark mode
frame.enableDarkMode(true)

# Disable dark mode (force light title bar)
frame.enableDarkMode(false)
```

### Refresh After Theme Changes

The title bar and client area controls automatically update when the system theme changes via WM_SETTINGCHANGE messages. However, you can also manually refresh the theme:

```nim
# Manually refresh title bar
frame.refreshDarkMode()

# Manually refresh all controls (recursively updates all child windows)
frame.updateThemeColorsRecursive()
```

## Custom Colors

If you want to override the automatic theming and use custom colors, simply set the `backgroundColor` and `foregroundColor` properties:

```nim
# Custom colors - these will NOT be changed by automatic theme updates
panel.backgroundColor = 0xFF0000  # Red background
panel.foregroundColor = 0x00FF00  # Green text

# The framework will preserve your custom colors when the theme changes
```

**Note:** Once you set custom colors, the automatic theme updates will not override them. The framework only updates controls that are using the default theme colors.

## Default Dark/Light Color Constants

The framework provides standard color constants that you can use:

```nim
import wNim

# Access dark mode color constants
echo wDarkModeBackground   # 0x202020 - Dark gray
echo wDarkModeForeground   # 0xFFFFFF - White
echo wDarkModeControl      # 0x2D2D2D - Control background

echo wLightModeBackground  # 0xF0F0F0 - Light gray
echo wLightModeForeground  # 0x000000 - Black
echo wLightModeControl     # 0xFFFFFF - White

# Get current appropriate colors based on theme
let bgColor = getDefaultBackgroundColor()
let fgColor = getDefaultForegroundColor()
```

## Example

See `examples/darkmode.nim` for a comprehensive working example that demonstrates:
- Automatic dark mode title bar support
- Automatic theming of client area controls
- Various control types (buttons, checkboxes, text inputs, etc.)
- Manual toggle for demonstration purposes

## Implementation Details

The dark mode support uses undocumented Windows APIs from `uxtheme.dll`. The implementation is based on the [win32-darkmode](https://github.com/komiyamma/win32-darkmode) project.

Key features:
- Detects Windows 10 build number at runtime
- Loads dark mode functions by ordinal from `uxtheme.dll`
- Uses `SetWindowCompositionAttribute` for builds 18362+ (Windows 10 1903+)
- Uses window properties for earlier builds (17763-18361)
- Respects high contrast mode settings
- **Automatically applies theme colors to all controls on creation and theme changes**

## Known Limitations

1. Requires Windows 10 build 17763 or later. Earlier Windows versions are not supported.
2. The implementation uses undocumented APIs that may change in future Windows versions.
3. Some native Windows controls have built-in rendering that may not fully respect custom colors in all cases.
4. Custom colors set by the application are preserved and not overridden by theme changes.

## Contributing

If you find issues or have suggestions for improving dark mode support, please open an issue on GitHub.
