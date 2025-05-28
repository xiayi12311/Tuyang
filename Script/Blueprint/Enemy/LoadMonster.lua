local LoadMonster = {}
 
local RegionCount =4
local Region ={
    0,
    -6950.227051,
    -23192.306641,
    -41106.753906,
    -100000,
}
function LoadMonster:ReceiveBeginPlay()
    LoadMonster.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function LoadMonster:ReceiveTick(DeltaTime)
    LoadMonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function LoadMonster:ReceiveEndPlay()
    LoadMonster.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function LoadMonster:GetReplicatedProperties()
    return
end
--]]

--[[
function LoadMonster:GetAvailableServerRPCs()
    return
end
--]]
function LoadMonster:GetRegionCount()
    return RegionCount
end
function LoadMonster:GetRegion()
    return Region
end
return LoadMonster