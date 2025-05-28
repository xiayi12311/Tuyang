---@class NPC1_C:UUserWidget
---@field NPC_Anim UWidgetAnimation
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_4 UImage
---@field Image_5 UImage
--Edit Below--
local NPC1 = { bInitDoOnce = false } 

local EventSystem =  require('Script.common.UGCEventSystem')
function NPC1:Construct()
	self:PlayAnimation(self.NPC_Anim,0,0,EUMGSequencePlayMode.forward,1)
    EventSystem:AddListener("NPCUI1",self.Close,self)
end


-- function NPC1:Tick(MyGeometry, InDeltaTime)

-- end

-- function NPC1:Destruct()

-- end
function NPC1:Close()
    self:RemoveFromViewport()
end

return NPC1