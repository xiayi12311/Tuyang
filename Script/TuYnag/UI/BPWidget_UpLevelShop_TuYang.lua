---@class BPWidget_UpLevelShop_TuYang_C:UUserWidget
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Button_UpLevel UButton
---@field CloseButton UButton
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_4 UImage
---@field Image_5 UImage
---@field Image_6 UImage
---@field Image_7 UImage
---@field Image_8 UImage
---@field Image_Gold UImage
---@field Image_menu UImage
---@field ItemsHorizontalBox UHorizontalBox
---@field ItemsHorizontalBox_1 UHorizontalBox
---@field TextBlock_Cost UTextBlock
---@field TextBlock_InsufficientGold UTextBlock
---@field VerticalBox_0 UVerticalBox
--Edit Below--
require("common.ue_object")

local DependencyProperty = require("common.DependencyProperty")

local BPWidget_UpLevelShop_TuYang = BPWidget_UpLevelShop_TuYang or {}

BPWidget_UpLevelShop_TuYang.BPWidget_ShopItemClassPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_ShopItem_TuYang_UpLevel.BPWidget_ShopItem_TuYang_UpLevel_C')

BPWidget_UpLevelShop_TuYang.BP_ShopClassPath = string.format([[UGCWidgetBlueprint'%sAsset/BP_Shop.BP_Shop_C']], UGCMapInfoLib.GetRootLongPackagePath())

BPWidget_UpLevelShop_TuYang.BPWidget_ShopItemClass = nil

BPWidget_UpLevelShop_TuYang.IsInitializedForPlayer = false

BPWidget_UpLevelShop_TuYang.ShopID = 0

BPWidget_UpLevelShop_TuYang.BP_ShopComponent = DependencyProperty.RecursivelyFromValue()

BPWidget_UpLevelShop_TuYang.tKey = "Level1"
BPWidget_UpLevelShop_TuYang.tNextKey = "LevelMax"

function BPWidget_UpLevelShop_TuYang:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_UpLevelShop_TuYang:Construct] self=%s", GetObjectFullName_Dev(self)))
    ugcprint("BPWidget_UpLevelShop_TuYangConstruct")
    BPWidget_UpLevelShop_TuYang.SuperClass.Construct(self)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController.UpLevelMonsterWidget = self
    if GameplayStatics.GetPlayerController(self, 0):IsLocalPlayerController() then -- dedicated server better
        self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
        self.ItemsHorizontalBox = self:GetWidgetFromName("ItemsHorizontalBox")
        self.ItemsHorizontalBox_1 = self:GetWidgetFromName("ItemsHorizontalBox_1")
        self.TextBlock_Cost = self:GetWidgetFromName("TextBlock_Cost")
        
        self.CloseButton.OnReleased:Add(self.Close, self);
        self.Button_UpLevel.OnReleased:Add(self.Button_UpLevel_OnReleased, self);

        self.bCanEverTick = true
        self:InitializeForPlayer()
        ugcprint("BPWidget_UpLevelShop_TuYangConstruct1")
        self:InvalidateDataSource()
    end
end

function BPWidget_UpLevelShop_TuYang:Destruct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_UpLevelShop_TuYang:Destruct] self=%s", GetObjectFullName_Dev(self)))

    self:FinalizeForPlayer()

    BPWidget_UpLevelShop_TuYang.SuperClass.Destruct(self)
end

function BPWidget_UpLevelShop_TuYang:Tick(Geometry, DeltaSeconds)
    BPWidget_UpLevelShop_TuYang.SuperClass.Tick(self, Geometry, DeltaSeconds)

    --KismetSystemLibrary.PrintString(self, "äÆ" .. tostring(self.DataSource), true, true, LinearColor.New(1, 1, 1, 1), 0.1)
    self:InitializeForPlayer()
end

function BPWidget_UpLevelShop_TuYang:InitializeForPlayer()
    if not self.IsInitializedForPlayer then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)

        sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_UpLevelShop_TuYang:InitializeForPlayer] PlayerController=%s", GetObjectFullName_Dev(PlayerController)))

        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_UpLevelShop_TuYang:InitializeForPlayer] self=%s", GetObjectFullName_Dev(self)))


            self.GoldTextBlock:SetText(tostring(math.floor(PlayerController.PlayerState.Gold)))
            

            PlayerController.PlayerState.GoldChangedDelegate:Add(self.On_PlayerState_Gold_Changed, self)

           

            self.IsInitializedForPlayer = true
            self.bCanEverTick = false
        end
        local GameState = GameplayStatics.GetGameState(self)
        GameState.MonsterLevelChangedDelegate:Add(
            function (InID)
               ugcprint("BPWidget_UpLevelShop_TuYangInitializeForPlayer MonsterLevelChangedDelegate"..InID)
               self:InvalidateDataSource()
            end
        )
    end
end

function BPWidget_UpLevelShop_TuYang:FinalizeForPlayer()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_UpLevelShop_TuYang:FinalizeForPlayer] self=%s IsInitializedForPlayer=%s", GetObjectFullName_Dev(self), ToString_Dev(self.IsInitializedForPlayer)))

    if self.IsInitializedForPlayer then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
            PlayerController.PlayerState.GoldChangedDelegate:Remove(self.On_PlayerState_Gold_Changed, self)
            
            self.IsInitializedForPlayer = false
        end
    end
end

function BPWidget_UpLevelShop_TuYang:On_PlayerState_Gold_Changed(PlayerState)
    self.GoldTextBlock:SetText(tostring(PlayerState.Gold))
    
end

function BPWidget_UpLevelShop_TuYang:InvalidateDataSource()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_UpLevelShop_TuYang:InvalidateDataSource] self=%s", GetObjectFullName_Dev(self)))
    ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource")
    if self.DataSource ~= nil then
        if self.BPWidget_ShopItemClass == nil then
            self.BPWidget_ShopItemClass = UE.LoadClass(self.BPWidget_ShopItemClassPath)
        end
        local GameState = GameplayStatics.GetGameState(self)
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        self:ClearItems()
        -- 升级前的商店
        local tCurrentLevel = 1
        -- 根据对方怪物等级添加子控件
        if UE.IsValid(GameState) then
            local tLevel = 0
            if PlayerController.PlayerState.TeamID == 1 then
                tLevel = GameState.iID2MonsterLevel
                ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource01 tID2Level = "..tLevel)
            elseif PlayerController.PlayerState.TeamID == 2 then
                tLevel = GameState.iID1MonsterLevel
                ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource01 tID1Level = "..tLevel)
            else
                ugcprint("error BPWidget_UpLevelShop_TuYang:InvalidateDataSource TeamID is nil"..PlayerController.PlayerState.TeamID)
                return
            end
            ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource00 tLevel = "..tLevel)
            if tLevel >= #self.DataSource.Items then
                self.tKey = "LevelMax"
            else
                self.tKey = "Level"..tLevel
            end
            
            
            tLevel = tLevel + 1 
            ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource0 key = "..self.tKey)
            if tLevel >= #self.DataSource.Items then
                self.tNextKey = "LevelMax"
                tLevel = #self.DataSource.Items
            else
                self.tNextKey = "Level"..tLevel
            end
            ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource1 key = "..self.tKey)
            ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource2 key = "..self.tNextKey)
            
            for K, V in ipairs(self.DataSource.Items) do
                --ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource3 key = "..V.Key)
                if V.Key == self.tKey then
                    local BPWidget_ShopItem = LuaExtendLibrary.NewLuaObject(self, self.BPWidget_ShopItemClass)
                    BPWidget_ShopItem.DataSource = V
                    self.ItemsHorizontalBox:AddChild(BPWidget_ShopItem)
                end
                if V.Key == self.tNextKey then
                    ugcprint("BPWidget_UpLevelShop_TuYangInvalidateDataSource4 key = "..self.tNextKey)
                    local BPWidget_ShopItem = LuaExtendLibrary.NewLuaObject(self, self.BPWidget_ShopItemClass)
                    BPWidget_ShopItem.DataSource = V
                    self.ItemsHorizontalBox_1:AddChild(BPWidget_ShopItem)
                end
            end
           self.TextBlock_Cost:SetText(self.DataSource.Items[tLevel].Cost.."金")
        end
    else
        ugcprint("error BPWidget_UpLevelShop_TuYangInvalidateDataSource is nil")
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_UpLevelShop_TuYang:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	-- [Editor Generated Lua] BindingEvent End;
end

function BPWidget_UpLevelShop_TuYang:ClearItems()
    -- 清空所有的子控件
    if self.ItemsHorizontalBox then 
        self.ItemsHorizontalBox:ClearChildren() 
    end
    if self.ItemsHorizontalBox_1 then
        self.ItemsHorizontalBox_1:ClearChildren() 
    end

end
function BPWidget_UpLevelShop_TuYang:Button_UpLevel_OnReleased()
    -- 按下升级后
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
        PlayerController:ServerRPC_MonsterShop(self.ShopID,self.tNextKey,1)
        self:InvalidateDataSource()
    end
end
function BPWidget_UpLevelShop_TuYang:SecceedOrFailUpLevel(InIsSecceed,IniReset)
    if InIsSecceed then
        self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
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
        self:PlayAnimation(self.NewAnimation_2,0,1,EUMGSequencePlayMode.Forward,1)
    end
end
function BPWidget_UpLevelShop_TuYang:Close()
    self:RemoveFromViewport()
end
-- [Editor Generated Lua] function define End;
     

return BPWidget_UpLevelShop_TuYang