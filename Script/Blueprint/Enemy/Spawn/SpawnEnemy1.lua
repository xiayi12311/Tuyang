---@class SpawnActor_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
---@field ID int32
---@field L1 FVector
---@field L2 FVector
---@field L3 FVector
---@field L4 FVector
--Edit Below--
local SpawnEnemy = {}
local gamestate
local PathList ={

    'Asset/Blueprint/Enemy/KanDaoGuai/kandaoguai.KanDaoGuai_C',
    'Asset/Blueprint/Enemy/Shooter/ShooterMonster.ShooterMonster_C',
    'Asset/Blueprint/Enemy/Sniper/Sniper.Sniper_C',
    'Asset/Blueprint/Enemy/KanDaoGuai/KanDao_Shield.KanDao_Shield_C'
}
local EnenmyNumList ={
{
    3,3,5
}
}
local EnemyList = {
    
       { --ID =1
        {--level =1
            PoolNum=2,
            PoolList={
                {
                    num =3,
                    MonsterList ={1,1,4}
                
                },
                {
                    num =3,
                    MonsterList ={2,1,1}
                }
            }
        },
        
        {
            PoolNum=2,
            PoolList={
                {
                    num =4,
                    MonsterList ={1,1,4,4}
                
                },
                {
                    num =4,
                    MonsterList ={3,1,1,2}
                }
            }
        },
        {
            PoolNum=2,
            PoolList={
                {
                    num =5,
                    MonsterList ={1,2,3,1,4}
                
                },
                {
                    num =5,
                    MonsterList ={1,1,1,2,4}
                }

                   
            }
        -- {
        --     1,1,1,2,2
        -- }
        -- {
        --     1,1,2,1,1
        -- },
        -- {
        --     2,2,1,2,2
        -- }
        }
    }

}
local QueneList ={
    3,
}
local PlaceList ={}
local LocationList ={

    {100,-100},
    {100,100},
    {0,0},
    {-100,100},
    {-100,-100}, 
}
SpawnEnemy.IsTrigger = false
local TimeSet = 0
local TimeCount = 0
local SpawnTime = 1
local Level =1;
function SpawnEnemy:ReceiveBeginPlay()
    SpawnEnemy.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
    gamestate = UGCGameSystem.GetGameState()

    table.insert(PlaceList,self.l1)
    table.insert(PlaceList,self.l2)
    table.insert(PlaceList,self.l3)
    table.insert(PlaceList,self.l4)
end

--]]


function SpawnEnemy:ReceiveTick(DeltaTime)
    SpawnEnemy.SuperClass.ReceiveTick(self, DeltaTime)
    if self:HasAuthority() then 
        if self.IsTrigger then
            if SpawnTime ~=0 then
            TimeSet = TimeSet +DeltaTime
            if TimeSet >=1 then
                ugcprint("TimeSet ==" ..TimeSet)
                TimeCount = TimeCount+1
                TimeSet = TimeSet -1
                if TimeCount ==10 then
                    ugcprint("TimeCount ==" ..TimeCount)
                    TimeCount =0
                    SpawnTime = SpawnTime -1
                    self:SpawnA()
                    if SpawnTime ==0 then
                        self:K2_DestroyActor()
                    end
                end
            end
        else
            self:K2_DestroyActor()
        end
        end
    end
end


--[[
function SpawnEnemy:ReceiveEndPlay()
    SpawnEnemy.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnEnemy:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnEnemy:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function SpawnEnemy:LuaInit()
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

function SpawnEnemy:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Spawn Overlap!!")
    if self:HasAuthority() then
    
    local PlayerController = OtherActor:GetPlayerControllerSafety()
    if PlayerController and self.IsTrigger==false then
        ugcprint("Spawn Overlap2!!")
        self.IsTrigger=true
        SpawnTime =1
        Level =  gamestate:GetDifficulty()
        self:SpawnA()
        -- local times = gamestate:GetDifficulty()
        -- ugcprint("Time is"..times)
        -- local gamestate = UGCGameSystem.GetGameState()

        ugcprint("SpawnTime is"..SpawnTime)
        -- for i =2,times do
        --     ugcprint("I is "..i)
        --     --KismetSystemLibrary.K2_SetTimerDelegateForLua(self.SpawnEnemy, self, 54, false)
        -- 	--UGCGameSystem.SetTimer(self,self.SpawnEnemy,5*i,false)--?
        -- end
        
end
end
    return nil;

end

-- [Editor Generated Lua] function define End;
function SpawnEnemy:SpawnA()
    if self:HasAuthority() then
        local num = UGCGameSystem.GetPlayerNum(false)
        local Quene = math.random(1,EnemyList[self.ID][Level].PoolNum)
        --local Quene = math.random(1,QueneList[self.ID])
        ugcprint("num is !" ..num)
        for j =1,num do
            
            local L = PlaceList[j]
            for i =1, EnemyList[self.ID][Level].PoolList[Quene].num do --5
                --ugcprint("num iS ! "..i)
                local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[EnemyList[self.ID][Level].PoolList[Quene].MonsterList[i]]))
                local Lo = L;
                Lo.X= Lo.X + LocationList[i][1]
                Lo.Y= Lo.Y + LocationList[i][2]
                local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Lo,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
            end
        end
    -- local L = self:K2_GetActorLocation()
    -- for i =1, 5 do
    --     local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[EnemyList[self.ID][Quene][i]]))
    --     local Lo = L;
    --     Lo.X= Lo.X + LocationList[i][1]
    --     Lo.Y= Lo.Y + LocationList[i][2]
	-- 	local Monster = ScriptGameplayStatics.SpawnEnemy(self,MonsterClass,Lo,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    -- end
    end
end
function SpawnEnemy:SpawnA2()
    local gamestate = UGCGameSystem.GetGameState()
    local SelfActor = nil
    if self:HasAuthority() then
        local Quene = math.random(1,QueneList[self.ID])
    local L = self:K2_GetActorLocation()
    for i =1, 5 do
        local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[EnemyList[self.ID][Quene][i]]))
        local Lo = L;
        Lo.X= Lo.X + LocationList[i][1]
        Lo.Y= Lo.Y + LocationList[i][2]
		local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Lo,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    end
end
return SpawnEnemy