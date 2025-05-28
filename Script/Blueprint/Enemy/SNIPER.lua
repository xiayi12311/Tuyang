local SNIPER = {}

DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
SNIPER.gold = 20

SNIPER.CampID = 0
function SNIPER:ReceiveBeginPlay()
    SNIPER.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function SNIPER:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    ugcprint("SNIPER怪物血量"..self.Health)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        --EventInstigator.PlayerState:MonsterDiedAddHot(self.MonsterDiedAddHotNum)
    end
end

function SNIPER:ReceiveEndPlay()
    if not self:HasAuthority() then
        return
    end

    local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 3)

    UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
    end
end

--[[
function SNIPER:ReceiveBeginPlay()
    SNIPER.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function SNIPER:ReceiveTick(DeltaTime)
    SNIPER.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SNIPER:ReceiveEndPlay()
    SNIPER.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SNIPER:GetReplicatedProperties()
    return
end
--]]

--[[
function SNIPER:GetAvailableServerRPCs()
    return
end
--]]

return SNIPER