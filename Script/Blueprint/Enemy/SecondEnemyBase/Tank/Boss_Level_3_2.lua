---@class Boss_Level_3_2_C:BP_YXMonsterBase_C
---@field UAESkillManager UUAESkillManagerComponent
---@field MonsterAnimList_Boss_Level_3_2 MonsterAnimList_Boss_Level_3_2_C
---@field BP_PathInterpSync BP_PathInterpSync_C
---@field TurnAroundView UTurnAroundViewComponent
---@field PVEProjectileMovement UPVEProjectileMovementComponent
---@field BP_ProduceDropItemComponent BP_ProduceDropItemComponent_C
---@field ParticleSystem UParticleSystemComponent
---@field ZombieShield UChildActorComponent
---@field Taskiconred UParticleSystemComponent
--Edit Below--
local Boss_Level_3_2 = {}
 
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
Boss_Level_3_2.gold = 200
Boss_Level_3_2.Boss_Level_3_2UI = nil;

local WalkSound 
local TimeSet

Boss_Level_3_2.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Sniper/Respawn/Sniper_Respawn.Sniper_Respawn_C'))
Boss_Level_3_2.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle4.DropParticle4_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
local axis ={1 ,2,4,4}
function Boss_Level_3_2:ReceiveBeginPlay()
    ugcprint("respawn complete");
    Boss_Level_3_2.SuperClass.ReceiveBeginPlay(self);
    self.ZombieShield:K2_AttachToComponent(self.Mesh,"item_r")
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    local health = UGCSimpleCharacterSystem.GetHealthMax(self)
    -- self.MH = 10000 * axis[difficulty] --math.pow好像用不了
    local MH = health * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    --upcprint()
    --local speed = UGCSimpleCharacterSystem.GetSpeedScale(self);
    --ugcprint("SpeedIS" ..speed);
    UGCSimpleCharacterSystem.SetSpeedScale(self,2);    

    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/footstep1.footstep1"
	WalkSound = UE.LoadObject(path)--AkAudioEvent'/Test/Asset/Blueprint/Test/Play_Grenade_Explosion.Play_Grenade_Explosion'
    TimeSet = 0.0
end


function Boss_Level_3_2:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        local SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/squence/Sequence_Sync/SpawnFirstBoss_2.SpawnFirstBoss_2_C'))
        local BossSequence = ScriptGameplayStatics.SpawnActor(self,SequenceActor,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
    
end



function Boss_Level_3_2:ReceiveTick(DeltaTime)
    Boss_Level_3_2.SuperClass.ReceiveTick(self, DeltaTime);   
    -- local health = UGCSimpleCharacterSystem.GetHealth(self);
    -- if health>=5 then
    --     UGCSimpleCharacterSystem.SetHealth(self,health-5);
    -- end
      --ugcprint("Boss_Level_3_2 tick ")
      if self.IsShow then --血条ui
        ugcprint("Fight Tick")
             --self:SentHealth()
     end
     if self.health <=0 and self.HasPlay ==false then
         ugcprint("going to play particle")
         self.HasPlay = true;
        -- STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
         --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
         UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)

     end
    
end



function Boss_Level_3_2:ReceiveEndPlay()		
    ugcprint("Boss ENd")	
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() then
        -- local SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/squence/Sequence_Sync/SpawnFirstBoss_2.SpawnFirstBoss_2_C'))
		-- local BossSequence = ScriptGameplayStatics.SpawnActor(self,SequenceActor,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        --local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 5)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
       -- UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
        local gamestate = UGCGameSystem.GetGameState()
        local currentDifficulty = gamestate:GetDifficulty()

        if currentDifficulty == 2 then
         
              -- 新增高难度过渡处理
        elseif currentDifficulty == 3 then
    
              -- 复用同一处理逻辑
        elseif currentDifficulty == 1 then
           
        else
            ugcprint("[ERROR] 未知难度等级："..tostring(currentDifficulty))
        end
          
        
    end
    --EventSystem:SendEvent("Boss_Level_3_2End");
    if not self:HasAuthority() then --有延迟bug,过去很久再运行，似乎包括下面的spawnitem，客户端会有一个无法拾取的物品
        
        self.Boss_Level_3_2UI:RemoveFromViewport();
        self.Boss_Level_3_2UI = nil
    end

     


end


function Boss_Level_3_2:GetReplicatedProperties()
    return
    "IsFight",
    "IsShow"
end

--[[
function Boss_Level_3_2:GetAvailableServerRPCs()
    return
end
--]]
function Boss_Level_3_2:StartFight()
    ugcprint("Boss_Level_3_2 Start fight")
    if self:HasAuthority() then
        if not self.IsShow then
            self.IsShow = true
            
        end
    end

end
function Boss_Level_3_2:ShowUI()
    ugcprint("RPC Boss_Level_3_2 Show UI")
    --.IsShow = true;
        --ugcprint("Boss_Level_3_2 load UI") 
        local UIClass  = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Boss_Level_3_2/UI/Boss_Level_3_2UI.Boss_Level_3_2UI_C");
        local PlayerController = GameplayStatics.GetPlayerController(self, 0);
        self.Boss_Level_3_2UI = UserWidget.NewWidgetObjectBP(PlayerController,UIClass);
        self.Boss_Level_3_2UI:AddToViewport(0)
        EventSystem:SendEvent("Boss_Level_3_2UI",1);
   
    
end

function Boss_Level_3_2:SentHealth()
    local health = UGCSimpleCharacterSystem.GetHealth(self)
    local mhealth = UGCSimpleCharacterSystem.GetHealthMax(self)
    local h = health/mhealth
    -- local health = UGCSimpleCharacterSystem.GetHealth(self)
    -- local h = health/10000
    EventSystem:SendEvent("Boss_Level_3_2UI",h);
end

function Boss_Level_3_2:Walk(DeltaTime)
    local bVelocityZero = self:IsVelocityZero()
    if not bVelocityZero then
        if TimeSet>= 1 then
            TimeSet = 0;
            UGCSoundManagerSystem.PlaySoundAttachActor(WalkSound,self,true)
        end 
        TimeSet = TimeSet+DeltaTime;
    else
        TimeSet = 0;
    end
end
function Boss_Level_3_2:IsVelocityZero() 
    local velocity = self:GetVelocity()
    return (velocity.x == 0 and velocity.y == 0 and velocity.z == 0)
end

return Boss_Level_3_2