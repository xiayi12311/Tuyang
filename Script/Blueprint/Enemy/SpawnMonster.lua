---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnMonster = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnMonster.MonsterClass = nil
SpawnMonster.Region= nil 
   
function SpawnMonster:ReceiveBeginPlay()
    ugcprint("SpawnMonster begin！")
    SpawnMonster.SuperClass.ReceiveBeginPlay(self)
    self:GetMonsterClass()
    -- EventSystem:AddListener("Spawn1", function(num) 
    --     self:Spawn(num) 
    -- end)
    self.Region =
    {
        0,
        -6950.227051,
        -23192.306641,
        -41106.753906,
        -100000,
    }
    EventSystem:AddListener("Spawn1",self.TrySpawnMonster,self)
    --EventSystem:AddListener("BossUI",self.SetPercent,self)
end


--[[
function SpawnMonster:ReceiveTick(DeltaTime)
    SpawnMonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnMonster:ReceiveEndPlay()
    SpawnMonster.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnMonster:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnMonster:GetAvailableServerRPCs()
    return
end
--]]
function SpawnMonster:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_1.Tesla_1_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnMonster:TrySpawnMonster(num)
    --ugcprint("spawn !"..num)
    local Location = self:K2_GetActorLocation().X
    if  Location<= self.Region[num] and Location>= self.Region[num+1] then
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
    end
end



return SpawnMonster