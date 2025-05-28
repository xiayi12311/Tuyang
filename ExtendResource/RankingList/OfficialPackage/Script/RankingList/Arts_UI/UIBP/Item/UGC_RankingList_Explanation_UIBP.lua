---@class UGC_RankingList_Explanation_UIBP_C:UUserWidget
---@field Button_0 UButton
---@field Button_CloseUI UButton
---@field Distance UImage
---@field MsgBox UCanvasPanel
---@field ScrollBox_0 UScrollBox
---@field TextBlock_WindowsTitle UTextBlock
---@field UGC_Common_UIPopupBG UGC_Common_UIPopupBG_C
---@field UGC_RankingList_PopupsBG_UIBP UGC_RankingList_PopupsBG_UIBP_C
---@field UTRichTextBlock_TipsContent UUTRichTextBlock
--Edit Below--
local UGC_RankingList_Explanation_UIBP = { bInitDoOnce = false } 

function UGC_RankingList_Explanation_UIBP:Construct()
    self:InitBindEvent();
end


-- function UGC_RankingList_Explanation_UIBP:Tick(MyGeometry, InDeltaTime)

-- end

-- function UGC_RankingList_Explanation_UIBP:Destruct()

-- end

function UGC_RankingList_Explanation_UIBP:InitBindEvent()
    self.Button_CloseUI.OnClicked:Add(self.Close, self)
end

function UGC_RankingList_Explanation_UIBP:Close()
    self:SetVisibility(ESlateVisibility.Collapsed);
end

return UGC_RankingList_Explanation_UIBP
