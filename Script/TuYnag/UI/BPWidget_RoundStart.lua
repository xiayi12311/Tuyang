---@class BPWidget_RoundStart_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field Text_TeamID UTextBlock
---@field TextBlock_5 UTextBlock
--Edit Below--
local BPWidget_RoundStart = { bInitDoOnce = false } 
BPWidget_RoundStart.WidgetLifeSpan = 3
local TimeSet = 0

function BPWidget_RoundStart:Construct()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    TimeSet = 0
end


function BPWidget_RoundStart:Tick(MyGeometry, InDeltaTime)
    TimeSet = TimeSet + InDeltaTime
    if TimeSet >= self.WidgetLifeSpan then
        self:Close()
    end
end

-- function BPWidget_RoundStart:Destruct()

-- end

function BPWidget_RoundStart:SetUpLevelTeamUI(InID)
    if InID == 1 then
        self.Text_TeamID:SetText("红方")
    elseif InID == 2 then
        self.Text_TeamID:SetText("紫方")
    end
    --self.Text_TeamID:SetText("")
end
function BPWidget_RoundStart:Close()
    self:RemoveFromViewport()
end
return BPWidget_RoundStart