---@class SpawnTesla_1_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnSniper = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnSniper.MonsterClass = nil
   
function SpawnSniper:ReceiveBeginPlay()
    ugcprint("SpawnSniper begin！")
    SpawnSniper.SuperClass.ReceiveBeginPlay(self)
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
function SpawnSniper:ReceiveTick(DeltaTime)
    SpawnSniper.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnSniper:ReceiveEndPlay()
    SpawnSniper.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnSniper:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnSniper:GetAvailableServerRPCs()
    return
end
--]]
function SpawnSniper:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Sniper/Sniper.Sniper_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnSniper:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnSniper