---@class Level_18_C:BP_YXMonsterBase_C
---@field UAESkillManager UUAESkillManagerComponent
---@field MonsterAnimList_Scientist MonsterAnimList_Scientist_C
---@field BP_PathInterpSync BP_PathInterpSync_C
---@field TurnAroundView UTurnAroundViewComponent
---@field PVEProjectileMovement UPVEProjectileMovementComponent
--Edit Below--
local Level_18 = {}
 
Level_18.gold = 120

Level_18.HasPlay = false

local axis ={1,2,4}
local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))

local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
Level_18.CampID = 0
function Level_18:ReceiveBeginPlay()
    Level_18.SuperClass.ReceiveBeginPlay(self)
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    -- self.MH = 10000 * axis[difficulty] --math.pow好像用不了
    local MH = 720 * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end


function Level_18:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 and EventInstigator and EventInstigator.PlayerState then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))

        
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)

        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:KuangZhan:OnSelfDeath - SpawnAnything")
            UGCGameSystem.SpawnActor(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end

function Level_18:ReceiveEndPlay()
    Level_18.SuperClass.ReceiveEndPlay(self) 
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function Level_18:ReceiveTick(DeltaTime)
    Level_18.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

--[[
function Level_18:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_18:GetAvailableServerRPCs()
    return
end
--]]

return Level_18