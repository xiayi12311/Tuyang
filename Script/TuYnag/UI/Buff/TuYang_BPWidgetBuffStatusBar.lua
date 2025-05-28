---@class TuYang_BPWidgetBuffStatusBar_C:UUserWidget
---@field Button_Details UButton
---@field HorizontalBox_StatusBar UHorizontalBox
--Edit Below--
local TuYang_BPWidgetBuffStatusBar = { bInitDoOnce = false } 

TuYang_BPWidgetBuffStatusBar.Details = nil
TuYang_BPWidgetBuffStatusBar.DetailsPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/TuYang_SkillDetails.TuYang_SkillDetails_C') 
TuYang_BPWidgetBuffStatusBar.KeyList = {}

function TuYang_BPWidgetBuffStatusBar:Construct()
    UGCLog.Log("TuYang_BPWidgetBuffStatusBar:Construct")
	self.Button_Details.OnClicked:Add(self.Button_Details_OnClicked,self)
    self:Button_Details_OnClicked()
    self.Details:Close()
end

-- function TuYang_BPWidgetBuffStatusBar:Tick(MyGeometry, InDeltaTime)

-- end

-- function TuYang_BPWidgetBuffStatusBar:Destruct()

-- end
function TuYang_BPWidgetBuffStatusBar:UpDataStatusBar(InKeyList)
    UGCLog.Log("TuYang_BPWidgetBuffStatusBar:UpDataStatusBar",InKeyList)
    self.KeyList = InKeyList
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    -- 清空所有的子控件
    if self.HorizontalBox_StatusBar then 
        self.HorizontalBox_StatusBar:ClearChildren() 
    end
    for k, v in pairs(InKeyList) do
        --UGCLog.Log("TuYang_BPWidgetBuffStatusBarUpDataStatusBar00")
        local BaseClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/TuYang_BPWidgetStatusBarIcon.TuYang_BPWidgetStatusBarIcon_C'))
        local BuffImage = LuaExtendLibrary.NewLuaObject(self, BaseClass)
        BuffImage.Key = v
        self.HorizontalBox_StatusBar:AddChild(BuffImage)
    end

end

function TuYang_BPWidgetBuffStatusBar:Button_Details_OnClicked()
    
    if self.Details == nil then
        self.Details = UGCWidgetManagerSystem.AddNewUI(self.DetailsPath,true)
    end
    self.Details:AddToViewport(self:GetZOrderOfViewportWidget() + 1)
    
    self.Details:SetAlreadyHaveBuff(self.KeyList)
    
    
end
return TuYang_BPWidgetBuffStatusBar