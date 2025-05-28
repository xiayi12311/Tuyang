---@class KanDaoGuai_3_C:UGC_Machete_BP_C
--Edit Below--
local kandaoguai = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local EventSystem = require("Script.Common.UGCEventSystem")
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
--kandaoguai.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/Respawn/KanDao_Respawn.KanDao_Respawn_C'))
kandaoguai.gold = 50
kandaoguai.MonsterDiedAddHotNum = 10
kandaoguai.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
--local MoveClass = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/Move_KDG_1.Move_KDG_1_C'))
kandaoguai.MoveActor =nil
local HasPlay = false
function kandaoguai:ReceiveBeginPlay()
    kandaoguai.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    if self:HasAuthority() then
		self.MoveActor = ScriptGameplayStatics.SpawnActor(self,MoveClass,{X=-45620.000000,Y=19900.000000,Z=60.000000},self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
	end
    ugcprint("SPawn Enter particle!")
	local EnterParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/P_Team_Season.P_Team_Season'))
	STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,EnterParticle,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
    ugcprint("KDG 3 !")
end


function kandaoguai:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        ugcprint("砍刀怪怪物血量"..self.Health)
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
       
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function kandaoguai:ReceiveTick(DeltaTime)
    kandaoguai.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
       -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function kandaoguai:ReceiveEndPlay()
    kandaoguai.SuperClass.ReceiveEndPlay(self)
    ugcprint("OpenWarm Sent")
    --EventSystem:SendEvent("OpenWarm");
    if self:HasAuthority() then 
        local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end 
    -- if not self:HasAuthority() then
    --     return 
    -- end

    -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

    -- UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)

end
function kandaoguai:IsHasPlay()
    ugcprint("KDG ReTurn HasPlay!")
    return self.HasPlay
end
function kandaoguai:SetHasPlay()

    self.HasPlay =true
end
function kandaoguai:GetMoveActor()
    return self.MoveActor
end
function kandaoguai:SetTarget()
    -- ugcprint("Set Target")
    -- local AimActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Effect/RangeActor.RangeActor_C'))
    -- local controller = self:GetController();
    -- local MyBlack = controller:GetBlackBoardComponent();
    
	-- local MyTarget = MyBlack:GetValueAsObject("Target");--Target
    -- --local Fvector = MyTarget:GetLocation()
    -- local Fvector = MyTarget:K2_GetActorLocation();
    -- Fvector.Z = Fvector.Z-60
    -- local AimTarget = ScriptGameplayStatics.SpawnActor(
    --     self,
    --     AimActor,
    --     Fvector,
    --     {Pitch =0,Yaw = 0;Roll = 0},
    --     {X = 1, Y = 1, Z = 1});
    -- MyBlack:SetValueAsObject("AimTarget",AimTarget)
    -- -- MyBlack:SetValueAsVector("AimLocation",Fvector)
    -- ugcprint("Fvector is  " ..Fvector.X)
    

end

--[[
function kandaoguai:GetReplicatedProperties()
    return
end
--]]

--[[
function kandaoguai:GetAvailableServerRPCs()
    return
end
--]]

return kandaoguai