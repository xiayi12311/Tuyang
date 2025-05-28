local DependencyProperty = require("common.DependencyProperty")

local BPWidget_Summon = BPWidget_Summon or {}

BPWidget_Summon.BP_Summon = DependencyProperty.RecursivelyFromValue()

function BPWidget_Summon:Construct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Summon:Construct] self=%s", GetObjectFullName_Dev(self)))

    BPWidget_Summon.SuperClass.Construct(self)
    
    if self:GetOwningPlayer():IsLocalPlayerController() then -- dedicated server better
        self.HpProgressBar = self:GetWidgetFromName("HpProgressBar")
        self.BP_Summon:RegisterChanged(
            function (BP_Summon)
                if UE.IsValid(BP_Summon()) then
                    BP_Summon.CurrentHpChangedDelegate:Add(self.On_BP_Summon_CurrentHpChanged, self)
                    self:On_BP_Summon_CurrentHpChanged(BP_Summon())
                end
            end
        )
        self.BP_Summon:BroadcastChanged()
    end
end

function BPWidget_Summon:Destruct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Summon:Destruct] self=%s", GetObjectFullName_Dev(self)))
    
    self.BP_Summon:ClearValue()

    BPWidget_Summon.SuperClass.Destruct(self)
end

function BPWidget_Summon:On_BP_Summon_CurrentHpChanged(BP_Summon)
    self.HpProgressBar:SetPercent(BP_Summon.MaxHp > 0 and BP_Summon.CurrentHp / BP_Summon.MaxHp or 0)
end

return BPWidget_Summon