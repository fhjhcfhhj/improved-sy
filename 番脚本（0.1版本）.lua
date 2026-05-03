-- 修复加载UI库 + 防报错
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/%E7%95%AAUI.lua"))()

local Window = library:CreateWindow({
    Title = "番脚本",
    Subtitle = "作者小番",
    Keybind = Enum.KeyCode.RightShift,
    Icon = 125309025997213,
    Theme = "Dark",
    Background = "https://chaton-images.s3.us-east-2.amazonaws.com/micukdwtowvsAv8eAdo2D68qnow9VjFVwxrC2zRbfMDCkrnu9numMrK66AGZvmAP_1798x810x147337.jpeg"
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- 资料库标签
local tabProfile = Window:Tab("资料库", "125309025997213")
local sectionProfile = tabProfile:Section("番脚本身份", {Y = "125309025997213", F = "125309025997213"}, true)

sectionProfile:Image({
    Title = "小番",
    Subtitle = "番脚本作者",
    Description = {"身份：番茄🍅", "小番牛逼", "xfnb666"},
    Icon = "rbxassetid://138242046025997213",
    IconColor = Color3.fromRGB(255, 255, 255),
    StrokeColor = Color3.fromRGB(255, 215, 0),
    Callback = function()
        Window:Notification("提示", "你点击了作者小番的资料", "Info", 2)
    end
})

-- 通用功能标签
local tabCommon = Window:Tab("通用", "125309025997213")
local sectionCommon = tabCommon:Section("通用功能", {Y = "125309025997213", F = "125309025997213"}, true)

-- 番飞行
sectionCommon:Button("番飞行", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
    end)
end)

-- 穿墙修复（原来逻辑反了，已纠正）
local noclipEnabled = false
local noclipHeartbeat = nil

local function setCharacterCollision(character, noclip)
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclip
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
    if noclipHeartbeat then
        noclipHeartbeat:Disconnect()
        noclipHeartbeat = nil
    end
end

-- 角色重生自动适配穿墙
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function(character)
        task.wait()
        setCharacterCollision(character, noclipEnabled)
    end)
    if LocalPlayer.Character then
        setCharacterCollision(LocalPlayer.Character, noclipEnabled)
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

-- 隐身修复
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
        task.wait()
        setCharacterInvisible(character, invisibleEnabled)
    end)
    if LocalPlayer.Character then
        setCharacterInvisible(LocalPlayer.Character, false)
    end
end

sectionCommon:Toggle("隐身", false, function(state)
    invisibleEnabled = state
    setCharacterInvisible(LocalPlayer.Character, state)
    if state then
        Window:Notification("隐身", "已开启", "Success", 2)
    else
        Window:Notification("隐身", "已关闭", "Info", 2)
    end
end)

-- 无限跳
local infiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

sectionCommon:Toggle("无限跳", false, function(state)
    infiniteJumpEnabled = state
    Window:Notification("无限跳", state and "已开启" or "已关闭", state and "Success" or "Info", 2)
end)

-- 自杀
sectionCommon:Button("自杀", function()
    pcall(function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end)
end)

-- 无敌
sectionCommon:Toggle("无敌（可能会失效）", false, function()
    pcall(function()
        loadstring(game:HttpGet('https://pastebin.com/raw/nwGEvkez'))()
    end)
end)

-- 踏空行走
sectionCommon:Button("踏空行走", function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
    end)
end)

-- 超广角
sectionCommon:Button("视角可提超广角", function()
    Workspace.CurrentCamera.FieldOfView = 100
end)

-- 铁拳
sectionCommon:Button("铁拳", function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
    end)
end)

-- 旋转
sectionCommon:Button("旋转", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
    end)
end)

-- 反挂机
sectionCommon:Toggle("反挂机", false, function()
    pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
    end)
end)

-- 娱乐FE标签
local tabFun = Window:Tab("娱乐（FE）", "125309025997213")
local sectionFun = tabFun:Section("娱乐功能", {Y = "125309025997213", F = "125309025997213"}, true)

sectionFun:Button("打人", function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))()
    end)
end)

sectionFun:Button("SCP-096", function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))()
    end)
end)

sectionFun:Button("变车", function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))()
    end)
end)

sectionFun:Button("撸管R15", function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end)
end)

sectionFun:Button("撸管R6", function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end)
end)

sectionFun:Button("飞檐走壁", function()
    pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
    end)
end)

-- 配置管理
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
    if dropdownObj and dropdownObj.Refresh then dropdownObj:Refresh(newList) end
end

dropdownObj = sectionConfig:Dropdown("选择配置", {"None"}, function(val) Window.CurrentConfig = val end)
sectionConfig:Button("刷新列表", RefreshConfigs)

sectionConfig:Button("保存配置", function()
    if ConfigName == "" then
        Window:Notification("保存错误", "请填写配置名", "Error", 2)
        return
    end
    library:SaveConfig(ConfigName, Window.ConfigFolder)
    RefreshConfigs()
    Window:Notification("成功保存", "配置保存为 " .. ConfigName, "Success", 2)
end)

sectionConfig:Button("加载配置", function()
    if not Window.CurrentConfig or Window.CurrentConfig == "None" then
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
    if not Window.CurrentConfig or Window.CurrentConfig == "None" then
        Window:Notification("错误", "请先选择要删除的配置", "Error", 2)
        return
    end
    local name = Window.CurrentConfig
    pcall(function()
        for _, path in ipairs({
            ConfigPaths[name],
            Window.ConfigFolder .. "/" .. name .. ".json",
            Window.ConfigFolder .. "\\" .. name .. ".json"
        }) do
            if path and isfile(path) then delfile(path) break end
        end
    end)
    Window.CurrentConfig = "None"
    task.wait(0.05)
    RefreshConfigs()
    if dropdownObj and dropdownObj.Reset then dropdownObj:Reset() end
    Window:Notification("成功", name .. " 已删除", "Success", 2)
end)

RefreshConfigs()

-- UI设置
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

sectionUI:Dropdown("边框类型", rainbowTypeDisplay, function(val)
    library:SetRainbowType(rainbowTypeMap[val])
end)

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

sectionUI:Dropdown("主题颜色", themeDisplay, function(v)
    library:SetTheme(themeMap[v])
end)

sectionUI:Keybind("菜单键绑定", Enum.KeyCode.RightShift, function(v)
    Window:SetKeybind(v)
end)

sectionUI:Button("摧毁界面", function()
    Window:Destroy()
end)
