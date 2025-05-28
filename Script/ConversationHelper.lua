ConversationHelpler = ConversationHelpler or {};

function ConversationHelpler.LoadConversationConfigTable()
    return TableDataLoadTool:GetFullTableData(ResourcesTools.GetUGCPath("Asset/CSV/ConversationConfig.ConversationConfig"))
end

function ConversationHelpler.HasChatOption(NPCId)
    local conversationConfigTable = ConversationHelpler.LoadConversationConfigTable()
    for _, config in pairs(conversationConfigTable) do
        if config.NPCId == NPCId and config.TaskId == 0 then
            return true
        end
    end
    return false
end

function ConversationHelpler.GetConversationForTask(NPCId, taskId, taskState)
    local conversationConfigTable = ConversationHelpler.LoadConversationConfigTable()
    for _, config in pairs(conversationConfigTable) do
        if config.NPCId == NPCId and config.TaskId == taskId then
            if taskId == 0 or config.TaskState == taskState then
                return config
            end
        end
    end
    return nil
end

function ConversationHelpler.GetConversationLine(lineId)
    return TableDataLoadTool:GetTableDataByRowName(ResourcesTools.GetUGCPath("Asset/CSV/ConversationLinesConfig.ConversationLinesConfig"), lineId)
end