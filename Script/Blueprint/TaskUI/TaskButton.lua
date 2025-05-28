---@class TaskButton_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field StageThree_Anim UWidgetAnimation
---@field StageTwo_Anim UWidgetAnimation
---@field TuYang_Toface UWidgetAnimation
---@field Tip_Anim UWidgetAnimation
---@field Button_148 UButton
---@field CanvasPanel_0 UCanvasPanel
---@field Enemycount1 UImage
---@field Enemycount2 UImage
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_4 UImage
---@field Image_5 UImage
---@field Image_6 UImage
---@field Image_7 UImage
---@field Image_SelfTeam UImage
---@field Image_Stage2 UImage
---@field MonsterNumber UTextBlock
---@field PatternOfMonsterNum1 UHorizontalBox
---@field TextBlock_1 UTextBlock
---@field TextBlock_2 UTextBlock
---@field TextBlock_40 UTextBlock
---@field TextBlock_73 UTextBlock
---@field TextBlock_75 UTextBlock
---@field TextBlock_77 UTextBlock
---@field TextBlock_79 UTextBlock
---@field TextBlock_PlacesNum UTextBlock
---@field TextBlock_RoundID1 UTextBlock
---@field TextBlock_RoundID2 UTextBlock
---@field TextBlock_SelfTeam UTextBlock
---@field TextBlock_Stage3DANGER UTextBlock
--Edit Below--
local TaskButton = { bInitDoOnce = false } 
local EventSystem =  require('Script.common.UGCEventSystem')
TaskButton.TaskButtonContent = nil
local EventSystem =  require('Script.common.UGCEventSystem')
function TaskButton:GetTaskButtonContentClassPath()
    return  string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/TaskUI/TaskButtonContent.TaskButtonContent_C']], UGCMapInfoLib.GetRootLongPackagePath())
end
TaskButton.TeamTexture_ID1 = '/Game/Arts/UI/TableIcons/ProfessionResult_Icon/ZY_img_tujibing.ZY_img_tujibing'
TaskButton.TeamTexture_ID2 = '/Game/Arts/UI/TableIcons/ProfessionResult_Icon/ZY_img_houqinbing.ZY_img_houqinbing'


function TaskButton:Construct()
	self:LuaInit();
	ugcprint("Task Button Construct!")
	self.Image_1 = self:GetWidgetFromName("Image_1")
	self.Image_1:SetVisibility(ESlateVisibility.Hidden)
	self:PlayAnimation(self.Tip_Anim,0,0,EUMGSequencePlayMode.Forward,1)
	
	EventSystem:AddListener("TimeCount",self.SetTimeCount,self)
	self.TextBlock_1 = self:GetWidgetFromName("TextBlock_1")
	self.TextBlock_2 = self:GetWidgetFromName("TextBlock_2")
	self.TextBlock_40= self:GetWidgetFromName("TextBlock_40")
	self.TextBlock_73= self:GetWidgetFromName("TextBlock_73")
	self.TextBlock_75= self:GetWidgetFromName("TextBlock_75")
	self.TextBlock_77= self:GetWidgetFromName("TextBlock_77")
	self.TextBlock_79= self:GetWidgetFromName("TextBlock_79")
	self.TextBlock_RoundID1= self:GetWidgetFromName("TextBlock_RoundID1")
	self.TextBlock_RoundID2= self:GetWidgetFromName("TextBlock_RoundID2")
	EventSystem:AddListener("MainUI",self.Update,self)
	-- tuyang
	self.MonsterNumber= self:GetWidgetFromName("MonsterNumber")
	self.Image_Stage2:SetVisibility(ESlateVisibility.Hidden)
	self.TextBlock_Stage3DANGER:SetVisibility(ESlateVisibility.Hidden)
	
	self:PlayAnimation(self.StageTwo_Anim,0,0,EUMGSequencePlayMode.Forward,1)
	self:PlayAnimation(self.StageThree_Anim,0,0,EUMGSequencePlayMode.Forward,1)
	
	
	--local PlayerStates = UGCGameSystem.GetAllPlayerState()
	-- local num = UGCGameSystem:GetPlayerNum()
	-- ugcprint("Player num is" ..num)
    -- for i = 1,num do
	-- 	if i == 1 then
	-- 		self.TextBlock_73:SetText("0" )
	-- 		self.Image_4:SetVisibility(ESlateVisibility.Visible)
	-- 	elseif i==2 then
	-- 		self.TextBlock_75:SetText("0" )
	-- 		self.Image_3:SetVisibility(ESlateVisibility.Visible)
	-- 	elseif i==3 then
	-- 		self.TextBlock_77:SetText("0" )
	-- 		self.Image_5:SetVisibility(ESlateVisibility.Visible)
	-- 	elseif i==4 then
	-- 		self.TextBlock_79:SetText("0" )
	-- 		self.Image_6:SetVisibility(ESlateVisibility.Visible)
	-- 	end
	-- 	i = i+1
	-- end
	-- for i,PlayerState in pairs(PlayerStates) do
	-- 	ugcprint("key = " ..i)
	-- 	if i == 1 then
	-- 		self.TextBlock_73:SetText("淘汰 " ..PlayerState:GetEnemyCount())

	-- 	elseif i==2 then
	-- 		self.TextBlock_75:SetText("淘汰 " ..PlayerState:GetEnemyCount())

	-- 	elseif i==3 then
	-- 		self.TextBlock_77:SetText("淘汰 " ..PlayerState:GetEnemyCount())

	-- 	elseif i==4 then
	-- 		self.TextBlock_79:SetText("淘汰 " ..PlayerState:GetEnemyCount())
	-- 	end

	-- end
	local GameState = GameplayStatics.GetGameState()
	if UE.IsValid(GameState) then
		GameState.CurrentRoundChangedDelegate:Add(
		function () self:On_GameState_CurrentRoundChangedDelegate(GameState) 
		end)
	end
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
	if PlayerState then
		if PlayerState.TeamID == 1 then
			self.TextBlock_SelfTeam:SetText("红方" )
			self.Image_SelfTeam:SetBrushFromTexture(UE.LoadObject(self.TeamTexture_ID1),true)
		elseif PlayerState.TeamID == 2 then
			self.TextBlock_SelfTeam:SetText("紫方" )
			self.Image_SelfTeam:SetBrushFromTexture(UE.LoadObject(self.TeamTexture_ID2),true)
		else
			UGCLog.Log("error TaskButton:Construct TeamID is nil",PlayerController.PlayerState.TeamID)
			return
		end
	end
	
end


function TaskButton:Tick(MyGeometry, InDeltaTime)
	self:SetMonsterNumberChangeUI()
end

-- function TaskButton:Destruct()

-- end

-- [Editor Generated Lua] function define Begin:
function TaskButton:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	local GameState = GameplayStatics.GetGameState(self)
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	self.Image_1:BindingProperty("Visibility", self.Image_1_Visibility, self);
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Button_148.OnClicked:Add(self.Button_148_OnClicked, self);
	-- [Editor Generated Lua] BindingEvent End;
	GameState.MonsterNumberChangedDelegate:Add(self.On_GameState_MonsterNumberChangeDelegate,self)
end

function TaskButton:Button_148_OnClicked()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
        local TaskButtonContentClass = UE.LoadClass(self:GetTaskButtonContentClassPath())
        if UE.IsValid(TaskButtonContentClass) then
            self.TaskButtonContent = UserWidget.NewWidgetObjectBP(PlayerController, TaskButtonContentClass)
            self.TaskButtonContent:AddToViewport(0)
        end
    end
	
end

function TaskButton:Image_1_Visibility(ReturnValue)
	return 0;
end
function TaskButton:ShowTaskTips(IsShow)
	ugcprint("TaskButton show 3")
	if IsShow then
		self.Image_1:SetVisibility(ESlateVisibility.Visible)
	else
		self.Image_1:SetVisibility(ESlateVisibility.Hidden)
	end
	
end
function TaskButton:SetTimeCount(TimeCount)
	ugcprint("Set Time Count")
	local a = math.floor(TimeCount/60)
	local b = math.fmod(TimeCount,60) 
	self.TextBlock_1:SetText("" ..a)  --
	self.TextBlock_2:SetText("" ..b)
end
-- [Editor Generated Lua] function define End;
function TaskButton:Update(TaskStage)
	if TaskStage then
	if TaskStage ==1   then
		self.TextBlock_40:SetText("击败敌人") 
	elseif TaskStage ==2 then
		self.TextBlock_40:SetText("打开供暖装置") 
	elseif TaskStage ==3 then
		self.TextBlock_40:SetText("前往下一节车厢")
		--4是等待大门开启
	elseif TaskStage ==4 then
		self.TextBlock_40:SetText("前往下一节车厢")
		--4.5 击杀小boss
	elseif TaskStage ==5 then
		self.TextBlock_40:SetText("请拾取燃料")
	elseif TaskStage ==6 then
		self.TextBlock_40:SetText("前往下一节车厢")
	elseif TaskStage== 7 then
		self.TextBlock_40:SetText("寻找钥匙(0/3)")
	elseif TaskStage== 8 then
		self.TextBlock_40:SetText("寻找钥匙(1/3)")
	elseif TaskStage== 9 then
		self.TextBlock_40:SetText("寻找钥匙2/3)")
	elseif TaskStage== 10 then
		self.TextBlock_40:SetText("打开大门")
	elseif TaskStage>= 11 then
		self.TextBlock_40:SetText("击败NSA执行官")
	end
	
end
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	local PlayerState = PlayerController.PlayerState;
	local gamestate = UGCGameSystem:GetGameState()
	--PlayerState为空时，打印警告
    if PlayerState == nil then
        print( "Error: MyStartManager:GetUGCModePlayerStart PlayerState is nil!");
		return
    end
	
	
end

function TaskButton:Initial()
	local num = UGCGameSystem:GetPlayerNum()
	ugcprint("Player num is" ..num)
    for i = 1,num do
		if i == 1 then
			self.TextBlock_75:SetText("0" )
			self.Image_4:SetVisibility(ESlateVisibility.Visible)
		elseif i==2 then
			self.TextBlock_73:SetText("0" )
			self.Image_3:SetVisibility(ESlateVisibility.Visible)
		elseif i==3 then
			self.TextBlock_77:SetText("0" )
			self.Image_5:SetVisibility(ESlateVisibility.Visible)
		elseif i==4 then
			self.TextBlock_79:SetText("0" )
			self.Image_6:SetVisibility(ESlateVisibility.Visible)
		end
		i = i+1
	end
	local gamestate = UGCGameSystem:GetGameState()
	local a = gamestate.iID1MonsterNum
	self.MonsterNumber:SetText("" ..a)
end


--怪物生成或者死亡通知
function  TaskButton:On_GameState_MonsterNumberChangeDelegate(InID)
	-- ugcprint("On_GameState_MonsterNumberChangeDelegate")
	-- local gamestate = UGCGameSystem:GetGameState()
	-- local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	-- local PlayerState = PlayerController.PlayerState;
	-- local bornPointId = 0
	-- local a
	-- ugcprint( "MonsterNumUI bornPointId = "..bornPointId);
	-- ugcprint( "MonsterNumUI iID1MonsterNum = "..gamestate.iID1MonsterNum);
    -- bornPointId = PlayerState.TeamID
	-- if bornPointId == 1 then
	-- 	a = gamestate.iID1MonsterNum
	-- 	self.MonsterNumber:SetText("" ..a)
	-- elseif bornPointId == 2 then
	-- 	a = gamestate.iID2MonsterNum
	-- 	self.MonsterNumber:SetText("" ..a)
	-- end

end
function  TaskButton:SetMonsterNumberChangeUI()
	local gamestate = UGCGameSystem:GetGameState()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	local PlayerState = PlayerController.PlayerState;
	local bornPointId = 0
	local tNum_ID1 = gamestate.iID1MonsterNum
	local tNum_ID2 = gamestate.iID2MonsterNum

    bornPointId = PlayerState.TeamID
	if bornPointId == 1 then
		self.MonsterNumber:SetText("" ..tNum_ID1)
		self.TextBlock_PlacesNum:SetText("" ..tNum_ID2)
	elseif bornPointId == 2 then
		self.MonsterNumber:SetText("" ..tNum_ID2)
		self.TextBlock_PlacesNum:SetText("" ..tNum_ID1)
	end
	self.TextBlock_RoundID1:SetText("" ..gamestate.iWinRound_ID1)
	self.TextBlock_RoundID2:SetText("" ..gamestate.iWinRound_ID2)
end
function TaskButton:PlayTaskStageUI(InStage)
	
		if InStage == 1 then
			self.Image_Stage2:SetVisibility(ESlateVisibility.Hidden)
			self.TextBlock_Stage3DANGER:SetVisibility(ESlateVisibility.Hidden)
		elseif InStage == 2 then
			self.Image_Stage2:SetVisibility(ESlateVisibility.Visible)
			self.TextBlock_Stage3DANGER:SetVisibility(ESlateVisibility.Hidden)
			
		elseif InStage == 3 then
			self.Image_Stage2:SetVisibility(ESlateVisibility.Visible)
			self.TextBlock_Stage3DANGER:SetVisibility(ESlateVisibility.Visible)
		end
	
	
end

function TaskButton:GameFightStartUI()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
end
function TaskButton:GameFightEndUI()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Reverse,1)
	self:PlayTaskStageUI(1)
end
return TaskButton