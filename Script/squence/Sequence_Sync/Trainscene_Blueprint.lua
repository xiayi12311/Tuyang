local Trainscene_Blueprint = {}

function Trainscene_Blueprint:ReceiveBeginPlay()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Captions/EnterGame1.EnterGame1_C')
    local UIClass =UE.LoadClass(path);
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local Captions = UserWidget.NewWidgetObjectBP(PlayerController,UIClass)
    Captions:AddToViewport(0) 


    self.MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
    if self.MainControlPanel ~= nil then
        local MainControlBaseUI = self.MainControlPanel.MainControlBaseUI;
        MainControlBaseUI.NavigatorPanel:SetVisibility(ESlateVisibility.Collapsed);
        MainControlBaseUI.SurviveInfoPanel:SetVisibility(ESlateVisibility.Collapsed);
        MainControlBaseUI.CanvasPanel_16:SetVisibility(ESlateVisibility.Collapsed);
    end



end


--[[
function Trainscene_Blueprint:ReceiveBeginPlay()
    Trainscene_Blueprint.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Trainscene_Blueprint:ReceiveTick(DeltaTime)
    Trainscene_Blueprint.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Trainscene_Blueprint:ReceiveEndPlay()
    Trainscene_Blueprint.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Trainscene_Blueprint:GetReplicatedProperties()
    return
end
--]]

--[[
function Trainscene_Blueprint:GetAvailableServerRPCs()
    return
end
--]]

return Trainscene_Blueprint