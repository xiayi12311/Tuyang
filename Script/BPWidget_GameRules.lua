local BPWidget_GameRules = BPWidget_GameRules or {}

function BPWidget_GameRules:Construct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_GameRules:Construct] self=%s", GetObjectFullName_Dev(self)))

    BPWidget_GameRules.SuperClass.Construct(self)

    self:GetWidgetFromName("CloseButton").OnClicked:Add(function () self:RemoveFromViewport() end)
end

return BPWidget_GameRules