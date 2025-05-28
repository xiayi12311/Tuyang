---@class BPWidget_PayLock_C:UUserWidget
---@field Button_PayLock UButton
---@field Image_0 UImage
--Edit Below--
local BPWidget_PayLock = { bInitDoOnce = false } 
UGCGameSystem.UGCRequire("ExtendResource.ShopV2.OfficialPackage.Script.ShopV2.ShopV2Manager")

function BPWidget_PayLock:Construct()
	self.Button_PayLock.OnReleased:Add(self.Button_PayLock_OnReleased, self);
end


-- function BPWidget_PayLock:Tick(MyGeometry, InDeltaTime)

-- end

-- function BPWidget_PayLock:Destruct()

-- end

function BPWidget_PayLock:Button_PayLock_OnReleased()
    ShopV2Manager:OpenMainUI(1)
end
return BPWidget_PayLock