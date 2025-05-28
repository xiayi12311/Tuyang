---@class SpawnEnemy4_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnEnemy4 = {}

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
local EnemyList = {
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
SpawnEnemy4.L =
{
    {X=-46680.000000,Y=20240.000000,Z=80.000000},
    {X=-46680.000000,Y=19820.000000,Z=80.000000},
    {X=-47220.000000,Y=20240.000000,Z=80.000000},
    {X=-47220.000000,Y=19820.000000,Z=80.000000}
}


local TimeSet = 0
local TimeCount = 0
local EntrySound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1')) --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1')
local gamestate
local EntryParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Spawn/EntryParticle.EntryParticle_C'))



function SpawnEnemy4:ReceiveBeginPlay()
    SpawnEnemy4.SuperClass.ReceiveBeginPlay(self)
    gamestate = UGCGameSystem.GetGameState()
    if not self:HasAuthority() then
        local num = UGCGameSystem.GetPlayerNum(false)
        for j =1,num do
            local L = self.L[j]
            local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,L,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        end
    end
end



function SpawnEnemy4:ReceiveTick(DeltaTime)
    SpawnEnemy4.SuperClass.ReceiveTick(self, DeltaTime)
    --if self:HasAuthority() then 
        TimeSet = TimeSet +DeltaTime
            if TimeSet >=1 then
                ugcprint("TimeSet ==" ..TimeSet)
                TimeCount = TimeCount+1
                TimeSet = TimeSet -1
                if TimeCount ==10 then
                    ugcprint("TimeCount ==" ..TimeCount)
                    TimeCount =0
                    self:SpawnA()
                end
            end
       -- end
end

--[[
function SpawnEnemy4:ReceiveEndPlay()
    SpawnEnemy4.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnEnemy4:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnEnemy4:GetAvailableServerRPCs()
    return
end
--]]
function SpawnEnemy4:SpawnA()
    
    UGCSoundManagerSystem.PlaySoundAttachActor(EntrySound,self,true)
    local num = UGCGameSystem.GetPlayerNum(false)
    if self:HasAuthority() then
       
        local Quene = math.random(1,EnemyList.PoolNum)
        --local Quene = math.random(1,QueneList[self.ID])
        ugcprint("num is !" ..num)
        for j =1,num do
            
            local L = self.L[j]

            for i =1, EnemyList.PoolList[Quene].num do --5
                ugcprint("Spawning " ..i)
                local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[EnemyList.PoolList[Quene].MonsterList[i]]))
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
    else
        for j =1,num do
            local L = self.L[j]
            local Particle = ScriptGameplayStatics.SpawnActor(self,EntryParticle,L,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
            end
        end
  
    
end
return SpawnEnemy4