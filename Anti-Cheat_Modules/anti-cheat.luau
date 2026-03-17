-- this Module is written by BSDC
-- the scripy has no licenses
-- u can use it anywhere,  [[ ##BUT IT IS A BASIC SCRIPT, NOT A PRO SCRIPT## ]]


local _M = {}
local Players = game:GetService("Players")
local flyingTimeCache = {}

function _M.checkCheat()
	
	local WalkSpeed = 16

	for _, player in  pairs(Players:GetPlayers()) do
		local chr = player.Character
		if not chr then
			print("This is not a player.")
			continue
		end
		
		local hum = chr:FindFirstChild("Humanoid")
		local humRoot = chr:FindFirstChild("HumanoidRootPart")
		
		if hum and hum.WalkSpeed > WalkSpeed then
			player:Kick("Speed Cheating Detected")
			continue
		end
		-- checking flying cheat
		if humRoot and hum then
			
			-- RaycastParams is just like Bcrypt,AuthenticationFilter in Springboot or other Instances. u can use it after init it
			-- dont mind that bcrypt and authenticationfilter, they also need init first, but actually different with raycast
			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			rayParams.FilterDescendantsInstances = {chr} -- except chr, then the raycast doesnt hit the player's body
			
			
			-- find player's position
			local plrPos = humRoot.Position
			-- find the distance of player and the ground
			local distance = Vector3.new(0, -15, 0)
			
			-- starts raycast
			local result = workspace:Raycast(plrPos, distance, rayParams)
			
			local userId = tostring(player.UserId)
			flyingTimeCache[userId] = flyingTimeCache[userId] or 0
			
			-- not result that means player is flying
			if not result then
				flyingTimeCache[userId] += 1
				
				-- if player is flying more than 3 seconds, then kick
				if flyingTimeCache[userId] > 3 then
					warn(player.Name .. "looks using flying cheat")
					player:Kick("Flying Cheating Detected")
				end
			else
				flyingTimeCache[userId] = 0
			end
			
			-- but we still need verifying function which is cheat and HD admin
			
		end
	end
end


return _M