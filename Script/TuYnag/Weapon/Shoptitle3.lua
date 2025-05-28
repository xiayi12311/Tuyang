---@class Shoptitle3_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field TextBlock_137 UTextBlock
---@field TextBlock_Cost UTextBlock
--Edit Below--
local Shoptitle = { bInitDoOnce = false } 

--[==[ Construct
function Shoptitle:Construct()
	
end
-- Construct ]==]

-- function Shoptitle:Tick(MyGeometry, InDeltaTime)

-- end

-- function Shoptitle:Destruct()

-- end
function Shoptitle:SetCost(InCost)
    self.TextBlock_Cost:SetText(tostring(InCost))
    self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
end
return Shoptitle