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
add "**do**" for every page you want to edit and dont forget to add the Subpages! or it would crash.

## Instructions/ Elements
