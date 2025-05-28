---@class Level_20_C:STExtraSimpleCharacter
---@field P_Plan_light_red_02 UParticleSystemComponent
---@field P_Drop_Trail_Red UParticleSystemComponent
---@field Scene USceneComponent
---@field Capsule UCapsuleComponent
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Level_20 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
--Level_20.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Level_20/Respawn/Tesla_2_Respawn.Tesla_2_Respawn_C'))
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Level_20.gold = 125
Level_20.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
	--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle3.DropParticle3_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsRespawn = true
Level_20.CampID = 0
function Level_20:ReceiveBeginPlay()
    Level_20.SuperClass.ReceiveBeginPlay(self)
    self.StaticMesh:K2_AttachToComponent(
		self.Mesh,"item_r")
	self.Scene:K2_AttachToComponent(self.Mesh,"HelmetSocket")
	self.RespawnLocation = self:K2_GetActorLocation()
	self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
	local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local Location = self:K2_GetActorLocation().X
    local RegionCount =Gamestate:GetRegionCount()
    for i =2 ,RegionCount do
   
		if  Location >= Region[i] and Location <= Region[i-1] then
			local j =i+1
			local text = ("Spawn" ..j)
        ugcprint(text)
        EventSystem:AddListener(text,self.ReceiveEnd,self)
    end
end
end
--
function Level_20:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
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

function Level_20:ReceiveTick(DeltaTime)
    Level_20.SuperClass.ReceiveTick(self, DeltaTime)
	if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play montage")
		self.HasPlay = true;
		-- self.Mesh:PlayAnimation(self.MontageDeath2,false);
		local SkillManager = self:GetSkillManagerComponent()
		if SkillManager ~= nil then
			--释放120号技能
			SkillManager:TriggerEvent(1, UTSkillEventType.SET_KEY_DOWN)
		end
		STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
		--local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
		UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function Level_20:ReceiveEndPlay()
    Level_20.SuperClass.ReceiveEndPlay(self) 
	--local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	if self:HasAuthority() and IsRespawn then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        --local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 3)

		local location = self:K2_GetActorLocation()
		if location.Z<0 then
			location.Z = 0
		end
      --  UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
	local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
    end
end


--[[
function Level_20:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_20:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function Level_20:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	--self.Mesh.OnAnimInitialized:Add(self.Mesh_OnAnimInitialized, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function Level_20:Mesh_OnAnimInitialized()
	return nil;
end

function Level_20:Die()
    local Montage = UE.LoadObject()
    self.Mesh:PlayAnimation()
end
-- [Editor Generated Lua] function define End;
	function Level_20:ReceiveEnd()
		IsRespawn =false
		--UGCGameSystem.ApplyDamage(self,1000)
	end
return Level_20