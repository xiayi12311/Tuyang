---@class Tesla_1_C:STExtraSimpleCharacter
---@field P_Prop02_buoy UParticleSystemComponent
---@field Scene USceneComponent
---@field Capsule UCapsuleComponent
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Tesla_lv2 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
Tesla_lv2.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_lv2/Respawn/Tesla_1_Respawn.Tesla_1_Respawn_C'))
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
Tesla_lv2.gold = 300
Tesla_lv2.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
function Tesla_lv2:ReceiveBeginPlay()
    Tesla_lv2.SuperClass.ReceiveBeginPlay(self)
    self.StaticMesh:K2_AttachToComponent(
		self.Mesh,"item_r")
	self.Scene:K2_AttachToComponent(self.Mesh,"HelmetSocket")
	self.RespawnLocation = self:K2_GetActorLocation()
	self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end
--
function Tesla_lv2:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
		EventInstigator.PlayerState:AddEnemyCount() 
		
        
    end
	EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Tesla_lv2:ReceiveTick(DeltaTime)
    Tesla_lv2.SuperClass.ReceiveTick(self, DeltaTime)
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
		UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function Tesla_lv2:ReceiveEndPlay()
    Tesla_lv2.SuperClass.ReceiveEndPlay(self) 
	if self:HasAuthority() then 
		local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 3)

		local location = self:K2_GetActorLocation()
		if location.Z<0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
end


--[[
function Tesla_lv2:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla_lv2:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function Tesla_lv2:LuaInit()
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

function Tesla_lv2:Mesh_OnAnimInitialized()
	return nil;
end

function Tesla_lv2:Die()
    local Montage = UE.LoadObject()
    self.Mesh:PlayAnimation()
end
-- [Editor Generated Lua] function define End;

return Tesla_lv2