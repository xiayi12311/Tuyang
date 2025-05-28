---@class Task_TankStartFight_C:BTTask_LuaBase
--Edit Below--
local Task_TankStartFight = {}

-- -- entry point, task will stay active until FinishExecute is called
function Task_TankStartFight:ReceiveExecuteAI(OwnerController, ControlledPawn)
    ugcprint("tank start fight")
    --if not self:HasAuthority() then
    ControlledPawn:StartFight()
    --end
	self:FinishExecute(true)
end

-- -- tick function
-- function Task_TankStartFight:ReceiveTickAI(OwnerController, ControlledPawn, DeltaSeconds)

-- end

-- -- if lua contains this event, task will stay active until FinishAbort is called
-- function Task_TankStartFight:ReceiveAbortAI(OwnerController, ControlledPawn)
-- 	self:FinishAbort()
-- end

return Task_TankStartFight