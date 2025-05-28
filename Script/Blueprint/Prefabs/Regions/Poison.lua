---@class Poison_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
---@field Interval float
---@field DamageValue float
---@field Pawn UClass
---@field BoxScale FVector
---@field Orientation FRotator
--Edit Below--
local Poison = {
    -- PEBuffClassPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/PESkill/PoisonGasGrenade/PEBuff_Poison.PEBuff_Poison_C'),
    -- PEBuffClassPath = "Asset/Blueprint/PESkill/PoisonGasGrenade/Poison.Poison_C",
    PEBuffClass_Poision = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Skill/ToxicGrenade/PEBuff_Poison.PEBuff_Poison_C')),
    PEBuffClass_DamageIncrease = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Skill/ToxicGrenade/PEBuff_DamageIncrease.PEBuff_DamageIncrease_C')),
    TimeDelegate = nil,
    TimeHandle = nil,
    CameraShakePawnList = {}
}


function Poison:ReceiveBeginPlay()
    Poison.SuperClass.ReceiveBeginPlay(self)
    print("Poison Log:ReceiveBeginPlay()")

    if self:HasAuthority() then
        self.TimeHandle, self.TimerDelegate =  UGCGameSystem.SetTimer(self,
        function ()
            print("Poison Log: In [TimerTriggerFunc]")
            local OverlappingActors = {}
            self.Box:GetOverlappingActors(OverlappingActors)
            
            for k, OverlappingActor in pairs(OverlappingActors) do
                print("Poison Log: --Character:"..tostring(self:GetInstigator()))
                if OverlappingActor ~= self:GetInstigator() then
                    local Damage = UGCGameSystem.ApplyDamage(OverlappingActor, self.DamageValue, self:GetInstigator():GetPlayerControllerSafety(), self, EDamageType.STPointDamage)
                    
                    -- 判断是否已经震屏了
                    local IsFirstCameraShake = true;
                    for k, CameraShakePawn in pairs(self.CameraShakePawnList) do
                        if CameraShakePawn == OverlappingActor then
                            IsFirstCameraShake = false
                        end
                    end
                    
                    if IsFirstCameraShake then
                        if UE.IsA(OverlappingActor,self.PlayerPawn) then
                            if UE.IsValid(OverlappingActor:GetPlayerControllerSafety()) then
                                local PlayerController = OverlappingActor:GetPlayerControllerSafety()
                                UGCGameSystem.ClientPlayCameraShake(PlayerController, EPESkillCameraShakeType.E_PESKILL_CameraShake_Random, 1, 1)
                                table.insert(self.CameraShakePawnList,OverlappingActor)
                            end
                        end
                    end
                   
                    
                    print("Poison: Log --Damage:"..tostring(Damage))
                end
            end
        end,
        self.Interval,
        true)
    end
end


-- function Poison:ReceiveTick(DeltaTime)
--     Poison.SuperClass.ReceiveTick(self, DeltaTime)
-- end



-- function Poison:ReceiveEndPlay()
--     Poison.SuperClass.ReceiveEndPlay(self) 
-- end


--[[
function Poison:GetReplicatedProperties()
    return
end
--]]

--[[
function Poison:GetAvailableServerRPCs()
    return
end
--]]


return Poison