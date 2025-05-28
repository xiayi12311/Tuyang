local First_Boss = {}
function First_Boss:GetBehaviorTreeObjectPath()
    return string.format('%sAsset/Blueprint/MyBt.MyBt', UGCMapInfoLib.GetRootLongPackagePath())
end

function First_Boss:OnPossess()
    self.SuperClass.OnPossess(self)

    self:RunBehaviorTree(UE.LoadObject(self:GetBehaviorTreeObjectPath()))
end
--[[
function First_Boss:ReceiveBeginPlay()
    First_Boss.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function First_Boss:ReceiveTick(DeltaTime)
    First_Boss.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function First_Boss:ReceiveEndPlay()
    First_Boss.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function First_Boss:GetReplicatedProperties()
    return
end
--]]

--[[
function First_Boss:GetAvailableServerRPCs()
    return
end
--]]

return First_Boss