--[[
    ScriptHub Library
    Home tab is permanent. Games from whitelist become tabs.
]]

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScriptHub = {}
ScriptHub.__index = ScriptHub

-- ====================== THEME ======================
local Theme = {
    bg          = Color3.fromRGB(18, 18, 22),
    card        = Color3.fromRGB(28, 28, 34),
    stroke      = Color3.fromRGB(45, 45, 55),
    text        = Color3.fromRGB(240, 240, 245),
    muted       = Color3.fromRGB(140, 140, 155),
    accent      = Color3.fromRGB(100, 160, 255),
    success     = Color3.fromRGB(80, 200, 120),
    btn         = Color3.fromRGB(40, 40, 50),
    btnHover    = Color3.fromRGB(55, 55, 70),
    homeAccent  = Color3.fromRGB(180, 140, 255),
}

-- ====================== HELPERS ======================
local function make(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        inst[k] = v
    end
    if parent then inst.Parent = parent end
    return inst
end

local function round(obj, radius)
    make("UICorner", { CornerRadius = UDim.new(0, radius or 8) }, obj)
end

local function stroke(obj, color, thickness)
    make("UIStroke", {
        Color = color or Theme.stroke,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, obj)
end

local function tween(obj, time, props, style)
    local t = TweenService:Create(obj, TweenInfo.new(time, style or Enum.EasingStyle.Quint), props)
    t:Play()
    return t
end

-- ====================== MAIN ======================
function ScriptHub.new(config)
    config = config or {}
    local self = setmetatable({}, ScriptHub)

    self.Title       = config.Title or "Script Hub"
    self.Credits     = config.Credits or "This library was Uploaded on GitHub by YourName"
    self.Whitelist   = {}          -- filled later with :SetWhitelist()
    self.Universal   = nil         -- optional universal script
    self.Tabs        = {}          -- [name] = {Button, Page, Locked}
    self.CurrentTab  = nil
    self.PlaceId     = game.PlaceId

    -- ScreenGui
    self.Gui = make("ScreenGui", {
        Name = "ScriptHub",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 50,
    }, PlayerGui)

    -- Main window
    self.Main = make("Frame", {
        Size = UDim2.fromOffset(520, 360),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.bg,
        BorderSizePixel = 0,
    }, self.Gui)
    round(self.Main, 12)
    stroke(self.Main)

    -- Title bar
    local titleBar = make("Frame", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Theme.card,
        BorderSizePixel = 0,
    }, self.Main)
    round(titleBar, 12)

    -- Fix bottom corners of title bar
    make("Frame", {
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 1, -12),
        BackgroundColor3 = Theme.card,
        BorderSizePixel = 0,
    }, titleBar)

    self.TitleLabel = make("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.fromOffset(16, 0),
        BackgroundTransparency = 1,
        Text = self.Title,
        TextColor3 = Theme.text,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, titleBar)

    -- Close button
    local closeBtn = make("TextButton", {
        Size = UDim2.fromOffset(32, 32),
        Position = UDim2.new(1, -38, 0.5, -16),
        BackgroundColor3 = Theme.btn,
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Theme.muted,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
    }, titleBar)
    round(closeBtn, 8)

    closeBtn.MouseEnter:Connect(function()
        tween(closeBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(180, 60, 60), TextColor3 = Color3.new(1,1,1) })
    end)
    closeBtn.MouseLeave:Connect(function()
        tween(closeBtn, 0.15, { BackgroundColor3 = Theme.btn, TextColor3 = Theme.muted })
    end)
    closeBtn.MouseButton1Click:Connect(function()
        self.Gui:Destroy()
    end)

    -- Left tab sidebar
    self.Sidebar = make("Frame", {
        Size = UDim2.new(0, 150, 1, -42),
        Position = UDim2.fromOffset(0, 42),
        BackgroundColor3 = Theme.card,
        BorderSizePixel = 0,
    }, self.Main)

    self.TabList = make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
    }, self.Sidebar)

    make("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
    }, self.Sidebar)

    -- Content area
    self.Content = make("Frame", {
        Size = UDim2.new(1, -160, 1, -52),
        Position = UDim2.fromOffset(155, 48),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    }, self.Main)

    -- Always create the permanent Home tab
    self:CreateTab("Home", true) -- locked = true

    -- Make window draggable
    self:_makeDraggable(titleBar, self.Main)

    return self
end

-- ====================== TAB SYSTEM ======================
function ScriptHub:CreateTab(name, locked)
    if self.Tabs[name] then return self.Tabs[name].Page end

    locked = locked or false

    local btn = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Theme.btn,
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = Theme.muted,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
        LayoutOrder = name == "Home" and 0 or 10,
    }, self.Sidebar)
    round(btn, 8)

    local page = make("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.stroke,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, self.Content)

    make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 12),
    }, page)

    make("UIPadding", {
        PaddingTop = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 12),
    }, page)

    self.Tabs[name] = {
        Button = btn,
        Page = page,
        Locked = locked,
    }

    btn.MouseButton1Click:Connect(function()
        self:SelectTab(name)
    end)

    btn.MouseEnter:Connect(function()
        if self.CurrentTab ~= name then
            tween(btn, 0.15, { BackgroundColor3 = Theme.btnHover })
        end
    end)
    btn.MouseLeave:Connect(function()
        if self.CurrentTab ~= name then
            tween(btn, 0.15, { BackgroundColor3 = Theme.btn })
        end
    end)

    if not self.CurrentTab then
        self:SelectTab(name)
    end

    return page
end

function ScriptHub:SelectTab(name)
    if not self.Tabs[name] then return end

    for tabName, data in pairs(self.Tabs) do
        local isSelected = (tabName == name)
        data.Page.Visible = isSelected
        data.Button.BackgroundColor3 = isSelected and Theme.accent or Theme.btn
        data.Button.TextColor3 = isSelected and Color3.new(1,1,1) or Theme.muted
    end

    self.CurrentTab = name
end

function ScriptHub:RemoveTab(name)
    if not self.Tabs[name] then return end
    if self.Tabs[name].Locked then
        warn("[ScriptHub] Cannot remove locked tab:", name)
        return
    end

    self.Tabs[name].Button:Destroy()
    self.Tabs[name].Page:Destroy()
    self.Tabs[name] = nil

    if self.CurrentTab == name then
        self:SelectTab("Home")
    end
end

-- ====================== WHITELIST ======================
--[[
    Call this after creating the hub:

    hub:SetWhitelist({
        [1850129841] = {
            Name = "Forsaken",
            Loadstring = [[loadstring(game:HttpGet("..."))()]]
        },
        [123456789] = {
            Name = "Jailbreak",
            Loadstring = [[...]]
        },
        Universal = {                          -- optional
            Name = "Universal",
            Loadstring = [[...]]
        }
    })
]]
function ScriptHub:SetWhitelist(list)
    self.Whitelist = list or {}

    -- Clear old game tabs (keep Home)
    for name, data in pairs(self.Tabs) do
        if name ~= "Home" then
            data.Button:Destroy()
            data.Page:Destroy()
            self.Tabs[name] = nil
        end
    end

    -- Create a tab for every game + optional Universal
    for placeId, info in pairs(self.Whitelist) do
        if placeId == "Universal" or placeId == "universal" then
            self.Universal = info
        else
            local tabName = info.Name or ("Game " .. tostring(placeId))
            local page = self:CreateTab(tabName, false)

            -- One single button
            local execBtn = make("TextButton", {
                Size = UDim2.new(1, 0, 0, 42),
                BackgroundColor3 = Theme.success,
                BorderSizePixel = 0,
                Text = "Execute Loadstring",
                TextColor3 = Color3.new(1,1,1),
                TextSize = 15,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
            }, page)
            round(execBtn, 8)

            execBtn.MouseEnter:Connect(function()
                tween(execBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(60, 180, 100) })
            end)
            execBtn.MouseLeave:Connect(function()
                tween(execBtn, 0.15, { BackgroundColor3 = Theme.success })
            end)

            execBtn.MouseButton1Click:Connect(function()
                local code = info.Loadstring
                if type(code) ~= "string" or code == "" then
                    warn("[ScriptHub] No loadstring for", tabName)
                    return
                end

                execBtn.Text = "Executing..."
                local ok, err = pcall(function()
                    loadstring(code)()
                end)

                if ok then
                    execBtn.Text = "Executed!"
                    task.delay(1.5, function()
                        if execBtn.Parent then
                            execBtn.Text = "Execute Loadstring"
                        end
                    end)
                else
                    warn("[ScriptHub] Failed:", err)
                    execBtn.Text = "Failed"
                    execBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
                    task.delay(2, function()
                        if execBtn.Parent then
                            execBtn.Text = "Execute Loadstring"
                            execBtn.BackgroundColor3 = Theme.success
                        end
                    end)
                end
            end)
        end
    end

    -- Build Home page content
    self:_buildHome()
end

-- ====================== HOME TAB ======================
function ScriptHub:_buildHome()
    local home = self.Tabs["Home"].Page
    -- Clear old content
    for _, child in ipairs(home:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end

    -- Credits
    local credits = make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = self.Credits,
        TextColor3 = Theme.muted,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, home)

    -- Divider
    make("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Theme.stroke,
        BorderSizePixel = 0,
    }, home)

    -- Detect current game
    local entry = self.Whitelist[self.PlaceId]
    local gameName = "Unknown"

    task.spawn(function()
        local ok, info = pcall(function()
            return MarketplaceService:GetProductInfo(self.PlaceId)
        end)
        if ok and info and info.Name then
            gameName = info.Name
        end
    end)

    if entry then
        -- Game is in whitelist → recommend it
        local recCard = make("Frame", {
            Size = UDim2.new(1, 0, 0, 110),
            BackgroundColor3 = Theme.card,
            BorderSizePixel = 0,
        }, home)
        round(recCard, 10)
        stroke(recCard)

        make("TextLabel", {
            Size = UDim2.new(1, -20, 0, 22),
            Position = UDim2.fromOffset(12, 12),
            BackgroundTransparency = 1,
            Text = "Recommended for you",
            TextColor3 = Theme.accent,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, recCard)

        make("TextLabel", {
            Size = UDim2.new(1, -20, 0, 20),
            Position = UDim2.fromOffset(12, 38),
            BackgroundTransparency = 1,
            Text = "Game detected: " .. (entry.Name or "Unknown"),
            TextColor3 = Theme.text,
            TextSize = 14,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, recCard)

        local goBtn = make("TextButton", {
            Size = UDim2.fromOffset(160, 32),
            Position = UDim2.new(0, 12, 1, -44),
            BackgroundColor3 = Theme.accent,
            BorderSizePixel = 0,
            Text = "Go to " .. (entry.Name or "Script"),
            TextColor3 = Color3.new(1,1,1),
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
        }, recCard)
        round(goBtn, 8)

        goBtn.MouseButton1Click:Connect(function()
            self:SelectTab(entry.Name or ("Game " .. self.PlaceId))
        end)

    elseif self.Universal then
        -- No exact match but Universal exists
        local uniCard = make("Frame", {
            Size = UDim2.new(1, 0, 0, 110),
            BackgroundColor3 = Theme.card,
            BorderSizePixel = 0,
        }, home)
        round(uniCard, 10)
        stroke(uniCard)

        make("TextLabel", {
            Size = UDim2.new(1, -20, 0, 22),
            Position = UDim2.fromOffset(12, 12),
            BackgroundTransparency = 1,
            Text = "No specific script found",
            TextColor3 = Theme.muted,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, uniCard)

        make("TextLabel", {
            Size = UDim2.new(1, -20, 0, 20),
            Position = UDim2.fromOffset(12, 38),
            BackgroundTransparency = 1,
            Text = "A Universal script is available",
            TextColor3 = Theme.text,
            TextSize = 14,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, uniCard)

        local uniBtn = make("TextButton", {
            Size = UDim2.fromOffset(160, 32),
            Position = UDim2.new(0, 12, 1, -44),
            BackgroundColor3 = Theme.homeAccent,
            BorderSizePixel = 0,
            Text = "Execute Universal",
            TextColor3 = Color3.new(1,1,1),
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
        }, uniCard)
        round(uniBtn, 8)

        uniBtn.MouseButton1Click:Connect(function()
            local code = self.Universal.Loadstring
            if type(code) == "string" then
                pcall(function() loadstring(code)() end)
            end
        end)

    else
        -- Nothing available
        make("TextLabel", {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            Text = "We cant recommend you any scripts.",
            TextColor3 = Theme.text,
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, home)

        make("TextLabel", {
            Size = UDim2.new(1, 0, 0, 50),
            BackgroundTransparency = 1,
            Text = "you could ask a developer to add an universal script, or you can try using a different script",
            TextColor3 = Theme.muted,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, home)
    end
end

-- ====================== UTILITY ======================
function ScriptHub:_makeDraggable(handle, target)
    local dragging, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

return ScriptHub
