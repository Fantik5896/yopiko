local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Yopiko Hub [AUT]", 5013109572)

-- themes
local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(0, 0, 0),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}

-- first page
local character = venyx:addPage("Character", 5012544693)
local teleports = venyx:addPage("Teleports", 5012544693)
local esppage = venyx:addPage("ESP", 5012544693)
local wsjp = character:addSection("WalkSpeed & JumpPower")
local other = character:addSection("Other")
local npctps = teleports:addSection("NPC Teleports")
local esp = esppage:addSection("ESP")

wsjp:addSlider("WalkSpeed", 28, 0, 750, function(value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

wsjp:addSlider("JumpPower", 50, 0, 1000, function(value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

wsjp:addButton("WalkSpeed & JumpPower to normal", function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 28
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end)

--section1:addToggle("Toggle", nil, function(value)
--print("Toggled", value)
--end)

other:addKeybind("Key = TP", Enum.KeyCode.LeftControl, function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer:GetMouse().Hit
end, function()
print("Changed Keybind")
end)

npclist = {}

for i,v in pairs(game.Workspace.NPCS:GetChildren()) do
   table.insert(npclist, v.Name)
end

npctps:addDropdown("NPC Teleport", npclist, function(text)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.NPCS[text].HumanoidRootPart.CFrame
end)

esp:addToggle("Player ESP", nil, function(value)
    if value == true then
        for i,v in pairs(game.Players:GetChildren()) do
            local hl = Instance.new("Highlight", v.Character)
            hl.OutlineColor = Color3.fromRGB(0, 0, 0)
            hl.OutlineTransparency = 0
        end
    else
        for i,v in pairs(game:GetService("Workspace").Living:GetDescendants()) do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end
    end
end)

esp:addToggle("Chest ESP", nil, function(value)
    if value == true then
        for i,v in pairs(game.Workspace.ItemSpawns.Chests:GetChildren()) do
            if v:FindFirstChild("Chest") then
                local hl = Instance.new("Highlight", v.Chest)
                hl.FillColor = Color3.fromRGB(75, 150, 255)
                hl.FillTransparency = 0.1
                hl.OutlineTransparency = 1
                --local bg = Instance.new("BillboardGui", v.Chest.HEad)
                --bg.Adornee = v.Chest
                --bg.Active = true
                --bg.Size = UDim2.new(6, 0, 3, 0)
                --bg.AlwaysOnTop = true
                --local button = Instance.new("TextButton", bg)
                --button.Active = true
                --button.Size = UDim2.new(1, 0, 1, 0)
                --button.Font = Enum.Font.GothamBold
                --button.Text = "Chest \n<Click to tp>"
                --button.TextColor3 = Color3.fromRGB(255, 255, 255)
                --button.BackgroundTransparency = 1
                --button.TextScaled = true
                --button.TextWrapped = true
                --.MouseButton1Click:Connect(function()
                    --print('smh')
                    --game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = button.Parent.Parent.CFrame
                --end)
            end
        end
    else
        for i,v in pairs(game.Workspace.ItemSpawns.Chests:GetDescendants()) do
            if v:IsA("Highlight") or v:IsA("BillboardGui") then
                v:Destroy()
            end
        end
    end
end)

esp:addToggle("Meteor ESP", nil, function(value)
    if value == true then
        for i,v in pairs(game.Workspace.ItemSpawns.Meteors:GetChildren()) do
            if v:FindFirstChild("Meteor") then
                local hl = Instance.new("Highlight", v.Meteor)
                hl.FillColor = Color3.fromRGB(255, 255, 0)
                hl.FillTransparency = 0.15
                hl.OutlineTransparency = 1
            end
        end
    else
        for i,v in pairs(game.Workspace.ItemSpawns.Meteors:GetDescendants()) do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end
    end
end)

esp:addToggle("Item ESP", nil, function(value)
    if value == true then
        for i,v in pairs(game.Workspace.ItemSpawns.StandardItems:GetChildren()) do
            if #v:GetChildren() > 0 then
                local hl = Instance.new("Highlight", v:GetChildren()[1])
                hl.FillColor = Color3.fromRGB(0, 255, 0)
                hl.FillTransparency = 0.1
                hl.OutlineTransparency = 1
            end
        end
    else
        for i,v in pairs(game.Workspace.ItemSpawns.StandardItems:GetDescendants()) do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end
    end
end)
--section2:addColorPicker("ColorPicker", Color3.fromRGB(50, 50, 50))
--section2:addColorPicker("ColorPicker2")
--section2:addDropdown("Dropdown", {"Hello", "World", "Hello World", "Word", 1, 2, 3})

--section2:addButton("Button")

-- second page
--local theme = venyx:addPage("Theme", 5012544693)
--local colors = theme:addSection("Colors")

--for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
--colors:addColorPicker(theme, color, function(color3)
--venyx:setTheme(theme, color3)
--end)
--end
game:GetService("UserInputService").InputBegan:Connect(function(input, isChat)
    if isChat == false then
        if input.KeyCode == Enum.KeyCode.RightControl then
            venyx:toggle()
        end
    end
end)
-- load
venyx:SelectPage(venyx.pages[1], true)
