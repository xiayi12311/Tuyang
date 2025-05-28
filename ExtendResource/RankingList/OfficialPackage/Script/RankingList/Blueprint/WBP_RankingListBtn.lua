---@class WBP_RankingListBtn_C:UUserWidget
---@field ClearRankData UButton
---@field RankID UEditableTextBox
---@field Score UEditableTextBox
---@field UID UEditableTextBox
---@field UpdateRankScore UButton
--Edit Below--
local WBP_RankingListBtn = { bInitDoOnce = false } 

function WBP_RankingListBtn:Construct()
    self.UpdateRankScore.OnClicked:Add(self.UpdateRankListScore, self);
    self.ClearRankData.OnClicked:Add(self.ClearAllRankData, self);
end

function WBP_RankingListBtn:UpdateRankListScore()
    print("WBP_RankingListBtn:UpdateRankListScore");
    if self.RankID.Text == nil or self.RankID.Text == "" or self.Score.Text == nil or self.Score.Text == "" or self.UID.Text == nil or self.UID.Text == "" then
        return;
    end

    local RankID = tonumber(self.RankID.Text);
    local Score = tonumber(self.Score.Text);
    local UID = tonumber(self.UID.Text);
    local PlayerController = STExtraGameplayStatics.GetFirstPlayerController(self);
    RankingListManager:UpdatePlayerRankingScore(PlayerController, UID, RankID, Score);
end

function WBP_RankingListBtn:ClearAllRankData()
    RankingListManager:ClearAllRankListData();
end

return WBP_RankingListBtn
