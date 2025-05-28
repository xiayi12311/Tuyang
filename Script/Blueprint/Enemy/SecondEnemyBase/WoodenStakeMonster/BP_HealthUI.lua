---@class BP_HealthUI_C:UUserWidget
---@field ProgressBar_0 UProgressBar
---@field TextBlock_Health UTextBlock
---@field TextBlock_HealthMax UTextBlock
--Edit Below--
local BP_HealthUI = { bInitDoOnce = false } 


function BP_HealthUI:Construct()
	BP_HealthUI.SuperClass.Construct(self)
end

-- function BP_HealthUI:Tick(MyGeometry, InDeltaTime)

-- end

-- function BP_HealthUI:Destruct()

-- end

function BP_HealthUI:SetHealthToMonster(Health,HealthMax)
    UGCLog.Log("BP_HealthUI:SetHealth", Health, HealthMax) -- 打印日志
    self.ProgressBar_0:SetPercent(Health / HealthMax)
    self.TextBlock_Health:SetText(tostring(math.floor(Health)))
    self.TextBlock_HealthMax:SetText(tostring(HealthMax))
end

return BP_HealthUI