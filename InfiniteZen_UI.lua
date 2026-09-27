-- ============================================================
-- INFINITE ZEN - UI LIBRARY
-- ============================================================

local UI = {}

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- CREATE WINDOW
-- ============================================================

function UI.CreateWindow(options)
    options = options or {}

    local title = options.Title or "Infinite Zen"

    local old = PlayerGui:FindFirstChild("InfiniteZen")
    if old then
        old:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "InfiniteZen"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = false
    gui.Parent = PlayerGui

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.fromOffset(500, 350)
    main.Position = UDim2.new(0.5, -250, 0.5, -175)
    main.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
    main.BorderSizePixel = 0
    main.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = main

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(90, 80, 255)
    stroke.Thickness = 1
    stroke.Parent = main

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -40, 0, 50)
    titleLabel.Position = UDim2.fromOffset(20, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = main

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -40, 1, -70)
    content.Position = UDim2.fromOffset(20, 55)
    content.BackgroundTransparency = 1
    content.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = content

    local window = {}

    window.Gui = gui
    window.Main = main
    window.Content = content

    function window:AddLabel(text)
        local label = Instance.new("TextLabel")

        label.Size = UDim2.new(1, 0, 0, 32)
        label.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
        label.BorderSizePixel = 0

        label.Text = tostring(text)
        label.TextColor3 = Color3.fromRGB(220, 220, 230)
        label.TextSize = 14
        label.Font = Enum.Font.Gotham

        label.Parent = content

        local labelCorner = Instance.new("UICorner")
        labelCorner.CornerRadius = UDim.new(0, 6)
        labelCorner.Parent = label

        return label
    end

    function window:AddButton(text, callback)
        local button = Instance.new("TextButton")

        button.Size = UDim2.new(1, 0, 0, 36)
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        button.BorderSizePixel = 0

        button.Text = tostring(text)
        button.TextColor3 = Color3.fromRGB(240, 240, 255)
        button.TextSize = 14
        button.Font = Enum.Font.GothamMedium

        button.AutoButtonColor = true
        button.Parent = content

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button

        button.MouseButton1Click:Connect(function()
            if callback then
                local success, err = pcall(callback)

                if not success then
                    warn("[Infinite Zen UI] Button error:", err)
                end
            end
        end)

        return button
    end

    function window:Destroy()
        if gui then
            gui:Destroy()
        end
    end

    return window
end

return UI
