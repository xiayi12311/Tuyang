---@class SpawnBoss_C:LevelSequenceActor
--Edit Below--
local SpawnBoss = {}
 

function SpawnBoss:ReceiveBeginPlay()
    SpawnBoss.SuperClass.ReceiveBeginPlay(self)
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
            if self:HasAuthority() then 
                local MonsterPath = UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Boss/Boss.Boss_C"
                local Class_Monster = UE.LoadClass(MonsterPath)
                local BP_Monster = ScriptGameplayStatics.SpawnActor(self, Class_Monster, 
                                {X=-46646.812500,Y=19937.462891,Z=190.000000},    --坐标
                                {Roll = 0, Pitch = 0, Yaw = 0},     --旋转
                                {X = 1, Y = 1, Z = 1})              --缩放

            end
            
        end)
    KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 14.1, false)

    
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Captions/Levelboss1.Levelboss1_C')
    local UIClass =UE.LoadClass(path);
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local Captions = UserWidget.NewWidgetObjectBP(PlayerController,UIClass)
    Captions:AddToViewport(0) 
end


--[[
function SpawnBoss:ReceiveTick(DeltaTime)
    SpawnBoss.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnBoss:ReceiveEndPlay()
    SpawnBoss.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnBoss:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnBoss:GetAvailableServerRPCs()
    return
end
--]]

return SpawnBoss