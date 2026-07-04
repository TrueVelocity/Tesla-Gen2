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

## instructions
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
