---@class TuYang_MonsterShopLand_C:BP_ShopLandBase_C
--Edit Below--
local TuYang_MonsterShopLand = {}
 
function TuYang_MonsterShopLand:GetBPWidget_UpLevelShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_UpLevelShop_TuYang.BPWidget_UpLevelShop_TuYang_C')
end

function TuYang_MonsterShopLand:GetBPWidget_AddSpecialMonsterShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_Shop_TuYangZhaohuan.BPWidget_Shop_TuYangZhaohuan_C')
end

function TuYang_MonsterShopLand:ReceiveBeginPlay()
    TuYang_MonsterShopLand.SuperClass.ReceiveBeginPlay(self)
    --UGCLog.Log("TuYang_MonsterShopLand:ReceiveBeginPlay")
    local GameState = GameplayStatics.GetGameState(self)
    if UE.IsValid(GameState) then
        if self.ShopID == 1 then
            self.DataSource = GameState.BP_EnemyShopComponent.DataSource1
        elseif self.ShopID == 2 then
            self.DataSource = GameState.BP_EnemyShopComponent.DataSource2
            else
                ugcprint("error BP_ShopLandBase:Construct ShopID is Worng  "..self.ShopID)
        end
    end
    -- local mt = getmetatable(TuYang_MonsterShopLand)
    -- if mt then
    --     for k, v in pairs(mt) do
    --         print("Key:", k, "Value:", v)
    --     end
    -- else
    --     print("TuYang_MonsterShopLand 没有元表")
    -- end
    
end


--[[
function TuYang_MonsterShopLand:ReceiveTick(DeltaTime)
    TuYang_MonsterShopLand.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_MonsterShopLand:ReceiveEndPlay()
    TuYang_MonsterShopLand.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_MonsterShopLand:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_MonsterShopLand:GetAvailableServerRPCs()
    return
end
--]]


function TuYang_MonsterShopLand:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Box_OnComponentBeginOverlap0")
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		local PlayerController = OtherActor:GetPlayerControllerSafety()
		if OtherActor:IsPlayerControlled() then
			ugcprint("Box_OnComponentBeginOverlap")
			 --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
			if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
				local tClassPath = self:GetBPWidget_UpLevelShopClassPath()
				if self.ShopID == 1 then
					tClassPath = self:GetBPWidget_UpLevelShopClassPath()
				elseif self.ShopID == 2 then
					tClassPath = self:GetBPWidget_AddSpecialMonsterShopClassPath()
					else
						ugcprint("error BPWidget_ShopEntry_TuYang:On_ShopEntryButton_Released ShopID is Worng  "..self.ShopID)
				end
				if UE.IsValid(PlayerController) and PlayerController:IsLocalController() and UGCPawnAttrSystem.GetHealth(PlayerController.pawn)>0 then
					ugcprint("[maoyu] Health>0")
					local BPWidget_ShopClass = UE.LoadClass(tClassPath)
					if UE.IsValid(BPWidget_ShopClass) then
                        if self.BPWidget_Shop == nil then
                            self.BPWidget_Shop = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopClass)
                        end
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
end


function TuYang_MonsterShopLand:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    UGCLog.Log("TuYang_MonsterShopLandBox_OnComponentEndOverlap")
    -- 调用父类调不到
    if not self:HasAuthority() then
        if OtherActor:IsPlayerControlled() then
            if UE.IsValid(self.BPWidget_Shop) then
                self.BPWidget_Shop:RemoveFromViewport()
            end
        end
    end
end

return TuYang_MonsterShopLand