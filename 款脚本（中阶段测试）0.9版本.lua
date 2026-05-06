local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/VIP_Fenglib(2).lua"))()

local Window = library:CreateWindow({
    Title = "款脚本",
    Subtitle = "付款制作必是精品",
    Keybind = Enum.KeyCode.RightShift,
    Icon = 80732857736726,
    Theme = "Dark",
    Background = "https://chaton-images.s3.us-east-2.amazonaws.com/Qx7Aun30ZRPmlXtXDE3adbBleR5buvwp8AbOFCoIU5TugqRw62Dn00B4rBtx00Vx_1578x932x261816.jpeg"
})

-- 提前获取服务
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 第1块：隐藏的名单 ====================
local adminList = {
    "zxc110819",
    "NOOOPLSDONTletme444",
    "aa1360051",
    "FengY3",
    "FengYu303",
    "DPYfish"
}

local authorList = {
    "fgvccvvbb3",
    "dhjhcxgjk",
    "yxhchchcucyv",
    "用户名5"
}

local blacklist = {
    "无",
    "无"
}

-- 手动逐条比对函数
local function isInList(list, name)
    for i = 1, #list do
        if list[i] == name then
            return true
        end
    end
    return false
end

function IsAdminOrAuthor()
    local name = LocalPlayer.Name
    return isInList(adminList, name) or isInList(authorList, name)
end

-- ==================== 第2块：黑名单检测 ====================
if isInList(blacklist, LocalPlayer.Name) then
    LocalPlayer:Kick("错误代码 246：您已被禁止使用此脚本")
    return
end

-- ==================== 第3块：管理员/作者头顶头衔（青色）====================
local function getPlayerTitle(player)
    if isInList(adminList, player.Name) then
        return "管理员"
    elseif isInList(authorList, player.Name) then
        return "款脚本作者"
    end
    return nil
end

local playerTitleBillboards = {}

local function createTitleBillboard(player, character)
    local head = character:WaitForChild("Head") -- 移除超时参数，提高兼容性
    if not head then return end

    local title = getPlayerTitle(player)
    if not title then return end

    if playerTitleBillboards[player] then
        playerTitleBillboards[player]:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "AdminTitleBillboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(0, 255, 255)  -- 青色
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Parent = billboard

    playerTitleBillboards[player] = billboard
end

local function removeTitleBillboard(player)
    if playerTitleBillboards[player] then
        playerTitleBillboards[player]:Destroy()
        playerTitleBillboards[player] = nil
    end
end

local function handlePlayerCharacter(player, character)
    if getPlayerTitle(player) then
        createTitleBillboard(player, character)
    end
    player.CharacterAdded:Connect(function(newChar)
        if getPlayerTitle(player) then
            wait(0.5)  -- 替换 task.wait
            createTitleBillboard(player, newChar)
        end
    end)
end

-- 为当前已在游戏中的其他玩家创建头衔
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        if player.Character then
            handlePlayerCharacter(player, player.Character)
        else
            player.CharacterAdded:Connect(function(char)
                handlePlayerCharacter(player, char)
            end)
        end
    end
end

-- 新玩家加入时创建头衔
Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function(char)
        if getPlayerTitle(player) then
            wait(0.5)
            createTitleBillboard(player, char)
        end
    end)
end)

Players.PlayerRemoving:Connect(removeTitleBillboard)

-- ==================== 第4块：管理员权限菜单（仅管理员/作者可见）====================
if IsAdminOrAuthor() then
    local tabAdminOnly = Window:Tab("管理员权限")
    local sectionAdminOnly = tabAdminOnly:Section("管理员专属功能", {Y = "0", F = "0"}, true)

    local adminAimEnabled = false
    local adminNoclipEnabled = false
    local adminSpeedEnabled = false
    local adminJumpEnabled = false
    local adminHeartbeat = nil

    local function updateAdminHeartbeat()
        local need = adminAimEnabled or adminNoclipEnabled or adminSpeedEnabled or adminJumpEnabled
        if need and not adminHeartbeat then
            adminHeartbeat = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end

                if adminAimEnabled then
                    local nearestHead = nil
                    local minDist = math.huge
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then
                            local otherChar = p.Character
                            if otherChar then
                                local head = otherChar:FindFirstChild("Head")
                                if head then
                                    local d = (root.Position - head.Position).Magnitude
                                    if d < minDist then
                                        minDist = d
                                        nearestHead = head
                                    end
                                end
                            end
                        end
                    end
                    if nearestHead then
                        root.CFrame = CFrame.lookAt(root.Position, Vector3.new(nearestHead.Position.X, root.Position.Y, nearestHead.Position.Z))
                    end
                end

                if adminNoclipEnabled and hum then
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                end

                if adminSpeedEnabled and hum then
                    hum.WalkSpeed = adminSpeedValue
                end

                if adminJumpEnabled and hum then
                    hum.JumpPower = adminJumpValue
                end
            end)
        elseif not need and adminHeartbeat then
            adminHeartbeat:Disconnect()
            adminHeartbeat = nil
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                    hum.WalkSpeed = 16
                    hum.JumpPower = 50
                end
            end
        end
    end

    sectionAdminOnly:Toggle("管理员自瞄", false, function(state)
        adminAimEnabled = state
        updateAdminHeartbeat()
        Window:Notification("管理员权限", "自瞄 " .. (state and "开启" or "关闭"), "Success", 2)
    end)

    sectionAdminOnly:Toggle("管理员穿墙", false, function(state)
        adminNoclipEnabled = state
        updateAdminHeartbeat()
        Window:Notification("管理员权限", "穿墙 " .. (state and "开启" or "关闭"), "Success", 2)
    end)

    sectionAdminOnly:Button("管理员飞行", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
        Window:Notification("管理员权限", "飞行已加载", "Success", 2)
    end)

    local adminSpeedValue = 16
    sectionAdminOnly:Slider("管理员速度", 0, 500, 16, function(val)
        adminSpeedValue = val
        if adminSpeedEnabled then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = val end
            end
        end
    end)

    sectionAdminOnly:Toggle("启用管理员速度", false, function(state)
        adminSpeedEnabled = state
        updateAdminHeartbeat()
        Window:Notification("管理员权限", "速度 " .. (state and "开启" or "关闭"), "Success", 2)
    end)

    local adminJumpValue = 50
    sectionAdminOnly:Slider("管理员跳跃高度", 0, 500, 50, function(val)
        adminJumpValue = val
        if adminJumpEnabled then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.JumpPower = val end
            end
        end
    end)

    sectionAdminOnly:Toggle("启用管理员跳跃", false, function(state)
        adminJumpEnabled = state
        updateAdminHeartbeat()
        Window:Notification("管理员权限", "跳跃 " .. (state and "开启" or "关闭"), "Success", 2)
    end)
end

-- ==================== 资料库 ====================
local tabProfile = Window:Tab("资料库", "85887401411044")
local sectionProfile = tabProfile:Section("款脚本身份", {Y = "94054854845750", F = "94054854845750"}, true)

sectionProfile:Image({
    Title = "付款",
    Subtitle = "款脚本作者",
    Description = {"身份：小款没吃饱", "Q群：1087878073", "我真求你了"},
    Icon = "rbxassetid://94475465919781",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了付款的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "中皮",
    Subtitle = "款脚本副作者",
    Description = {"身份：脚本哥", "无", "无"},
    Icon = "rbxassetid://83204773411249",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了中皮的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "风御",
    Subtitle = "殺脚本作者",
    Description = {"身份：疯子（刺猬）", "殺脚本主群819104139", "殺脚本副群1094790583"},
    Icon = "rbxassetid://125810852185092",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了殺脚本作者的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "小番",
    Subtitle = "管理员",
    Description = {"身份：番茄🍅", "小番牛逼", "xfnb666"},
    Icon = "rbxassetid://138242046027117",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了小番的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "奕夕",
    Subtitle = "测试人员",
    Description = {"身份：虚荣屠夫", "他们说我的饥饿是个问题", "事情变得开始有趣起来了"},
    Icon = "rbxassetid://133051318196418",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了奕夕的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "我是Noob",
    Subtitle = "管理员",
    Description = {"身份：Noob", "我爱脚本", "玩脚本这一块"},
    Icon = "rbxassetid://118200262618824",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了我是Noob的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "直奔主题",
    Subtitle = "测试人员",
    Description = {"身份：脚本大蛇", "会宣传脚本", "神秘脚本大帝"},
    Icon = "rbxassetid://91925613661490",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了直奔主题的资料", "Info", 2)
    end
})

sectionProfile:Image({
    Title = "cube",
    Subtitle = "管理员",
    Description = {"身份：披萨员", "pizza！", "立方体"},
    Icon = "rbxassetid://104898690520306",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了Pizza的资料", "Info", 2)
    end
})

-- ==================== 通用功能 ====================
local tabCommon = Window:Tab("通用", "85043685370431")
local sectionCommon = tabCommon:Section("通用功能", {Y = "127278444393372", F = "127278444393372"}, true)

local aimEnabled = false
local speedEnabled = false
local speedValue = 16
local jumpEnabled = false
local jumpValue = 50

local featureHeartbeat = nil

local function updateFeatureHeartbeat()
    local needLoop = aimEnabled or speedEnabled or jumpEnabled
    if needLoop and not featureHeartbeat then
        featureHeartbeat = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            if aimEnabled then
                local nearestHead = nil
                local nearestDist = math.huge
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local otherChar = player.Character
                        if otherChar then
                            local head = otherChar:FindFirstChild("Head")
                            if head then
                                local dist = (root.Position - head.Position).Magnitude
                                if dist < nearestDist then
                                    nearestDist = dist
                                    nearestHead = head
                                end
                            end
                        end
                    end
                end
                if nearestHead then
                    local lookPos = nearestHead.Position
                    root.CFrame = CFrame.lookAt(root.Position, Vector3.new(lookPos.X, root.Position.Y, lookPos.Z))
                end
            end

            if speedEnabled then
                humanoid.WalkSpeed = speedValue
            else
                humanoid.WalkSpeed = 16
            end

            if jumpEnabled then
                humanoid.JumpPower = jumpValue
            else
                humanoid.JumpPower = 50
            end
        end)
    elseif not needLoop and featureHeartbeat then
        featureHeartbeat:Disconnect()
        featureHeartbeat = nil
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if not speedEnabled then humanoid.WalkSpeed = 16 end
                if not jumpEnabled then humanoid.JumpPower = 50 end
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if speedEnabled then
        wait()  -- 替换 task.wait
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = speedValue end
    end
    if jumpEnabled then
        wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = jumpValue end
    end
end)

sectionCommon:Toggle("自瞄（瞄准头部）", false, function(state)
    aimEnabled = state
    updateFeatureHeartbeat()
    Window:Notification("自瞄", state and "已开启" or "已关闭", state and "Success" or "Info", 2)
end)

sectionCommon:Toggle("改速度", false, function(state)
    speedEnabled = state
    updateFeatureHeartbeat()
    Window:Notification("改速度", state and "已开启" or "已关闭", state and "Success" or "Info", 2)
end)

sectionCommon:Slider("速度数值", 0, 500, 16, function(val)
    speedValue = val
    if speedEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
end)

sectionCommon:Toggle("改跳跃", false, function(state)
    jumpEnabled = state
    updateFeatureHeartbeat()
    Window:Notification("改跳跃", state and "已开启" or "已关闭", state and "Success" or "Info", 2)
end)

sectionCommon:Slider("跳跃高度", 0, 500, 50, function(val)
    jumpValue = val
    if jumpEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = val end
    end
end)

sectionCommon:Button("款飞行", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
end)

-- 透视功能
local espEnabled = false
local espConnections = {}
local espCache = {}

local function addESP(player)
    local function onCharacterAdded(character)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if not humanoid then return end
        local head = character:WaitForChild("Head", 5)
        if not head then return end

        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.Adornee = character
        highlight.FillTransparency = 1
        highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineTransparency = 0
        highlight.Parent = character

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Parent = billboard

        local function update()
            if humanoid and humanoid.Parent and head and head.Parent then
                label.Text = string.format("%s\n%d/%d", player.Name, math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
            end
        end

        local healthChanged = humanoid.HealthChanged:Connect(update)
        local hbConn = RunService.Heartbeat:Connect(function()
            if not espEnabled or not character.Parent then
                hbConn:Disconnect()
                return
            end
            update()
        end)

        local connections = {healthChanged, hbConn}
        table.insert(espConnections, connections)
        espCache[player] = {
            highlight = highlight,
            billboard = billboard,
            connections = connections
        }
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end
    local charConn = player.CharacterAdded:Connect(onCharacterAdded)
    table.insert(espConnections, charConn)
    if not espCache[player] then espCache[player] = {} end
    espCache[player].charConnection = charConn
end

local function removeESP(player)
    local data = espCache[player]
    if not data then return end
    if data.charConnection then data.charConnection:Disconnect() end
    if data.connections then
        for _, conn in ipairs(data.connections) do
            if conn then conn:Disconnect() end
        end
    end
    if data.highlight then data.highlight:Destroy() end
    if data.billboard then data.billboard:Destroy() end
    espCache[player] = nil
end

local playerAddedConn, playerRemovingConn

sectionCommon:Toggle("透视（绿色轮廓+信息）", false, function(state)
    espEnabled = state
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                addESP(player)
            end
        end
        playerAddedConn = Players.PlayerAdded:Connect(function(player)
            if player ~= LocalPlayer then
                addESP(player)
            end
        end)
        playerRemovingConn = Players.PlayerRemoving:Connect(removeESP)
        Window:Notification("透视", "已开启", "Success", 2)
    else
        for player, _ in pairs(espCache) do
            removeESP(player)
        end
        if playerAddedConn then playerAddedConn:Disconnect() end
        if playerRemovingConn then playerRemovingConn:Disconnect() end
        espConnections = {}
        espCache = {}
        Window:Notification("透视", "已关闭", "Info", 2)
    end
end)

-- 穿墙
local noclipEnabled = false
local noclipHeartbeat = nil

local function setCharacterCollision(character, enabled)
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not enabled
        end
    end
end

local function startNoclipLoop()
    if noclipHeartbeat then return end
    noclipHeartbeat = RunService.Heartbeat:Connect(function()
        if noclipEnabled and LocalPlayer.Character then
            setCharacterCollision(LocalPlayer.Character, true)
        end
    end)
end

local function stopNoclipLoop()
    if noclipHeartbeat then noclipHeartbeat:Disconnect() noclipHeartbeat = nil end
end

if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function(character)
        if noclipEnabled then
            wait()  -- 替换 task.wait
            setCharacterCollision(character, true)
        else
            setCharacterCollision(character, false)
        end
    end)
    if LocalPlayer.Character then
        setCharacterCollision(LocalPlayer.Character, false)
    end
end

sectionCommon:Toggle("穿墙模式（永久）", false, function(state)
    noclipEnabled = state
    if state then
        if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, true) end
        startNoclipLoop()
        Window:Notification("穿墙", "已开启", "Success", 2)
    else
        if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, false) end
        stopNoclipLoop()
        Window:Notification("穿墙", "已关闭", "Info", 2)
    end
end)

-- 隐身
local invisibleEnabled = false
local function setCharacterInvisible(character, invisible)
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = invisible and 1 or 0
        end
    end
end
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function(character)
        if invisibleEnabled then
            wait()  -- 替换 task.wait
            setCharacterInvisible(character, true)
        end
    end)
    if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end
end

sectionCommon:Toggle("隐身", false, function(state)
    invisibleEnabled = state
    if state then
        if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, true) end
        Window:Notification("隐身", "已开启", "Success", 2)
    else
        if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end
        Window:Notification("隐身", "已关闭", "Info", 2)
    end
end)

-- 无限跳
local infiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

sectionCommon:Toggle("无限跳", false, function(state)
    infiniteJumpEnabled = state
    if state then
        Window:Notification("无限跳", "已开启", "Success", 2)
    else
        Window:Notification("无限跳", "已关闭", "Info", 2)
    end
end)

sectionCommon:Button("自杀", function()
    game.Players.LocalPlayer.Character.Humanoid.Health=0
end)

sectionCommon:Toggle("无敌（可能会失效）", false, function(state)
    loadstring(game:HttpGet('https://pastebin.com/raw/nwGEvkez'))()
end)

sectionCommon:Button("死亡笔记", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)

sectionCommon:Button("踏空行走", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

sectionCommon:Button("视角可提超广角", function()
    Workspace.CurrentCamera.FieldOfView = 100
end)

sectionCommon:Button("铁拳", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

sectionCommon:Button("iw指今控制台", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

sectionCommon:Button("旋转", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
end)

sectionCommon:Toggle("反挂机", false, function(state)
     loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)

sectionCommon:Button("工具挂", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
end)

-- ==================== 娱乐（FE） ====================
local tabFun = Window:Tab("娱乐（FE）", "117911709021357")
local sectionFun = tabFun:Section("娱乐功能", {Y = "113580079129703", F = "113580079129703"}, true)

sectionFun:Button("打人", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))() 
end)

sectionFun:Button("M 47", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))()
end)

sectionFun:Button("电脑键盘", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

sectionFun:Button("SCP-096", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))()
end)

sectionFun:Button("变车", function()
    loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))()
end)

sectionFun:Button("撸管R15", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

sectionFun:Button("撸管R6", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

sectionFun:Button("飞檐走壁", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

-- ==================== 配置管理 ====================
local tabConfig = Window:Tab("配置管理")
local sectionConfig = tabConfig:Section("配置设置")

local ConfigName = ""
sectionConfig:Textbox("配置名字", "输入配置名", function(val) ConfigName = val end)

local dropdownObj
local ConfigPaths = {}

local function RefreshConfigs()
    pcall(function()
        if not isfolder(Window.RootFolder) then makefolder(Window.RootFolder) end
        if not isfolder(Window.ConfigFolder) then makefolder(Window.ConfigFolder) end
    end)
    local newList = {"None"}
    local newPaths = {}
    pcall(function()
        for _, file in pairs(listfiles(Window.ConfigFolder)) do
            local name = file:gsub(".*[\\/]", ""):gsub("%.json$", "")
            if name ~= "" then
                table.insert(newList, name)
                newPaths[name] = file
            end
        end
    end)
    ConfigPaths = newPaths
    if dropdownObj then dropdownObj.Refresh(newList) end
end

dropdownObj = sectionConfig:Dropdown("选择配置", {"None"}, function(val) Window.CurrentConfig = val end)
sectionConfig:Button("刷新列表", RefreshConfigs)

sectionConfig:Button("保存配置", function()
    if ConfigName == "" then Window:Notification("保存错误", "请填写配置名", "Error", 2) return end
    library:SaveConfig(ConfigName, Window.ConfigFolder)
    RefreshConfigs()
    Window:Notification("成功保存", "配置保存为 " .. ConfigName, "Success", 2)
end)

sectionConfig:Button("加载配置", function()
    if Window.CurrentConfig == "" or Window.CurrentConfig == "None" then
        Window:Notification("加载错误", "请先选择一个配置", "Error", 2)
        return
    end
    local name = Window.CurrentConfig
    local path = ConfigPaths[name] or (Window.ConfigFolder .. "/" .. name .. ".json")
    Window:Notification("正在加载", "正在载入 " .. name, "Info", 2)
    local ok = library:LoadConfig(path)
    if ok then
        Window:Notification("加载成功", name .. " 已加载", "Success", 2)
    else
        Window:Notification("错误", "加载失败", "Error", 2)
    end
end)

sectionConfig:Button("删除配置", function()
    if Window.CurrentConfig == "" or Window.CurrentConfig == "None" then
        Window:Notification("错误", "请先选择要删除的配置", "Error", 2)
        return
    end
    local name = Window.CurrentConfig
    pcall(function()
        for _, path in ipairs({ConfigPaths[name], Window.ConfigFolder .. "/" .. name .. ".json", Window.ConfigFolder .. "\\" .. name .. ".json"}) do
            if path and isfile(path) then delfile(path) break end
        end
    end)
    Window.CurrentConfig = "None"
    wait(0.05)  -- 替换 task.wait
    RefreshConfigs()
    if dropdownObj and dropdownObj.Reset then dropdownObj.Reset() end
    Window:Notification("成功", name .. " 已删除", "Success", 2)
end)

RefreshConfigs()

-- ==================== UI设置 ====================
local tabUISettings = Window:Tab("UI设置")
local sectionUI = tabUISettings:Section("界面设置")

sectionUI:Toggle("彩虹边框", false, function(v) library:ToggleRainbow(v) end)
sectionUI:Slider("边框速度", 0.1, 10, 1, function(v) library:SetRainbowSpeed(v) end)

local rainbowTypeMap = {
    ["线性渐变（实心彩虹）"] = "Linear Gradient (Solid Rainbow)",
    ["动态/循环彩虹"] = "Animated/Cycling Rainbow",
    ["平滑渐变"] = "Smooth Fading Gradient",
    ["分段/条带彩虹"] = "Step/Band Rainbow",
    ["彩虹脉冲"] = "Rainbow Pulse",
    ["径向彩虹"] = "Radial Rainbow",
    ["霓虹/发光彩虹"] = "Neon/Glowing Rainbow",
    ["柔和彩虹"] = "Pastel Rainbow",
    ["垂直/水平渐变"] = "Vertical/Horizontal Fade"
}
local rainbowTypeDisplay = {}
for display, _ in pairs(rainbowTypeMap) do table.insert(rainbowTypeDisplay, display) end

sectionUI:Dropdown("边框类型", rainbowTypeDisplay, function(val) library:SetRainbowType(rainbowTypeMap[val]) end)

local themeMap = {
    ["暗色"] = "Dark",
    ["白色"] = "White",
    ["紫色"] = "Purple",
    ["蓝色"] = "Blue",
    ["红色"] = "Red",
    ["黄色"] = "Yellow",
    ["绿色"] = "Green"
}
local themeDisplay = {}
for display, _ in pairs(themeMap) do table.insert(themeDisplay, display) end

sectionUI:Dropdown("主题颜色", themeDisplay, function(v) library:SetTheme(themeMap[v]) end)
sectionUI:Keybind("菜单键绑定", Enum.KeyCode.RightShift, function(v) Window:SetKeybind(v) end)
sectionUI:Button("摧毁界面", function() Window:Destroy() end)