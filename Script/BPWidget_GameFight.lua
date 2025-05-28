---@class BPWidget_GameFight_C:UUserWidget
---@field NewAnimation_NoMonsterAdd UWidgetAnimation
---@field NewAnimation_MonsterDeadAdd UWidgetAnimation
---@field GoldTextBlock UTextBlock
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_118 UImage
---@field TextBlock_BuffSkillElement UTextBlock
---@field TextBlock_MonsterDeadAddGold UTextBlock
---@field TextBlock_NoMonsterAddGold UTextBlock
--Edit Below--
local BPWidget_GameFight = BPWidget_GameFight or {}

function BPWidget_GameFight:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_GameFight:Construct] self=%s", GetObjectFullName_Dev(self)))
    print("BPWidget_GameFight:InitGold ")
    BPWidget_GameFight.SuperClass.Construct(self)

    local GameState = GameplayStatics.GetGameState(self)
    GameState.GameStatusChangedDelegate:Add(
        function (GameState)
            if GameState.GameStatus ~= "GameFight" then
                self:RemoveFromViewport()
            end
        end
    )
    self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
    self.TextBlock_NoMonsterAddGold = self:GetWidgetFromName("TextBlock_NoMonsterAddGold")

    
    local GameState = GameplayStatics.GetGameState(self)
    
    local PlayerState = GameplayStatics.GetPlayerController(self, 0).PlayerState--self:GetOwningPlayer(self).PlayerState
    --print("BPWidget_GameFight:InitGold ")--..PlayerState.Gold
    PlayerState.GoldChangedDelegate:Add(self.On_PlayerState_GoldChanged, self)
    self:On_PlayerState_GoldChanged(PlayerState)--



    GameState.CurrentRoundChangedDelegate:Add(self.On_GameState_CurrentRoundChanged, self)
    self:On_GameState_CurrentRoundChanged(GameState)

    --self.MaxRoundTextBlock:SetText(tostring(GameState.MaxRound))


end



function BPWidget_GameFight:On_GameState_CurrentRoundChanged(GameState)
    --self.CurrentRoundTextBlock:SetText(tostring(GameState.CurrentRound))
end


local LastGold = 0
function BPWidget_GameFight:On_PlayerState_GoldChanged(PlayerState)
    local Gold = math.modf(PlayerState.Gold)
    print("BPWidget_GameFight:On_PlayerState_GoldChanged CurrentGold"..Gold)
    self.GoldTextBlock:SetText(tostring(Gold))

    if Gold > LastGold then
        self:PlayAnimation(self.NewAnimation_MonsterDeadAdd,0,1,EUMGSequencePlayMode.Forward,1)
    end
    LastGold = Gold
    
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_GameFight:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	-- [Editor Generated Lua] BindingEvent End;
end

function BPWidget_GameFight:NoMonsterAddGold(InID)
    if self.NewAnimation_NoMonsterAdd ~= nil then
        if InID == 1 then
            self.TextBlock_NoMonsterAddGold:SetText("红方")
        elseif InID == 2 then
            self.TextBlock_NoMonsterAddGold:SetText("紫方")
        end
        self:PlayAnimation(self.NewAnimation_NoMonsterAdd,0,1,EUMGSequencePlayMode.Forward,1)
        -- local teamID = GameplayStatics.GetPlayerController(self, 0).TeamID
    end
end

function BPWidget_GameFight:Tick(MyGeometry, InDeltaTime)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    if PlayerState ~= nil then
        --UGCLog.Log("BPWidget_GameFightTick",PlayerState:GeReconnectDataValue("iBuffSkillElement"))
        self.TextBlock_BuffSkillElement:SetText(tostring(PlayerState:GeReconnectDataValue("iBuffSkillElement")))
    end
end

-- [Editor Generated Lua] function define End;

return BPWidget_GameFight