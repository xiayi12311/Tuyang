---@class ShooterAI_C:MobAIController
--Edit Below--
local ShooterAI = {}
function ShooterAI:OnPossess()
    ShooterAI.SuperClass.OnPossess(self)
    --print("Log tree onprocess:"..self.TestValue)

    -- RunBehaviorTree is required Super of BasicAIController but MobAIController
    self:RunBehaviorTree(UE.LoadObject(string.format([[BehaviorTree'%sAsset/Blueprint/Enemy/Shooter/Chapter0/ShooterTree.ShooterTree']], UGCMapInfoLib.GetRootLongPackagePath())))
end

function ShooterAI:ReceiveBeginPlay()
    ShooterAI.SuperClass.ReceiveBeginPlay(self)
   -- print("Log tree onprocess")
    --self:RunBehaviorTree(UE.LoadObject(string.format([[BehaviorTree'%sAsset/Blueprint/Enemy/Shooter/ShooterTree.ShooterTree']], UGCMapInfoLib.GetRootLongPackagePath())))
end

--[[
function ShooterAI:ReceiveTick(DeltaTime)
    ShooterAI.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function ShooterAI:ReceiveEndPlay()
    ShooterAI.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function ShooterAI:GetReplicatedProperties()
    return
end
--]]

--[[
function ShooterAI:GetAvailableServerRPCs()
    return
end
--]]

return ShooterAI