---@class BPPlayerController_ProtectAthena_C:BP_UGCPlayerController_C
---@field RankingListComponent RankingListComponent_C
---@field BP_PayLockComponent BP_PayLockComponent_C
---@field PlayerBuffComponent PlayerBuffComponent_C
---@field ShopV2Component ShopV2Component_C
--Edit Below--
local BPPlayerController_ProtectAthena = BPPlayerController_ProtectAthena or {}
UGCGameSystem.UGCRequire("ExtendResource.RankingList.OfficialPackage.Script.RankingList.RankingListManager")
local Action_GameFight = require("Script.GameMode.Action_GameFight")

local TuYang_ShopConfig = require("Script.TuYang_ShopConfig")
local WeaponConfig = require("Script.TuYang_WeaponConfig")
local TuYang_PlayerBuffConfig = require("Script.Config.TuYang_PlayerBuffConfig")

local TaskButton = nil
local VoteClass

--TuYang

BPPlayerController_ProtectAthena.TuYangShopWidget = nil

-- 战术技能玩家CD
BPPlayerController_ProtectAthena.TacticalSkillLastUseTimeMap = {}
BPPlayerController_ProtectAthena.TacticalSkillLastUseTimeMap['skill_1'] = -300
-- 战术增益玩家CD
BPPlayerController_ProtectAthena.TacticalBuffIsUsingMap = {} --0=true 1=false
BPPlayerController_ProtectAthena.TacticalBuffIsUsingMap['skill_2'] = false
-- 新技能列表
BPPlayerController_ProtectAthena.SkillInstanceList = BPPlayerController_ProtectAthena.SkillInstanceList or {}
-- 开场Sequence跳过
BPPlayerController_ProtectAthena.StartSequence = nil
-- 第一次选择保底 不同步 只需在客户端修改
BPPlayerController_ProtectAthena.bFirstChooseSafety = false
function BPPlayerController_ProtectAthena:GetBPWidget_GameFightClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_GameFight.BPWidget_GameFight_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPPlayerController_ProtectAthena:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, Victim)
    return self.Pawn:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, Victim)
end

function BPPlayerController_ProtectAthena:GetBPWidget_RoundGameReadyClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_RoundGameReady.BPWidget_RoundGameReady_C')
end
function BPPlayerController_ProtectAthena:GetBPWidget_RoundEndClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_RoundEnd.BPWidget_RoundEnd_C') 
end
function BPPlayerController_ProtectAthena:GetReplicatedProperties()
    return "PlayerBuffComponent"
end
function BPPlayerController_ProtectAthena:GetAvailableServerRPCs()
    return 
    "ServerRPC_AddGoldNumber",
    "ServerRPC_DecreaseGold",     
    "ServerRPC_ShowRespawnUI",
    "ServerRPC_Respawn",
    "ServerRPC_Suicide",      
    "ServerRPC_SaveData",
    "ServerRPC_MonsterShop",
    "ServerRPC_Buy",
    "ClientRPC_PlaySound",
    "ServerRPC_PlayerTeleportStart",
    "ServerRPC_ClickBuffToSelect",
    "ServerRPC_WeaponBuy",
    "ServerRPC_GiveItem",
    "ServerRPC_RefreshTheWeaponList",
    "ServerRPC_UseCommercialCommodityRule",
    "ServerRPC_BuffSkillBuy",
    "ServerRPC_RefreshTheBuffSkillList",
    "ServerRPC_UseRefreshRule",
    

    "GM_SavePlayerData"
    
end

function BPPlayerController_ProtectAthena:OnRep_PlayerBuffComponent()
    
end


function BPPlayerController_ProtectAthena:ReceiveBeginPlay()
    UGCLog.Log("BPPlayerController_ProtectAthena:ReceiveBeginPlay")
    BPPlayerController_ProtectAthena.SuperClass.ReceiveBeginPlay(self)
    local GameState = UGCGameSystem.GetGameState()

    -- 创建一个延时执行函数体
    local OBTimerDelegate = ObjectExtend.CreateDelegate(self, 
    function()
        if self:HasAuthority() == true then -- 判断是否在服务端执行
            local PlayerPawn = self:GetPlayerCharacterSafety()  -- 获取玩家角色Pawn
            if PlayerPawn ~= nil then
                --self:ServerRPC_GiveItem("P92")-- 为角色增加物品
                --UGCBackPackSystem.AddItem(PlayerPawn, 301001, 100)
                --local weapon1 = UGCWeaponManagerSystem.GetCurrentWeapon(PlayerPawn)

                --local tString = WeaponConfig:GetWeaponOriginalData(self,"SawedOff")
                -- UGCBackPackSystem.AddItem(PlayerPawn, 101011, 100)
                -- local tstring = WeaponConfig:CreateNewDataBasedOnTheOldStore(101011,2)
                -- UGCLog.Log("BPPlayerController_ProtectAthenaReceiveBeginPlay",tstring)
                -- WeaponConfig:GetWeaponData("VAL",PlayerPawn)
                
            end
        end
    end
    )
    -- 执行延时函数体
    KismetSystemLibrary.K2_SetTimerDelegateForLua(OBTimerDelegate, self, 2, false)

    ugcprint(string.format("BPPlayerController_ProtectAthena:ReceiveBeginPlay[%s]", self.PlayerKey))
    if self:HasAuthority() == true then
        -- 玩家复活回调
        self.PlayerControllerRespawnedDelegate:Add(self.OnRespawned, self)
        -- 玩家死亡回调
        self.OnCharacterDeadDelegate:Add(self.OnDeath, self)
        local RespawnComponent= UGCGameSystem.GetRespawnComponent()
        if RespawnComponent then 
            RespawnComponent.DefaultRespawnInvincibleTime = 3
        end
        
        -- 初始化卡池
        if #self.PlayerState.SelectableBuffsList == 0 then
            for k, v in pairs(TuYang_PlayerBuffConfig.ItemsGroup) do
                table.insert(self.PlayerState.SelectableBuffsList,k)
            end
        end
        -- 断线重连复活
        local PS = UGCGameSystem.GetPlayerStateByPlayerKey(self.PlayerKey)
        UGCLog.Log("BPPlayerController_ProtectAthena:ReceiveBeginPlay1",PS.PlayerKey)
        if  PS.isReconnected  and not UGCPlayerStateSystem.IsAlive(self.PlayerKey) then
            self:RoundEndRespawn()
        end
    else
        -- 商店按钮UI
        local ShopMainUIClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('ExtendResource/ShopV2/OfficialPackage/Asset/ShopV2/Blueprint/ShopV2_OpenShopButton_UIBP.ShopV2_OpenShopButton_UIBP_C'));
        local ShopMainUI = UserWidget.NewWidgetObjectBP(self, ShopMainUIClass);
        ShopMainUI:AddToViewport(1000);
        -- -- 排行榜测试UI
        -- local RankListBtnClass = UE.LoadClass(UGCMapInfoLib.GetRootLongPackagePath().. "ExtendResource/RankingList/OfficialPackage/Asset/RankingList/Blueprint/WBP_RankingListBtn.WBP_RankingListBtn_C");
        -- local RankListBtn = UserWidget.NewWidgetObjectBP(self, RankListBtnClass);
        -- RankListBtn:AddToViewport(1000);
        --GM界面
        local GMBtnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/BP_TextGM.BP_TextGM_C'));
        local GMBtnBtn = UserWidget.NewWidgetObjectBP(self, GMBtnClass);
        GMBtnBtn:AddToViewport(10200);
        -- 加入语音房间
        self:UGCJoinVoiceRoom()
       
        -- 武器商店选择界面保底 
        self.StartSequenceEndTimer = Timer.InsertTimer(45,function()
           self:StartSequenceEnd()
        end,false)       
    end
    -- UGCLog.LogVector("BPPlayerControllerReceiveBeginPlay",GameState.RoundStartTepeportActorLocation[self.TeamID])
    -- --local text = KismetStringLibrary.Conv_VectorToString(GameState.RoundStartTepeportActorLocation[self.TeamID])
    -- --local text = tostring(UE.ToTable(GameState.RoundStartTepeportActorLocation[self.TeamID]))
    -- local tloc = self:K2_GetActorLocation()
    -- local trot = self:K2_GetActorRotation()
    -- local tdata = {a = 1,b = 2,c = 3}
    -- UGCLog.LogVector("BPPlayerControllerReceiveBeginPlay",tloc,trot,tdata)
  
end



function BPPlayerController_ProtectAthena:ServerRPC_AddGoldNumber(gold)
    if self:HasAuthority() then
        self.PlayerState:RPCAddGold(gold)
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_AddGoldNumber",gold)
    end
   
end

function BPPlayerController_ProtectAthena:ServerRPC_DecreaseGold(InGold)
    if self:HasAuthority() then
        self.PlayerState:DecreaseGold(InGold)
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_DecreaseGold",InGold)
    end    
end

function BPPlayerController_ProtectAthena:ServerRPC_ShowRespawnUI()
    ugcprint("RespawnUI show")
   -- local function ShowRespawnUI()
    --local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Captions/HintTime.HintTime_C')--UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Captions/HintTime.HintTime_C')
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/RespawnUI.RespawnUI_C')
    local UIClass = UE.LoadClass(path)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if self.RespawnUI == nil then
        self.RespawnUI = UserWidget.NewWidgetObjectBP(PlayerController , UIClass)
    end
    self.RespawnUI:AddToViewport(10)

end
function BPPlayerController_ProtectAthena:RespawnEndCountDownStart()
    UGCLog.Log("RespawnEndCountDownStart")
    if self:HasAuthority() then
        local tNum,times
        if self.PlayerState == nil then
            UGCLog.Log("RespawnEndCountDownStart PlayerState = nil")
            return
        end
        if self.PlayerState:GetiBeenRespawnNums() == nil then
            UGCLog.Log("RespawnEndCountDownStart iBeenRespawnNums = nil")
            self.PlayerState:SetiBeenRespawnNums(0)
        end
        if self.PlayerState:GetiBeenRespawnNums() < #self.PlayerState.PlayerRespawnTime then
            tNum = self.PlayerState:GetiBeenRespawnNums() + 1
        else
            tNum = #self.PlayerState.PlayerRespawnTime
        end
        times = self.PlayerState.PlayerRespawnTime[tNum]
        UGCLog.Log("RespawnEndCountDownStart",times,tNum)
        self.PlayerState:SetRespawnTime(times)
        self.RespawnTimer = Timer.InsertTimer(
        1, 
        function() 
           self:TimerSetRespawnTime()
        end, 
        true
        )
        UnrealNetwork.CallUnrealRPC(self,self,"RespawnEndCountDownStart")
    else
         -- 处于武器选择界面 关闭界面 返还花费
        if self.BPWidget_WeaponChoose ~= nil and self.BPWidget_WeaponChoose:IsInViewport() then
            self.BPWidget_WeaponChoose:Close()
            self:ServerRPC_AddGoldNumber(3000)
            return
        end
    end
   
end
function BPPlayerController_ProtectAthena:TimerSetRespawnTime()
    if self:HasAuthority() then
        local PlayerState = self.PlayerState
        PlayerState:SetRespawnTime(PlayerState:GetRespawnTime() - 1)
        if PlayerState:GetRespawnTime() <= 0 then
            Timer.RemoveTimer(self.RespawnTimer)
            UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_Respawn",false)
        end
    end
end

function BPPlayerController_ProtectAthena:ServerRPC_Respawn(IsQucik)
    ugcprint("Player Respawn!")
    if self:HasAuthority() then
        local RespawnComponent= UGCGameSystem.GetRespawnComponent()

        if RespawnComponent then
            Timer.RemoveTimer(self.RespawnTimer)
            if IsQucik then 
                UGCLog.Log("BPPlayerController_ProtectAthena:ServerRPC_RespawnIsQucik")
                self:ServerRPC_UseCommercialCommodityRule(1002,1)
                --UGCCommoditySystem.UseUGCCommodity2(self,1002,tIcon,tDes,1,true)
                return
            end
            RespawnComponent:AddRespawnPlayerWithTime(self.PlayerKey, 1)
            self.PlayerState:SetiBeenRespawnNums(self.PlayerState:GetiBeenRespawnNums() + 1) 
            self:CloseRespawnUI()           
        end
        
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_Respawn",IsQucik)
    end
    
end

function BPPlayerController_ProtectAthena:ShowBuyRevivalCoinUIFirstOrder()
    --复活币购买一级界面 Client
    local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_RevivalCoin.BPWidget_RevivalCoin_C')
    local tClass = UE.LoadClass(tPath)
    if self.BuyRevivalCoinUIFirstOrder == nil then
        self.BuyRevivalCoinUIFirstOrder = UserWidget.NewWidgetObjectBP(self , tClass)
    end
    self.BuyRevivalCoinUIFirstOrder:AddToViewport(10)
end

function BPPlayerController_ProtectAthena:BuyRevivalCoin(InNum)
    UGCLog.Log("BuyRevivalCoin")
    local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/Data/Table/UGCObject.UGCObject')
    local tData = UGCGameSystem.GetTableDataByRowName(tPath,"1002")
    
    local tIcon = tData.ItemSmallIcon_n
    local tDes = tData.ItemDesc
    local tCommodityID = 9000001
    if InNum == 1 then
        tCommodityID = 9000001
    elseif InNum == 5 then
        tCommodityID = 9000003
    elseif InNum == 10 then
        tCommodityID = 9000004
    end
    UGCCommoditySystem.BuyUGCCommodity2(tCommodityID,tIcon,tDes,1)
    
end
function BPPlayerController_ProtectAthena:RevivalCoinCommodityResult(InbSucceed,InCount)
    --UGCLog.Log("BPPlayerController_ProtectAthena:RevivalCoinCommodityResult")
    if InbSucceed then
        if self:HasAuthority() then
            self.PlayerState:SetRespawnCount(self.PlayerState:GetRespawnCount() + InCount)
            UnrealNetwork.CallUnrealRPC(self,self,"RevivalCoinCommodityResult",InbSucceed,InCount)
        else
            self.BuyRevivalCoinUIFirstOrder:RemoveFromViewport()
        end
    end
    
end


function BPPlayerController_ProtectAthena:UseRevivalCoin(InbSucceed)
    if InbSucceed and self:HasAuthority() then
        local RespawnComponent= UGCGameSystem.GetRespawnComponent()
        --self.PlayerState:MinusRespawnCount()
        RespawnComponent:AddRespawnPlayerWithTime(self.PlayerKey, 1)
        self.PlayerState:SetiBeenRespawnNums(self.PlayerState:GetiBeenRespawnNums() + 1)
        self:CloseRespawnUI()
    end
end
--回合结束复活
function BPPlayerController_ProtectAthena:RoundEndRespawn()
    local RespawnComponent= UGCGameSystem.GetRespawnComponent()
    UGCLog.Log("RoundEndRespawn")
    if self:HasAuthority() then
        if not UGCPlayerStateSystem.IsAlive(self.PlayerKey) then
            UGCLog.Log("RoundEndRespawn1")
            RespawnComponent:AddRespawnPlayerWithTime(self.PlayerKey, 1)
            self.PlayerState:SetiBeenRespawnNums(self.PlayerState:GetiBeenRespawnNums() + 1)
            self:CloseRespawnUI()
            Timer.RemoveTimer(self.RespawnTimer)
        end
        UnrealNetwork.CallUnrealRPC(self,self,"RoundEndRespawn")
    else
    end
    
    
end

function BPPlayerController_ProtectAthena:CloseRespawnUI()
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"CloseRespawnUI")
    else
          if self.RespawnUI ~= nil then
            self.RespawnUI:RemoveFromViewport()
        else
            UGCLog.Log("ServerRPC_RespawnRespawnUI = nil")
        end
        if self.BuyRevivalCoinUIFirstOrder ~= nil then
            self.BuyRevivalCoinUIFirstOrder:RemoveFromViewport()
        end
    end
end
function BPPlayerController_ProtectAthena:ServerRPC_Suicide()
    ugcprint("ApplyDamage!")
    if self:HasAuthority() then
        UGCGameSystem.ApplyDamage(self.Pawn,1000,self)
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_Suicide")    
    end
    
    --local Damage = UGCGameSystem.ApplyRadialDamage(1000,1000,OtherActor:K2_GetActorLocation(),10,10,0, EDamageType.RadialDamage,nil,nil,nil,ECollisionChannel.ECC_Visibility, 0);
end




-- （DS）玩家复活回调
function BPPlayerController_ProtectAthena:OnRespawned(Controller)
    ugcprint(string.format("UGCPlayerController:OnRespawned[%s]", self.PlayerName))
    --self:CheckIsHeavyWeaponSetMaxHealth()
end

-- （DS）玩家死亡回调
function BPPlayerController_ProtectAthena:OnDeath(Controller)
    ugcprint(string.format("UGCPlayerController:OnDeath[%s]", self.PlayerName))

    -- if Timer.IsTimerExistByName("CheckAndRefillBulletTimers") then
    --     Timer.RemoveTimerByName("CheckAndRefillBulletTimers")
    -- end

    -- 移除所有技能
    self.SkillInstanceList = nil

    if self.SkillTimers then
        for k, v in pairs(self.SkillTimers) do
            Timer.RemoveTimer(v)
        end
    end


        --Timer.RemoveTimer(self.SkillTimers[InKey])
end



function BPPlayerController_ProtectAthena:UGCJoinVoiceRoom()				--UGCTeamID为开发者自己注册的同步参数
    local RoomName = "TeamVoiceRoom"..tostring(self.TeamID)
    UGCVoiceManagerSystem.JoinVoiceRoom(RoomName)
end

function BPPlayerController_ProtectAthena:Inherit()
    ugcprint("Update id begin!")
    local gamestate = UGCGameSystem.GetGameState()
    
    local PlayerState = self.PlayerState
    local PlayerInfo = UGCPlayerStateSystem.GetPlayerAccountInfo(PlayerState.PlayerKey)

    ugcprint("PlayerSave LOad Data" ..PlayerState.UID)
    local readArchive = UGCPlayerStateSystem.GetPlayerArchiveData(PlayerState.UID)
        if readArchive then
        if readArchive.Gold then
            ugcprint("PlayerSave Gold is " ..readArchive.Gold)
            PlayerState.Gold = PlayerState.Gold +math.floor(readArchive.Gold*1) 
        end
        if readArchive.Weapon then
            ugcprint("Has Weapon")
                for _,WeaponID in pairs(readArchive.Weapon) do
                if WeaponID then
                    --local WeaponID = Weapon.DefineID.TypeSpecificID
                    --if WeaponID then
                        ugcprint("Weapong id "..tostring(WeaponID))

                        --UGCBackPackSystem.AddItem(self:GetPlayerCharacterSafety(),WeaponID,1)
                        --使用PlayerController进行添加物品
                        local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(self.PlayerKey)
                        PlayerController:AddItem(WeaponID, 1)
                        ugcprint("玩家添加武器"..tostring(WeaponID))
                    --end
                end
            end
        end
    end
end

BPPlayerController_ProtectAthena.GoldCommodityList = 
{
    {Key = 1,Name = "BuffRefresh",Cost = 250,Widget = nil},-- buff 商店刷新
    {Key = 2,Name = "WeaponRefresh",Cost = 250,Widget = nil},-- 武器商店刷新
    {Key = 3,Name = "TeleportCost",Cost = 1000,Widget = nil},-- 传送
    {Key = 4,Name = "BuffShop",Cost = 3000,Widget = nil},--Buff商店
    {Key = 5,Name = "WeaponShop",Cost = 3000,Widget = nil},--武器商店
}
-- 购买并修改定制化价格
function BPPlayerController_ProtectAthena:ServerRPC_Buy(InKey,...)
    UGCLog.Log("BPPlayerController_ProtectAthenaServer_Buy", InKey)
    local tData = self.GoldCommodityList[InKey]
    if tData == nil then 
        UGCLog.Log("Error CheckBuyItem tData = nil",InKey)
        return 
    end
    if self:HasAuthority()  then
        local GameState = UGCGameSystem.GetGameState()
        local PlayerPawn = self:GetPlayerCharacterSafety()
        
        if InKey == 1 or InKey == 2 then
            --UGCLog.Log("BPPlayerController：Server_Buy1")
            if self:CheckBuyItem(InKey,tData.Cost) then
                self:UseRefreshPoint(true)
            end
        elseif InKey == 3 then
            local InID,tLoc,tRot = ...
            --local InID,tLoc,tRot = select(1, ...),select(2, ...),select(3 , ...)
            --UGCLog.Log("BPPlayerController：TeleportServerRPC_Buy",InID)
            if self:CheckBuyItem(InKey,tData.Cost) then 
                PlayerPawn.bShouldDumpCallstackWhenMovingfast = false
                PlayerPawn:SetClientLocationOrRotation(tLoc, tRot, true, false)
                PlayerPawn.bShouldDumpCallstackWhenMovingfast = true

                GameState:UseTheTelepont(InID)
            end
        elseif InKey == 4 then --Buff商店
            local InGroundID,ShopID = ...
            local PlayerState = self.PlayerState
            if ShopID == 0 then
                UGCLog.Log("Error [LJH]ServerRPC_BuffSkillBuy ShopID == 0")
                return
            end
            local tShopConfigData = self:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.BuffSkillShop,1,ShopID)
            tData.Cost = self:HandleStageDiscount(tShopConfigData.Cost)
            if self:CheckBuyItem(InKey,tData.Cost) then
                UGCLog.Log("[LJH] BuffSkillBuySecceed")
                local GameState = UGCGameSystem.GetGameState()
                self:ServerRPC_RefreshTheBuffSkillList(InGroundID,ShopID)
            end
        elseif InKey == 5 then  --武器商店
            local InGroundID,ShopID = ...
            local PlayerState = self.PlayerState
            if ShopID == 0 then
                UGCLog.Log("[LJH]ServerRPC_WeaponBuy ShopID == 0")
                return
            end
            PlayerState.iPlayerWhichWeaponStore = ShopID
            local tShopConfigData = self:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.WeaponShop,InGroundID,ShopID)
            tData.Cost = self:HandleStageDiscount(tShopConfigData.Cost)
            
            if self:CheckBuyItem(5,tData.Cost) then
                self:ServerRPC_RefreshTheWeaponList(InGroundID,self.PlayerState.iPlayerWhichWeaponStore)
            end
           
        end

    else
       
        UnrealNetwork.CallUnrealRPC(self, self,"ServerRPC_Buy", InKey,...)
    end
end
-- 购买物品检查并扣钱(游戏内金币物品)
function BPPlayerController_ProtectAthena:CheckBuyItem(InKey,InCost)
    local bIsEnough = false
    local iReason = 0 -- 0表示成功，1-金币不足 2-等级达到上限，3表示冷却中，4表示战术增益正在被使用,5-准备期间暂停购买；6 - 技能碎片不足
    local PlayerState = self.PlayerState
    -- UI 
    if InKey == 1 or InKey == 2 or InKey == 3 or InKey == 5 then
      bIsEnough = self.PlayerState:CheckGoldEnough(InCost) 
        if bIsEnough then
            iReason = 0
            self:ServerRPC_DecreaseGold(InCost)
        else
            iReason = 1
        end
        UnrealNetwork.CallUnrealRPC(self, self,"ClientRPC_CheckBuyItem", InKey, iReason)
    elseif InKey == 4 then
        --Buff商店
        if PlayerState:GeReconnectDataValue("iBuffSkillElement") < PlayerState.BuffSkillElementNeed then
            iReason = 6
            bIsEnough = false
            UnrealNetwork.CallUnrealRPC(self, self,"ClientRPC_CheckBuyItem", InKey, iReason)
            return bIsEnough
        end
        bIsEnough = self.PlayerState:CheckGoldEnough(InCost) 
        if bIsEnough then
            iReason = 0
            self:ServerRPC_DecreaseGold(InCost)
            PlayerState:SetReconnectDataValue("iBuffSkillElement",PlayerState:GeReconnectDataValue("iBuffSkillElement") - PlayerState.BuffSkillElementNeed)
            
        else
            iReason = 1
        end
        UnrealNetwork.CallUnrealRPC(self, self,"ClientRPC_CheckBuyItem", InKey, iReason)
        
    end

    
    return bIsEnough
end
function BPPlayerController_ProtectAthena:ClientRPC_CheckBuyItem(InKey,iReason)
    UGCLog.Log("BPPlayerController_ProtectAthena：ClientRPC_CheckBuyItem",InKey,iReason)
    local tData = self.GoldCommodityList[InKey]
    if tData == nil then 
        UGCLog.Log("Error BPPlayerController_ProtectAthena:ClientRPC_CheckBuyItem tData = nil",InKey)
        return 
    end
    if iReason == 0 then
        if tData.Widget ~= nil then
            if tData.Widget.CheckBuyItem then
                tData.Widget:CheckBuyItem(iReason)
            else
                UGCLog.Log("Error ClientRPC_CheckBuyItem tData.Widget dont have CheckBuyItem",tData)    
            end
        else
            UGCLog.Log("Error ClientRPC_CheckBuyItem tData.Widget = nil",tData)
        end
    else
        if tData.Widget ~= nil then
            if tData.Widget.CheckBuyItem then
                tData.Widget:CheckBuyItem(iReason)
            else
                UGCLog.Log("Error ClientRPC_CheckBuyItem tData.Widget dont have CheckBuyItem",tData)    
            end
        else
            UGCLog.Log("Error ClientRPC_CheckBuyItem tData.Widget = nil",tData)
        end
    end
end
--TuYang
function BPPlayerController_ProtectAthena:GetBPWidget_GameRulesClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_Rule.TuYang_Rule_C')
end

function BPPlayerController_ProtectAthena:GetBPWidget_GameReadyClassPath()
    return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_GameReady.BPWidget_GameReady_C']], UGCMapInfoLib.GetRootLongPackagePath())
end
BPPlayerController_ProtectAthena.BPWidget_GameReady = nil
BPPlayerController_ProtectAthena.BPWidget_GameRule = nil

function BPPlayerController_ProtectAthena:PlayerLogin()
    UGCLog.Log("BPPlayerController_ProtectAthenaPlayerLogin")
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
         --矫正商品数量
         local Result = UGCCommoditySystem.GetAllPlayerUGCCommodityList()
         for i, tData in pairs(Result[self:GetInt64UID()]) do
             UGCLog.Log("Action_PlayerLoginUpDataCommodityNumber",tData)
             self:UpDataCommodityNumber(tData.CommodityID,tData.Count)
         end
    else
        --准备倒计时UI
        local BPWidget_GameReadyClass = UE.LoadClass(self:GetBPWidget_GameReadyClassPath())
        if UE.IsValid(BPWidget_GameReadyClass) then
            self.BPWidget_GameReady = UserWidget.NewWidgetObjectBP(self, BPWidget_GameReadyClass)                
            if UE.IsValid(self.BPWidget_GameReady) then
                self.BPWidget_GameReady:AddToViewport(0)
            end
        end
         -- 规则界面  --   
        -- local BPWidget_GameRuleClass = UE.LoadClass(self:GetBPWidget_GameRulesClassPath())
        -- if UE.IsValid(BPWidget_GameRuleClass) then
        --     if self.BPWidget_GameRule == nil then
        --         self.BPWidget_GameRule = UserWidget.NewWidgetObjectBP(self, BPWidget_GameRuleClass)  
        --     end      
        --     if UE.IsValid(self.BPWidget_GameRule) then
        --         self.BPWidget_GameRule:AddToViewport(10100)
        --     end
        -- end
        -- 改为 -- 
        --直接出选择界面 -- 这个地方直接调用有可能会 self.PlayerState == nil 导致找不到 
        
        -- 进游戏就播放BGM
        if self.PlayerState ~= nil then
            self:ClientRPC_PlaySound(1)
        else
            Timer.InsertTimer(1,
            function()
                self:ClientRPC_PlaySound(1)
            end,false)
        end
        
        
    end
    -- 开场Sequence跳过的绑定
    if self.StartSequence ~= nil then
        self.StartSequence.SequencePlayer.OnStop:Add(self.StartSequenceEnd,self)
        -- self.StartSequence.SequencePlayer.OnFinished:Add(self.StartSequenceEnd,self)
    end
    
end
function BPPlayerController_ProtectAthena:TimerPlayerLogin()
    if self.PlayerState.bIsFirstChoose then
        self:ServerRPC_RefreshTheWeaponList(2,1)
    end
   
end
    

function BPPlayerController_ProtectAthena:PlayerFirstGameJoin()
    UGCLog.Log("BPPlayerController_ProtectAthenaPlayerFirstGameJoin")
   
end

function BPPlayerController_ProtectAthena:ServerRPC_MonsterShop(InShopID,InKey,InBelong)
    ugcprint("ServerRPC_MonsterShop"..InKey)
    if self:HasAuthority() then
        local GameState = UGCGameSystem.GetGameState()
        if InShopID == 1 then
            self:UpMonsterLevel(InShopID,InKey,InBelong)
        elseif InShopID == 2 then
            self:SummonMonsterStore(InShopID,InKey,InBelong)
        end

    else
        UnrealNetwork.CallUnrealRPC(self, self, "ServerRPC_MonsterShop",InShopID,InKey,InBelong)
    end
end

function BPPlayerController_ProtectAthena:UpMonsterLevel(InShopID,InKey,InBelong)
    local tDataSource = {}
    local GameState = GameplayStatics.GetGameState(self)
   
    if UE.IsValid(GameState) then       
        tDataSource = GameState.BP_EnemyShopComponent:GetDataSourceItem(1,InKey,self)
        local Playerstate = self.PlayerState
        UGCLog.Log("BPPlayerController_ProtectAthenaUpMonsterLevel")
        if self:BShoppingCost(InShopID,Playerstate,tDataSource,InBelong)  then
            GameState:AddMonsterLevel(self.PlayerState.TeamID)
        end
        
    end
end


function BPPlayerController_ProtectAthena:SummonMonsterStore(InShopID,InKey,InBelong)
      -- 资源加载
      local GameState = UGCGameSystem.GetGameState()
      local Playerstate = self.PlayerState
      local ProductData = GameState.BP_EnemyShopComponent:GetDataSourceItem(InShopID,InKey)

      UGCLog.Log("BPPlayerController_ProtectAthenaSummonMonsterStore")
      -- 1-> 召唤怪物
      -- 2-> 战术技能
      -- 3-> 战术增益
      if self:HasAuthority() then
          if InBelong == 1 and self:BShoppingCost(InShopID,Playerstate,ProductData,InBelong) then
              self:SpawnSpecialMonster(InKey)
          elseif InBelong == 2 and self:BShoppingCost(InShopID,Playerstate,ProductData,InBelong) then
            if InKey == "skill_1" then
                self:SpawnProjectileSequenceActor(Playerstate,ProductData)
            elseif InKey == "skill_2" then

            end
              
          elseif InBelong == 3 and self:BShoppingCost(InShopID,Playerstate,ProductData,InBelong) then
              self:SpawnVehicleWeapon(ProductData)
          end
      end
end



-- 购买物品检查并扣除金币
function BPPlayerController_ProtectAthena:BShoppingCost(InShopID,InPlayerState,InData,Belong)

    local iReason = 0 -- 0表示成功，1-金币不足 2-等级达到上限，3表示冷却中，4表示战术增益正在被使用,5-准备期间暂停购买
    local GameState = GameplayStatics.GetGameState(self)

    if not GameState.bIsOpenShovelAbility then
        UGCLog.Log("[LJH] 购买物品失败，准备期间暂停购买")
        iReason = 5
        UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", false,iReason)
        return false
    end
    if InShopID == 1 then
        local tTeamID = self.PlayerState.TeamID
        local tLevel = 1
        local tMaxLevel = #(GameState.BP_EnemyShopComponent.DataSource1.Items)
        if tTeamID == 1 then
            tLevel = GameState.iID2MonsterLevel
        elseif tTeamID == 2 then
            tLevel = GameState.iID1MonsterLevel
        end
        if tLevel >= tMaxLevel then
            UGCLog.Log("[LJH] 等级达到上限")
            iReason = 2
            UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", false,iReason)
            return false
        end
    elseif InShopID == 2 then
        if Belong == 2 then 
    
            if self:IsCooldownReady(self.TacticalSkillLastUseTimeMap,InData) == false or GameState.TacticalSkillProjectileTarget ~= nil then
                iReason = 3
                UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", false,iReason)
                UGCLog.Log("[maoyu] 战术技能冷却时间检查，冷却中")
                return false
            end
        end
    
        if Belong == 3 then
            local tacticalBuffMap = self.PlayerState.TeamID == 1 and GameState.Team1TacticalBuffIsUsingMap or GameState.Team2TacticalBuffIsUsingMap
            --UGCLog.Log("[maoyu] 战术增益Map = ",tacticalBuffMap)
            if self:IsUsingTacticalBuff(tacticalBuffMap, InData) then
                iReason = 4
                UGCLog.Log("[maoyu] 战术增益正在被使用")
                UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", false,iReason)
                return false
            end
        end
    end

    UGCLog.Log("[maoyu] 购买物品扣金币")
    if InPlayerState.Gold < InData.Cost then
        iReason = 1
        UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", false,iReason)
    end
    if InPlayerState.Gold >= InData.Cost then
        UGCLog.Log("[maoyu] 成功扣除金币")
        UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", true,iReason)
        self:ServerRPC_DecreaseGold(InData.Cost)
        return true
    end
    UGCLog.Log("[maoyu] 扣除金币失败，金币不足，其他原因")
    
    return false
end

function BPPlayerController_ProtectAthena:ClientRPC_SecceedOrFailBuy(Inbool,IniReset)
    UGCLog.Log("ClientRPC_SecceedOrFailBuy")
    if self.UpLevelMonsterWidget ~= nil and self.UpLevelMonsterWidget:IsInViewport() then
        self.UpLevelMonsterWidget:SecceedOrFailUpLevel(Inbool,IniReset)
    end
    if self.TuYangShopWidget ~= nil and self.TuYangShopWidget:IsInViewport() then
        self.TuYangShopWidget:SecceedOrFailBuy(Inbool,IniReset)
    end
end

-- 检查冷却时间是否结束
-- @param InLastUseTimeArr: 上次使用的时间戳map（秒）
-- @param InData.Cooldown: 冷却时间（秒）
-- @return 是否可以使用（true 表示冷却结束，可以使用）
function BPPlayerController_ProtectAthena:IsCooldownReady(InLastUseTimeArr,InData)

    local CurrentTime = GameplayStatics.GetTimeSeconds(self) -- 获取当前时间戳
    --UGCLog.Log("[maoyu] 当前时间戳: ", InLastUseTimeArr[InData.Key])
    if (CurrentTime - InLastUseTimeArr[InData.Key]) >= InData.Cooldown then
        InLastUseTimeArr[InData.Key] = CurrentTime -- 更新上次使用时间
        UGCLog.Log("[maoyu] 更新上次使用时间:")
        print(self.TacticalSkillLastUseTimeMap)

        return true -- 冷却结束
    else
        return false -- 冷却中
    end
end

-- 检查战术增益是否在被使用
function BPPlayerController_ProtectAthena:IsUsingTacticalBuff(InTacticalBuffIsUsingMap,InData)
    --UGCLog.Log("[maoyu] 战术增益是否在被使用" , InTacticalBuffIsUsingMap[InData.Key] , self)
    --if InTacticalBuffIsUsingMap[InData.Key] and InTacticalBuffIsUsingMap[self.TeamID] then  -- 检查战术增益是否在被使用
    if InTacticalBuffIsUsingMap[InData.Key] then  -- 检查战术增益是否在被使用
        return true -- 返回战术增益在被使用
    end
    return false -- 返回战术增益没在被使用
end

--添加特殊怪物
function BPPlayerController_ProtectAthena:SpawnSpecialMonster(InKey)
    ugcprint("BPPlayerController_ProtectAthenaSpawnSpecialMonster")
    local GameState = UGCGameSystem.GetGameState()
    if UE.IsValid(GameState) then
        Action_GameFight:AddSpecialMoster(self.PlayerState.TeamID,InKey)
    end
end



-- 战术技能:生成导弹
function BPPlayerController_ProtectAthena:SpawnProjectileSequenceActor(InPlayerState,InData)

    UGCLog.Log("[maoyu] 战术技能")
    
    -- 加载目标类
    local tTeamID = self.PlayerState.TeamID
    local GameState = GameplayStatics.GetGameState(self)
    local SequenceActorclass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalSkillProjectile/TuYang_ProjectileSequence.TuYang_ProjectileSequence_C'))
    local WarningActorclass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalSkillProjectile/TuYang_ProjectWarning.TuYang_ProjectWarning_C'))
    local ProjActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalSkillProjectile/TuYang_TacticalSkillProjectile.TuYang_TacticalSkillProjectile_C'))
    local ProjActorArr = GameplayStatics.GetAllActorsOfClass(self, ProjActorClass, {})

    -- 定义一个通用的函数来生成SequenceActor
    local function SpawnSequenceActor(ProjActor)
        local controller = ProjActor:GetController()
        local MyBlack = controller:GetBlackBoardComponent()
        local Target = MyBlack:GetValueAsObject("Target")
        --UGCLog.Log("[maoyu] MyBlackTaget is nil" , Target ,"tTeamID = " ,tTeamID)

        -- 如果黑板里Target为nil，才能生成SequenceActor并发射导弹
        if not Target then

            if (ProjActor.Tags[1] == "1" and tTeamID == 1) or (ProjActor.Tags[1] == "2" and tTeamID == 2) then
                -- ugcprint("[maoyu] Spawning SequenceActor for ProjActor with tag: = " .. ProjActor.Tags[1].." and TeamID = " .. tTeamID)
                
                -- 生成SequenceActor
                UGCGameSystem.SpawnActor(
                    self,
                    SequenceActorclass,
                    ProjActor:K2_GetActorLocation(),
                    --ProjActor:K2_GetActorRotation(),
                    ProjActor:GetActorScale3D(),
                    nil
                )

                -- 设置目标
                local NewTarget = GameState:FindAnotherTeamPlayer(tTeamID)
                MyBlack:SetValueAsObject("Target", NewTarget)
                GameState.TacticalSkillProjectileTarget = NewTarget
                --UGCLog.Log("[maoyu] MyBlackTaget is " , NewTarget )

                UGCLog.Log("[maoyu] 生成导弹")
                -- 修正属性访问方式

            

                --if UE.IsValid(ProjActor.BlockVolume) then
                    -- UGCLog.Log("[maoyu] BlockVolume is valid")
                    -- local BlockVolume = ProjActor.BlockVolume
                    -- BlockVolume:SetActorHiddenInGame(true)
                    -- local Loc = BlockVolume:K2_GetActorLocation()
                    -- UGCLog.LogVector("BlockVolume Location",Loc)
                    -- Loc.Z = -1264
                    -- BlockVolume:K2_SetActorLocation(Loc,false,nil,true)
                    -- BlockVolume.BrushComponent:K2_SetMobility(EComponentMobility.Movable)
                    -- --Static
                    -- BlockVolume.BrushComponent.bUpdateOverlapEventsWhenMove = true

                    -- BlockVolume.BrushComponent:K2_SetWorldLocationAndRotation(Loc,{Roll = 0, Pitch = 0, Yaw = 0},false,nil,true)

                    -- GameplayStatics.UpdateComponentToWorld(BlockVolume.BrushComponent)

                    -- UGCLog.LogVector("BlockVolume Location",BlockVolume:K2_GetActorLocation())
                --else
                    UGCLog.Log("[maoyu 警告] BlockVolume 属性不存在或对象无效")
                --end
                

                -- if ProjActor.BlockingVloume and ProjActor.BlockingVloume:IsValid() then
                --     local BlockVolumeObj = ProjActor.BlockingVloume:Get()
                --     if UE.IsValid(BlockVolumeObj) then
                --         local Loc = BlockVolumeObj:K2_GetActorLocation()
                --         Loc.Z = -1264
                --         BlockVolumeObj:K2_SetActorLocation(Loc)
                --     end
                -- else
                --     UGCLog.Log("[警告] BlockVolume 属性不存在或对象无效")
                -- end

                --生成导弹预警提示
                if NewTarget then
                    UGCGameSystem.SpawnActor(
                        self,
                        WarningActorclass,
                        NewTarget:K2_GetActorLocation(),
                        {Roll = 0, Pitch = 0, Yaw = 0},
                        nil
                    )
                end

                -- 设置定时器清除目标
                Timer.InsertTimer(3, function()
                    MyBlack:SetValueAsObject("Target", nil)
                    GameState.TacticalSkillProjectileTarget = nil
                    UGCLog.Log("[maoyu] Timer cleared target")
                end, false)
            end
        else  
            -- 如果黑板里Target不为nil，说明导弹已经发射过了正在cd
            -- 播放正在cdUI
            -- UnrealNetwork.CallUnrealRPC(self, self, "ClientRPC_SecceedOrFailBuy", (InPlayerState.Gold >= InData.Cost)) 类似
        end
    end

    -- 遍历所有ProjActorArr并根据条件生成Actor
    for _, ProjActor in ipairs(ProjActorArr) do
        if ProjActor then
        ugcprint("maoyu ProjActor.tags = " .. ProjActor.Tags[1])
        SpawnSequenceActor(ProjActor)
        end
    end
end
-- 战术技能:偷枪！！！
function BPPlayerController_ProtectAthena:StealTheGun()
    UGCLog.Log("[LJH] 偷枪！！！")
    local GameState = UGCGameSystem.GetGameState()
    local tTeamID = self.PlayerState.TeamID
    local tPlayerList = GameState:GetAllTheSurvivingPlayersOfTheOtherTeam(tTeamID)
    local tRandom = math.random(1,#tPlayerList)
    local tGun = UGCWeaponManagerSystem.GetCurrentWeapon(tPlayerList[tRandom])
    local tInstenceID = tGun:GetInstanceIDint64()
    local tItemID = tGun:GetItemDefineID().TypeSpecificID
    UGCBackPackSystem.DropItemByInstanceID(tPlayerList[tRandom], tInstenceID , 1,true) -- 删除物品 TypeSpecificID
    local tKey = WeaponConfig:GetWeaponItems(WeaponConfig.ItemKey.WeaponItemID,tItemID).Key
    UGCLog.Log("[LJH] 偷枪成功，偷到的武器ID = " , tItemID,tKey)
    self:ServerRPC_GiveItem(tKey)
end

-- 战术增益:场地生成可乘载武器
function BPPlayerController_ProtectAthena:SpawnVehicleWeapon(InProductData)

    UGCLog.Log("[maoyu] SpawnVehicleWeapon called")

    local GameState = GameplayStatics.GetGameState(self)

    -- 加载目标类
    local tTeamID = self.PlayerState.TeamID
    local KobeSequenceActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalBuffs/TuYang_TacticalBuffsKobe.TuYang_TacticalBuffsKobe_C'))
    local VehicleActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalBuffs/TuYang_TacticalBuffsVehicle.TuYang_TacticalBuffsVehicle_C'))

    local WeaponActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalBuffs/TuYang_TacticalBuffsM2.TuYang_TacticalBuffsM2_C'))


    -- 检查类是否加载成功
    if not KobeSequenceActorClass or not VehicleActorClass then
        UGCLog.Log("[maoyu Error] Failed to load actor classes.")
        return
    end

    -- 获取所有车辆 Actor
    local VehicleActors = GameplayStatics.GetAllActorsOfClass(self, VehicleActorClass, {})
    if #VehicleActors == 0 then
        UGCLog.Log("[maoyu Warning] No VehicleActors found.")
        return
    end

    -- 定义生成车辆和提示的函数
    local function SpawnKobeActors(InActor)

        -- 检查生成的 Actor 是否有效
        if UE.IsValid(InActor) then

            -- 检查队伍 ID 和Vehicle.Tag[3]是否匹配
            if (InActor.Tags[3] == "1" and tTeamID == 1) or (InActor.Tags[3] == "2" and tTeamID == 2) then
                --UGCLog.Log("[maoyu] Spawning KobeActor for InActor with tag: = " , InActor.Tags[3], " and TeamID = " , tTeamID)

                --生成KobeSequenceActor播放直升机动画
                local Rotation = (tTeamID == 1) and {Roll = 0, Pitch = 0, Yaw = 0} or {Roll = 0, Pitch = 0, Yaw = -180}
                local KobeActor = UGCGameSystem.SpawnActor(self, KobeSequenceActorClass, InActor:K2_GetActorLocation(), Rotation, nil)

                if not UE.IsValid(KobeActor) then
                    UGCLog.Log("[maoyu Error] Failed to spawn KobeActor.")
                    return
                end

                local tacticalBuffMap = tTeamID == 1 and GameState.Team1TacticalBuffIsUsingMap or GameState.Team2TacticalBuffIsUsingMap
                tacticalBuffMap[InProductData.Key] = true -- 设置战术增益正在使用
                --UGCLog.Log("[maoyu] 战术增益在被使用", tacticalBuffMap[InProductData.Key])

                -- 设置定时器，延迟 2.5 秒后生成 VehicleActor
                Timer.InsertTimer(2.5, function()
                    if UE.IsValid(InActor) then
                        InActor:SetEnableVehicleEnter(true)
                        InActor:SetActorHiddenInGame(false)
                        UGCLog.Log("[maoyu] VehicleActor is now visible.")
                        local WeaponActor =  UGCVehicleSystem.GetVehicleWeapon(InActor,1,1)
                        local VehicleActor = InActor
                        self.GetWeaponBulletTimer = Timer.InsertTimer(0.5, function()
                            if UE.IsValid(WeaponActor) then
                                UGCLog.Log("[maoyu] WeaponActor = " , WeaponActor,"WeaponActor.CurBulletNumInClip = " , WeaponActor.CurBulletNumInClip)
                                if WeaponActor.CurBulletNumInClip <= 0 then
                                    self:ExitVehicleWeapon(VehicleActor,WeaponActor,InProductData,tacticalBuffMap)
                                end
                            end
                        end, true)
                    else
                        UGCLog.Log("[maoyu Warning] InActor is no longer valid.")
                    end
                end, false)
            end
        else
            UGCLog.Log("[maoyu Error] InActor is not valid.")
        end
    end

    -- 遍历所有ProjActorArr并根据条件生成Actor
    --local VehicleActor = nil
    for _, VehicleActor in ipairs(VehicleActors) do
        if UE.IsValid(VehicleActor) then
            SpawnKobeActors(VehicleActor)
        else
            UGCLog.Log("[maoyu Warning] Skipping invalid VehicleActor.")
        end
    end
end

--战术增益车载武器没子弹强行使玩家退出
function BPPlayerController_ProtectAthena:ExitVehicleWeapon(InVehicle,InWeapon,InData,InMap)

    -- 移除检查武器子弹的定时器
    if self.GetWeaponBulletTimer then
        Timer.RemoveTimer(self.GetWeaponBulletTimer)
    end

    -- 检查输入参数有效性
    if UE.IsValid(InVehicle) and UE.IsValid(InWeapon)then
        -- 强制乘客离开当前所在载具
        local PlayerPawn = UGCVehicleSystem.GetOccupierBySeatIndex(InVehicle, 1)
        local GameState = UGCGameSystem.GetGameState()
        if PlayerPawn then
            UGCVehicleSystem.ExitVehicle(PlayerPawn)
            UGCLog.Log("[maoyu] Player exited vehicle.")
        else
            UGCLog.Log("[maoyu Warning] PlayerPawn is not valid.")
        end
        -- 隐藏载具,禁止玩家进入载具并重置武器子弹数量
        local PlayerState = self.PlayerState
        InVehicle:SetActorHiddenInGame(true)
        InVehicle:SetEnableVehicleEnter(false)
        InWeapon:LocalSetBulletNumInClip(GameState.VehicleWeaponBulletNum)
        InMap[InData.Key] = false -- 设置战术增益未使用
        --UGCLog.Log("[maoyu] 战术增益没在被使用" , InMap[InData.Key])
        UGCLog.Log("[maoyu] VehicleActor 武装载具隐藏")
    end
end

--全图播报相关
    -- 1 升级成功全图播报
    -- 2 召唤怪物成功全图播报
    -- 3 传送全图播报
    -- 4 技能理财达人全图播报
BPPlayerController_ProtectAthena.TeamAnnoucerUIPath = 
{
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_UpGrade_Hint1.TuYang_UpGrade_Hint1_C'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_Somon_Hint1.TuYang_Somon_Hint1_C'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_PlayerTeleportAnnoucer.TuYang_PlayerTeleportAnnoucer_C'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_UpGrade_Hint1.TuYang_UpGrade_Hint1_C')
}
BPPlayerController_ProtectAthena.TeamAnnouncerUIList = {}
BPPlayerController_ProtectAthena.TeamAnnoucerID = 0
function BPPlayerController_ProtectAthena:ClientRPC_PlayTeamAnnouncerUI(InUIID,InTeamID)
    UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_PlayTeamAnnouncerUI",InUIID,InTeamID)
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_PlayTeamAnnouncerUI",InUIID,InTeamID)
    else
        
        local TeamAnnouncerPath = nil
        local TeamAnnouncerClass = nil
        if InUIID <= #self.TeamAnnoucerUIPath then
            TeamAnnouncerPath = self.TeamAnnoucerUIPath[InUIID]
        else
            UGCLog.Log("ClientRPC_PlayTeamAnnouncerUI InUIID Error",InUIID,#self.TeamAnnoucerUIPath)
        end        
        if TeamAnnouncerPath ~= nil then
            UGCLog.Log("ClientRPC_PlayTeamAnnouncerUI FString == nil  Error")
        end
        local TeamAnnouncerClass = UE.LoadClass(TeamAnnouncerPath)

        if self.TeamAnnouncerUI ~= nil then
            self.TeamAnnouncerUI:RemoveFromViewport()
            self.TeamAnnouncerUI = nil
        end
        if UE.IsValid(TeamAnnouncerClass) then
            self.TeamAnnouncerUI = UserWidget.NewWidgetObjectBP(self,TeamAnnouncerClass)
        else
            UGCLog.Log("ClientRPC_PlayTeamAnnouncerUI TeamAnnouncerClass Error",InUIID,InTeamID)
        end
        
        if UE.IsValid(self.TeamAnnouncerUI) then
            self.TeamAnnouncerUI:AddToViewport(10099)
            self.TeamAnnouncerUI:SetUpLevelTeamUI(InTeamID)
            UGCLog.Log("Add TeamAnnouncerUI!!")
        end
    end
    
end
function BPPlayerController_ProtectAthena:AddEndCountDownUI()
    UGCLog.Log("BPPlayerController_ProtectAthenaAddEndCountDownUI")
    local Playerstate = self.PlayerState
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"AddEndCountDownUI")
        --Playerstate.bIsStartCountdown = true
    else
        self:RemoveEndCountUI()
        local EndCountDownPath =UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BP_Widget_EndCountDown_TuYang.BP_Widget_EndCountDown_TuYang_C')
        local EndCountDownClass = UE.LoadClass(EndCountDownPath)
        if self.EndCountDownUI == nil then
            self.EndCountDownUI = UserWidget.NewWidgetObjectBP(self,EndCountDownClass)
        end
        if UE.IsValid(self.EndCountDownUI) then
            self.EndCountDownUI:AddToViewport(10099)
            UGCLog.Log("Add  self.EndCountDownUI!!")
        end
    end
    
end
function BPPlayerController_ProtectAthena:RemoveEndCountUI()
    local Playerstate = self.PlayerState
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"RemoveEndCountUI")
        --Playerstate.bIsStartCountdown = false
    else
        if  self.EndCountDownUI ~= nil then
            ugcprint("RemoveEndCountDownUI")
            self.EndCountDownUI:RemoveFromViewport()
        end
    end
end


-- 播放阶段变化
local bIsPlayTaskStageTwoSound = true
local bIsPlayTaskStageThreeSound = true
function  BPPlayerController_ProtectAthena:PlayTaskStage(InTeamID,IniTaskStage)
    ugcprint("BPPlayerController_ProtectAthenaPlayTaskStage")
    if self.TeamID ~= InTeamID then
        return
    end
    if IniTaskStage == 1 then
        bIsPlayTaskStageTwoSound = true
        bIsPlayTaskStageThreeSound = true
    elseif IniTaskStage == 2 then
       
        if bIsPlayTaskStageTwoSound then
            self:ClientRPC_PlaySound(3)
            bIsPlayTaskStageTwoSound = false
            bIsPlayTaskStageThreeSound = true
        end
    elseif IniTaskStage == 3 then

        if bIsPlayTaskStageThreeSound then
            self:ClientRPC_PlaySound(4)
            bIsPlayTaskStageTwoSound = false
            bIsPlayTaskStageThreeSound = false
        end
    end
     --UI相关
     if UE.IsValid(TaskButton) then
        TaskButton:PlayTaskStageUI(IniTaskStage)
     end
     
end

--添加新技能，技能编辑器2.0
function BPPlayerController_ProtectAthena:AddPersistSkills(InKey)
    local PlayerState = self.PlayerState
    local SkillPath = PlayerState.PersistSkillsList[InKey]
    local SkillClass = UGCObjectUtility.LoadClass(SkillPath)
	UGCLog.Log("[maoyu] AddPersistSkills",InKey)

    -- 通用技能实例创建
    if not UE.IsValid(SkillClass) then
        UGCLog.Log("[maoyu] 技能类加载失败: " ,InKey)
        return
    end

	-- 全局变量存储技能实例对象，方便卸载技能
    self.SkillInstanceList[InKey] = UGCPersistEffectSystem.AddSkillByClass(self.Pawn, SkillClass)
    if not UE.IsValid(self.SkillInstanceList[InKey]) then
        UGCLog.Log("[maoyu] 技能实例创建失败: ",InKey)
        return
    end

    self:SkillAttributeDamageIncrease(InKey)
    -- 添加技能后立即执行对应的武器修改
    local skillData = self.PlayerState.PersistSkillDamagesList[InKey]
    if skillData and skillData.Handler then
        local handler = self[skillData.Handler]
        if handler then
            handler(self, InKey)
        end
    end

    -- 需要特殊处理的技能
    -- 定时器配置表
    local timerConfig = {
        -- 移动类技能
        -- interval:Timer间隔时间 , checkFunc:Pawn调用的函数名 , param:函数CheckMoveDistanceEnough需要的第一个形参
        ["Skill4_1"] = {interval = 0.3, checkFunc = "CheckMoveDistanceEnough", param = 650},
        ["Skill4_3"] = {interval = 0.3, checkFunc = "CheckMoveDistanceEnough", param = 1000},
        ["Skill4_4"] = {interval = 0.3, checkFunc = "CheckMoveDistanceEnough", param = 200},
        ["Skill4_7"] = {interval = 0.3, checkFunc = "CheckMoveDistanceEnough", param = 900},
        ["Skill4_9"] = {interval = 0.3, checkFunc = "CheckMoveDistanceEnough", param = 325},

        -- 站立类技能
        -- interval:Timer间隔时间 , checkFunc:Pawn调用的函数名 , needActorSpawn:是否需要生成Actor , needResetStayTime是否需要重置时间
        ["Skill5_1"] = {interval = 0.3, checkFunc = "CheckIsStayTimeEnough", needActorSpawn = true},
        ["Skill5_2"] = {interval = 0.3, checkFunc = "CheckIsStayTimeEnough", needResetStayTime = true},
        ["Skill5_3"] = {interval = 0.3, checkFunc = "CheckIsStayTimeEnough", needResetStayTime = true}, --
        ["Skill5_4"] = {interval = 0.3, checkFunc = "CheckIsStayTimeEnough", needActorSpawn = true}, -- 治愈之风技能
        ["Skill5_9"] = {interval = 0.3, checkFunc = "CheckIsStayTimeEnough", needActorSpawn = true}
    }

    -- 统一定时器处理
    local config = timerConfig[InKey]
    if config then
        -- 根据技能前缀自动分配技能类型
        if string.find(InKey, "Skill4") then
            self.Pawn.MoveSkillData[InKey].Check = true
        elseif string.find(InKey, "Skill5") then
            self.Pawn.StaySkillData[InKey].Check = true
        else
            UGCLog.Log("[maoyu Error] 未知技能类型: ", InKey)
            return
        end
        local checkParam = config.param or InKey

        --ugcprint("[maoyu] timerConfig")

        -- 初始化定时器记录表
        self.SkillTimers = self.SkillTimers or {}
        -- 移除已有定时器
        if self.SkillTimers[InKey] then
            Timer.RemoveTimer(self.SkillTimers[InKey])
        end

        -- 创建独立定时器实例并记录
        self.SkillTimers[InKey] = Timer.InsertTimer(config.interval, function()
            if UE.IsValid(self.Pawn) and self.Pawn[config.checkFunc](self.Pawn, checkParam, InKey) then
                --ugcprint("[maoyu] Skill能用")
                self.SkillInstanceList[InKey]:EnableSkill()
                -- 特殊技能判断
                if InKey == "Skill4_3" then
                    -- 暂停移动检测
                    self.Pawn.MoveSkillData[InKey].Check = false
                    -- 1.5秒后恢复检测
                    Timer.InsertTimer(1.5, function()
                        if UE.IsValid(self.Pawn) then
                            self.Pawn.MoveSkillData[InKey].Check = true
                            self.Pawn.MoveSkillData[InKey].Distance = 0  -- 重置移动距离
                        end
                    end, false)
                end
                -- 仅特定技能需要生成Actor
                if config.needActorSpawn then
                    self.Pawn:OnSkillActorSpawned(InKey)
                end
                -- 仅需要重置时间的技能处理
                if config.needResetStayTime then
                    self.Pawn.StaySkillData[InKey].StayStartTime = -1
                end
            else
                --ugcprint("[maoyu] Skill还不能用")
                self.SkillInstanceList[InKey]:DisableSkill()
            end
        end, true)
    end
end

--添加新技能buff，技能编辑器2.0
function BPPlayerController_ProtectAthena:AddBuffSkills(InBuffClass)
    local BuffTarget = self:GetPlayerCharacterSafety()
    UGCPersistEffectSystem.AddBuffByClass(BuffTarget, InBuffClass)
end

--新技能属性增伤
function BPPlayerController_ProtectAthena:SkillAttributeDamageIncrease(InKey)
    local PlayerState = self.PlayerState

    -- 后缀7过滤逻辑
    local _, suffix7 = string.match(InKey, "Skill(%d+)_(%d+)")
    if suffix7 == "7" then
        UGCLog.Log("[maoyu] 跳过后缀7技能处理:", InKey)
        return
    end

    -- 解析技能前缀和后缀（如Skill3_4中的"3"和"4"）
    local prefix, suffix = string.match(InKey, "Skill(%d+)_(%d+)")
    if not (prefix and suffix) then return end

    -- 初始化伤害来源追踪表（存储格式：PersistSkillDamageSources[目标技能] = {来源前缀列表}）
    PlayerState.PersistSkillDamageSources = PlayerState.PersistSkillDamageSources or {}
    
    -- 获取当前技能的伤害倍率
    local currentMultiplier = self.CopyPersistSkillDamagesList[InKey].DamageMultiplier
    --UGCLog.Log("[maoyu] SkillAttributeDamageIncrease currentMultiplier = ",currentMultiplier)

    -- 获取当前技能配置
    local currentData = PlayerState.PersistSkillDamagesList[InKey]
    if not currentData then return end
    local currentMultiplier = currentData.DamageMultiplier

        -- 通用处理函数
    local function processSkill(targetPrefix, targetSuffix)
        local targetKey = string.format("Skill%d_%s", targetPrefix, targetSuffix)
        if targetKey == InKey then return end
        
        local targetData = PlayerState.PersistSkillDamagesList[targetKey]
        if not targetData then return end

        local sources = PlayerState.PersistSkillDamageSources[targetKey] or {}
        if not self:ContainsPrefix(sources, prefix) and #sources <= 5 then
            table.insert(sources, prefix)
            if not InKey == "Skill2_8" then
                PlayerState.PersistSkillDamageSources[targetKey] = sources
                targetData.DamageMultiplier = targetData.DamageMultiplier + currentMultiplier
                -- 特殊处理：Skill2_8
                if targetPrefix == 2 or targetPrefix == 4 then
                    PlayerState.PersistSkillDamagesList["Skill2_8"].DamageMultiplier = PlayerState.PersistSkillDamagesList["Skill2_8"].DamageMultiplier + currentMultiplier
                end
            end
        end
    end

    -- 处理同后缀技能
    for x = 1,5 do
        processSkill(x, suffix)
    end

    -- 特殊处理Skill2_8
    if InKey == "Skill2_8" then
        -- 使用表驱动方式处理需要影响的技能类型
        local affectedSkillTypes = {"2", "4"}
        for _, skillType in ipairs(affectedSkillTypes) do
            for x = 1,5 do
                processSkill(x, skillType)
            end
        end
    end
end

-- 辅助方法检查前缀是否已存在
function BPPlayerController_ProtectAthena:ContainsPrefix(t, prefix)
    for _, v in ipairs(t) do
        if v == prefix then
            return true
        end
    end
    return false
end

--新技能属性增伤(火电)
function BPPlayerController_ProtectAthena:LightFireDamageIncrease()
    local PlayerState = self.PlayerState
    local increments = 1.35

    -- 处理所有X_2系列技能 (Skill1_2到Skill5_2)
    for x=1,5 do
        local skillKey = string.format("Skill%d_2", x)
        if PlayerState.PersistSkillDamagesList[skillKey] then
            PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier = 
                PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier + increments
        end
    end

    -- 处理所有X_3系列技能 (Skill1_3到Skill5_3)
    for x=1,5 do
        local skillKey = string.format("Skill%d_3", x)
        if PlayerState.PersistSkillDamagesList[skillKey] then
            PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier = 
                PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier + increments
        end
    end
end

--新技能属性增伤(电)
function BPPlayerController_ProtectAthena:LightDamageIncrease()
    local PlayerState = self.PlayerState
    local increments = 1.0

    -- 处理所有X_3系列技能 (Skill1_3到Skill5_3)
    for x=1,5 do
        local skillKey = string.format("Skill%d_3", x)
        if PlayerState.PersistSkillDamagesList[skillKey] then
            PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier = 
                PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier + increments
        end
    end
end

--新技能属性增效(风)
function BPPlayerController_ProtectAthena:WindAllIncrease()
    local PlayerState = self.PlayerState
    local increments = 1.0

    -- 处理所有X_4系列技能 (Skill1_4到Skill5_4)
    for x=1,5 do
        local skillKey = string.format("Skill%d_4", x)
        if PlayerState.PersistSkillDamagesList[skillKey] then
            PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier = 
                PlayerState.PersistSkillDamagesList[skillKey].DamageMultiplier + increments
        end
    end
end

-- 新技能单发增伤
function BPPlayerController_ProtectAthena:SingleDamageIncrease(InIncrements)
    ugcprint("[maoyu]SingleDamageIncrease")
    -- 所有技能增伤
    local PlayerState = self.PlayerState
    for skillKey, damageData in pairs(PlayerState.PersistSkillDamagesList) do
        damageData.DamageMultiplier = damageData.DamageMultiplier + InIncrements
    end
end


-- 新技能单发增伤复原
function BPPlayerController_ProtectAthena:RestoreOriginalDamage(InIncrements)
    local PlayerState = self.PlayerState
    for skillKey, damageData in pairs(PlayerState.PersistSkillDamagesList) do
        damageData.DamageMultiplier = damageData.DamageMultiplier - InIncrements
    end
end

-- 新技能一路发财(已弃用)
function BPPlayerController_ProtectAthena:MoveDropRedPacket()
    --self:ServerRPC_AddGoldNumber(500)
end

-- 新技能理财达人
function BPPlayerController_ProtectAthena:AddMoneyInterval()
    Timer.InsertTimer(60, function()
        local PlayerState = self.PlayerState
        local addGold = PlayerState.Gold * 0.3
        self:ServerRPC_AddGoldNumber(addGold)
        local AllController = UGCGameSystem.GetAllPlayerController()
        for _,Controller in pairs(AllController) do
            Controller:ClientRPC_PlayTeamAnnouncerUI(4,self.TeamID)
        end
    end,true)
end

-- 新技能复原已修改武器的属性
function BPPlayerController_ProtectAthena:RestoreModifiedWeapon(InWeapon)
    local instanceID = InWeapon:GetInstanceIDint64()

    -- 通用恢复函数
    local function RestoreWeaponAttribute(modifiedTable, restoreFunc)
        if modifiedTable then
            -- 遍历所有复合键
            for compositeKey, data in pairs(modifiedTable) do
                -- 检查是否为当前武器实例的修改记录
                if string.find(compositeKey, "^"..tostring(instanceID).."_") then
                    restoreFunc(InWeapon, data.original)
                    modifiedTable[compositeKey] = nil
                end
            end
        end
    end

    -- 复原弹夹容量
    RestoreWeaponAttribute(self.ModifiedClipWeapons, UGCGunSystem.SetMaxBulletNumInOneClip)
    
    -- 复原换弹时间
    RestoreWeaponAttribute(self.ModifiedReloadWeapons, UGCGunSystem.SetTacticalReloadTime)
    
    -- 复原射速
    RestoreWeaponAttribute(self.ModifiedShootWeapons, UGCGunSystem.SetShootIntervalTime)

    -- 复原射速
    RestoreWeaponAttribute(self.ModifiedDamageWeapons, UGCGunSystem.SetBulletBaseDamage)

end

-- 新技能增加弹夹容量技能
function BPPlayerController_ProtectAthena:IncBulletNumInOneClip(InKey)
    -- 已修改武器弹夹记录表
    self.ModifiedClipWeapons = self.ModifiedClipWeapons or {}

    local playstate = self.PlayerState
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self.Pawn)
    local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')

    if not playstate or not weapon then
        UGCLog.Log("[maoyu] IncBulletNumInOneClip playstate or weapon nil")
        return
    end

    local tItemID = weapon:GetItemDefineID().TypeSpecificID
    local tData = UGCGameSystem.GetTableDataByRowName(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/TuYang_WeaponConfig.TuYang_WeaponConfig'),tItemID)
    local tNum = 0
    if tData then
        tNum = tData.MaxBulletNumInOneClip
    end

    if UE.IsA(weapon, weaponClass) then
        local instanceID = weapon:GetInstanceIDint64()
        -- 生成复合键记录修改状态
        local compositeKey = instanceID.."_"..InKey

        -- 首次修改时记录原始值
        if not self.ModifiedClipWeapons[compositeKey] then
            self.ModifiedClipWeapons[compositeKey] = {
                original = tNum,
                modified = false
            }
        end

        
        -- 通过武器实例ID检查是否已修改过
        ugcprint("[maoyu] IncBulletNumInOneClip InstanceID")
        if not self.ModifiedClipWeapons[compositeKey].modified then
            local weaponClipNum = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
            --UGCGunSystem.SetMaxBulletNumInOneClip(weapon, weaponClipNum * 1.2)
            if InKey == "Skill1_3" then
                weaponClipNum = weaponClipNum + math.ceil(tNum * playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)
            else
                weaponClipNum = weaponClipNum + playstate.PersistSkillDamagesList[InKey].WeaponArrtibute
            end
            -- ugcprint("[maoyu] IncBulletNumInOneClip"..weaponClipNum)
            UGCGunSystem.SetMaxBulletNumInOneClip(weapon, weaponClipNum)
            local curWeaponClipNum = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
            weapon.CurMaxBulletNumInOneClip = curWeaponClipNum
            weapon.CurBulletNumInClip = curWeaponClipNum
            -- weapon:RefreshtMaxBulletNumInOneClipOnServer(false)
            weapon:SetCurrentBulletNumInClipOnServerNew(curWeaponClipNum,true)
            weapon:SetCurrentBulletNumInClipOnClient(curWeaponClipNum)

            weapon:RPC_Client_SetBulletNumInClip(curWeaponClipNum)
            -- weapon.CurBulletNumInClipOnSimulatedClients = curWeaponClipNum
            --ugcprint("[maoyu] IncBulletNumInOneClip" ..weapon.CurBulletNumInClip)
            --记录已修改的武器实例
            self.ModifiedClipWeapons[compositeKey].modified = true
        end
    end

    -- local weaponClipNum = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
    -- UGCGunSystem.SetMaxBulletNumInOneClip(weapon, weaponClipNum*1.2)
    -- weapon.CurBulletNumInClip = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
end

-- 新技能减少换弹时间技能
function BPPlayerController_ProtectAthena:QuickReloadTime(InKey)
    -- 已修改武器换弹记录表
    self.ModifiedReloadWeapons = self.ModifiedReloadWeapons or {}

    local playstate = self.PlayerState

    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self.Pawn)
    local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')

    if not playstate or not weapon then
        UGCLog.Log("[maoyu] QuickReloadTime playstate or weapon nil")
        return
    end

    if UE.IsA(weapon, weaponClass) then 
        local instanceID = weapon:GetInstanceIDint64()

        -- 生成复合键记录修改状态
        local compositeKey = instanceID.."_"..InKey
        
        -- 首次修改时记录原始值
        if not self.ModifiedReloadWeapons[compositeKey] then
            self.ModifiedReloadWeapons[compositeKey] = {
                original = UGCGunSystem.GetTacticalReloadTime(weapon),
                modified = false
            }
        end

        -- 通过武器实例ID检查是否已修改过
        ugcprint("[maoyu] QuickReloadTime InstanceID")
        if not self.ModifiedReloadWeapons[compositeKey].modified then
            local weaponReloadTime = UGCGunSystem.GetTacticalReloadTime(weapon)
            UGCGunSystem.SetTacticalReloadTime(weapon, weaponReloadTime -  (self.ModifiedReloadWeapons[compositeKey].original * playstate.PersistSkillDamagesList[InKey].WeaponArrtibute))
            -- ugcprint("[maoyu] QuickReloadTime" ..weapon:GetTacticalReloadTime(weapon))
            -- 记录已修改的武器实例
            self.ModifiedReloadWeapons[compositeKey].modified = true
        end
    end
end

-- 新技能加快射速
function BPPlayerController_ProtectAthena:IncShootIntervalTime(InKey)
    -- 已修改武器射击间隔记录表
    self.ModifiedShootWeapons = self.ModifiedShootWeapons or {}

    local playstate = self.PlayerState
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self.Pawn)
    local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')

    if not playstate or not weapon then
        UGCLog.Log("[maoyu] IncShootIntervalTime playstate or weapon nil")
        return
    end

    local tItemID = weapon:GetItemDefineID().TypeSpecificID
    local tData = UGCGameSystem.GetTableDataByRowName(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/TuYang_WeaponConfig.TuYang_WeaponConfig'),tItemID)
    local tTime = 0
    if tData then
        tTime = tData.ShootIntervalTime
    end

    

    if UE.IsA(weapon, weaponClass) then 
        local instanceID = weapon:GetInstanceIDint64()

        -- 生成复合键记录修改状态
        local compositeKey = instanceID.."_"..InKey
        
        -- 首次修改时记录原始值
        if not self.ModifiedShootWeapons[compositeKey] then
            self.ModifiedShootWeapons[compositeKey] = {
                original = tTime,
                modified = false
            }
        end

        -- 通过武器实例ID检查是否已修改过
        ugcprint("[maoyu] IncShootIntervalTime InstanceID")
        if not self.ModifiedShootWeapons[compositeKey].modified then
            local weaponShootIntervalTime = UGCGunSystem.GetShootIntervalTime(weapon)

            UGCGunSystem.SetShootIntervalTime(weapon, weaponShootIntervalTime - tTime * playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)
            --ugcprint("[maoyu] IncShootIntervalTime" ..weapon:GetShootIntervalTime(weapon))
            -- 记录已修改的武器实例
            self.ModifiedShootWeapons[compositeKey].modified = true
        end
    end
end

-- 新技能增加武器伤害
function BPPlayerController_ProtectAthena:IncWeaponBulletDamage(InKey)
    -- 已修改武器射击间隔记录表
    self.ModifiedDamageWeapons = self.ModifiedDamageWeapons or {}

    local playstate = self.PlayerState
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self.Pawn)
    local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')

    if not playstate or not weapon then
        UGCLog.Log("[maoyu] IncWeaponBulletDamage playstate or weapon nil")
        return
    end

    local tItemID = weapon:GetItemDefineID().TypeSpecificID
    local tData = UGCGameSystem.GetTableDataByRowName(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/TuYang_WeaponConfig.TuYang_WeaponConfig'),tItemID)
    local tDam = 0
    if tData then
        tDam = tData.BulletBaseDamage
    end


    if UE.IsA(weapon, weaponClass) then 
        local instanceID = weapon:GetInstanceIDint64()

        -- 生成复合键记录修改状态
        local compositeKey = instanceID.."_"..InKey
        
        -- 首次修改时记录原始值
        if not self.ModifiedDamageWeapons[compositeKey] then
            self.ModifiedDamageWeapons[compositeKey] = {
                original = tDam,
                modified = false
            }
        end

        -- 通过武器实例ID检查是否已修改过
        ugcprint("[maoyu] IncWeaponBulletDamage InstanceID")
        if not self.ModifiedDamageWeapons[compositeKey].modified then
            local weaponBaseDamage = UGCGunSystem.GetBulletBaseDamage(weapon)

            UGCGunSystem.SetBulletBaseDamage(weapon, weaponBaseDamage + (tDam * playstate.PersistSkillDamagesList[InKey].WeaponArrtibute))
            --ugcprint("[maoyu] IncShootIntervalTime" ..weapon:GetShootIntervalTime(weapon))

            -- 记录已修改的武器实例
            self.ModifiedDamageWeapons[compositeKey].modified = true
        end
    end
end

-- 新技能改变玩家移速
function BPPlayerController_ProtectAthena:SkillChangePlayerSpeed(InKey)
    UGCLog.Log("[maoyu] SkillChangePlayerSpeed")
    local playstate = self.PlayerState
    local playerpawn = self:GetPlayerCharacterSafety()

    if not playstate or not playerpawn  then
        UGCLog.Log("[maoyu] SkillChangePlayerSpeed nil")
        return
    end

    local OrigSpeedScale = UGCPawnAttrSystem.GetSpeedScale(playerpawn)
    UGCPawnAttrSystem.SetSpeedScale(playerpawn, OrigSpeedScale + playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)

    -- 每种速度都需要修改才能生效
    -- local walkOrigSpeedScale = UGCPawnAttrSystem.GetWalkSpeedScale(playerpawn)
    -- UGCPawnAttrSystem.SetWalkSpeedScale(playerpawn, walkOrigSpeedScale + playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)

    -- local sprintOrigSpeedScale = UGCPawnAttrSystem.GetSprintSpeedScale(playerpawn)
    -- UGCPawnAttrSystem.SetSprintSpeedScale(playerpawn, sprintOrigSpeedScale + playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)

    -- local crouchOrigSpeedScale = UGCPawnAttrSystem.GetCrouchSpeedScale(playerpawn)
    -- UGCPawnAttrSystem.SetCrouchSpeedScale(playerpawn, crouchOrigSpeedScale + playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)

    -- local proneOrigSpeedScale = UGCPawnAttrSystem.GetProneSpeedScale(playerpawn)
    -- UGCPawnAttrSystem.SetProneSpeedScale(playerpawn, proneOrigSpeedScale + playstate.PersistSkillDamagesList[InKey].WeaponArrtibute)

    --UGCLog.Log("[maoyu] SkillChangePlayerSpeed",UGCPawnAttrSystem.GetSpeedScale(playerpawn))
end

-- 新技能改变玩家生命值
function BPPlayerController_ProtectAthena:SkillChangePlayerHealth(InKey)
    if self:HasAuthority() then
        UGCLog.Log("[maoyu] SkillChangePlayerHealth")
        local playstate = self.PlayerState
        local playerpawn = self:GetPlayerCharacterSafety()

        if not playstate or not playerpawn  then
            UGCLog.Log("[maoyu] SkillChangePlayerHealth nil")
            return
        end

        local curHealthMax = UGCPawnAttrSystem.GetHealthMax(playerpawn)
        --local curHealth = UGCPawnAttrSystem.GetHealth(playerpawn)
        UGCPawnAttrSystem.SetHealthMax(playerpawn, curHealthMax + (100.0 * playstate.PersistSkillDamagesList[InKey].WeaponArrtibute))
        --UGCPawnAttrSystem.SetHealth(playerpawn, curHealth)
    end
end

-- 新技能重武器改变玩家生命值和移速
function BPPlayerController_ProtectAthena:CheckIsHeavyWeaponSetMaxHealth()
    -- 需要只在服务器设置生命值，不然会设置两遍
    if self:HasAuthority() then
        local playstate = self.PlayerState
        local playerpawn = self:GetPlayerCharacterSafety()

        if not playstate or not playerpawn  then
            UGCLog.Log("[maoyu] CheckIsHeavyWeapon nil")
            return
        end

        local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(playerpawn)
        local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')
        --UGCLog.Log("[maoyu] CheckIsHeavyWeapon:weapon = " ,weapon)

        -- 减去生命值（每次切枪时先减）
        if playerpawn.LastHealthBonus and playerpawn.LastHealthBonus > 0 then
            --UGCLog.Log("[maoyu] CheckIsHeavyWeapon:减去生命值 = " ,self.LastHealthBonus)
            -- SetHealthMax也会修改玩家的当前生命值
            local curHealthMax = UGCPawnAttrSystem.GetHealthMax(playerpawn)
            local curHealth = UGCPawnAttrSystem.GetHealth(playerpawn)
            UGCPawnAttrSystem.SetHealthMax(playerpawn, curHealthMax - playerpawn.LastHealthBonus)
            UGCPawnAttrSystem.SetHealth(playerpawn, curHealth)

            local OrigSpeedScale = UGCPawnAttrSystem.GetSpeedScale(playerpawn)
            UGCPawnAttrSystem.SetSpeedScale(playerpawn, OrigSpeedScale + 0.25)

            --UGCLog.Log("[maoyu] CheckIsHeavyWeapon SpeedValue = ",self.SpeedValue)
        end

        if UE.IsA(weapon, weaponClass) then
            local weaponItemID = weapon:GetItemDefineID().TypeSpecificID
            --local curHealthMax = UGCPawnAttrSystem.GetHealthMax(playerpawn)
            --UGCLog.Log("[maoyu] CheckIsHeavyWeapon:检查武器是否为重武器")
            -- 检查武器是否为重武器
            -- 记录本次修改量
            local healthBonus = 0
            -- 使用表驱动方式存储武器ID与生命值加成关系
            local weaponHealthBonus = {
                [105002] = 30,
                [105001] = 55,
                [105012] = 125,
                [105010] = 215,
                [105003] = 215
            }
            
            -- 通过表查询获取加成值，默认值为0
            healthBonus = weaponHealthBonus[weaponItemID] or 0

            -- 应用新生命值并记录修改量
            if healthBonus > 0 then
                --UGCLog.Log("[maoyu] CheckIsHeavyWeapon:是重武器应用新生命值 = ",healthBonus)
                local newHealthMax = UGCPawnAttrSystem.GetHealthMax(playerpawn)
                local newHealth = UGCPawnAttrSystem.GetHealth(playerpawn)
            
                UGCPawnAttrSystem.SetHealthMax(playerpawn, newHealthMax + healthBonus)
                UGCPawnAttrSystem.SetHealth(playerpawn, newHealth)
                playerpawn.LastHealthBonus = healthBonus

                local newSpeedScale = UGCPawnAttrSystem.GetSpeedScale(playerpawn)
                UGCPawnAttrSystem.SetSpeedScale(playerpawn, newSpeedScale - 0.25)
            else
                playerpawn.LastHealthBonus = nil
            end
        else
            playerpawn.LastHealthBonus = nil
        end
    end
end


-- 新技能紧急换弹
function BPPlayerController_ProtectAthena:CheckAndRefillBullet()
    -- 初始化子弹监控标记
    self.lastBulletCount = self.lastBulletCount or 9999
    self.lastWeaponInstance = self.lastWeaponInstance or nil
    
    -- 获取当前武器
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self.Pawn)
    local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')
    
    if UE.IsA(weapon, weaponClass) then
        -- 当武器切换时重置计数
        if weapon ~= self.lastWeaponInstance then
            self.lastBulletCount = 9999
            self.lastWeaponInstance = weapon
        end
        
        -- 获取当前子弹数
        local currentBullet = weapon.CurBulletNumInClip
        local reloadTriggerBulletNum = weapon.CurMaxBulletNumInOneClip * 0.2
        
        -- 触发条件：小于最大百分之20时自动补满
        if self.lastBulletCount <= reloadTriggerBulletNum and currentBullet <= reloadTriggerBulletNum then
            self.SkillInstanceList["Skill2_6"]:EnableSkill()
        else
            self.SkillInstanceList["Skill2_6"]:DisableSkill()
        end
        
        -- 更新最后记录的子弹数
        self.lastBulletCount = currentBullet
    end
end

-- 新技能紧急换弹
function BPPlayerController_ProtectAthena:UrgencyReload()
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self.Pawn)
    local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')
    local maxBullet = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
    
    -- 服务端设置子弹
    weapon:SetCurrentBulletNumInClipOnServerNew(maxBullet, true)
    -- 客户端同步
    weapon:SetCurrentBulletNumInClipOnClient(maxBullet)
    -- RPC广播
    weapon:RPC_Client_SetBulletNumInClip(maxBullet)
    
    --UGCLog.Log("[maoyu] 子弹已补满", maxBullet)
end


-- 音频相关
BPPlayerController_ProtectAthena.BGMSoundEventID = 0
BPPlayerController_ProtectAthena.BGMDoOnce = true
function BPPlayerController_ProtectAthena:ClientRPC_PlaySound(InID)
    --UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_PlaySound",InID)
    local PlayerState = self.PlayerState
    if PlayerState == nil then
        UGCLog.Log("[LJH] Error ClientRPC_PlaySound PlayerState == nil")
        return
    end
    local tData = self.PlayerState.SoundList[InID]
    local tSound = UE.LoadObject(tData.Path)
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_PlaySound",InID)
    else
        --是否为BGM  是的话则关闭之前的BGM 
        UGCLog.Log("BPPlayerController_ProtectAthenaPlaySound",tData,PlayerState:GetAkEvent(),PlayerState.BGMID,InID)
        if tData.bIsBGM then
            if PlayerState.BGMID ~= InID then
                --关闭之前BGM
                UGCSoundManagerSystem.StopSoundByID(PlayerState:GetAkEvent())
                --切换BGM
                local NewEvent = UGCSoundManagerSystem.PlaySound2D(tSound)
                PlayerState.BGMID = InID
                PlayerState:SetAkEvent(NewEvent)
            end
        else
            local NewEvent = UGCSoundManagerSystem.PlaySound2D(tSound)
        end
    end
   
end

-- 杀敌数为0时给玩家加钱
function  BPPlayerController_ProtectAthena:ZeroMonsterAddGold()
    local PlayerState = self.PlayerState
    self:ServerRPC_AddGoldNumber(PlayerState.ZeroMonsterGold)
end

-- 战斗UI添加
function BPPlayerController_ProtectAthena:AddGameFightUI()
    if TaskButton == nil then
        local TaskButtonPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/TaskUI/TaskButton.TaskButton_C')
        local TaskButtonClass = UE.LoadClass(TaskButtonPath)
        TaskButton = UserWidget.NewWidgetObjectBP(self,TaskButtonClass)
        if UE.IsValid(TaskButton) then
            TaskButton:AddToViewport(10000)
        end
    end
    
    if TaskButton ~= nil then
        UGCLog.Log("BPPlayerController_ProtectAthenaAddGameFightUI")
        TaskButton:GameFightStartUI()
    end
    local BPWidget_GameFightClass = UE.LoadClass(self:GetBPWidget_GameFightClassPath())
    if UE.IsValid(BPWidget_GameFightClass) then
        self.BPWidget_GameFight = UserWidget.NewWidgetObjectBP(self, BPWidget_GameFightClass)
        if UE.IsValid(self.BPWidget_GameFight) then
            if self.BPWidget_GameFight:AddToViewport(0) then
                return true
            end
        end
    end
end
function BPPlayerController_ProtectAthena:ClientRPC_NoMonsterAddGoldUI(InID)
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_NoMonsterAddGoldUI",InID)
    else
        if self.BPWidget_GameFight ~= nil then
            UGCLog.Log("BPPlayerController_ProtectAthenaNoMonsterAddGoldUI")
            self.BPWidget_GameFight:NoMonsterAddGold(InID)
        end
    end
   
end

function BPPlayerController_ProtectAthena:RoundInitializeData()
    UGCLog.Log("BPPlayerController_ProtectAthenaRoundInitializeData")
    local GameState = UGCGameSystem.GetGameState()
    local PlayerState = self.PlayerState
   
     --初始化
     local PlayerPawn = self:GetPlayerCharacterSafety()  -- 获取玩家角色Pawn
     local tLoc
    --  if self.TeamID == 1 then
    --      tLoc = {X=-445.798248,Y=-8498.972656,Z=480.521942}
    --  else
    --      tLoc = {X=214.174561,Y=190.747314,Z=408.499084}
    --  end
    --GameState.RoundStartTepeportActorLocation[self.TeamID].X," ",GameState.RoundStartTepeportActorLocation[self.TeamID].Y," ",GameState.RoundStartTepeportActorLocation[self.TeamID].Z
    UGCLog.Log("BPPlayerController_ProtectAthenaRoundInitializeData",type(GameState.RoundStartTepeportActorLocation[self.TeamID]))
     tLoc = GameState.RoundStartTepeportActorLocation[self.TeamID]
     local tRot = {X=0,Y=0,Z=0}
     if UE.IsValid(PlayerPawn) then
         PlayerPawn.bShouldDumpCallstackWhenMovingfast = false
         PlayerPawn:SetClientLocationOrRotation(tLoc, tRot, true, false)
         PlayerPawn.bShouldDumpCallstackWhenMovingfast = true
         
        --  --清空背包
        --  local AllItemData = UGCBackPackSystem.GetAllItemData(PlayerPawn)
        --  for i, itemData in pairs(AllItemData) do
        --     local tType = UGCItemSystem.GetItemType(itemData.ItemID)
        --     UGCLog.Log("BPPlayerController_ProtectAthenaRoundInitializeData1",itemData.InstanceID,itemData.ItemID,tType)
        --     if tType ~= 4 and tType <= 30 then
        --         UGCLog.Log("BPPlayerController_ProtectAthenaRoundInitializeData2",itemData.InstanceID,itemData.Count)
        --         UGCBackPackSystem.DropItemByInstanceID(PlayerPawn, itemData.InstanceID, itemData.Count,true) -- 删除物品 
        --     end                        
        --  end
        --  UGCBackPackSystem.AddItem(PlayerPawn, 106001, 1)  -- 为角色增加物品
         -- 回合开始回血
         local tMaxH = UGCPawnAttrSystem.GetHealthMax(PlayerPawn)
         UGCPawnAttrSystem.SetHealth(PlayerPawn,tMaxH)
         -- 回合结束给技能碎片
         PlayerState:SetReconnectDataValue("iBuffSkillElement",PlayerState:GeReconnectDataValue("iBuffSkillElement") + PlayerState.RoundEndEuffSkillElement)
     end
     self.PlayerState.iRemainingSelectionTimes_Buff = self.PlayerState.RemainingSelectionTimesMax_Buff
end


function BPPlayerController_ProtectAthena:ClientRPC_RoundCountdownStart()
    UGCLog.Log("BPPlayerController：ClientRPC_RoundCountdownStart")
    
    if self:HasAuthority() then
       
        -- 回合结束时初始化数据
        self:RoundInitializeData()
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_RoundCountdownStart")
    else
        -- 回合结束关闭所有声音
        UGCSoundManagerSystem.StopAllSound()
        -- 这俩值没同步 只需要在客户端修改即可
        self.PlayerState:SetBGMID(0) 
        self.PlayerState:SetAkEvent(0)
        if self.BPWidget_GameReady == nil then
            --self.BPWidget_RoundGameReady = UserWidget.NewWidgetObjectBP(self,BPWidget_GameReadyClass) 
            self.BPWidget_GameReady = UGCWidgetManagerSystem.AddNewUI(self:GetBPWidget_GameReadyClassPath(),true)     
        end 
        if UE.IsValid(self.BPWidget_GameReady) then
            --self.BPWidget_RoundGameReady:AddToViewport(10)
            self.BPWidget_GameReady:AddToViewport(0)
        end
        if TaskButton ~= nil then
            UGCLog.Log("BPPlayerControllerRoundCountdownStart")
            TaskButton:GameFightEndUI()
        end
      
       
    end
    --self.RoundFightStartInitialzieTimer = 
    Timer.InsertTimer(
        5, 
        function() 
           self:TimerRoundEnd()
        end, 
        false
        )
end
function BPPlayerController_ProtectAthena:TimerRoundEnd()
    
    if self:HasAuthority() then
        
    else
        --self:ChooseRoundStartBuff()
        -- 真空期结束播放BGM
        self:ClientRPC_PlaySound(1)
    end
end
-- 播放回合结束UI
function BPPlayerController_ProtectAthena:ClientRPC_PlayRoundEndUI()
    UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_PlayRoundEndUI")
    local BPWidget_RoundEndClass = UE.LoadClass(self:GetBPWidget_RoundEndClassPath())
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_PlayRoundEndUI")
    else
         -- 回合结束UI
        if self.BPWidget_RoundEnd == nil then
            self.BPWidget_RoundEnd = UserWidget.NewWidgetObjectBP(self,BPWidget_RoundEndClass)
        end
        if UE.IsValid(self.BPWidget_RoundEnd) then
            self.BPWidget_RoundEnd:AddToViewport(10099)
        end
    end
   
end
function BPPlayerController_ProtectAthena:ClientRPC_SetRoundWinTeam(InTeamID)
    local Playerstate = self.PlayerState
    if self:HasAuthority() then
        if Playerstate ~= nil then
            Playerstate.iRoundWinTeamID = InTeamID
        end
        --UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_SetRoundWinTeam",InTeamID)
    else

    end
   UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_SetRoundWinTeam",InTeamID)
end

function BPPlayerController_ProtectAthena:ClientRPC_GameRoundFightStart()
    local GameState = UGCGameSystem.GetGameState()
    if self:HasAuthority() then
        --矫正商品数量
        local Result = UGCCommoditySystem.GetAllPlayerUGCCommodityList()
        for i, tData in pairs(Result[self:GetInt64UID()]) do
            UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_GameRoundFightStart1",tData)
            self:UpDataCommodityNumber(tData.CommodityID,tData.Count)
        end
      
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_GameRoundFightStart")
    else
        self:AddGameFightUI()
        -- 回合开始UI
        if self.RoundStartUI == nil then
            local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_RoundStart.BPWidget_RoundStart_C')
            local tClass = UE.LoadClass(tPath)
            self.RoundStartUI = UserWidget.NewWidgetObjectBP(self, tClass)        
        end
        if UE.IsValid(self.RoundStartUI) then
            self.RoundStartUI:AddToViewport(10)
        end
        
        UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_GameRoundFightStart2",GameState.ReadyToFightSeconds)
        if UE.IsValid(self.BPWidget_GameReady) then
            self.BPWidget_GameReady:RemoveFromViewport()
        end
       
    end
   
end

function BPPlayerController_ProtectAthena:SetTeleportActor()
    
end
-- 传送
function BPPlayerController_ProtectAthena:ServerRPC_PlayerTeleportStart(InID)
    if self:HasAuthority() then
        local GameState = UGCGameSystem.GetGameState()
        local tLoc,tSub
        if InID == 1 then    
            tSub = 2 
        else
            tSub = 1
        end
        UGCLog.Log("ServerRPC_PlayerTeleportStart",GameState.TepeportActorList[InID]:K2_GetActorLocation().X," ",GameState.TepeportActorList[InID]:K2_GetActorLocation().Y," ",GameState.TepeportActorList[InID]:K2_GetActorLocation().Z)
        tLoc = GameState.TepeportActorList[tSub]:K2_GetActorLocation()
        local PlayerPawn = self:GetPlayerCharacterSafety()  -- 获取玩家角色Pawn
        local tRot = {X=0,Y=0,Z=0}
        local PlayerState = self.PlayerState
        local tNeedCost = PlayerState.TeleportCost * PlayerState.TeleportCostScale
        self.GoldCommodityList[3].Cost = tNeedCost
        self:ServerRPC_Buy(3,InID,tLoc,tRot)
        -- if self:CheckBuyItem(3,tNeedCost) then 
           
        --     PlayerPawn.bShouldDumpCallstackWhenMovingfast = false
        --     PlayerPawn:SetClientLocationOrRotation(tLoc, tRot, true, false)
        --     PlayerPawn.bShouldDumpCallstackWhenMovingfast = true
            
        --     -- GameState.TepeportActorList[1]:StartTeleportSecquence(self)
        --     -- GameState.TepeportActorList[2]:StartTeleportSecquence(self)
        --     GameState:UseTheTelepont(InID)
        -- end
       
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_PlayerTeleportStart",InID)
    end
end
-- 选择Buff
function BPPlayerController_ProtectAthena:ChooseRoundStartBuff()
    if self.BuffCardUI == nil then
        local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/BP_Widget_TuYangCard.BP_Widget_TuYangCard_C')
        local tClass = UE.LoadClass(tPath)
        UGCLog.Log("BPPlayerController_ProtectAthenaChooseRoundStartBuff1")
        self.BuffCardUI = UserWidget.NewWidgetObjectBP(self, tClass)
        self.GoldCommodityList[1].Widget = self.BuffCardUI
    end
    if UE.IsValid(self.BuffCardUI) then
        UGCLog.Log("BPPlayerController_ProtectAthenaChooseRoundStartBuff2")
        self.BuffCardUI:AddToViewport(10000)
    end
    
end

function BPPlayerController_ProtectAthena:ServerRPC_ClickBuffToSelect(InBuffEnum)
    UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_ClickBuffToSelect",InBuffEnum)
    if self:HasAuthority() then
        -- 选择buff次数  已废弃
        -- local PlayerState = self.PlayerState
        -- PlayerState.iRemainingSelectionTimes_Buff = PlayerState.iRemainingSelectionTimes_Buff - 1
        -- --UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_ClickBuffToSelect01",PlayerState.iRemainingSelectionTimes_Buff)
        -- if PlayerState.iRemainingSelectionTimes_Buff > 0 then
        --         self:AddPlayerBuff(InBuffEnum,true)
        -- elseif PlayerState.iRemainingSelectionTimes_Buff == 0 then
        --         self:CloseTheBuffSelectionInterface()
        --         self:AddPlayerBuff(InBuffEnum,true)
        -- else
        --         self:CloseTheBuffSelectionInterface()
        -- end

        -- 第一次选择结束 (放到这里是为了第一次选择Buff时全是绿的)
        self.PlayerState:SetIsFirstChoose(false)
        self:AddPlayerBuff(InBuffEnum,true)
        self:CloseTheBuffSelectionInterface()
        for i = #self.PlayerState.SelectableBuffsList, 1, -1 do
            if self.PlayerState.SelectableBuffsList[i] == InBuffEnum then
                --UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_ClickBuffToSelect 01",InBuffEnum)
                table.remove(self.PlayerState.SelectableBuffsList, i)
                break
            end
        end
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_ClickBuffToSelect",InBuffEnum)
    end
    --UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_ClickBuffToSelect End",self.PlayerState.SelectableBuffsList)
end

function BPPlayerController_ProtectAthena:CloseTheBuffSelectionInterface()
    UGCLog.Log("BPPlayerController_ProtectAthenaCloseTheBuffSelectionInterface")
    -- 属性同步太慢  改为RPC
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"CloseTheBuffSelectionInterface")
    else
        -- 选择Buff次数不足 关闭选择界面
        if UE.IsValid(self.BuffCardUI) then
            self.BuffCardUI:Close()
        end
    end
   
end

function BPPlayerController_ProtectAthena:AddPlayerBuff(InBuffEnum,InIsOpen)
    if self:HasAuthority() then
        if self.PlayerBuffComponent ~= nil then
            self.PlayerBuffComponent:SetPlayerBuff(InBuffEnum,InIsOpen)    
            self.PLayerState:SetReconnectDataValue("BuffSkillList",self.PlayerBuffComponent.BuffList)
        end
    end
end

function BPPlayerController_ProtectAthena:ShowBuyRefreshPointUIFirstOrder()
     --刷新点购买一级界面 Client
    
     local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_RefreshPoint.BPWidget_RefreshPoint_C')
     local tClass = UE.LoadClass(tPath)
     if self.Buy_RefreshPointUI_FirstOrder == nil then
         self.Buy_RefreshPointUI_FirstOrder = UserWidget.NewWidgetObjectBP(self , tClass)
     end
     self.Buy_RefreshPointUI_FirstOrder:AddToViewport(10099)

end
function BPPlayerController_ProtectAthena:BuyRefreshPoint(InNum)
    local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/Data/Table/UGCObject.UGCObject')
    local tData = UGCGameSystem.GetTableDataByRowName(tPath,"1006")
    local tIcon = tData.ItemSmallIcon_n
    local tDes = tData.ItemDesc
    local tCommodityID = 9000002
    if InNum == 1 then
        tCommodityID = 9000002
    elseif InNum == 10 then
        tCommodityID = 9000007
    elseif InNum == 20 then
        tCommodityID = 9000008
    end
    UGCCommoditySystem.BuyUGCCommodity2(tCommodityID,tIcon,tDes,1)
end

function BPPlayerController_ProtectAthena:BuyRefreshPointCommodityResult(InbSucceed,InCount)
    if InbSucceed then
        if self:HasAuthority() then
            local tNum = self.PlayerState:GetRefreshPoint() + InCount
            self.PlayerState:SetRefreshPoint(tNum)
            UnrealNetwork.CallUnrealRPC(self,self,"BuyRefreshPointCommodityResult",InbSucceed,InCount)
        else
            self.Buy_RefreshPointUI_FirstOrder:RemoveFromViewport()          
           
            
        end
    end
end
-- 刷新点用金币刷新
function BPPlayerController_ProtectAthena:ServerRPC_UseRefreshRule(InCost)
    if self:HasAuthority() then
       if self.PlayerState:CheckGoldEnough(InCost) then
            self:ServerRPC_DecreaseGold(InCost)
            self:UseRefreshPoint(true)
        end
        
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_UseRefreshRule",InCost)
    end
end
function BPPlayerController_ProtectAthena:UseRefreshPoint(InbSucceed)
    if InbSucceed then
        if self:HasAuthority() then
            -- local tNum = self.PlayerState:GetRefreshPoint() - 1
            -- self.PlayerState:SetRefreshPoint(tNum)
            UnrealNetwork.CallUnrealRPC(self,self,"UseRefreshPoint",InbSucceed)
        else
            if self.PlayerState.bIsFirstChoose then
                 -- 处于武器选择界面
                if self.BPWidget_WeaponChoose ~= nil and self.BPWidget_WeaponChoose:IsInViewport() then
                    self:ServerRPC_RefreshTheWeaponList(2,1)
                    return
                end
                -- 处于Buff界面
                if self.BuffCardUI ~= nil and self.BuffCardUI:IsInViewport() then
                    self:ServerRPC_RefreshTheBuffSkillList(2,1)
                    return
                end
            else
                -- 处于武器选择界面
                if self.BPWidget_WeaponChoose ~= nil and self.BPWidget_WeaponChoose:IsInViewport() then
                    self:ServerRPC_RefreshTheWeaponList(3,self.PlayerState.iPlayerWhichWeaponStore)
                    return
                end
                -- 处于Buff界面
                if self.BuffCardUI ~= nil and self.BuffCardUI:IsInViewport() then
                    self:ServerRPC_RefreshTheBuffSkillList(1,self.PlayerState.iPlayerWhichBuffSkillStore)
                    return
                end
            end
           
            
        end
    end
end


function BPPlayerController_ProtectAthena:Server_OnUGCCommodityPlayerDataReady()
    UGCLog.Log("BPPlayerController_ProtectAthenaServer_OnUGCCommodityPlayerDataReady")
    --BPPlayerController_ProtectAthena.SuperClass.Server_OnUGCCommodityPlayerDataReady(self)
    local Result = UGCCommoditySystem.GetAllPlayerUGCCommodityList()
    for i, tData in pairs(Result[self:GetInt64UID()]) do
        UGCLog.Log("BPPlayerController_ProtectAthenaServer_OnUGCCommodityPlayerDataReady1",tData)
        self:UpDataCommodityNumber(tData.CommodityID,tData.Count)
    end

end
function BPPlayerController_ProtectAthena:UpDataCommodityNumber(InCommodityID,InCount)
    --更新商业化商品数量
    UGCLog.Log("BPPlayerController_ProtectAthenaUpDataCommodityNumber",InCommodityID,InCount)
    if self:HasAuthority() then
        local PlayerState = self.PlayerState
        if InCommodityID == 1002 then --复活币
            PlayerState:SetRespawnCount(InCount)
        elseif InCommodityID == 1006 then -- 刷新点
            PlayerState:SetRefreshPoint(InCount)
        elseif InCommodityID == 1003 then -- 机甲执行官
        elseif InCommodityID == 1004 then -- 加特林
    
        end 
        -- 付费解锁更新
        if self.BP_PayLockComponent ~= nil then
            if InCount > 0 then
                self.BP_PayLockComponent:UpDataPayLockBinaryDigit(InCommodityID)
            end
        end
    else
       
    end

  
end

 --购买商品后刷新UI
function BPPlayerController_ProtectAthena:OnPayLockChange()
     -- UI 更新
    -- 处于武器选择界面
    if self.BPWidget_WeaponChoose ~= nil and self.BPWidget_WeaponChoose:IsInViewport() then
        self.BPWidget_WeaponChoose:UpDateDataSource()
        return
    end
    -- 处于Buff界面
    if self.BuffCardUI ~= nil and self.BuffCardUI:IsInViewport() then
        self.BuffCardUI:UpDateDataSource()
        return
    end
    -- 怪物商店
    if self.TuYangShopWidget ~= nil then
        self.TuYangShopWidget:InvalidateDataSource()
    end
end

--商业化相关
-- function BPPlayerController_ProtectAthena:ShowBuyBuyRefreshPointUIFirstOrder()
    
-- end
-- function BPPlayerController_ProtectAthena:BuyRefreshPoint()
    
-- end
-- function BPPlayerController_ProtectAthena:BuyRefreshPointCommodityResult(InbSucceed,InCount)
    
-- end
-- function BPPlayerController_ProtectAthena:UseRefreshPoint(InbSucceed)
    
-- end

-- 使用商业化商品点
function BPPlayerController_ProtectAthena:ServerRPC_UseCommercialCommodityRule(InCommodityID,InNum)
    UGCLog.Log("ServerRPC_UseCommercialCommodityRule")
    if self:HasAuthority() then
        local tDeductionNum = InNum
        local PlayerState = self.PlayerState

        if InCommodityID == 1002 then
            UGCLog.Log("[LJH]ServerRPC_UseCommercialCommodityRule_RespawnCount",PlayerState:GetRealRefreshPoint(),PlayerState:GetRefreshPoint(),PlayerState:GetDefaultRefreshPoint())
            if PlayerState:GetRealRespawnCount() >= tDeductionNum then
                 -- 先使用默认复活币
                if PlayerState:GetDefaultRespawnCount() >= tDeductionNum then
                    PlayerState:SetDefaultRespawnCount(PlayerState:GetDefaultRespawnCount() - tDeductionNum)
                    self:UseRevivalCoin(true)
                    return
                else
                    -- 综合使用
                    tDeductionNum = tDeductionNum - PlayerState:GetDefaultRespawnCount()
                    PlayerState:SetDefaultRespawnCount(0)
                end
                -- 再使用玩家购买的复活币
                UGCLog.Log("[LJH]UseCommercialCommodityRule02_Respawn",tDeductionNum)
                self:UseCommercialCommodity(InCommodityID,tDeductionNum,true)
            else
                -- 刷新点不足
                UGCLog.Log("复活币不足")
            end
        
        elseif InCommodityID == 1006 then
            UGCLog.Log("[LJH]ServerRPC_UseCommercialCommodityRule_RefreshPoint",PlayerState:GetRealRefreshPoint(),PlayerState:GetRefreshPoint(),PlayerState:GetDefaultRefreshPoint())
            if PlayerState:GetRealRefreshPoint() >= tDeductionNum then
                 -- 先使用默认刷新点
                if PlayerState:GetDefaultRefreshPoint() >= tDeductionNum then
                    PlayerState:SetDefaultRefreshPoint(PlayerState:GetDefaultRefreshPoint() - tDeductionNum)
                    self:UseRefreshPoint(true)
                    return
                else
                    -- 综合使用
                    tDeductionNum = tDeductionNum - PlayerState:GetDefaultRefreshPoint()
                    PlayerState:SetDefaultRefreshPoint(0)
                end
                -- 再使用玩家购买的刷新点
                UGCLog.Log("[LJH]ServerRPC_UseCommercialCommodityRule02_Refresh",tDeductionNum)
                self:UseCommercialCommodity(InCommodityID,tDeductionNum,false)
            else
                -- 刷新点不足
                UGCLog.Log("刷新点不足")
            end
            -- -- 修改为用金币刷新
            --   if PlayerState:GetRealRefreshPoint() >= tDeductionNum then
            --      -- 先使用默认刷新点
            --     if PlayerState:GetDefaultRefreshPoint() >= tDeductionNum then
            --         PlayerState:SetDefaultRefreshPoint(PlayerState:GetDefaultRefreshPoint() - tDeductionNum)
            --         self:UseRefreshPoint(true)
                    
            --     end
            -- end
        end
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_UseCommercialCommodityRule",InCommodityID,InNum)
    end
end



function BPPlayerController_ProtectAthena:UseCommercialCommodity(InCommodityID,InCount,bShowDialog)
    local tPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/Data/Table/UGCObject.UGCObject')
    local tObjectData = UGCGameSystem.GetTableDataByRowName(tPath,tostring(InCommodityID))
    local tIcon = tObjectData.ItemSmallIcon_n
    local tDes = tObjectData.ItemDesc

    if self:HasAuthority() then
        UGCCommoditySystem.UseUGCCommodity2(self,InCommodityID,tIcon,tDes,InCount,bShowDialog)
    else
        UGCCommoditySystem.UseUGCCommodity2(nil,InCommodityID,tIcon,tDes,InCount,bShowDialog)
    end
    
end


-- UI相关
BPPlayerController_ProtectAthena.BPWidgetPath = 
{
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_BPWidgetWeaponShop.TuYang_BPWidgetWeaponShop_C'), -- 武器商店界面 
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_BPWidgetWeaponChoose.TuYang_BPWidgetWeaponChoose_C'), -- 武器商店选择界面

    [100] = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_Gameover.TuYang_Gameover_C'), -- 游戏结束界面
}
function BPPlayerController_ProtectAthena:CreateWidget(InWidgetID)
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"CreateWidget",InWidgetID)
    else
        local tPath = self.BPWidgetPath[InWidgetID]
        local BPWidget_Class = UE.LoadClass(tPath)
        local BPWidget = nil 
        if UE.IsValid(BPWidget_Class) then
            BPWidget = UserWidget.NewWidgetObjectBP(self, BPWidget_Class)
            if UE.IsValid(BPWidget) then
                BPWidget:AddToViewport(10000)
            end
        end
        return BPWidget
    end
end
-- 新武器商店卡池相关


function BPPlayerController_ProtectAthena:SetBPWidget_WeaponShopUI(InWidget,InShopID)
    UGCLog.Log("[LJH]SetBPWidget_WeaponShopUI",InShopID)
    if self:HasAuthority() then

    else
        self.BPWidget_WeaponShop = InWidget
    end
    --self.PlayerState.iPlayerWhichWeaponStore = InShopID
end

function BPPlayerController_ProtectAthena:ServerRPC_WeaponBuy(InGroundID,ShopID)
    UGCLog.Log("BPPlayerController_ProtectAthenaSercerRPC_WeaponBuy",InGroundID,ShopID)
    -- if self:HasAuthority() then
    --     local PlayerState = self.PlayerState
    --     if ShopID == 0 then
    --         UGCLog.Log("[LJH]ServerRPC_WeaponBuy ShopID == 0")
    --         return
    --     end
    --     PlayerState.iPlayerWhichWeaponStore = ShopID
    --     local tData = self:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.WeaponShop,InGroundID,ShopID)
    --     local tcost = self:HandleStageDiscount(tData.Cost)
    --     self:ServerRPC_Buy(5,InGroundID,ShopID)
    --     -- if PlayerState:GetGold() >= tcost then
    --     --     UGCLog.Log("[LJH] WeaponBuySecceed")
    --     --     self:ServerRPC_DecreaseGold(tcost)
    --     --     self:ServerRPC_RefreshTheWeaponList(InGroundID,self.PlayerState.iPlayerWhichWeaponStore)
    --     -- end
    --     if self:CheckBuyItem(5,tcost) then
    --         self:ServerRPC_RefreshTheWeaponList(InGroundID,self.PlayerState.iPlayerWhichWeaponStore)
    --     end
    -- else
    --     UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_WeaponBuy",InGroundID,ShopID)
    -- end
    self:ServerRPC_Buy(5,InGroundID,ShopID)
end




function BPPlayerController_ProtectAthena:ServerRPC_RefreshTheWeaponList(InGroundID,InShopID)
    UGCLog.Log("[LJH] ServerRPC_RefreshTheWeaponList ",InGroundID,InShopID)
    --local tKeyList = {"AUG","AK47","AK47"}
    local GameState = UGCGameSystem.GetGameState()
    
    if self.PlayerState == nil then
        UGCLog.Log("[LJH]ServerRPC_RefreshTheWeaponList self.PlayerState == nil")
        return
    end
    
    if self:HasAuthority() then
        if self.PlayerState.iPlayerWhichWeaponStore == 0 then
            UGCLog.Log("Error [LJH]RefreshTheWeaponList self.iPlayerWhichWeaponStore == 0")
            return
        end
            local tData = self:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.WeaponShop,InGroundID,InShopID)
            if tData == nil then
                UGCLog.Log("Error [LJH]ServerRPC_RefreshTheWeaponList tData is nil",TuYang_ShopConfig.ItemKey.WeaponShop,InGroundID,tShopID)
                return
            end
            --UGCLog.Log("[LJH]ServerRPC_RefreshTheWeaponList tData is ",tData)
            local tKeyList = TuYang_ShopConfig:SelectRandomCardsFromTheCardPool(tData.Items)
            self:ClientRPC_CreateWeaponChoose(tKeyList)
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_RefreshTheWeaponList",InGroundID,InShopID)
    end
end


function BPPlayerController_ProtectAthena:ClientRPC_CreateWeaponChoose(InKeyList)
    UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_CreateWeaponChoose")
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_CreateWeaponChoose",InKeyList)
    else
        if self.BPWidget_WeaponChoose == nil then
            self.BPWidget_WeaponChoose = self:CreateWidget(2) -- 武器商店选择界面
            self.GoldCommodityList[2].Widget = self.BPWidget_WeaponChoose
        end

        if UE.IsValid(self.BPWidget_WeaponChoose) then
            self.BPWidget_WeaponChoose:SetKeyList(InKeyList)
            self.BPWidget_WeaponChoose:AddToViewport(10000)
        end
        if UE.IsValid(self.BPWidget_WeaponShop) then
            --self.BPWidget_WeaponShop:Close()
        else
            UGCLog.Log("Error [LJH]ClientRPC_CreateWeaponChooseBPWidget_WeaponShop is nil")
        end
    end
end

function BPPlayerController_ProtectAthena:OnWeaponChooseChick(InKey)
    UGCLog.Log("[LJH]OnWeaponChooseChick",InKey)
    self:ServerRPC_GiveItem(InKey)

    if self.PlayerState.bIsFirstChoose then
        self:ServerRPC_RefreshTheBuffSkillList(2,1)
    end
end

function BPPlayerController_ProtectAthena:ServerRPC_GiveItem(InKey)
    UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_GiveItem",InKey)
    if self:HasAuthority() then
        local DataSource = WeaponConfig:GetWeaponItems(WeaponConfig.ItemKey.WeaponKey,InKey)
        local tAccessories = WeaponConfig:GetWeaponItems(WeaponConfig.ItemKey.WeaponKey,"MZJ_HD")
        --local tAccessoriesList = WeaponConfig:GetWeaponAddAccessoriesList(InKey)
        if DataSource ~= nil then
            --UGCLog.Log("[LJH]GivePlayerWeaponToItemID DataSource is ", DataSource)
            UGCBackPackSystem.AddItem(self:GetPlayerCharacterSafety(), DataSource.ItemID, DataSource.Count)
            --添加红点 临时
            if tAccessories ~= nil then
                UGCBackPackSystem.AddItem(self:GetPlayerCharacterSafety(), tAccessories.ItemID, tAccessories.Count)
            end
                       -- 为武器添加特定配件
            -- UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_GiveItem1",            -- if tAccessoriesList ~= nil then
            --     UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_GiveItem1",tAccessoriesList)
            --     for i, tData in pairs(tAccessoriesList) do
            --         local tAcc = WeaponConfig:GetWeaponItems(WeaponConfig.ItemKey.WeaponKey,tData)
            --         UGCBackPackSystem.AddItem(self:GetPlayerCharacterSafety(), tAcc.ItemID, tAcc.Count)
            --     end
            -- end

            
            --UGCBackPackSystem.AddItem(self:GetPlayerCharacterSafety(), 203001, 1)
        else
            UGCLog.Log("[LJH]GivePlayerWeaponToItemID DataSource is nil InKey = ",InKey)
        end
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_GiveItem",InKey)
    end
end

-- 新技能商店相关
function BPPlayerController_ProtectAthena:SetBPWidget_BuffSkillShopUI(InWidget,InShopID)
    UGCLog.Log("[LJH]SetBPWidget_BuffSkillShopUI",InShopID)
    if self:HasAuthority() then

    else
        self.BPWidget_BuffSkillShop = InWidget
        self.GoldCommodityList[4].Widget = self.BPWidget_BuffSkillShop
    end
    self.PlayerState.iPlayerWhichBuffSkillStore = InShopID
end

function BPPlayerController_ProtectAthena:ServerRPC_BuffSkillBuy(InGroundID,ShopID)
    UGCLog.Log("BPPlayerController_ProtectAthenaSercerRPC_BuffSkillBuy",ShopID)
    -- if self:HasAuthority() then
    --     local PlayerState = self.PlayerState
    --     if ShopID == 0 then
    --         UGCLog.Log("Error [LJH]ServerRPC_BuffSkillBuy ShopID == 0")
    --         return
    --     end
    --     local tData = self:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.BuffSkillShop,1,ShopID)
    --     --local tcost = tData.Cost
    --     local tcost = self:HandleStageDiscount(tData.Cost)
    --     if self:CheckBuyItem(4,tcost) then
    --         UGCLog.Log("[LJH] BuffSkillBuySecceed")
    --         --self:ServerRPC_DecreaseGold(tcost)
    --         local GameState = UGCGameSystem.GetGameState()
            
    --         self:ServerRPC_RefreshTheBuffSkillList(InGroundID,ShopID)
    --     end
    -- else
    --     UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_BuffSkillBuy",InGroundID,ShopID)
    -- end
    self:ServerRPC_Buy(4,InGroundID,ShopID)
end

function BPPlayerController_ProtectAthena:ServerRPC_RefreshTheBuffSkillList(InGroundID,InShopID)
    --local tKeyList = {"AUG","AK47","AK47"}
    if self.PlayerState == nil then
        UGCLog.Log("Error [LJH]ServerRPC_RefreshTheBuffSkillList self.PlayerState == nil")
        return
    end
    UGCLog.Log("[LJH] BuffSkillBuySecceed0 iPlayerWhichBuffSkillStore = ",InShopID)
 
    if self:HasAuthority() then
        if self.PlayerState.iPlayerWhichBuffSkillStore == 0 then
            UGCLog.Log("[LJH]RefreshTheBuffSkillList self.iPlayerWhichBuffSkillStore == 0")
            return
        end
        local tData = self:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.BuffSkillShop,InGroundID,InShopID)
        if tData == nil then
            UGCLog.Log("Error [LJH]RefreshTheBuffSkillShop tData is nil",TuYang_ShopConfig.ItemKey.BuffSkillShop,InGroundID,InShopID)
            return
        end

        local tRealdata = tData
        -- 在生成候选列表时过滤已选BUFF
        if self.PlayerBuffComponent ~= nil then
            tRealdata = TuYang_ShopConfig:FilterAvailableItems(tData.Items,self.PlayerBuffComponent.BuffList)
        end
        --UGCLog.Log("[LJH]RefreshTheBuffSkillList tRealdata is ",tRealdata)
        local tKeyList = TuYang_ShopConfig:SelectRandomCardsFromTheCardPool(tRealdata)
        self:ClientRPC_CreateBuffSkillChoose(tKeyList)
        
    else
        UnrealNetwork.CallUnrealRPC(self,self,"ServerRPC_RefreshTheBuffSkillList",InGroundID,InShopID)
    end
end


function BPPlayerController_ProtectAthena:ClientRPC_CreateBuffSkillChoose(InKeyList)
    UGCLog.Log("BPPlayerController_ProtectAthenaClientRPC_CreateBuffSkillChoose")
    if self:HasAuthority() then
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_CreateBuffSkillChoose",InKeyList)
    else
        self:ChooseRoundStartBuff() -- Buff商店选择界面
        
        if UE.IsValid(self.BuffCardUI) then
            self.BuffCardUI:SetKeyList(InKeyList)
            self.BuffCardUI:AddToViewport(10000)
        end
      
    end
end

function BPPlayerController_ProtectAthena:OnBuffSkillChooseChick(InKey)
    UGCLog.Log("[LJH]OnBuffSkillChooseChick",InKey)
    self:ServerRPC_ClickBuffToSelect(InKey)
end


-- 游戏结束
function BPPlayerController_ProtectAthena:ClientRPC_GameOverResult()
    if self:HasAuthority() then
        local GameState = UGCGameSystem.GetGameState()
        local PlayerState = self.PlayerState
        -- 上传玩家存档
        local tReadArchive = UGCPlayerStateSystem.GetPlayerArchiveData(self:GetInt64UID())
        UGCLog.Log("BPPlayerController_ProtectAthena:ClientRPC_GameOverResult0 tReadArchive = " , tReadArchive)
        local tCount = 0
        if tReadArchive["TotalNumberOfEnemiesKilled"] == nil then
            tReadArchive["TotalNumberOfEnemiesKilled"] = 0
        end
        tCount = tReadArchive["TotalNumberOfEnemiesKilled"] + PlayerState.EnemyCount
        PlayerState:UpDataGameSavePlayerData("TotalNumberOfEnemiesKilled",tCount)
        -- 胜场数
        if self.TeamID == GameState.iWinTeamID then
            tCount = 0
            if tReadArchive["WinCount"] == nil then
                tReadArchive["WinCount"] = 0
            end
            tCount = tReadArchive["WinCount"] + 1
            PlayerState:UpDataGameSavePlayerData("WinCount",tCount)
        end
        PlayerState:SaveData()
        UnrealNetwork.CallUnrealRPC(self,self,"ClientRPC_GameOverResult")
    else
        local BPWidget_PlayerResult = self:CreateWidget(100) -- 游戏结束界面
        BPWidget_PlayerResult:AddToViewport(100100) --10099 主ui
    end
end


-- 跳过开场
function BPPlayerController_ProtectAthena:ServerRPC_SkipGameStartSequence()
    --UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_SkipGameStart")
    if self:HasAuthority() then
    else
        if self.StartSequence == nil then
            UGCLog.Log("BPPlayerController_ProtectAthenaServerRPC_SkipGameStart StartSequence == nil")
        end
        self.StartSequence.SequencePlayer:Stop()
       
       
    end
end

-- 跳过Sequence回调
function BPPlayerController_ProtectAthena:StartSequenceEnd()
    UGCLog.Log("BPPlayerController_ProtectAthenaStartSequenceEnd")
    if self.bFirstChooseSafety or not self.PlayerState.bIsFirstChoose then
        UGCLog.Log("[LJH] The failure to skip the sequence binding took the fallback logic")
        return
    end
    self.bFirstChooseSafety = true
    if self:HasAuthority() then
        
    else
        if self.StartSequenceUI ~= nil then
        self.StartSequenceUI:RemoveFromViewport()
        end
        --Timer.RemoveTimer(self.StartSequenceEndTimer)
        if self.PlayerState ~= nil then
            if self.PlayerState.bIsFirstChoose then
                self:TimerPlayerLogin()
            end
        else
            Timer.InsertTimer(1,
            function()
                self:TimerPlayerLogin()
            end,false)    
        end
    end
    
        -- 删除绑定的Actor
    if self.StartSequence ~= nil then 
        local ActorClass = UE.LoadClass('/Script/Engine.Actor')
        -- local tObject = self.StartSequence.SequencePlayer:GetBoundObjects()
        -- for k, v in pairs(tObject) do
        --     UGCLog.Log("BPPlayerController_ProtectAthenaStartSequenceEnd11")
        --     if UE.IsA(v,ActorClass) then
        --     UGCLog.Log("BPPlayerController_ProtectAthenaStartSequenceEnd tObject is ActorClass")
        --     v:K2_DestroyActor()
        --     end
        -- end

        local tObject = GameplayStatics.GetAllActorsWithTag(self,"StartSequence")
        for k, v in pairs(tObject) do
            --UGCLog.Log("BPPlayerController_ProtectAthenaStartSequenceEnd11")
            if UE.IsValid(v) and UE.IsA(v,ActorClass) then
                --UGCLog.Log("BPPlayerController_ProtectAthenaStartSequenceEnd tObject is ActorClass")
                v:SetActorHiddenInGame(true)
                v:K2_DestroyActor()
            end
        end
    end
end

-- 商品打折机制
function BPPlayerController_ProtectAthena:HandleStageDiscount(InCost)
    local PlayerState = self.PlayerState    
    return InCost * PlayerState.TotalDiscount
end
-- 阶段转换修改打折系数
function BPPlayerController_ProtectAthena:HandleStageDiscountChange(InID , InStage)
    if self.TeamID ~= InID then
        return
    end
    local PlayerState = self.PlayerState
    PlayerState:SetStageDiscounts(InStage)
end


function BPPlayerController_ProtectAthena:ModifyGetShopItems(Key, GroupId,ShopID)

    if TuYang_ShopConfig == nil then
        UGCLog.Log("[LJH]GetShopItems TuYang_ShopConfig is nil",Key,GroupId,ShopID)
        TuYang_ShopConfig = require("Script.TuYang_ShopConfig")
    end
    local tData = TuYang_ShopConfig.GetShopItems(Key,GroupId,ShopID)
    if tData == nil then
        UGCLog.Log("[LJH]GetShopItems tData is nil",Key,GroupId,ShopID)
        return
    end
    return tData
end


-- GM指令
function BPPlayerController_ProtectAthena:GM_SavePlayerData(InData)
    local GameState = UGCGameSystem.GetGameState()
    if self:HasAuthority() then
        UGCLog.Log("GM_SavePlayerData")
        -- -- 上传玩家存档
		-- local tReadArchive = UGCPlayerStateSystem.GetPlayerArchiveData(self:GetInt64UID())
		-- UGCLog.Log("GM_SavePlayerData:Execute00 tReadArchive = " , tReadArchive)
		-- for k,v in pairs(tReadArchive) do
		-- 	UGCLog.Log("GM_SavePlayerData:Execute01 ",k,v)
		-- end
        -- local tCount = 0
        -- if tReadArchive["TotalNumberOfEnemiesKilled"] then
        --     tCount = tReadArchive["TotalNumberOfEnemiesKilled"] + InData
        -- else
        --     tReadArchive["TotalNumberOfEnemiesKilled"] = 0
        -- end
        
        -- self.PlayerState:UpDataGameSavePlayerData("TotalNumberOfEnemiesKilled",tCount)
		-- self.PlayerState:SaveData()
        --self.PlayerState:AddEnemyCount()
        -- Timer.InsertTimer(5.0, function()
        --     -- self:ServerRPC_ClickBuffToSelect(21)
        --     self:ServerRPC_ClickBuffToSelect(12)
        --     self:ServerRPC_ClickBuffToSelect(24)
        --     self:ServerRPC_ClickBuffToSelect(25)
        --     self:ServerRPC_ClickBuffToSelect(26)
        --     self:ServerRPC_ClickBuffToSelect(51)
        -- end,false)
        --self.PlayerState.iRemainingSelectionTimes_Buff = self.PlayerState.RemainingSelectionTimesMax_Buff
        
        self.PlayerState:SetIsFirstChoose(false)
        self:StealTheGun()
        self.PlayerState:SetReconnectDataValue("iBuffSkillElement",99)
        --GameState:SetCurrentRound(3)
    else
        --self:ServerRPC_RefreshTheWeaponList(2,1) --直接选武器和buff不等的配合修改StartSequence
        
        --self:ServerRPC_RefreshTheBuffSkillList()
        --local string = tostring(self.PlayerState:GeReconnectDataValue("textvalue"))
        local string = tostring(GameState:GetCurrentRound())
        UGCWidgetManagerSystem.ShowTipsUI(string)
        --UGCWidgetManagerSystem.AddNewUI(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_UpGrade_Hint1.TuYang_UpGrade_Hint1_C'),true)
        --UGCWidgetManagerSystem.AddObjectPositionUI()
       
        UnrealNetwork.CallUnrealRPC(self,self,"GM_SavePlayerData",InData)
    end
    
end

BPPlayerController_ProtectAthena.CopyPersistSkillDamagesList = {
        -- Skill1系列
        Skill1_1 = {SkillDamageMultiplier = 1.0,    DamageMultiplier = 0.16,     WeaponArrtibute = 0.1, Handler = "IncShootIntervalTime"},
        Skill1_2 = {SkillDamageMultiplier = 0.15,   DamageMultiplier = 0.18,    WeaponArrtibute = 0.11,Handler = "QuickReloadTime"},
        Skill1_3 = {SkillDamageMultiplier = 0.5,    DamageMultiplier = 0.18,    WeaponArrtibute = 0.11,Handler = "IncBulletNumInOneClip"},
        Skill1_4 = {SkillDamageMultiplier = 0.35,   DamageMultiplier = 0.27,    WeaponArrtibute = 0.17,Handler = "QuickReloadTime"},
        Skill1_9 = {SkillDamageMultiplier = 0.75,   DamageMultiplier = 0.21,    WeaponArrtibute = 0.13,Handler = "QuickReloadTime"},
    
        -- Skill2系列
        Skill2_1 = {SkillDamageMultiplier = 0.7,    DamageMultiplier = 0.18, WeaponArrtibute = 1,   Handler = "IncBulletNumInOneClip"},
        Skill2_2 = {SkillDamageMultiplier = 0.1,    DamageMultiplier = 0.21,  WeaponArrtibute = 1,   Handler = "IncBulletNumInOneClip"},
        Skill2_3 = {SkillDamageMultiplier = 0.2,    DamageMultiplier = 0.27,  WeaponArrtibute = 0.17,Handler = "QuickReloadTime"},
        Skill2_4 = {SkillDamageMultiplier = 2.25  ,  DamageMultiplier = 0.18,  WeaponArrtibute = 1,   Handler = "IncBulletNumInOneClip"},
        Skill2_8 = {SkillDamageMultiplier = 1.0  ,  DamageMultiplier = 0.27,  WeaponArrtibute = 2  , Handler = "IncBulletNumInOneClip"},
        Skill2_9 = {SkillDamageMultiplier = 2  ,    DamageMultiplier = 0.16,  WeaponArrtibute = 0.1, Handler = "QuickReloadTime"},
    
        -- Skill3系列
        Skill3_1 = {SkillDamageMultiplier = 0.85, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "IncWeaponBulletDamage"},
        Skill3_2 = {SkillDamageMultiplier = 1.05, DamageMultiplier = 0.27, WeaponArrtibute = 0.17, Handler = "IncWeaponBulletDamage"},
        Skill3_3 = {SkillDamageMultiplier = 2.55, DamageMultiplier = 0.16, WeaponArrtibute = 0.1,  Handler = "IncWeaponBulletDamage"},
        Skill3_4 = {SkillDamageMultiplier = 1.35, DamageMultiplier = 0.21, WeaponArrtibute = 0.13, Handler = "IncWeaponBulletDamage"},
        Skill3_9 = {SkillDamageMultiplier = 1.3, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "IncWeaponBulletDamage"},
    
        -- Skill4系列
        Skill4_1 = {SkillDamageMultiplier = 0.05, DamageMultiplier = 0.27, WeaponArrtibute = 0.17, Handler = "SkillChangePlayerSpeed"},
        Skill4_2 = {SkillDamageMultiplier = 0.2, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerSpeed"},
        Skill4_3 = {SkillDamageMultiplier = 0.03, DamageMultiplier = 0.21, WeaponArrtibute = 0.13, Handler = "SkillChangePlayerSpeed"},
        Skill4_4 = {SkillDamageMultiplier = 0.12, DamageMultiplier = 0.16, WeaponArrtibute = 0.1,  Handler = "SkillChangePlayerSpeed"},
        Skill4_9 = {SkillDamageMultiplier = 0.025, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerSpeed"},
    
        -- Skill5系列
        Skill5_1 = {SkillDamageMultiplier = 0.025, DamageMultiplier = 0.21, WeaponArrtibute = 0.13, Handler = "SkillChangePlayerHealth"},
        Skill5_2 = {SkillDamageMultiplier = 0.1, DamageMultiplier = 0.16, WeaponArrtibute = 0.1,  Handler = "SkillChangePlayerHealth"},
        Skill5_3 = {SkillDamageMultiplier = 0.06, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerHealth"},
        Skill5_4 = {SkillDamageMultiplier = 0.04, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerHealth"},
        Skill5_9 = {SkillDamageMultiplier = 0.25, DamageMultiplier = 0.27, WeaponArrtibute = 0.17, Handler = "SkillChangePlayerHealth"}
}

return BPPlayerController_ProtectAthena