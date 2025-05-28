---@class SpawnDoor2_C:LevelSequenceActor
--Edit Below--
local SpawnFirstBoss = {}
 

function SpawnFirstBoss:ReceiveBeginPlay()
    SpawnFirstBoss.SuperClass.ReceiveBeginPlay(self)
    ugcprint("sequence beginplay")
    --local SequencePlayer = self.SequencePlayer
    --SequencePlayer:Play()
    -- if not self:HasAuthority() then 
    --     ugcprint("大BOSS动画正在播放")
    --     local SequencePlayer = self.SequencePlayer
    --     SequencePlayer:Play()
    -- end
    --     local SequencePlayer = self.SequencePlayer
	-- 	if SequencePlayer then
	-- 		SequencePlayer:Play()
	-- 		ugcprint("大BOSS动画正在播放")
			
	-- 	else
	-- 		ugcprint("SequencePlayer not found.")
	-- 	end
    -- end

    local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
        function()      
            ugcprint("Tank Spawn")                                
            if self:HasAuthority() then --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tank/Tank.Tank_C')
                local MonsterPath = UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/Tank.Tank_C"
                local Class_Monster = UE.LoadClass(MonsterPath)
                local BP_Monster = ScriptGameplayStatics.SpawnActor(self, Class_Monster, 
                                {X=-5641.255859,Y=19910.000000,Z=220},    --坐标
                                {Roll = 0, Pitch = 0, Yaw = 0},     --旋转
                                {X = 1, Y = 1, Z = 1})              --缩放

            end
            
        end)
    KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 10, false)
end


--[[
function SpawnFirstBoss:ReceiveTick(DeltaTime)
    SpawnFirstBoss.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnFirstBoss:ReceiveEndPlay()
    SpawnFirstBoss.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnFirstBoss:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnFirstBoss:GetAvailableServerRPCs()
    return
end
--]]

return SpawnFirstBoss