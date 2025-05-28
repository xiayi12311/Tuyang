---@class BPWidget_Shop1_C:UUserWidget
---@field Button_EquipConsume UButton
---@field Button_left UButton
---@field Button_Pistol UButton
---@field Button_Rifle UButton
---@field Button_Right UButton
---@field Button_SniperRifle UButton
---@field CloseButton UButton
---@field Image_Gold UImage
---@field Image_menu UImage
--Edit Below--
require("common.ue_object")

local DependencyProperty = require("common.DependencyProperty")

local BPWidget_Shop = BPWidget_Shop or {}

BPWidget_Shop.BPWidget_ShopItemClassPath = string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_ShopItem.BPWidget_ShopItem_C']], UGCMapInfoLib.GetRootLongPackagePath())

BPWidget_Shop.BP_ShopClassPath = string.format([[UGCWidgetBlueprint'%sAsset/BP_Shop.BP_Shop_C']], UGCMapInfoLib.GetRootLongPackagePath())

BPWidget_Shop.BPWidget_ShopItemClass = nil

BPWidget_Shop.IsInitializedForPlayer = false

BPWidget_Shop.BP_ShopComponent = DependencyProperty.RecursivelyFromValue()

function BPWidget_Shop:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop:Construct] self=%s", GetObjectFullName_Dev(self)))

    BPWidget_Shop.SuperClass.Construct(self)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)

    if GameplayStatics.GetPlayerController(self, 0):IsLocalPlayerController() then -- dedicated server better
        self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
        self.ItemsHorizontalBox = self:GetWidgetFromName("ItemsHorizontalBox")
        self.ItemsHorizontalBox_1 = self:GetWidgetFromName("ItemsHorizontalBox_1")
        self.ItemsHorizontalBox_2 = self:GetWidgetFromName("ItemsHorizontalBox_2")
        self.ItemsHorizontalBox_3 = self:GetWidgetFromName("ItemsHorizontalBox_3")
        self.ItemsHorizontalBox_4 = self:GetWidgetFromName("ItemsHorizontalBox_4")
        self.ItemsHorizontalBox_5 = self:GetWidgetFromName("ItemsHorizontalBox_5")
        self.CloseButton.OnReleased:Add(self.Close, self);
        
        --[[self.CloseButton = self:GetWidgetFromName("CloseButton")

        self.CloseButton.OnReleased:Add(
            function ()
                if UE.IsValid(self.BP_ShopComponent) then
                    self:RemoveFromViewport()
                end
            end
        )]]

        do
            local BP_ShopClass = UE.LoadClass(self.BP_ShopClassPath)
            local BP_Shops = GameplayStatics.GetAllActorsOfClass(self, BP_ShopClass, {})
            for XXX, BP_Shop in require("common.Enumeration").FromEnumerable(BP_Shops)() do
                --if BP_Shop.WidgetComponent:GetUserWidgetObject() == self then
                    self.BP_ShopComponent(BP_Shop.BP_ShopComponent)
                    break
                --end
            end
            if UE.IsValid(self.BP_ShopComponent()) then
                
                if PlayerController.PlayerState.IsInTheShop3 == true then
                    self.DataSource = self.BP_ShopComponent().DataSource3
                end
                
            end
        end

        self.bCanEverTick = true
        self:InitializeForPlayer()
        self:InvalidateDataSource()
    end
end

function BPWidget_Shop:Destruct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop:Destruct] self=%s", GetObjectFullName_Dev(self)))

    self:FinalizeForPlayer()

    BPWidget_Shop.SuperClass.Destruct(self)
end

function BPWidget_Shop:Tick(Geometry, DeltaSeconds)
    BPWidget_Shop.SuperClass.Tick(self, Geometry, DeltaSeconds)

    --KismetSystemLibrary.PrintString(self, "äÆ" .. tostring(self.DataSource), true, true, LinearColor.New(1, 1, 1, 1), 0.1)
    self:InitializeForPlayer()
end

function BPWidget_Shop:InitializeForPlayer()
    if not self.IsInitializedForPlayer then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)

        sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop:InitializeForPlayer] PlayerController=%s", GetObjectFullName_Dev(PlayerController)))

        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop:InitializeForPlayer] self=%s", GetObjectFullName_Dev(self)))

            self.GoldTextBlock:SetText(tostring(math.floor(PlayerController.PlayerState.Gold)))
            
            PlayerController.PlayerState.GoldChangedDelegate:Add(self.On_PlayerState_Gold_Changed, self)
            self.IsInitializedForPlayer = true
            self.bCanEverTick = false
        end
    end
end

function BPWidget_Shop:FinalizeForPlayer()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop:FinalizeForPlayer] self=%s IsInitializedForPlayer=%s", GetObjectFullName_Dev(self), ToString_Dev(self.IsInitializedForPlayer)))

    if self.IsInitializedForPlayer then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            PlayerController.PlayerState.GoldChangedDelegate:Remove(self.On_PlayerState_Gold_Changed, self)
            
            self.IsInitializedForPlayer = false
        end
    end
end

function BPWidget_Shop:On_PlayerState_Gold_Changed(PlayerState)
    self.GoldTextBlock:SetText(tostring(PlayerState.Gold))
end

function BPWidget_Shop:InvalidateDataSource()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop:InvalidateDataSource] self=%s", GetObjectFullName_Dev(self)))
    log_tree_dev("[BPWidget_Shop:InvalidateDataSource] DataSource", self.DataSource)

    if self.DataSource ~= nil then
        if self.BPWidget_ShopItemClass == nil then
            self.BPWidget_ShopItemClass = UE.LoadClass(self.BPWidget_ShopItemClassPath)
        end
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        local category = PlayerController.PlayerState.Category1
        local page = PlayerController.PlayerState.Page1
        for K, V in ipairs(self.DataSource.Items) do
            local BPWidget_ShopItem = LuaExtendLibrary.NewLuaObject(self, self.BPWidget_ShopItemClass)
            BPWidget_ShopItem.BP_ShopComponent = self.BP_ShopComponent()
            BPWidget_ShopItem.DataSource = V
            
            if V.Belong == category and V.Page == page then
                if BPWidget_ShopItem.DataSource.Index == 1 then
                    self.ItemsHorizontalBox:AddChild(BPWidget_ShopItem)
                end
                if BPWidget_ShopItem.DataSource.Index == 2 then
                    self.ItemsHorizontalBox_1:AddChild(BPWidget_ShopItem)
                end
                if BPWidget_ShopItem.DataSource.Index == 3 then
                    self.ItemsHorizontalBox_2:AddChild(BPWidget_ShopItem)
                end
                if BPWidget_ShopItem.DataSource.Index == 4 then
                    self.ItemsHorizontalBox_3:AddChild(BPWidget_ShopItem)
                end
                if BPWidget_ShopItem.DataSource.Index == 5 then
                    self.ItemsHorizontalBox_4:AddChild(BPWidget_ShopItem)
                end
                if BPWidget_ShopItem.DataSource.Index == 6 then
                    self.ItemsHorizontalBox_5:AddChild(BPWidget_ShopItem)
                end

            end

        end
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_Shop:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Button_EquipConsume.OnReleased:Add(self.Button_EquipConsume_OnReleased, self);
	self.Button_Pistol.OnReleased:Add(self.Button_Pistol_OnReleased, self);
	self.Button_Rifle.OnReleased:Add(self.Button_Rifle_OnReleased, self);
	self.Button_SniperRifle.OnReleased:Add(self.Button_SniperRifle_OnReleased, self);
	--self.Button_HeavyWeapon.OnReleased:Add(self.Button_HeavyWeapon_OnReleased, self);
	self.Button_left.OnReleased:Add(self.Button_left_OnReleased, self);
	self.Button_Right.OnReleased:Add(self.Button_Right_OnReleased, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BPWidget_Shop:ClearItems()
    -- 清空所有的子控件
    if self.ItemsHorizontalBox then 
        self.ItemsHorizontalBox:ClearChildren() 
    end
    if self.ItemsHorizontalBox_1 then
        self.ItemsHorizontalBox_1:ClearChildren() 
    end
    if self.ItemsHorizontalBox_2 then 
        self.ItemsHorizontalBox_2:ClearChildren() 
    end
    if self.ItemsHorizontalBox_3 then 
        self.ItemsHorizontalBox_3:ClearChildren() 
    end
    if self.ItemsHorizontalBox_4 then 
        self.ItemsHorizontalBox_4:ClearChildren() 
    end
    if self.ItemsHorizontalBox_5 then 
        self.ItemsHorizontalBox_5:ClearChildren() 
    end
end

function BPWidget_Shop:Button_EquipConsume_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local num = 1
    PlayerController.PlayerState:ChangeCategory1(num)
    PlayerController.PlayerState:ResetPage1()
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop:Button_Pistol_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local num = 2
    PlayerController.PlayerState:ChangeCategory1(num)
    PlayerController.PlayerState:ResetPage1()
    self:ClearItems()
    self:InvalidateDataSource()

end

function BPWidget_Shop:Button_Rifle_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local num = 3
    PlayerController.PlayerState:ChangeCategory1(num)
    PlayerController.PlayerState:ResetPage1()
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop:Button_SniperRifle_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local num = 4
    PlayerController.PlayerState:ChangeCategory1(num)
    PlayerController.PlayerState:ResetPage1()
    self:ClearItems()
    self:InvalidateDataSource()
end
--[[
function BPWidget_Shop:Button_HeavyWeapon_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local num = 5
    PlayerController.PlayerState:ChangeCategory1(num)
    PlayerController.PlayerState:ResetPage1()
    self:ClearItems()
    self:InvalidateDataSource()
end
--]]

function BPWidget_Shop:Button_left_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController.PlayerState:SubPage1()
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop:Button_Right_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController.PlayerState:AddPage1()
    self:ClearItems()
    self:InvalidateDataSource()
end
function BPWidget_Shop:Close()
    self:RemoveFromViewport()
end
-- [Editor Generated Lua] function define End;

return BPWidget_Shop