--任务剧情模板事件
TaskAndStoryEventDefine = {
    ----------------------------------------- Server Only----------------------------------------------------
    OnKillPlayer = 101;
    OnEnterArea = 102;
    OnLeaveArea = 103;
    OnKillMonster = 104;
  	OnPickupItem = 105;                            -- 捡到物品
  	OnBackpackItemChanged = 106;                   -- 背包物品数量改变
    ---------------------------------------Server & Client--------------------------------------------------
    ReActiveTaskEvent = 201;                            -- 重新激活任务事件
    OnTaskStateChange = 202;                            -- 任务状态变化
    PlayerFinishedConversation = 203;                   -- 玩家完成对话

-----------------------------------------Client Only ----------------------------------------------------
    OnTaskDataInitComplete = 303;                       -- 任务数据初始化完成
    OnRepTaskMap = 304;                                 -- OnRep_TaskMap调用时触发
    OnRepCanReceiveTaskIDList = 305;                    -- OnRep_CanReceiveTaskIDList调用时触发
    OnLevelSequenceStop = 306;                          -- 过场动画播放完毕 
}
TaskAndStoryEventDefine = TaskAndStoryEventDefine or {}; 