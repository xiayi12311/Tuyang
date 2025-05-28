local SetAim = {}

-- -- entry point, task will stay active until FinishExecute is called
function SetAim:ReceiveExecuteAI(OwnerController, ControlledPawn)
    ugcprint("Before Throw Start")
    ControlledPawn:SetTarget();

    self:FinishExecute(true)
end

-- -- tick function
-- function SetAim:ReceiveTickAI(OwnerController, ControlledPawn, DeltaSeconds)

-- end

-- -- if lua contains this event, task will stay active until FinishAbort is called
-- function SetAim:ReceiveAbortAI(OwnerController, ControlledPawn)
-- 	self:FinishAbort()
-- end

return SetAim