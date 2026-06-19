--!strict
-- Apple UI - Gen2 Example LocalScript

-- Load the library
local library = loadstring(game:HttpGet("YOUR_LIBRARY_URL_HERE"))()

-- Create the main window
local window = library:init("My Apple UI", true, Enum.KeyCode.RightShift, true)

-- Add a divider to the sidebar
window:Divider("Main Section")

-- Create a section
local section = window:Section("Demo Elements")

-- Add a label
section:Label({
    Text = "Welcome to Apple UI - Gen2!"
})

-- Add a button
section:Button({
    Text = "Click Me",
    Callback = function()
        print("Button clicked!")
        window:TempNotify("Clicked!", "You pressed the button.", "rbxassetid://12608259004")
    end
})

-- Add a switch
section:Switch({
    Text = "Enable Feature",
    State = false,
    Callback = function(state)
        print("Switch state:", state)
    end
})

-- Add a textbox
section:Textbox({
    Text = "Your Name",
    Placeholder = "Type here...",
    Callback = function(text)
        print("You typed:", text)
    end
})

-- Add a slider
section:Slider({
    Text = "Volume",
    Min = 0,
    Max = 100,
    Value = 50,
    Callback = function(value)
        print("Volume set to:", value)
    end
})

-- Add a dropdown
section:Dropdown({
    Text = "Choose Fruit",
    List = {"Apple", "Banana", "Grape"},
    Callback = function(choice)
        print("Selected:", choice)
    end
})

-- Add a multi dropdown
section:MultiDropdown({
    Text = "Select Perks",
    List = {"Speed", "Strength", "Luck"},
    Selected = {"Speed"},
    Callback = function(values)
        print("Selected perks:", table.concat(values, ", "))
    end
})

-- Add a color picker
section:Colorpicker({
    Text = "Pick a Color",
    Color = Color3.fromRGB(255, 100, 100),
    Callback = function(color)
        print("Color picked:", color)
    end
})

-- Select the section by default
section:Select()

-- Add a green button callback
window:GreenButton(function()
    print("Green button clicked!")
end)

-- Add a second section for notifications
local notifSection = window:Section("Notifications")

notifSection:Button({
    Text = "Show Notification",
    Callback = function()
        window:Notify("Hello!", "This is a test notification.", "OK", "rbxassetid://12608259004", function()
            print("Notification button clicked!")
        end)
    end
})

notifSection:Button({
    Text = "Show Dual Notification",
    Callback = function()
        window:Notify2(
            "Choose",
            "Pick an option below.",
            "Yes",
            "No",
            "rbxassetid://12608259004",
            function() print("Yes clicked!") end,
            function() print("No clicked!") end
        )
    end
})
