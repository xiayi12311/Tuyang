---@class BPWidget_ShopEntry_TuYang_C:UUserWidget
---@field ShopEntryButton UButton
--Edit Below--
local BPWidget_ShopEntry_TuYang = {}

BPWidget_ShopEntry_TuYang.BPWidget_Shop = nil
BPWidget_ShopEntry_TuYang.ShopID = 0

function BPWidget_ShopEntry_TuYang:GetBPWidget_UpLevelShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_UpLevelShop_TuYang.BPWidget_UpLevelShop_TuYang_C')
end

function BPWidget_ShopEntry_TuYang:GetBPWidget_AddSpecialMonsterShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_ShopItem_TuYangZhaohuan.BPWidget_ShopItem_TuYangZhaohuan_C')
end

function BPWidget_ShopEntry_TuYang:Construct()
    ugcprint("BPWidget_ShopEntry_TuYangConstruct  ")
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopEntry_TuYang:Construct] self=%s", GetObjectFullName_Dev(self)))

    BPWidget_ShopEntry_TuYang.SuperClass.Construct(self)
    self.ShopEntryButton = self:GetWidgetFromName("ShopEntryButton")
    self.ShopEntryButton.OnReleased:Add(self.On_ShopEntryButton_Released, self)
    
    local GameState = GameplayStatics.GetGameState(self)
    if UE.IsValid(GameState) then
        if self.ShopID == 1 then
            self.DataSource = GameState.BP_EnemyShopComponent.DataSource1
        elseif self.ShopID == 2 then
            self.DataSource = GameState.BP_EnemyShopComponent.DataSource2
            else
                ugcprint("error BPWidget_ShopEntry_TuYang:Construct ShopID is Worng  "..self.ShopID)
        end
        ugcprint("BPWidget_ShopEntry_TuYangConstruct0  "..#self.DataSource)
        for _, Category in pairs(self.DataSource) do
            for X, Y in pairs(Category) do
                if type(Y) == "table" then
                    ugcprint("BPWidget_ShopEntry_TuYangConstruct1  "..Y.Key)
                end
            end
        end
    end
    
end

function BPWidget_ShopEntry_TuYang:ReceiveTick(DeltaTime)
    BPWidget_ShopEntry_TuYang.SuperClass.ReceiveTick(self, DeltaTime)
    --local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    -- local isintheshop = PlayerController.PlayerState.IsInTheShop
    -- local isintheshop1 = PlayerController.PlayerState.IsInTheShop1
    -- local isintheshop2 = PlayerController.PlayerState.IsInTheShop2
    -- local judge = isintheshop and isintheshop1 and isintheshop2
    -- if not judge then
    --     self:CloseUI()
    -- end

end

function BPWidget_ShopEntry_TuYang:Destruct()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopEntry_TuYang:Destruct] self=%s", GetObjectFullName_Dev(self)))
    BPWidget_ShopEntry_TuYang.SuperClass.Destruct(self)
end

function BPWidget_ShopEntry_TuYang:On_ShopEntryButton_Released()
   ugcprint("Shop Entry Reslesed")
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopEntry_TuYang:On_ShopEntryButton_Released] self=%s BPWidget_Shop=%s", GetObjectFullName_Dev(self), GetObjectFullName_Dev(self.BPWidget_Shop)))
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    

    --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
    if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
        --local isintheshop = PlayerController.PlayerState.IsInTheShop
        if UE.IsValid(self.BPWidget_Shop) then
            self.BPWidget_Shop:RemoveFromViewport()
            self.BPWidget_Shop = nil
        else
            local tClassPath = self:GetBPWidget_UpLevelShopClassPath()
            if self.ShopID == 1 then
                tClassPath = self:GetBPWidget_UpLevelShopClassPath()
            elseif self.ShopID == 2 then
                tClassPath = self:GetBPWidget_AddSpecialMonsterShopClassPath()
                else
                    ugcprint("error BPWidget_ShopEntry_TuYang:On_ShopEntryButton_Released ShopID is Worng  "..self.ShopID)
            end
            if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
                local BPWidget_ShopClass = UE.LoadClass(tClassPath)
                if UE.IsValid(BPWidget_ShopClass) then
                    ugcprint("111111111")
                self.BPWidget_Shop = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopClass)
                    if UE.IsValid(self.BPWidget_Shop) then
                        self.BPWidget_Shop.ShopID = self.ShopID
                        self.BPWidget_Shop.DataSource = self.DataSource
                        self.BPWidget_Shop:AddToViewport(10099)
                    end
                end
            end
        end
    end
end

function BPWidget_ShopEntry_TuYang:CloseUI()
    --用于销毁商店界面
    if UE.IsValid(self.BPWidget_Shop) then
        self.BPWidget_Shop:RemoveFromViewport()
        self.BPWidget_Shop = nil
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_ShopEntry_TuYang:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
    	
end



return BPWidget_ShopEntry_TuYang