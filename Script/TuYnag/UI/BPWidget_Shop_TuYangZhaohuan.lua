---@class BPWidget_Shop_TuYangZhaohuan_C:UUserWidget
---@field NewAnimation_3 UWidgetAnimation
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Button_EquipConsume UButton
---@field Button_left UButton
---@field Button_Pistol UButton
---@field Button_Rifle UButton
---@field Button_Right UButton
---@field CloseButton UButton
---@field GoldTextBlock UTextBlock
---@field Image_Gold UImage
---@field Image_menu UImage
---@field TextBlock_InsufficientGold UTextBlock
---@field VerticalBox_0 UVerticalBox
--Edit Below--
require("common.ue_object")

local DependencyProperty = require("common.DependencyProperty")

local BPWidget_Shop_TuYang = BPWidget_Shop_TuYang or {}

BPWidget_Shop_TuYang.BPWidget_ShopItemClassPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_ShopItem_TuYangZhaohuan.BPWidget_ShopItem_TuYangZhaohuan_C')

BPWidget_Shop_TuYang.BP_ShopClassPath = string.format([[UGCWidgetBlueprint'%sAsset/BP_Shop.BP_Shop_C']], UGCMapInfoLib.GetRootLongPackagePath())

BPWidget_Shop_TuYang.BPWidget_ShopItemClass = nil

BPWidget_Shop_TuYang.IsInitializedForPlayer = false

BPWidget_Shop_TuYang.ShopID = 0

BPWidget_Shop_TuYang.BP_ShopComponent = DependencyProperty.RecursivelyFromValue()

local Page = 1
local PageMax = {}
local Category = 1

function BPWidget_Shop_TuYang:Construct()
    UGCLog.Log("BPWidget_Shop_TuYangConstruct")
	self:LuaInit();
    -- 自适应页数
    for K, V in ipairs(self.DataSource.Items) do
        UGCLog.Log("BPWidget_Shop_TuYangConstruct",V.Belong,V.Page)
        if PageMax[V.Belong] == nil then
            PageMax[V.Belong] = 0
        end
        PageMax[V.Belong] = math.max(PageMax[V.Belong],V.Page)
    end
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop_TuYang:Construct] self=%s", GetObjectFullName_Dev(self)))

    BPWidget_Shop_TuYang.SuperClass.Construct(self)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController.TuYangShopWidget = self
    if GameplayStatics.GetPlayerController(self, 0):IsLocalPlayerController() then -- dedicated server better
        self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
        self.ItemsHorizontalBox = self:GetWidgetFromName("ItemsHorizontalBox")
        self.ItemsHorizontalBox_1 = self:GetWidgetFromName("ItemsHorizontalBox_1")
        self.ItemsHorizontalBox_2 = self:GetWidgetFromName("ItemsHorizontalBox_2")
        self.ItemsHorizontalBox_3 = self:GetWidgetFromName("ItemsHorizontalBox_3")
        self.ItemsHorizontalBox_4 = self:GetWidgetFromName("ItemsHorizontalBox_4")
        self.ItemsHorizontalBox_5 = self:GetWidgetFromName("ItemsHorizontalBox_5")
        self.CloseButton.OnReleased:Add(self.Close, self);
       

        self.bCanEverTick = true
        self:InitializeForPlayer()
        self:InvalidateDataSource()
    end
    --self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.forward,1)
end

function BPWidget_Shop_TuYang:Destruct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop_TuYang:Destruct] self=%s", GetObjectFullName_Dev(self)))

    self:FinalizeForPlayer()

    BPWidget_Shop_TuYang.SuperClass.Destruct(self)
end

function BPWidget_Shop_TuYang:Tick(Geometry, DeltaSeconds)
    BPWidget_Shop_TuYang.SuperClass.Tick(self, Geometry, DeltaSeconds)

    --KismetSystemLibrary.PrintString(self, "äÆ" .. tostring(self.DataSource), true, true, LinearColor.New(1, 1, 1, 1), 0.1)
    self:InitializeForPlayer()
end

function BPWidget_Shop_TuYang:InitializeForPlayer()
    if not self.IsInitializedForPlayer then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)

        sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop_TuYang:InitializeForPlayer] PlayerController=%s", GetObjectFullName_Dev(PlayerController)))

        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop_TuYang:InitializeForPlayer] self=%s", GetObjectFullName_Dev(self)))


            self.GoldTextBlock:SetText(tostring(math.floor(PlayerController.PlayerState.Gold)))


            PlayerController.PlayerState.GoldChangedDelegate:Add(self.On_PlayerState_Gold_Changed, self)
            self.IsInitializedForPlayer = true
            self.bCanEverTick = false
        end
    end
end

function BPWidget_Shop_TuYang:FinalizeForPlayer()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop_TuYang:FinalizeForPlayer] self=%s IsInitializedForPlayer=%s", GetObjectFullName_Dev(self), ToString_Dev(self.IsInitializedForPlayer)))

    if self.IsInitializedForPlayer then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            PlayerController.PlayerState.GoldChangedDelegate:Remove(self.On_PlayerState_Gold_Changed, self)
            
            self.IsInitializedForPlayer = false
        end
    end
end

function BPWidget_Shop_TuYang:On_PlayerState_Gold_Changed(PlayerState)
    self.GoldTextBlock:SetText(tostring(PlayerState.Gold))
end

function BPWidget_Shop_TuYang:InvalidateDataSource()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_Shop_TuYang:InvalidateDataSource] self=%s", GetObjectFullName_Dev(self)))
    log_tree_dev("[BPWidget_Shop_TuYang:InvalidateDataSource] DataSource", self.DataSource)
    
    if self.DataSource ~= nil then
        self:ClearItems()
        if self.BPWidget_ShopItemClass == nil then
            self.BPWidget_ShopItemClass = UE.LoadClass(self.BPWidget_ShopItemClassPath)
        end
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        for K, V in ipairs(self.DataSource.Items) do
            local BPWidget_ShopItem = LuaExtendLibrary.NewLuaObject(self, self.BPWidget_ShopItemClass)
            BPWidget_ShopItem.DataSource = V
            BPWidget_ShopItem.ShopID = self.ShopID
            if V.Belong == Category and V.Page == Page then
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
                -- 判断是否锁定
                UGCLog.Log("[YYH]BPWidget_Shop_TuYangCheckUnlocked",V.Key)
                -- if PlayerController.BP_PayLockComponent:CheckUnlocked(V.Key) then
                --     V.PayLockNum = 0 
                -- else
                --     V.PayLockNum = 1
                -- end
                PlayerController.BP_PayLockComponent:PrintBinary()
                BPWidget_ShopItem:PayLock(PlayerController.BP_PayLockComponent:CheckUnlocked(V.Key))
            end

        end
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_Shop_TuYang:LuaInit()
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
	-- self.Button_SniperRifle.OnReleased:Add(self.Button_SniperRifle_OnReleased, self);
	-- self.Button_HeavyWeapon.OnReleased:Add(self.Button_HeavyWeapon_OnReleased, self);
	self.Button_left.OnReleased:Add(self.Button_left_OnReleased, self);
	self.Button_Right.OnReleased:Add(self.Button_Right_OnReleased, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BPWidget_Shop_TuYang:ClearItems()
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

function BPWidget_Shop_TuYang:Button_EquipConsume_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    Category = 1
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop_TuYang:Button_Pistol_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    Category = 2
    self:ClearItems()
    self:InvalidateDataSource()

end

function BPWidget_Shop_TuYang:Button_Rifle_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    Category = 3
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop_TuYang:Button_SniperRifle_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    Category = 4
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop_TuYang:Button_HeavyWeapon_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    Category = 5
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop_TuYang:Button_left_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    
    self:SubPage()
    self:ClearItems()
    self:InvalidateDataSource()
end

function BPWidget_Shop_TuYang:Button_Right_OnReleased()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    
    self:AddPage()
    self:ClearItems()
    self:InvalidateDataSource()
end
function BPWidget_Shop_TuYang:Close()
    self:RemoveFromViewport()
end


function BPWidget_Shop_TuYang:AddPage()
    if Page < PageMax[Category] then
        Page = Page + 1
    end    
end
function BPWidget_Shop_TuYang:SubPage()
    if Page > 1 then
        Page = Page - 1
    end
end
function BPWidget_Shop_TuYang:SecceedOrFailBuy(InIsSecceed , IniReset)
    if InIsSecceed then
        self:PlayAnimation(self.NewAnimation_2, 0, 1, EUMGSequencePlayMode.Forward, 1)
    else
         if IniReset == 1 then
            self.TextBlock_InsufficientGold:SetText("金币不足")
        elseif IniReset == 2 then
            self.TextBlock_InsufficientGold:SetText("等级达到上限")
            elseif IniReset == 3 then
                self.TextBlock_InsufficientGold:SetText("冷却中")
                elseif IniReset == 4 then
                    self.TextBlock_InsufficientGold:SetText("战术增益正在被使用")
                    elseif IniReset == 5 then
                        self.TextBlock_InsufficientGold:SetText("准备期间暂停购买")
        else
            self.TextBlock_InsufficientGold:SetText("购买失败")
        end
        self:PlayAnimation(self.NewAnimation_3,0,1,EUMGSequencePlayMode.Forward,1)
    end    
end
-- [Editor Generated Lua] function define End;
     

return BPWidget_Shop_TuYang
