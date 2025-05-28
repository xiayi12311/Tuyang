---@class NPC2_C:UUserWidget
---@field NPC_Anim UWidgetAnimation
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_4 UImage
--Edit Below--
local NPC2 = { bInitDoOnce = false } 

local EventSystem =  require('Script.common.UGCEventSystem')
function NPC2:Construct()
    self:PlayAnimation(self.NPC_Anim,0,0,EUMGSequencePlayMode.forward,1)
	EventSystem:AddListener("NPCUI2",self.Close,self)
end


-- function NPC2:Tick(MyGeometry, InDeltaTime)

-- end

-- function NPC2:Destruct()

-- end
function NPC2:Close()
    self:RemoveFromViewport()
end
return NPC2