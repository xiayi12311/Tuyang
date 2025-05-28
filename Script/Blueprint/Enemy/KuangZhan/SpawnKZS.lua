---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnKZS = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnKZS.MonsterClass = nil
   
function SpawnKZS:ReceiveBeginPlay()
    ugcprint("SpawnKZS begin！")
    SpawnKZS.SuperClass.ReceiveBeginPlay(self)
    self:GetMonsterClass()
    -- EventSystem:AddListener("Spawn1", function(num) 
    --     self:Spawn(num) 
    -- end)
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local Location = self:K2_GetActorLocation().X
    local RegionCount =Gamestate:GetRegionCount()
    for i =1 ,RegionCount do
   
    if  Location<= Region[i] and Location>= Region[i+1] then
        local text = ("Spawn" ..i)
        ugcprint(text)
        EventSystem:AddListener(text,self.TrySpawnMonster,self)
    end
end
    --EventSystem:AddListener("BossUI",self.SetPercent,self)
end


--[[
function SpawnKZS:ReceiveTick(DeltaTime)
    SpawnKZS.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnKZS:ReceiveEndPlay()
    SpawnKZS.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnKZS:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnKZS:GetAvailableServerRPCs()
    return
end
--]]
function SpawnKZS:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KuangZhan/KuangZhanl.KuangZhanl_C')--UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KuangZhan/KuangZhanl.KuangZhanl_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnKZS:TrySpawnMonster()
    ugcprint("spawnKZS !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnKZS