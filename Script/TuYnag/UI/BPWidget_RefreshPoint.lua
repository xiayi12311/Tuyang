---@class BPWidget_RefreshPoint_C:UUserWidget
---@field Button_Buy1 UButton
---@field Button_Buy2 UButton
---@field Button_Buy3 UButton
---@field Button_Close UButton
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
--Edit Below--
local BPWidget_RefreshPoint = { bInitDoOnce = false } 


function BPWidget_RefreshPoint:Construct()
	
   
    self.Button_Close.OnReleased:Add(self.Button_Close_OnReleased, self);
    self.Button_Buy1.OnReleased:Add(self.Button_Buy1_OnReleased, self);
    self.Button_Buy2.OnReleased:Add(self.Button_Buy2_OnReleased, self);
    self.Button_Buy3.OnReleased:Add(self.Button_Buy3_OnReleased, self);
end


-- function BPWidget_RefreshPoint:Tick(MyGeometry, InDeltaTime)

-- end

-- function BPWidget_RefreshPoint:Destruct()

-- end

function BPWidget_RefreshPoint:Button_Buy_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRefreshPoint()
end
function BPWidget_RefreshPoint:Button_Close_OnReleased()
    self:RemoveFromViewport()
end

function BPWidget_RefreshPoint:Button_Buy1_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRefreshPoint(1)
end
function BPWidget_RefreshPoint:Button_Buy2_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRefreshPoint(10)
end
function BPWidget_RefreshPoint:Button_Buy3_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRefreshPoint(20)
end
return BPWidget_RefreshPoint