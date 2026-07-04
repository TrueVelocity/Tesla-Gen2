# Tesla / UI library

## How to use
You can execute our [example script](https://raw.githubusercontent.com/TrueVelocity/Tesla-Gen2/refs/heads/main/example.luau).
### or..
you can just scroll down to the elements with their instructions.


<details>
<summary>Q & A</summary>

## Read some Q & A.


<details>
<summary>Is it free?</summary>
  
YES, ITS FREE!

</details>

<details>
<summary>Why does it exist?</summary>

well... i don't really know.

</details>
</details>

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
