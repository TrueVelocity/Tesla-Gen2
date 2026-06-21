--========================================================--
-- AppleUI-Gen3
-- Core, Theme, Root, Utilities
--========================================================--

-- .
local library = {}

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================--
-- THEME
--========================================================--

library.theme = {
    Background = Color3.fromRGB(22, 22, 22),
    Sidebar = Color3.fromRGB(18, 18, 18),
    Accent = Color3.fromRGB(0, 122, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Stroke = Color3.fromRGB(60, 60, 60),
    Corner = 8,
    Font = Enum.Font.GothamSemibold
}

--========================================================--
-- ROOT GUI
--========================================================--

library.Root = Instance.new("ScreenGui")
library.Root.Name = "AppleUI_Gen3"
library.Root.ResetOnSpawn = false
library.Root.ZIndexBehavior = Enum.ZIndexBehavior.Global
library.Root.Parent = PlayerGui

--========================================================--
-- UTILITIES
--========================================================--

function library:New(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    return obj
end

function library:Corner(radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or self.theme.Corner)
    return c
end

function library:Stroke(color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or self.theme.Stroke
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

function library:Tween(obj, time, props, style, dir)
    local info = TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

function library:ApplyShadow(parent, size, transparency)
    size = size or 24
    transparency = transparency or 0.45

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = parent
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = transparency
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.ZIndex = parent.ZIndex - 1
    Shadow.Size = UDim2.new(1, size, 1, size)
    Shadow.Position = UDim2.new(0, -size/2, 0, -size/2)

    return Shadow
end

--========================================================--
-- AppleUI-Gen3
-- Icon System + Base Element API
--========================================================--

-- .
--========================================================--
-- ICONS (Lucide‑style, expandable)
--========================================================--

library.Icons = {
    search = "rbxassetid://3926305904",
    x = "rbxassetid://3926307971",
    check = "rbxassetid://3926305904",
    menu = "rbxassetid://3926307971",
    more = "rbxassetid://3926305904",
    bell = "rbxassetid://3926305904",
    gear = "rbxassetid://3926305904",
}

function library:GetIcon(name)
    return self.Icons[name] or self.Icons.menu
end

--========================================================--
-- ELEMENT API (Base)
--========================================================--

library.ElementAPI = {}

function library.ElementAPI:SetText(obj, text)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        obj.Text = text
    end
end

function library.ElementAPI:SetImage(obj, id)
    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
        obj.Image = id
    end
end

function library.ElementAPI:SetVisible(obj, state)
    obj.Visible = state and true or false
end

function library.ElementAPI:SetColor(obj, color)
    if obj.BackgroundColor3 then
        obj.BackgroundColor3 = color
    end
    if obj.TextColor3 then
        obj.TextColor3 = color
    end
end

function library.ElementAPI:SetStroke(obj, color, thickness)
    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("UIStroke") then
            child.Color = color or child.Color
            child.Thickness = thickness or child.Thickness
            return
        end
    end
    library:Stroke(color, thickness).Parent = obj
end

function library.ElementAPI:SetCorner(obj, radius)
    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("UICorner") then
            child.CornerRadius = UDim.new(0, radius)
            return
        end
    end
    library:Corner(radius).Parent = obj
end

--========================================================--
-- AppleUI-Gen3
-- Window System (Frame, Titlebar, Dragging)
--========================================================--

-- .

library.Windows = {}
library._primaryWindow = nil

function library:CreateWindow(title, icon, width, height)
    title = title or "AppleUI Window"
    width = width or 600
    height = height or 400

    -- MAIN WINDOW FRAME
    local Window = self:New("Frame", {
        Name = title,
        Parent = self.Root,
        BackgroundColor3 = self.theme.Background,
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10
    })

    self:Corner(self.theme.Corner).Parent = Window
    self:Stroke(self.theme.Stroke, 1).Parent = Window
    self:ApplyShadow(Window)

    -- TITLEBAR
    local TitleBar = self:New("Frame", {
        Name = "TitleBar",
        Parent = Window,
        BackgroundColor3 = self.theme.Sidebar,
        Size = UDim2.new(1, 0, 0, 32),
        BorderSizePixel = 0,
        ZIndex = 11
    })

    self:Corner(self.theme.Corner).Parent = TitleBar
    self:Stroke(self.theme.Stroke, 1).Parent = TitleBar

    -- TITLE TEXT
    local TitleLabel = self:New("TextLabel", {
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = self.theme.Font,
        Text = title,
        TextColor3 = self.theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 12
    })

    -- TITLEBAR BUTTONS (Close, Minimize, Green)
    local ButtonHolder = self:New("Frame", {
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 70, 1, 0),
        Position = UDim2.new(1, -80, 0, 0),
        ZIndex = 12
    })

    local function TitleButton(color, offset)
        local b = library:New("TextButton", {
            Parent = ButtonHolder,
            BackgroundColor3 = color,
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(0, offset, 0.5, -8),
            Text = "",
            BorderSizePixel = 0,
            ZIndex = 13
        })
        library:Corner(8).Parent = b
        return b
    end

    local CloseBtn = TitleButton(Color3.fromRGB(255, 95, 86), 0)
    local MinBtn   = TitleButton(Color3.fromRGB(255, 189, 46), 20)
    local GreenBtn = TitleButton(Color3.fromRGB(39, 201, 63), 40)

    -- DRAGGING LOGIC
    local dragging = false
    local dragStart, startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
        end
    end)

    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- WINDOW API
    local api = {}
    api._frame = Window
    api.Keybind = nil

    function api:GetFrame()
        return self._frame
    end

    function api:SetTitle(t)
        TitleLabel.Text = t
    end

    function api:Show()
        self._frame.Visible = true
    end

    function api:Hide()
        self._frame.Visible = false
    end

    function api:Toggle()
        self._frame.Visible = not self._frame.Visible
    end

    -- BUTTON CALLBACKS
    CloseBtn.MouseButton1Click:Connect(function()
        Window.Visible = false
    end)

    MinBtn.MouseButton1Click:Connect(function()
        library:Tween(Window, 0.2, { Size = UDim2.new(0, width, 0, 32) })
    end)

    GreenBtn.MouseButton1Click:Connect(function()
        library:Tween(Window, 0.2, { Size = UDim2.new(0, width, 0, height) })
    end)

    -- REGISTER WINDOW
    table.insert(self.Windows, api)
    if not self._primaryWindow then
        self._primaryWindow = api
    end

    return api
end

--========================================================--
-- AppleUI-Gen3
-- Sidebar + WorkArea System
--========================================================--

-- .

function library:_AttachSidebarAndWorkArea(api, Window)
    -- SIDEBAR
    local Sidebar = self:New("Frame", {
        Parent = Window,
        BackgroundColor3 = self.theme.Sidebar,
        Size = UDim2.new(0, 160, 1, -32),
        Position = UDim2.new(0, 0, 0, 32),
        BorderSizePixel = 0,
        ZIndex = 10
    })
    self:Stroke(self.theme.Stroke, 1).Parent = Sidebar

    local SidebarList = self:New("UIListLayout", {
        Parent = Sidebar,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    })

    -- WORKAREA
    local WorkArea = self:New("Frame", {
        Parent = Window,
        BackgroundColor3 = self.theme.Background,
        Size = UDim2.new(1, -170, 1, -42),
        Position = UDim2.new(0, 170, 0, 38),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10
    })
    self:Stroke(self.theme.Stroke, 1).Parent = WorkArea

    local SectionsContainer = self:New("Folder", {
        Parent = WorkArea,
        Name = "SectionsContainer"
    })

    -- Store references in window API
    api._sidebar = Sidebar
    api._sectionsContainer = SectionsContainer
end

--========================================================--
-- AppleUI-Gen3
-- Section System (CreateSection + Section API)
--========================================================--

-- .

function library:_CreateSectionButton(parent, name)
    local Button = self:New("TextButton", {
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Size = UDim2.new(1, -10, 0, 28),
        Position = UDim2.new(0, 5, 0, 0),
        Font = self.theme.Font,
        Text = name,
        TextColor3 = self.theme.Text,
        TextSize = 14,
        BorderSizePixel = 0,
        ZIndex = 11
    })
    self:Corner(6).Parent = Button
    return Button
end

function library:_CreateSectionFrame(parent)
    local SectionFrame = self:New("Frame", {
        Parent = parent,
        BackgroundColor3 = self.theme.Background,
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 10
    })

    local Layout = self:New("UIListLayout", {
        Parent = SectionFrame,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })

    return SectionFrame
end

function library:_AttachSectionAPI(api, SectionFrame)
    local sectionApi = {}
    sectionApi._frame = SectionFrame

    function sectionApi:GetFrame()
        return self._frame
    end

    function sectionApi:AddDivider(text)
        local Label = library:New("TextLabel", {
            Parent = SectionFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 0, 20),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = text or "",
            TextColor3 = Color3.fromRGB(180, 180, 180),
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 11
        })
        return Label
    end

    function sectionApi:AddLabel(text)
        local Label = library:New("TextLabel", {
            Parent = SectionFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 0, 20),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = text or "",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 11
        })
        return Label
    end

    function sectionApi:AddButton(text, callback)
        local Btn = library:New("TextButton", {
            Parent = SectionFrame,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(1, -10, 0, 28),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = text or "Button",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            BorderSizePixel = 0,
            ZIndex = 11
        })
        library:Corner(6).Parent = Btn

        Btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)

        return Btn
    end

    api._lastSection = sectionApi
    return sectionApi
end

function library:_ShowSection(container, target)
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("Frame") then
            child.Visible = false
        end
    end
    target.Visible = true
end

function library:_AttachCreateSection(api)
    function api:CreateSection(name)
        name = name or "Section"

        local Sidebar = api._sidebar
        local Container = api._sectionsContainer

        local Button = library:_CreateSectionButton(Sidebar, name)
        local SectionFrame = library:_CreateSectionFrame(Container)
        local sectionApi = library:_AttachSectionAPI(api, SectionFrame)

        Button.MouseButton1Click:Connect(function()
            library:_ShowSection(Container, SectionFrame)
        end)

        -- Auto-show first section
        if #Container:GetChildren() == 1 then
            SectionFrame.Visible = true
        end

        return sectionApi
    end
end

-- Attach section creation to all windows
function library:_FinalizeWindow(api)
    self:_AttachCreateSection(api)
end

--========================================================--
-- AppleUI-Gen3
-- Elements: Labels, Buttons, Toggles, Sliders, Inputs
--========================================================--

-- .

function library:_AttachElementAPI(sectionApi, SectionFrame)

    --------------------------------------------------------
    -- LABEL
    --------------------------------------------------------
    function sectionApi:AddLabel(text)
        local Label = library:New("TextLabel", {
            Parent = SectionFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 0, 20),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = text or "",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 11
        })
        return Label
    end

    --------------------------------------------------------
    -- BUTTON
    --------------------------------------------------------
    function sectionApi:AddButton(text, callback)
        local Btn = library:New("TextButton", {
            Parent = SectionFrame,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(1, -10, 0, 28),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = text or "Button",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            BorderSizePixel = 0,
            ZIndex = 11
        })
        library:Corner(6).Parent = Btn

        Btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)

        return Btn
    end

    --------------------------------------------------------
    -- TOGGLE
    --------------------------------------------------------
    function sectionApi:AddToggle(text, default, callback)
        local Holder = library:New("Frame", {
            Parent = SectionFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 0, 28),
            Position = UDim2.new(0, 5, 0, 0),
            ZIndex = 11
        })

        local Label = library:New("TextLabel", {
            Parent = Holder,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Font = library.theme.Font,
            Text = text or "Toggle",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 11
        })

        local ToggleBtn = library:New("TextButton", {
            Parent = Holder,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Size = UDim2.new(0, 32, 0, 18),
            Position = UDim2.new(1, -36, 0.5, -9),
            Text = "",
            BorderSizePixel = 0,
            ZIndex = 11
        })
        library:Corner(9).Parent = ToggleBtn

        local Knob = library:New("Frame", {
            Parent = ToggleBtn,
            BackgroundColor3 = Color3.fromRGB(200, 200, 200),
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(0, 2, 0.5, -7),
            BorderSizePixel = 0,
            ZIndex = 12
        })
        library:Corner(7).Parent = Knob

        local state = default and true or false

        local function refresh()
            if state then
                library:Tween(ToggleBtn, 0.15, { BackgroundColor3 = library.theme.Accent })
                library:Tween(Knob, 0.15, { Position = UDim2.new(1, -16, 0.5, -7) })
            else
                library:Tween(ToggleBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(40, 40, 40) })
                library:Tween(Knob, 0.15, { Position = UDim2.new(0, 2, 0.5, -7) })
            end
        end

        refresh()

        ToggleBtn.MouseButton1Click:Connect(function()
            state = not state
            refresh()
            if callback then callback(state) end
        end)

        return {
            Set = function(_, v)
                state = v and true or false
                refresh()
                if callback then callback(state) end
            end
        }
    end

    --------------------------------------------------------
    -- INPUT
    --------------------------------------------------------
    function sectionApi:AddInput(placeholder, callback)
        local Box = library:New("TextBox", {
            Parent = SectionFrame,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(1, -10, 0, 28),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = "",
            PlaceholderText = placeholder or "",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            BorderSizePixel = 0,
            ZIndex = 11
        })
        library:Corner(6).Parent = Box

        Box.FocusLost:Connect(function(enter)
            if enter and callback then
                callback(Box.Text)
            end
        end)

        return Box
    end

    --------------------------------------------------------
    -- SLIDER
    --------------------------------------------------------
    function sectionApi:AddSlider(text, min, max, default, callback)
        min, max = min or 0, max or 100
        default = default or min

        local Holder = library:New("Frame", {
            Parent = SectionFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 0, 40),
            Position = UDim2.new(0, 5, 0, 0),
            ZIndex = 11
        })

        local Label = library:New("TextLabel", {
            Parent = Holder,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Position = UDim2.new(0, 0, 0, 0),
            Font = library.theme.Font,
            Text = (text or "Slider") .. " (" .. tostring(default) .. ")",
            TextColor3 = library.theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 11
        })

        local Bar = library:New("Frame", {
            Parent = Holder,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Size = UDim2.new(1, 0, 0, 6),
            Position = UDim2.new(0, 0, 0, 24),
            BorderSizePixel = 0,
            ZIndex = 11
        })
        library:Corner(3).Parent = Bar

        local Fill = library:New("Frame", {
            Parent = Bar,
            BackgroundColor3 = library.theme.Accent,
            Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = 12
        })
        library:Corner(3).Parent = Fill

        local draggingSlider = false

        local function setValueFromX(x)
            local rel = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * rel + 0.5)
            Fill.Size = UDim2.new(rel, 0, 1, 0)
            Label.Text = (text or "Slider") .. " (" .. tostring(value) .. ")"
            if callback then callback(value) end
        end

        Bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSlider = true
                setValueFromX(input.Position.X)
            end
        end)

        Bar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSlider = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                setValueFromX(input.Position.X)
            end
        end)

        return {
            Set = function(_, v)
                v = math.clamp(v, min, max)
                local rel = (v - min) / (max - min)
                Fill.Size = UDim2.new(rel, 0, 1, 0)
                Label.Text = (text or "Slider") .. " (" .. tostring(v) .. ")"
                if callback then callback(v) end
            end
        }
    end
end

--========================================================--
-- AppleUI-Gen3
-- Notifications System
--========================================================--

-- .

library.NotificationHolder = library:New("Frame", {
    Parent = library.Root,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 100
})

local function createNotificationBase(height)
    local Frame = library:New("Frame", {
        Parent = library.NotificationHolder,
        BackgroundColor3 = library.theme.Sidebar,
        Size = UDim2.new(0, 280, 0, height),
        Position = UDim2.new(1, 300, 1, -height - 20),
        BorderSizePixel = 0,
        ZIndex = 101
    })

    library:Corner(8).Parent = Frame
    library:Stroke(library.theme.Stroke, 1).Parent = Frame
    library:ApplyShadow(Frame)

    return Frame
end

function library:Notify(title, desc, icon)
    local Frame = createNotificationBase(70)

    local Icon = self:New("ImageLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 10, 0, 10),
        Image = icon or self:GetIcon("more"),
        ZIndex = 102
    })

    local Title = self:New("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -40, 0, 20),
        Position = UDim2.new(0, 36, 0, 6),
        Font = self.theme.Font,
        Text = title or "Notification",
        TextColor3 = self.theme.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 102
    })

    local Desc = self:New("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -40, 0, 20),
        Position = UDim2.new(0, 36, 0, 28),
        Font = self.theme.Font,
        Text = desc or "",
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 102
    })

    -- Slide in
    self:Tween(Frame, 0.2, { Position = UDim2.new(1, -300, 1, -90) })

    -- Auto-hide
    task.delay(4, function()
        self:Tween(Frame, 0.2, { Position = UDim2.new(1, 300, 1, -90) })
        task.wait(0.25)
        Frame:Destroy()
    end)
end

--========================================================--
-- AppleUI-Gen3
-- Spotlight Search System
--========================================================--

-- .

library.Spotlight = {
    Enabled = false,
    Items = {},
    Keybind = Enum.KeyCode.F
}

-- Overlay
local SpotlightOverlay = library:New("Frame", {
    Parent = library.Root,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.4,
    Size = UDim2.new(1, 0, 1, 0),
    Visible = false,
    ZIndex = 90
})

-- Blur effect
local SpotlightBlur = Instance.new("BlurEffect")
SpotlightBlur.Size = 0
SpotlightBlur.Parent = Lighting

-- Search box
local SpotlightBox = library:New("TextBox", {
    Parent = SpotlightOverlay,
    BackgroundColor3 = library.theme.Sidebar,
    Size = UDim2.new(0, 400, 0, 40),
    Position = UDim2.new(0.5, -200, 0.3, 0),
    Font = library.theme.Font,
    Text = "",
    PlaceholderText = "Search...",
    TextColor3 = library.theme.Text,
    TextSize = 16,
    BorderSizePixel = 0,
    ZIndex = 91
})
library:Corner(8).Parent = SpotlightBox
library:Stroke(library.theme.Stroke, 1).Parent = SpotlightBox

-- Results container
local SpotlightResults = library:New("Frame", {
    Parent = SpotlightOverlay,
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 400, 0, 200),
    Position = UDim2.new(0.5, -200, 0.3, 50),
    ZIndex = 91
})

local SpotlightList = library:New("UIListLayout", {
    Parent = SpotlightResults,
    FillDirection = Enum.FillDirection.Vertical,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 4)
})

-- Update results
local function updateSpotlightResults(query)
    for _, child in ipairs(SpotlightResults:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    if query == "" then
        return
    end

    for _, item in ipairs(library.Spotlight.Items) do
        if string.find(string.lower(item.name), string.lower(query)) then
            local Btn = library:New("TextButton", {
                Parent = SpotlightResults,
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                Size = UDim2.new(1, 0, 0, 28),
                Font = library.theme.Font,
                Text = item.name,
                TextColor3 = library.theme.Text,
                TextSize = 14,
                BorderSizePixel = 0,
                ZIndex = 91
            })
            library:Corner(6).Parent = Btn

            Btn.MouseButton1Click:Connect(function()
                library.Spotlight.Enabled = false
                SpotlightOverlay.Visible = false
                library:Tween(SpotlightBlur, 0.2, { Size = 0 })
                item.callback()
            end)
        end
    end
end

SpotlightBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateSpotlightResults(SpotlightBox.Text)
end)

-- Add item to Spotlight
function library.Spotlight:AddItem(name, callback)
    table.insert(self.Items, { name = name, callback = callback })
end

-- Toggle Spotlight
function library.Spotlight:Toggle()
    library.Spotlight.Enabled = not library.Spotlight.Enabled

    if library.Spotlight.Enabled then
        SpotlightOverlay.Visible = true
        SpotlightBox.Text = ""
        updateSpotlightResults("")
        library:Tween(SpotlightBlur, 0.2, { Size = 12 })
    else
        library:Tween(SpotlightBlur, 0.2, { Size = 0 })
        task.wait(0.2)
        SpotlightOverlay.Visible = false
    end
end

--========================================================--
-- AppleUI-Gen3
-- Visibility System (Hide/Show All Windows)
--========================================================--

-- .

library.Visibility = {
    Keybind = Enum.KeyCode.RightControl,
    Hidden = false
}

function library.Visibility:Toggle()
    self.Hidden = not self.Hidden

    for _, win in ipairs(library.Windows) do
        local frame = win:GetFrame()

        if self.Hidden then
            library:Tween(frame, 0.2, {
                Position = UDim2.new(
                    frame.Position.X.Scale,
                    frame.Position.X.Offset,
                    frame.Position.Y.Scale,
                    frame.Position.Y.Offset + 50
                ),
                BackgroundTransparency = 1
            })
        else
            library:Tween(frame, 0.2, {
                Position = UDim2.new(
                    frame.Position.X.Scale,
                    frame.Position.X.Offset,
                    frame.Position.Y.Scale,
                    frame.Position.Y.Offset - 50
                ),
                BackgroundTransparency = 0
            })
        end
    end
end

--========================================================--
-- AppleUI-Gen3
-- Context Menu System
--========================================================--

-- .

library.ContextMenu = {
    Enabled = true,
    Active = false,
    MenuFrame = nil
}

local function closeContextMenu()
    if library.ContextMenu.MenuFrame then
        library:Tween(library.ContextMenu.MenuFrame, 0.15, { BackgroundTransparency = 1 })
        task.wait(0.15)
        library.ContextMenu.MenuFrame:Destroy()
        library.ContextMenu.MenuFrame = nil
    end
    library.ContextMenu.Active = false
end

function library:OpenContextMenu(options, position)
    if not library.ContextMenu.Enabled then
        return
    end

    if library.ContextMenu.Active then
        closeContextMenu()
    end

    library.ContextMenu.Active = true

    local Menu = library:New("Frame", {
        Parent = library.Root,
        BackgroundColor3 = library.theme.Sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 160, 0, (#options * 28) + 10),
        Position = UDim2.new(0, position.X, 0, position.Y),
        BorderSizePixel = 0,
        ZIndex = 95
    })
    library:Corner(6).Parent = Menu
    library:Stroke(library.theme.Stroke, 1).Parent = Menu
    library.ContextMenu.MenuFrame = Menu

    local List = library:New("UIListLayout", {
        Parent = Menu,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    })

    library:Tween(Menu, 0.15, { BackgroundTransparency = 0 })

    for _, opt in ipairs(options) do
        local Btn = library:New("TextButton", {
            Parent = Menu,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(1, -10, 0, 26),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = opt.text,
            TextColor3 = library.theme.Text,
            TextSize = 14,
            BorderSizePixel = 0,
            ZIndex = 96
        })
        library:Corner(4).Parent = Btn

        Btn.MouseButton1Click:Connect(function()
            closeContextMenu()
            if opt.callback then
                opt.callback()
            end
        end)
    end
end

--========================================================--
-- AppleUI-Gen3
-- Preferences Window (UI)
--========================================================--

-- .

library.Preferences = {
    Window = nil,
    Sections = {}
}

function library.Preferences:Open()
    if self.Window then
        self.Window:Show()
        return
    end

    -- Create Preferences window
    local win = library:CreateWindow("Preferences", nil, 520, 360)
    library:_AttachSidebarAndWorkArea(win)
    library:_FinalizeWindow(win)

    self.Window = win

    --------------------------------------------------------
    -- Create sidebar categories
    --------------------------------------------------------

    local General = win:CreateSection("General")
    local UI = win:CreateSection("UI")
    local Keybinds = win:CreateSection("Keybinds")
    local About = win:CreateSection("About")

    self.Sections.General = General
    self.Sections.UI = UI
    self.Sections.Keybinds = Keybinds
    self.Sections.About = About

    --------------------------------------------------------
    -- General Section
    --------------------------------------------------------
    General:AddLabel("General Settings")
    General:AddDivider("")

    General:AddButton("Reload UI", function()
        library:Notify("Reloaded", "The UI has been refreshed.")
    end)

    --------------------------------------------------------
    -- UI Section
    --------------------------------------------------------
    UI:AddLabel("Interface Settings")
    UI:AddDivider("")

    UI:AddToggle("Enable Context Menu", true, function(state)
        library.ContextMenu.Enabled = state
    end)

    UI:AddToggle("Enable Spotlight", true, function(state)
        library.Spotlight.Enabled = state
    end)

    --------------------------------------------------------
    -- Keybinds Section
    --------------------------------------------------------
    Keybinds:AddLabel("Keybind Settings")
    Keybinds:AddDivider("")

    Keybinds:AddButton("Change Window Toggle Key", function()
        library:Notify("Awaiting Input", "Press a key to set the new toggle key.")
        library._awaitingWindowKey = true
    end)

    Keybinds:AddButton("Change Spotlight Key", function()
        library:Notify("Awaiting Input", "Press a key to set the Spotlight key.")
        library._awaitingSpotlightKey = true
    end)

    Keybinds:AddButton("Change Visibility Key", function()
        library:Notify("Awaiting Input", "Press a key to set the visibility key.")
        library._awaitingVisibilityKey = true
    end)

    --------------------------------------------------------
    -- About Section
    --------------------------------------------------------
    About:AddLabel("AppleUI-Gen3")
    About:AddDivider("")
    About:AddLabel("Created by TrueVelocity")
    About:AddLabel("Inspired by macOS & iPadOS design")
    About:AddLabel("Version 3.0.0")

    --------------------------------------------------------
    -- Show window
    --------------------------------------------------------
    win:Show()
end

--========================================================--
-- AppleUI-Gen3
-- Preferences Logic (Keybind Changers + Right-Click Toggle)
--========================================================--

-- .

-- Awaiting keybind flags
library._awaitingWindowKey = false
library._awaitingSpotlightKey = false
library._awaitingVisibilityKey = false

-- Apply new keybind
local function applyKeybind(name, key)
    if name == "window" then
        if library._primaryWindow then
            library._primaryWindow.Keybind = key
        end
        library:Notify("Updated", "Window toggle key set to " .. key.Name)
    elseif name == "spotlight" then
        library.Spotlight.Keybind = key
        library:Notify("Updated", "Spotlight key set to " .. key.Name)
    elseif name == "visibility" then
        library.Visibility.Keybind = key
        library:Notify("Updated", "Visibility key set to " .. key.Name)
    end
end

-- Listen for keybind changes
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    -- Window toggle key
    if library._awaitingWindowKey and input.KeyCode ~= Enum.KeyCode.Unknown then
        library._awaitingWindowKey = false
        applyKeybind("window", input.KeyCode)
        return
    end

    -- Spotlight key
    if library._awaitingSpotlightKey and input.KeyCode ~= Enum.KeyCode.Unknown then
        library._awaitingSpotlightKey = false
        applyKeybind("spotlight", input.KeyCode)
        return
    end

    -- Visibility key
    if library._awaitingVisibilityKey and input.KeyCode ~= Enum.KeyCode.Unknown then
        library._awaitingVisibilityKey = false
        applyKeybind("visibility", input.KeyCode)
        return
    end

    --------------------------------------------------------
    -- Normal keybind behavior
    --------------------------------------------------------

    -- Toggle primary window
    if library._primaryWindow and library._primaryWindow.Keybind then
        if input.KeyCode == library._primaryWindow.Keybind then
            library._primaryWindow:Toggle()
        end
    end

    -- Spotlight
    if input.KeyCode == library.Spotlight.Keybind then
        library.Spotlight:Toggle()
    end

    -- Visibility
    if input.KeyCode == library.Visibility.Keybind then
        library.Visibility:Toggle()
    end
end)

------------------------------------------------------------
-- Right-click context menu listener
------------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if library.ContextMenu.Enabled then
            local pos = UserInputService:GetMouseLocation()
            library:OpenContextMenu({
                { text = "Preferences", callback = function() library.Preferences:Open() end },
                { text = "Reload UI", callback = function() library:Notify("Reloaded", "UI refreshed.") end },
            }, pos)
        end
    end
end)

--========================================================--
-- AppleUI-Gen3
-- Global Input Listeners (Escape, Focus, Drag Safety)
--========================================================--

-- .

------------------------------------------------------------
-- ESCAPE BEHAVIOR
------------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.Escape then
        -- Close context menu
        if library.ContextMenu.Active then
            local f = library.ContextMenu.MenuFrame
            if f then
                library:Tween(f, 0.15, { BackgroundTransparency = 1 })
                task.wait(0.15)
                f:Destroy()
            end
            library.ContextMenu.Active = false
        end

        -- Close Spotlight
        if library.Spotlight.Enabled then
            library.Spotlight.Enabled = false
            library:Tween(SpotlightBlur, 0.2, { Size = 0 })
            SpotlightOverlay.Visible = false
        end

        -- Hide Preferences window
        if library.Preferences.Window then
            library.Preferences.Window:Hide()
        end
    end
end)

------------------------------------------------------------
-- WINDOW FOCUS (Bring clicked window to front)
------------------------------------------------------------
local function bringToFront(frame)
    local maxZ = 10
    for _, win in ipairs(library.Windows) do
        local f = win:GetFrame()
        if f.ZIndex > maxZ then
            maxZ = f.ZIndex
        end
    end
    frame.ZIndex = maxZ + 1
end

for _, win in ipairs(library.Windows) do
    local frame = win:GetFrame()
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            bringToFront(frame)
        end
    end)
end

------------------------------------------------------------
-- DRAG SAFETY (Stop dragging if mouse leaves window)
------------------------------------------------------------
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- This automatically stops dragging in the window system
        -- because the dragging flag is stored inside each window.
        -- No extra code needed here, but this ensures consistency.
    end
end)

--========================================================--
-- AppleUI-Gen3
-- API Export (Clean Version)
--========================================================--

-- .

------------------------------------------------------------
-- Public Window Creation
------------------------------------------------------------
function library.new(title, icon, width, height)
    local win = library:CreateWindow(title, icon, width, height)
    library:_AttachSidebarAndWorkArea(win)
    library:_FinalizeWindow(win)
    return win
end

------------------------------------------------------------
-- Public Preferences Access
------------------------------------------------------------
function library.openPreferences()
    library.Preferences:Open()
end

------------------------------------------------------------
-- Public Spotlight Access
------------------------------------------------------------
function library.addSpotlightItem(name, callback)
    library.Spotlight:AddItem(name, callback)
end

------------------------------------------------------------
-- Public Context Menu Access
------------------------------------------------------------
function library.openContextMenu(options, position)
    library:OpenContextMenu(options, position)
end

------------------------------------------------------------
-- Public Visibility Toggle
------------------------------------------------------------
function library.toggleVisibility()
    library.Visibility:Toggle()
end

------------------------------------------------------------
-- Return Library (ONLY ONE)
------------------------------------------------------------
return library

--========================================================--
-- AppleUI-Gen3
-- Utility Functions (Tween, Corner, Stroke, Shadow, New)
--========================================================--

-- .

local TweenService = game:GetService("TweenService")

------------------------------------------------------------
-- Tween Wrapper
------------------------------------------------------------
function library:Tween(obj, time, props, easing)
    local info = TweenInfo.new(
        time or 0.2,
        easing or Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    return tween
end

------------------------------------------------------------
-- Corner Wrapper
------------------------------------------------------------
function library:Corner(radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or self.theme.Corner)
    return c
end

------------------------------------------------------------
-- Stroke Wrapper
------------------------------------------------------------
function library:Stroke(color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or self.theme.Stroke
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

------------------------------------------------------------
-- Shadow Wrapper
------------------------------------------------------------
function library:ApplyShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = parent
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.ZIndex = (parent.ZIndex or 1) - 1
end

------------------------------------------------------------
-- Safe Instance Creation
------------------------------------------------------------
function library:New(class, props)
    local obj = Instance.new(class)

    for k, v in pairs(props or {}) do
        obj[k] = v
    end

    return obj
end

--========================================================--
-- AppleUI-Gen3
-- Icon System (GetIcon, Asset Map)
--========================================================--

-- .

------------------------------------------------------------
-- Icon Asset Map
------------------------------------------------------------
library.Icons = {
    close = "rbxassetid://3926305904",      -- X icon
    minimize = "rbxassetid://3926307971",   -- dash icon
    settings = "rbxassetid://3926305904",   -- gear icon (placeholder)
    search = "rbxassetid://3926305904",     -- magnifying glass
    more = "rbxassetid://3926307971",       -- three dots
    info = "rbxassetid://3926307971",       -- info circle
    alert = "rbxassetid://3926307971",      -- warning triangle
    check = "rbxassetid://3926307971",      -- checkmark
}

------------------------------------------------------------
-- Get Icon by Name
------------------------------------------------------------
function library:GetIcon(name)
    return self.Icons[name] or self.Icons.info
end

--========================================================--
-- AppleUI-Gen3
-- Window System Enhancements (Dragging, Focus, Show/Hide)
--========================================================--

-- .

------------------------------------------------------------
-- Window API Enhancements
------------------------------------------------------------
function library:_EnhanceWindowAPI(api, frame, topbar)
    api._dragging = false
    api._dragOffset = Vector2.new(0, 0)

    --------------------------------------------------------
    -- Show Window
    --------------------------------------------------------
    function api:Show()
        frame.Visible = true
        library:Tween(frame, 0.2, {
            BackgroundTransparency = 0,
            Position = UDim2.new(frame.Position.X.Scale, frame.Position.X.Offset,
                                 frame.Position.Y.Scale, frame.Position.Y.Offset - 10)
        })
    end

    --------------------------------------------------------
    -- Hide Window
    --------------------------------------------------------
    function api:Hide()
        library:Tween(frame, 0.2, {
            BackgroundTransparency = 1,
            Position = UDim2.new(frame.Position.X.Scale, frame.Position.X.Offset,
                                 frame.Position.Y.Scale, frame.Position.Y.Offset + 10)
        })
        task.wait(0.2)
        frame.Visible = false
    end

    --------------------------------------------------------
    -- Toggle Window
    --------------------------------------------------------
    function api:Toggle()
        if frame.Visible then
            self:Hide()
        else
            self:Show()
        end
    end

    --------------------------------------------------------
    -- Bring Window to Front
    --------------------------------------------------------
    function api:Focus()
        local maxZ = 10
        for _, win in ipairs(library.Windows) do
            local f = win:GetFrame()
            if f.ZIndex > maxZ then
                maxZ = f.ZIndex
            end
        end
        frame.ZIndex = maxZ + 1
    end

    --------------------------------------------------------
    -- Dragging Logic
    --------------------------------------------------------
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            api._dragging = true
            api:Focus()
            api._dragOffset = Vector2.new(
                input.Position.X - frame.AbsolutePosition.X,
                input.Position.Y - frame.AbsolutePosition.Y
            )
        end
    end)

    topbar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            api._dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if api._dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newX = input.Position.X - api._dragOffset.X
            local newY = input.Position.Y - api._dragOffset.Y

            frame.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
end

--========================================================--
-- AppleUI-Gen3
-- Window Creation Core (CreateWindow, Sidebar, WorkArea)
--========================================================--

-- .

library.Windows = {}

------------------------------------------------------------
-- Create Window
------------------------------------------------------------
function library:CreateWindow(title, icon, width, height)
    width = width or 420
    height = height or 300

    --------------------------------------------------------
    -- Main Frame
    --------------------------------------------------------
    local Frame = self:New("Frame", {
        Parent = self.Root,
        BackgroundColor3 = self.theme.Background,
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2),
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 20
    })
    self:Corner(self.theme.Corner).Parent = Frame
    self:Stroke(self.theme.Stroke, 1).Parent = Frame
    self:ApplyShadow(Frame)

    --------------------------------------------------------
    -- Topbar
    --------------------------------------------------------
    local Topbar = self:New("Frame", {
        Parent = Frame,
        BackgroundColor3 = self.theme.Sidebar,
        Size = UDim2.new(1, 0, 0, 32),
        BorderSizePixel = 0,
        ZIndex = 21
    })
    self:Corner(self.theme.Corner).Parent = Topbar

    local Title = self:New("TextLabel", {
        Parent = Topbar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = self.theme.Font,
        Text = title or "Window",
        TextColor3 = self.theme.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 22
    })

    --------------------------------------------------------
    -- Close Button
    --------------------------------------------------------
    local Close = self:New("ImageButton", {
        Parent = Topbar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -28, 0.5, -10),
        Image = self:GetIcon("close"),
        ZIndex = 22
    })

    Close.MouseButton1Click:Connect(function()
        Frame.Visible = false
    end)

    --------------------------------------------------------
    -- Sidebar
    --------------------------------------------------------
    local Sidebar = self:New("Frame", {
        Parent = Frame,
        BackgroundColor3 = self.theme.Sidebar,
        Size = UDim2.new(0, 120, 1, -32),
        Position = UDim2.new(0, 0, 0, 32),
        BorderSizePixel = 0,
        ZIndex = 21
    })

    local SidebarList = self:New("UIListLayout", {
        Parent = Sidebar,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    })

    --------------------------------------------------------
    -- WorkArea
    --------------------------------------------------------
    local WorkArea = self:New("Frame", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -120, 1, -32),
        Position = UDim2.new(0, 120, 0, 32),
        ZIndex = 21
    })

    --------------------------------------------------------
    -- Window API
    --------------------------------------------------------
    local api = {}
    api.Frame = Frame
    api.Sidebar = Sidebar
    api.WorkArea = WorkArea
    api.Title = Title

    function api:GetFrame()
        return Frame
    end

    --------------------------------------------------------
    -- Section Creation
    --------------------------------------------------------
    function api:CreateSection(name)
        local Btn = library:New("TextButton", {
            Parent = Sidebar,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(1, -10, 0, 28),
            Position = UDim2.new(0, 5, 0, 0),
            Font = library.theme.Font,
            Text = name,
            TextColor3 = library.theme.Text,
            TextSize = 14,
            BorderSizePixel = 0,
            ZIndex = 22
        })
        library:Corner(6).Parent = Btn

        local SectionFrame = library:New("Frame", {
            Parent = WorkArea,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 5, 0, 5),
            Visible = false,
            ZIndex = 22
        })

        local SectionList = library:New("UIListLayout", {
            Parent = SectionFrame,
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6)
        })

        local sectionApi = {}
        library:_AttachElementAPI(sectionApi, SectionFrame)

        Btn.MouseButton1Click:Connect(function()
            for _, child in ipairs(WorkArea:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            SectionFrame.Visible = true
        end)

        return sectionApi
    end

    --------------------------------------------------------
    -- Enhance Window API (dragging, focus, show/hide)
    --------------------------------------------------------
    library:_EnhanceWindowAPI(api, Frame, Topbar)

    --------------------------------------------------------
    -- Register Window
    --------------------------------------------------------
    table.insert(self.Windows, api)

    return api
end

--========================================================--
-- AppleUI-Gen3
-- Final Cleanup + Integration Notes
--========================================================--

-- .

------------------------------------------------------------
-- Ensure All Windows Have Section APIs Attached
------------------------------------------------------------
for _, win in ipairs(library.Windows) do
    if win.WorkArea and win.Sidebar then
        -- Already handled during CreateWindow
    end
end

------------------------------------------------------------
-- Ensure Spotlight Blur Exists
------------------------------------------------------------
if not SpotlightBlur or SpotlightBlur.Parent == nil then
    local Lighting = game:GetService("Lighting")
    SpotlightBlur = Instance.new("BlurEffect")
    SpotlightBlur.Size = 0
    SpotlightBlur.Parent = Lighting
end

------------------------------------------------------------
-- Ensure Notification Holder Exists
------------------------------------------------------------
if not library.NotificationHolder then
    library.NotificationHolder = library:New("Frame", {
        Parent = library.Root,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 100
    })
end

------------------------------------------------------------
-- Final Ready Event
------------------------------------------------------------
if library.onReady then
    task.spawn(function()
        library.onReady()
    end)
end

------------------------------------------------------------
-- Library Fully Loaded
------------------------------------------------------------
print("[AppleUI-Gen3] Library successfully initialized.")
return library
