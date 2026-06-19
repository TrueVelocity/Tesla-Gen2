# Apple UI - Gen2
Remember the First Apple UI Library by [mham-z](https://github.com/mham-z)?  
That library was SO GOOD, that I decided to remake it!  
So here it is... **the APPLE UI — GEN2**

---

## Creating Window
The window holds all UI elements except temporary notifications.

```luau
local window = library:init(titleText: string, splash: boolean, showHideKeybind: KeyCode, deletePreviousUI: boolean)
```

(See also: [Creating Window](ca://s?q=Creating_Window))

---

## Notifications

### Temporary Notification
Appears in the top-right corner. No buttons. Deletes automatically.

```luau
window:TempNotify(titleText: string, paragraphText: string, icon: string)
```

### Notification 1
One button, one icon. Appears centered over the window.

```luau
window:Notify(titleText: string, paragraphText: string, button1Text: string, icon: string, callback: function)
```

### Notification 2
Two buttons, one icon. Appears centered over the window.

```luau
window:Notify2(titleText: string, paragraphText: string, button1Text: string, button2Text: string, icon: string, callback1: function, callback2: function)
```

(See also: [Notifications](ca://s?q=Notifications_Documentation))

---

## Sidebar Menus and Dividers

### Section Divider
Simple text label to divide sidebar sections.

```luau
window:Divider(text: string)
```

### Section
Contains elements. Returns a table.

```luau
local section = window:Section(text: string)
```

---

## Section Elements

### Divider
```luau
section:Divider(text: string)
```

### Label
```luau
section:Label({
    Text = "Example text"
})
```

### Button
Executes callback when clicked.

```luau
section:Button({
    Text = "Click me",
    Callback = function()
        print("Clicked")
    end
})
```

### Switch
Toggle switch that passes a boolean to callback.

```luau
section:Switch({
    Text = "Enable feature",
    State = false,
    Callback = function(state)
        print(state)
    end
})
```

### Text Field
Executes callback when focus is lost.

```luau
section:Textbox({
    Text = "Label",
    Placeholder = "Enter text...",
    Callback = function(value)
        print(value)
    end
})
```

### Slider
```luau
section:Slider({
    Text = "Volume",
    Min = 0,
    Max = 100,
    Value = 50,
    Callback = function(v)
        print(v)
    end
})
```

### Dropdown
```luau
section:Dropdown({
    Text = "Select option",
    List = {"A", "B", "C"},
    Callback = function(choice)
        print(choice)
    end
})
```

### Multi Dropdown
```luau
section:MultiDropdown({
    Text = "Select multiple",
    List = {"A", "B", "C"},
    Selected = {"A"},
    Callback = function(values)
        print(values)
    end
})
```

### Searchable Dropdown
```luau
section:SearchDropdown({
    Text = "Search items",
    List = {"Apple", "Banana", "Cherry"},
    Callback = function(choice)
        print(choice)
    end
})
```

### Color Picker
```luau
section:Colorpicker({
    Text = "Pick a color",
    Color = Color3.fromRGB(255, 100, 100),
    Callback = function(c)
        print(c)
    end
})
```

(See also: [Section Elements](ca://s?q=Section_Elements))

---

## Miscellaneous

### Toggle Visibility
```luau
window:ToggleVisible()
```

### Green Button
Sets callback for the green traffic-light button.

```luau
window:GreenButton(function()
    print("Green button clicked")
end)
```

### Spotlight Search
```luau
window:EnableSpotlight(Enum.KeyCode.F)
window.Spotlight:Toggle()
```

### Context Menu
```luau
window:ContextMenu({
    {Text = "Copy", Icon = "copy", Callback = function() print("Copy") end},
    {Text = "Delete", Icon = "trash", Callback = function() print("Delete") end}
})
```

### Theme Engine
```luau
window:SetTheme("Dark")
window:ToggleTheme()
```

### Performance Engine
```luau
local obj = window.Perf:Get("TextButton")
window.Perf:Recycle(obj)

if window.Perf:ThrottleKey("search", 0.1) then
    -- throttled logic
end
```

(See also: [Miscellaneous](ca://s?q=Miscellaneous_Features))

---

# Apple UI - Gen2: Images
(Add your own images here)

---

# Contact
For inquiries, contact the developer on Discord.
