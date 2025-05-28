---@class Tank_C:BPPawn_Tank_C
---@field Taskiconred UParticleSystemComponent
---@field FirstBossEnd_BL UChildActorComponent
--Edit Below--
local Tank = 
{
    IsFight = false,
    IsShow = false
}
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
local EventSystem =  require('Script.common.UGCEventSystem')
Tank.gold = 500
Tank.TankUI = nil;
--Tank.UIClass  = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/UI/TankUI.TankUI_C");
local WalkSound 
local TimeSet
local axis ={1 ,2,4,4}
Tank.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Sniper/Respawn/Sniper_Respawn.Sniper_Respawn_C'))
Tank.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Fbossrespawn_1__1.Fbossrespawn_1__1'))
function Tank:ReceiveBeginPlay()
    Tank.SuperClass.ReceiveBeginPlay(self)
    ugcprint("tank beginplay")
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    local health = UGCSimpleCharacterSystem.GetHealthMax(self)
    -- self.MH = 10000 * axis[difficulty] --math.pow好像用不了
    local MH = health * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/footstep1.footstep1')
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/footstep2.footstep2"
	WalkSound = UE.LoadObject(path)--AkAudioEvent'/Test/Asset/Blueprint/Test/Play_Grenade_Explosion.Play_Grenade_Explosion'
    TimeSet = 0.0
    ugcprint("Tank Show UI")
    --self.IsShow = true;
    -- if not self:HasAuthority() then
    --     ugcprint("Tank load UI") 
    --     local UIClass  = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/UI/TankUI.TankUI_C");
    --     local PlayerController = GameplayStatics.GetPlayerController(self, 0);
    --     self.TankUI = UserWidget.NewWidgetObjectBP(PlayerController,UIClass);
    --     self.TankUI:AddToViewport(0)
    --     EventSystem:SendEvent("TankUI",1);
    -- end
    --Tank:ShowUI()
end


function Tank:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold) 
        EventInstigator.PlayerState:AddEnemyCount() 
        
        if not self:HasAuthority() then --不生效 这个代理似乎不在客户端运行
            ugcprint("Boss ENd")
            self.TankUI:RemoveFromViewport();
            self.TankUI = nil
        end
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function Tank:ReceiveTick(DeltaTime)
    Tank.SuperClass.ReceiveTick(self, DeltaTime)
    --ugcprint("Tank tick ")
     if self.IsShow then --血条ui
       ugcprint("Fight Tick")
            self:SentHealth()
    end
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		--self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
    --if self.IsFight then --血条ui
       -- ugcprint("Fight Tick")
    --     if self.IsShow then
    --         self:SentHealth()
    --     else
    --         ugcprint("Tick show UI")
    --         self.IsShow = true
    --         if not self:HasAuthority() then  --显示UI,注意网络同步
    --             ugcprint("Tank load UI") 
    --             local UIClass  = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/UI/TankUI.TankUI_C");
    --             local PlayerController = GameplayStatics.GetPlayerController(self, 0);
    --             self.TankUI = UserWidget.NewWidgetObjectBP(PlayerController,UIClass);
    --             self.TankUI:AddToViewport(0)
    --             EventSystem:SendEvent("TankUI",1);
    --         end
    --     end
    -- end
    -- if self.Health <= 0 then
       
    --     local SequencePlayer = self.FirstBossEnd_BL.ChildActor
    --     if SequencePlayer then
    --         ugcprint("播放2")
    --         SequencePlayer.SequencePlayer:Play()
    --         ugcprint("播放3")
    --     end
    --     ugcprint("Boss ENd")
    --     self.TankUI:RemoveFromViewport();
    --     self.TankUI = nil
    -- end
    self:Walk(DeltaTime) --脚步声
    
end



function Tank:ReceiveEndPlay()
    ugcprint("TankDie") 
    if self:HasAuthority() then 
    -- local RespawnActor = UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/Skill/Respawn_1.Respawn_1_C"
    -- local RespawnClass = UE.LoadClass(RespawnActor)
    -- local BP_Hello = ScriptGameplayStatics.SpawnActor(self, RespawnClass, 
    -- self:K2_GetActorLocation(),    --坐标
    -- {Roll = 0, Pitch = 0, Yaw = 0},     --旋转
    -- {X = 1, Y = 1, Z = 1})              --缩				
   
end
    -- local SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/squence/Sequence_Sync/SpawnFirstBoss_2.SpawnFirstBoss_2_C'))
    -- if self:HasAuthority() then
	-- 	local BossSequence = ScriptGameplayStatics.SpawnActor(self,SequenceActor,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
	-- end
    
    -- if not self:HasAuthority() then --有延迟bug,过去很久再运行，似乎包括下面的spawnitem，客户端会有一个无法拾取的物品
    --     ugcprint("Boss ENd")
    --     self.TankUI:RemoveFromViewport();
    --     self.TankUI = nil
    -- end
    -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 6)

    -- UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
    -- Tank.SuperClass.ReceiveEndPlay(self) 
    -- local SequencePlayer = self.FirstBossEnd_BL.ChildActor
    --     if SequencePlayer then
    --         ugcprint("播放2")
    --         SequencePlayer.SequencePlayer:Play()
    --         ugcprint("播放3")
    --     end
    
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
           
            
            --GameplayStatics.GetPlayerController(self, 0);
            
        end
    end

end
function Tank:ShowUI()
    ugcprint("RPC Tank Show UI")
    --.IsShow = true;
        --ugcprint("Tank load UI") 
        local UIClass  = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/UI/TankUI.TankUI_C");
        local PlayerController = GameplayStatics.GetPlayerController(self, 0);
        -- self.TankUI = UserWidget.NewWidgetObjectBP(PlayerController,UIClass);
        -- self.TankUI:AddToViewport(0)
        -- EventSystem:SendEvent("TankUI",1);
   
    
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