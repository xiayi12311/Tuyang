---@class SpawnTesla_1_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnBLC = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnBLC.MonsterClass = nil
   
function SpawnBLC:ReceiveBeginPlay()
    ugcprint("SpawnBLC begin！")
    SpawnBLC.SuperClass.ReceiveBeginPlay(self)
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
function SpawnBLC:ReceiveTick(DeltaTime)
    SpawnBLC.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnBLC:ReceiveEndPlay()
    SpawnBLC.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnBLC:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnBLC:GetAvailableServerRPCs()
    return
end
--]]
function SpawnBLC:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/BLC/BLC.BLC_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnBLC:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnBLC