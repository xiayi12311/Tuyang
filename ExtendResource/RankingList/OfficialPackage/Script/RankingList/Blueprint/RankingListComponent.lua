---@class RankingListComponent_C:ActorComponent
---@field RankingListMainUIPath FSoftClassPath
---@field RankingListUnnamedUIPath FSoftClassPath
---@field GoldIconPath FSoftObjectPath
---@field SilverIconPath FSoftObjectPath
---@field CopperIconPath FSoftObjectPath
---@field RankingListItemGetUIPath FSoftClassPath
---@field RankingListExplanationUIPath FSoftClassPath
---@field RankingListBtnUIPath FSoftClassPath
--Edit Below--
local RankingListComponent = {
    RankListAwardState = {},
    AllRankListData = {
        RankData = {},
        MyRank = {},
    },
    AllUIDList = {},
    ProfileUIDList = {},
    AllUIDProfileData = {},
    LastReceiveRankID = 0,
    PlayerAccountInfo = {},
    PrivacySetting = {},
    InitRankingListManager = false;
    InitVirtualItemManager = false;
}

UGCGameSystem.UGCRequire("ExtendResource.RankingList.OfficialPackage." .. "Script.RankingList.RankingListManager");
UGCGameSystem.UGCRequire("ExtendResource.RankingList.OfficialPackage." .. "Script.Common.Common");

function RankingListComponent:ReceiveBeginPlay()
    print("[RankingListComponent] ReceiveBeginPlay")
    RankingListComponent.SuperClass.ReceiveBeginPlay(self)
    RankingListManager:RegisterComponentClass(GameplayStatics.GetObjectClass(self));

    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        GMP.GlobalMessage.BindUObject(PlayerController, "UGC.GamePart.GamePartLoadedForPlayer", self, self.InitGamePart);

        if PlayerController:GetInt64PlayerKey() == 0 then
            local STExtraGMDelegatesMgr = UGCGameSystem.GetSTExtraGMDelegatesMgr();
            if STExtraGMDelegatesMgr ~= nil then
                STExtraGMDelegatesMgr.GetInstance().OnPlayerPostLoginDelegate:AddInstance(self.LoadData, self);
            end
        else
            self:LoadData();
        end
    else
        GMP.GlobalMessage.BindUObject(PlayerController, "UGC.GamePart.GamePartLoaded", self, self.InitGamePart); 
        self:PreLoadUI();
    end

    self.AllUIDList = {};
    self.ProfileUIDList = {};
    self.AllUIDProfileData = {};

    local ShowRankListBtn = false;
    local RequestUIDList = false;
    local SyncAwardState = false;
    if self.RankingListTimer == nil then
        self.RankingListTimer = Timer.InsertTimer(
            1,
            function ()
                local ServerTime = UGCGameSystem.GetServerTimeSec();
                if PlayerController:HasAuthority() == true then
                    print(string.format("[RankingListComponent] UID: %d ServerTime: %d LastRequestTime: %d", self:GetSelfUID() or 0, ServerTime or 0, self.LastRequestTime or 0));
                    if UE.IsValid(self:GetRankingListPlayerComponent()) then
                        if self.LastRequestTime == nil or ServerTime - self.LastRequestTime >= 60 then
                            local RankList = RankingListManager:GetLegalRankListTableData();
                            if RankList and next(RankList) ~= nil then
                                self:RequestAllRankListData();
                            end
                        end

                        if SyncAwardState == false then
                            local PlayerData = self:GetRankingListPlayerComponent():ReadPlayerData();
                            self.RankListAwardState = PlayerData.AwardState;
                            _G.DOREPONCE(self, "RankListAwardState");
                            SyncAwardState = true;
                        end
                    end
                else
                    if ShowRankListBtn == false and (self.LastCheckRankListTime == nil or ServerTime - self.LastCheckRankListTime >= 60) then
                        local RankList = RankingListManager:GetLegalRankListTableData();
                        if RankList and next(RankList) ~= nil then
                            if self.RankingListBtn then
                                self.RankingListBtn:InitUI();
                                self.RankingListBtn:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                                ShowRankListBtn = true;
                            end
                        end
                        self.LastCheckRankListTime = ServerTime;
                    end

                    if ServerTime and RequestUIDList == false and UE.IsValid(self:GetRankingListPlayerComponent()) then
                        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_RequestProfileUIDList");
                        RequestUIDList = true;
                    end
                end

                if self.InitRankingListManager == false and UE.IsValid(self:GetRankingListPlayerComponent()) then
                    self:GetRankingListPlayerComponent().RequestRankListDelegate:Add(self.RequestRankListDataOtherRsp, self);
                    self:GetRankingListPlayerComponent().RequestRankListInnerDelegate:Add(self.RequestRankListDataRsp, self);
                    self:GetRankingListPlayerComponent().SetRankListPrivacyDelegate:Add(self.SetRankListPrivacyRsp, self);
                    self:GetRankingListPlayerComponent().GetRankListPrivacyDelegate:Add(self.GetRankListPrivacyRsp, self);
                    self:GetRankingListPlayerComponent().UpdateRankListDelegate:Add(self.UpdateRankListRsp, self);
                    self.InitRankingListManager = true;
                end

                if self.InitVirtualItemManager == false and UE.IsValid(self:GetVirtualItemManager()) then
                    if PlayerController:HasAuthority() == true then
                        self:GetVirtualItemManager().AddItemResultDelegate:Add(self.OnAddVirtualItem, self);
                    end
                    self.InitVirtualItemManager = true;
                end
            end,
            true,
            "RankingListTimer",
            0
        );
    end
end

--[[
function RankingListComponent:ReceiveTick(DeltaTime)
    RankingListComponent.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

function RankingListComponent:ReceiveEndPlay()
    print("[RankingListComponent] ReceiveEndPlay");
    RankingListComponent.SuperClass.ReceiveEndPlay(self);

    if UE.IsValid(self:GetRankingListPlayerComponent()) then
        self:GetRankingListPlayerComponent().RequestRankListDelegate:Remove(self.RequestRankListDataOtherRsp, self);
        self:GetRankingListPlayerComponent().RequestRankListInnerDelegate:Remove(self.RequestRankListDataRsp, self);
        self:GetRankingListPlayerComponent().SetRankListPrivacyDelegate:Remove(self.SetRankListPrivacyRsp, self);
        self:GetRankingListPlayerComponent().GetRankListPrivacyDelegate:Remove(self.GetRankListPrivacyRsp, self);
        self:GetRankingListPlayerComponent().UpdateRankListDelegate:Remove(self.UpdateRankListRsp, self);
    end

    if self:GetOwner():HasAuthority() == true then
        if UE.IsValid(self:GetVirtualItemManager()) then
            self:GetVirtualItemManager().AddItemResultDelegate:Remove(self.OnAddVirtualItem, self);
        end
    end

    if self.RankingListTimer ~= nil then
        Timer.RemoveTimer(self.RankingListTimer);
        self.RankingListTimer = nil;
    end
end

function RankingListComponent:GetReplicatedProperties()
    return {"RankListAwardState", "Lazy"}, "LastReceiveRankID", {"PlayerAccountInfo", "Lazy"}, {"PrivacySetting", "Lazy"};
end

function RankingListComponent:GetAvailableServerRPCs()
    return  "Server_UploadPrivacySetting",
            "Server_ReceiveRankListAward",
            "Server_UpdateRankListScore",
            "Server_RequestAllRankListData",
            "Server_ClearAllRankListData",
            "Server_UpdateLocalRankListData",
            "Server_RequestRankListData",
            "Server_RequestProfileUIDList";
end

--初始化GamePart
---生效范围:客户端&&服务端
---@param GamePartName string
function RankingListComponent:InitGamePart(GamePartName)
    print(string.format("[RankingListComponent] InitGamePart GamePartName: %s", GamePartName or ""));
    local PlayerController = self:GetOwner();
    if GamePartName == "VirtualItemManager" then
        if self.VirtualItemManager == nil then
            self.VirtualItemManager = UGCBlueprintFunctionLibrary.GetGamePartGlobalActor(UGCGameSystem.GameState, "VirtualItemManager");
        end
        print(string.format("[RankingListComponent] VirtualItemManager is Nil: %s", self.VirtualItemManager == nil));
    elseif GamePartName == "RankingListManager" then
        if self.RankingListPlayerComponent == nil then
            self.RankingListPlayerComponent = UGCBlueprintFunctionLibrary.GetGamePartPlayerComponent(PlayerController, "RankingListManager", PlayerController, "RankingList");
        end
        print(string.format("[RankingListComponent] RankingListPlayerComponent is Nil: %s", self.RankingListPlayerComponent == nil));
    end
end

--玩家登录后初始化数据
--生效范围：服务端
function RankingListComponent:LoadData()
    local PlayerController = self:GetOwner();
    local PlayerKey = PlayerController:GetInt64PlayerKey();
    local PlayerAccountInfo = UGCPlayerStateSystem.GetPlayerAccountInfo(PlayerKey):Copy();
    self.PlayerAccountInfo.UID = PlayerAccountInfo.UID;
    self.PlayerAccountInfo.PlayerName = PlayerAccountInfo.PlayerName;
    self.PlayerAccountInfo.Gender = PlayerAccountInfo.Gender;
    self.PlayerAccountInfo.IconURL = PlayerAccountInfo.IconURL;
    _G.DOREPONCE(self, "PlayerAccountInfo");
    self:ResetAllRankListData();
end

function RankingListComponent:OnRep_PrivacySetting()
    log_tree("[RankingListComponent] OnRep_PrivacySetting PrivacySetting: ", self.PrivacySetting);
end

function RankingListComponent:OnRep_PlayerAccountInfo()
    log_tree("[RankingListComponent] OnRep_PlayerAccountInfo PlayerAccountInfo: ", self.PlayerAccountInfo);
end

function RankingListComponent:OnRep_RankListAwardState()
    log_tree("[RankingListComponent] OnRep_RankListAwardState RankListAwardState: ", self.RankListAwardState);
    -- 刷新所有红点
    self:RefreshAllRedPoint();
end

------------------------------------------------------------请求数据相关------------------------------------------------------------
--请求所有排行榜数据
--生效范围：客户端
function RankingListComponent:ClientRequestAllRankListData()
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        return;
    end
    UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_RequestAllRankListData", PlayerController);
end

--请求所有排行榜数据
--生效范围：服务端
---@param PlayerController BP_UGCPlayerController_C
function RankingListComponent:Server_RequestAllRankListData(PlayerController)
    if PlayerController:HasAuthority() == false then
        return;
    end
    self:RequestAllRankListData();
end

--请求所有排行榜数据
--生效范围：服务端
function RankingListComponent:RequestAllRankListData()
    print("[RankingListComponent] RequestAllRankListData")
    --- 清空隐私设置
    self.PrivacySetting = {};
    --- 清空UID
    self.AllUIDList = {};
    self.ProfileUIDList = {};
    self.RequestAllRankListState = {};
    local RankListTableData = RankingListManager:GetLegalRankListTableData();
    for Index, Data in pairs(RankListTableData) do
        if not self:IsPIE() then
            self.AllRankListData.RankData[Data.ID] = {
                [0] = {},
                [1] = {},
            }
            self.AllRankListData.MyRank[Data.ID] = {
                [0] = {
                    Rank = -1,
                    Score = 0,
                },
                [1] = {
                    Rank = -1,
                    Score = 0,
                },
            }
        end
        if Data.PeriodType == ERankListPeriodType.NotReset then
            if Data.PeopleNum <= 100 then
                self:RequestRankingListData(Data.ID, 1, Data.PeopleNum, 0);
            else
                self:RequestRankingListData(Data.ID, 1, 100, 0);
                self:RequestRankingListData(Data.ID, 101, Data.PeopleNum - 100, 0);
            end
            self.RequestAllRankListState[Data.ID] = {
                [0] = false,
            }
        else
            if Data.PeopleNum <= 100 then
                self:RequestRankingListData(Data.ID, 1, Data.PeopleNum, 0);
                self:RequestRankingListData(Data.ID, 1, Data.PeopleNum, 1);
            else
                self:RequestRankingListData(Data.ID, 1, 100, 0);
                self:RequestRankingListData(Data.ID, 101, Data.PeopleNum - 100, 0);
                self:RequestRankingListData(Data.ID, 1, 100, 1);
                self:RequestRankingListData(Data.ID, 101, Data.PeopleNum - 100, 1);
            end
            self.RequestAllRankListState[Data.ID] = {
                [0] = false,
                [1] = false,
            }
        end
    end
    self.LastRequestTime = UGCGameSystem.GetServerTimeSec();
end
---请求所有排行榜数据
--生效范围：服务端
---@param PlayerController BP_UGCPlayerController_C
---@param RankID number
---@param StartIdx number
---@param Count number
---@param RankingCycles number
function RankingListComponent:Server_RequestRankListData(PlayerController, RankID, StartIdx, Count, RankingCycles)
    if PlayerController:HasAuthority() == false then
        return;
    end
    self:RequestRankingListData(RankID, StartIdx, Count, RankingCycles);
end

--请求单个排行榜数据
--生效范围：服务端
---@param RankID number
---@param StartIdx number
---@param Count number
---@param RankingCycles number
function RankingListComponent:RequestRankingListData(RankID, StartIdx, Count, RankingCycles)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return;
    end
    if self:IsPIE() then
        self.DelayTimer = Timer.InsertTimer(1, function()
            -- log_tree("[RankingListComponent] RequestRankingListData AllRankListData: ", self.AllRankListData);

            if self.AllRankListData then
                local RankList = {};
                local MyRankData = {rank_no = -1,score = 0};
                local TotalCount = 0;
                if self.AllRankListData.RankData and
                    self.AllRankListData.RankData[RankID] and
                    self.AllRankListData.RankData[RankID][RankingCycles] then
                    for Idx = StartIdx, Count do
                        if self.AllRankListData.RankData[RankID][RankingCycles][Idx] then
                            local RankData = {};
                            RankData.rank = self.AllRankListData.RankData[RankID][RankingCycles][Idx].Rank or -1;
                            RankData.uid = self.AllRankListData.RankData[RankID][RankingCycles][Idx].UID or 0;
                            RankData.total_score = self.AllRankListData.RankData[RankID][RankingCycles][Idx].Score or 0;
                            RankList[Idx] = RankData;
                        end 
                    end
                    TotalCount = #self.AllRankListData.RankData[RankID][RankingCycles];
                end
                
                if self.AllRankListData.MyRank and
                    self.AllRankListData.MyRank[RankID] and
                    self.AllRankListData.MyRank[RankID][RankingCycles] then
                    MyRankData.rank_no = self.AllRankListData.MyRank[RankID][RankingCycles].Rank or -1;
                    MyRankData.score = self.AllRankListData.MyRank[RankID][RankingCycles].Score or 0;
                end
                if UE.IsValid(self:GetRankingListPlayerComponent()) then
                    local UID = PlayerController:GetInt64UID();
                    self:GetRankingListPlayerComponent():RequestRankListDataResponse(0, UID, RankID, StartIdx, Count, RankingCycles, TotalCount, RankList, MyRankData);
                end
            end
            if self.DelayTimer ~= nil then
                Timer.RemoveTimer(self.DelayTimer);
                self.DelayTimer = nil;
            end
        end, false);
    else
        if UE.IsValid(self:GetRankingListPlayerComponent()) then
            self:GetRankingListPlayerComponent():RequestRankingListData(RankID, StartIdx, Count, RankingCycles);
        end
    end
end

--请求排行榜数据回调
--生效范围：服务端
---@param RequestParam any
function RankingListComponent:RequestRankListDataRsp(RequestParam)
    log_tree("[RankingListComponent] RequestRankListDataRsp: ", RequestParam);
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return;
    end
    local Res = RequestParam.Res;
    local UID = RequestParam.UID;
    local RankID = RequestParam.RankID;
    local StartIdx = RequestParam.StartIdx;
    local Count = RequestParam.Count;
    local RankingCycles = RequestParam.RankingCycles;
    local TotalCount = RequestParam.TotalCount;
    local RankList = RequestParam.RankList;
    local MyRankData = RequestParam.MyRankData;

    local SelfUID = self:GetSelfUID();
    local NewUIDList = {};
    if self.AllUIDList[SelfUID] == nil and SelfUID ~= 0 then
        self.AllUIDList[SelfUID] = true;
        self.ProfileUIDList[#self.ProfileUIDList + 1] = SelfUID;
        table.insert(NewUIDList, SelfUID);
    end

    local RankListData = {
        RankData = {
            [RankID] = {
                [RankingCycles] = {
                }
            }
        },
        MyRank = {
            [RankID] = {
                [0] = {
                    Rank = -1,
                    Score = 0,
                },
                [1] = {
                    Rank = -1,
                    Score = 0,
                }
            }
        },
    };
    if Res == 0 then
        if TotalCount == 0 then
            ---无人上榜
        else
            local RankConfigData = RankingListManager:GetRankConfigData(RankID);
            if RankConfigData then
                for Index, Data in pairs(RankList) do
                    if self.AllUIDList[Data.uid] == nil then
                        self.AllUIDList[Data.uid] = true;
                        self.ProfileUIDList[#self.ProfileUIDList + 1] = Data.uid;
                        table.insert(NewUIDList, Data.uid);
                    end
                    self.AllRankListData.RankData[RankID][RankingCycles][Data.rank] = {
                        UID = Data.uid,
                        Rank = Data.rank,
                        Score = Data.total_score,
                    };
                    RankListData.RankData[RankID][RankingCycles][Data.rank] = {
                        UID = Data.uid,
                        Rank = Data.rank,
                        Score = Data.total_score,
                    }
                end
                self.AllRankListData.MyRank[RankID][RankingCycles] = {
                    Rank = MyRankData.rank_no,
                    Score = MyRankData.score or 0,
                };
                RankListData.MyRank[RankID][RankingCycles] = {
                    Rank = MyRankData.rank_no,
                    Score = MyRankData.score or 0,
                }
            end
        end
        self.LastGetRankTime = UGCGameSystem.GetServerTimeSec();
    end
    --- 等待所有排行榜的数据都拉取完毕之后再同步数据
    local IsRequsetOver = true;
    self.RequestAllRankListState[RankID][RankingCycles] = true;
    for RankID, Data in pairs(self.RequestAllRankListState) do
        for ImageVal, State in pairs(Data) do
            if State == false then
                IsRequsetOver = false;
            end
        end
    end
    print(string.format("[RankingListComponent] IsRequsetOver: %s", tostring(IsRequsetOver)));
    UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncAllRankListData", RankListData, RankID, RankingCycles, StartIdx, Count, IsRequsetOver);
    local UIDNum = #NewUIDList;
    if UIDNum > 0 then
        if UIDNum > 50 then
            local ChunkSize = 50;
            local Res = self:SplitTableByChunk(NewUIDList, ChunkSize);
            for Idx, List in pairs(Res) do
                UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncProfileUIDList", List);
                if not self:IsPIE() then
                    self:GetAllPrivacyState(List);
                end
            end
        else
            UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncProfileUIDList", NewUIDList);
            if not self:IsPIE() then
                self:GetAllPrivacyState(NewUIDList);
            end
        end
    end
end

function RankingListComponent:RequestRankListDataOtherRsp(RequestMsg)
    log_tree("[RankingListComponent] RequestRankListDataOtherRsp RequestMsg:", RequestMsg);
end

--更新排行榜分数
--生效范围：客户端&&服务端
---@param UID number
---@param RankID number
---@param Score number
function RankingListComponent:UpdateRankingListScore(UID, RankID, Score)
    UID = tonumber(UID);
    print(string.format("[RankingListComponent] UpdateRankingListScore UID: %d RankID: %d Score: %d", UID or -1, RankID or -1, Score or -1));
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        --- 服务端直接调用
        self:Server_UpdateRankListScore(PlayerController, UID, RankID, Score);
    else
        --- 客户端发送RPC
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_UpdateRankListScore", PlayerController, UID, RankID, Score);
    end
end

--更新排行榜分数
--生效范围：服务端
---@param PlayerController BP_UGCPlayerController_C
---@param UID number
---@param RankID number
---@param Score number
function RankingListComponent:Server_UpdateRankListScore(PlayerController, UID, RankID, Score)
    print(string.format("[RankingListComponent] Server_UpdateRankListScore RankID: %d Score: %d", RankID or -1, Score or -1))
    if PlayerController:HasAuthority() == false then
        return;
    end
    if self:IsPIE() then
        --- 判断是否在榜单上
        local IsInRank = false;
        -- log_tree("[RankingListComponent] Server_UpdateRankListScore AllRankListData: ", self.AllRankListData);
        for Rank, RankData in pairs(self.AllRankListData.RankData[RankID][0]) do
            if RankData.UID == UID then
                IsInRank = true;
                RankData.Score = Score;
                break;
            end
        end

        local RankNum = #self.AllRankListData.RankData[RankID][0];
        if IsInRank == false then
            table.insert(self.AllRankListData.RankData[RankID][0], {UID = UID, Rank = RankNum + 1, Score = Score});
        end

        --- 排序
        table.sort(self.AllRankListData.RankData[RankID][0], function(a, b)
            local RankInfo = RankingListManager:GetRankConfigData(RankID);
            if RankInfo.SortType == ERankListSortType.LargeValuePrefer then
                return a.Score > b.Score;
            elseif RankInfo.SortType == ERankListSortType.SmallValuePrefer then
                return a.Score < b.Score
            end
        end)

        --- 更新排名
        for Rank, RankData in pairs(self.AllRankListData.RankData[RankID][0]) do
            self.AllRankListData.RankData[RankID][0][Rank].Rank = Rank;
        end

        --- 限制上榜人数
        local SelfUID = self:GetSelfUID();
        local RankInfo = RankingListManager:GetRankConfigData(RankID);
        if RankInfo then
            local PeopleNum = RankInfo.PeopleNum;
            local NewRankNum = #self.AllRankListData.RankData[RankID][0];
            for Rank, RankData in pairs(self.AllRankListData.RankData[RankID][0]) do
                if RankData.UID == SelfUID then
                    self.AllRankListData.MyRank[RankID][0].Score = RankData.Score;
                    if Rank > PeopleNum then
                        self.AllRankListData.MyRank[RankID][0].Rank = -1;
                    else
                        self.AllRankListData.MyRank[RankID][0].Rank = Rank;
                    end
                    break;
                end
            end

            if NewRankNum > PeopleNum then
                for Idx = PeopleNum + 1, NewRankNum do
                    self.AllRankListData.RankData[RankID][0][Idx] = nil;
                end
            end
        end

        if self.AllUIDList[UID] == nil then
            self.AllUIDList[UID] = true;
            self.ProfileUIDList[#self.ProfileUIDList + 1] = UID;
        end
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncAllRankListData", self.AllRankListData);
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncProfileUIDList", self.ProfileUIDList);
        RankingListManager:UpdateAllClientRankListData(true, UID, RankID, Score);
    else
        --- 向后台发送协议
        if UE.IsValid(self:GetRankingListPlayerComponent()) then
            self:GetRankingListPlayerComponent():UpdateRankingListScore(UID, RankID, Score)
        end
    end
end

--更新排行榜分数回调
--生效范围：客户端&&服务端
---@param RequestMsg any
function RankingListComponent:UpdateRankListRsp(RequestMsg)
    log_tree("[RankingListComponent] UpdateRankListRsp RequestMsg:", RequestMsg);
end

--上传隐私设置
--生效范围：客户端
---@param State number
function RankingListComponent:SetPrivacyState(State)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        return;
    end
    print(string.format("[RankingListComponent] SetPrivacyState State: %d", State or -1));
    local UID = self:GetSelfUID();
    UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_UploadPrivacySetting", UID, State);
end

--上传隐私设置
--生效范围：服务端
---@param UID number
---@param State number
function RankingListComponent:Server_UploadPrivacySetting(UID, State)
    if self:GetOwner():HasAuthority() == false then
        return;
    end

    if UE.IsValid(self:GetRankingListPlayerComponent()) then
        self:GetRankingListPlayerComponent():SetRankListPrivacy(UID, State);
    end
end

--上传隐私设置回调
--生效范围：客户端&&服务端
function RankingListComponent:SetRankListPrivacyRsp(RequestMsg)
    log_tree("[RankingListComponent] SetRankListPrivacyRsp RequestMsg:", RequestMsg);
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return;
    end
    if RequestMsg.bSuccess == true then
        local UID = RequestMsg.UID or -1;
        local State = RequestMsg.State or 0;
        self.PrivacySetting[UID] = State;
        _G.DOREPONCE(self, "PrivacySetting");
    end
end

--批量获取隐私设置
--生效范围：服务端
---@param TargetUIDList any
function RankingListComponent:GetAllPrivacyState(TargetUIDList)
    if self:GetOwner():HasAuthority() == false then
        return;
    end
    if UE.IsValid(self:GetRankingListPlayerComponent()) then
        self:GetRankingListPlayerComponent():GetRankListPrivacy(TargetUIDList);
    end
end

--批量获取隐私设置回调
--生效范围：客户端&&服务端
---@param RequestMsg any
function RankingListComponent:GetRankListPrivacyRsp(RequestMsg)
    log_tree("[RankingListComponent] GetRankListPrivacyRsp RequestMsg:", RequestMsg);
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return;
    end
    if RequestMsg.bSuccess == true then
        local Result = RequestMsg.Result or {};
        for UID, State in pairs(Result) do
            self.PrivacySetting[UID] = State;
        end
        _G.DOREPONCE(self, "PrivacySetting");
    end
end

--DS向Client发送Rpc同步排行榜数据
--生效范围：客户端
---@param AllRankListData any
function RankingListComponent:Client_SyncAllRankListData(AllRankListData, RankID, RankingCycles, StartIdx, Count, IsRequsetOver)
    -- log_tree("[RankingListComponent] Client_SyncAllRankListData Before: ", AllRankListData);
    if self:IsPIE() then
        self.AllRankListData = AllRankListData;
        if self.RankingListMainUI and self.RankingListMainUI.SelectedRankID then
            self.RankingListMainUI:SelectRank(self.RankingListMainUI.SelectedRankID, true)
        end
    else
        if StartIdx ~= nil and Count ~= nil and IsRequsetOver ~= nil then
            for i = StartIdx, StartIdx + Count - 1 do
                if self.AllRankListData.RankData[RankID] == nil then
                    self.AllRankListData.RankData[RankID] = {};
                end
                if self.AllRankListData.RankData[RankID][RankingCycles] == nil then
                    self.AllRankListData.RankData[RankID][RankingCycles] = {};
                end
                self.AllRankListData.RankData[RankID][RankingCycles][i] = AllRankListData.RankData[RankID][RankingCycles][i];
            end
            if self.AllRankListData.MyRank[RankID] == nil then
                self.AllRankListData.MyRank[RankID] = {};
            end
            self.AllRankListData.MyRank[RankID][RankingCycles] = AllRankListData.MyRank[RankID][RankingCycles];
            -- log_tree("[RankingListComponent] Client_SyncAllRankListData After: ", self.AllRankListData);
            if IsRequsetOver then
                if self.RankingListMainUI and self.RankingListMainUI.SelectedRankID then
                    self.RankingListMainUI:SelectRank(self.RankingListMainUI.SelectedRankID, true)
                end
            end
        end
    end
end

--Client向DS请求ProfileUIDList
--生效范围：服务端
function RankingListComponent:Server_RequestProfileUIDList()
    local PlayerController = self:GetOwner();
    -- log_tree("[RankingListComponent] Server_RequestProfileUIDList ProfileUIDList", self.ProfileUIDList);
    local UIDNum = #self.ProfileUIDList;
    if UIDNum > 0 then
        if UIDNum > 50 then
            local ChunkSize = 50;
            local Res = self:SplitTableByChunk(self.ProfileUIDList, ChunkSize);
            for Idx, List in pairs(Res) do
                UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncProfileUIDList", List);
            end
        else
            UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncProfileUIDList", self.ProfileUIDList);
        end
    end
end

--DS向Client发送Rpc同步UIDList
--生效范围：客户端
---@param ProfileUIDList any
function RankingListComponent:Client_SyncProfileUIDList(UIDList)
    -- log_tree("[RankingListComponent] Client_SyncProfileUIDList UIDList: ", UIDList);
    if UIDList and #UIDList > 0 then
        local RankList = RankingListManager:GetLegalRankListTableData();
        if RankList then
            for Idx, Data in pairs(RankList) do
                self:GetProfileList(UIDList, Data.ID);
            end
        end
    end
end

------------------------------------------------------------获取数据相关------------------------------------------------------------
--获取排行榜排名数据
--生效范围：客户端&&服务端
---@param RankID number
---@param ImageVal number
---@return any
function RankingListComponent:GetRankListData(RankID, ImageVal)
    -- log_tree("[RankingListComponent] GetRankListData: ", self.AllRankListData);
    if self.AllRankListData and self.AllRankListData.RankData and self.AllRankListData.RankData[RankID] and self.AllRankListData.RankData[RankID][ImageVal] then
        return self.AllRankListData.RankData[RankID][ImageVal];
    end
    return {};
end

--获取当前玩家的排名数据
--生效范围：客户端&&服务端
---@param RankID number
---@param ImageVal number
---@return any
function RankingListComponent:GetMyRankData(RankID, ImageVal)
    -- log_tree("[RankingListComponent] GetMyRankData: ", self.AllRankListData);
    if self.AllRankListData and self.AllRankListData.MyRank and self.AllRankListData.MyRank[RankID] and self.AllRankListData.MyRank[RankID][ImageVal] then
        return self.AllRankListData.MyRank[RankID][ImageVal];
    end
    return {Rank = -1, Score = 0};
end

--获取全部排行榜排名数据
--生效范围：客户端&&服务端
---@return any
function RankingListComponent:GetAllRankListData()
    -- log_tree("[RankingListComponent] GetAllRankListData: ", self.AllRankListData);
    return self.AllRankListData;
end

--获取玩家账号信息
--生效范围：客户端
---@param UIDList any
---@param RankID number
function RankingListComponent:GetProfileList(UIDList, RankID)
    if self.AllUIDProfileData[RankID] == nil then
        self.AllUIDProfileData[RankID] = {};
    end
    if UE.IsValid(self:GetRankingListPlayerComponent()) and UIDList then
        self:GetRankingListPlayerComponent():GetProfileDataList(UIDList, RankID, function(ProfileDataList)
            if ProfileDataList == nil then
                print(string.format("[RankingListComponent] GetProfileList ProfileDataList is Nil"));
                return;
            end
            for UID, ProfileData in pairs(ProfileDataList) do
                self.AllUIDProfileData[RankID][UID] = {UID = UID, PlayerName = ProfileData.PlayerName, PicUrl = ProfileData.PicUrl, IsAnonymous = ProfileData.IsAnonymous};
            end
            -- log_tree("[RankingListComponent] GetProfileList:", self.AllUIDProfileData);
            if self.RankingListMainUI then
                self.RankingListMainUI:SetAllRankListData(self.AllRankListData);
            end
        end)
    end
end

--通过玩家UID获取账号信息
--生效范围：客户端
---@param RankID number
---@param UID number
---@return any
function RankingListComponent:GetProfileDataByUID(RankID, UID)
    if self.AllUIDProfileData[RankID] and self.AllUIDProfileData[RankID][UID] then
        log_tree("[RankingListComponent] GetProfileDataByUID:", self.AllUIDProfileData[RankID][UID]);
        return self.AllUIDProfileData[RankID][UID];
    end
    return {};
end

--获取当前玩家的隐私配置
--生效范围：客户端&&服务端
function RankingListComponent:GetSelfPrivacySetting()
    local SelfUID = self:GetSelfUID();
    return self:GetPrivacySettingByUID(SelfUID);
end

--通过玩家UID获取隐私配置
--生效范围：客户端&&服务端
---@param UID number
---@return number
function RankingListComponent:GetPrivacySettingByUID(UID)
    print(string.format("[RankingListComponent] GetPrivacySettingByUID UID: %d", UID or -1))
    if self.PrivacySetting[UID] then
        -- log_tree("[RankingListComponent] PrivacySetting: ", self.PrivacySetting);
        return self.PrivacySetting[UID];
    end
    return 0;
end

--获取当前玩家的UID
--生效范围：客户端&&服务端
---@return number
function RankingListComponent:GetSelfUID()
    if self.PlayerAccountInfo and self.PlayerAccountInfo.UID then
        print(string.format("[RankingListComponent] SelfUID: %d", self.PlayerAccountInfo.UID));
        return self.PlayerAccountInfo.UID;
    end
    return 0;
end

--获取已拥有的道具数量
--生效范围：客户端&&服务端
---@param ItemID number
---@return number
function RankingListComponent:GetItemNum(ItemID)
    if UE.IsValid(self:GetVirtualItemManager()) then
        local PlayerController = self:GetOwner();
        return self:GetVirtualItemManager():GetItemNum(ItemID, PlayerController); 
    end
    return 0;
end

--通过PlayerController获取排行榜排名信息
--生效范围：客户端&&服务端
---@param PlayerController BP_UGCPlayerController_C
---@param RankID number
---@param RankingCycles number
---@return number, number
function RankingListComponent:GetPlayerRankingData(PlayerController, RankID, RankingCycles)
    local UID = PlayerController:GetCurPlayerState().UID;
    local SelfUID = self:GetSelfUID();
    if UID == SelfUID then
        if self.AllRankListData and self.AllRankListData.MyRank and self.AllRankListData.MyRank[RankID] and self.AllRankListData.MyRank[RankID][RankingCycles] then
            local Rank = self.AllRankListData.MyRank[RankID][RankingCycles].Rank;
            local Score = self.AllRankListData.MyRank[RankID][RankingCycles].Score;
            return Rank, Score;
        end
    else
        if self.AllRankListData and self.AllRankListData.RankData and self.AllRankListData.RankData[RankID] and self.AllRankListData.RankData[RankID][RankingCycles] then
            for Index, RankData in ipairs(self.AllRankListData.RankData[RankID][RankingCycles]) do
                if RankData.UID == UID then
                    return RankData.Rank, RankData.Score;
                end
            end
        end
    end
    return -1, 0;
end

------------------------------------------------------------排行榜奖励相关------------------------------------------------------------
--领取排行榜奖励
--生效范围：客户端
---@param RankID number
---@param Rank number
function RankingListComponent:ReceiveRankListAward(RankID, Rank)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        return; 
    end

    UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_ReceiveRankListAward", PlayerController, RankID, Rank);
end

--领取排行榜奖励
--生效范围：服务端
---@param PlayerController BP_UGCPlayerController_C
---@param RankID number
---@param Rank number
---@return boolean
function RankingListComponent:Server_ReceiveRankListAward(PlayerController, RankID, Rank)
    if PlayerController:HasAuthority() == false then
        return;
    end
    
    local AwardList = RankingListManager:GetAwardList(RankID, Rank);
    if next(AwardList) ~= nil then
        local RankListData = RankingListManager:GetRankConfigData(RankID);
        if RankListData then
            local CurTime = UGCGameSystem.GetServerTimeSec();
            local CurDate = os.date("*t", CurTime);
            local CanSign = false;

            ---服务器上再判断一次是否可以领取奖励
            local AwardState = self:CheckAwardCanSign(RankID) or UGCRankingListAwardState.Lock;
            print(string.format("[RankingListComponent] Server_ReceiveRankListAward AwardState: %d", AwardState));
            if AwardState == UGCRankingListAwardState.CanSign then
                self.LastReceiveRankID = RankID;
                local Result = self:AddItems(AwardList);
                self:AddRankListAwardsDelegate(Result);
                UnrealNetwork.CallUnrealRPC(PlayerController, self, "AddRankListAwardsDelegate", Result);
                return Result;
            end
        end
    end
    self:AddRankListAwardsDelegate(false);
    UnrealNetwork.CallUnrealRPC(PlayerController, self, "AddRankListAwardsDelegate", false);
    return false;
end

--判断是否可以领取奖励
--生效范围：客户端&&服务端
---@param RankID number
---@return UGCRankingListAwardState
function RankingListComponent:CheckAwardCanSign(RankID)
    local Rank = -1;
    local ImageVal = 1;
    local RankListData = RankingListManager:GetRankConfigData(RankID);
    if RankListData == nil then
        print(string.format("[RankingListComponent] RankID: %d Data Is Nil", RankID or -1));
        return UGCRankingListAwardState.Lock;
    end

    if self.AllRankListData and self.AllRankListData.MyRank and self.AllRankListData.MyRank[RankID] then
        if RankListData.PeriodType == ERankListPeriodType.NotReset then
            if self.AllRankListData.MyRank[RankID][0] and self.AllRankListData.MyRank[RankID][0].Rank then
                Rank = self.AllRankListData.MyRank[RankID][0].Rank;
                ImageVal = 0;
            end
        else
            if self.AllRankListData.MyRank[RankID][1] and self.AllRankListData.MyRank[RankID][1].Rank then
                Rank = self.AllRankListData.MyRank[RankID][1].Rank;
                ImageVal = 1;
            end
        end
    end

    local AwardList = RankingListManager:GetAwardList(RankID, Rank);
    if next(AwardList) == nil then
        print(string.format("[RankingListComponent] RankID: %d AwardList Is Nil", RankID or -1));
        return UGCRankingListAwardState.Lock;
    end

    if RankListData then
        if ImageVal == 0 and RankListData.PeriodType ~= ERankListPeriodType.NotReset then
            return UGCRankingListAwardState.Lock;
        end

        local CurTime = UGCGameSystem.GetServerTimeSec();
        local CurDate = os.date("*t", CurTime);
        print(string.format("[RankingListComponent] CurTime: %d", CurTime));
        if self.RankListAwardState[RankID] then
            if RankListData.PeriodType == ERankListPeriodType.DailyReset then
                ---结算时间为每天的23.59.59, 所以
                if CurTime - self.RankListAwardState[RankID] >= 24 * 60 * 60 then
                    return UGCRankingListAwardState.CanSign;
                end
            elseif RankListData.PeriodType == ERankListPeriodType.WeeklyReset then
                if CurTime - self.RankListAwardState[RankID] >= 7 * 24 * 60 * 60 then
                    return UGCRankingListAwardState.CanSign;
                end
            elseif RankListData.PeriodType == ERankListPeriodType.MonthlyReset then
                local MonthDay = os.date("%d", os.time({year=CurDate.year, month=CurDate.month+1, day=0}))
                if CurTime - self.RankListAwardState[RankID] >= MonthDay * 24 * 60 * 60 then
                    return UGCRankingListAwardState.CanSign;
                end
            end
    
            return UGCRankingListAwardState.HasGot;
        else
            ---需要去判断是否结算过一次
            if RankListData.PeriodType == ERankListPeriodType.DailyReset then
                --- 到达开始时间的下一天
                local BeginTimeStamp = RankListData.BeginDate:ToUnixTimestamp();
                local BeginDate = os.date("*t", BeginTimeStamp);
                local RefreshTimeStamp = os.time({year=BeginDate.year, month=BeginDate.month, day=BeginDate.day + 1, hour=0, min=0, sec=0});
                if CurTime > RefreshTimeStamp then
                    return UGCRankingListAwardState.CanSign;
                end
            elseif RankListData.PeriodType == ERankListPeriodType.WeeklyReset then
                --- 到达开始时间的下一周
                local BeginTimeStamp = RankListData.BeginDate:ToUnixTimestamp();
                local BeginDate = os.date("*t", BeginTimeStamp);
                local WeekDay = tonumber(os.date("%w", BeginTimeStamp));
                local Offset = (WeekDay - 1) % 7;
                local RefreshTimeStamp = os.time({year=BeginDate.year, month=BeginDate.month, day=BeginDate.day - Offset + 7, hour=0, min=0, sec=0});
                if CurTime > RefreshTimeStamp then
                    return UGCRankingListAwardState.CanSign;
                end
            elseif RankListData.PeriodType == ERankListPeriodType.MonthlyReset then
                --- 到达开始时间的下个月
                local BeginTimeStamp = RankListData.BeginDate:ToUnixTimestamp();
                local BeginDate = os.date("*t", BeginTimeStamp);
                local RefreshTimeStamp = os.time({year=BeginDate.year, month=BeginDate.month+1, day=1, hour=0, min=0, sec=0});
                if CurTime > RefreshTimeStamp then
                    return UGCRankingListAwardState.CanSign;
                end
            elseif RankListData.PeriodType == ERankListPeriodType.NotReset then
                if CurTime >= RankListData.SettleDate:ToUnixTimestamp() then
                    return UGCRankingListAwardState.CanSign;
                end
            end
            return UGCRankingListAwardState.Lock;
        end
    end
end

--添加道具 
--生效范围：服务端
---@param AwardList any
---@return boolean
function RankingListComponent:AddItems(AwardList)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return false;
    end

    if UE.IsValid(self:GetVirtualItemManager()) then
        return self:GetVirtualItemManager():AddVirtualItems(PlayerController, AwardList);
    end
    return false;
end

---添加道具回调
--生效范围：服务端
---@param Result any
function RankingListComponent:OnAddVirtualItem(Result)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return; 
    end
    local bSucceeded = Result.bSucceeded;
    local ItemList = Result.ItemList;
    local PlayerKey = Result.PlayerKey;
    local SelfPlayerKey = PlayerController:GetInt64PlayerKey();
    print(string.format("[RankingListComponent] OnAddVirtualItem PlayerKey: %d SelfPlayerKey: %d", PlayerKey, SelfPlayerKey));
    if bSucceeded and PlayerKey == SelfPlayerKey then
        local RankID = self.LastReceiveRankID;
        local RankListData = RankingListManager:GetRankConfigData(RankID);
        if RankListData then
            local CurTime = UGCGameSystem.GetServerTimeSec();
            local CurDate = os.date("*t", CurTime);
            if UE.IsValid(self:GetRankingListPlayerComponent()) then
                local PlayerData = self:GetRankingListPlayerComponent():ReadPlayerData();
                if PlayerData.AwardState[RankID] == nil then
                    if RankListData.PeriodType == ERankListPeriodType.DailyReset then
                        local SettleTime = os.time({year=CurDate.year, month=CurDate.month, day=CurDate.day, hour=0, min=0, sec=0});
                        PlayerData.AwardState[RankID] = SettleTime;
                    elseif RankListData.PeriodType == ERankListPeriodType.WeeklyReset then
                        local WeekDay = tonumber(os.date("%w", CurTime));
                        local Offset = (WeekDay - 1) % 7;
                        local SettleTime = os.time({year=CurDate.year, month=CurDate.month, day=CurDate.day - Offset, hour=0, min=0, sec=0});
                        PlayerData.AwardState[RankID] = SettleTime;
                    elseif RankListData.PeriodType == ERankListPeriodType.MonthlyReset then
                        local SettleTime = os.time({year=CurDate.year, month=CurDate.month, day=1, hour=0, min=0, sec=0});
                        PlayerData.AwardState[RankID] = SettleTime;
                    elseif RankListData.PeriodType == ERankListPeriodType.NotReset then
                        PlayerData.AwardState[RankID] = RankListData.SettleDate:ToUnixTimestamp();
                    end
                else
                    if RankListData.PeriodType == ERankListPeriodType.DailyReset then
                        if CurTime - PlayerData.AwardState[RankID] >= 24 * 60 * 60 then
                            local SettleTime = os.time({year=CurDate.year, month=CurDate.month, day=CurDate.day, hour=0, min=0, sec=0});
                            PlayerData.AwardState[RankID] = SettleTime;
                        end
                    elseif RankListData.PeriodType == ERankListPeriodType.WeeklyReset then
                        if CurTime - PlayerData.AwardState[RankID] >= 7 * 24 * 60 * 60 then
                            local WeekDay = tonumber(os.date("%w", CurTime));
                            local Offset = (WeekDay - 1) % 7;
                            local SettleTime = os.time({year=CurDate.year, month=CurDate.month, day=CurDate.day - Offset, hour=0, min=0, sec=0});
                            PlayerData.AwardState[RankID] = SettleTime;
                        end
                    elseif RankListData.PeriodType == ERankListPeriodType.MonthlyReset then
                        local MonthDay = os.date("%d", os.time({year=CurDate.year, month=CurDate.month, day=0}))
                        if CurTime - PlayerData.AwardState[RankID] >= MonthDay * 24 * 60 * 60 then
                            local SettleTime = os.time({year=CurDate.year, month=CurDate.month, day=1, hour=0, min=0, sec=0});
                            PlayerData.AwardState[RankID] = SettleTime;
                        end
                    end
                end
                self:GetRankingListPlayerComponent():WritePlayerData(PlayerData);
                self.RankListAwardState = PlayerData.AwardState;
                _G.DOREPONCE(self, "RankListAwardState");
            end

            self.LastReceiveRankID = 0;
            local AwardList = {};
            for ItemID, ItemNum in pairs(ItemList) do
                table.insert(AwardList, {ItemID = ItemID, ItemNum = ItemNum});
            end
            UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_ItemGet", AwardList);
        end
    end
end


------------------------------------------------------------UI相关------------------------------------------------------------
--预加载UI
--生效范围：客户端
function RankingListComponent:PreLoadUI()
    local PlayerController = self:GetOwner();
    Common.LoadObjectWithSoftPathAsync(self.RankingListMainUIPath, function(Object)
        if self ~= nil and Object ~= nil then
            self.RankingListMainUI = UserWidget.NewWidgetObjectBP(PlayerController, Object);
            self.RankingListMainUI:AddToViewport(10000);
            self.RankingListMainUI:SetVisibility(ESlateVisibility.Collapsed);
        end
    end)
    Common.LoadObjectWithSoftPathAsync(self.RankingListUnnamedUIPath, function(Object)
        if self ~= nil and Object ~= nil then
            self.RankingListUnnamedUI = UserWidget.NewWidgetObjectBP(PlayerController, Object);
            self.RankingListUnnamedUI:AddToViewport(15000);
            self.RankingListUnnamedUI:SetVisibility(ESlateVisibility.Collapsed);
        end
    end)
    Common.LoadObjectWithSoftPathAsync(self.RankingListExplanationUIPath, function(Object)
        if self ~= nil and Object ~= nil then
            self.RankingListExplanationUI = UserWidget.NewWidgetObjectBP(PlayerController, Object);
            self.RankingListExplanationUI:AddToViewport(15000);
            self.RankingListExplanationUI:SetVisibility(ESlateVisibility.Collapsed);
        end
    end)
    Common.LoadObjectWithSoftPathAsync(self.RankingListItemGetUIPath, function(Object)
        if self ~= nil and Object ~= nil then
            self.RankingListItemGetUI = UserWidget.NewWidgetObjectBP(PlayerController, Object);
            self.RankingListItemGetUI:AddToViewport(15000);
            self.RankingListItemGetUI:SetVisibility(ESlateVisibility.Collapsed);
        end
    end)
    Common.LoadObjectWithSoftPathAsync(self.RankingListBtnUIPath, function(Object)
        if self ~= nil and Object ~= nil then
            self.RankingListBtn = UserWidget.NewWidgetObjectBP(PlayerController, Object);
            self.RankingListBtn:AddToViewport(1000);
            self.RankingListBtn:InitUI();
            local RankList = RankingListManager:GetLegalRankListTableData();
            if RankList and next(RankList) ~= nil then
                self.RankingListBtn:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
            else
                self.RankingListBtn:SetVisibility(ESlateVisibility.Collapsed);
            end
        end
    end)
end

--打开排行榜主界面
--生效范围：客户端
function RankingListComponent:OpenRankingList()
    if self.RankingListMainUI then
        self.RankingListMainUI:InitUI();
        self.RankingListMainUI:SetVisibility(ESlateVisibility.SelfHitTestInvisible);        
    end
end

--打开隐私设置界面
--生效范围：客户端
function RankingListComponent:OpenUnnamedUI()
    if self.RankingListUnnamedUI then
        self.RankingListUnnamedUI:InitUI();
        self.RankingListUnnamedUI:SetVisibility(ESlateVisibility.SelfHitTestInvisible);        
    end
end

--打开说明界面
--生效范围：客户端
function RankingListComponent:OpenExplanationUI()
    if self.RankingListExplanationUI then
        self.RankingListExplanationUI:SetVisibility(ESlateVisibility.SelfHitTestInvisible);        
    end
end

--选择排行榜
--生效范围：客户端
---@param RankID number
function RankingListComponent:SelectRank(RankID)
    if self.RankingListMainUI ~= nil then
        self.RankingListMainUI:SelectRank(RankID);
    end
end

--显示道具提示
--生效范围：客户端
---@param ItemID number
---@param Position any
function RankingListComponent:ShowItemTip(ItemID, Position)
    if self.RankingListMainUI ~= nil then
        self.RankingListMainUI:ShowItemTip(ItemID, Position);
    end
end

--显示获得道具界面并刷新红点
--生效范围：客户端
---@param ItemList any
function RankingListComponent:Client_ItemGet(ItemList)
    if self:GetOwner():HasAuthority() == true then
        return;
    end
    if self.RankingListItemGetUI then
        self.RankingListItemGetUI:InitUI(ItemList);
        self.RankingListItemGetUI:SetVisibility(ESlateVisibility.SelfHitTestInvisible);        
    end
    self:RefreshAllRedPoint();
end

--关闭排行榜界面及入口
--生效范围：客户端
function RankingListComponent:CloseRankList()
    if self.RankingListBtn then
         self.RankingListBtn:SetVisibility(ESlateVisibility.Collapsed);
    end
    if self.RankingListMainUI then
        self.RankingListMainUI:SetVisibility(ESlateVisibility.Collapsed);
    end
end

--显示举报按钮
--生效范围：客户端
---@param Index number
function RankingListComponent:OpenReportBtn(Index)
    if self.RankingListMainUI then
        self.RankingListMainUI:OpenReportBtn(Index);
    end
end

--刷新整个排行榜的红点
--生效范围：客户端
function RankingListComponent:RefreshAllRedPoint()
    if self.RankingListBtn then
        self.RankingListBtn:RefreshRedPoint();
    end
    if self.RankingListMainUI then
        self.RankingListMainUI:RefreshRedPoint();
    end
end

--获取前三名的排名图标
--生效范围：客户端
---@param Rank number
---@return string
function RankingListComponent:GetRankPic(Rank)
    print(string.format("[RankingListComponent] GetRankPic Rank: %d", Rank));
    if Rank == 1 then
        return self.GoldIconPath.AssetPathName;
    elseif Rank == 2 then
        return self.SilverIconPath.AssetPathName;
    elseif Rank == 3 then
        return self.CopperIconPath.AssetPathName;
    end

    return nil;
end

------------------------------------------------------------其他接口------------------------------------------------------------
--清空排行榜信息(仅PIE使用)
--生效范围：客户端
function RankingListComponent:ClearAllRankListData()
    local PlayerController = self:GetOwner();
    UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_ClearAllRankListData");
end

--清空排行榜信息(仅PIE使用)
--生效范围：服务端
function RankingListComponent:Server_ClearAllRankListData()
    if self:IsPIE() then
        self.AllRankListData = {
            RankData = {},
            MyRank = {},
        };
        self:ResetAllRankListData();
        local PlayerController = self:GetOwner();
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncAllRankListData", self.AllRankListData);
        RankingListManager:UpdateAllClientRankListData(false);
    end
end

--判断是否处于PIE环境下
--生效范围：客户端&&服务端
---@return boolean
function RankingListComponent:IsPIE()
    local PlayerController = self:GetOwner();
    return UGCBlueprintFunctionLibrary.IsUGCPIE(PlayerController);
end

--PIE时客户端修改排名数据后同步下来的数据
--生效范围：客户端
---@param IsUpdate boolean
---@param UID number
---@param RankID number
---@param Score number
function RankingListComponent:UpdateLocalRankListData(IsUpdate, UID, RankID, Score)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        return;
    end
    UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_UpdateLocalRankListData", IsUpdate, UID, RankID, Score);
end

--PIE时客户端修改排名数据后同步下来的数据
--生效范围：服务端
---@param IsUpdate boolean
---@param UID number
---@param RankID number
---@param Score number
function RankingListComponent:Server_UpdateLocalRankListData(IsUpdate, UID, RankID, Score)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == false then
        return;
    end
    if self:IsPIE() then
        if IsUpdate then
            --- 判断是否在榜单上
            local IsInRank = false;
            -- log_tree("[RankingListComponent] Server_UpdateLocalRankListData: ", self.AllRankListData);
            for Rank, RankData in pairs(self.AllRankListData.RankData[RankID][0]) do
                if RankData.UID == UID then
                    IsInRank = true;
                    RankData.Score = Score;
                    break;
                end
            end

            local RankNum = #self.AllRankListData.RankData[RankID][0];
            if IsInRank == false then
                table.insert(self.AllRankListData.RankData[RankID][0], {UID = UID, Rank = RankNum + 1, Score = Score});
            end

            --- 排序
            table.sort(self.AllRankListData.RankData[RankID][0], function(a, b)
                local RankInfo = RankingListManager:GetRankConfigData(RankID);
                if RankInfo.SortType == ERankListSortType.LargeValuePrefer then
                    return a.Score > b.Score;
                elseif RankInfo.SortType == ERankListSortType.SmallValuePrefer then
                    return a.Score < b.Score;
                end
            end)

            --- 更新排名
            for Rank, RankData in pairs(self.AllRankListData.RankData[RankID][0]) do
                self.AllRankListData.RankData[RankID][0][Rank].Rank = Rank;
            end

            --- 限制上榜人数
            local SelfUID = self:GetSelfUID();
            local RankInfo = RankingListManager:GetRankConfigData(RankID);
            if RankInfo then
                local PeopleNum = RankInfo.PeopleNum;
                local NewRankNum = #self.AllRankListData.RankData[RankID][0];
                for Rank, RankData in pairs(self.AllRankListData.RankData[RankID][0]) do
                    if RankData.UID == SelfUID then
                        self.AllRankListData.MyRank[RankID][0].Score = RankData.Score;
                        if Rank > PeopleNum then
                            self.AllRankListData.MyRank[RankID][0].Rank = -1;
                        else
                            self.AllRankListData.MyRank[RankID][0].Rank = Rank;
                        end
                        break;
                    end
                end

                if NewRankNum > PeopleNum then
                    for Idx = PeopleNum + 1, NewRankNum do
                        self.AllRankListData.RankData[RankID][0][Idx] = nil;
                    end
                end
            end
        else
            self.AllRankListData = {
                RankData = {},
                MyRank = {},
            };
            self:ResetAllRankListData();
        end
        if self.AllUIDList[UID] == nil then
            self.AllUIDList[UID] = true;
            self.ProfileUIDList[#self.ProfileUIDList + 1] = UID;
        end
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncAllRankListData", self.AllRankListData);
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Client_SyncProfileUIDList", self.ProfileUIDList);
    end
end

--重置缓存的排行榜数据
--生效范围：客户端&&服务端
function RankingListComponent:ResetAllRankListData()
    local RankListTableData = RankingListManager:GetLegalRankListTableData();
    for Index, Data in pairs(RankListTableData) do
        self.AllRankListData.RankData[Data.ID] = {
            [0] = {},
            [1] = {},
        }
        self.AllRankListData.MyRank[Data.ID] = {
            [0] = {
                Rank = -1,
                Score = 0,
            },
            [1] = {
                Rank = -1,
                Score = 0,
            },
        }
    end
end

--发放排名奖励物资
--生效范围：客户端&&服务端
---@param PlayerController BP_UGCPlayerController_C
---@param RankID number
function RankingListComponent:AddRankListAwards(PlayerController, RankID)
    local Rank = self:GetPlayerRankingData(PlayerController, RankID, 1);
    if PlayerController:HasAuthority() == true then
        self:Server_ReceiveRankListAward(PlayerController, RankID, Rank);
    else
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_ReceiveRankListAward", PlayerController, RankID, Rank);
    end
end

--发放排名奖励物资回调
--生效范围：客户端&&服务端
---@param Success boolean
function RankingListComponent:AddRankListAwardsDelegate(Success)
    print(string.format("[RankingListComponent] AddRankListAwardsDelegate Success: %s", tostring(Success or false)));
    RankingListManager.OnAddAwardsDelegate(Success);
end

--拉取上榜的排行数据
--生效范围：客户端&&服务端
function RankingListComponent:RequestTopRankingListData()
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        self:Server_RequestAllRankListData(PlayerController);
    else
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_RequestAllRankListData", PlayerController);
    end
end

--拉取上榜的排行数据
--生效范围：客户端&&服务端
---@param RankID number
---@param StartIdx number
---@param Count number
---@param RankingCycles number
function RankingListComponent:RequestRankingListDataByRankID(RankID, StartIdx, Count, RankingCycles)
    local PlayerController = self:GetOwner();
    if PlayerController:HasAuthority() == true then
        self:Server_RequestRankListData(PlayerController, RankID, StartIdx, Count, RankingCycles);
    else
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_RequestRankListData", PlayerController, RankID, StartIdx, Count, RankingCycles);
    end
end

function RankingListComponent:GetVirtualItemManager()
    if self.VirtualItemManager == nil and UGCGamePartSystem.IsGamePartLoaded("VirtualItemManager") then
        self.VirtualItemManager = UGCGamePartSystem.GetGamePartGlobalActor("VirtualItemManager");
    end
    return self.VirtualItemManager;
end

function RankingListComponent:GetRankingListPlayerComponent()
    if self.RankingListPlayerComponent == nil and UGCGamePartSystem.IsGamePartLoaded("RankingListManager") then
        self.RankingListPlayerComponent = UGCGamePartSystem.GetGamePartPlayerComponent("RankingListManager", self:GetOwner(), "RankingList");
    end
    return self.RankingListPlayerComponent;
end

function RankingListComponent:SplitTableByChunk(Original, ChunkSize)
    local Res = {}
    local Total = #Original
    local Chunks = math.ceil(Total / ChunkSize)  --计算总组数
    
    for i = 1, Chunks do
        local StartIdx = (i - 1) * ChunkSize + 1
        local EndIdx = math.min(i * ChunkSize, Total)
        local Sub = {}
        table.move(Original, StartIdx, EndIdx, 1, Sub)  --从原表复制到子表
        Res[i] = Sub
    end
    return Res
end

return RankingListComponent
