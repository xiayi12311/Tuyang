local RaningListActor = {}
 
UGCGameSystem.UGCRequire("ExtendResource.RankingList.OfficialPackage." .. "Script.RankingList.RankingListManager");
function RaningListActor:ReceiveBeginPlay()
    RaningListActor.SuperClass.ReceiveBeginPlay(self);
    print("RankingListActor:ReceiveBeginPlay");
    RankingListManager:RegisterActor(self);
end

-- function RankActor:ReceiveTick(DeltaTime)
--     RankActor.SuperClass.ReceiveTick(self, DeltaTime)
-- end

function RaningListActor:ReceiveEndPlay()
    RaningListActor.SuperClass.ReceiveEndPlay(self) 
end

-- function RankActor:GetReplicatedProperties()
--     return
-- end

function RaningListActor:GetAvailableServerRPCs()
    return "UpdateLocalRankListData";
end

function RaningListActor:UpdateAllClientRankListData(IsUpdate, UID, RankID, Score)
    UnrealNetwork.CallUnrealRPC_Multicast(self, "UpdateLocalRankListData", IsUpdate, UID, RankID, Score);
end

function RaningListActor:UpdateLocalRankListData(IsUpdate, UID, RankID, Score)
    RankingListManager:UpdateLocalRankListData(IsUpdate, UID, RankID, Score);
end

return RaningListActor
