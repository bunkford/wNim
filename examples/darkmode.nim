#====================================================================
#
#               wNim - Nim's Windows GUI Framework
#                Copyright (c) Chen Kai-Hung, Ward
#
#====================================================================

## This example demonstrates comprehensive Windows 10 dark mode support in wNim.
## It shows how to apply dark mode to both the title bar and client area controls.
## Dark mode for the title bar is automatically enabled if the system is using dark theme.

import wNim

# Dark mode color scheme constants
const
  # Dark mode colors
  DarkBackground = 0x202020      # Dark gray background
  DarkForeground = 0xFFFFFF      # White text
  DarkControlBg = 0x2D2D2D       # Slightly lighter gray for controls
  DarkButtonBg = 0x3D3D3D        # Button background
  
  # Light mode colors
  LightBackground = 0xF0F0F0     # Light gray background
  LightForeground = 0x000000     # Black text
  LightControlBg = 0xFFFFFF      # White for controls
  LightButtonBg = 0xE1E1E1       # Light button background

let app = App(wSystemDpiAware)
let frame = Frame(title="wNim Dark Mode Demo - Comprehensive", size=(600, 500))

# Check if dark mode is supported
if app.isDarkModeSupported():
  echo "Dark mode is supported on this system"
  if app.isDarkModeEnabled():
    echo "Dark mode is currently enabled"
  else:
    echo "Dark mode is currently disabled (light theme)"
else:
  echo "Dark mode is not supported (requires Windows 10 build 17763+)"

# Create a scrollable panel for controls
let panel = Panel(frame, style=wBorderSunken)

# Header text
let headerText = StaticText(panel, 
  label="Dark Mode Demo - Comprehensive Controls",
  pos=(20, 10))

# Description
let descText1 = StaticText(panel, 
  label="This example demonstrates dark mode support for various controls.",
  pos=(20, 35))
let descText2 = StaticText(panel, 
  label="The title bar and client area colors change based on the theme.",
  pos=(20, 55))

# Buttons section
let buttonLabel = StaticText(panel, label="Buttons:", pos=(20, 85))
let button1 = Button(panel, label="Standard Button", pos=(20, 105), size=(150, 30))
let button2 = Button(panel, label="Another Button", pos=(180, 105), size=(150, 30))

# Checkbox section
let checkLabel = StaticText(panel, label="Checkboxes:", pos=(20, 150))
let checkbox1 = CheckBox(panel, label="Option 1", pos=(20, 170))
let checkbox2 = CheckBox(panel, label="Option 2", pos=(20, 195))
let checkbox3 = CheckBox(panel, label="Option 3 (checked)", pos=(20, 220))
checkbox3.value = true

# Radio buttons section
let radioLabel = StaticText(panel, label="Radio Buttons:", pos=(180, 150))
let radio1 = RadioButton(panel, label="Choice A", pos=(180, 170))
let radio2 = RadioButton(panel, label="Choice B", pos=(180, 195))
let radio3 = RadioButton(panel, label="Choice C", pos=(180, 220))
radio1.value = true

# Text input section
let textLabel = StaticText(panel, label="Text Input:", pos=(20, 255))
let textCtrl = TextCtrl(panel, value="Type here...", 
  pos=(20, 275), size=(310, 25), style=wBorderSunken)

# ComboBox section
let comboLabel = StaticText(panel, label="Dropdown:", pos=(20, 315))
let comboBox = ComboBox(panel, value="Item 1",
  choices=["Item 1", "Item 2", "Item 3", "Item 4"],
  pos=(20, 335), size=(150, 25), style=wCbReadOnly)

# ListBox section
let listLabel = StaticText(panel, label="List Box:", pos=(180, 315))
let listBox = ListBox(panel, 
  choices=["Entry 1", "Entry 2", "Entry 3", "Entry 4", "Entry 5"],
  pos=(180, 335), size=(150, 80), style=wBorderSunken)

# Slider section
let sliderLabel = StaticText(panel, label="Slider:", pos=(350, 85))
let slider = Slider(panel, value=50, pos=(350, 105), size=(200, 30))

# Gauge section
let gaugeLabel = StaticText(panel, label="Progress Bar:", pos=(350, 150))
let gauge = Gauge(panel, value=70, pos=(350, 170), size=(200, 25))

# Toggle button for dark mode
let toggleButton = Button(panel, label="Toggle Dark/Light Mode", 
  pos=(20, 425), size=(200, 35))

# Status information
let statusText = StaticText(panel, label="", pos=(230, 430))

# Variable to track current mode (initialize based on system settings)
var useDarkMode = app.isDarkModeEnabled()

# Procedure to apply theme colors to all controls
proc applyTheme(isDark: bool) =
  let bgColor = if isDark: DarkBackground else: LightBackground
  let fgColor = if isDark: DarkForeground else: LightForeground
  let controlBg = if isDark: DarkControlBg else: LightControlBg
  
  # Apply to panel
  panel.backgroundColor = bgColor
  panel.foregroundColor = fgColor
  
  # Apply to all static texts
  for control in [headerText, descText1, descText2, buttonLabel, checkLabel, 
                  radioLabel, textLabel, comboLabel, listLabel, sliderLabel, 
                  gaugeLabel, statusText]:
    control.backgroundColor = bgColor
    control.foregroundColor = fgColor
  
  # Apply to checkboxes
  for control in [checkbox1, checkbox2, checkbox3]:
    control.backgroundColor = bgColor
    control.foregroundColor = fgColor
  
  # Apply to radio buttons
  for control in [radio1, radio2, radio3]:
    control.backgroundColor = bgColor
    control.foregroundColor = fgColor
  
  # Apply to text control
  textCtrl.backgroundColor = controlBg
  textCtrl.foregroundColor = fgColor
  
  # Apply to combo box
  comboBox.backgroundColor = controlBg
  comboBox.foregroundColor = fgColor
  
  # Apply to list box
  listBox.backgroundColor = controlBg
  listBox.foregroundColor = fgColor
  
  # Update title bar
  frame.enableDarkMode(isDark)
  
  # Update status
  statusText.label = if isDark: "Mode: Dark" else: "Mode: Light"
  
  echo "Theme applied: ", if isDark: "Dark Mode" else: "Light Mode"

# Toggle button handler
toggleButton.wEvent_Button do ():
  useDarkMode = not useDarkMode
  applyTheme(useDarkMode)

# Button click events for demonstration
button1.wEvent_Button do ():
  echo "Button 1 clicked"
  
button2.wEvent_Button do ():
  echo "Button 2 clicked"

# Checkbox events
checkbox1.wEvent_CheckBox do ():
  echo "Checkbox 1: ", checkbox1.value

checkbox2.wEvent_CheckBox do ():
  echo "Checkbox 2: ", checkbox2.value

checkbox3.wEvent_CheckBox do ():
  echo "Checkbox 3: ", checkbox3.value

# Text control event
textCtrl.wEvent_Text do ():
  echo "Text changed: ", textCtrl.value

# ComboBox event
comboBox.wEvent_ComboBox do ():
  echo "ComboBox selection: ", comboBox.value

# Slider event
slider.wEvent_Slider do ():
  gauge.value = slider.value
  echo "Slider value: ", slider.value

# Apply initial theme based on system settings
applyTheme(useDarkMode)

frame.center()
frame.show()
app.mainLoop()
