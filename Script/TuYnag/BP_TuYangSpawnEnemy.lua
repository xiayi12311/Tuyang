---@class BP_TuYangSpawnEnemy_C:AActor
---@field DefaultSceneRoot USceneComponent
---@field ID int32
---@field L ULuaArrayHelper<FVector>
---@field fSpawnTime float
---@field InitLevel int32
---@field InitNumber int32
---@field SpecialMonsterLoc ULuaArrayHelper<FVector>
--Edit Below--
local BP_TuYangSpawnEnemy = {}
local Action_GameFight = require("Script.GameMode.Action_GameFight")
--local UGCLog = require("Script.UGCLog")
local gamestate
local PathList ={
    'Asset/Blueprint/Enemy/SecondEnemyBase/ZombieDog/Level_1.Level_1_C', -- 1
    'Asset/Blueprint/Enemy/Scorpion/Level_2.Level_2_C',--2
    'Asset/Blueprint/Enemy/SecondEnemyBase/WereWolf/WereWolf1/Level_3.Level_3_C',--3
    'Asset/Blueprint/Enemy/KanDaoGuai/Level_4.Level_4_C',--4
    'Asset/Blueprint/Enemy/Shooter/Level_5.Level_5_C',--5
    'Asset/Blueprint/Enemy/SecondEnemyBase/BLC/Level_6.Level_6_C',--6
    'Asset/Blueprint/Enemy/SecondEnemyBase/KuangZhan/SmallKuangZhan/Level_7.Level_7_C',--7
    'Asset/Blueprint/Enemy/SecondEnemyBase/BoomRobot/Level_8.Level_8_C',--8
    'Asset/Blueprint/Enemy/SecondEnemyBase/WereWolf/WereWolf3/Level_9.Level_9_C',--9
    'Asset/Blueprint/Enemy/Sniper/Level_10.Level_10_C',--10
    'Asset/Blueprint/Enemy/KanDaoGuai/Level_11.Level_11_C',--11
    'Asset/Blueprint/Enemy/Tesla/Tesla_6/Level_12.Level_12_C',--12
    'Asset/Blueprint/Enemy/Tesla/Tesla_3/Level_13.Level_13_C',--13
    'Asset/Blueprint/Enemy/Tesla/Tesla_2/Level_14.Level_14_C',--14
    'Asset/Blueprint/Enemy/SecondEnemyBase/KuangZhan/BigKuangZhan/Level_15.Level_15_C',--15
    'Asset/Blueprint/Enemy/SecondEnemyBase/WereWolf/WereWolf2/Level_16.Level_16_C',--16
    'Asset/Blueprint/Enemy/Tesla/Tesla_1/Level_17.Level_17_C',--17
    'Asset/Blueprint/Enemy/SecondEnemyBase/Scientist/Level_18.Level_18_C',--18
    'Asset/Blueprint/Enemy/Tesla/Tesla_4/Level_19.Level_19_C',--19
    'Asset/Blueprint/Enemy/Tesla/Tesla_1/Level_20.Level_20_C',--20

    
}
local SpecialMonsterPathList ={
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Sniper/Boss_Level_1.Boss_Level_1_C'),--1
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_7/Boss_Level_2.Boss_Level_2_C'),--2yx
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/SecondEnemyBase/Tank/Boss_Level_3.Boss_Level_3_C'),--3
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/elite/Boss_Level_4.Boss_Level_4_C'),--4
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Boss_Level_5.Boss_Level_5_C'),--5

}
local SpecialSequenceClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalBuffs/TuYang_SpecialMonsterSequence.TuYang_SpecialMonsterSequence_C'))


local AllObjectList = {}
BP_TuYangSpawnEnemy.IsTrigger = true
local TimeSet = 0
local TimeCount = 0
local SpawnTime = 1
local Level =1;
local EntrySound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1')) --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1')
local MonsterProperty = 
{
    {Gold = 80},
    {Gold = 80},
    {Gold = 80},
    {Gold = 80},
    {Gold = 80},
    {Gold = 85},
    {Gold = 85},
    {Gold = 85},
    {Gold = 85},
    {Gold = 85},
    {Gold = 90},
    {Gold = 90},
    {Gold = 90},
    {Gold = 90},
    {Gold = 90},
    {Gold = 100},
    {Gold = 100},
    {Gold = 100},
    {Gold = 100},
    {Gold = 100},
}


function BP_TuYangSpawnEnemy:AddEnemyLevel(iAddEnemyLevel)
    ugcprint(string.format("BP_TuYangSpawnEnemy:AddEnemyLevel InitLevel = %s iAddEnemyLevel = %s ",self.InitLevel,iAddEnemyLevel))
    self.InitLevel = self.InitLevel + iAddEnemyLevel
end

function BP_TuYangSpawnEnemy:AddEnemyNumber(iAddEnemyNumber)
    ugcprint(string.format("BP_TuYangSpawnEnemy:AddEnemyNumber InitNumber = %s InitNumber = %s ",self.InitNumber,iAddEnemyNumber))
    self.InitNumber = self.InitNumber + iAddEnemyNumber
end

 
function BP_TuYangSpawnEnemy:ReceiveBeginPlay()
    BP_TuYangSpawnEnemy.SuperClass.ReceiveBeginPlay(self)
    
    gamestate = UGCGameSystem.GetGameState()
    for i = 1,#(self.L) do
    --ugcprint(string.format("BP_TuYangSpawnEnemy:ReceiveBeginPlay [L.X = %s Y = %s Z = %s  ]",self.L[i].X,self.L[i].Y,self.L[i].Z))
    end
    if self.ID == 1 then
        Action_GameFight.iID1SpawnEnemy = self
        UGCLog.Log("BP_TuYangSpawnEnemyReceiveBeginPlay", Action_GameFight.iID1SpawnEnemy)
    elseif self.ID == 2 then
        Action_GameFight.iID2SpawnEnemy = self
        UGCLog.Log("BP_TuYangSpawnEnemyReceiveBeginPlay", Action_GameFight.iID2SpawnEnemy)
    end
   
end
function BP_TuYangSpawnEnemy:SpawnEnemyStart()
    ugcprint(string.format("BP_TuYangSpawnEnemy:SpawnEnemyStart self = %s",tostring(self)))
    for i = 1,#(self.L) do
        ugcprint(string.format("BP_TuYangSpawnEnemy:SpawnEnemyStart [L.X = %s Y = %s Z = %s  ]",self.L[i].X,self.L[i].Y,self.L[i].Z))
    end
    self:SpawnFirstEnemy()
   
    -- 创建一个延时执行函数体
    self.SpawnEnemyTimerDelegate = ObjectExtend.CreateDelegate(self, 
    function()
        if self:HasAuthority() == true then -- 判断是否在服务端执行
            ugcprint("[BP_TuYangSpawnEnemy:SpawnEnemyStart1]")
            
            if self.IsTrigger then
                
            else
                ObjectExtend.DestroyDelegate(self.SpawnEnemyTimerDelegate)
                -- self:K2_DestroyActor()
            end
            
        end
    end
    )
    -- 执行延时函数体
    KismetSystemLibrary.K2_SetTimerDelegateForLua(self.SpawnEnemyTimerDelegate, self, 3, true)
end

function BP_TuYangSpawnEnemy:GetMonsterNumScale(InNum)
    local tScale = 1.1
    if InNum > 0 and InNum <= 10 then
        tScale = 2
    elseif InNum <= 25 then
        tScale = 1.5
    elseif InNum <= 35 then
        tScale = 1.1
    else 
        tScale = 0.8
    end
    return tScale
end

function BP_TuYangSpawnEnemy:TimerSpawnEnemy()
    if self:HasAuthority() then
        --UGCLog.Log("BP_TuYangSpawnEnemyTimerSpawnEnemy")
        local SpawnLocID = 1
        local L = self.L:Get(SpawnLocID)
        local Loc
        local GameState = GameplayStatics.GetGameState(self)
        local MonsterLevel = 1
        local MonsterNum = 0
        if self.ID == 1 then
            MonsterLevel = GameState.iID1MonsterLevel
            MonsterNum = math.floor(GameState.iID2KillNum * self:GetMonsterNumScale(GameState.iID1MonsterNum + GameState.iID2KillNum))
        else if self.ID == 2 then    
            MonsterLevel = GameState.iID2MonsterLevel
            MonsterNum =  math.floor(GameState.iID1KillNum * self:GetMonsterNumScale(GameState.iID2MonsterNum + GameState.iID1KillNum))
            end
        end
        --ugcprint("TimerSpawnEnemy:SpawnEnemy1".."ID= "..self.ID.." MonsterLevel= "..MonsterLevel.." MonsterNum= "..MonsterNum)
        -- if GameState. MonsterNumStage2 and MonsterNum == 0 then
        --     MonsterNum = 1
        -- end
        for i = 1 , MonsterNum do
            --ugcprint(string.format("TimerSpawnEnemy:SpawnEnemy2 [SpawnLocID = %s  ]",SpawnLocID))
            local MonsterClass = LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[MonsterLevel]))
            
            Loc = L;
            
            local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Loc,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
            if UE.IsValid(Monster) and UE.IsA(Monster,MonsterClass) then
                --ugcprint(string.format("TimerSpawnEnemy:SpawnEnemy4 [Lo.X = %s Y = %s Z = %s  ]",Loc.X,Loc.Y,Loc.Z))
                Monster.CampID = self.ID
                Monster:SetLifeSpan(180)
                GameState:SetMonsterNum(self.ID,GameState:GetMonsterNum(self.ID) + 1)
                -- Monster.gold = MonsterProperty[MonsterLevel].Gold

                table.insert(AllObjectList,Monster)
            end

            SpawnLocID = SpawnLocID + 1
            if SpawnLocID > #(self.L) then
                SpawnLocID = 1
            end
            L = self.L[SpawnLocID]
            if self.ID == 1 then
                GameState.iID2KillNum = 0
            else if self.ID == 2 then    
                GameState.iID1KillNum = 0
                end
            end
           
        end
        
       
    end
end

function BP_TuYangSpawnEnemy:SpawnFirstEnemy()
    if self:HasAuthority() then
        ugcprint(string.format("SpawnFirstEnemy:SpawnEnemy1 MonsterNum = %s",self.InitNumber))
        local SpawnLocID = 1
        local L = self.L:Get(SpawnLocID)
        local Loc
        local GameState = GameplayStatics.GetGameState(self)
        for i = 1 , self.InitNumber do
            --ugcprint(string.format("SpawnFirstEnemy:SpawnEnemy2 [SpawnLocID = %s  ]",SpawnLocID))
            local MonsterLevel = GameState.iID1MonsterLevel
            local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[GameState.iID1MonsterLevel]))
            
            Loc = L;
           
            --ugcprint(string.format("SpawnFirstEnemy:SpawnEnemy3 [Lo.X = %s Y = %s Z = %s  ]",Loc.X,Loc.Y,Loc.Z))
            for i = 1,#(self.L) do
                ugcprint(string.format("BP_TuYangSpawnEnemy:SpawnFirstEnemy [L.X = %s Y = %s Z = %s  ]",self.L[i].X,self.L[i].Y,self.L[i].Z))
            end
            
            local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Loc,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
            if UE.IsValid(Monster) and UE.IsA(Monster,MonsterClass) then
                --ugcprint(string.format("SpawnFirstEnemy:SpawnEnemy4 [Lo.X = %s Y = %s Z = %s  ]",Loc.X,Loc.Y,Loc.Z))
                Monster.CampID = self.ID
                Monster:SetLifeSpan(180)
                GameState:SetMonsterNum(self.ID,GameState:GetMonsterNum(self.ID) + 1)
                -- Monster.gold = MonsterProperty[MonsterLevel].Gold
                table.insert(AllObjectList,Monster)
            end

            SpawnLocID = SpawnLocID + 1
            if SpawnLocID > #(self.L) then
                SpawnLocID = 1
            end
            L = self.L[SpawnLocID]
        end
        
       
    end
end

function BP_TuYangSpawnEnemy:SpawnNewEnemy(InNum)
    if self:HasAuthority() then
        local SpawnLocID = math.random(1,#(self.L))
        local Loc
        local GameState = GameplayStatics.GetGameState(self)
        local MonsterLevel
        if self.ID == 1 then
            MonsterLevel = GameState.iID1MonsterLevel
        else if self.ID == 2 then    
            MonsterLevel = GameState.iID2MonsterLevel
            end
        end
        local MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath(PathList[MonsterLevel]))
        for i = 1, InNum do
            SpawnLocID = math.random(1,#(self.L))
            Loc = self.L:Get(SpawnLocID)
            self:SpawnEnemy(MonsterClass,1,Loc,self:K2_GetActorRotation(), MonsterLevel)
            SpawnLocID = SpawnLocID + 1
            if SpawnLocID > #(self.L) then
                SpawnLocID = 1
            end
        end
        
       
    end
end


function BP_TuYangSpawnEnemy:SpawnSpecialMonsterSequence(InIndex)
    if self:HasAuthority() then
        local SpawnLocID = 1
        local Loc = self.SpecialMonsterLoc:Get(SpawnLocID)
        -- 先生成Sequence
        local SpecialSequence = ScriptGameplayStatics.SpawnActor(self,SpecialSequenceClass,Loc,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        table.insert(AllObjectList,SpecialSequence)
        Timer.InsertTimer(2.5,
        function()
            self:SpawnSpecialMonsterActor(InIndex,Loc)
        end,
            false)
        SpawnLocID = SpawnLocID + 1
        if SpawnLocID > #(self.L) then
            SpawnLocID = 1
        end
        Loc = self.L[SpawnLocID]

    end
end

function BP_TuYangSpawnEnemy:SpawnSpecialMonsterActor(InKey,InLoc)
    ugcprint("BP_TuYangSpawnEnemy:SpawnSpecialMonster InIndex = "..InKey)
    if self:HasAuthority() then
        local tDataSource = {}
        local GameState = GameplayStatics.GetGameState(self)
        if UE.IsValid(GameState) then                 
            tDataSource = GameState.BP_EnemyShopComponent:GetDataSourceItem(2,InKey,nil)
            local MonsterPath = SpecialMonsterPathList[tDataSource.ItemId]
            local MonsterClass = UE.LoadClass(MonsterPath)        
            local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,InLoc,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
            if UE.IsA(Monster,MonsterClass) then
                Monster.CampID = self.ID
                -- 动态设置血量
                local MonsterHealth = tDataSource.HealthList[GameState:GetCurrentRound()]
                UGCLog.Log("BP_TuYangSpawnEnemy:SpawnSpecialMonsterActor MonsterHealth = ",MonsterHealth)
                UGCSimpleCharacterSystem.SetHealthMax(Monster,MonsterHealth)
                UGCSimpleCharacterSystem.SetHealth(Monster,MonsterHealth)
            
                table.insert(AllObjectList,Monster)
            end
        end
    end

end


function BP_TuYangSpawnEnemy:SpawnSpecialMonster(InIndex)
    ugcprint("BP_TuYangSpawnEnemy:SpawnSpecialMonster InIndex = "..InIndex)
    -- if self:HasAuthority() then
    --     local MonsterPath = SpecialMonsterPathList[InIndex]
    --     local SpawnLocID = 1
    --     local Loc = self.SpecialMonsterLoc:Get(SpawnLocID)
    --     local GameState = GameplayStatics.GetGameState(self)
    --     local MonsterLevel = 1
    --     if self.ID == 1 then
    --         MonsterLevel = GameState.iID1MonsterLevel
    --     else if self.ID == 2 then    
    --         MonsterLevel = GameState.iID2MonsterLevel
    --         end
    --     end
        
    --     local MonsterClass = UE.LoadClass(MonsterPath)        
        
    --     local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,Loc,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
        
    --     if UE.IsA(Monster,MonsterClass) then
    --         Monster.CampID = self.ID
    --         table.insert(AllObjectList,Monster)
    --     end
    --     SpawnLocID = SpawnLocID + 1
    --     if SpawnLocID > #(self.L) then
    --         SpawnLocID = 1
    --     end
    --     Loc = self.L[SpawnLocID]
    -- end
    
    self:SpawnSpecialMonsterSequence(InIndex)
end

function BP_TuYangSpawnEnemy:SpawnEnemy(InClass,InNum,InLoc,InRot, ...)
    if self:HasAuthority() then
        local GameState = GameplayStatics.GetGameState(self)        
        local MonsterNum = InNum
        local MonsterLevel = ...
        for i = 1 , MonsterNum do
            local MonsterClass = InClass
            local Monster = ScriptGameplayStatics.SpawnActor(self,MonsterClass,InLoc,InRot,{X = 1, Y = 1, Z = 1},self);
            if UE.IsValid(Monster) and UE.IsA(Monster,MonsterClass) then
                Monster.CampID = self.ID
                Monster:SetLifeSpan(180)
                GameState:SetMonsterNum(self.ID,GameState:GetMonsterNum(self.ID) + 1)
                --Monster.gold = MonsterProperty[MonsterLevel].Gold
                table.insert(AllObjectList,Monster)
            end           
        end
    end     
end

function BP_TuYangSpawnEnemy:RountEndClearAllMonster()
    for k, v in pairs(AllObjectList) do
        if UE.IsValid(v) then
            v:K2_DestroyActor()
        end
    end
end
--[[
function BP_TuYangSpawnEnemy:ReceiveTick(DeltaTime)
    BP_TuYangSpawnEnemy.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_TuYangSpawnEnemy:ReceiveEndPlay()
    BP_TuYangSpawnEnemy.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BP_TuYangSpawnEnemy:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_TuYangSpawnEnemy:GetAvailableServerRPCs()
    return
end
--]]

return BP_TuYangSpawnEnemy