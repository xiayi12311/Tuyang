---@class SpawnShooter_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnShooter = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnShooter.MonsterClass = nil
   
function SpawnShooter:ReceiveBeginPlay()
    ugcprint("SpawnShooter begin！")
    SpawnShooter.SuperClass.ReceiveBeginPlay(self)
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
function SpawnShooter:ReceiveTick(DeltaTime)
    SpawnShooter.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnShooter:ReceiveEndPlay()
    SpawnShooter.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnShooter:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnShooter:GetAvailableServerRPCs()
    return
end
--]]
function SpawnShooter:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Shooter/ShooterMonster.ShooterMonster_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnShooter:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



-- [Editor Generated Lua] function define Begin:
function SpawnShooter:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function SpawnShooter:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	return nil;
end

-- [Editor Generated Lua] function define End;

return SpawnShooter