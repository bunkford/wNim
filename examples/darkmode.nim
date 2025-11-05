#====================================================================
#
#               wNim - Nim's Windows GUI Framework
#                Copyright (c) Chen Kai-Hung, Ward
#
#====================================================================

## This example demonstrates Windows 10 dark mode support in wNim.
## Dark mode will automatically be enabled if the system is using dark theme.

import wNim

let app = App(wSystemDpiAware)
let frame = Frame(title="wNim Dark Mode Demo", size=(400, 300))

# Check if dark mode is supported
if app.isDarkModeSupported():
  echo "Dark mode is supported on this system"
  if app.isDarkModeEnabled():
    echo "Dark mode is currently enabled"
  else:
    echo "Dark mode is currently disabled (light theme)"
else:
  echo "Dark mode is not supported (requires Windows 10 build 17763+)"

# Create some controls to show in the window
let panel = Panel(frame)
let staticText1 = StaticText(panel, 
  label="This window demonstrates dark mode support.",
  pos=(20, 20))
let staticText2 = StaticText(panel, 
  label="The title bar should use dark theme if enabled in Windows settings.",
  pos=(20, 50))
let staticText3 = StaticText(panel,
  label="Change your Windows theme and the title bar will update automatically.",
  pos=(20, 80))

let button = Button(panel, label="Toggle Dark Mode Manually", pos=(20, 120))

var darkModeEnabled = true

# Button to manually toggle dark mode for this window
button.wEvent_Button do ():
  darkModeEnabled = not darkModeEnabled
  frame.enableDarkMode(darkModeEnabled)
  echo "Dark mode ", if darkModeEnabled: "enabled" else: "disabled"

frame.center()
frame.show()
app.mainLoop()
