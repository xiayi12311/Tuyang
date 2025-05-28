---@class HintBOSS_C:UUserWidget
---@field Captions_Anim UWidgetAnimation
---@field Image_95 UImage
---@field Image_97 UImage
---@field Image_98 UImage
---@field Image_137 UImage
---@field TextBlock_0 UTextBlock
---@field TextBlock_1 UTextBlock
---@field TextBlock_10 UTextBlock
--Edit Below--
local EnterGame = { bInitDoOnce = false } 

function EnterGame:Construct()
    self.Captions_Anim.OnAnimationFinished:Add(self.AnimEnd,self)
	self:PlayAnimation(self.Captions_Anim,0,1,EUMGSequencePlayMode.forward,1)
end


-- function EnterGame:Tick(MyGeometry, InDeltaTime)

-- end

-- function EnterGame:Destruct()

-- end

function EnterGame:AnimEnd()
    self:RemoveFromViewport()
end
return EnterGame