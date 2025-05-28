local Shoot_Dynamic = {}

-- -- entry point, task will stay active until FinishExecute is called
function Shoot_Dynamic:ReceiveExecuteAI(OwnerController, ControlledPawn)
    ugcprint("Shoot Dy Start")
    ControlledPawn:ShootBullet()
	self:FinishExecute(true)
end

-- -- tick function
-- function Shoot_Dynamic:ReceiveTickAI(OwnerController, ControlledPawn, DeltaSeconds)

-- end

-- -- if lua contains this event, task will stay active until FinishAbort is called
-- function Shoot_Dynamic:ReceiveAbortAI(OwnerController, ControlledPawn)
-- 	self:FinishAbort()
-- end

return Shoot_Dynamic