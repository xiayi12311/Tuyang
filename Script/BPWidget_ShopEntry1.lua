---@class BPWidget_ShopEntry1_C:UUserWidget
---@field ShopEntryButton UButton
--Edit Below--
local BPWidget_ShopEntry = {}

BPWidget_ShopEntry.BPWidget_Shop = nil


function BPWidget_ShopEntry:GetBPWidget_ShopEntryClassPath()
    return  string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_ShopEntry1.BPWidget_ShopEntry1_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPWidget_ShopEntry:GetBPWidget_ShopClassPath()
    return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_Shop1.BPWidget_Shop1_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPWidget_ShopEntry:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopEntry:Construct] self=%s", GetObjectFullName_Dev(self)))

    BPWidget_ShopEntry.SuperClass.Construct(self)
    self.ShopEntryButton = self:GetWidgetFromName("ShopEntryButton")
    self.ShopEntryButton.OnReleased:Add(self.On_ShopEntryButton_Released, self)
    
end

function BPWidget_ShopEntry:ReceiveTick(DeltaTime)
    BPWidget_ShopEntry.SuperClass.ReceiveTick(self, DeltaTime)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local isintheshop = PlayerController.PlayerState.IsInTheShop3
    if not isintheshop then
        self:CloseUI()
    end

end

function BPWidget_ShopEntry:Destruct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopEntry:Destruct] self=%s", GetObjectFullName_Dev(self)))
    BPWidget_ShopEntry.SuperClass.Destruct(self)
end

function BPWidget_ShopEntry:On_ShopEntryButton_Released()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopEntry:On_ShopEntryButton_Released] self=%s BPWidget_Shop=%s", GetObjectFullName_Dev(self), GetObjectFullName_Dev(self.BPWidget_Shop)))
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local isintheshop3 = PlayerController.PlayerState.IsInTheShop3

    --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
    if isintheshop3 then
        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            --local isintheshop = PlayerController.PlayerState.IsInTheShop
            if UE.IsValid(self.BPWidget_Shop) then
                self.BPWidget_Shop:RemoveFromViewport()
                self.BPWidget_Shop = nil
            else
                local PlayerController = GameplayStatics.GetPlayerController(self, 0)
                if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
                    local BPWidget_ShopClass = UE.LoadClass(self:GetBPWidget_ShopClassPath())
                    if UE.IsValid(BPWidget_ShopClass) then
                        self.BPWidget_Shop = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopClass)
                        if UE.IsValid(self.BPWidget_Shop) then
                            self.BPWidget_Shop:AddToViewport(10099)
                        end
                    end
                end
            end
        end
    end

end

function BPWidget_ShopEntry:CloseUI()
    --用于销毁商店界面
    if UE.IsValid(self.BPWidget_Shop) then
        self.BPWidget_Shop:RemoveFromViewport()
        self.BPWidget_Shop = nil
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_ShopEntry:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
    	
end



return BPWidget_ShopEntry