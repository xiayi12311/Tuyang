---@class Level_3_C:BP_YXMonsterBase_C
---@field UAESkillManager UUAESkillManagerComponent
---@field UAEMonsterAnimList_Base UAEMonsterAnimList_Base_C
--Edit Below--
local Level_3 = {}

local EventSystem =  require('Script.common.UGCEventSystem')
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Level_3.gold = 100
 
Level_3.HasPlay = false
local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))

local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

Level_3.CampID = 0
function Level_3:ReceiveBeginPlay()
    Level_3.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)

    -- Timer.InsertTimer(1.5,function()
    --     self.bActorLabelEditable = true
    --     self.ActorLabel = "狼人1"
    -- end,false)

end

function Level_3:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount()         
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function Level_3:ReceiveEndPlay()
    Level_3.SuperClass.ReceiveEndPlay(self) 
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
    end
end


function Level_3:ReceiveTick(DeltaTime)
    Level_3.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
       STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

--[[
function Level_3:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_3:GetAvailableServerRPCs()
    return
end
--]]

return Level_3