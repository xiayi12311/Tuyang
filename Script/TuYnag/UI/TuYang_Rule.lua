---@class TuYang_Rule_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field Button_0 UButton
---@field LeftDown UImage
---@field LeftUp UImage
---@field Logo UImage
---@field RightDown UImage
---@field RightUp UImage
---@field Rule1 UImage
---@field Rule2 UImage
---@field Rule3 UImage
--Edit Below--
local TuYang_Rule = { bInitDoOnce = false } 


function TuYang_Rule:Construct()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    self.Button_0.OnClicked:Add(self.Button_0_OnClicked, self);
end


-- function TuYang_Rule:Tick(MyGeometry, InDeltaTime)

-- end

-- function TuYang_Rule:Destruct()

-- end


function TuYang_Rule:Button_0_OnClicked()
    -- 跳过开场动画
    
    -- 打开卡牌界面
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:ChooseRoundStartBuff()
    -- 武器商店选择界面
    PlayerController:ServerRPC_RefreshTheWeaponList()
    self:RemoveFromViewport()
end
return TuYang_Rule