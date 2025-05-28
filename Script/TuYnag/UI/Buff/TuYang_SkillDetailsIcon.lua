---@class TuYang_SkillDetailsIcon_C:UUserWidget
---@field Button_Chick UButton
---@field Image_0 UImage
--Edit Below--
local TuYang_PlayerBuffConfig = require("Script.Config.TuYang_PlayerBuffConfig")

local TuYang_BPWidgetStatusBarIcon = { bInitDoOnce = false } 
TuYang_BPWidgetStatusBarIcon.Key = 1

function TuYang_BPWidgetStatusBarIcon:Construct()
	self.Button_Chick.OnReleased:Add(self.OnButton_Chick, self);
end


-- function TuYang_BPWidgetStatusBarIcon:Tick(MyGeometry, InDeltaTime)

-- end

-- function TuYang_BPWidgetStatusBarIcon:Destruct()

-- end

function TuYang_BPWidgetStatusBarIcon:InItializeWidget(InOwnerWidget,InKey)
   self.Key = InKey
   self.OwnerWidget = InOwnerWidget
   UGCLog.Log("TuYang_BPWidgetStatusBarIcon:SetIcon",self.Key)
   self.Image_0:SetBrushFromTexture(UE.LoadObject(TuYang_PlayerBuffConfig:GetItem(self.Key).Texture),true)
   --(SpecifiedColor=(R=0.287000,G=0.287000,B=0.287000,A=1.000000),ColorUseRule=UseColor_Specified)
   self.Image_0:SetColorAndOpacity({R=0.287000,G=0.287000,B=0.287000,A=0.800000})
end

function TuYang_BPWidgetStatusBarIcon:OnButton_Chick()
   if self.OwnerWidget then
      self.OwnerWidget:OpenDetail(self.Key)
   end
end

function TuYang_BPWidgetStatusBarIcon:SetAlreadyHaveBuff()
   
   self.Image_0:SetColorAndOpacity({R=1.000000,G=1.000000,B=1.000000,A=1.000000})
   
end
return TuYang_BPWidgetStatusBarIcon