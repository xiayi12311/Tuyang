---@class TuYang_BPWidgetStatusBarIcon_C:UUserWidget
---@field Image_0 UImage
--Edit Below--
local TuYang_PlayerBuffConfig = require("Script.Config.TuYang_PlayerBuffConfig")

local TuYang_BPWidgetStatusBarIcon = { bInitDoOnce = false } 
TuYang_BPWidgetStatusBarIcon.Key = ""

function TuYang_BPWidgetStatusBarIcon:Construct()
	self:SetIcon()
end


-- function TuYang_BPWidgetStatusBarIcon:Tick(MyGeometry, InDeltaTime)

-- end

-- function TuYang_BPWidgetStatusBarIcon:Destruct()

-- end

function TuYang_BPWidgetStatusBarIcon:SetIcon()
   self.Image_0:SetBrushFromTexture(UE.LoadObject(TuYang_PlayerBuffConfig:GetItem(self.Key).Texture),true)
end
return TuYang_BPWidgetStatusBarIcon