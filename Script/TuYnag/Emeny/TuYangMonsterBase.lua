---@class TuYangMonsterBase_C:STExtraSimpleCharacter
---@field ID int32
--Edit Below--
local TuYangMonsterBase = {}
 
--[[
function TuYangMonsterBase:ReceiveBeginPlay()
    TuYangMonsterBase.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function TuYangMonsterBase:ReceiveTick(DeltaTime)
    TuYangMonsterBase.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYangMonsterBase:ReceiveEndPlay(EndPlayReason)
    print("TuYangMonsterBase:ReceiveEndPlay")
    print("TuYangMonsterBase:ReceiveEndPlay"..self.ID)
    
    local GameState = GameplayStatics.GetGameState(self)
    if self.ID == 1 then
        GameState.iID2DeadNum = GameState.iID2DeadNum + 1
        else if self.ID == 2 then
            GameState.iID1KillNum = GameState.iID1KillNum + 1
        end
    end

    TuYangMonsterBase.SuperClass.ReceiveEndPlay(self,EndPlayReason)
end


--[[
function TuYangMonsterBase:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYangMonsterBase:GetAvailableServerRPCs()
    return
end
--]]

function  TuYangMonsterBase:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        -- EventInstigator.PlayerState:AddEnemyCount() 
        -- EventInstigator.PlayerState:AddDamageCount(Damage)
    end
end

return TuYangMonsterBase