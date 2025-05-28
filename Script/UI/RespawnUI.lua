---@class RespawnUI_C:UUserWidget
---@field Anim UWidgetAnimation
---@field Button_1 UButton
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_3 UImage
---@field Image_4 UImage
---@field TextBlock_2 UTextBlock
---@field TextBlock_17 UTextBlock
--Edit Below--
local RespawnUI = { bInitDoOnce = false } 
local TimeCount = 45
local TimeSet = 0
local RespawnCount
function RespawnUI:Construct()
   -- self.Anim.OnAnimationFinished:Add(self.AnimEnd,self)
	--self:PlayAnimation(self.Anim,0,1,EUMGSequencePlayMode.forward,0)
    ugcprint("RespawnUI Construct")
    TimeCount = 45
    TimeSet = 0
    --self.Button_1.OnReleased:Add(self)
    self.Button_1.OnReleased:Add(self.Respawn, self)
    self:PlayAnimation(self.Anim,0,0,EUMGSequencePlayMode.Forward,1)
    self.TextBlock_2:SetText(""..TimeCount)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    RespawnCount = PlayerState:GetRealRespawnCount()
    self.TextBlock_17:SetText(RespawnCount)
end




function RespawnUI:Tick(MyGeometry, InDeltaTime)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    TimeCount = PlayerState:GetRespawnTime()
    RespawnCount = PlayerState:GetRealRespawnCount()
    
    self.TextBlock_2:SetText(""..TimeCount)    
    self.TextBlock_17:SetText(RespawnCount)
end

-- function RespawnUI:Destruct()

-- end
function RespawnUI:Respawn()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if RespawnCount > 0 then
        PlayerController:ServerRPC_Respawn(true)
        self:RemoveFromViewport()
    else
        PlayerController:ShowBuyRevivalCoinUIFirstOrder()
    end
end
function RespawnUI:Close()
    self:RemoveFromViewport()
end
return RespawnUI