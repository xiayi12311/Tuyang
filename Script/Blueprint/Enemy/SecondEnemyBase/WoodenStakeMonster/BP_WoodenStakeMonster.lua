---@class BP_WoodenStakeMonster_C:BP_YXMonsterBase_C
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field HealthUI UWidgetComponent
--Edit Below--
local BP_WoodenStakeMonster = {}
 

function BP_WoodenStakeMonster:ReceiveBeginPlay()
    UGCLog.Log("BP_WoodenStakeMonster:ReceiveBeginPlay")
    BP_WoodenStakeMonster.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    self.UGC_OnHPChangedDelegate:Add(self.OnHPChangedDelegate, self)
    --self.OnRep_Health:Add(self.OnRep_Health_BP_WoodenStakeMonster, self)

    if self:HasAuthority() then

    else
        self.HealthUI.Widget:SetHealthToMonster(self.Health, self.HealthMax) -- 更新 UI 显示
    end
end


--[[
function BP_WoodenStakeMonster:ReceiveTick(DeltaTime)
    BP_WoodenStakeMonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_WoodenStakeMonster:ReceiveEndPlay()
    BP_WoodenStakeMonster.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BP_WoodenStakeMonster:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_WoodenStakeMonster:GetAvailableServerRPCs()
    return
end
--]]
BP_WoodenStakeMonster.TextList = {}
BP_WoodenStakeMonster.iTakeDamageNums = 0
BP_WoodenStakeMonster.lastWeapon = nil 
function BP_WoodenStakeMonster:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    UGCLog.Log("BP_WoodenStakeMonster:OnTakeDamageDelegate",Damage)
    -- if self.Health <= 10000 then
    --     UGCSimpleCharacterSystem.SetHealth(self,self.HealthMax)
    -- end


    local BaseClass = UE.LoadClass('/Game/UGC/UGCGame/GameMode/BP_UGCPlayerPawn.BP_UGCPlayerPawn_C')
    if UE.IsA(EventInstigator.Pawn,BaseClass) then
        --UGCLog.Log("BP_WoodenStakeMonster:OnTakeDamageDelegate EventInstigator is BP_UGCPlayerPawn")
        local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(EventInstigator.Pawn)
        local Name = weapon:GetWeaponName() 
        UGCLog.Log("BP_WoodenStakeMonster:OnTakeDamageDelegateTextFunction  ",Name," Damage =  ",Damage)
    end
   
end
function BP_WoodenStakeMonster:OnHPChangedDelegate(HP,HPChanged)
    UGCLog.Log("BP_WoodenStakeMonster:OnRep_Health_BP_WoodenStakeMonster", HP) -- 打印日志
    if self.HealthUI == nil then
        self.HealthUI = self:GetWidgetComponent("HealthUI")
        UGCLog.Log("BP_WoodenStakeMonster:OnRep_Health_BP_WoodenStakeMonster HealthUI == nil ", self.Health) -- 打印日志
    end
    self.HealthUI.Widget:SetHealthToMonster(self.Health, self.HealthMax) -- 更新 UI 显示
end

function BP_WoodenStakeMonster:UGC_PreTakeDamageEvent(Damage,EventInstigator,DamageEvent,DamageCauser)
    if Damage > self.Health then
        self.Health = self.HealthMax
    end
    return Damage
end
return BP_WoodenStakeMonster