UGCDropItemMgr = UGCDropItemMgr or {}
UGCDropItemMgr.WrapperDict = {}
require("Script.VectorHelper")
--UGCGameState = require("Script.BPGameState_ProtectAthena")
--UGCGameState = require("Script.Blueprint.UGCGameState")
function UGCDropItemMgr.SpawnItems(ItemList, Pos, Rot, Radius, LiftTime)
    if ItemList == nil then
        return
    end
    for k,v in pairs(ItemList) do
        UGCDropItemMgr.SpawnItem(v, Pos, Rot, Radius, LiftTime)
    end
end

--刷物品

--刷物品
function UGCDropItemMgr.SpawnItem(ItemData, Pos, Rot, Radius, LiftTime)
    local WrapperClass = UGCDropItemMgr.GetWrapperClass(ItemData.ItemID)
    if WrapperClass == nil then
        return nil
    end
    --local RandomPos = VectorHelper.RandomVector(Pos, Radius)
    local RandomPos = VectorHelper.ChangePos(Pos)
    local RandomRot = VectorHelper.RandomRotatorYaw(Rot)
    --local Pos = UGCGameState:FindCanDropPosLite(RandomPos)
    
    local PickupWrapper = ScriptGameplayStatics.SpawnActor(UGCGameSystem.GameState, WrapperClass, RandomPos, Rot, VectorHelper.ScaleOne());
    
    PickupWrapper.Count = ItemData.Count;
    if LiftTime ~= nil then
        PickupWrapper:SetLifeSpan(LiftTime)
    end

    if ItemData.Concomitants ~= nil then
        for k,v in pairs(ItemData.Concomitants) do
            UGCDropItemMgr.SpawnConcomitantItem(v, RandomPos, RandomRot, 50)
        end
    end
end

--刷伴生物

function UGCDropItemMgr.SpawnConcomitantItem(ConcomitantData, Pos, Rot, Radius)
    local WrapperClass = UGCDropItemMgr.GetWrapperClass(ConcomitantData.ItemID)
    if WrapperClass == nil then
        return nil
    end

    local RealConcomitantNum = math.random(ConcomitantData.CountMin, ConcomitantData.CountMax);

    for i = 1, RealConcomitantNum do
        local RandomPos = VectorHelper.RandomVector(Pos, Radius)
        local RandomRot = VectorHelper.RandomRotatorYaw(Rot)
        local Pos = UGCGameSystem.GameState:FindCanDropPosLite(RandomPos)
        local PickupWrapper = ScriptGameplayStatics.SpawnActor(UGCGameSystem.GameState, WrapperClass, Pos, RandomRot, VectorHelper.ScaleOne());
        PickupWrapper.Count = ConcomitantData.StackCount;
    end
end


function UGCDropItemMgr.GetWrapperClass(ItemID)
    if UGCDropItemMgr.WrapperDict[ItemID] ~= nil then
        return UGCDropItemMgr.WrapperDict[ItemID]
    end

    local WrapperClassPath = BackpackUtils.GetPickupWrapperClassPath(ItemID);
    if WrapperClassPath ~= nil and WrapperClassPath ~= "" then
        local WrapperClass = UE.LoadClass(WrapperClassPath);
        UGCDropItemMgr.WrapperDict[ItemID] = WrapperClass
        return WrapperClass
    end

    print("Error UGCDropItemMgr.GetWrapperClass:"..tostring(WrapperClassPath).." ItemID:"..ItemID)
    return nil
end

return UGCDropItemMgr