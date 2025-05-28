local BTCondition_HasPlay = {}

-- -- called when testing if underlying node can be executed
function BTCondition_HasPlay:PerformConditionCheckAI(OwnerController, ControlledPawn)
	ugcprint("Test Condition！")
    if ControlledPawn:IsHasPlay() then
        ControlledPawn:SetHasPlay(true)
        local MyBlack = OwnerController:GetBlackBoardComponent();
        --local MoveActor = MyBlack:GetValueAsObject("MoveActor");--Target
        local MoveActor = ControlledPawn:GetMoveActor()
        MyBlack:SetValueAsObject("MoveActor",MoveActor)
--     --local Fvector = MyTarget:GetLocation()
--     self
--     MyBlack:SetValueAsObject("AimTarget",AimTarget)
        return true
    else
        return false
    end
end

-- -- tick function
-- function BTCondition_HasPlay:ReceiveTickAI(OwnerController, ControlledPawn, DeltaSeconds)

-- end

-- -- called on execution of underlying node
-- function BTCondition_HasPlay:ReceiveExecutionStartAI(OwnerController, ControlledPawn)

-- end

-- -- called when execution of underlying node is finished
-- function BTCondition_HasPlay:ReceiveExecutionFinishAI(OwnerController, ControlledPawn, NodeResult)

-- end

-- -- called when observer is activated (flow controller)
-- function BTCondition_HasPlay:ReceiveObserverActivatedAI(OwnerController, ControlledPawn)

-- end

-- -- called when observer is deactivated (flow controller)
-- function BTCondition_HasPlay:ReceiveObserverDeactivatedAI(OwnerController, ControlledPawn)

-- end

return BTCondition_HasPlay