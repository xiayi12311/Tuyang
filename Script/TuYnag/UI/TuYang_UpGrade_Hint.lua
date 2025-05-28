---@class TuYang_UpGrade_Hint_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field Text_TeamID UTextBlock
--Edit Below--
local TuYang_Rule = { bInitDoOnce = false } 


function TuYang_Rule:Construct()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.forward,1)
    
end


-- function TuYang_Rule:Tick(MyGeometry, InDeltaTime)

-- end

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
return TuYang_Rule