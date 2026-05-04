local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/VIP_Fenglib(2).lua"))()

local Window = library:CreateWindow({
    Title = "款脚本",
    Subtitle = "付款制作必是精品",
    Keybind = Enum.KeyCode.RightShift,
    Icon = 80732857736726,
    Theme = "Dark",
    Background = "https://chaton-images.s3.us-east-2.amazonaws.com/Qx7Aun30ZRPmlXtXDE3adbBleR5buvwp8AbOFCoIU5TugqRw62Dn00B4rBtx00Vx_1578x932x261816.jpeg"
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

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
    Subtitle = "款脚本测试人员",
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
    Subtitle = "款脚本管理员",
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
    Subtitle = "款脚本测试人员",
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
    Subtitle = "款脚本管理员",
    Description = {"身份：披萨员", "pizza！", "立方体"},
    Icon = "rbxassetid://104898690520306",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了Pizza的资料", "Info", 2)
    end
})

local tabCommon = Window:Tab("通用", "85043685370431")
local sectionCommon = tabCommon:Section("通用功能", {Y = "127278444393372", F = "127278444393372"}, true)

-- ===== 新增功能变量 =====
local aimEnabled = false
local speedEnabled = false
local speedValue = 16
local jumpEnabled = false
local jumpValue = 50

-- 用于统一管理的 Heartbeat 循环
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

            -- 自瞄：看向最近玩家的头部
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
                    -- 平滑转向，避免抖动
                    local lookPos = nearestHead.Position
                    root.CFrame = CFrame.lookAt(root.Position, Vector3.new(lookPos.X, root.Position.Y, lookPos.Z))
                end
            end

            -- 自定义速度
            if speedEnabled then
                humanoid.WalkSpeed = speedValue
            else
                humanoid.WalkSpeed = 16  -- 恢复默认
            end

            -- 自定义跳跃高度
            if jumpEnabled then
                humanoid.JumpPower = jumpValue
            else
                humanoid.JumpPower = 50  -- 恢复默认
            end
        end)
    elseif not needLoop and featureHeartbeat then
        featureHeartbeat:Disconnect()
        featureHeartbeat = nil
        -- 关闭循环后立刻恢复默认值
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

-- 角色重生时清理旧值
LocalPlayer.CharacterAdded:Connect(function(char)
    if speedEnabled then
        task.wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = speedValue end
    end
    if jumpEnabled then
        task.wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = jumpValue end
    end
end)

-- ===== 新增UI: 自瞄 =====
sectionCommon:Toggle("自瞄（瞄准头部）", false, function(state)
    aimEnabled = state
    updateFeatureHeartbeat()
    Window:Notification("自瞄", state and "已开启" or "已关闭", state and "Success" or "Info", 2)
end)

-- ===== 新增UI: 改速度 =====
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

-- ===== 新增UI: 改跳跃 =====
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

-- ===== 原有功能 =====
sectionCommon:Button("款飞行", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
end)

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
            task.wait()
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
            task.wait()
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

sectionCommon:Toggle("无敌（可能会失效）", false, function(state)
    loadstring(game:HttpGet('https://pastebin.com/raw/nwGEvkez'))()
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

local tabCommon = Window:Tab("娱乐（FE）", "117911709021357")
local sectionCommon = tabCommon:Section("娱乐功能", {Y = "113580079129703", F = "113580079129703"}, true)

sectionCommon:Button("打人", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))() 
end)

sectionCommon:Button("M 47", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))()
end)

sectionCommon:Button("电脑键盘", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

sectionCommon:Button("SCP-096", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))()
end)

sectionCommon:Button("变车", function()
    loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))()
end)

sectionCommon:Button("撸管R15", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

sectionCommon:Button("撸管R6", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

sectionCommon:Button("飞檐走壁", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

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
    task.wait(0.05)
    RefreshConfigs()
    if dropdownObj and dropdownObj.Reset then dropdownObj.Reset() end
    Window:Notification("成功", name .. " 已删除", "Success", 2)
end)

RefreshConfigs()

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