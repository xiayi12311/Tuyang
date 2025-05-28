---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnKDG = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnKDG.MonsterClass = nil
   
function SpawnKDG:ReceiveBeginPlay()
    ugcprint("SpawnKDG begin！")
    SpawnKDG.SuperClass.ReceiveBeginPlay(self)
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
function SpawnKDG:ReceiveTick(DeltaTime)
    SpawnKDG.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnKDG:ReceiveEndPlay()
    SpawnKDG.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnKDG:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnKDG:GetAvailableServerRPCs()
    return
end
--]]
function SpawnKDG:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/WereWolf2/WereWolf2.WereWolf2_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnKDG:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnKDG