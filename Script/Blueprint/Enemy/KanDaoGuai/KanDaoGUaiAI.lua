local KanDaoGUaiAI = {}
 
function KanDaoGUaiAI:OnPossess()
    KanDaoGUaiAI.SuperClass.OnPossess(self)
   -- print("Log tree onprocess:"..self.TestValue)
    -- RunBehaviorTree is required Super of BasicAIController but MobAIController
    --self:RunBehaviorTree(UE.LoadObject(string.format([[BehaviorTree'%sAsset/Blueprint/Enemy/KanDaoGuai/KanDaoTree.KanDaoTree']], UGCMapInfoLib.GetRootLongPackagePath())))
end
--[[
function KanDaoGUaiAI:ReceiveBeginPlay()
    KanDaoGUaiAI.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function KanDaoGUaiAI:ReceiveTick(DeltaTime)
    KanDaoGUaiAI.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function KanDaoGUaiAI:ReceiveEndPlay()
    KanDaoGUaiAI.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function KanDaoGUaiAI:GetReplicatedProperties()
    return
end
--]]

--[[
function KanDaoGUaiAI:GetAvailableServerRPCs()
    return
end
--]]

return KanDaoGUaiAI