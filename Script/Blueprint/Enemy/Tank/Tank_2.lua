---@class Tank_2_C:BPPawn_Tank_C
---@field Taskiconred UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local Tank = 
{
    IsFight = false,
    IsShow = false
}

DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
Tank.gold = 200
Tank.TankUI = nil;

local WalkSound 
local TimeSet

Tank.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Sniper/Respawn/Sniper_Respawn.Sniper_Respawn_C'))
Tank.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle4.DropParticle4_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
local axis ={1 ,2,4,4}
function Tank:ReceiveBeginPlay()
    ugcprint("respawn complete");
    Tank.SuperClass.ReceiveBeginPlay(self);
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


function Tank:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        local SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/squence/Sequence_Sync/SpawnFirstBoss_2.SpawnFirstBoss_2_C'))
        local BossSequence = ScriptGameplayStatics.SpawnActor(self,SequenceActor,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
    
end



function Tank:ReceiveTick(DeltaTime)
    Tank.SuperClass.ReceiveTick(self, DeltaTime);   
    -- local health = UGCSimpleCharacterSystem.GetHealth(self);
    -- if health>=5 then
    --     UGCSimpleCharacterSystem.SetHealth(self,health-5);
    -- end
      --ugcprint("Tank tick ")
      if self.IsShow then --血条ui
        ugcprint("Fight Tick")
             self:SentHealth()
     end
     if self.health <=0 and self.HasPlay ==false then
         ugcprint("going to play particle")
         self.HasPlay = true;
        -- STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
         --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
         UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)

     end
    
end



function Tank:ReceiveEndPlay()		
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
    --EventSystem:SendEvent("TankEnd");
    if not self:HasAuthority() then --有延迟bug,过去很久再运行，似乎包括下面的spawnitem，客户端会有一个无法拾取的物品
        
        self.TankUI:RemoveFromViewport();
        self.TankUI = nil
    end

     


end


function Tank:GetReplicatedProperties()
    return
    "IsFight",
    "IsShow"
end

--[[
function Tank:GetAvailableServerRPCs()
    return
end
--]]
function Tank:StartFight()
    ugcprint("Tank Start fight")
    if self:HasAuthority() then
        if not self.IsShow then
            self.IsShow = true
            
        end
    end

end
function Tank:ShowUI()
    ugcprint("RPC Tank Show UI")
    --.IsShow = true;
        --ugcprint("Tank load UI") 
        local UIClass  = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/UI/TankUI.TankUI_C");
        local PlayerController = GameplayStatics.GetPlayerController(self, 0);
        self.TankUI = UserWidget.NewWidgetObjectBP(PlayerController,UIClass);
        self.TankUI:AddToViewport(0)
        EventSystem:SendEvent("TankUI",1);
   
    
end

function Tank:SentHealth()
    local health = UGCSimpleCharacterSystem.GetHealth(self)
    local mhealth = UGCSimpleCharacterSystem.GetHealthMax(self)
    local h = health/mhealth
    -- local health = UGCSimpleCharacterSystem.GetHealth(self)
    -- local h = health/10000
    EventSystem:SendEvent("TankUI",h);
end

function Tank:Walk(DeltaTime)
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
function Tank:IsVelocityZero() 
    local velocity = self:GetVelocity()
    return (velocity.x == 0 and velocity.y == 0 and velocity.z == 0)
end
return Tank