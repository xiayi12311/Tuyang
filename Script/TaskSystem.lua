-- 任务处理系统 负责任务流程管理 不负责动画播放等表现 表现在PlayerController中实现
TaskSystem = TaskSystem or {
    ConditionTrackers = {}
}

-- [CS]根据TaskId查找TaskConfig
function TaskSystem.GetTaskConfigByTaskID(TaskID)
    return TableDataLoadTool:GetTableDataByRowName(ResourcesTools.GetUGCPath("Asset/CSV/TaskConfig.TaskConfig"), TaskID)
end

-- [S]触发任务：让任务变为可接受
function TaskSystem.TriggerTask(PlayerKey, TaskID)
    print_dev(string.format("TaskSystem.TriggerTask,PlayerKey is [%f],TaskID is [%f]",PlayerKey,TaskID));
    local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey)
    if PlayerState then
        PlayerState:AddNewCanReceiveTask(TaskID); 
        -- 服务端事件
        UGCEventSystem:SendEvent(TaskAndStoryEventDefine.OnTaskStateChange,PlayerKey, TaskID, ETaskState.WaitReceive);
        -- 客户端事件
        UnrealNetwork.CallUnrealRPC(PlayerState, PlayerState, "ClientRPC_TaskChangeState", TaskID, ETaskState.WaitReceive);
        -- 播放触发任务过场动画
        local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskID);
        if TaskConfig ~= nil then
            if TaskConfig.TaskTriggerSequence ~= "" then
                local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
                if PlayerController then
                    UnrealNetwork.CallUnrealRPC(PlayerController, PlayerController, "ClientRPC_PlayLevelSequence", TaskConfig.TaskTriggerSequence, TaskID, ETaskState.WaitReceive);
                else
                    print("TaskSystem.TriggerTask Cant find PlayerController with PlayerKey :" .. tostring(PlayerKey));        
                end
            end
        else
            print("TaskSystem.TriggerTask Cant find TaskConfig with TaskId :" .. tostring(TaskID));        
        end
    end
end

-- [S]接任务
function TaskSystem.ReceiveTask(PlayerKey,TaskID)
    print_dev(string.format("TaskSystem.ReceiveTask,PlayerKey is [%f],TaskID is [%f]",PlayerKey,TaskID));
    local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey)
    if PlayerState then
        -- 判断是否是重复接任务
        local TaskExistInstance = PlayerState.TaskMap[TaskID];
        if TaskExistInstance ~= nil and TaskExistInstance.TaskState == ETaskState.InProgress then
            print("TaskSystem.ReceiveTask But Task is InProgress,TaskID is:" .. tostring(TaskID));
            return;
        end
        -- 根据TaskId创建一个任务实例
        local TaskInstance = {};
        -- 初始化任务实例
        local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskID);
        if TaskConfig ~= nil then
            TaskInstance.TaskID = TaskConfig.TaskID;
            -- 初始化任务目标和进度
            TaskInstance.TaskCompleteProgress = {};
            TaskInstance.TaskFailedProgress = {};
            -- 为每个任务条件初始化任务进度
            for Index, type in ipairs(TaskConfig.TaskCompleteConditionType_StrArr) do
                TaskInstance.TaskCompleteProgress[Index] = {CurrentProgress = 0, MaxProgress = TaskConfig.TaskCompleteTargetProgress_IntArr[Index]};
            end
            for Index, type in ipairs(TaskConfig.TaskFailedConditionType_StrArr) do
                TaskInstance.TaskFailedProgress[Index] = {CurrentProgress = 0, MaxProgress = TaskConfig.TaskFailedTargetProgress_IntArr[Index]};
            end
            TaskInstance.TaskCompleteTimes = 0;
            -- 执行任务激活行为
            TaskSystem.TaskSettlement(PlayerKey, TaskConfig.TaskStartActivityType_StrArr,TaskConfig.TaskStartActivityTarget_IntArr,TaskConfig.TaskStartActivityNum_IntArr)
            -- 通过PlayeyKey找到PlayerState
            local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
            -- 在PlayerState中将任务加进去
            local IsReActive = PlayerState:AddNewTask(TaskInstance);
            -- 判断是否是重新激活的任务
            if IsReActive then
                -- 发送重新激活任务事件
                UGCEventSystem:SendEvent(TaskAndStoryEventDefine.ReActiveTaskEvent,PlayerKey, TaskID);
            end
            -- 开始追踪任务条件
            TaskSystem.StartTrackingTaskConditions(PlayerKey, TaskInstance)
            -- 播放激活任务过场动画
            if TaskConfig.TaskActiveSequence ~= "" then
                local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
                if PlayerController then
                    UnrealNetwork.CallUnrealRPC(PlayerController, PlayerController, "ClientRPC_PlayLevelSequence", TaskConfig.TaskActiveSequence, TaskID, ETaskState.InProgress);
                else
                    print("TaskSystem.ReceiveTask Cant find PlayerController with PlayerKey :" .. tostring(PlayerKey));        
                end
            end
        else
            print("TaskSystem.ReceiveTask Cant find TaskConfig with TaskId :" .. tostring(TaskID));        
        end
    else
        print("TaskSystem.ReceiveTask playerState is nil");
    end
end

function TaskSystem.StartTrackingTaskConditions(playerKey, taskInstance)
    log_tree_dev("TaskSystem.StartTrackingTaskConditions", taskInstance)
    local taskConfig = TaskSystem.GetTaskConfigByTaskID(taskInstance.TaskID)
    -- 开始跟踪任务完成条件
    for Index, type in pairs(taskConfig.TaskCompleteConditionType_StrArr) do
        local tracker = {
            playerKey = playerKey,
            taskId = taskInstance.TaskID,
            conditionIndex = Index,
            IsCompleteProgress = true,
            targetId = taskConfig.TaskCompleteConditionTargetId_IntArr[Index]
        }
        TaskSystem.AddConditionTracker(type, tracker)
    end
    -- 开始跟踪任务失败条件
    for Index, type in pairs(taskConfig.TaskFailedConditionType_StrArr) do
        local tracker = {
            playerKey = playerKey,
            taskId = taskInstance.TaskID,
            conditionIndex = Index,
            IsCompleteProgress = false,
            targetId = taskConfig.TaskFailedConditionTargetId_IntArr[Index]
        }
        TaskSystem.AddConditionTracker(type, tracker)
    end
end

function TaskSystem.AddConditionTracker(conditionType, tracker)
    log_tree_dev("TaskSystem.AddConditionTracker",tracker)
    print("TaskSystem.AddConditionTracker, conditionType is:" .. conditionType);
    local meta_index = require(ETaskConditionTrackerLuaModule[conditionType])
    setmetatable(tracker, {__index = meta_index})
    local key = string.format("%s_%d_%d_%s", tracker.playerKey, tracker.taskId, tracker.conditionIndex, tostring(tracker.IsCompleteProgress))
    print_dev("TaskSystem.AddConditionTracker key: "..key)
    TaskSystem.ConditionTrackers[key] = tracker
    tracker:StartTracking()
end

function TaskSystem.RemoveConditionTracker(playerKey, taskId, conditionIndex, isCompleteProgress)
    local key = string.format("%s_%d_%d_%s", playerKey, taskId, conditionIndex, tostring(isCompleteProgress))
    print_dev("TaskSystem.RemoveConditionTracker key: "..key)
    if TaskSystem.ConditionTrackers[key].StopTracking then
        TaskSystem.ConditionTrackers[key]:StopTracking()
    end
    TaskSystem.ConditionTrackers[key] = nil
end

-- [S] tracker调用此函数更新任务进度
function TaskSystem.UpdateTaskProgressForTracker(tracker, ChangeCount)
    log_tree_dev("TaskSystem.UpdateTaskProgressForTracker",tracker)
    TaskSystem.ChangeTaskProgress(tracker.playerKey, tracker.taskId, tracker.conditionIndex, ChangeCount, tracker.IsCompleteProgress)
end

-- [S] 变化任务进度
function TaskSystem.ChangeTaskProgress(PlayerKey, TaskID, TaskConditionIndex, ChangeCount, IsCompleteProgress)
    print_dev(string.format("TaskSystem.ChangeTaskProgress,PlayerKey is:[%d], TaskID is[%d], TaskConditionIndex is:[%d], ChangeCount is:[%d], IsCompleteProgress is:[%s]", PlayerKey,TaskID, TaskConditionIndex,ChangeCount, tostring(IsCompleteProgress)));
    local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
    if PlayerState then
        local TaskInstance = PlayerState.TaskMap[TaskID];
        if TaskInstance then
            local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskID)
            if not TaskConfig then
                print("TaskSystem.ChangeTaskProgress can find TaskConfig with TaskID:" .. tostring(TaskID));
                return;
            end
            -- 只有进行中的任务可以变化任务进度
            if TaskInstance.TaskState == ETaskState.InProgress then
                if IsCompleteProgress then
                    if TaskInstance.TaskCompleteProgress[TaskConditionIndex] ~= nil then
                        -- 增加任务进度
                        TaskInstance.TaskCompleteProgress[TaskConditionIndex].CurrentProgress = TaskInstance.TaskCompleteProgress[TaskConditionIndex].CurrentProgress + ChangeCount;
                        -- 限制任务进度不能超过最大进度
                        if TaskInstance.TaskCompleteProgress[TaskConditionIndex].CurrentProgress >= TaskInstance.TaskCompleteProgress[TaskConditionIndex].MaxProgress then
                            TaskInstance.TaskCompleteProgress[TaskConditionIndex].CurrentProgress = TaskInstance.TaskCompleteProgress[TaskConditionIndex].MaxProgress;
                            TaskSystem.RemoveConditionTracker(PlayerKey, TaskID, TaskConditionIndex, true)
                        end
                    else
                        print("Task CompleteProgress Cant find TaskConditionIndex Condition, TaskID is:" .. tostring(TaskID) .. "TaskConditionIndex is:" .. tostring(TaskConditionIndex));
                    end
                else
                    if TaskInstance.TaskFailedProgress[TaskConditionIndex] ~= nil then
                        print_dev("TaskSystem.ChangeTaskProgress change failed Count,CurrentProgress is: " .. tostring(TaskInstance.TaskFailedProgress[TaskConditionIndex].CurrentProgress .. ",Count is:" .. tostring(ChangeCount) .. ",MaxCount is:" .. tostring(TaskInstance.TaskFailedProgress[TaskConditionIndex].MaxProgress)));
                        -- 增加任务失败进度
                        TaskInstance.TaskFailedProgress[TaskConditionIndex].CurrentProgress = TaskInstance.TaskFailedProgress[TaskConditionIndex].CurrentProgress + ChangeCount;
                        -- 限制任务失败进度不能超过最大进度
                        if TaskInstance.TaskFailedProgress[TaskConditionIndex].CurrentProgress >= TaskInstance.TaskFailedProgress[TaskConditionIndex].MaxProgress then
                            TaskInstance.TaskFailedProgress[TaskConditionIndex].CurrentProgress = TaskInstance.TaskFailedProgress[TaskConditionIndex].MaxProgress;
                            TaskSystem.RemoveConditionTracker(PlayerKey, TaskID, TaskConditionIndex, false)
                        end
                    else
                        print("Task TaskFailedProgress Cant find TaskConditionIndex Condition, TaskID is:" .. tostring(TaskID) .. "TaskConditionIndex is:" .. tostring(TaskConditionIndex));
                    end
                end
                -- 检查任务是否完成
                local TaskState = TaskSystem.CheckTaskComplete(PlayerKey, TaskID);
                if TaskState == ETaskState.CompleteWaitCommit or TaskState == ETaskState.FailedWaitCommit then
                    -- 播放过场动画
                    if TaskState == ETaskState.CompleteWaitCommit then
                        -- 播放达到任务完成条件过场动画
                        if TaskConfig.TaskCompleteSequence ~= "" then
                            local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
                            if PlayerController then
                                UnrealNetwork.CallUnrealRPC(PlayerController, PlayerController, "ClientRPC_PlayLevelSequence", TaskConfig.TaskCompleteSequence, TaskID, ETaskState.CompleteWaitCommit);
                            else
                                print("TaskSystem.ChangeTaskProgress Complete Cant find PlayerController with PlayerKey :" .. tostring(PlayerKey));        
                            end
                        else
                            print("TaskConfig.TaskCompleteSequence is Empty,TaskConfig.TaskCompleteSequence is:" .. TaskConfig.TaskCompleteSequence);
                        end            
                    else
                        -- 播放达到任务失败条件过场动画
                        if TaskConfig.TaskFailedSequence ~= "" then
                            local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
                            if PlayerController then
                                UnrealNetwork.CallUnrealRPC(PlayerController, PlayerController, "ClientRPC_PlayLevelSequence", TaskConfig.TaskFailedSequence, TaskID, ETaskState.FailedWaitCommit);
                            else
                                print("TaskSystem.ChangeTaskProgress Failed Cant find PlayerController with PlayerKey :" .. tostring(PlayerKey));        
                            end
                        end
                    end
                    -- 更新任务状态
                    print("TaskSystem.ChangeTaskProgress task commit state:" .. tostring(TaskState));
                    PlayerState:SetTaskState(TaskID, TaskState);
                    -- 判断是否需要自动提交任务
                    if (TaskState == ETaskState.CompleteWaitCommit and TaskConfig.TaskCompleteTargetID == 0) or (TaskState == ETaskState.FailedWaitCommit and TaskConfig.TaskFailedTargetID == 0) then
                        -- 没有交任务NPCID 则自动提交任务
                        TaskSystem.TaskCommit(PlayerKey, TaskID);
                    end
                end
            else
                print("TaskSystem.ChangeTaskProgress trying to change progress for state:" .. tostring(TaskInstance.TaskState));
            end
        else
            print("TaskSystem.ChangeTaskProgress This Player Dont has the Task,Player Key  :" .. tostring(PlayerKey) .. ", TaskID is: " .. tostring(TaskID));
        end
    else
        print("TaskSystem.ChangeTaskProgress PlayerState is nil");
    end
end

-- [S]检查前置任务是否完成
function TaskSystem.CheckPreTaskIsComplete(PlayerKey, TaskID)
    print_dev(string.format("TaskSystem.CheckPreTaskIsComplete,TaskID is[%f]",TaskID));
    local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
    if PlayerState then
        -- 获取TaskConfig
        local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskID)
        if TaskConfig then
            -- 获取前置任务ID
            local TaskPreTaskID_IntArr = TaskConfig.TaskPreTaskID_IntArr;
            -- 获取前置任务需要的完成情况
            local TaskPreTaskCondition_StrArr = TaskConfig.TaskPreTaskCondition_StrArr;
            -- 遍历前置任务ID
            for PreIndex, PreTaskID in pairs(TaskPreTaskID_IntArr) do
                local HasCompletePreTask = false;
                -- 在我们接过的所有任务里面遍历查找是否有前置任务ID
                for _, TaskInstance in pairs(PlayerState.TaskMap) do
                    if PreTaskID == TaskInstance.TaskID then
                        -- 判断我们任务的状态是否符合前置任务的要求
                        if TaskInstance.TaskState == TaskPreTaskCondition_StrArr[PreIndex] then
                            HasCompletePreTask = true;
                            break;
                        end
                    end
                end
                -- 只要有一个前置不符合就直接判定未完成
                if HasCompletePreTask == false then
                    return false;
                end
            end
            -- 能成功出循环就说明前置条件全部完成
            return true;
        else
            print("TaskSystem.CheckPreTaskIsComplete can find TaskConfig with TaskID:" .. tostring(TaskID));
        end
    else
        print("TaskSystem.CheckPreTaskIsComplete PlayerState is Nil");
    end
end

-- [S]检查玩家任务是否完成或失败
function TaskSystem.CheckTaskComplete(PlayerKey, TaskID)
    print_dev(string.format("TaskSystem.CheckTaskComplete,PlayerKey is [%f],TaskID is [%f]",PlayerKey,TaskID));
    local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
    if PlayerState then
        -- 获取客户端TaskInstance
        local TaskInstance = PlayerState.TaskMap[TaskID];
        if TaskInstance then
            -- 只有进行中的任务可以检查是否完成
            if TaskInstance.TaskState == ETaskState.InProgress then
                -- 判断是否成功
                local TaskIsComplete = true;
                for _,TaskProgressTable  in pairs(TaskInstance.TaskCompleteProgress) do
                    -- 如果有任意完成条件不满足，则任务没有完成
                    if TaskProgressTable.CurrentProgress < TaskProgressTable.MaxProgress then
                        TaskIsComplete = false;
                        break;
                    end
                end

                -- 判断是否失败 这里用计数是防止当没有失败条件的时候直接判定为失败
                local FailedConditionNum = 0
                local AllFailedConditionNum = 0;
                for _,TaskProgressTable in pairs(TaskInstance.TaskFailedProgress) do
                    -- 任务失败一条就计数一次
                    if TaskProgressTable.CurrentProgress >= TaskProgressTable.MaxProgress then
                        FailedConditionNum = FailedConditionNum + 1;
                    end
                    AllFailedConditionNum = AllFailedConditionNum + 1;
                end
                -- 判断任务是否完成或失败 完成优先
                if TaskIsComplete then
                    -- 任务已经完成
                    return ETaskState.CompleteWaitCommit;
                elseif AllFailedConditionNum ~= 0 and FailedConditionNum == AllFailedConditionNum then
                    -- 任务失败
                    return ETaskState.FailedWaitCommit;
                end
            end
        else
            print("TaskSystem.CheckTaskComplete This Player Dont has the Task,Player Key  :" .. tostring(PlayerKey) .. ", TaskID is: " .. tostring(TaskID));
        end
    end
    return 0;
end

-- [S]任务交付
function TaskSystem.TaskCommit(PlayerKey, TaskID)
    print_dev(string.format("TaskSystem.TaskCommit,PlayerKey is [%f],TaskID is [%f]",PlayerKey,TaskID));
    local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
    if PlayerState then
        -- 获取TaskConfig
        local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskID)
        if TaskConfig then
            -- 检查一下任务是否是可交付状态
            local TaskInstance = PlayerState.TaskMap[TaskID];
            if TaskInstance then
                if TaskInstance.TaskState == ETaskState.CompleteWaitCommit then
                    -- 完成任务
                    PlayerState:SetTaskState(TaskID, ETaskState.Complete);
                    -- 任务计数+1
                    TaskInstance.TaskCompleteTimes = TaskInstance.TaskCompleteTimes + 1;
                    -- 任务结算
                    TaskSystem.TaskSettlement(PlayerKey,TaskConfig.TaskCompleteActivityType_StrArr,TaskConfig.TaskCompleteActivityTarget_IntArr,TaskConfig.TaskCompleteActivityNum_IntArr);
                    -- 获得后续任务
                    local TaskFollowedTaskID_IntArr = TaskConfig.TaskFollowedTaskID_IntArr;
                    for index,FollowedTaskID in ipairs(TaskFollowedTaskID_IntArr) do
                        -- 判断后续任务的前置任务是否都已经完成
                        if TaskSystem.CheckPreTaskIsComplete(PlayerKey, FollowedTaskID) then
                            -- 查找该FollowedTaskConfig
                            local FollowedTaskConfig = TaskSystem.GetTaskConfigByTaskID(FollowedTaskID);
                            if FollowedTaskConfig then
                                -- 如果任务不是开发者手动触发 则将后续任务添加到可接受任务列表中 并且判断是否可以直接领取
                                if not FollowedTaskConfig.TaskNeedPlayerReceive then
                                    -- 触发任务 将该任务重新加入到可接受任务列表中
                                    TaskSystem.TriggerTask(PlayerKey, FollowedTaskID); 
                                    -- 如果没有领取任务NPC 则直接接受任务
                                    if FollowedTaskConfig.TaskReceiveTargetID == 0 then
                                        TaskSystem.ReceiveTask(PlayerKey,FollowedTaskID)
                                     end
                                end
                            else
                                print("TaskSystem.TaskComplete can find FollowedTaskConfig with TaskID:" .. tostring(FollowedTaskID));
                            end
                        end
                    end
                    -- 判断是否是循环任务 循环任务完成后添加到可接受列表
                    if TaskConfig.TaskIsCycle then
                        PlayerState:AddNewCanReceiveTask(TaskID);
                    end
                elseif TaskInstance.TaskState == ETaskState.FailedWaitCommit then
                    -- 任务失败
                    PlayerState:SetTaskState(TaskID, ETaskState.Failed);
                    -- 任务失败暂时没有结算
                    TaskSystem.TaskSettlement(PlayerKey,TaskConfig.TaskFailedActivityType_StrArr,TaskConfig.TaskFailedActivityTarget_IntArr,TaskConfig.TaskFailedActivityNum_IntArr);
                    -- 任务失败是否重新开始任务
                    if TaskConfig.TaskCanRestart then
                        print_dev("TaskFailed And ReReceive Task ,TaskID is:" .. tostring(TaskID));
                        -- 重新触发任务 将该任务重新加入到可接受任务列表中
                        TaskSystem.TriggerTask(PlayerKey, TaskID);
                        -- 如果没有领取任务NPC 则直接接受任务
                        if TaskConfig.TaskReceiveTargetID == 0 then
                            TaskSystem.ReceiveTask(PlayerKey,TaskID)
                        end
                    end
                end

                print_dev("TaskState is :" .. TaskInstance.TaskState .. ", TaskCanRestart is:" .. tostring(TaskConfig.TaskCanRestart) .. ",TaskIsCycle :" .. tostring(TaskConfig.TaskIsCycle));
                -- 不是循环任务或者失败可重接的任务 则判定为任务结束
                if (TaskInstance.TaskState == ETaskState.Failed and not TaskConfig.TaskCanRestart) or (TaskInstance.TaskState == ETaskState.Complete and not TaskConfig.TaskIsCycle) then
                    print_dev("TaskConfig.TaskCloseSequence is:" .. TaskConfig.TaskCloseSequence);
                    -- 播放任务结束过场动画
                    if TaskConfig.TaskCloseSequence ~= "" then
                        local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
                        if PlayerController then
                            UnrealNetwork.CallUnrealRPC(PlayerController, PlayerController, "ClientRPC_PlayLevelSequence", TaskConfig.TaskCloseSequence, TaskID, ETaskState.Finished);
                        else
                            print("TaskSystem.TaskCommit Cant find PlayerController with PlayerKey :" .. tostring(PlayerKey));        
                        end
                    end 
                end
            else
                print("TaskSystem.TaskComplete This Player Dont has the Task,Player Key  :" .. tostring(PlayerKey) .. ", TaskID is: " .. tostring(TaskID));
            end
        else
            print("TaskSystem.TaskComplete can find TaskConfig with TaskID:" .. tostring(TaskID));
        end
    end
end

-- [S]获得奖励（包括接受任务和完成任务的）
function TaskSystem.TaskSettlement(PlayerKey, TaskCompleteActivityType_StrArr, TaskCompleteActivityTarget_IntArr, TaskCompleteActivityNum_IntArr)
    print("TaskSystem.TaskSettlement");
    for index,TaskFinishActivityType in pairs(TaskCompleteActivityType_StrArr) do
        local TaskFinishActivityTarget = TaskCompleteActivityTarget_IntArr[index];
        local TaskFinishActivityNum =  TaskCompleteActivityNum_IntArr[index];
        if TaskFinishActivityType == ETaskSettlementType.GetItem then
            local PlayerPawn = UGCGameSystem.GetPlayerPawnByPlayerKey(PlayerKey)
            if PlayerPawn then
                UGCBackPackSystem.AddItem(PlayerPawn, tonumber(TaskFinishActivityTarget) , tonumber(TaskFinishActivityNum))
            else
                print("TaskSystem.TaskSettlement ERROR : can't find playerPawn by playerKey : " .. PlayerKey);
            end
        elseif TaskFinishActivityType == ETaskSettlementType.LostItem then
            local PlayerPawn = UGCGameSystem.GetPlayerPawnByPlayerKey(PlayerKey)
            if PlayerPawn then
                UGCBackPackSystem.DropItem(PlayerPawn, tonumber(TaskFinishActivityTarget) , tonumber(TaskFinishActivityNum),true)
            else
                print("TaskSystem.TaskSettlement ERROR : can't find playerPawn by playerKey : " .. PlayerKey);
            end
        elseif TaskFinishActivityType == ETaskSettlementType.AddMoney then
            local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
            if PlayerState then
                PlayerState.TaskCoin = PlayerState.TaskCoin + tonumber(TaskFinishActivityNum)
            else
                print("TaskSystem.TaskSettlement ERROR : can't find PlayerState by playerKey : " .. PlayerKey);
            end
        elseif TaskFinishActivityType == ETaskSettlementType.AddScore then
            local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
            if PlayerState then
                PlayerState.TaskScore = PlayerState.TaskScore + tonumber(TaskFinishActivityNum)
            else
                print("TaskSystem.TaskSettlement ERROR : can't find PlayerState by playerKey : " .. PlayerKey);
            end
        elseif TaskFinishActivityType == ETaskSettlementType.SetMoney then
            local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
            if PlayerState then
                PlayerState.TaskCoin = tonumber(TaskFinishActivityNum)
            else
                print("TaskSystem.TaskSettlement ERROR : can't find PlayerState by playerKey : " .. PlayerKey);
            end
        elseif TaskFinishActivityType == ETaskSettlementType.SetScore then
            local PlayerState = UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey);
            if PlayerState then
                PlayerState.TaskScore = tonumber(TaskFinishActivityNum)
            else
                print("TaskSystem.TaskSettlement ERROR : can't find PlayerState by playerKey : " .. PlayerKey);
            end
        else
            print("TaskSystem.TaskSettlement TaskFinishActivityType Cant Find, TaskFinishActivityType is:" .. TaskFinishActivityType);
        end
    end
end

-- [CS]根据ObjectID和ObjectType筛选出所有可以交互的任务
function TaskSystem.GetAllInteractableTaskFromObjectID(PlayerState, ObjectType, ObjectID)
    print_dev(string.format("TaskSystem.TaskCommit,PlayerKey is [%f],ObjectType is [%s],ObjectID is [%f]",PlayerState.PlayerKey,ObjectType,ObjectID));
    local InteractableTaskList = {};

    -- 查找是否有和这个ID关联的可接受任务
    for index, TaskID in ipairs(PlayerState.CanReceiveTaskIDList) do
        local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskID);
        if TaskConfig then
            -- 如果可接受任务里面接受任务需要的ID和传来的ID一致且ID的类型一致，则说明这里可以接受这个任务
            if TaskConfig.TaskReceiveTargetID == ObjectID and TaskConfig.TaskReceiveTargetType == ObjectType then
                table.insert(InteractableTaskList, {TaskID = TaskID, TaskState = ETaskState.WaitReceive});
            end
        else
            print("TaskSystem.GetAllCanReceiveTaskIDFromObjectID Cant find TaskConfig with TaskId :" .. tostring(TaskID));   
        end
    end

    -- 查找是否有和这个ID关联的进行中任务和可提交任务
    for _, TaskInstance in pairs(PlayerState.TaskMap) do
        local TaskConfig = TaskSystem.GetTaskConfigByTaskID(TaskInstance.TaskID);
        if TaskConfig then
            -- 如果是NPC类型，则需要将有完成对话的任务条件的关联任务返回
            if ObjectType == EInteractTargetType.NPC then
                -- 如果是进行中，判断任务目标中是否有完成对话目标
                if TaskInstance.TaskState == ETaskState.InProgress then
                    for Index, TaskCompleteConditionType in ipairs(TaskConfig.TaskCompleteConditionType_StrArr) do
                        if TaskCompleteConditionType == ETaskConditionType.FinishTalk then
                            -- 完成对话的NPCID是否和传进来的ID一致
                            if TaskConfig.TaskCompleteConditionTargetId_IntArr[Index] == ObjectID then
                                table.insert(InteractableTaskList, {TaskID = TaskInstance.TaskID, TaskState = ETaskState.InProgress});
                            end
                        end
                    end
                end
            end
            -- 如果是完成待提交 则判断提交对应的ObjectID是不是传进来的ID和类型是否一致
            if TaskInstance.TaskState == ETaskState.CompleteWaitCommit and TaskConfig.TaskCompleteTargetID == ObjectID and TaskConfig.TaskCompleteTargetType == ObjectType then
                table.insert(InteractableTaskList, {TaskID = TaskInstance.TaskID, TaskState = ETaskState.CompleteWaitCommit});
            elseif TaskInstance.TaskState == ETaskState.FailedWaitCommit and TaskConfig.TaskFailedTargetID == ObjectID and TaskConfig.TaskFailedTargetType == ObjectType then
                table.insert(InteractableTaskList, {TaskID = TaskInstance.TaskID, TaskState = ETaskState.FailedWaitCommit});
            end
        else
            print("TaskSystem.GetAllCanReceiveTaskIDFromObjectID Cant find TaskConfig with TaskId :" .. tostring(TaskInstance.TaskID));   
        end
    end
    log_tree_dev("GetAllInteractableTaskFromObjectID",InteractableTaskList);
    return InteractableTaskList;
end

-- [CS]当前任务是否是结局任务
function TaskSystem.IsEndingTask(taskId)
    -- return taskId == 2 or taskId == 4 or taskId == 5
    return taskId == 4 or taskId == 5
end
