---@class SpawnTesla_1_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnBOOM = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnBOOM.MonsterClass = nil
   
function SpawnBOOM:ReceiveBeginPlay()
    ugcprint("SpawnBOOM begin！")
    SpawnBOOM.SuperClass.ReceiveBeginPlay(self)
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
function SpawnBOOM:ReceiveTick(DeltaTime)
    SpawnBOOM.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnBOOM:ReceiveEndPlay()
    SpawnBOOM.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnBOOM:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnBOOM:GetAvailableServerRPCs()
    return
end
--]]
function SpawnBOOM:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/BOOMRobot/BOOMRobot.BOOMRobot_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnBOOM:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnBOOM