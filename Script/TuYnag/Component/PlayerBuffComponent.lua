---@class PlayerBuffComponent_C:ActorComponent
---@field EnumBuff ULuaArrayHelper<TEnumAsByte<Enum_Buff>>
--Edit Below--
local PlayerBuffComponent = {}
local EventSystem = require("Script.Common.UGCEventSystem")
PlayerBuffComponent.ReloadTimeScale = 1
PlayerBuffComponent.ShootIntervalTimeScale = 1
PlayerBuffComponent.GunData = 
{
    {
        Gun = nil,
        ReloadTime = 1,
        Damage = 1,
        ShootIntervalTime = 0.1
    }

}
-- 玩家拥有的BUFF
PlayerBuffComponent.BuffList = {}
--  每次复活需要重新添加的BUFF
PlayerBuffComponent.bIsRespawnAdd = false
PlayerBuffComponent.RespawnBuffList = {}
--Epinephrine
-- 0	肾上腺素 换弹时间 -15%
PlayerBuffComponent.ReloadTimeScale_Epinephrine = -0.15
-- 1	脚底抹油 移速增加 15%
PlayerBuffComponent.SpeedScale_FeetSolesGrease = 0.15
-- 2	身强体壮 生命值 +50
PlayerBuffComponent.MaxHealth_GoodHealth = 50
-- 3	赏金猎人 击杀怪物额外获得 10钱
PlayerBuffComponent.ExtraGold_BountyHunter = 10
-- 4	高利贷 开局获得3000金币，但击杀怪物赏金减少20
PlayerBuffComponent.Gold_LoanShark = 3000
PlayerBuffComponent.GoldScale_LoanShark = -0.2
-- 5	祖传武器 开局获得1把AK47 
PlayerBuffComponent.Gun_AncestralWeapon = "AK47" 
-- 6	炸弹狂人 开局获得5个手雷
PlayerBuffComponent.Gun1_BombManiac = 602004
PlayerBuffComponent.Gun1Num_BombManiac = 5
-- 7	吸血鬼 击杀怪物时回复1滴血
PlayerBuffComponent.AddHealth_Vampires = 1
-- 8	乌龟壳 开局获得1件3级甲
PlayerBuffComponent.Gun_TortoiseShell = "Armor_Lv3"
-- 9	时空旅者 使用传送门费用-90%
PlayerBuffComponent.Time_TimeTraveler = -0.9


function PlayerBuffComponent:ReceiveBeginPlay()
    PlayerBuffComponent.SuperClass.ReceiveBeginPlay(self)

    local PlayerController = self:GetOwner()
    if PlayerController:HasAuthority() then

    else
        self:CreateStatusBarWidget()
    end
    
    
end


--[[
function PlayerBuffComponent:ReceiveTick(DeltaTime)
    PlayerBuffComponent.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function PlayerBuffComponent:ReceiveEndPlay()
    PlayerBuffComponent.SuperClass.ReceiveEndPlay(self) 
end
--]]


function PlayerBuffComponent:GetReplicatedProperties()
    return "BuffList"
end

function PlayerBuffComponent:OnRep_BuffList()
    --UGCLog.Log("PlayerBuffComponentOnRep_BuffList",self.BuffList)
end
--[[
function PlayerBuffComponent:GetAvailableServerRPCs()
    return
end
--]]
--根据ID 来判断应该给玩家哪些Buff
--@parm InEnumBuff  BuffID
--@parm InValue  对应功能的参数
--@parm InIsOpen 如果是功能相关则是开关  如果是添加相关则为是否是永久存在的
function PlayerBuffComponent:SetPlayerBuff(InEnumBuff,InIsOpen)
    UGCLog.Log("PlayerBuffComponentSetPlayerBuff",InEnumBuff,InIsOpen)
    if self:FindBuffList(InEnumBuff) ~= nil  and not self.bIsRespawnAdd then
       UGCLog.Log("PlayerBuffComponentSetPlayerBuff",InEnumBuff,"已经存在 不再重复添加")   
       return
    end
    if InEnumBuff == Enum_Buff.Epinephrine then
        self:Epinephrine(self.ReloadTimeScale_Epinephrine,InIsOpen)
    elseif InEnumBuff == Enum_Buff.FeetSolesGrease then
        self:FeetSolesGrease(self.SpeedScale_FeetSolesGrease,InIsOpen)
    elseif InEnumBuff == Enum_Buff.GoodBody then
        self:GoodBody(self.MaxHealth_GoodHealth)
        self:AddBuffToMap(Enum_Buff.GoodBody)
    elseif InEnumBuff == Enum_Buff.BountyHunter then
        self:BountyHunter()
    elseif InEnumBuff == Enum_Buff.LoanShark then
        self:LoanShark()
    elseif InEnumBuff == Enum_Buff.AncestralWeapon then
        self:AddGun(self.Gun_AncestralWeapon,false)
    elseif InEnumBuff == Enum_Buff.BombManiac then
        self:BombManiac(false)
    elseif InEnumBuff == Enum_Buff.Vampires then
        self:Vampires(InIsOpen)
    elseif InEnumBuff == Enum_Buff.TortoiseShell then
        self:AddGun(self.Gun_TortoiseShell,false)
    elseif InEnumBuff == Enum_Buff.TimeTraveler then
        self:TimeTraveler()
    elseif InEnumBuff == Enum_Buff.AccurateSniping then
        self:AddPersistSkills(1)
        self:AddBuffToMap(Enum_Buff.AccurateSniping)
    elseif InEnumBuff == Enum_Buff.TuYang_IceCountGreenSkill_P_1_1 then
        self:AddPersistSkills("Skill1_1")
        self:AddBuffToMap(Enum_Buff.TuYang_IceCountGreenSkill_P_1_1)
    elseif InEnumBuff == Enum_Buff.TuYang_WindStandBlueSkill_P_5_4 then
        self:AddPersistSkills("Skill5_4")
        self:AddBuffToMap(Enum_Buff.TuYang_WindStandBlueSkill_P_5_4)
    elseif InEnumBuff == Enum_Buff.TuYang_IceRateBlueSkill_P_2_1 then
        self:AddPersistSkills("Skill2_1")
        self:AddBuffToMap(Enum_Buff.TuYang_IceRateBlueSkill_P_2_1)
    elseif InEnumBuff == Enum_Buff.TuYang_FireCountPurpleSkill_P_1_2 then
        self:AddPersistSkills("Skill1_2")
        self:AddBuffToMap(Enum_Buff.TuYang_FireCountPurpleSkill_P_1_2)
    elseif InEnumBuff == Enum_Buff.TuYang_FireRateGreenSkill_P_2_2 then
        self:AddPersistSkills("Skill2_2")
        self:AddBuffToMap(Enum_Buff.TuYang_FireRateGreenSkill_P_2_2)
    elseif InEnumBuff == Enum_Buff.TuYang_LightCDGreenSkill_P_3_3 then
        self:AddPersistSkills("Skill3_3")
        self:AddBuffToMap(Enum_Buff.TuYang_LightCDGreenSkill_P_3_3)
    elseif InEnumBuff == Enum_Buff.TuYang_WindCountRedSkill_P_1_4 then
        self:AddPersistSkills("Skill1_4")
        self:AddBuffToMap(Enum_Buff.TuYang_WindCountRedSkill_P_1_4)
    elseif InEnumBuff == Enum_Buff.TuYang_LightRateRedSkill_P_2_3 then
        self:AddPersistSkills("Skill2_3")
        self:AddBuffToMap(Enum_Buff.TuYang_LightRateRedSkill_P_2_3)
    elseif InEnumBuff == Enum_Buff.TuYang_LightCountBlueSkill_P_1_3 then
        self:AddPersistSkills("Skill1_3")
        self:AddBuffToMap(Enum_Buff.TuYang_LightCountBlueSkill_P_1_3)
    elseif InEnumBuff == Enum_Buff.TuYang_WindRateBlueSkill_P_2_4 then
        self:AddPersistSkills("Skill2_4")
        self:AddBuffToMap(Enum_Buff.TuYang_WindRateBlueSkill_P_2_4)
    elseif InEnumBuff == Enum_Buff.TuYang_IceMoveRedSkill_P_4_1 then
        self:AddPersistSkills("Skill4_1")
        self:AddBuffToMap(Enum_Buff.TuYang_IceMoveRedSkill_P_4_1)
    elseif InEnumBuff == Enum_Buff.TuYang_LightMovePurpleSkill_P_4_3 then
        self:AddPersistSkills("Skill4_3")
        self:AddBuffToMap(Enum_Buff.TuYang_LightMovePurpleSkill_P_4_3)
    elseif InEnumBuff == Enum_Buff.TuYang_FireMoveBlueSkill_P_4_2 then
        self:AddPersistSkills("Skill4_2")
        self:AddBuffToMap(Enum_Buff.TuYang_FireMoveBlueSkill_P_4_2)
    elseif InEnumBuff == Enum_Buff.TuYang_IceStandRedSkill_P_5_1 then
        self:AddPersistSkills("Skill5_1")
        self:AddBuffToMap(Enum_Buff.TuYang_IceStandRedSkill_P_5_1)
    elseif InEnumBuff == Enum_Buff.TuYang_LightStandPurpleSkill_P_5_3 then
        self:AddPersistSkills("Skill5_3")
        self:AddBuffToMap(Enum_Buff.TuYang_LightStandPurpleSkill_P_5_3)
    elseif InEnumBuff == Enum_Buff.TuYang_FireStandGreenSkill_P_5_2 then
        self:AddPersistSkills("Skill5_2")
        self:AddBuffToMap(Enum_Buff.TuYang_FireStandGreenSkill_P_5_2)
    elseif InEnumBuff == Enum_Buff.TuYang_WindMoveGreenSkill_P_4_4 then
        self:AddPersistSkills("Skill4_4")
        self:AddBuffToMap(Enum_Buff.TuYang_WindMoveGreenSkill_P_4_4)
    elseif InEnumBuff == Enum_Buff.TuYang_FireCDRedSkill_P_3_2 then
        self:AddPersistSkills("Skill3_2")
        self:AddBuffToMap(Enum_Buff.TuYang_FireCDRedSkill_P_3_2)
    elseif InEnumBuff == Enum_Buff.TuYang_IceCDPurpleSkill_P_3_1 then
        self:AddPersistSkills("Skill3_1")
        self:AddBuffToMap(Enum_Buff.TuYang_IceCDPurpleSkill_P_3_1)
    elseif InEnumBuff == Enum_Buff.TuYang_WindCDPurpleSkill_P_3_4 then
        self:AddPersistSkills("Skill3_4")
        self:AddBuffToMap(Enum_Buff.TuYang_WindCDPurpleSkill_P_3_4)
    -- elseif InEnumBuff == Enum_Buff.IceFireParadox then
    --     self:IceFireDamageIncrease()
    -- elseif InEnumBuff == Enum_Buff.LightFireParadox then
    --     self:LightFireDamageIncrease()
    -- elseif InEnumBuff == Enum_Buff.LightParadox then
    --     self:LightDamageIncrease()
    -- elseif InEnumBuff == Enum_Buff.WindParadox then
    --     self:WindAllIncrease()
    -- elseif InEnumBuff == Enum_Buff.TuYang_DmgIncCDGreenSkill_P_3_5 then
    --     self:AddPersistSkills("Skill3_5")
    --     self:AddBuffToMap(Enum_Buff.TuYang_DmgIncCDGreenSkill_P_3_5)
    -- elseif InEnumBuff == Enum_Buff.TuYang_DmgIncCDRedSkill_P_3_6 then
    --     self:AddPersistSkills("Skill3_6")
    --     self:AddBuffToMap(Enum_Buff.TuYang_DmgIncCDRedSkill_P_3_6)
    -- elseif InEnumBuff == Enum_Buff.TuYang_SpeedMoveBlueSkill_P_4_5 then
    --     self:AddPersistSkills("Skill4_5")
    --     self:AddBuffToMap(Enum_Buff.TuYang_SpeedMoveBlueSkill_P_4_5)
    -- elseif InEnumBuff == Enum_Buff.TuYang_SpeedMovePurpleSkill_P_4_6 then
    --     self:AddPersistSkills("Skill4_6")
    --     self:AddBuffToMap(Enum_Buff.TuYang_SpeedMovePurpleSkill_P_4_6)
    elseif InEnumBuff == Enum_Buff.TuYang_SpeedMovePurpleSkill_P_4_7 then
        self:AddPersistSkills("Skill4_7")
        self:AddBuffToMap(Enum_Buff.TuYang_SpeedMovePurpleSkill_P_4_7)
    -- elseif InEnumBuff == Enum_Buff.TuYang_WPCountBlueSkill_P_1_6 then
    --     self:AddPersistSkills("Skill1_6")
    --     self:AddBuffToMap(Enum_Buff.TuYang_WPCountBlueSkill_P_1_6)
    -- elseif InEnumBuff == Enum_Buff.TuYang_WPRatePurpleSkill_P_2_5 then
    --     self:AddPersistSkills("Skill2_5")
    --     self:AddBuffToMap(Enum_Buff.TuYang_WPRatePurpleSkill_P_2_5)
    -- elseif InEnumBuff == Enum_Buff.TuYang_WPCountGreenSkill_P_1_5 then
    --     self:AddPersistSkills("Skill1_5")
    --     self:AddBuffToMap(Enum_Buff.TuYang_WPCountGreenSkill_P_1_5)
    -- elseif InEnumBuff == Enum_Buff.TuYang_WPRateBlueSkill_P_2_6 then
    --     self:AddPersistSkills("Skill2_6")
    --     self:AddBuffToMap(Enum_Buff.TuYang_WPRateBlueSkill_P_2_6)
    elseif InEnumBuff == Enum_Buff.CashCrusader then
        self:AddMoneyInterval()
    elseif InEnumBuff == Enum_Buff.TuYang_WPCountGreenSkill_P_1_7 then
        self:AddPersistSkills("Skill1_7")
        self:AddBuffToMap(Enum_Buff.TuYang_WPCountGreenSkill_P_1_7)
    elseif InEnumBuff == Enum_Buff.TuYang_FireRateRedSkill_P_2_8 then
        self:AddPersistSkills("Skill2_8")
        self:AddBuffToMap(Enum_Buff.TuYang_FireRateRedSkill_P_2_8)
    elseif InEnumBuff == Enum_Buff.TuYang_WoodCountPurpleSkill_P_1_9 then
        self:AddPersistSkills("Skill1_9")
        self:AddBuffToMap(Enum_Buff.TuYang_WoodCountPurpleSkill_P_1_9)
    elseif InEnumBuff == Enum_Buff.TuYang_WoodRateGreenSkill_P_2_9 then
        self:AddPersistSkills("Skill2_9")
        self:AddBuffToMap(Enum_Buff.TuYang_WoodRateGreenSkill_P_2_9)
    elseif InEnumBuff == Enum_Buff.TuYang_WoodCDBlueSkill_P_3_9 then
        self:AddPersistSkills("Skill3_9")
        self:AddBuffToMap(Enum_Buff.TuYang_WoodCDBlueSkill_P_3_9)
    elseif InEnumBuff == Enum_Buff.TuYang_WoodMoveBlueSkill_P_4_9 then
        self:AddPersistSkills("Skill4_9")
        self:AddBuffToMap(Enum_Buff.TuYang_WoodMoveBlueSkill_P_4_9)
    elseif InEnumBuff == Enum_Buff.TuYang_WoodStandRedSkill_P_5_9 then
        self:AddPersistSkills("Skill5_9")
        self:AddBuffToMap(Enum_Buff.TuYang_WoodStandRedSkill_P_5_9)
    end
    self:SetBuffList(InEnumBuff,InIsOpen)
    --更新状态栏
    self:UpDataStatusBarWidget(self.BuffList)
    
end

-- 在选择buff界面添加可选新技能：技能编辑器2.0
function PlayerBuffComponent:AddPersistSkills(InKey)
    local PlayerController = self:GetOwner()
    UGCLog.Log("[maoyu] AddPersistSkills 玩家复活重新添加技能")
    if UE.IsValid(PlayerController) then
        PlayerController:AddPersistSkills(InKey)
    end
    
end

--初始化  复活时把已拥有的buff给上
function PlayerBuffComponent:InitializeBuff()
    UGCLog.Log("InitializeBuff")
    UGCLog.Log("InitializeBuff0.5",self.RespawnBuffList)
    for i, Value in pairs(self.RespawnBuffList) do
        UGCLog.Log("InitializeBuff1",i,Value)
        if Value then
            self.bIsRespawnAdd = true
            self:SetPlayerBuff(i,true)
            self.bIsRespawnAdd = false
        end
    end
end

function PlayerBuffComponent:AddGun(InValue,InIsOpen)
    local PlayerController = self:GetOwner()
    PlayerController:ServerRPC_GiveItem(InValue)
    
end


function PlayerBuffComponent:SetReloadTime()
    
end

function PlayerBuffComponent:GetTargetGunData(InGun)
    for i, tData in pairs(self.GunData) do
        if tData.Gun == InGun then
            return tData
        end
    end
    return nil
end
function PlayerBuffComponent:Epinephrine(InValue,InIsOpen)
    self.ReloadTimeScale = 1 + self.ReloadTimeScale_Epinephrine
     
end
function PlayerBuffComponent:UpDatePlayerBuff_Gun(InGun)
    --UGCLog.Log("UpDatePlayerBuff_Gun",UGCGunSystem.GetTacticalReloadTime(InGun))
    if self.GunData[InGun] == nil then
        local tGunData = {Gun = nil, ReloadTime = 1,Damage = 1}
        tGunData.Gun = InGun
        tGunData.ReloadTime = UGCGunSystem.GetTacticalReloadTime(InGun) * self.ReloadTimeScale
        tGunData.Damage = UGCGunSystem.GetBulletBaseDamage(InGun)
        tGunData.ShootIntervalTime = UGCGunSystem.GetShootIntervalTime(InGun) * self.ShootIntervalTimeScale
        self.GunData[InGun] = tGunData

        --UGCGunSystem.SetTacticalReloadTime(InGun,tGunData.ReloadTime)
        --UGCGunSystem.SetShootIntervalTime(InGun,tGunData.ShootIntervalTime)
        --UGCLog.Log("UpDatePlayerBuff_Gun1",tGunData.ReloadTime)
    else
         --已经改过的枪不做逻辑
    end
end

function PlayerBuffComponent:FeetSolesGrease(InValue,InIsOpen)
    if InIsOpen then
        local tScal = UGCPawnAttrSystem.GetWalkSpeedScale(self:GetOwner().Pawn) * (1 + InValue)
        UGCPawnAttrSystem.SetWalkSpeedScale(self:GetOwner().Pawn,tScal)
        local tScalSprint = UGCPawnAttrSystem.GetSprintSpeedScale(self:GetOwner().Pawn) * (1 + InValue)
        UGCPawnAttrSystem.SetSprintSpeedScale(self:GetOwner().Pawn,tScalSprint)
        self:AddBuffToMap(Enum_Buff.MovingSpeed)
    else
        UGCPawnAttrSystem.SetWalkSpeedScale(self:GetOwner().Pawn,1)
        UGCPawnAttrSystem.SetSprintSpeedScale(self:GetOwner().Pawn,1)
       
    end
    
end
function PlayerBuffComponent:GoodBody(InValue,InIsOpen)
    UGCLog.Log("PlayerBuffComponent:GoodBody0",UGCPawnAttrSystem.GetHealthMax(self:GetOwner().Pawn))
    local tMaxH = UGCPawnAttrSystem.GetHealthMax(self:GetOwner().Pawn) + InValue
    UGCPawnAttrSystem.SetHealthMax(self:GetOwner().Pawn,tMaxH)
    UGCLog.Log("PlayerBuffComponent:GoodBody1",tMaxH)
end
function PlayerBuffComponent:BountyHunter()
    local Owner = self:GetOwner()
    local PlayerController = Owner
    local PlayerState = PlayerController.PlayerState
    local tExtraGold
    --tExtraGold = PlayerState.MonsterDiedGoldScale * 1.1 --[[+ self.ExtraGold_BountyHunter]]
    PlayerState:SetMonsterDiedGoldScale(1.1)
end
function PlayerBuffComponent:LoanShark(InIsOpen)
    local PlayerController = self:GetOwner()
    local PlayerState = PlayerController.PlayerState
    PlayerController:ServerRPC_AddGoldNumber(self.Gold_LoanShark)
    local tGoldSca = PlayerState.MonsterDiedGoldScale + self.GoldScale_LoanShark
    PlayerState:SetMonsterDiedGoldScale(tGoldSca)
end
function PlayerBuffComponent:AncestralWeapon(InIsOpen)

end
function PlayerBuffComponent:BombManiac(InIsOpen)
    local PlayerController = self:GetOwner()
    UGCBackPackSystem.AddItem(self:GetOwner().Pawn, self.Gun1_BombManiac, self.Gun1Num_BombManiac) 

end
function PlayerBuffComponent:Vampires(InIsOpen)
    UGCLog.Log("PlayerBuffComponent:Vampires")
    if InIsOpen then
        EventSystem:AddListener("MonsterDied",self.MonsterDiedEvent,self)
    else
        EventSystem:RemoveListener("MonsterDied",self.MonsterDiedEvent,self)
    end
    self:AddBuffToMap(Enum_Buff.Vampires)
end
function PlayerBuffComponent:MonsterDiedEvent()
    UGCLog.Log("PlayerBuffComponentMonsterDiedEvent")
    if self:GetOwner().Pawn == nil then
        UGCLog.Log("PlayerBuffComponent:Vampires Owner is nil",self:GetOwner().Pawn)
        return
    end
    UGCLog.Log("PlayerBuffComponent:Vampires0",UGCPawnAttrSystem.GetHealth(self:GetOwner().Pawn))
    local tHealth = UGCPawnAttrSystem.GetHealth(self:GetOwner().Pawn) + self.AddHealth_Vampires
    UGCLog.Log("PlayerBuffComponent:Vampires1",tHealth)
    UGCPawnAttrSystem.SetHealth(self:GetOwner().Pawn,tHealth)
end
function PlayerBuffComponent:TimeTraveler()
    local Owner = self:GetOwner().Pawn
    local PlayerController = Owner
    local PlayerState = PlayerController.PlayerState
    PlayerState.TeleportCostScale = PlayerState.TeleportCostScale * (1 + self.Time_TimeTraveler)
end

-- -- 冰火增伤buff
-- function PlayerBuffComponent:IceFireDamageIncrease()
--     local PlayerController = self:GetOwner()
--     PlayerController:IceFireDamageIncrease()
-- end

-- -- 电火增伤buff
-- function PlayerBuffComponent:LightFireDamageIncrease()
--     local PlayerController = self:GetOwner()
--     PlayerController:LightFireDamageIncrease()
-- end

-- -- 电增伤buff
-- function PlayerBuffComponent:LightDamageIncrease()
--     local PlayerController = self:GetOwner()
--     PlayerController:LightDamageIncrease()
-- end

-- -- 风增效buff
-- function PlayerBuffComponent:WindAllIncrease()
--     local PlayerController = self:GetOwner()
--     PlayerController:WindAllIncrease()
-- end

-- 理财达人
function PlayerBuffComponent:AddMoneyInterval()
    local PlayerController = self:GetOwner()
    PlayerController:AddMoneyInterval()
end


--设置已拥有BUFF
function PlayerBuffComponent:SetBuffList(InKey,InIsOpen)
    if InIsOpen then
        if self:FindBuffList(InKey) ~= nil then
            UGCLog.Log(" already have this skill",InKey)
        else
            if type(InKey) ~= "number" then
                UGCLog.Log(" Key is not number",InKey)
                return
            end
            table.insert(self.BuffList,InKey)
        end
        
    else
        local tSub = self:FindBuffList(InKey)
        if tSub ~=  nil then
            table.remove(self.BuffList,tSub)    
        end
        
    end
end
function PlayerBuffComponent:FindBuffList(InKey)
    for k, v in pairs(self.BuffList) do
        if v == InKey then
            return k
        end
    end
    return nil
end

-- 将需要重复添加的Buff加入数组
function PlayerBuffComponent:AddBuffToMap(Key)
    UGCLog.Log("PlayerBuffComponent:AddBuffToMap",Key)
    if self.RespawnBuffList[Key] == nil then
        self.RespawnBuffList[Key] = true
    end
    
    -- if self:FindBuffList(Key) == nil then
    --     UGCLog.Log("PlayerBuffComponent:AddBuffToMap1",Key)
    --     table.insert(self.RespawnBuffList,Key)
    -- end
    
end




-- 状态栏相关
PlayerBuffComponent.StatusBarUI = nil 
local function GetStatusBarWidgetPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/TuYang_BPWidgetBuffStatusBar.TuYang_BPWidgetBuffStatusBar_C')
end

function PlayerBuffComponent:CreateStatusBarWidget()
    local PlayerController = self:GetOwner()
    if self.StatusBarUI == nil then
        local StatusBarUIClass = UE.LoadClass(GetStatusBarWidgetPath())
        self.StatusBarUI = UserWidget.NewWidgetObjectBP(PlayerController , StatusBarUIClass)
    end
    self.StatusBarUI:AddToViewport(10000)
end

function PlayerBuffComponent:UpDataStatusBarWidget(InBuffList)
    local PlayerController = self:GetOwner()
    if PlayerController:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(PlayerController,self,"UpDataStatusBarWidget",InBuffList)
    else
       if self.StatusBarUI ~= nil then
            self.StatusBarUI:UpDataStatusBar(InBuffList)
       else
            self:CreateStatusBarWidget()
            Timer.InsertTimer(1,
            function()
                self:UpDataStatusBarWidget(InBuffList)
            end,false)
       end
    end
    
end
return PlayerBuffComponent