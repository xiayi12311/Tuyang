---@class StartSutitle_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Button_Skip UButton
---@field Text2 UUTRichTextBlock
--Edit Below--
local StartSutitle = { bInitDoOnce = false } 
local HStringRule = require("Script.HStringRule")

function StartSutitle:Construct()
    UGCLog.Log("StartSutitle:Construct")
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if PlayerController then
        PlayerController.StartSequenceUI = self
    end
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
	self.Button_Skip.OnReleased:Add(
        function ()
			local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:ServerRPC_SkipGameStartSequence()
			self:RemoveFromParent()
        end
    )
    -- local tstring = "我拥有<abc>15次</>巴拉巴拉"
    -- tstring = HStringRule:LabelRelevantFontsAccordingToTheRules(tstring)
    -- UGCLog.Log("tstring = ",tstring)
    -- self.Text2:SetText(tstring)
end
-- Construct ]==]

-- function StartSutitle:Tick(MyGeometry, InDeltaTime)

-- end

-- function StartSutitle:Destruct()

-- end

return StartSutitle