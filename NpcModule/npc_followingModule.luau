-- this module script written by bsdc
-- this script doesnt have any license
-- if u want to use it, you can use it freely

local _M = {}


local players = game:GetService("Players")


function _M.findPlayers(monsterRoot)

	local closestPlayer = nil
	local shortestDistance = math.huge -- find players in the maps

	for _, player in pairs(players:GetPlayers()) do

		if player.Character and player.Character:FindFirstChild("Humanoid") then

			-- set a target. it is a player here. the npc follows humanoidrootpart of the plr
			local targetPart = player.Character.HumanoidRootPart 

			-- is a distance. from npc to player. we use .magnutude to use operators
			local distance = (monsterRoot.Position - targetPart.Position).Magnitude
			
			-- set the shortestDistance(it is huge) to the distance what we found
			if distance < shortestDistance then
				shortestDistance = distance
				closestPlayer = player
			else
				print("no one found in the map")
			end
		else
			print("cannot find a player")
		end
	end

	return closestPlayer

end

function _M.run(monsterPart)
	
	local monsterHumanoid = monsterPart:WaitForChild("Humanoid")
	local monsterRootPart = monsterPart:WaitForChild("HumanoidRootPart")
	
	if not monsterRootPart then
		error("monsterModel not loaded and something gone wrong")
	end
	
	-- it is my firt time to use task.spawn() xD
	task.spawn(function()
		while true do

			local target = _M.findPlayers(monsterRootPart)

			if target and target.Character then

				local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")

				if targetRoot then
					monsterHumanoid:MoveTo(targetRoot.Position)
				end
			else
				print("no target found")
			end

			task.wait(0.5)

		end
	end)
end

return _M