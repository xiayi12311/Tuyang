---@class TuYang_WindCountRedSkill_A_1_4_Effect_C:AActor
---@field ActorSequence UActorSequenceComponent
---@field ParticleSystem UParticleSystemComponent
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_WindCountRedSkill_A_1_4_Effect = {}
 

function TuYang_WindCountRedSkill_A_1_4_Effect:ReceiveBeginPlay()
    TuYang_WindCountRedSkill_A_1_4_Effect.SuperClass.ReceiveBeginPlay(self)
    -- UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Effect_C:ReceiveBeginPlay",self.Box)
    

    if self:HasAuthority() then
        Timer.InsertTimer(0.5, function()

            -- UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Effect_C:ReceiveBeginPlay",self:K2_GetActorLocation().X,self:K2_GetActorLocation().Y,self:K2_GetActorLocation().Z)

            local OverlappingActors = {}
            self.Box:GetOverlappingActors(OverlappingActors)

            for k, OverlappingActor in pairs(OverlappingActors) do
                -- UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Effect_C:Character:", self:GetInstigator())
                
                if OverlappingActor ~= self:GetInstigator() then
                    local Damage = UGCGameSystem.ApplyDamage(OverlappingActor, 50, self:GetInstigator():GetPlayerControllerSafety(), self:GetInstigator())
                end
            end
        end,true)
    end
    
end


--[[
function TuYang_WindCountRedSkill_A_1_4_Effect:ReceiveTick(DeltaTime)
    TuYang_WindCountRedSkill_A_1_4_Effect.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_WindCountRedSkill_A_1_4_Effect:ReceiveEndPlay()
    TuYang_WindCountRedSkill_A_1_4_Effect.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_WindCountRedSkill_A_1_4_Effect:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WindCountRedSkill_A_1_4_Effect:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_WindCountRedSkill_A_1_4_Effect