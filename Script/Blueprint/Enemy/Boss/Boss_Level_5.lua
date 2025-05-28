---@class Boss_Level_5_C:STExtraSimpleCharacter
---@field Taskiconred UParticleSystemComponent
---@field P_WereWolf_Eye_01 UParticleSystemComponent
---@field Box UBoxComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
--Edit Below--
----@class Boss_C:STExtraSimpleCharacter
--丙火临巳 庚金化水 乙木参天
-- 大吉大利 一鸣惊人！
local Boss_Level_5 = {
    MH =7777
}
 
local UIClass
Boss_Level_5.bossUI = nil;
local EventSystem =  require('Script.common.UGCEventSystem')
--local EntryParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Spawn/EntryParticle2.EntryParticle2_C'))
local Bullet
Boss_Level_5.HasShield = false
local Shield
--local AimActor
Boss_Level_5.Isplay_UI = false
Boss_Level_5.Isplay_Montage = false
local axis ={1 ,2,4,4}
local WalkSound 
local TimeSet
-- local KDGClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/KanDaoGuai_3.KanDaoGuai_3_C'))
-- local Tesla1Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_1_2.Tesla_1_2_C'))
-- local Tesla2Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_2/Tesla_2_1.Tesla_2_1_C'))
-- local Tesla3Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_3/Tesla_3_1.Tesla_3_1_C'))
-- local Tesla4Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_2_2.Tesla_2_2_C'))
-- local Tesla5Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_4/Tesla_5_1.Tesla_5_1_C'))
-- local Tesla6Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_6/Tesla_6_1.Tesla_6_1_C'))
function Boss_Level_5:ReceiveBeginPlay()
    Boss_Level_5.SuperClass.ReceiveBeginPlay(self)
    ugcprint("Boss_Level_5 Start")
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    -- self.MH = 15000 * axis[difficulty] --math.pow好像用不了
    local MH = 7777 * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    
    UIClass  = UE.LoadClass( UGCMapInfoLib.GetRootLongPackagePath().. 'Asset/Blueprint/Enemy/Boss_Level_5/UI/BossUI.BossUI_C');
    Bullet = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss_Level_5/BossBullet.Bossbullet_C'))
    Shield = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss_Level_5/shield/Shield.Shield_C'))
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/bossfootstep.bossfootstep"
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bossfootstep.bossfootstep')
	WalkSound = UE.LoadObject(path)--AkAudioEvent'/Test/Asset/Blueprint/Test/Play_Grenade_Explosion.Play_Grenade_Explosion'UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_2_2.Tesla_2_2_C')
    TimeSet = 0.0
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0);
    -- self.bossUI = UserWidget.NewWidgetObjectBP(PlayerController,UIClass);
    -- self.bossUI:AddToViewport(0)
    --EventSystem:SendEvent("BossUI",1);
end


function Boss_Level_5:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        ugcprint("Boss_Level_5怪物血量"..self.Health)
        EventInstigator.PlayerState:AddEnemyCount() 
        local gamestate = UGCGameSystem.GetGameState()
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Boss_Level_5:ReceiveTick(DeltaTime)
    Boss_Level_5.SuperClass.ReceiveTick(self, DeltaTime)
    local health = UGCSimpleCharacterSystem.GetHealth(self)
    local mhealth = UGCSimpleCharacterSystem.GetHealthMax(self)
    local h = health/mhealth
    --EventSystem:SendEvent("BossUI",h);
    if self.HasShield then
        UGCSimpleCharacterSystem.SetHealth(self,health+5) 
        ugcprint("Is Healing " ..health)
    end
    if health <=0 then
        if not self:HasAuthority() then
            if self.Isplay_UI == false then
            ugcprint("Boss_Level_5 ENd")
            self.bossUI:RemoveFromViewport();
            self.bossUI = nil
            ugcprint("Play Monatage")
            self.Isplay  = true;
            self:K2_DestroyActor();
            end
        end
        if  self:HasAuthority() then
        	if self.Isplay_Montage ==false then
			ugcprint("going to play montage")
			self.Isplay_Montage = true;
			-- self.Mesh:PlayAnimation(self.MontageDeath2,false);
			local SkillManager = self:GetSkillManagerComponent()
			if SkillManager ~= nil then
				--释放5号技能
				SkillManager:TriggerEvent(5, UTSkillEventType.SET_KEY_DOWN)
			end
            end

		end
    -- else
    --     if self:HasAuthority() then
    --         if self.HasShield == true then
    --             ugcprint("boss is Healing" ..health)
    --             UGCSimpleCharacterSystem.SetHealth(health+10) 
    --         end
    --     end

    end

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



function Boss_Level_5:ReceiveEndPlay()
    ugcprint("Boss_Level_5 ENd!")
  
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    if difficulty ==4 then
        if self:HasAuthority() then
        local SpanEnemy = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Spawn/SpawnEnemy4.SpawnEnemy4_C'))
        local SpanEnemy1= ScriptGameplayStatics.SpawnActor(self,SpanEnemy,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    else
    local SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss_Level_5/Sequence/SpawnENdBoss.SpawnEndBoss_C'))
    
        local PlayerControllers = UGCGameSystem.GetAllPlayerController()
        for _,Controller in pairs(PlayerControllers) do
            Controller:UpLoad() 
        end
    if self:HasAuthority() then
		local BossSequence = ScriptGameplayStatics.SpawnActor(self,SequenceActor,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
	end
    if not self:HasAuthority() then
        ugcprint("Boss_Level_5 ENd")
        self.bossUI:RemoveFromViewport();
        self.bossUI = nil
    end
end
   
    Boss_Level_5.SuperClass.ReceiveEndPlay(self) 
    
 

end



function Boss_Level_5:GetReplicatedProperties()
    return
    "HasShield",
    "MH"
end


--[[
function Boss_Level_5:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function Boss_Level_5:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	--self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Mesh.OnAnimInitialized:Add(self.Mesh_OnAnimInitialized, self);
	self.Mesh.OnComponentHit:Add(self.Mesh_OnComponentHit, self);
	-- [Editor Generated Lua] BindingEvent End;
end

-- function Boss_Level_5:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
-- 	return nil;
-- end

function Boss_Level_5:Mesh_OnAnimInitialized()
	return nil;
end

function Boss_Level_5:Mesh_OnComponentHit(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit)
	return nil;
end

-- [Editor Generated Lua] function define End;


function Boss_Level_5:ShootBullet()
    ugcprint("Boss_Level_5 Shoot BUllet")
    local controller = self:GetController();
    local MyBlack = controller:GetBlackBoardComponent();
	local MyTarget = MyBlack:GetValueAsObject("Target");--Target
    local TargetLocation = MyTarget:GetLocation();
    local Location = self:K2_GetActorLocation()
    local Rotation = self:K2_GetActorRotation()
    if self:HasAuthority() then
    local BP_Bullet = ScriptGameplayStatics.SpawnActor(self,Bullet,{X = Location.X,Y = Location.Y,Z = Location.Z} ,{Roll = Rotation.Roll,Pitch = Rotation.Pitch+30,Yaw = Rotation.Yaw+60},{X = 1, Y = 1, Z = 1},self);
    local BP_Bullet1 = ScriptGameplayStatics.SpawnActor(self,Bullet,{X = Location.X,Y = Location.Y,Z = Location.Z} ,{Roll = Rotation.Roll,Pitch = Rotation.Pitch+30,Yaw = Rotation.Yaw-60},{X = 1, Y = 1, Z = 1},self);
    end
end

function Boss_Level_5:SetShield()

    if self.HasShield == true then
        self.HasShield = false
    else
        self.HasShield = true
    end
end

function Boss_Level_5:SetHasShieldOn()
    ugcprint("Shield ON!")
    Boss_Level_5.HasShield = true
    --
    local BP_Shield = ScriptGameplayStatics.SpawnActor(
        self,
        Shield,
        self:K2_GetActorLocation(),
        self:K2_GetActorRotation(),
        {X = 1, Y = 1, Z = 1});
        --local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,{X=-47664.335938,Y=18858.203125,Z=419.811157},self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        --local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,{X=-47271.000000,Y=20951.689453,Z=416.060699},self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
       -- local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,{X=-47784.804688,Y=20006.125000,Z=5.419220},self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
       -- local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,{X=-45450.000000,Y=20000.000000,Z=5.000000},self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    if self:HasAuthority() then
        UGCGameSystem.SetTimer(self,self.SpawnEnemy,5,false)--?
    
    
    --local BP_Bullet1 = ScriptGameplayStatics.SpawnActor(self,Bullet,{X = Location.X,Y = Location.Y,Z = Location.Z} ,{Roll = Rotation.Roll,Pitch = Rotation.Pitch+30,Yaw = Rotation.Yaw-60},{X = 1, Y = 1, Z = 1},self);
    end
end

function Boss_Level_5:SetHasShieldEnd()

    Boss_Level_5.HasShield = false
   
end

function Boss_Level_5:SetTarget()
    ugcprint("Set Target")
    local AimActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss_Level_5/Effect/RangeActor.RangeActor_C'))
    local controller = self:GetController();
    local MyBlack = controller:GetBlackBoardComponent();
    
	local MyTarget = MyBlack:GetValueAsObject("Target");--Target
    --local Fvector = MyTarget:GetLocation()
    local Fvector = MyTarget:K2_GetActorLocation();
    Fvector.Z = Fvector.Z-60
    local AimTarget = ScriptGameplayStatics.SpawnActor(
        self,
        AimActor,
        Fvector,
        {Pitch =0,Yaw = 0;Roll = 0},
        {X = 1, Y = 1, Z = 1});
    MyBlack:SetValueAsObject("AimTarget",AimTarget)
    -- MyBlack:SetValueAsVector("AimLocation",Fvector)
    ugcprint("Fvector is  " ..Fvector.X)
    

end

function Boss_Level_5:IsVelocityZero() 
    local velocity = self:GetVelocity()
    return (velocity.x == 0 and velocity.y == 0 and velocity.z == 0)
end

function Boss_Level_5:Walk(DeltaTime)
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
function Boss_Level_5:SpawnEnemy()
    ugcprint("Boss_Level_5 Spawn!")
    local GameMode = UGCGameSystem.GetGameMode()
   -- local KDGClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/KanDaoGuai_3.KanDaoGuai_3_C'))
   -- local Tesla1Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_1_2.Tesla_1_2_C'))
   -- local Tesla2Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_2/Tesla_2_1.Tesla_2_1_C'))
   -- local Tesla3Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_3/Tesla_3_1.Tesla_3_1_C'))
   -- local Tesla4Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_2_2.Tesla_2_2_C'))
   -- local Tesla5Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_4/Tesla_5_1.Tesla_5_1_C'))
   -- local Tesla6Class = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_6/Tesla_6_1.Tesla_6_1_C'))
   -- local KDG= ScriptGameplayStatics.SpawnActor(GameMode,KDGClass,{X=-45360.000000,Y=20460.000000,Z=5.00000} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
   -- local Tesla1= ScriptGameplayStatics.SpawnActor(GameMode,Tesla1Class,{X=-47053.628906,Y=20503.080078,Z=5.419220} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    --local Tesla2= ScriptGameplayStatics.SpawnActor(GameMode,Tesla2Class,{X=-47360.000000,Y=20060.000000,Z=5.00000} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
   -- local Tesla3= ScriptGameplayStatics.SpawnActor(GameMode,Tesla3Class,{X=-47784.804688,Y=19536.125000,Z=5.419220} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
   -- local Tesla4= ScriptGameplayStatics.SpawnActor(GameMode,Tesla4Class,{X=-47784.804688,Y=19082.367188,Z=5.419220} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
  --  local Tesla5= ScriptGameplayStatics.SpawnActor(GameMode,Tesla5Class,{X=-47664.335938,Y=18858.203125,Z=419.811157} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self); --狙击怪
   -- local Tesla5= ScriptGameplayStatics.SpawnActor(GameMode,Tesla5Class,{X=-47271.000000,Y=20951.689453,Z=416.060699} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);--狙击怪
  --  local Tesla6_1= ScriptGameplayStatics.SpawnActor(GameMode,Tesla6Class,{X=-47580.109375,Y=20081.804688,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
  --  local Tesla6_2= ScriptGameplayStatics.SpawnActor(GameMode,Tesla6Class,{X=-47580.109375,Y=19924.150391,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
   -- local Tesla6_3= ScriptGameplayStatics.SpawnActor(GameMode,Tesla6Class,{X=-47387.523438,Y=19974.542969,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
   -- local Tesla6_4= ScriptGameplayStatics.SpawnActor(GameMode,Tesla6Class,{X=-47580.109375,Y=19744.189453,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
   -- local Tesla6_5= ScriptGameplayStatics.SpawnActor(GameMode,Tesla6Class,{X=-47387.523438,Y=19813.304688,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local KDG= ScriptGameplayStatics.SpawnActor(self,KDGClass,{X=-45360.000000,Y=20460.000000,Z=5.00000} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla1= ScriptGameplayStatics.SpawnActor(self,Tesla1Class,{X=-47053.628906,Y=20503.080078,Z=5.419220} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla2= ScriptGameplayStatics.SpawnActor(self,Tesla2Class,{X=-47360.000000,Y=20060.000000,Z=5.00000} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla3= ScriptGameplayStatics.SpawnActor(self,Tesla3Class,{X=-47784.804688,Y=19536.125000,Z=5.419220} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla4= ScriptGameplayStatics.SpawnActor(self,Tesla4Class,{X=-47784.804688,Y=19082.367188,Z=5.419220} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla5= ScriptGameplayStatics.SpawnActor(self,Tesla5Class,{X=-47664.335938,Y=18858.203125,Z=419.811157} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self); --狙击怪
    -- local Tesla5= ScriptGameplayStatics.SpawnActor(self,Tesla5Class,{X=-47271.000000,Y=20951.689453,Z=416.060699} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);--狙击怪
    -- local Tesla6_1= ScriptGameplayStatics.SpawnActor(self,Tesla6Class,{X=-47580.109375,Y=20081.804688,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla6_2= ScriptGameplayStatics.SpawnActor(self,Tesla6Class,{X=-47580.109375,Y=19924.150391,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla6_3= ScriptGameplayStatics.SpawnActor(self,Tesla6Class,{X=-47387.523438,Y=19974.542969,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla6_4= ScriptGameplayStatics.SpawnActor(self,Tesla6Class,{X=-47580.109375,Y=19744.189453,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
    -- local Tesla6_5= ScriptGameplayStatics.SpawnActor(self,Tesla6Class,{X=-47387.523438,Y=19813.304688,Z=5.419067} ,{Pitch = 0,Yaw = 0,Roll = 0},{X = 1, Y = 1, Z = 1},self);
end
return Boss_Level_5