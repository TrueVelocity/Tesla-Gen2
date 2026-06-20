library = {}
-- LUCIDE ICONS
local Lucide = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mabil-YT/New-Apple-Library/refs/heads/main/icons.lua"))()

function library.ResolveIcon(icon)
    if typeof(icon) == "number" then
        return icon
    end
    if typeof(icon) == "string" then
        local key = string.lower(icon)
        local data = Lucide["48px"] and Lucide["48px"][key]
        if data then
            return data[1]
        end
    end
    return nil
end

function library.ApplyIconToElement(element, assetId)
    if not assetId then return end

    if element:FindFirstChild("icon") then
        element.icon.Image = "rbxassetid://" .. assetId
        return
    end

    local img = Instance.new("ImageLabel")
    img.Name = "icon"
    img.Parent = element
    img.BackgroundTransparency = 1
    img.Position = UDim2.new(0, 5, 0.5, -11)
    img.Size = UDim2.new(0, 22, 0, 22)
    img.Image = "rbxassetid://" .. assetId
    img.ImageColor3 = Color3.fromRGB(95, 95, 95)

    if element:IsA("TextButton") or element:IsA("TextLabel") then
        element.TextXAlignment = Enum.TextXAlignment.Left
        element.Text = "      " .. element.Text
    end
end

-- Universal element API
local function CreateElementAPI(obj)
    local api = {}

    function api:SetText(newText)
        if obj:FindFirstChild("label") then
            obj.label.Text = newText
        elseif obj:IsA("TextButton") or obj:IsA("TextLabel") then
            obj.Text = newText
        end
    end

    function api:SetImage(icon)
        local assetId = library.ResolveIcon(icon) or icon
        if not assetId then return end

        if obj:FindFirstChild("icon") then
            obj.icon.Image = "rbxassetid://" .. assetId
        else
            library.ApplyIconToElement(obj, assetId)
        end
    end

    return api
end

-- Main Library things --
local lib = {}
local sections = {}
local workareas = {}
local notifs = {}
local visible = true
local dbcooper = false

local function tp(ins, pos, time, thing)
    game:GetService("TweenService"):Create(ins, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), { Position = pos }):Play()
end

function lib:init(ti, dosplash, visiblekey, deleteprevious)
    if syn then
        cg = game:GetService("CoreGui")
        if cg:FindFirstChild("ScreenGui") and deleteprevious then
            tp(cg.ScreenGui.main, cg.ScreenGui.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            game:GetService("Debris"):AddItem(cg.ScreenGui, 1)
        end

        scrgui = Instance.new("ScreenGui")
        syn.protect_gui(scrgui)
        scrgui.Parent = game:GetService("CoreGui")
    elseif gethui then
        if gethui():FindFirstChild("ScreenGui") and deleteprevious then
            gethui().ScreenGui.main:TweenPosition(gethui().ScreenGui.main.Position + UDim2.new(0, 0, 2, 0), "InOut", "Quart", 0.5)
            game:GetService("Debris"):AddItem(gethui().ScreenGui, 1)
        end

        scrgui = Instance.new("ScreenGui")
        scrgui.Parent = gethui()
    else
        cg = game:GetService("CoreGui")
        if cg:FindFirstChild("ScreenGui") and deleteprevious then
            tp(cg.ScreenGui.main, cg.ScreenGui.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            game:GetService("Debris"):AddItem(cg.ScreenGui, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Parent = cg
    end

    if dosplash then
        local splash = Instance.new("Frame")
        splash.Name = "splash"
        splash.Parent = scrgui
        splash.AnchorPoint = Vector2.new(0.5, 0.5)
        splash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        splash.BackgroundTransparency = 0.600
        splash.Position = UDim2.new(0.5, 0, 2, 0)
        splash.Size = UDim2.new(0, 340, 0, 340)
        splash.Visible = true
        splash.ZIndex = 40

        local uc_22 = Instance.new("UICorner")
        uc_22.CornerRadius = UDim.new(0, 18)
        uc_22.Parent = splash

        local sicon = Instance.new("ImageLabel")
        sicon.Name = "sicon"
        sicon.Parent = splash
        sicon.AnchorPoint = Vector2.new(0.5, 0.5)
        sicon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sicon.BackgroundTransparency = 1
        sicon.Position = UDim2.new(0.5, 0, 0.5, 0)
        sicon.Size = UDim2.new(0, 191, 0, 190)
        sicon.ZIndex = 40
        sicon.Image = "rbxassetid://12621719043"
        sicon.ScaleType = Enum.ScaleType.Fit
        sicon.TileSize = UDim2.new(1, 0, 20, 0)

        local ug = Instance.new("UIGradient")
        ug.Color = ColorSequence.new {
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.01, Color3.fromRGB(61, 61, 61)),
            ColorSequenceKeypoint.new(0.47, Color3.fromRGB(41, 41, 41)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
        }
        ug.Rotation = 90
        ug.Parent = sicon

        local sshadow = Instance.new("ImageLabel")
        sshadow.Name = "sshadow"
        sshadow.Parent = splash
        sshadow.AnchorPoint = Vector2.new(0.5, 0.5)
        sshadow.BackgroundTransparency = 1
        sshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        sshadow.Size = UDim2.new(1.20000005, 0, 1.20000005, 0)
        sshadow.ZIndex = 39
        sshadow.Image = "rbxassetid://313486536"
        sshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        sshadow.ImageTransparency = 0.400
        sshadow.TileSize = UDim2.new(0, 1, 0, 1)

        splash:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "InOut", "Quart", 1)
        task.wait(2)
        splash:TweenPosition(UDim2.new(0.5, 0, 2, 0), "InOut", "Quart", 1)
        game:GetService("Debris"):AddItem(splash, 1)
    end

    local main = Instance.new("Frame")
    main.Name = "main"
    main.Parent = scrgui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    main.BackgroundTransparency = 0.150
    main.Position = UDim2.new(0.5, 0, 2, 0)
    main.Size = UDim2.new(0, 721, 0, 584)

    local uc = Instance.new("UICorner")
    uc.CornerRadius = UDim.new(0, 18)
    uc.Parent = main

    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    local workarea = Instance.new("Frame")
    workarea.Name = "workarea"
    workarea.Parent = main
    workarea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    workarea.Position = UDim2.new(0.36403501, 0, 0, 0)
    workarea.Size = UDim2.new(0, 458, 0, 584)

    local uc_2 = Instance.new("UICorner")
    uc_2.CornerRadius = UDim.new(0, 18)
    uc_2.Parent = workarea

    local workareacornerhider = Instance.new("Frame")
    workareacornerhider.Name = "workareacornerhider"
    workareacornerhider.Parent = workarea
    workareacornerhider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    workareacornerhider.BorderSizePixel = 0
    workareacornerhider.Size = UDim2.new(0, 18, 0.99895674, 0)

    local search = Instance.new("Frame")
    search.Name = "search"
    search.Parent = main
    search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    search.Position = UDim2.new(0.0256588068, 0, 0.0958904102, 0)
    search.Size = UDim2.new(0, 225, 0, 34)

    local uc_8 = Instance.new("UICorner")
    uc_8.CornerRadius = UDim.new(0, 9)
    uc_8.Parent = search

    local searchicon = Instance.new("ImageButton")
    searchicon.Name = "searchicon"
    searchicon.Parent = search
    searchicon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    searchicon.BackgroundTransparency = 1
    searchicon.BorderColor3 = Color3.fromRGB(27, 42, 53)
    searchicon.Position = UDim2.new(0.0379999988, -2, 0.138999999, 2)
    searchicon.Size = UDim2.new(0, 24, 0, 21)
    searchicon.Image = "rbxassetid://2804603863"
    searchicon.ImageColor3 = Color3.fromRGB(95, 95, 95)
    searchicon.ScaleType = Enum.ScaleType.Fit

    local searchtextbox = Instance.new("TextBox")
    searchtextbox.Name = "searchtextbox"
    searchtextbox.Parent = search
    searchtextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    searchtextbox.BackgroundTransparency = 1
    searchtextbox.ClipsDescendants = true
    searchtextbox.Position = UDim2.new(0.180257514, 0, -0.0162218884, 0)
    searchtextbox.Size = UDim2.new(0, 176, 0, 34)
    searchtextbox.Font = Enum.Font.Gotham
    searchtextbox.LineHeight = 0.870
    searchtextbox.PlaceholderText = "Search"
    searchtextbox.Text = ""
    searchtextbox.TextColor3 = Color3.fromRGB(95, 95, 95)
    searchtextbox.TextSize = 22
    searchtextbox.TextXAlignment = Enum.TextXAlignment.Left

    searchicon.MouseButton1Click:Connect(function()
        searchtextbox:CaptureFocus()
    end)

    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Name = "sidebar"
    sidebar.Parent = main
    sidebar.Active = true
    sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sidebar.BackgroundTransparency = 1
    sidebar.BorderSizePixel = 0
    sidebar.Position = UDim2.new(0.0249653254, 0, 0.181506842, 0)
    sidebar.Size = UDim2.new(0, 233, 0, 463)
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.ScrollBarThickness = 2

    local ull_2 = Instance.new("UIListLayout")
    ull_2.Parent = sidebar
    ull_2.SortOrder = Enum.SortOrder.LayoutOrder
    ull_2.Padding = UDim.new(0, 5)

    game:GetService("RunService"):BindToRenderStep("search", 1, function()
        if not searchtextbox:IsFocused() then
            for _, v in next, sidebar:GetChildren() do
                if not v:IsA("TextButton") then continue end
                v.Visible = true
            end
        end

        local InputText = string.upper(searchtextbox.Text)
        for _, button in pairs(sidebar:GetChildren()) do
            if button:IsA("TextButton") then
                if InputText == "" or string.find(string.upper(button.Text), InputText) ~= nil then
                    button.Visible = true
                else
                    button.Visible = false
                end
            end
        end
    end)

    local buttons = Instance.new("Frame")
    buttons.Name = "buttons"
    buttons.Parent = main
    buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    buttons.BackgroundTransparency = 1
    buttons.Size = UDim2.new(0, 105, 0, 57)

    local ull_3 = Instance.new("UIListLayout")
    ull_3.Parent = buttons
    ull_3.FillDirection = Enum.FillDirection.Horizontal
    ull_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ull_3.SortOrder = Enum.SortOrder.LayoutOrder
    ull_3.VerticalAlignment = Enum.VerticalAlignment.Center
    ull_3.Padding = UDim.new(0, 10)

    local close = Instance.new("TextButton")
    close.Name = "close"
    close.Parent = buttons
    close.BackgroundColor3 = Color3.fromRGB(254, 94, 86)
    close.Size = UDim2.new(0, 16, 0, 16)
    close.AutoButtonColor = false
    close.Font = Enum.Font.SourceSans
    close.Text = ""
    close.TextColor3 = Color3.fromRGB(255, 50, 50)
    close.TextSize = 14
    close.MouseButton1Click:Connect(function()
        scrgui:Destroy()
    end)

    local uc_18 = Instance.new("UICorner")
    uc_18.CornerRadius = UDim.new(1, 0)
    uc_18.Parent = close

    local minimize = Instance.new("TextButton")
    minimize.Name = "minimize"
    minimize.Parent = buttons
    minimize.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
    minimize.Size = UDim2.new(0, 16, 0, 16)
    minimize.AutoButtonColor = false
    minimize.Font = Enum.Font.SourceSans
    minimize.Text = ""
    minimize.TextColor3 = Color3.fromRGB(255, 50, 50)
    minimize.TextSize = 14

    local uc_19 = Instance.new("UICorner")
    uc_19.CornerRadius = UDim.new(1, 0)
    uc_19.Parent = minimize

    local resize = Instance.new("TextButton")
    resize.Name = "resize"
    resize.Parent = buttons
    resize.BackgroundColor3 = Color3.fromRGB(39, 200, 63)
    resize.Size = UDim2.new(0, 16, 0, 16)
    resize.AutoButtonColor = false
    resize.Font = Enum.Font.SourceSans
    resize.Text = ""
    resize.TextColor3 = Color3.fromRGB(255, 50, 50)
    resize.TextSize = 14

    local uc_20 = Instance.new("UICorner")
    uc_20.CornerRadius = UDim.new(1, 0)
    uc_20.Parent = resize

    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Parent = main
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.BorderSizePixel = 2
    title.Position = UDim2.new(0.389000326, 0, 0.0351027399, 0)
    title.Size = UDim2.new(0, 400, 0, 15)
    title.Font = Enum.Font.Gotham
    title.LineHeight = 1.180
    title.TextColor3 = Color3.fromRGB(0, 0, 0)
    title.TextSize = 28
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Left

    local notif = Instance.new("Frame")
    notif.Name = "notif"
    notif.Parent = main
    notif.AnchorPoint = Vector2.new(0.5, 0.5)
    notif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif.Size = UDim2.new(0, 304, 0, 362)
    notif.Visible = false
    notif.ZIndex = 3

    local uc_11 = Instance.new("UICorner")
    uc_11.CornerRadius = UDim.new(0, 18)
    uc_11.Parent = notif

    local notificon = Instance.new("ImageLabel")
    notificon.Name = "notificon"
    notificon.Parent = notif
    notificon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notificon.BackgroundTransparency = 1
    notificon.Position = UDim2.new(0.335526317, 0, 0.0994475111, 0)
    notificon.Size = UDim2.new(0, 100, 0, 100)
    notificon.ZIndex = 3
    notificon.Image = "rbxassetid://4871684504"
    notificon.ImageColor3 = Color3.fromRGB(95, 95, 95)

    local notifbutton1 = Instance.new("TextButton")
    notifbutton1.Name = "notifbutton1"
    notifbutton1.Parent = notif
    notifbutton1.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notifbutton1.Position = UDim2.new(0.0559210554, 0, 0.817679524, 0)
    notifbutton1.Size = UDim2.new(0, 270, 0, 50)
    notifbutton1.ZIndex = 3
    notifbutton1.Font = Enum.Font.Gotham
    notifbutton1.Text = "OK"
    notifbutton1.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifbutton1.TextSize = 21

    local uc_12 = Instance.new("UICorner")
    uc_12.CornerRadius = UDim.new(0, 9)
    uc_12.Parent = notifbutton1

    local notifshadow = Instance.new("ImageLabel")
    notifshadow.Name = "notifshadow"
    notifshadow.Parent = notif
    notifshadow.AnchorPoint = Vector2.new(0.5, 0.5)
    notifshadow.BackgroundTransparency = 1
    notifshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    notifshadow.Size = UDim2.new(1.20000005, 0, 1.20000005, 0)
    notifshadow.Image = "rbxassetid://313486536"
    notifshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)

    local notifdarkness = Instance.new("Frame")
    notifdarkness.Name = "notifdarkness"
    notifdarkness.Parent = notif
    notifdarkness.AnchorPoint = Vector2.new(0.5, 0.5)
    notifdarkness.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notifdarkness.BackgroundTransparency = 0.600
    notifdarkness.Position = UDim2.new(0.5, 0, 0.5, 0)
    notifdarkness.Size = UDim2.new(0, 721, 0, 584)
    notifdarkness.ZIndex = 2

    local uc_13 = Instance.new("UICorner")
    uc_13.CornerRadius = UDim.new(0, 18)
    uc_13.Parent = notifdarkness

    local notiftitle = Instance.new("TextLabel")
    notiftitle.Name = "notiftitle"
    notiftitle.Parent = notif
    notiftitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notiftitle.BackgroundTransparency = 1
    notiftitle.Position = UDim2.new(0.167763159, 0, 0.375690609, 0)
    notiftitle.Size = UDim2.new(0, 200, 0, 50)
    notiftitle.ZIndex = 3
    notiftitle.Font = Enum.Font.GothamMedium
    notiftitle.Text = "Notice"
    notiftitle.TextColor3 = Color3.fromRGB(95, 95, 95)
    notiftitle.TextSize = 28

    local notiftext = Instance.new("TextLabel")
    notiftext.Name = "notiftext"
    notiftext.Parent = notif
    notiftext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notiftext.BackgroundTransparency = 1
    notiftext.Position = UDim2.new(0.0822368413, 0, 0.513812184, 0)
    notiftext.Size = UDim2.new(0, 254, 0, 66)
    notiftext.ZIndex = 3
    notiftext.Font = Enum.Font.Gotham
    notiftext.Text = "We would like to contact you regarding your car's extended warranty."
    notiftext.TextColor3 = Color3.fromRGB(95, 95, 95)
    notiftext.TextSize = 16
    notiftext.TextWrapped = true

    local notif2 = Instance.new("Frame")
    notif2.Name = "notif2"
    notif2.Parent = main
    notif2.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif2.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2.Size = UDim2.new(0, 304, 0, 362)
    notif2.Visible = false
    notif2.ZIndex = 3

    local uc_14 = Instance.new("UICorner")
    uc_14.CornerRadius = UDim.new(0, 18)
    uc_14.Parent = notif2

    local notif2icon = Instance.new("ImageLabel")
    notif2icon.Name = "notif2icon"
    notif2icon.Parent = notif2
    notif2icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif2icon.BackgroundTransparency = 1
    notif2icon.Position = UDim2.new(0.335526317, 0, 0.0994475111, 0)
    notif2icon.Size = UDim2.new(0, 100, 0, 100)
    notif2icon.ZIndex = 3
    notif2icon.Image = "rbxassetid://12608260095"
    notif2icon.ImageColor3 = Color3.fromRGB(95, 95, 95)

    local notif2title = Instance.new("TextLabel")
    notif2title.Name = "notif2title"
    notif2title.Parent = notif2
    notif2title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif2title.BackgroundTransparency = 1
    notif2title.Position = UDim2.new(0.167763159, 0, 0.375690609, 0)
    notif2title.Size = UDim2.new(0, 200, 0, 50)
    notif2title.ZIndex = 3
    notif2title.Font = Enum.Font.GothamMedium
    notif2title.Text = "Notice"
    notif2title.TextColor3 = Color3.fromRGB(95, 95, 95)
    notif2title.TextSize = 28

    local notif2text = Instance.new("TextLabel")
    notif2text.Name = "notif2text"
    notif2text.Parent = notif2
    notif2text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif2text.BackgroundTransparency = 1
    notif2text.Position = UDim2.new(0.0822368413, 0, 0.513812184, 0)
    notif2text.Size = UDim2.new(0, 254, 0, 66)
    notif2text.ZIndex = 3
    notif2text.Font = Enum.Font.Gotham
    notif2text.Text = "We would like to contact you regarding your car's extended warranty."
    notif2text.TextColor3 = Color3.fromRGB(95, 95, 95)
    notif2text.TextSize = 16
    notif2text.TextWrapped = true

    local notif2button1 = Instance.new("TextButton")
    notif2button1.Name = "notif2button1"
    notif2button1.Parent = notif2
    notif2button1.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notif2button1.Position = UDim2.new(0.0559210517, 0, 0.715469658, 0)
    notif2button1.Size = UDim2.new(0, 270, 0, 40)
    notif2button1.ZIndex = 3
    notif2button1.Font = Enum.Font.Gotham
    notif2button1.Text = "Sure!"
    notif2button1.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif2button1.TextSize = 21

    local uc_15 = Instance.new("UICorner")
    uc_15.CornerRadius = UDim.new(0, 9)
    uc_15.Parent = notif2button1

    local notif2shadow = Instance.new("ImageLabel")
    notif2shadow.Name = "notif2shadow"
    notif2shadow.Parent = notif2
    notif2shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2shadow.BackgroundTransparency = 1
    notif2shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2shadow.Size = UDim2.new(1.20000005, 0, 1.20000005, 0)
    notif2shadow.Image = "rbxassetid://313486536"
    notif2shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)

    local notif2darkness = Instance.new("Frame")
    notif2darkness.Name = "notif2darkness"
    notif2darkness.Parent = notif2
    notif2darkness.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2darkness.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notif2darkness.BackgroundTransparency = 0.600
    notif2darkness.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2darkness.Size = UDim2.new(0, 721, 0, 584)
    notif2darkness.ZIndex = 2

    local uc_16 = Instance.new("UICorner")
    uc_16.CornerRadius = UDim.new(0, 18)
    uc_16.Parent = notif2darkness

    local notif2button2 = Instance.new("TextButton")
    notif2button2.Name = "notif2button2"
    notif2button2.Parent = notif2
    notif2button2.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notif2button2.BackgroundTransparency = 1
    notif2button2.Position = UDim2.new(0.0526315793, 0, 0.842541456, 0)
    notif2button2.Size = UDim2.new(0, 270, 0, 40)
    notif2button2.ZIndex = 3
    notif2button2.Font = Enum.Font.Gotham
    notif2button2.Text = "Go away."
    notif2button2.TextColor3 = Color3.fromRGB(95, 95, 95)
    notif2button2.TextSize = 21

    local uc_17 = Instance.new("UICorner")
    uc_17.CornerRadius = UDim.new(0, 9)
    uc_17.Parent = notif2button2

    if ti then
        title.Text = ti
    else
        title.Text = ""
    end

    tp(main, UDim2.new(0.5, 0, 0.5, 0), 1)

    window = {}
    window.ContextMenu = ContextMenu

    function window:Section(opts)
    opts = typeof(opts) == "table" and opts or { Text = opts }

    local text = opts.Text or "Section"
    local image = opts.Image

    local sidebar2 = Instance.new("TextButton")
    sidebar2.Name = "sidebar2"
    sidebar2.Parent = sidebar
    sidebar2.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    sidebar2.BackgroundTransparency = 1
    sidebar2.Size = UDim2.new(0, 226, 0, 37)
    sidebar2.ZIndex = 2
    sidebar2.AutoButtonColor = false
    sidebar2.Font = Enum.Font.Gotham
    sidebar2.Text = text
    sidebar2.TextColor3 = Color3.fromRGB(0, 0, 0)
    sidebar2.TextSize = 21

    local uc_10 = Instance.new("UICorner")
    uc_10.CornerRadius = UDim.new(0, 9)
    uc_10.Parent = sidebar2
    table.insert(sections, sidebar2)

    -- ICON SUPPORT
    if image then
        local assetId = ResolveIcon(image) or image
        local icon = Instance.new("ImageLabel")
        icon.Name = "icon"
        icon.Parent = sidebar2
        icon.BackgroundTransparency = 1
        icon.Position = UDim2.new(0, 5, 0.5, -11)
        icon.Size = UDim2.new(0, 22, 0, 22)
        icon.Image = "rbxassetid://" .. assetId
        icon.ImageColor3 = Color3.fromRGB(95, 95, 95)

        sidebar2.Text = "      " .. text
        sidebar2.TextXAlignment = Enum.TextXAlignment.Left
    end

    local workareamain = Instance.new("ScrollingFrame")
    workareamain.Name = "workareamain"
    workareamain.Parent = workarea
    workareamain.Active = true
    workareamain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    workareamain.BackgroundTransparency = 1
    workareamain.BorderSizePixel = 0
    workareamain.Position = UDim2.new(0.0393013097, 0, 0.0958904102, 0)
    workareamain.Size = UDim2.new(0, 422, 0, 512)
    workareamain.ZIndex = 3
    workareamain.CanvasSize = UDim2.new(0, 0, 0, 0)
    workareamain.ScrollBarThickness = 2
    workareamain.Visible = false

    local ull = Instance.new("UIListLayout")
    ull.Parent = workareamain
    ull.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ull.SortOrder = Enum.SortOrder.LayoutOrder
    ull.Padding = UDim.new(0, 5)

    table.insert(workareas, workareamain)

    local sec = {}

    function sec:Select()
        for _, v in next, sections do
            v.BackgroundTransparency = 1
            v.TextColor3 = Color3.fromRGB(0, 0, 0)
        end
        sidebar2.BackgroundTransparency = 0
        sidebar2.TextColor3 = Color3.fromRGB(255, 255, 255)

        for _, v in next, workareas do
            v.Visible = false
        end
        workareamain.Visible = true
    end

    function sec:Divider(name)
        local section = Instance.new("TextLabel")
        section.Name = "section"
        section.Parent = workareamain
        section.BackgroundTransparency = 1
        section.Size = UDim2.new(0, 418, 0, 50)
        section.Font = Enum.Font.Gotham
        section.Text = name
        section.TextColor3 = Color3.fromRGB(95, 95, 95)
        section.TextSize = 21
        section.TextXAlignment = Enum.TextXAlignment.Left
    end

    sec._workarea = workareamain
    return sec
end

    function window:ToggleVisible()
        if dbcooper then return end
        visible = not visible
        dbcooper = true
        if visible then
            tp(main, UDim2.new(0.5, 0, 0.5, 0), 0.5)
            task.wait(0.5)
            dbcooper = false
        else
            tp(main, main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            task.wait(0.5)
            dbcooper = false
        end
    end

    if visiblekey then
        minimize.MouseButton1Click:Connect(function()
            window:ToggleVisible()
        end)

        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == visiblekey then
                window:ToggleVisible()
            end
        end)
    end

    function window:GreenButton(callback)
        if _G.gbutton_123123 then _G.gbutton_123123:Disconnect() end
        _G.gbutton_123123 = resize.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    function window:TempNotify(text1, text2, icon)
        for _, v in next, scrgui:GetChildren() do
            if v.Name == "tempnotif" then
                v.Position += UDim2.new(0, 0, 0, 130)
            end
        end

        local tempnotif = Instance.new("Frame")
        tempnotif.Name = "tempnotif"
        tempnotif.Parent = scrgui
        tempnotif.AnchorPoint = Vector2.new(0.5, 0.5)
        tempnotif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tempnotif.BackgroundTransparency = 0.150
        tempnotif.Position = UDim2.new(1, -250, 0.0794737339, 0)
        tempnotif.Size = UDim2.new(0, 447, 0, 117)
        tempnotif.Visible = true
        tempnotif.ZIndex = 4

        local uc_21 = Instance.new("UICorner")
        uc_21.CornerRadius = UDim.new(0, 18)
        uc_21.Parent = tempnotif

        local t2 = Instance.new("TextLabel")
        t2.Name = "t2"
        t2.Parent = tempnotif
        t2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        t2.BackgroundTransparency = 1
        t2.Position = UDim2.new(0.236927822, 0, 0.470085472, 0)
        t2.Size = UDim2.new(0, 326, 0, 52)
        t2.ZIndex = 4
        t2.Font = Enum.Font.Gotham
        t2.Text = text2
        t2.TextColor3 = Color3.fromRGB(95, 95, 95)
        t2.TextSize = 16
        t2.TextWrapped = true
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextYAlignment = Enum.TextYAlignment.Top

        local t1 = Instance.new("TextLabel")
        t1.Name = "t1"
        t1.Parent = tempnotif
        t1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        t1.BackgroundTransparency = 1
        t1.Position = UDim2.new(0.234690696, 0, 0.193464488, 0)
        t1.Size = UDim2.new(0, 327, 0, 25)
        t1.ZIndex = 4
        t1.Font = Enum.Font.GothamMedium
        t1.Text = text1
        t1.TextColor3 = Color3.fromRGB(95, 95, 95)
        t1.TextSize = 28
        t1.TextXAlignment = Enum.TextXAlignment.Left

        local ticon = Instance.new("ImageLabel")
        ticon.Name = "ticon"
        ticon.Parent = tempnotif
        ticon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ticon.BackgroundTransparency = 1
        ticon.Position = UDim2.new(0.0311112702, 0, 0.193464488, 0)
        ticon.Size = UDim2.new(0, 71, 0, 71)
        ticon.ZIndex = 4
        ticon.Image = icon
        ticon.ImageColor3 = Color3.fromRGB(95, 95, 95)
        ticon.ScaleType = Enum.ScaleType.Fit

        local tshadow = Instance.new("ImageLabel")
        tshadow.Name = "tshadow"
        tshadow.Parent = tempnotif
        tshadow.AnchorPoint = Vector2.new(0.5, 0.5)
        tshadow.BackgroundTransparency = 1
        tshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        tshadow.Size = UDim2.new(1.12, 0, 1.20000005, 0)
        tshadow.ZIndex = 3
        tshadow.Image = "rbxassetid://313486536"
        tshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        tshadow.ImageTransparency = 0.400
        tshadow.TileSize = UDim2.new(0, 1, 0, 1)

        game:GetService("Debris"):AddItem(tempnotif, 5)
    end

    function window:Notify(txt1, txt2, b1, icohn, callback)
        if notif.Visible == true or notif2.Visible == true then return "Already visible" end
        notiftitle.Text = txt1
        notiftext.Text = txt2
        notificon.Image = icohn
        notif.Visible = true
        notifbutton1.Text = b1

        if callback then
            local con1
            con1 = notifbutton1.MouseButton1Click:Connect(function()
                con1:Disconnect()
                callback()
                notif.Visible = false
            end)
        end
    end

    function window:Notify2(txt1, txt2, b1, b2, icohn, callback, callback2)
        if notif.Visible == true or notif2.Visible == true then return "Already visible" end
        notif2title.Text = txt1
        notif2text.Text = txt2
        notif2icon.Image = icohn
        notif2.Visible = true
        notif2button1.Text = b1
        notif2button2.Text = b2

        if callback and callback2 then
            local con1, con2
            con1 = notif2button1.MouseButton1Click:Connect(function()
                con1:Disconnect()
                con2:Disconnect()
                callback()
                notif2.Visible = false
            end)
            con2 = notif2button2.MouseButton1Click:Connect(function()
                con1:Disconnect()
                con2:Disconnect()
                callback2()
                notif2.Visible = false
            end)
        end
    end

    function window:Divider(name)
        local sidebardivider = Instance.new("TextLabel")
        sidebardivider.Name = "sidebardivider"
        sidebardivider.Parent = sidebar
        sidebardivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sidebardivider.BackgroundTransparency = 1
        sidebardivider.BorderSizePixel = 2
        sidebardivider.Position = UDim2.new(0, 0, 0.00215982716, 0)
        sidebardivider.Size = UDim2.new(0, 226, 0, 26)
        sidebardivider.Font = Enum.Font.Gotham
        sidebardivider.Text = name
        sidebardivider.TextColor3 = Color3.fromRGB(95, 95, 95)
        sidebardivider.TextSize = 21
        sidebardivider.TextWrapped = true
        sidebardivider.TextXAlignment = Enum.TextXAlignment.Left
        sidebardivider.TextYAlignment = Enum.TextYAlignment.Bottom
    end
end

return window
end


function sec:Keybind(opts, callback)
    opts = opts or {}
    local text = opts.Text or "Keybind"
    local image = opts.Image
    local current = opts.Current or "Q"

    local frame = Instance.new("Frame")
    frame.Name = "Keybind"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 50)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0.5, -11)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0, 260, 1, 0)
    label.Position = iconImg and UDim2.new(0, 35, 0, 0) or UDim2.new(0, 5, 0, 0)

    -- KEY BUTTON
    local keyBtn = Instance.new("TextButton")
    keyBtn.Name = "keyBtn"
    keyBtn.Parent = frame
    keyBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    keyBtn.BorderSizePixel = 0
    keyBtn.Size = UDim2.new(0, 80, 0, 30)
    keyBtn.Position = UDim2.new(1, -90, 0.5, -15)
    keyBtn.Font = Enum.Font.GothamSemibold
    keyBtn.Text = current
    keyBtn.TextColor3 = Color3.fromRGB(70, 70, 70)
    keyBtn.TextSize = 14

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = keyBtn

    -- Hover effect
    keyBtn.MouseEnter:Connect(function()
        keyBtn.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
    end)
    keyBtn.MouseLeave:Connect(function()
        keyBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    end)

    -- Keybind selection
    local UIS = game:GetService("UserInputService")
    local listening = false

    keyBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyBtn.Text = "..."

        local input = UIS.InputBegan:Wait()
        if input.KeyCode and input.KeyCode.Name ~= "Unknown" then
            current = input.KeyCode.Name
            keyBtn.Text = current
            if callback then callback(current) end
        else
            keyBtn.Text = current
        end

        listening = false
    end)

    -- Keybind activation
    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode.Name == current then
            if callback then callback(current) end
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0.5, -11)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetKey(newKey)
        current = newKey
        keyBtn.Text = newKey
    end

    return api
end

function sec:Button(opts)
    opts = opts or {}
    local text = opts.Text or opts.Name or "Button"
    local image = opts.Image
    local callback = opts.Callback

    -- MAIN BUTTON FRAME
    local btn = Instance.new("TextButton")
    btn.Name = "Button"
    btn.Parent = workareamain
    btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(0, 418, 0, 40)
    btn.Font = Enum.Font.Gotham
    btn.Text = ""
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = btn

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = btn
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 10, 0.5, -11)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = btn
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(40, 40, 40)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = iconImg and UDim2.new(0, 40, 0, 0) or UDim2.new(0, 12, 0, 0)

    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    end)

    -- Click callback
    btn.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = btn
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 10, 0.5, -11)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    return api
end

function sec:Toggle(opts)
    opts = opts or {}
    local text = opts.Text or "Toggle"
    local image = opts.Image
    local state = opts.State or false
    local callback = opts.Callback

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "Toggle"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 50)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0.5, -11)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0, 260, 1, 0)
    label.Position = iconImg and UDim2.new(0, 35, 0, 0) or UDim2.new(0, 5, 0, 0)

    -- TOGGLE SWITCH
    local toggle = Instance.new("Frame")
    toggle.Name = "switch"
    toggle.Parent = frame
    toggle.BackgroundColor3 = state and Color3.fromRGB(21, 103, 251) or Color3.fromRGB(200, 200, 200)
    toggle.Size = UDim2.new(0, 45, 0, 24)
    toggle.Position = UDim2.new(1, -60, 0.5, -12)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Name = "knob"
    knob.Parent = toggle
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    -- ANIMATION FUNCTION
    local TweenService = game:GetService("TweenService")

    local function animateToggle(newState)
        state = newState

        TweenService:Create(toggle, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            BackgroundColor3 = newState and Color3.fromRGB(21, 103, 251) or Color3.fromRGB(200, 200, 200)
        }):Play()

        TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Position = newState
                and UDim2.new(1, -22, 0.5, -10)
                or UDim2.new(0, 2, 0.5, -10)
        }):Play()

        if callback then
            callback(newState)
        end
    end

    -- CLICK HANDLER
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            animateToggle(not state)
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0.5, -11)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetState(newState)
        animateToggle(newState)
    end

    return api
end
function sec:Slider(opts)
    opts = opts or {}
    local text = opts.Text or "Slider"
    local image = opts.Image
    local min = opts.Min or 0
    local max = opts.Max or 100
    local value = opts.Value or min
    local callback = opts.Callback

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "Slider"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 60)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0, 5)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, -10, 0, 22)
    label.Position = iconImg and UDim2.new(0, 35, 0, 5) or UDim2.new(0, 5, 0, 5)

    -- VALUE LABEL
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "valueLabel"
    valueLabel.Parent = frame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Enum.Font.GothamSemibold
    valueLabel.Text = tostring(value)
    valueLabel.TextColor3 = Color3.fromRGB(70, 70, 70)
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Size = UDim2.new(0, 80, 0, 22)
    valueLabel.Position = UDim2.new(1, -85, 0, 5)

    -- SLIDER BAR
    local bar = Instance.new("Frame")
    bar.Name = "bar"
    bar.Parent = frame
    bar.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    bar.BorderSizePixel = 0
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 35)

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    -- FILL
    local fill = Instance.new("Frame")
    fill.Name = "fill"
    fill.Parent = bar
    fill.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    -- KNOB
    local knob = Instance.new("Frame")
    knob.Name = "knob"
    knob.Parent = bar
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8)

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local dragging = false
    local UIS = game:GetService("UserInputService")

    -- UPDATE FUNCTION
    local function update(inputX)
        local barAbsPos = bar.AbsolutePosition.X
        local barAbsSize = bar.AbsoluteSize.X

        local percent = math.clamp((inputX - barAbsPos) / barAbsSize, 0, 1)
        local newValue = math.floor(min + (max - min) * percent)

        value = newValue
        valueLabel.Text = tostring(value)

        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -8, 0.5, -8)

        if callback then
            callback(value)
        end
    end

    -- DRAGGING
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0, 5)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetValue(newValue)
        value = math.clamp(newValue, min, max)
        local percent = (value - min) / (max - min)

        valueLabel.Text = tostring(value)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -8, 0.5, -8)

        if callback then
            callback(value)
        end
    end

    return api
end

function sec:Dropdown(opts)
    opts = opts or {}
    local text = opts.Text or "Dropdown"
    local image = opts.Image
    local list = opts.List or {}
    local value = opts.Value or list[1] or ""
    local callback = opts.Callback

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "Dropdown"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 50)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0.5, -11)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0, 260, 1, 0)
    label.Position = iconImg and UDim2.new(0, 35, 0, 0) or UDim2.new(0, 5, 0, 0)

    -- CURRENT VALUE
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "valueLabel"
    valueLabel.Parent = frame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Enum.Font.GothamSemibold
    valueLabel.Text = tostring(value)
    valueLabel.TextColor3 = Color3.fromRGB(70, 70, 70)
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Size = UDim2.new(0, 120, 1, 0)
    valueLabel.Position = UDim2.new(1, -130, 0, 0)

    -- ARROW
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "arrow"
    arrow.Parent = frame
    arrow.BackgroundTransparency = 1
    arrow.Size = UDim2.new(0, 18, 0, 18)
    arrow.Position = UDim2.new(1, -25, 0.5, -9)
    arrow.Image = "rbxassetid://7072706620" -- clean chevron
    arrow.ImageColor3 = Color3.fromRGB(95, 95, 95)

    -- DROPDOWN LIST
    local listFrame = Instance.new("Frame")
    listFrame.Name = "listFrame"
    listFrame.Parent = frame
    listFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    listFrame.BorderSizePixel = 0
    listFrame.Position = UDim2.new(0, 0, 1, 0)
    listFrame.Size = UDim2.new(1, 0, 0, 0)
    listFrame.ClipsDescendants = true
    listFrame.Visible = false

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 9)
    listCorner.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = listFrame
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- POPULATE LIST
    local function refreshList()
        for _, child in ipairs(listFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for _, item in ipairs(list) do
            local btn = Instance.new("TextButton")
            btn.Name = "item"
            btn.Parent = listFrame
            btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Position = UDim2.new(0, 5, 0, 0)
            btn.Font = Enum.Font.Gotham
            btn.Text = item
            btn.TextColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextSize = 16
            btn.AutoButtonColor = false

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = btn

            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            end)

            btn.MouseButton1Click:Connect(function()
                value = item
                valueLabel.Text = item
                listFrame.Visible = false
                listFrame.Size = UDim2.new(1, 0, 0, 0)
                if callback then callback(item) end
            end)
        end
    end

    refreshList()

    -- OPEN/CLOSE ANIMATION
    local TweenService = game:GetService("TweenService")
    local open = false

    local function toggleDropdown()
        open = not open

        if open then
            listFrame.Visible = true
            TweenService:Create(listFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, #list * 40)
            }):Play()
        else
            TweenService:Create(listFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.wait(0.15)
            listFrame.Visible = false
        end
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDropdown()
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0.5, -11)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetList(newList)
        list = newList
        refreshList()
    end

    function api:SetValue(newValue)
        value = newValue
        valueLabel.Text = newValue
        if callback then callback(newValue) end
    end

    return api
end

function sec:Textbox(opts)
    opts = opts or {}
    local text = opts.Text or "Textbox"
    local image = opts.Image
    local placeholder = opts.Placeholder or "Enter text..."
    local value = opts.Value or ""
    local callback = opts.Callback

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "Textbox"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 60)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0, 5)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, -10, 0, 22)
    label.Position = iconImg and UDim2.new(0, 35, 0, 5) or UDim2.new(0, 5, 0, 5)

    -- INPUT BOX
    local box = Instance.new("TextBox")
    box.Name = "box"
    box.Parent = frame
    box.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    box.BorderSizePixel = 0
    box.Size = UDim2.new(1, -20, 0, 32)
    box.Position = UDim2.new(0, 10, 0, 28)
    box.Font = Enum.Font.Gotham
    box.Text = value
    box.PlaceholderText = placeholder
    box.TextColor3 = Color3.fromRGB(40, 40, 40)
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.TextSize = 16

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = box

    -- FOCUS EFFECT
    box.Focused:Connect(function()
        box.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    end)

    box.FocusLost:Connect(function()
        box.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        value = box.Text
        if callback then callback(value) end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0, 5)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetValue(newValue)
        value = newValue
        box.Text = newValue
        if callback then callback(newValue) end
    end

    return api
end

function sec:Colorpicker(opts)
    opts = opts or {}
    local text = opts.Text or "Color Picker"
    local image = opts.Image
    local default = opts.Color or Color3.fromRGB(255, 255, 255)
    local callback = opts.Callback

    local hue = 0
    local sat = 1
    local val = 1

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "Colorpicker"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 90)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0, 5)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, -10, 0, 22)
    label.Position = iconImg and UDim2.new(0, 35, 0, 5) or UDim2.new(0, 5, 0, 5)

    -- PREVIEW CIRCLE
    local preview = Instance.new("Frame")
    preview.Name = "preview"
    preview.Parent = frame
    preview.BackgroundColor3 = default
    preview.Size = UDim2.new(0, 26, 0, 26)
    preview.Position = UDim2.new(1, -40, 0, 5)

    local previewCorner = Instance.new("UICorner")
    previewCorner.CornerRadius = UDim.new(1, 0)
    previewCorner.Parent = preview

    -- HUE BAR
    local hueBar = Instance.new("Frame")
    hueBar.Name = "hueBar"
    hueBar.Parent = frame
    hueBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    hueBar.BorderSizePixel = 0
    hueBar.Size = UDim2.new(1, -20, 0, 12)
    hueBar.Position = UDim2.new(0, 10, 0, 40)

    local hueCorner = Instance.new("UICorner")
    hueCorner.CornerRadius = UDim.new(1, 0)
    hueCorner.Parent = hueBar

    local hueGradient = Instance.new("UIGradient")
    hueGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    hueGradient.Parent = hueBar

    -- HUE KNOB
    local hueKnob = Instance.new("Frame")
    hueKnob.Name = "hueKnob"
    hueKnob.Parent = hueBar
    hueKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueKnob.Size = UDim2.new(0, 14, 0, 14)
    hueKnob.Position = UDim2.new(0, -7, 0.5, -7)

    local hueKnobCorner = Instance.new("UICorner")
    hueKnobCorner.CornerRadius = UDim.new(1, 0)
    hueKnobCorner.Parent = hueKnob

    -- UPDATE COLOR
    local function updateColor()
        local color = Color3.fromHSV(hue, sat, val)
        preview.BackgroundColor3 = color
        if callback then callback(color) end
    end

    -- DRAGGING
    local draggingHue = false
    local UIS = game:GetService("UserInputService")

    hueBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingHue = true
            local x = input.Position.X
            local barPos = hueBar.AbsolutePosition.X
            local barSize = hueBar.AbsoluteSize.X
            hue = math.clamp((x - barPos) / barSize, 0, 1)
            hueKnob.Position = UDim2.new(hue, -7, 0.5, -7)
            updateColor()
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if draggingHue and input.UserInputType == Enum.UserInputType.MouseMovement then
            local x = input.Position.X
            local barPos = hueBar.AbsolutePosition.X
            local barSize = hueBar.AbsoluteSize.X
            hue = math.clamp((x - barPos) / barSize, 0, 1)
            hueKnob.Position = UDim2.new(hue, -7, 0.5, -7)
            updateColor()
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingHue = false
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0, 5)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetColor(newColor)
        local h, s, v = Color3.toHSV(newColor)
        hue, sat, val = h, s, v
        hueKnob.Position = UDim2.new(hue, -7, 0.5, -7)
        preview.BackgroundColor3 = newColor
        if callback then callback(newColor) end
    end

    return api
end

function sec:MultiDropdown(opts)
    opts = opts or {}
    local text = opts.Text or "Multi Select"
    local image = opts.Image
    local list = opts.List or {}
    local selected = opts.Selected or {} -- table of selected values
    local callback = opts.Callback

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "MultiDropdown"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 50)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0.5, -11)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0, 260, 1, 0)
    label.Position = iconImg and UDim2.new(0, 35, 0, 0) or UDim2.new(0, 5, 0, 0)

    -- SELECTED COUNT
    local countLabel = Instance.new("TextLabel")
    countLabel.Name = "countLabel"
    countLabel.Parent = frame
    countLabel.BackgroundTransparency = 1
    countLabel.Font = Enum.Font.GothamSemibold
    countLabel.Text = tostring(#selected) .. " selected"
    countLabel.TextColor3 = Color3.fromRGB(70, 70, 70)
    countLabel.TextSize = 16
    countLabel.TextXAlignment = Enum.TextXAlignment.Right
    countLabel.Size = UDim2.new(0, 120, 1, 0)
    countLabel.Position = UDim2.new(1, -130, 0, 0)

    -- ARROW
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "arrow"
    arrow.Parent = frame
    arrow.BackgroundTransparency = 1
    arrow.Size = UDim2.new(0, 18, 0, 18)
    arrow.Position = UDim2.new(1, -25, 0.5, -9)
    arrow.Image = "rbxassetid://7072706620"
    arrow.ImageColor3 = Color3.fromRGB(95, 95, 95)

    -- LIST FRAME
    local listFrame = Instance.new("Frame")
    listFrame.Name = "listFrame"
    listFrame.Parent = frame
    listFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    listFrame.BorderSizePixel = 0
    listFrame.Position = UDim2.new(0, 0, 1, 0)
    listFrame.Size = UDim2.new(1, 0, 0, 0)
    listFrame.ClipsDescendants = true
    listFrame.Visible = false

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 9)
    listCorner.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = listFrame
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- POPULATE LIST
    local function refreshList()
        for _, child in ipairs(listFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for _, item in ipairs(list) do
            local btn = Instance.new("TextButton")
            btn.Name = "item"
            btn.Parent = listFrame
            btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Position = UDim2.new(0, 5, 0, 0)
            btn.Font = Enum.Font.Gotham
            btn.Text = item
            btn.TextColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextSize = 16
            btn.AutoButtonColor = false
            btn.TextXAlignment = Enum.TextXAlignment.Left

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = btn

            -- CHECKMARK
            local check = Instance.new("ImageLabel")
            check.Name = "check"
            check.Parent = btn
            check.BackgroundTransparency = 1
            check.Size = UDim2.new(0, 20, 0, 20)
            check.Position = UDim2.new(1, -30, 0.5, -10)
            check.Image = "rbxassetid://6031094667" -- checkmark
            check.ImageColor3 = Color3.fromRGB(21, 103, 251)
            check.Visible = table.find(selected, item) ~= nil

            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            end)

            btn.MouseButton1Click:Connect(function()
                if table.find(selected, item) then
                    table.remove(selected, table.find(selected, item))
                else
                    table.insert(selected, item)
                end

                check.Visible = table.find(selected, item) ~= nil
                countLabel.Text = tostring(#selected) .. " selected"

                if callback then callback(selected) end
            end)
        end
    end

    refreshList()

    -- OPEN/CLOSE ANIMATION
    local TweenService = game:GetService("TweenService")
    local open = false

    local function toggleDropdown()
        open = not open

        if open then
            listFrame.Visible = true
            TweenService:Create(listFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, #list * 40)
            }):Play()
        else
            TweenService:Create(listFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.wait(0.15)
            listFrame.Visible = false
        end
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDropdown()
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0.5, -11)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetList(newList)
        list = newList
        refreshList()
    end

    function api:SetValues(newValues)
        selected = newValues
        countLabel.Text = tostring(#selected) .. " selected"
        refreshList()
        if callback then callback(selected) end
    end

    return api
end

function window:NotifySonoma(opts)
    opts = opts or {}
    local title = opts.Title or "Notification"
    local text = opts.Text or ""
    local icon = opts.Icon
    local duration = opts.Duration or 4
    local callback = opts.Callback

    -- STACK OFFSET
    local offset = 0
    for _, v in ipairs(scrgui:GetChildren()) do
        if v.Name == "sonomaNotif" then
            offset += 70
        end
    end

    -- MAIN FRAME
    local notif = Instance.new("Frame")
    notif.Name = "sonomaNotif"
    notif.Parent = scrgui
    notif.AnchorPoint = Vector2.new(1, 0)
    notif.Position = UDim2.new(1, -20, 0, 20 + offset)
    notif.Size = UDim2.new(0, 320, 0, 60)
    notif.BackgroundTransparency = 1
    notif.ZIndex = 50

    -- BLUR BACKGROUND
    local blur = Instance.new("Frame")
    blur.Parent = notif
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    blur.BackgroundTransparency = 0.25
    blur.ZIndex = 51

    local blurCorner = Instance.new("UICorner")
    blurCorner.CornerRadius = UDim.new(0, 14)
    blurCorner.Parent = blur

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Parent = blur
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Transparency = 0.6
    uiStroke.Thickness = 1

    -- SHADOW
    local shadow = Instance.new("ImageLabel")
    shadow.Parent = notif
    shadow.BackgroundTransparency = 1
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1.3, 0, 1.6, 0)
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageTransparency = 0.45
    shadow.ZIndex = 49

    -- ICON
    local iconImg
    if icon then
        iconImg = Instance.new("ImageLabel")
        iconImg.Parent = notif
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 32, 0, 32)
        iconImg.Position = UDim2.new(0, 12, 0.5, -16)
        iconImg.Image = "rbxassetid://" .. (library.ResolveIcon(icon) or icon)
        iconImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
        iconImg.ZIndex = 52
    end

    -- TITLE
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = notif
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.ZIndex = 52
    titleLabel.Position = iconImg and UDim2.new(0, 55, 0, 6) or UDim2.new(0, 12, 0, 6)
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- TEXT
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = notif
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    textLabel.TextSize = 14
    textLabel.ZIndex = 52
    textLabel.Position = iconImg and UDim2.new(0, 55, 0, 28) or UDim2.new(0, 12, 0, 28)
    textLabel.Size = UDim2.new(1, -20, 0, 20)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- ANIMATION
    notif.Position = UDim2.new(1, 40, 0, 20 + offset)
    notif.BackgroundTransparency = 1

    game:GetService("TweenService"):Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -20, 0, 20 + offset),
        BackgroundTransparency = 0
    }):Play()

    -- AUTO REMOVE
    task.delay(duration, function()
        game:GetService("TweenService"):Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Position = UDim2.new(1, 40, 0, 20 + offset),
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.25)
        notif:Destroy()
    end)

    -- CLICK CALLBACK
    notif.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if callback then callback() end
        end
    end)
end

local sidebar2 = Instance.new("TextButton")
sidebar2.Name = "sidebar2"
sidebar2.Parent = sidebar
sidebar2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sidebar2.BackgroundTransparency = 1
sidebar2.Size = UDim2.new(0, 226, 0, 37)
sidebar2.Font = Enum.Font.Gotham
sidebar2.Text = text
sidebar2.TextColor3 = Color3.fromRGB(0, 0, 0)
sidebar2.TextSize = 21
sidebar2.AutoButtonColor = false

-- ICON
local iconImg
if image then
    iconImg = Instance.new("ImageLabel")
    iconImg.Name = "icon"
    iconImg.Parent = sidebar2
    iconImg.BackgroundTransparency = 1
    iconImg.Size = UDim2.new(0, 20, 0, 20)
    iconImg.Position = UDim2.new(0, 5, 0.5, -10)
    iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
    iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    sidebar2.Text = "      " .. text
    sidebar2.TextXAlignment = Enum.TextXAlignment.Left
end

-- LEFT ACCENT BAR
local accent = Instance.new("Frame")
accent.Name = "accent"
accent.Parent = sidebar2
accent.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
accent.Size = UDim2.new(0, 4, 1, 0)
accent.Position = UDim2.new(0, -4, 0, 0)
accent.Visible = false

-- HOVER EFFECT
sidebar2.MouseEnter:Connect(function()
    sidebar2.BackgroundTransparency = 0.85
end)
sidebar2.MouseLeave:Connect(function()
    if sidebar2.BackgroundColor3 ~= Color3.fromRGB(21, 103, 251) then
        sidebar2.BackgroundTransparency = 1
    end
end)

-- SELECT FUNCTION
function sec:Select()
    for _, v in next, sections do
        v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        v.TextColor3 = Color3.fromRGB(0, 0, 0)
        if v:FindFirstChild("accent") then
            v.accent.Visible = false
        end
    end

    sidebar2.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    sidebar2.BackgroundTransparency = 0
    sidebar2.TextColor3 = Color3.fromRGB(255, 255, 255)
    if iconImg then iconImg.ImageColor3 = Color3.fromRGB(255, 255, 255) end
    accent.Visible = true

    for _, v in next, workareas do
        v.Visible = false
    end
    workareamain.Visible = true
end

function sec:SearchDropdown(opts)
    opts = opts or {}
    local text = opts.Text or "Search Dropdown"
    local image = opts.Image
    local list = opts.List or {}
    local value = opts.Value or ""
    local callback = opts.Callback

    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Name = "SearchDropdown"
    frame.Parent = workareamain
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0, 418, 0, 50)

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Parent = frame
    line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)

    -- ICON (optional)
    local iconImg
    if image then
        iconImg = Instance.new("ImageLabel")
        iconImg.Name = "icon"
        iconImg.Parent = frame
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 5, 0.5, -11)
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(image) or image)
        iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
    end

    -- LABEL
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(95, 95, 95)
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0, 260, 1, 0)
    label.Position = iconImg and UDim2.new(0, 35, 0, 0) or UDim2.new(0, 5, 0, 0)

    -- CURRENT VALUE
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "valueLabel"
    valueLabel.Parent = frame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Enum.Font.GothamSemibold
    valueLabel.Text = tostring(value)
    valueLabel.TextColor3 = Color3.fromRGB(70, 70, 70)
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Size = UDim2.new(0, 120, 1, 0)
    valueLabel.Position = UDim2.new(1, -130, 0, 0)

    -- ARROW
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "arrow"
    arrow.Parent = frame
    arrow.BackgroundTransparency = 1
    arrow.Size = UDim2.new(0, 18, 0, 18)
    arrow.Position = UDim2.new(1, -25, 0.5, -9)
    arrow.Image = "rbxassetid://7072706620"
    arrow.ImageColor3 = Color3.fromRGB(95, 95, 95)

    -- DROPDOWN LIST FRAME
    local listFrame = Instance.new("Frame")
    listFrame.Name = "listFrame"
    listFrame.Parent = frame
    listFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    listFrame.BorderSizePixel = 0
    listFrame.Position = UDim2.new(0, 0, 1, 0)
    listFrame.Size = UDim2.new(1, 0, 0, 0)
    listFrame.ClipsDescendants = true
    listFrame.Visible = false

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 9)
    listCorner.Parent = listFrame

    -- SEARCH BOX
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "searchBox"
    searchBox.Parent = listFrame
    searchBox.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    searchBox.BorderSizePixel = 0
    searchBox.Size = UDim2.new(1, -20, 0, 32)
    searchBox.Position = UDim2.new(0, 10, 0, 5)
    searchBox.Font = Enum.Font.Gotham
    searchBox.PlaceholderText = "Search..."
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.fromRGB(40, 40, 40)
    searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    searchBox.TextSize = 16

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 8)
    searchCorner.Parent = searchBox

    -- LIST HOLDER
    local holder = Instance.new("Frame")
    holder.Name = "holder"
    holder.Parent = listFrame
    holder.BackgroundTransparency = 1
    holder.Position = UDim2.new(0, 0, 0, 42)
    holder.Size = UDim2.new(1, 0, 1, -42)

    local layout = Instance.new("UIListLayout")
    layout.Parent = holder
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- POPULATE LIST
    local function refreshList(filter)
        for _, child in ipairs(holder:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for _, item in ipairs(list) do
            if filter and filter ~= "" then
                if not string.find(string.lower(item), string.lower(filter)) then
                    continue
                end
            end

            local btn = Instance.new("TextButton")
            btn.Name = "item"
            btn.Parent = holder
            btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Position = UDim2.new(0, 5, 0, 0)
            btn.Font = Enum.Font.Gotham
            btn.Text = item
            btn.TextColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextSize = 16
            btn.AutoButtonColor = false

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = btn

            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            end)

            btn.MouseButton1Click:Connect(function()
                value = item
                valueLabel.Text = item
                listFrame.Visible = false
                listFrame.Size = UDim2.new(1, 0, 0, 0)
                if callback then callback(item) end
            end)
        end
    end

    refreshList()

    -- SEARCH UPDATE
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        refreshList(searchBox.Text)
    end)

    -- OPEN/CLOSE ANIMATION
    local TweenService = game:GetService("TweenService")
    local open = false

    local function toggleDropdown()
        open = not open

        if open then
            listFrame.Visible = true
            TweenService:Create(listFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, 200)
            }):Play()
        else
            TweenService:Create(listFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.wait(0.15)
            listFrame.Visible = false
        end
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDropdown()
        end
    end)

    -- API
    local api = {}

    function api:SetText(newText)
        label.Text = newText
    end

    function api:SetImage(newImage)
        if not iconImg then
            iconImg = Instance.new("ImageLabel")
            iconImg.Name = "icon"
            iconImg.Parent = frame
            iconImg.BackgroundTransparency = 1
            iconImg.Size = UDim2.new(0, 22, 0, 22)
            iconImg.Position = UDim2.new(0, 5, 0.5, -11)
            iconImg.ImageColor3 = Color3.fromRGB(95, 95, 95)
        end
        iconImg.Image = "rbxassetid://" .. (ResolveIcon(newImage) or newImage)
    end

    function api:SetList(newList)
        list = newList
        refreshList()
    end

    function api:SetValue(newValue)
        value = newValue
        valueLabel.Text = newValue
        if callback then callback(newValue) end
    end

    return api
end

-- THEME ENGINE --------------------------------------------

local Themes = {
    Light = {
        Background = Color3.fromRGB(255, 255, 255),
        Foreground = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(21, 103, 251),
        Soft = Color3.fromRGB(245, 245, 245),
        Soft2 = Color3.fromRGB(230, 230, 230),
        Text = Color3.fromRGB(95, 95, 95),
        Shadow = 0.45
    },

    Dark = {
        Background = Color3.fromRGB(25, 25, 25),
        Foreground = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(21, 103, 251),
        Soft = Color3.fromRGB(40, 40, 40),
        Soft2 = Color3.fromRGB(60, 60, 60),
        Text = Color3.fromRGB(200, 200, 200),
        Shadow = 0.65
    }
}

local CurrentTheme = "Light"

local function ApplyThemeToObject(obj, theme)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        obj.TextColor3 = theme.Text
    end

    if obj:IsA("Frame") then
        if obj.Name == "main" or obj.Name == "workarea" then
            obj.BackgroundColor3 = theme.Background
        elseif obj.Name == "sidebar" or obj.Name == "sidebar2" then
            obj.BackgroundColor3 = theme.Background
        elseif obj.Name == "Line" then
            obj.BackgroundColor3 = theme.Soft2
        end
    end

    if obj:IsA("ImageLabel") then
        if obj.Name == "icon" then
            obj.ImageColor3 = theme.Text
        end
    end

    for _, child in ipairs(obj:GetChildren()) do
        ApplyThemeToObject(child, theme)
    end
end

function window:SetTheme(name)
    if not Themes[name] then return end
    CurrentTheme = name
    local theme = Themes[name]

    -- animate main window
    game:GetService("TweenService"):Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        BackgroundColor3 = theme.Background
    }):Play()

    -- apply theme to all UI
    ApplyThemeToObject(scrgui, theme)
end

function window:ToggleTheme()
    if CurrentTheme == "Light" then
        window:SetTheme("Dark")
    else
        window:SetTheme("Light")
    end
end

function window:Sheet(opts)
    opts = opts or {}
    local title = opts.Title or "Are you sure?"
    local text = opts.Text or ""
    local icon = opts.Icon
    local yes = opts.Yes or "OK"
    local no = opts.No or "Cancel"
    local callback = opts.Callback

    -- DARK OVERLAY
    local overlay = Instance.new("Frame")
    overlay.Name = "sheetOverlay"
    overlay.Parent = scrgui
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 200

    -- SHEET FRAME
    local sheet = Instance.new("Frame")
    sheet.Name = "sheet"
    sheet.Parent = overlay
    sheet.AnchorPoint = Vector2.new(0.5, 0)
    sheet.Position = UDim2.new(0.5, 0, 0, -200)
    sheet.Size = UDim2.new(0, 420, 0, 200)
    sheet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sheet.ZIndex = 201

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18)
    corner.Parent = sheet

    local stroke = Instance.new("UIStroke")
    stroke.Parent = sheet
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.6

    -- SHADOW
    local shadow = Instance.new("ImageLabel")
    shadow.Parent = sheet
    shadow.BackgroundTransparency = 1
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1.3, 0, 1.6, 0)
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageTransparency = 0.55
    shadow.ZIndex = 200

    -- ICON
    if icon then
        local ic = Instance.new("ImageLabel")
        ic.Parent = sheet
        ic.BackgroundTransparency = 1
        ic.Size = UDim2.new(0, 40, 0, 40)
        ic.Position = UDim2.new(0, 20, 0, 20)
        ic.Image = "rbxassetid://" .. (library.ResolveIcon(icon) or icon)
        ic.ImageColor3 = Color3.fromRGB(95, 95, 95)
        ic.ZIndex = 202
    end

    -- TITLE
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = sheet
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.TextSize = 24
    titleLabel.Position = UDim2.new(0, 20, 0, 20)
    titleLabel.Size = UDim2.new(1, -40, 0, 30)
    titleLabel.ZIndex = 202

    -- TEXT
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = sheet
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(95, 95, 95)
    textLabel.TextSize = 16
    textLabel.TextWrapped = true
    textLabel.Position = UDim2.new(0, 20, 0, 60)
    textLabel.Size = UDim2.new(1, -40, 0, 60)
    textLabel.ZIndex = 202

    -- BUTTONS
    local yesBtn = Instance.new("TextButton")
    yesBtn.Parent = sheet
    yesBtn.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    yesBtn.Size = UDim2.new(0, 180, 0, 40)
    yesBtn.Position = UDim2.new(0, 20, 1, -60)
    yesBtn.Font = Enum.Font.GothamMedium
    yesBtn.Text = yes
    yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesBtn.TextSize = 18
    yesBtn.ZIndex = 202

    local yesCorner = Instance.new("UICorner")
    yesCorner.CornerRadius = UDim.new(0, 10)
    yesCorner.Parent = yesBtn

    local noBtn = Instance.new("TextButton")
    noBtn.Parent = sheet
    noBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    noBtn.Size = UDim2.new(0, 180, 0, 40)
    noBtn.Position = UDim2.new(1, -200, 1, -60)
    noBtn.Font = Enum.Font.GothamMedium
    noBtn.Text = no
    noBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
    noBtn.TextSize = 18
    noBtn.ZIndex = 202

    local noCorner = Instance.new("UICorner")
    noCorner.CornerRadius = UDim.new(0, 10)
    noCorner.Parent = noBtn

    -- ANIMATION
    local TweenService = game:GetService("TweenService")

    TweenService:Create(overlay, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.4
    }):Play()

    TweenService:Create(sheet, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0.5, 0, 0, 40)
    }):Play()

    -- BUTTON LOGIC
    local function close(result)
        TweenService:Create(overlay, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        }):Play()

        TweenService:Create(sheet, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0.5, 0, 0, -200)
        }):Play()

        task.wait(0.25)
        overlay:Destroy()

        if callback then callback(result) end
    end

    yesBtn.MouseButton1Click:Connect(function()
        close(true)
    end)

    noBtn.MouseButton1Click:Connect(function()
        close(false)
    end)
end

-- TOAST QUEUE SYSTEM (macOS Sonoma Style)
local ToastQueue = {}
local ToastActive = false

function window:Toast(opts)
    opts = opts or {}
    local text = opts.Text or "Notification"
    local icon = opts.Icon
    local duration = opts.Duration or 3
    local callback = opts.Callback

    table.insert(ToastQueue, {
        Text = text,
        Icon = icon,
        Duration = duration,
        Callback = callback
    })

    if not ToastActive then
        ToastActive = true

        while #ToastQueue > 0 do
            local data = table.remove(ToastQueue, 1)

            local toast = Instance.new("Frame")
            toast.Name = "sonomaToast"
            toast.Parent = scrgui
            toast.AnchorPoint = Vector2.new(1, 0)
            toast.Position = UDim2.new(1, -20, 0, -80)
            toast.Size = UDim2.new(0, 300, 0, 50)
            toast.BackgroundTransparency = 1
            toast.ZIndex = 300

            local blur = Instance.new("Frame")
            blur.Parent = toast
            blur.Size = UDim2.new(1, 0, 1, 0)
            blur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            blur.BackgroundTransparency = 0.25

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 12)
            corner.Parent = blur

            local stroke = Instance.new("UIStroke")
            stroke.Parent = blur
            stroke.Color = Color3.fromRGB(255, 255, 255)
            stroke.Transparency = 0.6

            local shadow = Instance.new("ImageLabel")
            shadow.Parent = toast
            shadow.BackgroundTransparency = 1
            shadow.AnchorPoint = Vector2.new(0.5, 0.5)
            shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
            shadow.Size = UDim2.new(1.3, 0, 1.6, 0)
            shadow.Image = "rbxassetid://6014261993"
            shadow.ImageTransparency = 0.45
            shadow.ZIndex = 299

            if data.Icon then
                local ic = Instance.new("ImageLabel")
                ic.Parent = toast
                ic.BackgroundTransparency = 1
                ic.Size = UDim2.new(0, 24, 0, 24)
                ic.Position = UDim2.new(0, 12, 0.5, -12)
                ic.Image = "rbxassetid://" .. (ResolveIcon(data.Icon) or data.Icon)
                ic.ImageColor3 = Color3.fromRGB(255, 255, 255)
                ic.ZIndex = 301
            end

            local label = Instance.new("TextLabel")
            label.Parent = toast
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.Gotham
            label.Text = data.Text
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Position = data.Icon and UDim2.new(0, 45, 0, 0) or UDim2.new(0, 12, 0, 0)
            label.Size = UDim2.new(1, -60, 1, 0)
            label.ZIndex = 301

            local TweenService = game:GetService("TweenService")

            toast.Position = UDim2.new(1, 40, 0, 20)
            toast.BackgroundTransparency = 1

            TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                Position = UDim2.new(1, -20, 0, 20),
                BackgroundTransparency = 0
            }):Play()

            local clicked = false
            toast.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    clicked = true
                    if data.Callback then data.Callback() end
                end
            end)

            task.wait(data.Duration)

            TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                Position = UDim2.new(1, 40, 0, 20),
                BackgroundTransparency = 1
            }):Play()

            task.wait(0.25)
            toast:Destroy()
        end

        ToastActive = false
    end
end

-- PERFORMANCE ENGINE ----------------------------------------------------

local Perf = {
    RecyclePool = {},
    Throttle = {},
    ActiveSection = nil
}

-- RECYCLE UI OBJECTS INSTEAD OF DESTROYING
function Perf:Get(typeName)
    if not self.RecyclePool[typeName] then
        self.RecyclePool[typeName] = {}
    end

    local pool = self.RecyclePool[typeName]
    if #pool > 0 then
        local obj = table.remove(pool)
        obj.Visible = true
        return obj
    end

    return Instance.new(typeName)
end

function Perf:Recycle(obj)
    obj.Visible = false
    obj.Parent = nil

    local typeName = obj.ClassName
    if not self.RecyclePool[typeName] then
        self.RecyclePool[typeName] = {}
    end

    table.insert(self.RecyclePool[typeName], obj)
end

-- THROTTLE EXPENSIVE FUNCTIONS
function Perf:ThrottleKey(key, delay)
    local now = tick()
    if not self.Throttle[key] or now - self.Throttle[key] >= delay then
        self.Throttle[key] = now
        return true
    end
    return false
end

-- LAZY RENDERING FOR SECTIONS
function Perf:SetActiveSection(sec)
    if Perf.ActiveSection == sec then return end

    if Perf.ActiveSection then
        Perf.ActiveSection.workarea.Visible = false
    end

    Perf.ActiveSection = sec
    sec.workarea.Visible = true
end

-- OPTIMIZE SCROLLING
function Perf:OptimizeScrolling(scrollFrame)
    local UIS = game:GetService("UserInputService")
    local scrolling = false

    scrollFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            scrolling = true
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            scrolling = false
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if scrolling then
            scrollFrame.CanvasSize = scrollFrame.CanvasSize -- no expensive layout updates
        end
    end)
end

-- CLEANUP UNUSED UI
function Perf:Cleanup()
    for typeName, pool in pairs(self.RecyclePool) do
        for i = #pool, 1, -1 do
            local obj = pool[i]
            if obj.Parent ~= nil then
                table.remove(pool, i)
            end
        end
    end
end

-- EXPOSE TO WINDOW
window.Perf = Perf

-- SPOTLIGHT COMMAND PALETTE --------------------------------------------

local Spotlight = {}
local SpotlightOpen = false
local SpotlightResults = {}
local SpotlightIndex = 1

function window:EnableSpotlight(keybind)
    keybind = keybind or Enum.KeyCode.F

    local UIS = game:GetService("UserInputService")

    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == keybind then
            Spotlight:Toggle()
        end
    end)
end

-- BUILD SPOTLIGHT UI
function Spotlight:Init()
    if self.UI then return end

    self.UI = Instance.new("Frame")
    self.UI.Name = "Spotlight"
    self.UI.Parent = scrgui
    self.UI.AnchorPoint = Vector2.new(0.5, 0)
    self.UI.Position = UDim2.new(0.5, 0, 0, -100)
    self.UI.Size = UDim2.new(0, 500, 0, 300)
    self.UI.BackgroundTransparency = 1
    self.UI.ZIndex = 500
    self.UI.Visible = false

    local bg = Instance.new("Frame")
    bg.Parent = self.UI
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    bg.BackgroundTransparency = 0.15
    bg.ZIndex = 501

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = bg

    local stroke = Instance.new("UIStroke")
    stroke.Parent = bg
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.6

    -- SEARCH BOX
    self.Box = Instance.new("TextBox")
    self.Box.Parent = bg
    self.Box.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    self.Box.BorderSizePixel = 0
    self.Box.Size = UDim2.new(1, -20, 0, 40)
    self.Box.Position = UDim2.new(0, 10, 0, 10)
    self.Box.Font = Enum.Font.Gotham
    self.Box.PlaceholderText = "Search..."
    self.Box.Text = ""
    self.Box.TextColor3 = Color3.fromRGB(40, 40, 40)
    self.Box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    self.Box.TextSize = 18
    self.Box.ZIndex = 502

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 10)
    boxCorner.Parent = self.Box

    -- RESULTS HOLDER
    self.Holder = Instance.new("Frame")
    self.Holder.Parent = bg
    self.Holder.BackgroundTransparency = 1
    self.Holder.Position = UDim2.new(0, 0, 0, 60)
    self.Holder.Size = UDim2.new(1, 0, 1, -70)
    self.Holder.ZIndex = 502

    local layout = Instance.new("UIListLayout")
    layout.Parent = self.Holder
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- INPUT EVENTS
    self.Box:GetPropertyChangedSignal("Text"):Connect(function()
        Spotlight:Search(self.Box.Text)
    end)

    local UIS = game:GetService("UserInputService")

    UIS.InputBegan:Connect(function(input)
        if not SpotlightOpen then return end

        if input.KeyCode == Enum.KeyCode.Down then
            SpotlightIndex = math.clamp(SpotlightIndex + 1, 1, #SpotlightResults)
            Spotlight:Highlight()
        elseif input.KeyCode == Enum.KeyCode.Up then
            SpotlightIndex = math.clamp(SpotlightIndex - 1, 1, #SpotlightResults)
            Spotlight:Highlight()
        elseif input.KeyCode == Enum.KeyCode.Return then
            Spotlight:Activate()
        elseif input.KeyCode == Enum.KeyCode.Escape then
            Spotlight:Toggle()
        end
    end)
end

-- OPEN/CLOSE
function Spotlight:Toggle()
    self:Init()

    SpotlightOpen = not SpotlightOpen

    if SpotlightOpen then
        self.UI.Visible = true
        self.UI.Position = UDim2.new(0.5, 0, 0, -100)
        self.UI.BackgroundTransparency = 1

        game:GetService("TweenService"):Create(self.UI, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0.5, 0, 0, 20),
            BackgroundTransparency = 0
        }):Play()

        self.Box:CaptureFocus()
        self.Box.Text = ""
        Spotlight:Search("")
    else
        game:GetService("TweenService"):Create(self.UI, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0.5, 0, 0, -100),
            BackgroundTransparency = 1
        }):Play()

        task.wait(0.25)
        self.UI.Visible = false
    end
end

-- SEARCH LOGIC
function Spotlight:Search(query)
    for _, child in ipairs(self.Holder:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    SpotlightResults = {}
    SpotlightIndex = 1

    query = string.lower(query)

    -- SEARCH SECTIONS + ELEMENTS
    for _, sec in ipairs(sections) do
        local secName = string.lower(sec.Text)
        if string.find(secName, query) then
            table.insert(SpotlightResults, {
                Type = "Section",
                Name = sec.Text,
                Icon = sec:FindFirstChild("icon") and sec.icon.Image,
                Action = function()
                    sec:Activate()
                end
            })
        end
    end

    -- BUILD RESULTS
    for i, result in ipairs(SpotlightResults) do
        local btn = Instance.new("TextButton")
        btn.Parent = self.Holder
        btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, 0)
        btn.Font = Enum.Font.Gotham
        btn.Text = result.Name
        btn.TextColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextSize = 16
        btn.AutoButtonColor = false
        btn.ZIndex = 503

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            SpotlightIndex = i
            Spotlight:Activate()
        end)
    end

    Spotlight:Highlight()
end

-- HIGHLIGHT CURRENT RESULT
function Spotlight:Highlight()
    for i, child in ipairs(self.Holder:GetChildren()) do
        if child:IsA("TextButton") then
            if i == SpotlightIndex then
                child.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            else
                child.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            end
        end
    end
end

-- ACTIVATE SELECTED RESULT
function Spotlight:Activate()
    local result = SpotlightResults[SpotlightIndex]
    if not result then return end

    Spotlight:Toggle()
    result.Action()
end

window.Spotlight = Spotlight

-- CONTEXT MENU SYSTEM ---------------------------------------------------

local ContextMenu = {}

function window:ContextMenu(options)
    -- options = { {Text="Copy", Icon="copy", Callback=function() end}, ... }

    if ContextMenu.UI then
        ContextMenu.UI:Destroy()
    end

    local mouse = game:GetService("UserInputService"):GetMouseLocation()

    local menu = Instance.new("Frame")
    menu.Name = "ContextMenu"
    menu.Parent = scrgui
    menu.Position = UDim2.fromOffset(mouse.X, mouse.Y)
    menu.Size = UDim2.new(0, 180, 0, #options * 36)
    menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    menu.BackgroundTransparency = 0
    menu.ZIndex = 600

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = menu

    local stroke = Instance.new("UIStroke")
    stroke.Parent = menu
    stroke.Color = Color3.fromRGB(200, 200, 200)
    stroke.Thickness = 1

    local layout = Instance.new("UIListLayout")
    layout.Parent = menu
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, opt in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Parent = menu
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.Gotham
        btn.Text = "   " .. opt.Text
        btn.TextColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextSize = 16
        btn.ZIndex = 601
        btn.AutoButtonColor = false
        btn.TextXAlignment = Enum.TextXAlignment.Left

        local corner2 = Instance.new("UICorner")
        corner2.CornerRadius = UDim.new(0, 8)
        corner2.Parent = btn

        if opt.Icon then
            local ic = Instance.new("ImageLabel")
            ic.Parent = btn
            ic.BackgroundTransparency = 1
            ic.Size = UDim2.new(0, 20, 0, 20)
            ic.Position = UDim2.new(0, 8, 0.5, -10)
            ic.Image = "rbxassetid://" .. (ResolveIcon(opt.Icon) or opt.Icon)
            ic.ImageColor3 = Color3.fromRGB(95, 95, 95)
            ic.ZIndex = 602
        end

        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end)

        btn.MouseButton1Click:Connect(function()
            if opt.Callback then opt.Callback() end
            menu:Destroy()
        end)
    end

    ContextMenu.UI = menu

    -- Close when clicking outside
    task.spawn(function()
        local UIS = game:GetService("UserInputService")
        UIS.InputBegan:Wait()
        if ContextMenu.UI then
            ContextMenu.UI:Destroy()
        end
    end)
end

return window   -- return the window API
end             -- closes lib:init()

return lib      -- return the library module


