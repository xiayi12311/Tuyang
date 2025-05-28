---@class BPWidget_RevivalCoin_C:UUserWidget
---@field Button_Buy UButton
---@field Button_Buy1 UButton
---@field Button_Buy2 UButton
---@field Button_Buy3 UButton
---@field Button_Close UButton
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
--Edit Below--
local BPWidget_RevivalCoin = { bInitDoOnce = false } 


function BPWidget_RevivalCoin:Construct()
	
    self.Button_Buy.OnReleased:Add(self.Button_Buy_OnReleased, self);
    self.Button_Buy1.OnReleased:Add(self.Button_Buy1_OnReleased, self);
    self.Button_Buy2.OnReleased:Add(self.Button_Buy2_OnReleased, self);
    self.Button_Buy3.OnReleased:Add(self.Button_Buy3_OnReleased, self);
    self.Button_Close.OnReleased:Add(self.Button_Close_OnReleased, self);
end


-- function BPWidget_RevivalCoin:Tick(MyGeometry, InDeltaTime)

-- end

-- function BPWidget_RevivalCoin:Destruct()

-- end

function BPWidget_RevivalCoin:Button_Buy_OnReleased()
    --local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    --PlayerController:BuyRevivalCoin()
end

function BPWidget_RevivalCoin:Button_Buy1_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRevivalCoin(1)
end
function BPWidget_RevivalCoin:Button_Buy2_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRevivalCoin(5)
end
function BPWidget_RevivalCoin:Button_Buy3_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:BuyRevivalCoin(10)
end
function BPWidget_RevivalCoin:Button_Close_OnReleased()
    self:RemoveFromViewport()
end
return BPWidget_RevivalCoin