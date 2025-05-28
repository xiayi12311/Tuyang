---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Spawn_Insect = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
Spawn_Insect.MonsterClass = nil
   
function Spawn_Insect:ReceiveBeginPlay()
    ugcprint("Spawn_Insect begin！")
    Spawn_Insect.SuperClass.ReceiveBeginPlay(self)
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
function Spawn_Insect:ReceiveTick(DeltaTime)
    Spawn_Insect.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Spawn_Insect:ReceiveEndPlay()
    Spawn_Insect.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Spawn_Insect:GetReplicatedProperties()
    return
end
--]]

--[[
function Spawn_Insect:GetAvailableServerRPCs()
    return
end
--]]
function Spawn_Insect:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Insect/Insect.Insect_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function Spawn_Insect:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return Spawn_Insect