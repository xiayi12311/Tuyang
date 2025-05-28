---@class TuYang_StartSequence_C:BP_LevelSequenceActorBase_C
--Edit Below--
local TuYang_StartSequence = {}
 

function TuYang_StartSequence:ReceiveBeginPlay()
    TuYang_StartSequence.SuperClass.ReceiveBeginPlay(self)
    if self:HasAuthority() then

    else
        local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Squence/StartSutitle.StartSutitle_C')
        local UIClass =UE.LoadClass(path);
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        PlayerController.StartSequence = self
        if UserWidget ~= nil then
        local Captions = UserWidget.NewWidgetObjectBP(PlayerController,UIClass)
        Captions:AddToViewport(0) 
        
    end
    end
   
   
end


--[[
function TuYang_StartSequence:ReceiveTick(DeltaTime)
    TuYang_StartSequence.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_StartSequence:ReceiveEndPlay()
    TuYang_StartSequence.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_StartSequence:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_StartSequence:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_StartSequence