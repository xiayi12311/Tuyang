TaskAndStoryUIManager = TaskAndStoryUIManager or {}

-- Manager管理的UI界面
TaskAndStoryUIManager.MainUI = nil;
TaskAndStoryUIManager.ConversationUI = nil;
TaskAndStoryUIManager.TaskUI = nil;
TaskAndStoryUIManager.SettlementUI = nil;

function TaskAndStoryUIManager:Init()
    print_dev("TaskAndStoryUIManager:Init")
    -- self:InitCGUI()
    self:LoadUIClasses()
    self.timer = Timer.InsertTimer(0, function ()
        if TaskAndStoryMode.MyPlayerController and self.MainUIClass and self.ConversationUIClass and self.TaskUIClass and self.SettlementUIClass then
            self:InitTaskAndStoryUI()
            Timer.RemoveTimer(self.timer)
            self.timer = nil
        end
    end, true)
end

-- -- 修改和平UI
-- function TaskAndStoryUIManager:InitCGUI()
-- 	print_dev("TaskAndStoryUIManager:InitCGUI");
--     -- 接口有问题，IOS上无法正常获取到
--     -- local MainControlPanel = UGCWidgetManagerSystem.GetMainUI();
--     local MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
--     if MainControlPanel ~= nil then
--         -- local MainControlBaseUI = MainControlPanel.MainControlBaseUI;
--         -- local ShootingUIPanel = MainControlPanel.ShootingUIPanel;
--     else
--         print("Error: TaskAndStoryUIManager:InitCGUI MainControlPanel == nil!");
--     end
-- end

-- 显示过场动画时刷新UI
function TaskAndStoryUIManager:UpdateUIWhenPlayingSequence(isPlayingSequence)
    print_dev("MainUI:UpdateUIWhenPlayingSequence:"..tostring(isPlayingSequence));
    local show = isPlayingSequence and ESlateVisibility.SelfHitTestInvisible or ESlateVisibility.Collapsed
    local hide = isPlayingSequence and ESlateVisibility.Collapsed or ESlateVisibility.SelfHitTestInvisible
    -- 显示跳过按钮
    self.MainUI.TaskPlot_Skip_UIBP:SetVisibility(show)
    -- 隐藏任务UI
    self.TaskUI:SetVisibility(hide)
    -- 显示跳过过场动画时，隐藏和平UI
    UGCWidgetManagerSystem.GetMainControlUI():SetVisibility(hide)
    UGCWidgetManagerSystem.GetShootingUIPanel():SetVisibility(hide)
    UGCWidgetManagerSystem.SetVirtualJoystickVisibility(not isPlayingSequence)
end

-- 异步加载UIClass
function TaskAndStoryUIManager:LoadUIClasses()
	print_dev("TaskAndStoryUIManager:LoadUIClasses");
    --ResourcesTools.AsyncLoadUGCClass(UGCGameSystem.GameState, "Asset/UI/MainUI.MainUI_C", function (class) TaskAndStoryUIManager.MainUIClass = class end)

    ResourcesTools.AsyncLoadUGCClass(UGCGameSystem.GameState, "Asset/Blueprint/TaskUI/TaskPlot_Main_UIBP.TaskPlot_Main_UIBP_C", function (class) TaskAndStoryUIManager.ConversationUIClass = class end)
    ResourcesTools.AsyncLoadUGCClass(UGCGameSystem.GameState, "'Asset/Blueprint/TaskUI/TaskPlot_Mission_UIBP.TaskPlot_Mission_UIBP_C'", function (class) TaskAndStoryUIManager.TaskUIClass = class end)
    
end

-- 初始化玩法UI
function TaskAndStoryUIManager:InitTaskAndStoryUI()
	print_dev("TaskAndStoryUIManager:InitTaskAndStoryUI");
    --self:CreateMainUI()
    self:CreateConversationUI()
    self:CreateTaskUI()
    self:UpdateUIWhenPlayingSequence(false)
end

-- 创建主UI
function TaskAndStoryUIManager:CreateMainUI()
	print_dev("TaskAndStoryUIManager:CreateMainUI");
    self.MainUI = UserWidget.NewWidgetObjectBP(PlayerController, self.MainUIClass);
    if self.MainUI == nil then
        print("Error: TaskAndStoryUIManager:CreateMainUI MainUI == nil!");
        return false;
    end

    -- 这里不知为何会报错，暂时用下面这个
    -- UGCWidgetManagerSystem.AddChildToTochButton(self.MainUI)
    local TochButton = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
    if TochButton ~= nil then
        UIUtil.AttachTo(TochButton:GetWidgetFromName("CanvasPanel_IPX"), self.MainUI, 1, { Minimum = { X = 0, Y = 0 }, Maximum = { X = 1, Y = 1 } }, { Left = 0, Right = -1.5, Bottom = 0, Top = 0 })
        CustomizeUtils.ApplyAllUGCButtonsSetting(self.MainUI)
    else
        print("Error: TochButton is nil")
        return false;
    end

    return true;
end

-- 创建对话UI
function TaskAndStoryUIManager:CreateConversationUI()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	print_dev("TaskAndStoryUIManager:CreateConversationUI");
    self.ConversationUI = UserWidget.NewWidgetObjectBP(PlayerController, self.ConversationUIClass);
    if self.ConversationUI == nil then
        print("Error: TaskAndStoryUIManager:CreateConversationUI ConversationUI == nil!");
        return false;
    end
    self.ConversationUI:AddToViewport(10051);
end

-- 创建任务UI
function TaskAndStoryUIManager:CreateTaskUI()
	print_dev("TaskAndStoryUIManager:CreateTaskUI");
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    self.TaskUI = UserWidget.NewWidgetObjectBP(PlayerController, self.TaskUIClass);
    if self.TaskUI == nil then
        print("Error: TaskAndStoryUIManager:CreateConversationUI TaskUI == nil!");
        return false;
    end
    self.TaskUI:AddToViewport(10051);
end

-- 创建结算UI
function TaskAndStoryUIManager:CreateSettlementUI()
	print_dev("TaskAndStoryUIManager:CreateSettlementUI");
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    self.SettlementUI = UserWidget.NewWidgetObjectBP(PlayerController, self.SettlementUIClass);
    if self.SettlementUI == nil then
        print("Error: TaskAndStoryUIManager:CreateConversationUI SettlementUI == nil!");
        return false;
    end
    self.SettlementUI:AddToViewport(10051);
--     -- 隐藏和平的主界面UI、射击UI，保留设置和聊天按钮
--     local MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
--    UGCWidgetManagerSystem.AddWidgetHiddenLayer(MainControlPanel.MainControlBaseUI)

end
