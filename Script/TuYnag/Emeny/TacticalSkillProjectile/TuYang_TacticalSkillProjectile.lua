---@class TuYang_TacticalSkillProjectile_C:STExtraSimpleCharacter
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field BlockVolume TSoftObjectPtr<ABlockingVolume>
---@field NewVar_0 ABlockingVolume
--Edit Below--
local TuYang_TacticalSkillProjectile = {}
 

function TuYang_TacticalSkillProjectile:ReceiveBeginPlay()
    TuYang_TacticalSkillProjectile.SuperClass.ReceiveBeginPlay(self)

    -- UGCLog.Log("[maoyu]:TuYang_TacticalSkillProjectile:ReceiveBeginPlay")
    -- local BlockVolumeObjs = GameplayStatics.GetAllActorsWithTag(self, "NeedMove")
    -- if BlockVolumeObjs and #BlockVolumeObjs > 0 then
    --     UGCLog.Log("[maoyu]:TuYang_TacticalSkillProjectile:ReceiveBeginPlay - Found BlockVolumeObjs")
    --     self.BlockVolume = BlockVolumeObjs[1]
    -- end
end


--[[
function TuYang_TacticalSkillProjectile:ReceiveTick(DeltaTime)
    TuYang_TacticalSkillProjectile.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_TacticalSkillProjectile:ReceiveEndPlay()
    TuYang_TacticalSkillProjectile.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_TacticalSkillProjectile:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_TacticalSkillProjectile:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_TacticalSkillProjectile