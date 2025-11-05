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

By default, wNim automatically enables dark mode for all Frame windows if the system is using dark theme:

```nim
import wNim

let app = App()
let frame = Frame(title="Dark Mode Window", size=(400, 300))

# Dark mode is automatically applied if supported and enabled by the system
frame.show()
app.mainLoop()
```

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

The title bar automatically updates when the system theme changes via WM_SETTINGCHANGE messages. However, you can also manually refresh:

```nim
frame.refreshDarkMode()
```

## Theming the Client Area

While the title bar is automatically themed, the client area controls require manual theming. You can set background and foreground colors for controls to match the dark/light theme:

```nim
# Define color schemes
const
  DarkBackground = 0x202020      # Dark gray background
  DarkForeground = 0xFFFFFF      # White text
  LightBackground = 0xF0F0F0     # Light gray background
  LightForeground = 0x000000     # Black text

proc applyTheme(isDark: bool) =
  let bgColor = if isDark: DarkBackground else: LightBackground
  let fgColor = if isDark: DarkForeground else: LightForeground
  
  # Apply to controls
  panel.backgroundColor = bgColor
  panel.foregroundColor = fgColor
  textCtrl.backgroundColor = bgColor
  textCtrl.foregroundColor = fgColor
  # ... apply to other controls
  
  # Update title bar
  frame.enableDarkMode(isDark)
```

## Example

See `examples/darkmode.nim` for a comprehensive working example that demonstrates:
- Dark mode title bar support
- Manual theming of client area controls
- Various control types (buttons, checkboxes, text inputs, etc.)
- Toggling between dark and light modes

## Implementation Details

The dark mode support uses undocumented Windows APIs from `uxtheme.dll`. The implementation is based on the [win32-darkmode](https://github.com/komiyamma/win32-darkmode) project.

Key features:
- Detects Windows 10 build number at runtime
- Loads dark mode functions by ordinal from `uxtheme.dll`
- Uses `SetWindowCompositionAttribute` for builds 18362+ (Windows 10 1903+)
- Uses window properties for earlier builds (17763-18361)
- Respects high contrast mode settings

## Known Limitations

1. The title bar and window border are automatically themed, but the client area (content) requires manual color application through `backgroundColor` and `foregroundColor` properties.
2. Requires Windows 10 build 17763 or later. Earlier Windows versions are not supported.
3. The implementation uses undocumented APIs that may change in future Windows versions.
4. Some native Windows controls have built-in rendering that may not fully respect custom colors in all cases.

## Contributing

If you find issues or have suggestions for improving dark mode support, please open an issue on GitHub.
