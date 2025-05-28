---@class TuYang_Gameover_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field a_Count1 UTextBlock
---@field a_Count2 UTextBlock
---@field a_Count3 UTextBlock
---@field a_Count4 UTextBlock
---@field a_PlayerName1 UTextBlock
---@field a_PlayerName2 UTextBlock
---@field a_PlayerName3 UTextBlock
---@field a_PlayerName4 UTextBlock
---@field Background UImage
---@field DynaHorizontalBox_0 UDynaHorizontalBox
---@field HorizontalBox_0 UHorizontalBox
---@field HorizontalBox_48 UHorizontalBox
---@field HorizontalBox_49 UHorizontalBox
---@field HorizontalBox_50 UHorizontalBox
---@field HorizontalBox_51 UHorizontalBox
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_WinTeam UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field Logo UImage
---@field NewButton_Return UNewButton
---@field RightDown UImage
---@field RightUp UImage
---@field Rule1 UImage
---@field Rule2 UImage
---@field Rule3 UImage
---@field TextBlock_BastPlayerKill UTextBlock
---@field TextBlock_BestPlayer UTextBlock
---@field TextBlock_Num UTextBlock
---@field TextBlock_SecceedTeam UTextBlock
---@field TuYang_BPWidgetStatusBarIcon TuYang_BPWidgetStatusBarIcon_C
---@field TuYang_BPWidgetStatusBarIcon_0 TuYang_BPWidgetStatusBarIcon_C
---@field TuYang_BPWidgetStatusBarIcon_C_0 TuYang_BPWidgetStatusBarIcon_C
---@field TuYang_BPWidgetStatusBarIcon_C_1 TuYang_BPWidgetStatusBarIcon_C
---@field TuYang_BPWidgetStatusBarIcon_C_2 TuYang_BPWidgetStatusBarIcon_C
---@field UniformGridPanel_Items UUniformGridPanel
---@field Zhandi UVerticalBox
--Edit Below--
local TuYang_Gameover = { bInitDoOnce = false } 

TuYang_Gameover.EnemyList = {}
local Icon_ID1 = '/Game/Arts/UI/TableIcons/ProfessionResult_Icon/ZY_img_tujibing.ZY_img_tujibing'
local Icon_ID2 = '/Game/Arts/UI/TableIcons/ProfessionResult_Icon/ZY_img_houqinbing.ZY_img_houqinbing'
function TuYang_Gameover:Construct()
    UGCLog.Log("TuYang_Gameover_Construct")
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)

	local WeakSelf = WeakObjectPtr(self)
	self.ReturnToLobbyTimer = Timer.InsertTimer(
        1, 
        function() 
            local self = WeakSelf:Get()
            if UE.IsValid(self) then
                local TextBlock_Num = self.TextBlock_Num
                local SecondsText = TextBlock_Num:GetText()
                local Seconds = math.tointeger(SecondsText)
                if Seconds > 0 then
                    Seconds = Seconds - 1
                    TextBlock_Num:SetText(tostring(Seconds))
                else
                    Timer.RemoveTimer(self.ReturnToLobbyTimer)
                    UGCGameSystem.ReturnToLobby()
                end
            end
        end, 
        true
    )
	self.NewButton_Return.OnClicked:AddInstance(self.OnNewButton_ReturnClicked, self)
    local GameState  = UGCGameSystem.GetGameState() 
    if GameState.iWinTeamID == 1 then
        self.TextBlock_SecceedTeam:SetText("红方")
        self.Image_WinTeam:SetBrushFromTexture(UE.LoadObject(Icon_ID1),true)
    elseif GameState.iWinTeamID == 2 then
        self.TextBlock_SecceedTeam:SetText("紫方")
        self.Image_WinTeam:SetBrushFromTexture(UE.LoadObject(Icon_ID2),true)
    end

    local num = UGCGameSystem.GetPlayerNum()
    GameState = UGCGameSystem.GetGameState()
    --UGCLog.Log("TuYang_Gameover_Construct0",GameState.PlayerData)
    self.EnemyList = self:SortListEnemy(GameState.PlayerData)    
    --UGCLog.Log("TuYang_Gameover_Construct1",self.EnemyList)
    
    
    for i = 1,num do
		if i == 1 then
            self.a_PlayerName1:SetText(""..self:GetPlayerDataByKey(self.EnemyList[i]).Name)
            self.a_Count1:SetText(" "..self:GetPlayerDataByKey(self.EnemyList[i]).EnemyCount)
		elseif i==2 then
            self.a_PlayerName2:SetText(""..self:GetPlayerDataByKey(self.EnemyList[i]).Name)
            self.a_Count2:SetText(" "..self:GetPlayerDataByKey(self.EnemyList[i]).EnemyCount)

		elseif i==3 then
            self.a_PlayerName3:SetText(""..self:GetPlayerDataByKey(self.EnemyList[i]).Name)
            self.a_Count3:SetText(" "..self:GetPlayerDataByKey(self.EnemyList[i]).EnemyCount)

		elseif i==4 then
            self.a_PlayerName4:SetText(""..self:GetPlayerDataByKey(self.EnemyList[i]).Name)
            self.a_Count4:SetText(" "..self:GetPlayerDataByKey(self.EnemyList[i]).EnemyCount)
		end
		i = i+1
	end

    self.TextBlock_BestPlayer:SetText(""..self:GetPlayerDataByKey(self.EnemyList[1]).Name)
    self.TextBlock_BastPlayerKill:SetText(" "..self:GetPlayerDataByKey(self.EnemyList[1]).EnemyCount)
    --self.TextBlock_BastPlayerKill:SetText("1000")
    
    -- 玩家的buff 和 武器
    local IconIndex = 0
    self.UniformGridPanel_Items:ClearChildren()
    UGCLog.Log("TuYang_Gameover_Construct PlayerController",#(self:GetPlayerDataByKey(self.EnemyList[1]).BuffSkillList))
    for k, v in pairs(self:GetPlayerDataByKey(self.EnemyList[1]).BuffSkillList) do
        UGCLog.Log("TuYang_Gameover_Construct BuffList",tostring(v))
        local BaseClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/TuYang_BPWidgetStatusBarIcon.TuYang_BPWidgetStatusBarIcon_C'))
        local BuffItem = LuaExtendLibrary.NewLuaObject(self, BaseClass)
        BuffItem.Key = v
        local solt = self.UniformGridPanel_Items:AddChildToUniformGrid(BuffItem)
        local Row = math.floor(IconIndex / 3)
        local Col = IconIndex % 3
        solt:SetRow(Row)
        solt:SetColumn(Col)
        IconIndex = IconIndex + 1
    end
end


-- function TuYang_Gameover:Tick(MyGeometry, InDeltaTime)

-- end

-- function TuYang_Gameover:Destruct()

-- end
function TuYang_Gameover:OnNewButton_ReturnClicked()
    UGCGameSystem.ReturnToLobby()
end

function TuYang_Gameover:GetPlayerDataByKey(key)
    local GameState  = UGCGameSystem.GetGameState() 
    return GameState.PlayerData[key]
end

-- function TuYang_Gameover:SortListEnemy(List)
--     for i = 1, 3 do
--         for j = 1, 4 - i do
--             if self:GetPlayerDataByKey(List[j]) ~= nil and self:GetPlayerDataByKey(List[j+1]) ~= nil then
--                   -- 确保将EnemyCount转换为数值进行比较
--                 local currentCount = tonumber(self:GetPlayerDataByKey(List[j]).EnemyCount)
--                 local nextCount = tonumber(self:GetPlayerDataByKey(List[j+1]).EnemyCount)
--                 if currentCount < nextCount then
--                     -- 交换位置
--                     List[j], List[j+1] = List[j+1], List[j]
--                 end
--             end
--         end
--     end
--     return List
-- end

function TuYang_Gameover:SortListEnemy(List)
    local temp = {}
    local OutList = {}
    for k, v in pairs(List) do
        temp[k] = v.EnemyCount
    end
    temp = self:BubbleSort(temp)    
    return temp
end
function TuYang_Gameover:BubbleSort(tbl)
    -- 提取键到一个数组
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end

    local n = #keys
    local swapped
    repeat
        swapped = false
        for i = 1, n - 1 do
            local key1 = keys[i]
            local key2 = keys[i + 1]
            -- 比较对应的值
            if tbl[key1] < tbl[key2] then
                -- 交换键的位置
                keys[i], keys[i + 1] = keys[i + 1], keys[i]
                swapped = true
            end
        end
        n = n - 1
    until not swapped
    return keys
end







return TuYang_Gameover