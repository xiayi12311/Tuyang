local shooter = {}
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")

shooter.gold = 30
--shooter.MonsterDiedAddHotNum = 10

function shooter:ReceiveBeginPlay()
    shooter.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function shooter:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    ugcprint("shooter怪物血量"..self.Health)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        --EventInstigator.PlayerState:MonsterDiedAddHot(self.MonsterDiedAddHotNum)
    end
end


function shooter:ReceiveEndPlay()
    if not self:HasAuthority() then
        return
    end

    local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

    UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)

end

--[[
function shooter:ReceiveBeginPlay()
    shooter.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function shooter:ReceiveTick(DeltaTime)
    shooter.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function shooter:ReceiveEndPlay()
    shooter.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function shooter:GetReplicatedProperties()
    return
end
--]]

--[[
function shooter:GetAvailableServerRPCs()
    return
end
--]]

return shooter