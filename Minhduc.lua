-- [[ MINHDUC HUB - PREMIUM RGB WIDGETS - FULL FINAL EDITION 2026 ]] --
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Bảng quản lý tất cả các UIStroke để đồng bộ màu RGB
local AllStrokes = {}
local function registerStroke(stroke)
    table.insert(AllStrokes, stroke)
end

-- Vòng lặp đổi màu mượt mà cho các viền GUI
task.spawn(function()
    while true do
        for hue = 0, 1, 0.002 do
            local color = Color3.fromHSV(hue, 0.85, 0.9)
            for _, stroke in pairs(AllStrokes) do
                if stroke and stroke.Parent then
                    stroke.Color = color
                end
            end
            task.wait(0.01)
        end
    end
end)

-- ==========================================
-- ĐỊNH NGHĨA HÀM TẠO THÔNG BÁO (NOTIFY)
-- ==========================================
local NotifyGui = Instance.new("ScreenGui")
NotifyGui.Name = "HubNotificationSystem"
NotifyGui.ResetOnSpawn = false
NotifyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function createNotification(text)
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 220, 0, 45)
    notifyFrame.Position = UDim2.new(1, 30, 0, 20) -- Bắt đầu ẩn ngoài màn hình bên phải
    notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    notifyFrame.BorderSizePixel = 0
    Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 8)
    
    local notifyStroke = Instance.new("UIStroke", notifyFrame)
    notifyStroke.Thickness = 1.5
    registerStroke(notifyStroke) -- Chạy hiệu ứng màu RGB cho thông báo
    
    local notifyText = Instance.new("TextLabel", notifyFrame)
    notifyText.Size = UDim2.new(1, 0, 1, 0)
    notifyText.BackgroundTransparency = 1
    notifyText.Font = Enum.Font.GothamBold
    notifyText.TextSize = 12
    notifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifyText.Text = text
    
    notifyFrame.Parent = NotifyGui
    
    -- Hiệu ứng trượt vào (Slide In)
    local tweenIn = TweenService:Create(notifyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -240, 0, 20)
    })
    tweenIn:Play()
    
    -- Biến mất sau 3.5 giây
    task.delay(3.5, function()
        local tweenOut = TweenService:Create(notifyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 30, 0, 20)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notifyFrame:Destroy()
        end)
    end)
end

-- ==========================================
-- 1. PANEL ĐĂNG NHẬP & CHỌN THIẾT BỊ
-- ==========================================
local PassGui = Instance.new("ScreenGui")
PassGui.Name = "AdminLoginGUI"
PassGui.ResetOnSpawn = false
PassGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local PassFrame = Instance.new("Frame")
PassFrame.Size = UDim2.new(0, 260, 0, 140)
PassFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
PassFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
PassFrame.BorderSizePixel = 0
Instance.new("UICorner", PassFrame).CornerRadius = UDim.new(0, 10)
local PassStroke = Instance.new("UIStroke", PassFrame)
PassStroke.Color = Color3.fromRGB(255, 60, 60)
PassStroke.Thickness = 2
PassFrame.Parent = PassGui

local PassTitle = Instance.new("TextLabel", PassFrame)
PassTitle.Size = UDim2.new(1, 0, 0, 35)
PassTitle.BackgroundTransparency = 1
PassTitle.Font = Enum.Font.GothamBold
PassTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PassTitle.TextSize = 13
PassTitle.Text = "HỆ THỐNG BẢO MẬT HUB"

local PassInput = Instance.new("TextBox", PassFrame)
PassInput.Size = UDim2.new(0.9, 0, 0, 35)
PassInput.Position = UDim2.new(0.05, 0, 0.3, 0)
PassInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
PassInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 13
PassInput.PlaceholderText = "Nhập mật khẩu mới..."
PassInput.Text = ""
Instance.new("UICorner", PassInput).CornerRadius = UDim.new(0, 6)

local SubmitBtn = Instance.new("TextButton", PassFrame)
SubmitBtn.Size = UDim2.new(0.9, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 13
SubmitBtn.Text = "XÁC NHẬN"
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

local DeviceFrame = Instance.new("Frame")
DeviceFrame.Size = UDim2.new(0, 280, 0, 130)
DeviceFrame.Position = UDim2.new(0.5, -140, 0.5, -65)
DeviceFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
DeviceFrame.BorderSizePixel = 0
DeviceFrame.Visible = false
Instance.new("UICorner", DeviceFrame).CornerRadius = UDim.new(0, 10)
local DeviceStroke = Instance.new("UIStroke", DeviceFrame)
DeviceStroke.Color = Color3.fromRGB(0, 255, 150)
DeviceStroke.Thickness = 2
DeviceFrame.Parent = PassGui

local DeviceTitle = Instance.new("TextLabel", DeviceFrame)
DeviceTitle.Size = UDim2.new(1, 0, 0, 35)
DeviceTitle.BackgroundTransparency = 1
DeviceTitle.Font = Enum.Font.GothamBold
DeviceTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
DeviceTitle.TextSize = 13
DeviceTitle.Text = "VUI LÒNG CHỌN GIAO DIỆN"

local PcBtn = Instance.new("TextButton", DeviceFrame)
PcBtn.Size = UDim2.new(0.42, 0, 0, 45)
PcBtn.Position = UDim2.new(0.06, 0, 0.45, 0)
PcBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
PcBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PcBtn.Font = Enum.Font.GothamBold
PcBtn.TextSize = 12
PcBtn.Text = "MÁY TÍNH (PC)"
Instance.new("UICorner", PcBtn).CornerRadius = UDim.new(0, 6)

local MobileBtn = Instance.new("TextButton", DeviceFrame)
MobileBtn.Size = UDim2.new(0.42, 0, 0, 45)
MobileBtn.Position = UDim2.new(0.52, 0, 0.45, 0)
MobileBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MobileBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
MobileBtn.Font = Enum.Font.GothamBold
MobileBtn.TextSize = 12
MobileBtn.Text = "DI ĐỘNG (MOBILE)"
Instance.new("UICorner", MobileBtn).CornerRadius = UDim.new(0, 6)

-- ==========================================
-- 2. THIẾT KẾ MAIN GUI - BANNER & SIDEBAR
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernDashboardHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "HUBToggle"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 12
ToggleButton.Text = "HUB"
local UICornerToggle = Instance.new("UICorner", ToggleButton)
UICornerToggle.CornerRadius = UDim.new(0, 25)
Instance.new("UIStroke", ToggleButton).Color = Color3.fromRGB(80, 80, 90)
ToggleButton.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
registerStroke(MainStroke)
MainFrame.Parent = ScreenGui

local SideBar = Instance.new("Frame", MainFrame)
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 110, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
SideBar.BorderSizePixel = 0
local SideBarCorner = Instance.new("UICorner", SideBar)
SideBarCorner.CornerRadius = UDim.new(0, 10)

local SmoothPatch = Instance.new("Frame", SideBar)
SmoothPatch.Size = UDim2.new(0, 15, 1, 0)
SmoothPatch.Position = UDim2.new(1, -15, 0, 0)
SmoothPatch.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
SmoothPatch.BorderSizePixel = 0

local BrandLabel = Instance.new("TextLabel", SideBar)
BrandLabel.Size = UDim2.new(1, 0, 0, 35)
BrandLabel.BackgroundTransparency = 1
BrandLabel.Font = Enum.Font.GothamBold
BrandLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
BrandLabel.TextSize = 13
BrandLabel.Text = "MINHDUC HUB"

local SubBrand = Instance.new("TextLabel", SideBar)
SubBrand.Size = UDim2.new(1, 0, 0, 15)
SubBrand.Position = UDim2.new(0, 0, 0, 28)
SubBrand.BackgroundTransparency = 1
SubBrand.Font = Enum.Font.Gotham
SubBrand.TextColor3 = Color3.fromRGB(120, 120, 130)
SubBrand.TextSize = 9
SubBrand.Text = "v2.0 • Premium Edition"

local TabContainer = Instance.new("Frame", SideBar)
TabContainer.Size = UDim2.new(1, -10, 1, -60)
TabContainer.Position = UDim2.new(0, 5, 0, 55)
TabContainer.BackgroundTransparency = 1
local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 6)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -120, 1, -15)
ContentArea.Position = UDim2.new(0, 115, 0, 10)
ContentArea.BackgroundTransparency = 1

local Container1 = Instance.new("ScrollingFrame", ContentArea)
Container1.Size = UDim2.new(1, 0, 1, 0)
Container1.BackgroundTransparency = 1
Container1.CanvasSize = UDim2.new(0, 0, 0, 390)
Container1.ScrollBarThickness = 2
Container1.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)

local Container2 = Instance.new("ScrollingFrame", ContentArea)
Container2.Size = UDim2.new(1, 0, 1, 0)
Container2.BackgroundTransparency = 1
Container2.CanvasSize = UDim2.new(0, 0, 0, 390)
Container2.ScrollBarThickness = 2
Container2.Visible = false

local UIList1 = Instance.new("UIListLayout", Container1)
UIList1.Padding = UDim.new(0, 6)
local UIList2 = Instance.new("UIListLayout", Container2)
UIList2.Padding = UDim.new(0, 6)

local function createTabBtn(text)
    local btn = Instance.new("TextButton", TabContainer)
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.Text = "  " .. text
    btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabBtn("Movement")
local Tab2Btn = createTabBtn("Visuals / Teleport")

Tab1Btn.BackgroundTransparency = 0
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)

Tab1Btn.MouseButton1Click:Connect(function()
    Container1.Visible = true; Container2.Visible = false
    Tab1Btn.BackgroundTransparency = 0; Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab2Btn.BackgroundTransparency = 1; Tab2Btn.TextColor3 = Color3.fromRGB(160, 160, 170)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    Container1.Visible = false; Container2.Visible = true
    Tab1Btn.BackgroundTransparency = 1; Tab1Btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    Tab2Btn.BackgroundTransparency = 0; Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

local function createFeatureToggle(parent, text, defaultCallback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -5, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local elementStroke = Instance.new("UIStroke", frame)
    elementStroke.Thickness = 1.2
    registerStroke(elementStroke)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(230, 230, 235)
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.Size = UDim2.new(0, 42, 0, 22)
    toggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    toggleBtn.Text = ""
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 11)
    
    local indicator = Instance.new("Frame", toggleBtn)
    indicator.Size = UDim2.new(0, 16, 0, 16)
    indicator.Position = UDim2.new(0, 3, 0.5, -8)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 8)
    
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 210, 120)
            indicator:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            indicator:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
        end
        defaultCallback(state)
    end)
    return frame
end

-- ==========================================
-- 3. THIẾT LẬP CÁC Ô CHỨC NĂNG
-- ==========================================

-- --- [1. CỤM CHỈNH TỐC ĐỘ CHẠY] ---
local SpeedVal = 16
local speedActive = false

local SpeedGroupFrame = Instance.new("Frame", Container1)
SpeedGroupFrame.Size = UDim2.new(1, -5, 0, 40)
SpeedGroupFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Instance.new("UICorner", SpeedGroupFrame).CornerRadius = UDim.new(0, 6)
local SpeedStroke = Instance.new("UIStroke", SpeedGroupFrame)
SpeedStroke.Thickness = 1.2
registerStroke(SpeedStroke)

local SpeedLabel = Instance.new("TextLabel", SpeedGroupFrame)
SpeedLabel.Size = UDim2.new(0.4, 0, 1, 0)
SpeedLabel.Position = UDim2.new(0, 10, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextSize = 11
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Text = "Tốc Độ Nhân Vật"
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInputBox = Instance.new("TextBox", SpeedGroupFrame)
SpeedInputBox.Size = UDim2.new(0, 50, 0, 22)
SpeedInputBox.Position = UDim2.new(0.46, 0, 0.5, -11)
SpeedInputBox.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
SpeedInputBox.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedInputBox.Font = Enum.Font.GothamBold
SpeedInputBox.TextSize = 11
SpeedInputBox.Text = "16"
Instance.new("UICorner", SpeedInputBox).CornerRadius = UDim.new(0, 4)

SpeedInputBox.FocusLost:Connect(function()
    local num = tonumber(SpeedInputBox.Text)
    if num then SpeedVal = num end
end)

local SpeedToggleBtn = Instance.new("TextButton", SpeedGroupFrame)
SpeedToggleBtn.Size = UDim2.new(0, 42, 0, 22)
SpeedToggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
SpeedToggleBtn.Text = ""
Instance.new("UICorner", SpeedToggleBtn).CornerRadius = UDim.new(0, 11)

local SpeedToggleInd = Instance.new("Frame", SpeedToggleBtn)
SpeedToggleInd.Size = UDim2.new(0, 16, 0, 16)
SpeedToggleInd.Position = UDim2.new(0, 3, 0.5, -8)
SpeedToggleInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedToggleInd).CornerRadius = UDim.new(0, 8)

SpeedToggleBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 210, 120)
        SpeedToggleInd:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.15, true)
    else
        SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
        SpeedToggleInd:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    end
end)

-- --- [2. CỤM TUA NGƯỢC VỊ TRÍ] ---
local SavedLocation = nil

local RewindGroupFrame = Instance.new("Frame", Container1)
RewindGroupFrame.Size = UDim2.new(1, -5, 0, 40)
RewindGroupFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Instance.new("UICorner", RewindGroupFrame).CornerRadius = UDim.new(0, 6)
local RewindStroke = Instance.new("UIStroke", RewindGroupFrame)
RewindStroke.Thickness = 1.2
registerStroke(RewindStroke)

local RewindLabel = Instance.new("TextLabel", RewindGroupFrame)
RewindLabel.Size = UDim2.new(0.35, 0, 1, 0)
RewindLabel.Position = UDim2.new(0, 10, 0, 0)
RewindLabel.BackgroundTransparency = 1
RewindLabel.Font = Enum.Font.GothamMedium
RewindLabel.TextSize = 11
RewindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RewindLabel.Text = "Tua Ngược Vị Trí"
RewindLabel.TextXAlignment = Enum.TextXAlignment.Left

local SavePosBtn = Instance.new("TextButton", RewindGroupFrame)
SavePosBtn.Size = UDim2.new(0, 85, 0, 24)
SavePosBtn.Position = UDim2.new(0.42, 0, 0.5, -12)
SavePosBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 180)
SavePosBtn.Font = Enum.Font.GothamBold
SavePosBtn.TextSize = 10
SavePosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SavePosBtn.Text = "LƯU ĐỊA ĐIỂM"
Instance.new("UICorner", SavePosBtn).CornerRadius = UDim.new(0, 4)

local TeleportBackBtn = Instance.new("TextButton", RewindGroupFrame)
TeleportBackBtn.Size = UDim2.new(0, 75, 0, 24)
TeleportBackBtn.Position = UDim2.new(1, -85, 0.5, -12)
TeleportBackBtn.BackgroundColor3 = Color3.fromRGB(140, 50, 220)
TeleportBackBtn.Font = Enum.Font.GothamBold
TeleportBackBtn.TextSize = 10
TeleportBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportBackBtn.Text = "QUAY LẠI"
Instance.new("UICorner", TeleportBackBtn).CornerRadius = UDim.new(0, 4)

SavePosBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        SavedLocation = hrp.CFrame
        SavePosBtn.Text = "ĐÃ LƯU ✓"
        task.delay(1, function() SavePosBtn.Text = "LƯU ĐỊA ĐIỂM" end)
    end
end)

TeleportBackBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and SavedLocation then
        hrp.CFrame = SavedLocation
    elseif not SavedLocation then
        TeleportBackBtn.Text = "CHƯA LƯU!"
        task.delay(1, function() TeleportBackBtn.Text = "QUAY LẠI" end)
    end
end)

-- --- [3. CỤM XUẤT HỒN PHIÊN BẢN MOBILE FIX BAY LÊN XUỐNG] ---
local FreecamSpeedVal = 50
local isFreecam = false

local FreecamGroupFrame = Instance.new("Frame", Container1)
FreecamGroupFrame.Size = UDim2.new(1, -5, 0, 40)
FreecamGroupFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Instance.new("UICorner", FreecamGroupFrame).CornerRadius = UDim.new(0, 6)
local FreecamStroke = Instance.new("UIStroke", FreecamGroupFrame)
FreecamStroke.Thickness = 1.2
registerStroke(FreecamStroke)

local FreecamLabel = Instance.new("TextLabel", FreecamGroupFrame)
FreecamLabel.Size = UDim2.new(0.4, 0, 1, 0)
FreecamLabel.Position = UDim2.new(0, 10, 0, 0)
FreecamLabel.BackgroundTransparency = 1
FreecamLabel.Font = Enum.Font.GothamMedium
FreecamLabel.TextSize = 11
FreecamLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FreecamLabel.Text = "Xuất Hồn (3D Free Move)"
FreecamLabel.TextXAlignment = Enum.TextXAlignment.Left

local FreecamSpeedInput = Instance.new("TextBox", FreecamGroupFrame)
FreecamSpeedInput.Size = UDim2.new(0, 50, 0, 22)
FreecamSpeedInput.Position = UDim2.new(0.46, 0, 0.5, -11)
FreecamSpeedInput.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
FreecamSpeedInput.TextColor3 = Color3.fromRGB(255, 255, 0)
FreecamSpeedInput.Font = Enum.Font.GothamBold
FreecamSpeedInput.TextSize = 11
FreecamSpeedInput.Text = "50"
Instance.new("UICorner", FreecamSpeedInput).CornerRadius = UDim.new(0, 4)

FreecamSpeedInput.FocusLost:Connect(function()
    local num = tonumber(FreecamSpeedInput.Text)
    if num then FreecamSpeedVal = num end
end)

local FreecamToggleBtn = Instance.new("TextButton", FreecamGroupFrame)
FreecamToggleBtn.Size = UDim2.new(0, 42, 0, 22)
FreecamToggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
FreecamToggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
FreecamToggleBtn.Text = ""
Instance.new("UICorner", FreecamToggleBtn).CornerRadius = UDim.new(0, 11)

local FreecamToggleInd = Instance.new("Frame", FreecamToggleBtn)
FreecamToggleInd.Size = UDim2.new(0, 16, 0, 16)
FreecamToggleInd.Position = UDim2.new(0, 3, 0.5, -8)
FreecamToggleInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FreecamToggleInd).CornerRadius = UDim.new(0, 8)

local autoStandEnabled, noclipEnabled, floatEnabled, respawnEnabled, espEnabled, playerEspEnabled = false, false, false, false, false, false

local triggerOldFreecam

FreecamToggleBtn.MouseButton1Click:Connect(function()
    isFreecam = not isFreecam
    if isFreecam then
        FreecamToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 210, 120)
        FreecamToggleInd:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.15, true)
    else
        FreecamToggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
        FreecamToggleInd:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    end
    triggerOldFreecam(isFreecam)
end)

-- --- CÁC CHỨC NĂNG PHỤ KHÁC ---
local AutoStandToggle = createFeatureToggle(Container1, "Tự Động Đứng Dậy (Chống Ngã)", function(s) autoStandEnabled = s end)
local NoclipToggle    = createFeatureToggle(Container1, "Đi Xuyên Tường (Noclip)", function(s) noclipEnabled = s end)
local FloatToggle     = createFeatureToggle(Container1, "Chế Độ Bay (Float Floor)", function(s) floatEnabled = s end)

local RespawnToggle   = createFeatureToggle(Container2, "Hồi Sinh Ngay Tại Chỗ Chết", function(s) respawnEnabled = s end)
local EspNpcToggle    = createFeatureToggle(Container2, "Bật Định Vị Sinh Vật / NPC", function(s) espEnabled = s end)
local EspPlayerToggle = createFeatureToggle(Container2, "Bật Định Vị Người Chơi khác", function(s) playerEspEnabled = s end)

-- ==========================================
-- 4. LOGIC ĐĂNG NHẬP CHỌN THIẾT BỊ & ẨN/HIỆN
-- ==========================================
SubmitBtn.MouseButton1Click:Connect(function()
    -- ĐỔI MẬT KHẨU THÀNH: MINHDUC HUB
    if PassInput.Text == "MINHDUC HUB" then
        PassFrame.Visible = false
        DeviceFrame.Visible = true
    else
        PassInput.Text = ""
        PassInput.PlaceholderText = "Mật khẩu sai!"
    end
end)

local function initDashboard(w, h)
    PassGui:Destroy()
    MainFrame.Size = UDim2.new(0, w, 0, h)
    MainFrame.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
    ScreenGui.Enabled = true
    MainFrame.Visible = true
    
    -- THÊM THÔNG BÁO KHI BẬT HUB THÀNH CÔNG
    createNotification("MINHDUC HUB ĐÃ BẬT")
end

PcBtn.MouseButton1Click:Connect(function() initDashboard(440, 260) end)
MobileBtn.MouseButton1Click:Connect(function() initDashboard(320, 210) end)

ToggleButton.MouseButton1Click:Connect(function()
    if ScreenGui.Enabled then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ==========================================
-- 5. HỆ THỐNG XỬ LÝ CORE XUẤT HỒN 3D
-- ==========================================
local freecamPart = nil
local freecamCFrame = CFrame.new()
local anchoredParts = {}

function triggerOldFreecam(state)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if state and hrp and hum then
        freecamCFrame = hrp.CFrame
        if not freecamPart then
            freecamPart = Instance.new("Part")
            freecamPart.Size = Vector3.new(1, 1, 1)
            freecamPart.Transparency = 1
            freecamPart.Anchored = true
            freecamPart.CanCollide = false
            freecamPart.Parent = Workspace
        end
        freecamPart.CFrame = freecamCFrame
        Workspace.CurrentCamera.CameraSubject = freecamPart
        
        hum.PlatformStand = true
        
        table.clear(anchoredParts)
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") and not p.Anchored then
                p.Anchored = true
                table.insert(anchoredParts, p)
            end
        end
    else
        for _, p in pairs(anchoredParts) do
            if p and p.Parent then p.Anchored = false end
        end
        table.clear(anchoredParts)
        
        if hum then hum.PlatformStand = false end
        Workspace.CurrentCamera.CameraSubject = char and char:FindFirstChildOfClass("Humanoid")
        if freecamPart then
            freecamPart:Destroy()
            freecamPart = nil
        end
    end
end

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not isFreecam perks and hum and speedActive then
        hum.WalkSpeed = SpeedVal
     perkelseif not speedActive and hum then
        hum.WalkSpeed = 16
    end
    
    -- XỬ LÝ FREECAM DI CHUYỂN THEO CAMERA (Xoay hướng nào đi hướng đó)
    if isFreecam and freecamPart then
        local camCFrame = Workspace.CurrentCamera.CFrame
        local moveVector = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camCFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camCFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camCFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camCFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.new(0, 1, 0) end
        
        -- Hỗ trợ Mobile JoyStick kéo tiến lùi tự động bay lên/hạ xuống theo góc ngẩng màn hình
        if hum and hum.MoveDirection.Magnitude > 0 and moveVector.Magnitude == 0 then
            local joyDir = hum.MoveDirection
            local forwardVector = camCFrame.LookVector
            local rightVector = camCFrame.RightVector
            
            local localMoveDrive = camCFrame:VectorToObjectSpace(joyDir)
            moveVector = (forwardVector * -localMoveDrive.Z) + (rightVector * localMoveDrive.X)
        end
        
        if moveVector.Magnitude > 0 then
            freecamCFrame = freecamCFrame + (moveVector.Unit * (FreecamSpeedVal * 0.016))
        end
        
        freecamPart.CFrame = freecamCFrame
    end
end)

-- Hệ thống phụ trợ tự động đứng, noclip và float floor
task.spawn(function()
    while true do
        task.wait(1)
        if autoStandEnabled and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and (hum.PlatformStand or hum.Sit or hum:GetState() == Enum.HumanoidStateType.Ragdoll) and not isFreecam then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                hum.PlatformStand = false; hum.Sit = false
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character and not isFreecam then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

local floatPart = nil
RunService.Heartbeat:Connect(function()
    if floatEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and not isFreecam then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if not floatPart or not floatPart.Parent then  
            floatPart = Instance.new("Part", workspace)  
            floatPart.Size = Vector3.new(5, 0.5, 5)  
            floatPart.Transparency = 1; floatPart.Anchored = true  
        end  
        if hum and (hum.FloorMaterial == Enum.Material.Air or floatPart.Position.Y > hrp.Position.Y) then  
            floatPart.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3.25, hrp.Position.Z)  
        else  
            floatPart.CFrame = CFrame.new(hrp.Position.X, floatPart.Position.Y, hrp.Position.Z)  
        end  
    else  
        if floatPart then floatPart:Destroy() floatPart = nil end
    end
end)

local lastDeathPos = nil
local function listenDeath(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum.Died:Connect(function() if respawnEnabled and char:FindFirstChild("HumanoidRootPart") then lastDeathPos = char.HumanoidRootPart.CFrame end end)
    end
end
if LocalPlayer.Character then listenDeath(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(char)
    listenDeath(char)
    if respawnEnabled and lastDeathPos then
        task.wait(0.5)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if hrp then hrp.CFrame = lastDeathPos end
    end
end)

RunService.RenderStepped:Connect(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") and obj ~= LocalPlayer.Character then
            local isPlayer = Players:GetPlayerFromCharacter(obj)
            if (espEnabled and not isPlayer) or (playerEspEnabled and isPlayer) then
                if obj:FindFirstChild("HumanoidRootPart") then
                    local hl = obj:FindFirstChild("EspHl")
                    if not hl then
                        hl = Instance.new("Highlight", obj); hl.Name = "EspHl"
                        hl.FillTransparency = 0.6; hl.OutlineTransparency = 0
                        hl.FillColor = isPlayer and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(255, 150, 0)
                        hl.OutlineColor = hl.FillColor
                    end
                end
            else
                local hl = obj:FindFirstChild("EspHl")
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- ==========================================
-- 6. HỆ THỐNG DI CHUYỂN BẢNG CHÍNH (DRAG)
-- ==========================================
local dragging, dragStart, startPos
local isResizingGlobal = false 

SideBar.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not isResizingGlobal then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

-- ==========================================
-- 7. THUẬT TOÁN KÉO GIÃN NEON TRẮNG BẠC CHUẨN XÁC
-- ==========================================
local activeResizeHandle = nil
local basePos, baseSize, startMousePos

local corners = {
    TopLeft = {Pos = UDim2.new(0, -2, 0, -2), Anchor = Vector2.new(0,0), FaceX = -1, FaceY = -1},
    TopRight = {Pos = UDim2.new(1, 2, 0, -2), Anchor = Vector2.new(1,0), FaceX = 1, FaceY = -1},
    BottomLeft = {Pos = UDim2.new(0, -2, 1, 2), Anchor = Vector2.new(0,1), FaceX = -1, FaceY = 1},
    BottomRight = {Pos = UDim2.new(1, 2, 1, 2), Anchor = Vector2.new(1,1), FaceX = 1, FaceY = 1}
}

for name, info in pairs(corners) do
    local handle = Instance.new("Frame", MainFrame)
    handle.Name = name .. "_ResizeHandle"
    handle.Size = UDim2.new(0, 12, 0, 12)
    handle.Position = info.Pos
    handle.AnchorPoint = info.Anchor
    handle.BackgroundColor3 = Color3.fromRGB(240, 245, 255)
    handle.BackgroundTransparency = 0.25
    handle.BorderSizePixel = 0
    handle.ZIndex = 50
    
    local handleCorner = Instance.new("UICorner", handle)
    handleCorner.CornerRadius = UDim.new(0, 4)
    
    local handleStroke = Instance.new("UIStroke", handle)
    handleStroke.Color = Color3.fromRGB(255, 255, 255)
    handleStroke.Thickness = 2
    handleStroke.Transparency = 0.1
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            handle.BackgroundTransparency = 0
            handleStroke.Thickness = 3
        end
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            activeResizeHandle = info
            isResizingGlobal = true
            dragging = false
            startMousePos = input.Position
            basePos = MainFrame.Position
            baseSize = MainFrame.Size
        end
    end)
    
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            handle.BackgroundTransparency = 0.25
            handleStroke.Thickness = 2
        end
    end)
end

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    if isResizingGlobal and activeResizeHandle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mouseDelta = input.Position - startMousePos
        
        local deltaWidth = mouseDelta.X * activeResizeHandle.FaceX
        local deltaHeight = mouseDelta.Y * activeResizeHandle.FaceY
        
        local newWidth = math.clamp(baseSize.X.Offset + deltaWidth, 260, 800)
        local newHeight = math.clamp(baseSize.Y.Offset + deltaHeight, 160, 600)
        
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        
        local finalPosX = basePos.X.Offset
        local finalPosY = basePos.Y.Offset
        
        if activeResizeHandle.FaceX == -1 then finalPosX = basePos.X.Offset - (newWidth - baseSize.X.Offset) end
        if activeResizeHandle.FaceY == -1 then finalPosY = basePos.Y.Offset - (newHeight - baseSize.Y.Offset) end
        
        MainFrame.Position = UDim2.new(basePos.X.Scale, finalPosX, basePos.Y.Scale, finalPosY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        isResizingGlobal = false
        activeResizeHandle = nil
    end
end)
