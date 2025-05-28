---@class SpawnEnemy2_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
---@field ID int32
---@field L TArray<FVector>
--Edit Below--
local SpawnEnemy = {}
local gamestate
local PathList ={

    'Asset/Blueprint/Enemy/KanDaoGuai/kandaoguai.KanDaoGuai_C',--1
    'Asset/Blueprint/Enemy/Shooter/ShooterMonster.ShooterMonster_C',--2
    'Asset/Blueprint/Enemy/Sniper/Sniper.Sniper_C',--3
    'Asset/Blueprint/Enemy/KanDaoGuai/KanDao_Shield.KanDao_Shield_C',--4
    'Asset/Blueprint/Enemy/KuangZhan/KuangZhanl.KuangZhanl_C',--5
    'Asset/Blueprint/Enemy/KuangZhan/KuangZhan.KuangZhan_C',--6
    'Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_1.Tesla_1_C',--7
    'Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_2.Tesla_2_C',--8
    'Asset/Blueprint/Enemy/Tesla/Tesla_2/Tesla_2.Tesla_2_C',--9
    'Asset/Blueprint/Enemy/Tesla/Tesla_3/Tesla_3.Tesla_3_C',--10
    'Asset/Blueprint/Enemy/Tesla/Tesla_4/Tesla_5.Tesla_5_C',--11
    'Asset/Blueprint/Enemy/Tesla/Tesla_6/Tesla_6.Tesla_6_C',--12
    'Asset/Blueprint/Enemy/Tesla/Tesla_7/Tesla_7.Tesla_7_C',--13
    'Asset/Blueprint/Enemy/BOOMRobot/BOOMRobot.BOOMRobot_C',--14
    'Asset/Blueprint/Enemy/BlueMecha/BlueMecha1.BlueMecha1_C'--15
}
local EntryParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Spawn/EntryParticle2.EntryParticle2_C'))
local EnenmyNumList ={
{
    3,3,5
}
}
local EnemyList = {
    
       { --ID =1
        {--难度 =1
            PoolNum=3,--有几组随机
            PoolList={
                {
                    num =2,--有几个怪物
                    MonsterList ={1,1}
                
                },
                {
                    num =2,
                    MonsterList ={2,2}
                },
                {
                    num =2,
                    MonsterList ={1,2}
                }
            }
        },
        
        {--难度 =2
            PoolNum=3,
            PoolList={
                {
                    num =3,
                    MonsterList ={1,1,2}
                
                },
                {
                    num =3,
                    MonsterList ={1,2,2}
                },
                {
                    num =3,
                    MonsterList ={1,1,1}
                }
            }
        },
        {--难度 =3
            PoolNum=2,
            PoolList={
                {
                    num =4,
                    MonsterList ={1,1,2,4}
                
                },
                {
                    num =4,
                    MonsterList ={1,2,2,4}
                },
                {
                    num =4,
                    MonsterList ={1,1,1,4}
                }

                   
            }
        }
    },
    { --ID =2
    {--难度 =1
        PoolNum=4,
        PoolList={
            {
                num =2,
                MonsterList ={1,2}
            
            },
            {
                num =2,
                MonsterList ={1,4}
            },
            {
                num =2,
                MonsterList ={2,4}
            }
            ,
            {
                num =3,
                MonsterList ={1,1,2}
            }
        }
    },
    
    {--难度 =2
        PoolNum=3,
        PoolList={
            {
                num =4, 
                MonsterList ={1,1,14,3}
            
            },
            {
                num =3,
                MonsterList ={4,3,1}
            },
            {
                num =5,
                MonsterList ={1,1,1,14,2}
            }
        }
    },
    {--难度 =3
        PoolNum=3,
        PoolList={
            {
                num =4,
                MonsterList ={2,2,14,9}
            
            },
            {
                num =3,
                MonsterList ={1,12,9}
            }
            ,
            {
                num =3,
                MonsterList ={1,4,10}
            }

               
        }
    },
    
},
{ --ID =3
{--难度 =1 总威胁值15
    PoolNum=4,--有几组随机
    PoolList={
        {
            num =2,--有几个怪物
            MonsterList ={5,5}
        
        },

        {
            num =2,--有几个怪物
            MonsterList ={1,5}
        
        }
        ,

        {
            num =2,--有几个怪物
            MonsterList ={5,2}
        
        },

        {
            num =1,--有几个怪物
            MonsterList ={6}
        
        }



    }
},

{--难度 =2 总威胁值30
    PoolNum=3,
    PoolList={
        {
            num =2,
            MonsterList ={6,5}
        
        },
        {
            num =4,
            MonsterList ={5,5,5,1}
        },
        {
            num =4,
            MonsterList ={5,5,5,2}
        }
    }
},
{--难度 =3 总威胁值60
    PoolNum=2,
    PoolList={
        {
            num =4,
            MonsterList ={5,5,6,6}
        
        },
        {
            num =3,
            MonsterList ={6,6,6}
        }

           
    }
}
},       
{ --ID =4
{--难度 =1
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={6,6,6}
        
        },
        {
            num =3,
            MonsterList ={6,7,8}
        }
    }
},

{--难度 =2 总威胁值30
    PoolNum=2,
    PoolList={
        {
            num =2,
            MonsterList ={12,10}
        
        },
        {
            num =2,
            MonsterList ={12,9}
        },
        {
            num =2,
            MonsterList ={9,10}
        }
    }
},
{--难度 =3 总威胁值60
    PoolNum=2,
    PoolList={
        {
            num =3,
            MonsterList ={7,12,10}
        
        },
        {
            num =3,
            MonsterList ={7,9,10}
        },
        {
            num =3,
            MonsterList ={7,12,9}
        }

           
    }
}
},       
{ --ID =5
{--难度 =1 
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={1,1,4}
        
        },
        {
            num =3,
            MonsterList ={2,1,1}
        }
    }
},

{--难度 =2 总威胁30
    PoolNum=5,
    PoolList={
        {
            num =5,
            MonsterList ={12,10,10,12,12}
        
        },
        {
            num =5,
            MonsterList ={12,12,9,12,9}
        },
        {
            num =4,
            MonsterList ={12,12,9,11}
        },
        {
            num =4,
            MonsterList ={7,12,12,9}
        },
        {
            num =2,
            MonsterList ={13,11}
        }
    }
},
{--难度 =3 总威胁60
    PoolNum=5,
    PoolList={
        {
            num =5,
            MonsterList ={12,10,7,12,12}
        
        },
        {
            num =4,
            MonsterList ={12,9,7,9}
        },
        {
            num =3,
            MonsterList ={13,7,11}
        },
        {
            num =4,
            MonsterList ={8,12,12,12}
        },
        {
            num =5,
            MonsterList ={12,12,13,9,9}
        }
        ,
        {
            num =3,
            MonsterList ={8,7,11}
        }

           
    }
}
},       
{ --ID =6
{--难度 =1
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={1,1,4}
        
        },
        {
            num =3,
            MonsterList ={2,1,1}
        }
    }
},

{--难度 =2 15威胁
    PoolNum=11,
    PoolList={
        {
            num =2,
            MonsterList ={6,5}
        
        },
        {
            num =4,
            MonsterList ={5,5,5,1}
        },
        {
            num =4,
            MonsterList ={5,5,5,2}
        },
        {
            num =4, 
            MonsterList ={1,1,14,3}
        
        },
        {
            num =3,
            MonsterList ={4,3,1}
        },
        {
            num =5,
            MonsterList ={1,1,1,14,2}
        },
        {
            num =3,
            MonsterList ={12,10,9}
        
        },
        {
            num =3,
            MonsterList ={12,12,10}
        },
        {
            num =3,
            MonsterList ={12,12,9}
        },
        {
            num =1,
            MonsterList ={7}
        },
        {
            num =1,
            MonsterList ={13}
        }

    }
},
{--难度 =3 30威胁
    PoolNum=10,
    PoolList={
        {
            num =3,
            MonsterList ={12,10,7}
        
        },
        {
            num =3,
            MonsterList ={12,9,7}
        },
        {
            num =2,
            MonsterList ={13,7}
        },
        {
            num =1,
            MonsterList ={8}
        },
        {
            num =3,
            MonsterList ={12,12,13}
        },
        {
            num =4,
            MonsterList ={5,5,6,6}
        
        },
        {
            num =3,
            MonsterList ={6,6,6}
        },
        {
            num =4,
            MonsterList ={2,2,14,9}
        
        },
        {
            num =3,
            MonsterList ={1,12,9}
        }
        ,
        {
            num =3,
            MonsterList ={1,4,10}
        }
           
    }
}
},       
{ --ID =7
{--难度 =1
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={1,1,4}
        
        },
        {
            num =3,
            MonsterList ={2,1,1}
        }
    }
},

{--难度 =2
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
{--难度 =3
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
}
},      
{ --ID =8
{--难度 =1
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={1,1,4}
        
        },
        {
            num =3,
            MonsterList ={2,1,1}
        }
    }
},

{--难度 =2
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
{--难度 =3
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
}
},       
{ --ID =9
{--难度 =1
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={1,1,4}
        
        },
        {
            num =3,
            MonsterList ={2,1,1}
        }
    }
},

{--难度 =2
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
{--难度 =3
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
}
},       
{ --ID =10
{--难度 =1
    PoolNum=2,--有几组随机
    PoolList={
        {
            num =3,--有几个怪物
            MonsterList ={1,1,4}
        
        },
        {
            num =3,
            MonsterList ={2,1,1}
        }
    }
},

{--难度 =2
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
{--难度 =3
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
}
},
}
local QueneList ={
    3,
}
--local PlaceList ={}
SpawnEnemy.LocationList ={

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
local EntrySound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1')) --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1')
function SpawnEnemy:ReceiveBeginPlay()
    SpawnEnemy.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
    gamestate = UGCGameSystem.GetGameState()

end

--]]


function SpawnEnemy:ReceiveTick(DeltaTime)
    SpawnEnemy.SuperClass.ReceiveTick(self, DeltaTime)
    if self:HasAuthority() then 
        if self.IsTrigger then
            if SpawnTime >0 then
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
        SpawnTime =2
        Level =  gamestate:GetDifficulty()
        --self:SpawnA()
        -- local times = gamestate:GetDifficulty()
        -- ugcprint("Time is"..times)
        -- local gamestate = UGCGameSystem.GetGameState()
        local num = UGCGameSystem.GetPlayerNum(false)
        
        ugcprint("SpawnTime is"..SpawnTime)
        for j =1,num do
            local L = self.L[j]
            local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,L,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        end
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
    
    UGCSoundManagerSystem.PlaySoundAttachActor(EntrySound,self,true)
    
    if self:HasAuthority() then
        local num = UGCGameSystem.GetPlayerNum(false)
        ugcprint("ID is"..self.ID)
        local Quene = math.random(1,EnemyList[self.ID][Level].PoolNum)
        --local Quene = math.random(1,QueneList[self.ID])
        ugcprint("num is !" ..num)
        for j =1,num do
            
            local L = self.L[j]

            for i =1, EnemyList[self.ID][Level].PoolList[Quene].num do --5
                ugcprint("Spawning " ..i)
                --ugcprint("num iS ! "..i)
                local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[EnemyList[self.ID][Level].PoolList[Quene].MonsterList[i]]))
                local Lo = L;
                -- Lo.X= Lo.X + self.L[i][1]
                -- Lo.Y= Lo.Y + self.L[i][2]
                -- Lo.X= Lo.X + self.LocationList[i][1]
                -- Lo.Y= Lo.Y + self.LocationList[i][2]
                
                local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Lo,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
                
                -- else
                --     STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,EntryParticle,Lo,self:K2_GetActorRotation(),true);
                -- end
            end
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
function SpawnEnemy:SpawnA2()
    local gamestate = UGCGameSystem.GetGameState()
    local SelfActor = nil
    if self:HasAuthority() then
        local Quene = math.random(1,QueneList[self.ID])
    local L = self:K2_GetActorLocation()
    for i =1, 5 do
        local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[EnemyList[self.ID][Quene][i]]))
        local Lo = L;
        Lo.X= Lo.X + self.LocationList[i][1]
        Lo.Y= Lo.Y + self.LocationList[i][2]
		local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Lo,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    end
end
return SpawnEnemy