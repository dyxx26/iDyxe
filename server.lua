CarryServer.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local remote = Instance.new("RemoteEvent")
remote.Name = "CarryEvent"
remote.Parent = ReplicatedStorage

local carrying = {}

remote.OnServerEvent:Connect(function(player, action, targetName)

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if action == "carry" then

		local target = Players:FindFirstChild(targetName)
		if not target then return end

		local targetChar = target.Character
		if not targetChar then return end

		local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
		if not targetRoot then return end

		if carrying[player] then return end

		local weld = Instance.new("WeldConstraint")
		weld.Name = "CarryWeld"
		weld.Part0 = root
		weld.Part1 = targetRoot
		weld.Parent = root

		targetRoot.CFrame = root.CFrame * CFrame.new(0,0,-3)

		carrying[player] = target

	elseif action == "uncarry" then

		local weld = root:FindFirstChild("CarryWeld")
		if weld then
			weld:Destroy()
		end

		carrying[player] = nil

	elseif action == "fly" then

		local bv = root:FindFirstChild("CarryFly")

		if bv then
			bv:Destroy()
			return
		end

		bv = Instance.new("BodyVelocity")
		bv.Name = "CarryFly"
		bv.MaxForce = Vector3.new(1e5,1e5,1e5)
		bv.Velocity = Vector3.new(0,60,0)
		bv.Parent = root

	end
end)
