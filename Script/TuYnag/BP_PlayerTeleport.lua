---@class BP_PlayerTeleport_C:AActor
---@field P_Birthisland_fire_01 UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
---@field ActorSequence UActorSequenceComponent
---@field Box UBoxComponent
---@field StaticMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field ID int32
--Edit Below--
local BP_PlayerTeleport = {}
BP_PlayerTeleport.BPWidget_TP = nil

function BP_PlayerTeleport:GetBPWidget_TeleportUIPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_TeleportUI.BPWidget_TeleportUI_C')
end


function BP_PlayerTeleport:ReceiveBeginPlay()
    BP_PlayerTeleport.SuperClass.ReceiveBeginPlay(self)
	--添加碰撞体检测回调函数
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap,self)
	self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	local GameState = UGCGameSystem.GetGameState()
	if GameState.TepeportActorList[self.ID] == nil then
		GameState.TepeportActorList[self.ID] = self
	end
end


--[[
function BP_PlayerTeleport:ReceiveTick(DeltaTime)
    BP_PlayerTeleport.SuperClass.ReceiveTick(self, DeltaTime)
	
end
--]]

function BP_PlayerTeleport:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Box_OnComponentBeginOverlap0")
	local PlayerController = OtherActor:GetPlayerControllerSafety()
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		
		
		if OtherActor:IsPlayerControlled() then
			
			UGCLog.Log("BP_ShopLandBox_OnComponentBeginOverlap",OtherActor)
			 --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
			if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
				--local isintheshop = PlayerController.PlayerState.IsInTheShop
				if UE.IsValid(self.BPWidget_TP) then
					self.BPWidget_TP:AddToViewport(10099)
				else
					local tClassPath = self:GetBPWidget_TeleportUIPath()
					if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
						local BPWidget_ShopClass = UE.LoadClass(tClassPath)
						if UE.IsValid(BPWidget_ShopClass) then
							self.BPWidget_TP = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopClass)
							if UE.IsValid(self.BPWidget_TP) then
								self.BPWidget_TP:AddToViewport(10099)
								self.BPWidget_TP.ID = self.ID
							end
						end
					end
				end
				self.BPWidget_TP:InitializeWidget()
			end
		end
    end	
	PlayerController:SetTeleportActor(self.ID,self)
end


function BP_PlayerTeleport:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		UGCLog.Log("BP_PlayerTeleportBox_OnComponentEndOverlap",OtherActor)
		if OtherActor:IsPlayerControlled() then
			if UE.IsValid(self.BPWidget_TP) then
				UGCLog.Log("BP_PlayerTeleportBox_OnComponentEndOverlap0")
				self.BPWidget_TP:RemoveFromViewport()
				
			end
		end
	else
    end
end

function BP_PlayerTeleport:StartTeleportSecquence(InPlayerController)
	UGCLog.Log("BP_PlayerTeleportPlayTeleportSequence")
	if self:HasAuthority() then
		UnrealNetwork.CallUnrealRPC(InPlayerController,self,"StartTeleportSecquence")
	else
		self.ActorSequence:StartPlay(0,true)
	end
	
	if self.ActorSequence:GetSequencePlayer() ~= nil then
		--self.ActorSequence:GetSequencePlayer():Play()
	else
		UGCLog.Log("self.ActorSequence == NIL ")
	end
	
end

-- [Editor Generated Lua] function define End;

return BP_PlayerTeleport