local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")

-- Tắt màn hình chờ mặc định của Roblox ngay lập tức
ReplicatedFirst:RemoveDefaultLoadingScreen()

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

----------------------------------------------------------------
-- 1. TỰ ĐỘNG KHỞI TẠO GIAO DIỆN (GUI) BẰNG CODE
----------------------------------------------------------------

-- Tạo ScreenGui chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoLoadingScreen"
screenGui.IgnoreGuiInset = true -- Tràn viền màn hình, che cả thanh topbar
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Tạo hình nền (Background) màu tối hiện đại
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(15, 15, 20) -- Màu xám xanh tối sang trọng
background.BorderSizePixel = 0
background.Active = true
background.Parent = screenGui

-- Tạo tiêu đề game / Trạng thái loading
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "ĐANG KHỞI TẠO THẾ GIỚI..."
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = background

-- Tạo nhãn hiển thị số lượng Asset đã load thực tế
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(0.8, 0, 0.05, 0)
statusLabel.Position = UDim2.new(0.1, 0, 0.48, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 155)
statusLabel.Text = "Đang tải tài nguyên: 0/0"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 16
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = background

-- Tạo khung nền cho thanh loading (ProgressBarBackground)
local barBackground = Instance.new("Frame")
barBackground.Name = "BarBackground"
barBackground.Size = UDim2.new(0.35, 0, 0.015, 0)
barBackground.Position = UDim2.new(0.325, 0, 0.55, 0)
barBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
barBackground.BorderSizePixel = 0
barBackground.Parent = background

-- Bo góc cho khung nền thanh loading
local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(0.5, 0)
barBgCorner.Parent = barBackground

-- Tạo thanh chạy chính bên trong (ProgressBar) - Màu xanh Neon cực đẹp
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0) -- Bắt đầu từ 0%
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Xanh lam Neon sáng
progressBar.BorderSizePixel = 0
progressBar.Parent = barBackground

-- Bo góc cho thanh chạy
local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0.5, 0)
progressCorner.Parent = progressBar

----------------------------------------------------------------
-- 2. LOGIC TẢI GAME VÀ CHẠY HIỆU ỨNG TWEEN
----------------------------------------------------------------

-- Danh sách các thư mục cần load trước
local assetsToLoad = {}
local targetFolders = {
	workspace,
	game:GetService("ReplicatedStorage"),
	game:GetService("SoundService")
}

-- Quét toàn bộ Asset con trong các folder mục tiêu
for _, folder in ipairs(targetFolders) do
	for _, child in ipairs(folder:GetDescendants()) do
		-- Chỉ load các Asset quan trọng để tránh quá tải (Mesh, Sound, Decal/Texture, Tool)
		if child:IsA("MeshPart") or child:IsA("SpecialMesh") or child:IsA("Sound") or child:IsA("Decal") or child:IsA("Texture") then
			table.insert(assetsToLoad, child)
		end
	end
end

local totalAssets = #assetsToLoad
local assetsLoaded = 0

-- Nếu game trống rỗng không có gì để tải
if totalAssets == 0 then
	totalAssets = 1
end

-- Hàm cập nhật thanh loading mượt mà
local function updateProgress(percentage)
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local targetSize = UDim2.new(percentage, 0, 1, 0)
	
	local tween = TweenService:Create(progressBar, tweenInfo, {Size = targetSize})
	tween:Play()
end

-- Bắt đầu quá trình load game
task.wait(0.5) -- Đợi một chút để người chơi ổn định kết nối

for i, asset in ipairs(assetsToLoad) do
	pcall(function()
		ContentProvider:PreloadAsync({asset})
	end)
	
	assetsLoaded = i
	local percentage = math.clamp(assetsLoaded / totalAssets, 0, 1)
	
	-- Cập nhật chữ và tiến trình
	titleLabel.Text = "ĐANG TẢI DỮ LIỆU... (" .. math.floor(percentage * 100) .. "%)"
	statusLabel.Text = "Tập tin đã tải: " .. assetsLoaded .. " / " .. totalAssets
	
	updateProgress(percentage)
	
	-- Khi test trên Roblox Studio, tiến trình có thể diễn ra quá nhanh.
	-- Thêm dòng wait siêu nhỏ này giúp hiệu ứng chạy mượt mà dễ quan sát hơn.
	task.wait(0.02) 
end

-- Tải hoàn tất
titleLabel.Text = "KHỞI CHẠY TRÒ CHƠI!"
statusLabel.Text = "Đã tải xong toàn bộ " .. totalAssets .. " tài nguyên."
updateProgress(1)
task.wait(0.8)

----------------------------------------------------------------
-- 3. HIỆU ỨNG FADE-OUT BIẾN MẤT KHI HOÀN TẤT
----------------------------------------------------------------

local fadeInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

-- Làm mờ toàn bộ chữ và thanh chạy
TweenService:Create(titleLabel, fadeInfo, {TextTransparency = 1}):Play()
TweenService:Create(statusLabel, fadeInfo, {TextTransparency = 1}):Play()
TweenService:Create(barBackground, fadeInfo, {BackgroundTransparency = 1}):Play()
TweenService:Create(progressBar, fadeInfo, {BackgroundTransparency = 1}):Play()

-- Làm mờ nền chính
local bgTween = TweenService:Create(background, fadeInfo, {BackgroundTransparency = 1})
bgTween:Play()

-- Khi hiệu ứng biến mất hoàn thành, tự động xóa GUI để giải phóng bộ nhớ
bgTween.Completed:Connect(function()
	screenGui:Destroy()
end)
