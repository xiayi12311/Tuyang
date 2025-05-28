---@class TuYang_PlayerTeleportAnnoucer_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field Text_TeamID UTextBlock
---@field TextBlock_5 UTextBlock
--Edit Below--
local TuYang_PlayerTeleportAnnoucer = { bInitDoOnce = false } 
TuYang_PlayerTeleportAnnoucer.WidgetLifeSpan = 3
local TimeSet = 0

function TuYang_PlayerTeleportAnnoucer:Construct()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    TimeSet = 0
end


    function TuYang_PlayerTeleportAnnoucer:Tick(MyGeometry, InDeltaTime)
        TimeSet = TimeSet + InDeltaTime
        if TimeSet >= self.WidgetLifeSpan then
            self:Close()
        end
    end

-- function TuYang_PlayerTeleportAnnoucer:Destruct()

-- end

function TuYang_PlayerTeleportAnnoucer:SetUpLevelTeamUI(InID)
    if InID == 1 then
        self.Text_TeamID:SetText("红方")
    elseif InID == 2 then
        self.Text_TeamID:SetText("紫方")
    end
    --self.Text_TeamID:SetText("")
end
function TuYang_PlayerTeleportAnnoucer:Close()
    self:RemoveFromViewport()
end
return TuYang_PlayerTeleportAnnoucer