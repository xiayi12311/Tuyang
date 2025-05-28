TuYang_ShopConfig = TuYang_ShopConfig or {}

TuYang_ShopConfig.ItemKey = 
{
    WeaponShop = "WeaponShop";
    BuffSkillShop = "BuffSkillShop";
}
TuYang_ShopConfig.ItemsGroup = 
{
    [TuYang_ShopConfig.ItemKey.WeaponShop] = {};
    [TuYang_ShopConfig.ItemKey.BuffSkillShop] = {};
}

local function InitGroup(GroupName, GroupId)
    TuYang_ShopConfig.ItemsGroup[GroupName][GroupId] = {}
    return TuYang_ShopConfig.ItemsGroup[GroupName][GroupId]
end
local function AddItemGroup_NewDemand(Data)
    local Tmp = Data
    -- 新功能 刷新花费
    Tmp.RefreshCost = 250
    table.insert(Data, Tmp)
    return Tmp
end

local function AddItemGroup(Data,InCost, InName, InTexturePath)
    local Tmp = {Cost = InCost, Name = InName,TexturePath = InTexturePath, Items = {}}
    
    Tmp = AddItemGroup_NewDemand(Tmp)
    table.insert(Data, Tmp)
    return Tmp
end


local function AddConcomitants(Data, ItemID, StackCount, CountMin, CountMax)
    local Tmp = {ItemID = ItemID; StackCount = StackCount; CountMin = CountMin; CountMax = CountMax}
    table.insert(Data.Concomitants, Tmp)
    return Tmp
end

local function AddItem(Data, InWeight, ...)
    local Tmp = {Weight = InWeight; ItemsList = {}}
    table.insert(Data.Items, Tmp)
    return Tmp
end

local function AddItemsList(Data,InKey, InWeight, ...)
    local Tmp = {Key = InKey; Weight = InWeight}
    table.insert(Data.ItemsList, Tmp)
    return Tmp
    
end


function TuYang_ShopConfig.GetShopItems(Key, GroupId,ShopID)
    local Group = TuYang_ShopConfig.ItemsGroup[Key]
    if Group == nil then
        return
    end

    local ItemGroup = Group[GroupId]
    if ItemGroup == nil then
        print("Error TuYang_ShopConfig.GetDropItems: Key:"..Key.."  GroupId:"..GroupId)
        return
    end 
    return ItemGroup[ShopID]
end

--不要外部调用
function TuYang_ShopConfig.GetItemGroup(ItemGroup, OutItems)

    --累计总权值
    local WeightAccumulator = 0;
    for k,v in pairs(ItemGroup) do
        WeightAccumulator = WeightAccumulator + v.Weigth
        v.WeightAccumulator = WeightAccumulator
    end

    --把随机到的物品添加到列表中
    local RandomWeight = math.random(1, WeightAccumulator);

    for k,v in pairs(ItemGroup) do
        if v.WeightAccumulator >= RandomWeight then
            table.insert(OutItems, v)
            break
        end
    end
end

local function deepCopy(original)
    local copy
    if type(original) == "table" then
        copy = {}
        for origKey, origValue in next, original, nil do
            copy[deepCopy(origKey)] = deepCopy(origValue)
        end
        setmetatable(copy, deepCopy(getmetatable(original)))
    else 
        copy = original
    end
    return copy
end
-- 根据权重来随机选择物品
function TuYang_ShopConfig:SelectRandomCardsFromTheCardPool(InData)
    if InData == nil  or #InData == 0 then
        print("Error TuYang_ShopConfig:SelectRandomCardsFromTheCardPool: InData is nil or empty")
        return
    end
    local copiedData = deepCopy(InData)
    local tLevelSub
    local tSub
    local tKeyList = {}
    local tInList = {}
    local tOutList = {}
    local tItemsList = {}
    
    for i = 1,3 do
        tInList = {}
        tOutList = {}
        tInList = deepCopy(copiedData)
        local selectedGroup = nil  -- 新增局部变量初始化
        repeat
            -- 先选出当前物品为什么品质的
            tOutList = {}
            --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool01",tInList)
            tLevelSub = TuYang_ShopConfig:GetRandomItemByWeight(tInList,tOutList)
            if #tOutList == 0 then
                UGCLog.Log("Error All Weights are 0")
                return
            end
            --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool02",tOutList)
            if tItemsList[tLevelSub] == nil then
                UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool02.5",tLevelSub)
                tItemsList[tLevelSub] = TuYang_ShopConfig:HandleCopy(tInList[tLevelSub].ItemsList)
            end
            if #tItemsList[tLevelSub] == 0 then
                --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool02.6",tLevelSub)
                tInList[tLevelSub].Weight = 0
            end
        until tItemsList[tLevelSub] ~= nil and #tItemsList[tLevelSub] > 0 -- 新增终止条件
       
        -- 再在当前品质中选出该出现什么物品
        tInList = {}
        tOutList = {}
        -- 修改对应品质池子的武器
        tInList = tItemsList[tLevelSub]
        --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool03",tInList)
        tSub = TuYang_ShopConfig:GetRandomItemByWeight(tInList,tOutList)
        table.insert(tKeyList, tInList[tSub].Key)
        --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool03.5",tSub,tInList)
        if tItemsList[tLevelSub][tSub] ~= nil then 
            --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool03.6",tSub)
            table.remove(tItemsList[tLevelSub],tSub)
        end       
        --UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool03.7",tSub,tItemsList[tLevelSub])
    end
    UGCLog.Log("[LJH] SelectRandomCardsFromTheCardPool04",tKeyList)
    return tKeyList
end
function TuYang_ShopConfig:GetRandomItemByWeight(InList,outList)
    
    -- for k, v in pairs(InList) do
    --     --UGCLog.Log("[LJH]GetRandomItemByWeight",k, v.Weight)
    --     TuYang_ShopConfig:AddOutList(outList,k, v.Weight)
    -- end
    -- local tRandomNum = math.random(1, #outList)
    -- local tSub = outList[tRandomNum]

    local tSub = 1
    local tobleweight = 0
    for k, v in pairs(InList) do
        --UGCLog.Log("[LJH]GetRandomItemByWeight",k, v.Weight)
        tobleweight = tobleweight + v.Weight
        table.insert(outList, { item = k,
                    accum = tobleweight})
    end
    local tRandomNum = math.random(tobleweight)
    for i, v in ipairs(outList) do
        if tRandomNum <= v.accum then
           return v.item
        end
    end
    
    return tSub
end
function TuYang_ShopConfig:AddOutList(outList,InKey, InWeight)
    local tRandomList = {}
    for i = 1,InWeight do
        table.insert(outList, InKey)
    end    
end

function TuYang_ShopConfig:GetThreeUniqueKeysByWeight(Data)
    local copiedData = self:HandleCopy(Data.Items)
    local selectedKeys = {}
    local usedKeys = {}

    for i = 1, 3 do
        -- 新增大类有效性检查循环
        local validGroups = {}
        local selectedGroup = nil  -- 新增局部变量初始化
        repeat
            -- 重新计算有效大类
            local totalWeight = 0
            validGroups = {}
            for _, group in ipairs(copiedData) do
                if group.Weight > 0 then
                    -- 检查该大类是否有可用Key
                    local hasAvailable = false
                    for _, item in ipairs(group.ItemsList) do
                        if not usedKeys[item.Key] then
                            hasAvailable = true
                            break
                        end
                    end
                    if hasAvailable then
                        totalWeight = totalWeight + group.Weight
                        table.insert(validGroups, {group = group, accum = totalWeight})
                    end
                end
            end

            if totalWeight == 0 then break end

            -- 随机选择大类
            local rand = math.random(totalWeight)
            for _, cw in ipairs(validGroups) do
                if rand <= cw.accum then
                    selectedGroup = cw.group
                    break
                end
            end
        until selectedGroup and #selectedGroup.ItemsList > 0  -- 新增终止条件

        if not selectedGroup or #validGroups == 0 then break end

        -- ... 保持后续处理逻辑不变 ...
        -- 过滤已选Key并计算子项权重
        local availableItems = {}
        local itemTotalWeight = 0
        for _, item in ipairs(selectedGroup.ItemsList) do
            if not usedKeys[item.Key] then
                itemTotalWeight = itemTotalWeight + item.Weight
                table.insert(availableItems, {
                    item = item,
                    accum = itemTotalWeight
                })
            end
        end

        -- 随机选择子项
        local itemRand = math.random(itemTotalWeight)
        for _, ci in ipairs(availableItems) do
            if itemRand <= ci.accum then
                table.insert(selectedKeys, ci.item.Key)
                usedKeys[ci.item.Key] = true
                break
            end
        end
    end

    return selectedKeys
end

-- function TuYang_ShopConfig:HandleCopy(original)
--     local copy = {}
--     for i, v in ipairs(original) do
--         copy[i] = v
--     end
--     for k, v in pairs(original) do
--         if type(k) == "string" then
--             copy[k] = v
--         end
--     end
--     return copy
-- end

function TuYang_ShopConfig:HandleCopy(original)
    local copy = {}
    -- 递归拷贝所有层级的 table
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = TuYang_ShopConfig:HandleCopy(v)  -- 递归处理嵌套 table
        else
            copy[k] = v
        end
    end
    return copy
end

  -- 在生成候选列表时过滤已选BUFF
function TuYang_ShopConfig:TableContains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end
function TuYang_ShopConfig:FilterAvailableItems(AllList, SelectedList)
    local filtered = {}
    for i, item in ipairs(AllList) do
        local tItemsList = {Weight = 0, ItemsList = {}}
        tItemsList.Weight = item.Weight
        for k, v in pairs(item.ItemsList) do
            if not TuYang_ShopConfig:TableContains(SelectedList,v.Key) then
                table.insert(tItemsList.ItemsList, v)
            end
        end
        table.insert(filtered, tItemsList)
    end
    return filtered
end


function TuYang_ShopConfig.InitConfig()
    --UGCLog.Log("[YYH]TuYang_ShopConfig.InitConfig")
    local Data
    local Cost
    local Name
    local TexturePath
    local ItemGroup
    local tWeight
    local tItems


    -----*****&&&&& GroupID == 1  抽卡武器商店  &&&&&*****-----
    Data = InitGroup(TuYang_ShopConfig.ItemKey.WeaponShop, 1)
    ------------------------旧版------------------------
    -- 蓝色商店 --  1
    Cost = 800
    Name = "武器低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 67
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "AKS74", 10)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "Kar98k", 10)
    AddItemsList(tItems, "Win94", 10)
    AddItemsList(tItems, "SVD", 10)
    AddItemsList(tItems, "Bow", 10)
    AddItemsList(tItems, "DP28", 10)
    --蓝色物品 
    tWeight = 30
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 5
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)

    -- 紫色商店 --  2
    Cost = 2000
    Name = "武器中级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "AKS74", 10)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "Kar98k", 10)
    AddItemsList(tItems, "Win94", 10)
    AddItemsList(tItems, "SVD", 10)
    AddItemsList(tItems, "Bow", 10)
    AddItemsList(tItems, "DP28", 10)
    --蓝色物品 
    tWeight = 67
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 5
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)

    -- 红色商店 --  3
    Cost = 5000
    Name = "武器高级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "AKS74", 10)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "Kar98k", 10)
    AddItemsList(tItems, "Win94", 10)
    AddItemsList(tItems, "SVD", 10)
    AddItemsList(tItems, "Bow", 10)
    AddItemsList(tItems, "DP28", 10)
    --蓝色物品 
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 67
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)

      -----***** GroupID == 2  等级武器商店  *****-----
    Data = InitGroup(TuYang_ShopConfig.ItemKey.WeaponShop, 2)
    -- 蓝色商店 --  1
    Cost = 800
    Name = "武器低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "AKS74", 10)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "Kar98k", 10)
    AddItemsList(tItems, "Win94", 10)
    AddItemsList(tItems, "SVD", 10)
    AddItemsList(tItems, "Bow", 10)
    AddItemsList(tItems, "DP28", 10)
    AddItemsList(tItems, "Sickle", 10)
     --蓝色物品 
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)

  -----***** GroupID == 3  品类武器商店  *****-----
    Data = InitGroup(TuYang_ShopConfig.ItemKey.WeaponShop, 3)
    ------------------------ 回合1 ------------------------
    ----- 轻武器 -----  1
    Cost = 3000
    Name = "轻武器低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "Sickle", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "Cowbar", 10)
    
    --紫色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "Machete", 10)
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "Pan", 10)
    ----- 重武器 -----  2
    Cost = 3000
    Name = "重武器低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "DP28", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)
    ----- 狙击枪 -----  3
    Cost = 3000
    Name = "狙击枪低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "Bow", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    --紫色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)
    ----- 步枪 -----  4
    Cost = 3000
    Name = "步枪低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    --紫色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)

    ------------------------ 回合2 ------------------------
    ----- 轻武器 -----  5
    Cost = 3000
    Name = "轻武器中级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "Sickle", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "Cowbar", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "Machete", 10)
    --红色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "Pan", 10)

    ----- 重武器 -----  6
    Cost = 3000
    Name = "重武器中级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "DP28", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)

    ----- 狙击枪 -----  7
    Cost = 3000
    Name = "狙击枪中级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "Bow", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    --红色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)

    ----- 步枪 -----  8
    Cost = 3000
    Name = "步枪中级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    --红色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)
     ------------------------ 回合3 ------------------------
    ----- 轻武器 -----  9
    Cost = 3000
    Name = "轻武器高级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "Thompson", 10)
    AddItemsList(tItems, "UZI", 10)
    AddItemsList(tItems, "Skorpion", 10)
    AddItemsList(tItems, "Sickle", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "MP5K", 10)
    AddItemsList(tItems, "Vector", 10)
    AddItemsList(tItems, "UMP45", 10)
    AddItemsList(tItems, "Cowbar", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "JS9", 10)
    AddItemsList(tItems, "PP19", 10)
    AddItemsList(tItems, "Machete", 10)
    --红色物品
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "P90", 10)
    AddItemsList(tItems, "Pan", 10)

    ----- 重武器 -----  10
    Cost = 3000
    Name = "重武器高级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "S686", 10)
    AddItemsList(tItems, "S1897", 10)
    AddItemsList(tItems, "SawedOff", 10)
    AddItemsList(tItems, "DP28", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "S12K", 10)
    AddItemsList(tItems, "SPAS-12", 10)
    AddItemsList(tItems, "M249", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "DBS", 10)
    AddItemsList(tItems, "PKM", 10)
    --红色物品
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AA12-G", 10)
    AddItemsList(tItems, "MG3", 10)
    AddItemsList(tItems, "M134", 10)

    ----- 狙击枪 -----  11
    Cost = 3000
    Name = "狙击枪高级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "Bow", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M24", 10)
    AddItemsList(tItems, "SKS", 10)
    AddItemsList(tItems, "Mosin", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "MK20-H", 10)
    AddItemsList(tItems, "AWM", 10)
    --红色物品
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M200", 10)
    AddItemsList(tItems, "AMR", 10)

    ----- 步枪 -----  12
    Cost = 3000
    Name = "步枪高级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 40
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "VAL", 10)
    AddItemsList(tItems, "G36C", 10)
    AddItemsList(tItems, "M16A4", 10)
    --蓝色物品 
    tWeight = 32
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "SCAR-L", 10)
    AddItemsList(tItems, "AK47", 10)
    AddItemsList(tItems, "HoneyBadger", 10)
    --紫色物品
    tWeight = 24
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "M416", 10)
    AddItemsList(tItems, "M762", 10)
    --红色物品
    tWeight = 15
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, "AUG", 10)
    AddItemsList(tItems, "Groza", 10)

   
    -----*****&&&&& GroupID == 1  抽卡BUFF技能商店  &&&&&*****-----
    Data = InitGroup(TuYang_ShopConfig.ItemKey.BuffSkillShop, 1)
    -- 蓝色商店 --
    Cost = 3000
    Name = "技能低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 31
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 3, 10)   -- 赏金猎人
    AddItemsList(tItems, 7, 10)   -- 吸血鬼
    AddItemsList(tItems, 9, 10)   -- 时空旅者
    AddItemsList(tItems, 11, 10)  -- 冰冻子弹
    AddItemsList(tItems, 16, 10)  -- 闪电子弹
    AddItemsList(tItems, 26, 10)  -- 火焰爪牙
    AddItemsList(tItems, 27, 10)  -- 风刃术
    AddItemsList(tItems, 45, 10)  -- 打钱高手
    AddItemsList(tItems, 48, 10)  -- 毒刺子弹
    --蓝色物品 
    tWeight = 28
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 10, 10)  -- 偷袭！
    AddItemsList(tItems, 12, 10)  -- 治愈之风
    AddItemsList(tItems, 13, 10)  -- 旺旺碎冰冰
    AddItemsList(tItems, 14, 10)  -- 大火收汁
    AddItemsList(tItems, 19, 10)  -- 电能激荡
    AddItemsList(tItems, 20, 10)  -- 春风拂面
    AddItemsList(tItems, 23, 10)  -- 英雄登场
    AddItemsList(tItems, 25, 10)  -- 电疗
    AddItemsList(tItems, 29, 10)  -- 冰锥术
    AddItemsList(tItems, 49, 10)  -- 变质大西瓜
    AddItemsList(tItems, 50, 10)  -- 人肉毒气弹
    --紫色物品
    local tWeight = 0
    local tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 22, 10)  -- 大威天雷
    AddItemsList(tItems, 30, 10)  -- 飓风呼啸
    AddItemsList(tItems, 39, 10)  -- 一路发财
    AddItemsList(tItems, 15, 10)  -- 自热火锅
    AddItemsList(tItems, 24, 10)  -- 美丽冻人
    AddItemsList(tItems, 47, 10)  -- 寄生种子
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 17, 10)  -- 龙卷风摧毁停车场
    AddItemsList(tItems, 18, 10)  -- 雷霆之锤
    AddItemsList(tItems, 21, 10)  -- 滑冰运动
    AddItemsList(tItems, 28, 10)  -- 霹雳15火箭弹
    AddItemsList(tItems, 51, 10)  -- 天罗地网
    AddItemsList(tItems, 46, 10)  -- 火龙卷

    -- 中级商店 --
    Cost = 3000
    Name = "技能中级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 31
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 3, 10)   -- 赏金猎人
    AddItemsList(tItems, 7, 10)   -- 吸血鬼
    AddItemsList(tItems, 9, 10)   -- 时空旅者
    AddItemsList(tItems, 11, 10)  -- 冰冻子弹
    
    AddItemsList(tItems, 16, 10)  -- 闪电子弹
    AddItemsList(tItems, 26, 10)  -- 火焰爪牙
    AddItemsList(tItems, 27, 10)  -- 风刃术
    AddItemsList(tItems, 45, 10)  -- 打钱高手
    AddItemsList(tItems, 48, 10)  -- 毒刺子弹
    --蓝色物品 
    tWeight = 28
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 10, 10)  -- 偷袭！
    AddItemsList(tItems, 12, 10)  -- 治愈之风
    AddItemsList(tItems, 13, 10)  -- 旺旺碎冰冰
    AddItemsList(tItems, 14, 10)  -- 大火收汁
    AddItemsList(tItems, 19, 10)  -- 电能激荡
    AddItemsList(tItems, 20, 10)  -- 春风拂面
    AddItemsList(tItems, 23, 10)  -- 英雄登场
    AddItemsList(tItems, 25, 10)  -- 电疗
    AddItemsList(tItems, 29, 10)  -- 冰锥术
    AddItemsList(tItems, 49, 10)  -- 变质大西瓜
    AddItemsList(tItems, 50, 10)  -- 人肉毒气弹
    --紫色物品
    tWeight = 28
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 22, 10)  -- 大威天雷
    AddItemsList(tItems, 30, 10)  -- 飓风呼啸
    AddItemsList(tItems, 39, 10)  -- 一路发财
    AddItemsList(tItems, 15, 10)  -- 自热火锅
    AddItemsList(tItems, 24, 10)  -- 美丽冻人
    AddItemsList(tItems, 47, 10)  -- 寄生种子
    --红色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 17, 10)  -- 龙卷风摧毁停车场
    AddItemsList(tItems, 18, 10)  -- 雷霆之锤
    AddItemsList(tItems, 21, 10)  -- 滑冰运动
    AddItemsList(tItems, 28, 10)  -- 霹雳15火箭弹
    AddItemsList(tItems, 51, 10)  -- 天罗地网
    AddItemsList(tItems, 46, 10)  -- 火龙卷

    -- 高级商店 --
    Cost = 3000
    Name = "技能高级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 31
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 3, 10)   -- 赏金猎人
    AddItemsList(tItems, 7, 10)   -- 吸血鬼
    AddItemsList(tItems, 9, 10)   -- 时空旅者
    AddItemsList(tItems, 11, 10)  -- 冰冻子弹
    
    AddItemsList(tItems, 16, 10)  -- 闪电子弹
    AddItemsList(tItems, 26, 10)  -- 火焰爪牙
    AddItemsList(tItems, 27, 10)  -- 风刃术
    AddItemsList(tItems, 45, 10)  -- 打钱高手
    AddItemsList(tItems, 48, 10)  -- 毒刺子弹
    --蓝色物品 
    tWeight = 28
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 10, 10)  -- 偷袭！
    AddItemsList(tItems, 12, 10)  -- 治愈之风
    AddItemsList(tItems, 13, 10)  -- 旺旺碎冰冰
    AddItemsList(tItems, 14, 10)  -- 大火收汁
    AddItemsList(tItems, 19, 10)  -- 电能激荡
    AddItemsList(tItems, 20, 10)  -- 春风拂面
    AddItemsList(tItems, 23, 10)  -- 英雄登场
    AddItemsList(tItems, 25, 10)  -- 电疗
    AddItemsList(tItems, 29, 10)  -- 冰锥术
    AddItemsList(tItems, 49, 10)  -- 变质大西瓜
    AddItemsList(tItems, 50, 10)  -- 人肉毒气弹
    AddItemsList(tItems, 44, 10)  -- 理财达人
    --紫色物品
    tWeight = 28
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 22, 10)  -- 大威天雷
    AddItemsList(tItems, 30, 10)  -- 飓风呼啸
    AddItemsList(tItems, 39, 10)  -- 一路发财
    AddItemsList(tItems, 15, 10)  -- 自热火锅
    AddItemsList(tItems, 24, 10)  -- 美丽冻人
    AddItemsList(tItems, 47, 10)  -- 寄生种子
    --红色物品
    tWeight = 23
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 17, 10)  -- 逆风快递
    AddItemsList(tItems, 18, 10)  -- 十万伏特
    AddItemsList(tItems, 21, 10)  -- 滑冰运动
    AddItemsList(tItems, 28, 10)  -- 霹雳15火箭弹
    AddItemsList(tItems, 51, 10)  -- 天罗地网
    AddItemsList(tItems, 46, 10)  -- 火龙卷

    -----***** GroupID == 2  抽卡BUFF技能商店（等级）  *****-----
    Data = InitGroup(TuYang_ShopConfig.ItemKey.BuffSkillShop, 2)
    -- 蓝色商店 --
    Cost = 3000
    Name = "技能低级抽卡"
    TexturePath = ""
    ItemGroup = AddItemGroup(Data, Cost ,Name,TexturePath)
    --绿色物品
    tWeight = 1
    tItems = AddItem(ItemGroup,tWeight)
    --AddItemsList(tItems, 3, 10)   -- 赏金猎人
    --AddItemsList(tItems, 7, 10)   -- 吸血鬼
    --AddItemsList(tItems, 9, 10)   -- 时空旅者
    AddItemsList(tItems, 11, 10)  -- 冰冻子弹
    
    AddItemsList(tItems, 16, 10)  -- 闪电子弹
    AddItemsList(tItems, 26, 10)  -- 小火慢炖
    AddItemsList(tItems, 27, 10)  -- 风刃术
    AddItemsList(tItems, 48, 10)  -- 毒刺子弹
    --AddItemsList(tItems, 45, 10)  -- 打钱高手
    --蓝色物品 
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 10, 10)  -- 偷袭！
    AddItemsList(tItems, 12, 10)  -- 治愈之风
    AddItemsList(tItems, 13, 10)  -- 旺旺碎冰冰
    AddItemsList(tItems, 14, 10)  -- 大火收汁
    AddItemsList(tItems, 19, 10)  -- 电能激荡
    AddItemsList(tItems, 20, 10)  -- 春风拂面
    AddItemsList(tItems, 23, 10)  -- 英雄登场
    AddItemsList(tItems, 25, 10)  -- 电疗
    AddItemsList(tItems, 29, 10)  -- 冰锥术
    AddItemsList(tItems, 49, 10)  -- 变质大西瓜
    AddItemsList(tItems, 50, 10)  -- 人肉毒气弹
    --紫色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 22, 10)  -- 大威天雷
    AddItemsList(tItems, 30, 10)  -- 飓风呼啸
    AddItemsList(tItems, 39, 10)  -- 一路发财
    AddItemsList(tItems, 15, 10)  -- 自热火锅
    AddItemsList(tItems, 24, 10)  -- 美丽冻人
    AddItemsList(tItems, 47, 10)  -- 寄生种子
    --红色物品
    tWeight = 0
    tItems = AddItem(ItemGroup,tWeight)
    AddItemsList(tItems, 17, 10)  -- 龙卷风摧毁停车场
    AddItemsList(tItems, 18, 10)  -- 雷霆之锤
    AddItemsList(tItems, 21, 10)  -- 滑冰运动
    AddItemsList(tItems, 28, 10)  -- 霹雳15火箭弹
    AddItemsList(tItems, 51, 10)  -- 天罗地网
    AddItemsList(tItems, 46, 10)  -- 火龙卷

    
    --UGCLog.Log("[LJH]TuYang_ShopConfig.InitConfig TuYang_ShopConfig.ItemsGroup",TuYang_ShopConfig.ItemsGroup[TuYang_ShopConfig.ItemKey.BuffSkillShop])


end

-- TuYang_ShopConfig.ItemKey.WeaponShop = 
-- {
-- 	Items =
-- 	{	
-- 		{
-- 			Weight = 67,
-- 			ItemsList =	
-- 			{
-- 				{
-- 					Key = "Thompson",		
-- 					Weight = 		10	
-- 				},	
-- 				{
-- 					Key = 		"UZI",	
-- 					Weight = 		10	
-- 				},	
-- 				{
-- 					Key = 		"Skorpion",	
-- 					Weight = 		10	
-- 				}
-- 			}
-- 		},	
-- 		{
-- 			Weight = 30	,
-- 			ItemsList=	
-- 			{

-- 				{
-- 					Key = 		"MP5K",	
-- 					Weight = 		10	
-- 				},	
-- 				{
-- 					Key = 		"Vector",	
-- 					Weight = 		10	
-- 				},	
-- 				{
-- 					Key = 		"UMP45",	
-- 					Weight = 		10	
-- 				}
-- 			}
-- 		}
-- 		,	
-- 		{
-- 			Weight = 5,	
-- 			ItemsList=
-- 			{

-- 				{
-- 					Key = 		"JS9",	
-- 					Weight = 		10	
-- 				}
-- 				,
-- 				{
-- 					Key = 		"PP19",	
-- 					Weight = 		10	
-- 				}
-- 			}
-- 		}
-- 		,
-- 		{
-- 			Weight = 0,	
-- 			ItemsList =	
-- 			{	
-- 				{
-- 					Key = 		"P90",	
-- 					Weight = 		10	
-- 				}
-- 			}
-- 		}
-- 	},
-- 	Name =	"轻武器低级抽卡",
-- 	Cost = 	800	,
-- 	TexturePath = ""		
-- }




function TuYang_ShopConfig:GetShopCost(InGroupName)
    return TuYang_ShopConfig.ItemsGroup[InGroupName].Cost
end


function TuYang_ShopConfig:GetShop(InID)
    return TuYang_ShopConfig.ItemsGroup["WeaponShop"][InID]
end

















TuYang_ShopConfig.InitConfig()


return TuYang_ShopConfig