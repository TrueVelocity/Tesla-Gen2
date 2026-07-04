# Tesla / UI library
i want one of those UI library finders to add my library into their UI libraries folder, so people could find my UI everywhere.

[![Eazvy/UILibs](https://img.shields.io/badge/Eazvy-UI%20Libs-green?style=for-the-badge&logo=github)](https://github.com/Eazvy/UILibs/tree/main/Librarys) [![Xyraniz/UI-Libs](https://img.shields.io/badge/Xyraniz-UI%20Libs-blue?style=for-the-badge&logo=github)](https://github.com/Eazvy/UILibs/tree/main/Librarys]) [![GhostDuckyy/UI-Libraries](https://img.shields.io/badge/GhostDuckyy-UI%20Libs-yellow?style=for-the-badge&logo=github)](https://github.com/Eazvy/UILibs/tree/main/Librarys](https://github.com/GhostDuckyy/UI-Libraries))


## How to use
you can execute our [example script](https://raw.githubusercontent.com/TrueVelocity/Tesla-Gen2/refs/heads/main/example.luau).
### or..
you can just scroll down to the elements with their instructions.

## Instructions/ Booting the library
### Booting the library
make a new lua(u) file in VS code or in your executor.
at the top of your file, add this line of code
``` luau
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TrueVelocity/AppleUI-Gen2/refs/heads/main/library.luau"))()
```
thats all! nothing too hard.

### Windows
after you added the Library code, you have to add a function called "do", and inside of that function you add the Window function
``` luau
do -- Example
    local Window = Library:Window({
        Logo = "123748867365417",
        FadeSpeed = 0.15,
        PagePadding = 19,
        --Size = UDim2.new(0, 681, 0, 481)
    })
  -- DO NOT ADD ANY END HERE, THE FUNCTION IS NOT OVER YET!
```
### Tabs/Pages & Subpages
now, because you have the window, we need to add two more elements, **Tabs/Pages** & **Subpages**.
copy this exact function to create **tab**/**Pages**
``` luau
    local Pages = {
        ["One"] = Window:Page({Icon = "109391165290124", Search = true}),
        ["Two"] = Window:Page({Icon = "72974659157165", Search = false}),
        ["_"] = Window:Seperator(),
        ["Three"] = Window:Page({Icon = "109391165290124", Search = true}),
        ["Four"] = Window:Page({Icon = "129960652808688", Search = true}),
        ["__"] = Window:Seperator(),
        ["Five"] = Window:Page({Icon = "112887626955824", Search = true}),
        ["Six"] = Window:Page({Icon = "72974659157165", Search = false}),
        ["Seven"] = Window:Page({Icon = "82402610527668", Search = true}),
        ["Eight"] = Window:Page({Icon = "72974659157165", Search = true}),
        ["Nine"] = Window:Page({Icon = "82402610527668", Search = true}),
    }
```
you can add as much **Tabs/Pages** as you want.

Subpages
``` luau
      do -- EXPLAINING
        local AimbotSubpage = Pages["One"]:SubPage({Name = "Aimbot"})
        local SilentSubpage = Pages["One"]:SubPage({Name = "Silent"})
```
add ```do``` for every page you want to edit and dont forget to add the Subpages! or it would crash.

## Instructions/ Elements
### Sections

Sections are the containers inside your SubPages.They split your UI into Left and Right columns.
```luau
local AimbotSection = AimbotSubpage:Section({
    Name = "Aimbot",
    Side = "Left" -- or "Right"
})
```
### Toggle

A toggle is a simple ON/OFF switch.
```luau
local Toggle = AimbotSection:Toggle({
    Name = "Enable", 
    Flag = "Enable", 
    Default = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})
```
### Toggle Keybind

Attach a keybind directly to a toggle.
```luau
Toggle:Keybind({
    Name = "Keybind",
    Flag = "Keybind",
    Default = Enum.KeyCode.X,
    Mode = "Toggle", -- Toggle / Hold
    Callback = function(Value)
        print("Keybind:", Value)
    end
})
```
### Toggle Colorpicker

Attach a colorpicker to a toggle.
```luau
Toggle:Colorpicker({
    Name = "Colorpicker", 
    Flag = "Colorpicker", 
    Default = Color3.fromRGB(255, 255, 255), 
    Callback = function(Value, Alpha)
        print("Color:", Value, "Alpha:", Alpha)
    end
})
```
### Button

Buttons execute a function when clicked.
```luau
AimbotSection:Button({
    Name = "Button",
    Callback = function()
        print("Button pressed")
    end
})
```
### Button + SubButton

Buttons can have sub-buttons attached.
```luau
AimbotSection:Button({
    Name = "Button",
    Callback = function()
        print("Main Button")
    end
}):SubButton({
    Name = "SubButton",
    Callback = function()
        print("SubButton pressed")
    end
})
```
### Slider

Sliders allow numeric input.
```luau
AimbotSection:Slider({
    Name = "Slider", 
    Flag = "Slider", 
    Min = 0, 
    Default = 0, 
    Max = 100, 
    Suffix = "%", 
    Decimals = 1, 
    Callback = function(Value)
        print("Slider:", Value)
    end
})
```
### Dropdown

A single‑select dropdown.
```luau
AimbotSection:Dropdown({
    Name = "Dropdown", 
    Flag = "Dropdown", 
    Items = { "One", "Two", "Three", "Four" }, 
    Multi = false,
    MaxSize = 50,
    Callback = function(Value)
        print("Dropdown:", Value)
    end
})
```

### Multi Dropdown

A multi‑select dropdown.
```luau
AimbotSection:Dropdown({
    Name = "Multi Dropdown", 
    Flag = "Multi Dropdown", 
    Items = { "One", "Two", "Three", "Four" }, 
    Multi = true,
    MaxSize = 75,
    Callback = function(Value)
        print("Multi Dropdown:", Value)
    end
})
```
### Label

Labels are text elements inside sections.
```luau
local ColorpickerLabel = AimbotSection:Label("Colorpicker", "Left")
```
Labels can also have colorpickers:
```luau
ColorpickerLabel:Colorpicker({ 
    Name = "Colorpicker", 
    Flag = "Colorpicker", 
    Default = Color3.fromRGB(255, 255, 255), 
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end
})
```
### Keybind (Standalone)

A standalone keybind (not attached to a toggle).
```luau
AimbotSection:Keybind({
    Name = "Keybind",
    Flag = "Keybind",
    Default = Enum.KeyCode.C,
    Mode = "Toggle",
    Callback = function(Value)
        print("Keybind:", Value)
    end
})
```
### Textbox

Textboxes allow text input.
```luau
AimbotSection:Textbox({
    Name = "Textbox",
    Flag = "Textbox",
    Placeholder = "Placeholder",
    Default = "Input",
    Callback = function(Value)
        print("Textbox:", Value)
    end
})
```
## Theming System

Our library supports dynamic theming.
```luau
for Index, Value in Library.Theme do
    ThemingSection:Label(Index, "Left"):Colorpicker({
        Name = Index,
        Flag = "Theme" .. Index,
        Default = Value,
        Callback = function(Value)
            Library.Theme[Index] = Value
            Library:ChangeTheme(Index, Value)
        end
    })
end
```
## Config System

### Configs Dropdown
```luau
local ConfigsDropdown = ConfigsSection:Dropdown({
    Name = "Configs", 
    Flag = "ConfigsList", 
    Items = { }, 
    Multi = false,
    MaxSize = 85,
    Callback = function(Value)
        ConfigSelected = Value
    end
})
```
Config Name Textbox
```luau
ConfigsSection:Textbox({
    Name = "Config Name",
    Default = "",
    Flag = "ConfigName",
    Placeholder = "...",
    Callback = function(Value)
        ConfigName = Value
    end
})
```
### Load / Save Config
```luau
ConfigsSection:Button({
    Name = "Load Config",
    Callback = function()
        if ConfigSelected then
            Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))

            Library:Thread(function()
                task.wait(0.1)

                for Index, Value in Library.Theme do 
                    Library.Theme[Index] = Library.Flags["Theme"..Index].Color
                    Library:ChangeTheme(Index, Library.Flags["Theme"..Index].Color)
                end    
            end)

            Library:Notification("Success", "Loaded config " .. ConfigSelected, 5)
        else
            return
        end
    end
}):SubButton({
    Name = "Save Config",
    Callback = function()
        if ConfigName then
            Library:SaveConfig(ConfigSelected)
        else
            return
        end
    end
})
```

### Create / Delete Config
```luau
ConfigsSection:Button({
    Name = "Create Config",
    Callback = function()
        if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
            writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())

            Library:RefreshConfigsList(ConfigsDropdown)
        else
            Library:Notification("Error", "Config already exists", 3)
            return
        end
    end
}):SubButton({
    Name = "Delete Config",
    Callback = function()
        if ConfigSelected then
            Library:DeleteConfig(ConfigSelected)

            Library:RefreshConfigsList(ConfigsDropdown)
        else
            return
        end
    end
})
```
### Refresh Config List
```luau
Library:RefreshConfigsList(ConfigsDropdown)
```
## Notifications
```luau
Library:Notification("Notification test", "Test", 5)
```
## Threads
```luau
Library:Thread(function()
    print("Running in a thread")
end)
```
## Separators
```luau
["_"] = Window:Seperator(),
["__"] = Window:Seperator(),
```
and thats the end.
# Minimal Example
```luau
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TrueVelocity/AppleUI-Gen2/refs/heads/main/library.luau"))()

do
    local Window = Library:Window({
        Logo = "123748867365417",
        FadeSpeed = 0.15,
        PagePadding = 19,
    })

    local Pages = {
        ["Main"] = Window:Page({Icon = "109391165290124", Search = true}),
    }

    do
        local MainSubpage = Pages["Main"]:SubPage({Name = "Main"})

        local Section = MainSubpage:Section({
            Name = "Example",
            Side = "Left"
        })

        Section:Toggle({
            Name = "Enable",
            Flag = "Enable",
            Default = false,
            Callback = function(v)
                print(v)
            end
        })
    end
end
```

# Q & A
<details>
<summary>Open Q & A</summary>

<p><strong>Close Q & A</strong> (scroll up to collapse)</p>

<details>
<summary>Is it free?</summary>
YES, ITS FREE!
</details>

<details>
<summary>Why does it exist?</summary>
<p><strong>well...</strong> i don't really know.</p>
</details>

<details>
  <summary>Am i able to remake this library</summary>
  <p>As an old company once said,<i> For exploiters, <b> by exploiters</b></i></p>
</details>

</details>

<p align="center"><b>Thank you for reading.</b></p>

