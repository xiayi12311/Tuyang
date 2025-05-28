---@class TuYang_Somon_Hint1_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field Text_TeamID UTextBlock
---@field TextBlock_5 UTextBlock
--Edit Below--
local TuYang_Rule = { bInitDoOnce = false } 
TuYang_Rule.WidgetLifeSpan = 3
local TimeSet = 0

function TuYang_Rule:Construct()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    TimeSet = 0
end


    function TuYang_Rule:Tick(MyGeometry, InDeltaTime)
        TimeSet = TimeSet + InDeltaTime
        if TimeSet >= self.WidgetLifeSpan then
            self:Close()
        end
    end

-- function TuYang_Rule:Destruct()

-- end

function TuYang_Rule:SetUpLevelTeamUI(InID)
    if InID == 1 then
        self.Text_TeamID:SetText("红方")
    elseif InID == 2 then
        self.Text_TeamID:SetText("紫方")
    end
    --self.Text_TeamID:SetText("")
end
function TuYang_Rule:Close()
    self:RemoveFromViewport()
end
return TuYang_Rule