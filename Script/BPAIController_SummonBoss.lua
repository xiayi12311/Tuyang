---@class BPAIController_SummonBoss_C:BPAIController_Summon_C
--Edit Below--

local BPAIController_Summon = require("Script.BPAIController_Summon")
local BPAIController_SummonBoss = setmetatable({}, { __index = BPAIController_Summon, __metatable = BPAIController_Summon, })

function BPAIController_SummonBoss:GetBehaviorTreeObjectPath()
    return string.format([[BehaviorTree'%sAsset/BT_SummonBoss.BT_SummonBoss']], UGCMapInfoLib.GetRootLongPackagePath())
end

return BPAIController_SummonBoss