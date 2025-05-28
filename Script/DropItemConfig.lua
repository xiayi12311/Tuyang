DropItemConfig = DropItemConfig or {}

DropItemConfig.ItemKey = 
{
    RewardBox = "RewardBox";
    RandomItem = "RandomItem";
    Monster = "Monster";
}

DropItemConfig.ItemsGroup = 
{
    [DropItemConfig.ItemKey.RewardBox] = {};
    [DropItemConfig.ItemKey.RandomItem] = {};
    [DropItemConfig.ItemKey.Monster] = {};
}

local function InitGroup(GroupName, GroupId)
    DropItemConfig.ItemsGroup[GroupName][GroupId] = {}
    return DropItemConfig.ItemsGroup[GroupName][GroupId]
end

local function AddItemGroup(Data, Pro, Count)
    local Tmp = {Pro = Pro, Count = Count,Items = {}}
    table.insert(Data, Tmp)
    return Tmp
end

local function AddConcomitants(Data, ItemID, StackCount, CountMin, CountMax)
    local Tmp = {ItemID = ItemID; StackCount = StackCount; CountMin = CountMin; CountMax = CountMax}
    table.insert(Data.Concomitants, Tmp)
    return Tmp
end

local function AddItem(Data, ItemID , Count, Weigth, ...)
    local Tmp = {ItemID = ItemID; Count = Count; Weigth = Weigth; Concomitants = {}}

    --初始化附带物品
    local Concomitants = {...}
    for k,v in pairs(Concomitants) do
        local ItemID = v[1]
        local StackCount = v[2]
        local CountMin = v[3]
        local CountMax = v[4]
        AddConcomitants(Tmp, ItemID, StackCount, CountMin, CountMax)
    end

    table.insert(Data.Items, Tmp)
    return Tmp
end

function DropItemConfig.GetDropItems(Key, GroupId)
    local Group = DropItemConfig.ItemsGroup[Key]
    if Group == nil then
        return
    end

    local ItemGroup = Group[GroupId]
    if ItemGroup == nil then
        print("Error DropItemConfig.GetDropItems: Key:"..Key.."  GroupId:"..GroupId)
        return
    end 

    local OutItems = {}
    for k,v in pairs(ItemGroup) do
        local Pro = v.Pro
        local Count = v.Count

        local Random = math.random(1, 100);
        if Random <= Pro then
            for i=1,Count do
                DropItemConfig.GetItemGroup(v.Items, OutItems)
            end
        end
    end

    return OutItems
end

--不要外部调用
function DropItemConfig.GetItemGroup(ItemGroup, OutItems)

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

function DropItemConfig.InitConfig()

    --[[
    --出生宝箱方案
    local Data = InitGroup(DropItemConfig.ItemKey.RewardBox, 0)
    local ItemGroup = AddItemGroup(Data, 100, 1)
    AddItem(ItemGroup, 102001, 1, 10, {301001, 30, 1, 2})
    AddItem(ItemGroup, 102003, 1, 10, {301001, 30, 1, 2})
    AddItem(ItemGroup, 104002, 1, 10, {304001, 30, 1, 1})

    --治疗箱掉落方案1（level 1-1)
    local Data = InitGroup(DropItemConfig.ItemKey.RewardBox, 100)
    local ItemGroup = AddItemGroup(Data, 100 ,3)
    AddItem(ItemGroup, 601001, 1, 100)--饮料
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601005, 1, 100)--医疗包
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601005, 1, 100)--医疗包

    --宝箱掉落方案10 正式掉落
    local Data = InitGroup(DropItemConfig.ItemKey.RewardBox, 10)
    --喷子和冲锋1
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 102001, 1, 10, {301001, 30, 1, 2})
    AddItem(ItemGroup, 102003, 1, 10, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 102005, 1, 10, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 104001, 1, 10, {304001, 30, 1, 1})
    AddItem(ItemGroup, 104002, 1, 10, {304001, 30, 1, 1})
    --AddItem(ItemGroup, 104000, 1, 10, {304001, 30, 1, 1})
    --AddItem(ItemGroup, 104004, 1, 10, {304001, 30, 1, 1})
    --枪口0.75
    local ItemGroup = AddItemGroup(Data, 75 ,1)
    AddItem(ItemGroup, 201002, 1, 10)
    AddItem(ItemGroup, 201004, 1, 10)
    AddItem(ItemGroup, 201006, 1, 10)
    AddItem(ItemGroup, 201001, 1, 10)
    AddItem(ItemGroup, 201009, 1, 10)
    --弹夹
    local ItemGroup = AddItemGroup(Data, 75 ,1)
    AddItem(ItemGroup, 204004, 1, 10)
    AddItem(ItemGroup, 204005, 1, 10)
    AddItem(ItemGroup, 204006, 1, 10)
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    --红点全息
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 203001, 1, 10)
    AddItem(ItemGroup, 203002, 1, 10)
    --握把
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    AddItem(ItemGroup, 202006, 1, 10)
    --枪托
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 205001, 1, 10)
    AddItem(ItemGroup, 205002, 1, 10)
    --止痛药
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 601003, 1, 10)
    --医疗包
    local ItemGroup = AddItemGroup(Data, 50 ,4)
    AddItem(ItemGroup, 601005, 1, 10)
    --医疗箱
    local ItemGroup = AddItemGroup(Data, 25 ,2)
    AddItem(ItemGroup, 601006, 1, 10)
    --手雷
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 602004, 1, 10)
    --宝箱补充
    --步枪1.5
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 101001, 1, 10, {302001, 30, 2, 3})
    AddItem(ItemGroup, 101002, 1, 10, {303001, 30, 2, 3})
    AddItem(ItemGroup, 101003, 1, 10, {303001, 30, 2, 3})
    AddItem(ItemGroup, 101004, 1, 10, {303001, 30, 2, 3})
    --AddItem(ItemGroup, 105001, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105002, 1, 10, {302001, 30, 2, 3})
    --AddItem(ItemGroup, 101007, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 101008, 1, 10, {302001, 30, 1, 2})

    --枪口0.75
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 201009, 1, 10)
    AddItem(ItemGroup, 201010, 1, 10)
    AddItem(ItemGroup, 201011, 1, 10)

    --弹夹0.75
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    --2倍3倍 0.25
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 203003, 1, 10)
    AddItem(ItemGroup, 203014, 1, 10)
    --握把
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    AddItem(ItemGroup, 202006, 1, 10)
    --枪托
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 205002, 1, 10)



    --宝箱掉落方案20 正式掉落
    local Data = InitGroup(DropItemConfig.ItemKey.RewardBox, 20)
    --步枪1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 101001, 1, 10, {302001, 30, 1, 2})
    AddItem(ItemGroup, 101002, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101003, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101004, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 105001, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105002, 1, 10, {302001, 30, 2, 2})
    --AddItem(ItemGroup, 101007, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 101008, 1, 10, {302001, 30, 1, 2})

    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 101001, 1, 10, {302001, 30, 1, 2})
    AddItem(ItemGroup, 101002, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101003, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101004, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 105001, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105002, 1, 10, {302001, 30, 2, 2})
    --AddItem(ItemGroup, 101007, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 101008, 1, 10, {302001, 30, 1, 2})

    --枪口0.75
    local ItemGroup = AddItemGroup(Data, 75 ,1)
    AddItem(ItemGroup, 201009, 1, 10)
    AddItem(ItemGroup, 201010, 1, 10)
    AddItem(ItemGroup, 201011, 1, 10)

    --弹夹0.75
    local ItemGroup = AddItemGroup(Data, 75 ,1)
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    --2倍3倍 0.25
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 203003, 1, 10)
    AddItem(ItemGroup, 203014, 1, 10)
    --握把
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    AddItem(ItemGroup, 202006, 1, 10)
    --枪托
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 205002, 1, 10)
    --止痛药
    local ItemGroup = AddItemGroup(Data, 75 ,1)
    AddItem(ItemGroup, 601003, 1, 10)
    --医疗包
    local ItemGroup = AddItemGroup(Data, 50 ,4)
    AddItem(ItemGroup, 601005, 1, 10)
    --医疗箱
    local ItemGroup = AddItemGroup(Data, 25 ,2)
    AddItem(ItemGroup, 601006, 1, 10)
    --手雷
    local ItemGroup = AddItemGroup(Data, 75 ,1)
    AddItem(ItemGroup, 602004, 1, 10)
    --烟雾
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 602002, 1, 10)
    --宝箱补充：
    --喷子和冲锋1
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 102001, 1, 10, {301001, 30, 2, 3})
    AddItem(ItemGroup, 102003, 1, 10, {301001, 30, 2, 3})
    --AddItem(ItemGroup, 102005, 1, 10, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 104001, 1, 10, {304001, 30, 1, 1})
    AddItem(ItemGroup, 104002, 1, 10, {304001, 30, 2, 3})
    --AddItem(ItemGroup, 104000, 1, 10, {304001, 30, 1, 1})
    --AddItem(ItemGroup, 104004, 1, 10, {304001, 30, 1, 1})
    --枪口0.75
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 201002, 1, 10)
    AddItem(ItemGroup, 201004, 1, 10)
    AddItem(ItemGroup, 201006, 1, 10)
    AddItem(ItemGroup, 201001, 1, 10)
    AddItem(ItemGroup, 201009, 1, 10)
    --弹夹
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 204004, 1, 10)
    AddItem(ItemGroup, 204005, 1, 10)
    AddItem(ItemGroup, 204006, 1, 10)
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    --红点全息
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 203001, 1, 10)
    AddItem(ItemGroup, 203002, 1, 10)
    --握把
    local ItemGroup = AddItemGroup(Data, 10 ,1)
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    AddItem(ItemGroup, 202006, 1, 10)
    --枪托
    local ItemGroup = AddItemGroup(Data, 10 ,1)
    AddItem(ItemGroup, 205001, 1, 10)
    AddItem(ItemGroup, 205002, 1, 10)    

    
    --宝箱掉落方案30 正式掉落
    local Data = InitGroup(DropItemConfig.ItemKey.RewardBox, 30)
    --步枪1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 101004, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101005, 1, 10, {302001, 30, 1, 2})
    --AddItem(ItemGroup, 101006, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 105001, 1, 10, {303001, 30, 1, 2})

    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 101004, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101005, 1, 10, {302001, 30, 1, 2})
    --AddItem(ItemGroup, 101006, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 105001, 1, 10, {303001, 30, 1, 2})

    --狙击1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    --AddItem(ItemGroup, 103001, 1, 10, {203018, 30, 1, 2})
    AddItem(ItemGroup, 103002, 1, 10, {203018, 30, 1, 2})
    AddItem(ItemGroup, 103003, 1, 3, {203018, 30, 1, 2})
    --AddItem(ItemGroup, 103004, 1, 10, {203018, 30, 1, 2})
    AddItem(ItemGroup, 103006, 1, 10, {203018, 30, 1, 2})
    --AddItem(ItemGroup, 103009, 1, 10, {203018, 30, 1, 2})

    local ItemGroup = AddItemGroup(Data, 50 ,1)
    --AddItem(ItemGroup, 103001, 1, 10, {203018, 30, 1, 2})
    AddItem(ItemGroup, 103002, 1, 10, {203018, 30, 1, 2})
    AddItem(ItemGroup, 103003, 1, 3, {203018, 30, 1, 2})
    --AddItem(ItemGroup, 103004, 1, 10, {203018, 30, 1, 2})
    AddItem(ItemGroup, 103006, 1, 10, {203018, 30, 1, 2})
    --AddItem(ItemGroup, 103009, 1, 10, {203018, 30, 1, 2})
    --宝箱补充：
    --步枪1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 101001, 1, 10, {302001, 30, 1, 2})
    AddItem(ItemGroup, 101002, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101003, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101004, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 105001, 1, 10, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105002, 1, 10, {302001, 30, 2, 2})
    --AddItem(ItemGroup, 101007, 1, 10, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 101008, 1, 10, {302001, 30, 1, 2})


    --枪口1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 201009, 1, 10)
    AddItem(ItemGroup, 201010, 1, 10)
    AddItem(ItemGroup, 201011, 1, 10)
    AddItem(ItemGroup, 201003, 1, 10)
    AddItem(ItemGroup, 201005, 1, 10)
    AddItem(ItemGroup, 201007, 1, 10)

    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 201009, 1, 10)
    AddItem(ItemGroup, 201010, 1, 10)
    AddItem(ItemGroup, 201011, 1, 10)
    AddItem(ItemGroup, 201003, 1, 10)
    AddItem(ItemGroup, 201005, 1, 10)
    AddItem(ItemGroup, 201007, 1, 10)

    --弹夹1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    AddItem(ItemGroup, 204007, 1, 10)
    AddItem(ItemGroup, 204008, 1, 10)
    AddItem(ItemGroup, 204009, 1, 10)

    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    AddItem(ItemGroup, 204007, 1, 10)
    AddItem(ItemGroup, 204008, 1, 10)
    AddItem(ItemGroup, 204009, 1, 10)

    --2倍3倍 0.25
    local ItemGroup = AddItemGroup(Data, 25 ,1)
    AddItem(ItemGroup, 203003, 1, 10)
    AddItem(ItemGroup, 203014, 1, 10)

    --4倍 0.5
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 203004, 1, 10)

    --握把 0.5
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    AddItem(ItemGroup, 202006, 1, 10)

    --枪托1
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 205002, 1, 10)
    --止痛药1.5
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601003, 1, 10)
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 601003, 1, 10)
    --医疗包1
    local ItemGroup = AddItemGroup(Data, 100 ,4)
    AddItem(ItemGroup, 601005, 1, 10)
    --医疗箱0.5
    local ItemGroup = AddItemGroup(Data, 50 ,2)
    AddItem(ItemGroup, 601006, 1, 10)
    --手雷1
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 602004, 1, 10)
    --烟雾0.5
    local ItemGroup = AddItemGroup(Data, 50 ,1)
    AddItem(ItemGroup, 602002, 1, 10)
   


    


    
   





   

    

    --随机物品掉落方案1
    --1级包 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 1)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 501001, 1, 10)


    --随机物品掉落方案2
    --2级包 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 2)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 501002, 1, 10)


    --随机物品掉落方案3
    --3级包 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 3)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 501003, 1, 10)


    --随机物品掉落方案4
    --1级头 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 4)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 502001, 1, 10)


    --随机物品掉落方案5
    --2级头 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 5)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 502002, 1, 10)


    --随机物品掉落方案6
    --3级头 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 6)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 502003, 1, 10)


    --随机物品掉落方案7
    --1级甲 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 7)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 503001, 1, 10)


    --随机物品掉落方案8
    --2级甲 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 8)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 503002, 1, 10)


    --随机物品掉落方案9
    --3级甲 
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 9)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 503003, 1, 10)

    --随机物品掉落方案10
    --DP12
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 10)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 104004, 1, 10, {304001, 15, 1, 1})

    --随机物品掉落方案11
    --SPAS
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 11)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 104100, 1, 10, {304001, 15, 1, 1})

    --随机物品掉落方案12
    --UZI
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 12)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 102001, 1, 10, {301001, 30, 1, 1})

    --随机物品掉落方案13
    --野牛
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 13)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 102005, 1, 10, {301001, 30, 1, 1})

    --随机物品掉落方案14
    --Vector
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 14)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 102002, 1, 10, {301001, 30, 1, 1})

    --随机物品掉落方案15
    --UMP45
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 15)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 102002, 1, 10, {305001, 30, 1, 1})

    --随机物品掉落方案15
    --UMP45
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 15)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 102002, 1, 10, {305001, 30, 1, 1})


    --随机物品掉落方案16
    --能量饮料
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 16)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601001, 1, 10)

    --随机物品掉落方案17
    --止痛药
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 17)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601003, 1, 10)

    --随机物品掉落方案18
    --绷带
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 18)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601004, 1, 10)

    --随机物品掉落方案19
    --止痛药
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 19)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601005, 1, 10)

    --随机物品掉落方案20
    --止痛药
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 20)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 601003, 1, 10)

    --随机物品掉落方案21
    --红点
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 21)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 203001, 1, 10)


    --随机物品掉落方案22
    --全息
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 22)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 203002, 1, 10)




    --随机物品掉落方案23 1区地上正式掉落方案
    --29掉落
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 23)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    --一级包头甲
    AddItem(ItemGroup, 502001, 1, 3000)
    AddItem(ItemGroup, 501001, 1, 3000)
    AddItem(ItemGroup, 503001, 1, 3000)
    --喷子和冲锋
    AddItem(ItemGroup, 102001, 1, 700, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 102005, 1, 700, {301001, 30, 1, 2})
    AddItem(ItemGroup, 102003, 1, 700, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 104001, 1, 500, {304001, 30, 1, 2})
    AddItem(ItemGroup, 104002, 1, 500, {304001, 30, 1, 2})
    --AddItem(ItemGroup, 104000, 1, 500, {304001, 30, 1, 2})
    --AddItem(ItemGroup, 104004, 1, 500, {304001, 30, 1, 2})
    --枪口
    AddItem(ItemGroup, 201002, 1, 400)
    AddItem(ItemGroup, 201004, 1, 400)
    AddItem(ItemGroup, 201006, 1, 400)
    AddItem(ItemGroup, 201001, 1, 400)
    AddItem(ItemGroup, 201009, 1, 400)
    --弹夹
    AddItem(ItemGroup, 204004, 1, 333)
    AddItem(ItemGroup, 204005, 1, 333)
    AddItem(ItemGroup, 204006, 1, 333)
    AddItem(ItemGroup, 204011, 1, 333)
    AddItem(ItemGroup, 204012, 1, 333)
    AddItem(ItemGroup, 204013, 1, 333)
    --红点全息
    AddItem(ItemGroup, 203001, 1, 700)
    AddItem(ItemGroup, 203002, 1, 700)
    --握把
    AddItem(ItemGroup, 202001, 1, 200)
    AddItem(ItemGroup, 202002, 1, 200)
    AddItem(ItemGroup, 202004, 1, 200)
    AddItem(ItemGroup, 202005, 1, 200)
    AddItem(ItemGroup, 202006, 1, 200)
    --饮料
    AddItem(ItemGroup, 601001, 2, 4000)
    --绷带
    AddItem(ItemGroup, 601004, 5, 2000)
    --治疗包
    AddItem(ItemGroup, 601005, 1, 1000)
    --手雷燃烧闪光
    AddItem(ItemGroup, 602004, 1, 1000)
    AddItem(ItemGroup, 602003, 1, 1000)
    AddItem(ItemGroup, 602001, 1, 1000)
    --一区地上加步枪：
    AddItem(ItemGroup, 101001, 1, 350, {302001, 30, 2, 3})
    AddItem(ItemGroup, 101002, 1, 350, {303001, 30, 2, 3})
    AddItem(ItemGroup, 101003, 1, 350, {303001, 30, 2, 3})
    AddItem(ItemGroup, 101004, 1, 350, {303001, 30, 2, 3})
    --AddItem(ItemGroup, 105001, 1, 350, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105002, 1, 350, {302001, 30, 2, 3})
    --AddItem(ItemGroup, 101007, 1, 350, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 101008, 1, 350, {302001, 30, 1, 2})
    --枪口
    AddItem(ItemGroup, 201009, 1, 600)
    AddItem(ItemGroup, 201010, 1, 600)
    AddItem(ItemGroup, 201011, 1, 600)
    --弹夹
    AddItem(ItemGroup, 204011, 1, 600)
    AddItem(ItemGroup, 204012, 1, 600)
    AddItem(ItemGroup, 204013, 1, 600)
    --红点全息
    AddItem(ItemGroup, 203001, 1, 100)
    AddItem(ItemGroup, 203002, 1, 100)
    --2倍3倍
    AddItem(ItemGroup, 203003, 1, 200)
    AddItem(ItemGroup, 203014, 1, 200)
    --握把
    AddItem(ItemGroup, 202001, 1, 200)
    AddItem(ItemGroup, 202002, 1, 200)
    AddItem(ItemGroup, 202004, 1, 200)
    AddItem(ItemGroup, 202005, 1, 200)
    AddItem(ItemGroup, 202006, 1, 200)


    --随机物品掉落方案24 2区地上正式掉落方案
    --64掉落
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 24)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    --2级包头甲
    AddItem(ItemGroup, 502002, 1, 600)
    AddItem(ItemGroup, 501002, 1, 600)
    AddItem(ItemGroup, 503002, 1, 600)
    --步枪
    AddItem(ItemGroup, 101001, 1, 75, {302001, 30, 1, 2})
    AddItem(ItemGroup, 101002, 1, 75, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101003, 1, 75, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101004, 1, 75, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 105001, 1, 75, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105002, 1, 75, {302001, 30, 2, 2})
    --AddItem(ItemGroup, 101007, 1, 75, {303001, 30, 1, 2})
    --AddItem(ItemGroup, 101008, 1, 75, {302001, 30, 1, 2})
    --枪口
    AddItem(ItemGroup, 201009, 1, 133)
    AddItem(ItemGroup, 201010, 1, 133)
    AddItem(ItemGroup, 201011, 1, 133)
    --弹夹
    AddItem(ItemGroup, 204011, 1, 133)
    AddItem(ItemGroup, 204012, 1, 133)
    AddItem(ItemGroup, 204013, 1, 133)
    --红点全息
    AddItem(ItemGroup, 203001, 1, 50)
    AddItem(ItemGroup, 203002, 1, 50)
    --2倍3倍
    AddItem(ItemGroup, 203003, 1, 100)
    AddItem(ItemGroup, 203014, 1, 100)
    --握把
    AddItem(ItemGroup, 202001, 1, 40)
    AddItem(ItemGroup, 202002, 1, 40)
    AddItem(ItemGroup, 202004, 1, 40)
    AddItem(ItemGroup, 202005, 1, 40)
    AddItem(ItemGroup, 202006, 1, 40)
    --饮料
    AddItem(ItemGroup, 601001, 2, 400)
    --止痛药
    AddItem(ItemGroup, 601003, 2, 200)
    --绷带
    AddItem(ItemGroup, 601004, 5, 500)
    --治疗包
    AddItem(ItemGroup, 601005, 1, 200)
    --医疗箱
    AddItem(ItemGroup, 601006, 1, 100)
    --手雷
    AddItem(ItemGroup, 602004, 1, 600)
    --燃烧
    AddItem(ItemGroup, 602003, 1, 200)
    --闪光
    AddItem(ItemGroup, 602001, 1, 200)
    --烟雾
    AddItem(ItemGroup, 602002, 1, 400)
    --2区地上新增喷子冲锋
    --喷子和冲锋
    AddItem(ItemGroup, 102001, 1, 30, {301001, 30, 2, 3})
    --AddItem(ItemGroup, 102005, 1, 700, {301001, 30, 1, 2})
    AddItem(ItemGroup, 102003, 1, 30, {301001, 30, 2, 3})
    --AddItem(ItemGroup, 104001, 1, 500, {304001, 30, 1, 2})
    AddItem(ItemGroup, 104002, 1, 50, {304001, 30, 2, 3})
    --AddItem(ItemGroup, 104000, 1, 500, {304001, 30, 1, 2})
    --AddItem(ItemGroup, 104004, 1, 500, {304001, 30, 1, 2})

    --随机物品掉落方案26 出生点必掉冲锋
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 25)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    
    AddItem(ItemGroup, 102001, 1, 10, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 102005, 1, 10, {301001, 30, 1, 2})
    AddItem(ItemGroup, 102003, 1, 10, {301001, 30, 1, 2})
    --AddItem(ItemGroup, 102002, 1, 10, {305001, 30, 1, 2})

    --随机物品掉落方案25 出生点必掉喷子
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 26)
    local ItemGroup = AddItemGroup(Data, 100 ,1)

    --AddItem(ItemGroup, 104001, 1, 500, {304001, 30, 1, 2})
    AddItem(ItemGroup, 104002, 1, 500, {304001, 30, 1, 2})
    --AddItem(ItemGroup, 104000, 1, 500, {304001, 30, 1, 2})
    --AddItem(ItemGroup, 104004, 1, 500, {304001, 30, 1, 2})

     --随机物品掉落方案27 3区地上正式掉落方案
    --55 掉落
    local Data = InitGroup(DropItemConfig.ItemKey.RandomItem, 27)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    --3级包头甲
    AddItem(ItemGroup, 502003, 1, 200)
    AddItem(ItemGroup, 501003, 1, 200)
    AddItem(ItemGroup, 503003, 1, 200)
    --2级包头甲
    AddItem(ItemGroup, 502002, 1, 200)
    AddItem(ItemGroup, 501002, 1, 200)
    AddItem(ItemGroup, 503002, 1, 200)
    --步枪
    AddItem(ItemGroup, 101004, 1, 100, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101005, 1, 100, {302001, 30, 1, 2})
    AddItem(ItemGroup, 101006, 1, 50, {303001, 30, 1, 2})
    AddItem(ItemGroup, 105001, 1, 50, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101001, 1, 50, {302001, 30, 1, 2})
    AddItem(ItemGroup, 101002, 1, 50, {303001, 30, 1, 2})
    AddItem(ItemGroup, 101003, 1, 50, {303001, 30, 1, 2})
    --枪口
    AddItem(ItemGroup, 201009, 1, 66)
    AddItem(ItemGroup, 201010, 1, 66)
    AddItem(ItemGroup, 201011, 1, 66)
    AddItem(ItemGroup, 201003, 1, 66)
    AddItem(ItemGroup, 201005, 1, 66)
    AddItem(ItemGroup, 201007, 1, 66)
    --弹夹
    AddItem(ItemGroup, 204011, 1, 66)
    AddItem(ItemGroup, 204012, 1, 66)
    AddItem(ItemGroup, 204013, 1, 66)
    AddItem(ItemGroup, 204007, 1, 66)
    AddItem(ItemGroup, 204008, 1, 66)
    AddItem(ItemGroup, 204009, 1, 66)
    --2倍3倍
    AddItem(ItemGroup, 203003, 1, 50)
    AddItem(ItemGroup, 203014, 1, 50)
    --4倍
    AddItem(ItemGroup, 203004, 1, 200)
    --握把
    AddItem(ItemGroup, 202001, 1, 40)
    AddItem(ItemGroup, 202002, 1, 40)
    AddItem(ItemGroup, 202004, 1, 40)
    AddItem(ItemGroup, 202005, 1, 40)
    AddItem(ItemGroup, 202006, 1, 40)
    --枪托
    AddItem(ItemGroup, 205002, 1, 400)
    --饮料
    AddItem(ItemGroup, 601001, 2, 400)
    --止痛药
    AddItem(ItemGroup, 601003, 2, 200)
    --绷带
    AddItem(ItemGroup, 601004, 5, 500)
    --治疗包
    AddItem(ItemGroup, 601005, 1, 200)
    --医疗箱
    AddItem(ItemGroup, 601006, 1, 100)
    --手雷
    AddItem(ItemGroup, 602004, 1, 400)
    --燃烧
    AddItem(ItemGroup, 602003, 1, 200)
    --闪光
    AddItem(ItemGroup, 602001, 1, 200)
    --烟雾
    AddItem(ItemGroup, 602002, 1, 400)


    --]]
    

    

    --怪物掉落

    --0 阶段
    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 100)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 106001, 1, 10)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 301001, 30, 10)
    
    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 200)
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    AddItem(ItemGroup, 108001, 1, 10)
 
   
    --1阶段·威胁值1-5

    --子弹，绷带，可乐6个类型随机掉落1个，几率各15%，不掉战利品几率5%。
    --子弹10个

    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 1)
    --子弹
    local ItemGroup = AddItemGroup(Data, 90 ,1)
    AddItem(ItemGroup, 304001, 10, 10)
    AddItem(ItemGroup, 303001, 30, 20)
    AddItem(ItemGroup, 302001, 30, 20)
    AddItem(ItemGroup, 301001, 30, 10)
    AddItem(ItemGroup, 305001, 30, 10)
    
    --药品
    local ItemGroup = AddItemGroup(Data, 20 ,1)
    AddItem(ItemGroup, 601004, 10, 10)
    AddItem(ItemGroup, 601001, 1, 10)

   --一级护甲
    local ItemGroup = AddItemGroup(Data, 1 ,1)
    AddItem(ItemGroup, 501001, 1, 10)
    AddItem(ItemGroup, 502001, 1, 10)
    AddItem(ItemGroup, 503001, 1, 10)

    --普通近战武器
    local ItemGroup = AddItemGroup(Data, 5 ,1)
    AddItem(ItemGroup, 108001, 1, 10)
    AddItem(ItemGroup, 108002, 1, 10)
    AddItem(ItemGroup, 108003, 1, 10)
    AddItem(ItemGroup, 108004, 1, 10)

     --手枪冲锋枪配件
    local ItemGroup = AddItemGroup(Data, 10 ,1)
    AddItem(ItemGroup, 201006, 1, 10)
    AddItem(ItemGroup, 204004, 1, 10)
    AddItem(ItemGroup, 204005, 1, 10)
    AddItem(ItemGroup, 204006, 1, 10)

    --瞄准镜
    local ItemGroup = AddItemGroup(Data, 15,1)
    AddItem(ItemGroup, 203001, 1, 10)
    AddItem(ItemGroup, 203002, 1, 10)
    
    --喷子配件
    local ItemGroup = AddItemGroup(Data, 5 ,1)
    AddItem(ItemGroup, 201001, 1, 10)
    AddItem(ItemGroup, 204010, 1, 10)
    

    --2阶段·威胁值6-10

    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 2)
        --子弹
    local ItemGroup = AddItemGroup(Data, 90 ,1)
    AddItem(ItemGroup, 304001, 10, 10)
    AddItem(ItemGroup, 303001, 45, 20)
    AddItem(ItemGroup, 302001, 45, 20)
    AddItem(ItemGroup, 301001, 45, 10)
    AddItem(ItemGroup, 305001, 45, 10)
      --药品
    local ItemGroup = AddItemGroup(Data, 30 ,1)
    AddItem(ItemGroup, 601005, 1, 10)
    AddItem(ItemGroup, 601003, 1, 10)
    --二级护甲
    local ItemGroup = AddItemGroup(Data, 1 ,1)
    AddItem(ItemGroup, 501002, 1, 10)
    AddItem(ItemGroup, 502002, 1, 10)
    AddItem(ItemGroup, 503002, 1, 10)
  
     
    local ItemGroup = AddItemGroup(Data, 40 ,1)
    --普通商店手枪
    AddItem(ItemGroup, 106001, 1, 10)
    AddItem(ItemGroup, 106002, 1, 10)
    AddItem(ItemGroup, 106004, 1, 10)
    AddItem(ItemGroup, 106005, 1, 10)
    --步枪枪口配件
    AddItem(ItemGroup, 201010, 1, 10)
    AddItem(ItemGroup, 201011, 1, 10)
    AddItem(ItemGroup, 201009, 1, 10)
    AddItem(ItemGroup, 201051, 1, 10)
    --步枪弹夹配件
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    --步枪握把
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202003, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    --瞄准镜
    AddItem(ItemGroup, 203003, 1, 10)
    AddItem(ItemGroup, 203014, 1, 10)
    AddItem(ItemGroup, 203018, 1, 10)

    --3阶段威胁值10-39 B级枪20%， A级别枪1%

    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 3)
     
    local ItemGroup = AddItemGroup(Data, 80 ,1)
    AddItem(ItemGroup, 304001, 30, 10)
    AddItem(ItemGroup, 303001, 90, 20)
    AddItem(ItemGroup, 302001, 90, 20)
    AddItem(ItemGroup, 301001, 90, 10)
    AddItem(ItemGroup, 305001, 90, 10)
      --药品
    local ItemGroup = AddItemGroup(Data, 35 ,1)
    AddItem(ItemGroup, 601006, 1, 10)
    AddItem(ItemGroup, 601002, 1, 10)
    --二级护甲
    local ItemGroup = AddItemGroup(Data, 1 ,1)
    AddItem(ItemGroup, 501002, 1, 10)
    AddItem(ItemGroup, 502002, 1, 10)
    AddItem(ItemGroup, 503002, 1, 10)
  
     
    local ItemGroup = AddItemGroup(Data, 20 ,1)
    --B级别枪
    AddItem(ItemGroup, 106003, 1, 10)
    AddItem(ItemGroup, 106008, 1, 10)
    AddItem(ItemGroup, 102001, 1, 10)
    AddItem(ItemGroup, 102002, 1, 10)
    AddItem(ItemGroup, 102003, 1, 10)
    AddItem(ItemGroup, 102004, 1, 10)
    AddItem(ItemGroup, 102005, 1, 10)
    AddItem(ItemGroup, 102007, 1, 10)
    AddItem(ItemGroup, 102008, 1, 10)
    AddItem(ItemGroup, 103008, 1, 10)
    AddItem(ItemGroup, 103005, 1, 10)
    AddItem(ItemGroup, 106006, 1, 10)
    AddItem(ItemGroup, 107005, 1, 10)
    AddItem(ItemGroup, 101011, 1, 10)
    AddItem(ItemGroup, 104002, 1, 10)
    AddItem(ItemGroup, 104001, 1, 10)
    AddItem(ItemGroup, 103001, 1, 10)
    AddItem(ItemGroup, 103011, 1, 10)
    AddItem(ItemGroup, 106005, 1, 10)
    AddItem(ItemGroup, 107001, 1, 10)
    

    local ItemGroup = AddItemGroup(Data, 1 ,1)
  
    --A枪
    AddItem(ItemGroup, 101001, 1, 10)
    AddItem(ItemGroup, 101002, 1, 10)
    AddItem(ItemGroup, 101003, 1, 10)
    AddItem(ItemGroup, 101005, 1, 10)
    AddItem(ItemGroup, 101007, 1, 10)
    AddItem(ItemGroup, 101008, 1, 10)
    AddItem(ItemGroup, 101009, 1, 10)
    AddItem(ItemGroup, 101010, 1, 10)
    AddItem(ItemGroup, 101011, 1, 10)
    AddItem(ItemGroup, 101012, 1, 10)
    AddItem(ItemGroup, 103010, 1, 10)
    AddItem(ItemGroup, 103004, 1, 10)
    AddItem(ItemGroup, 104100, 1, 10)
    AddItem(ItemGroup, 103013, 1, 10)
    AddItem(ItemGroup, 104003, 1, 10)
    AddItem(ItemGroup, 105002, 1, 10)
    AddItem(ItemGroup, 107096, 1, 10)
    AddItem(ItemGroup, 107008, 1, 10)
 


    local ItemGroup = AddItemGroup(Data, 100 ,1)
    
    AddItem(ItemGroup, 201010, 1, 10)
    AddItem(ItemGroup, 201011, 1, 10)
    AddItem(ItemGroup, 201009, 1, 10)
    AddItem(ItemGroup, 201051, 1, 10)
    --步枪弹夹配件
    AddItem(ItemGroup, 204011, 1, 10)
    AddItem(ItemGroup, 204012, 1, 10)
    AddItem(ItemGroup, 204013, 1, 10)
    --步枪握把
    AddItem(ItemGroup, 202001, 1, 10)
    AddItem(ItemGroup, 202002, 1, 10)
    AddItem(ItemGroup, 202003, 1, 10)
    AddItem(ItemGroup, 202004, 1, 10)
    AddItem(ItemGroup, 202005, 1, 10)
    --瞄准镜
    AddItem(ItemGroup, 203003, 1, 10)
    AddItem(ItemGroup, 203014, 1, 10)
    AddItem(ItemGroup, 203018, 1, 10)
    --手枪冲锋枪配件
    AddItem(ItemGroup, 201006, 1, 10)
    AddItem(ItemGroup, 204006, 1, 10)

  


    --4阶段 威胁值40 B级枪80%， A级枪8%
    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 4)
    local ItemGroup = AddItemGroup(Data, 80 ,1)
    AddItem(ItemGroup, 304001, 40, 10)
    AddItem(ItemGroup, 303001, 120, 20)
    AddItem(ItemGroup, 302001, 120, 20)
    AddItem(ItemGroup, 301001, 120, 10)
    AddItem(ItemGroup, 305001, 120, 10)
      --药品
    local ItemGroup = AddItemGroup(Data, 40 ,1)
    AddItem(ItemGroup, 601006, 1, 10)
    AddItem(ItemGroup, 601002, 1, 10)
    --二级护甲
    local ItemGroup = AddItemGroup(Data, 100,2)
    AddItem(ItemGroup, 501002, 1, 5)
    AddItem(ItemGroup, 502002, 1, 80)
    AddItem(ItemGroup, 503002, 1, 5)
  
    local ItemGroup = AddItemGroup(Data, 80 ,1)
    --B级别枪
    AddItem(ItemGroup, 106003, 1, 10)
    AddItem(ItemGroup, 106008, 1, 10)
    AddItem(ItemGroup, 102001, 1, 10)
    AddItem(ItemGroup, 102002, 1, 10)
    AddItem(ItemGroup, 102003, 1, 10)
    AddItem(ItemGroup, 102004, 1, 10)
    AddItem(ItemGroup, 102005, 1, 10)
    AddItem(ItemGroup, 102007, 1, 10)
    AddItem(ItemGroup, 102008, 1, 10)
    AddItem(ItemGroup, 103008, 1, 10)
    AddItem(ItemGroup, 103005, 1, 10)
    AddItem(ItemGroup, 106006, 1, 10)
    AddItem(ItemGroup, 107005, 1, 10)
    AddItem(ItemGroup, 101011, 1, 10)
    AddItem(ItemGroup, 104002, 1, 10)
    AddItem(ItemGroup, 104001, 1, 10)
    AddItem(ItemGroup, 103001, 1, 10)
    AddItem(ItemGroup, 103011, 1, 10)
    AddItem(ItemGroup, 106005, 1, 10)
    AddItem(ItemGroup, 107001, 1, 10)
    
    local ItemGroup = AddItemGroup(Data, 8 ,1)
  
    --A枪
    AddItem(ItemGroup, 101001, 1, 10)
    AddItem(ItemGroup, 101002, 1, 10)
    AddItem(ItemGroup, 101003, 1, 10)
    AddItem(ItemGroup, 101005, 1, 10)
    AddItem(ItemGroup, 101007, 1, 10)
    AddItem(ItemGroup, 101008, 1, 10)
    AddItem(ItemGroup, 101009, 1, 10)
    AddItem(ItemGroup, 101010, 1, 10)
    AddItem(ItemGroup, 101011, 1, 10)
    AddItem(ItemGroup, 101012, 1, 10)
    AddItem(ItemGroup, 103010, 1, 10)
    AddItem(ItemGroup, 103004, 1, 10)
    AddItem(ItemGroup, 104100, 1, 10)
    AddItem(ItemGroup, 103013, 1, 10)
    AddItem(ItemGroup, 104003, 1, 10)
    AddItem(ItemGroup, 105002, 1, 10)
    AddItem(ItemGroup, 107096, 1, 10)
    AddItem(ItemGroup, 107008, 1, 10)

    --必掉一配件
    local ItemGroup = AddItemGroup(Data, 100 ,1)
    --步枪枪口配件
    AddItem(ItemGroup, 201011, 1, 10)
    AddItem(ItemGroup, 201009, 1, 10)
    --步枪弹夹配件
    AddItem(ItemGroup, 204013, 1, 10)
    --步枪握把
    AddItem(ItemGroup, 202002, 1, 10)
    --瞄准镜
    AddItem(ItemGroup, 203004, 1, 10)
    --手枪冲锋枪配件
    AddItem(ItemGroup, 201006, 1, 10)
    AddItem(ItemGroup, 204006, 1, 10)
   

    --5阶段 威胁值100 小BOSS， 女武神。 A级枪100%，50%概率第二把， S级枪1%

    local Data = InitGroup(DropItemConfig.ItemKey.Monster, 5)
    
    --三级护甲
    local ItemGroup = AddItemGroup(Data, 100,2)
    AddItem(ItemGroup, 501003, 1, 5)
    AddItem(ItemGroup, 502003, 1, 80)
    AddItem(ItemGroup, 503003, 1, 5)
  
     --必掉一武器+随机50%一武器
     
    local ItemGroup = AddItemGroup(Data, 100 ,1)
  
     --A枪
     AddItem(ItemGroup, 101001, 1, 10)
     AddItem(ItemGroup, 101002, 1, 10)
     AddItem(ItemGroup, 101003, 1, 10)
     AddItem(ItemGroup, 101005, 1, 10)
     AddItem(ItemGroup, 101007, 1, 10)
     AddItem(ItemGroup, 101008, 1, 10)
     AddItem(ItemGroup, 101009, 1, 10)
     AddItem(ItemGroup, 101010, 1, 10)
     AddItem(ItemGroup, 101011, 1, 10)
     AddItem(ItemGroup, 101012, 1, 10)
     AddItem(ItemGroup, 103010, 1, 10)
     AddItem(ItemGroup, 103004, 1, 10)
     AddItem(ItemGroup, 104100, 1, 10)
     AddItem(ItemGroup, 103013, 1, 10)
     AddItem(ItemGroup, 104003, 1, 10)
     AddItem(ItemGroup, 105002, 1, 10)
     AddItem(ItemGroup, 107096, 1, 10)
     AddItem(ItemGroup, 107008, 1, 10)

    local ItemGroup = AddItemGroup(Data, 50 ,1)
  
     --A枪
     AddItem(ItemGroup, 101001, 1, 10)
     AddItem(ItemGroup, 101002, 1, 10)
     AddItem(ItemGroup, 101003, 1, 10)
     AddItem(ItemGroup, 101005, 1, 10)
     AddItem(ItemGroup, 101007, 1, 10)
     AddItem(ItemGroup, 101008, 1, 10)
     AddItem(ItemGroup, 101009, 1, 10)
     AddItem(ItemGroup, 101010, 1, 10)
     AddItem(ItemGroup, 101011, 1, 10)
     AddItem(ItemGroup, 101012, 1, 10)
     AddItem(ItemGroup, 103010, 1, 10)
     AddItem(ItemGroup, 103004, 1, 10)
     AddItem(ItemGroup, 104100, 1, 10)
     AddItem(ItemGroup, 103013, 1, 10)
     AddItem(ItemGroup, 104003, 1, 10)
     AddItem(ItemGroup, 105002, 1, 10)
     AddItem(ItemGroup, 107096, 1, 10)
     AddItem(ItemGroup, 107008, 1, 10)

    local ItemGroup = AddItemGroup(Data, 1 ,1)
    
    --S枪
    AddItem(ItemGroup, 102105, 1, 10)
    AddItem(ItemGroup, 101005, 1, 10)
    AddItem(ItemGroup, 107098, 1, 10)
    AddItem(ItemGroup, 103003, 1, 10)
    AddItem(ItemGroup, 105001, 1, 10)
    AddItem(ItemGroup, 101006, 1, 10)
    AddItem(ItemGroup, 103902, 1, 10)
    AddItem(ItemGroup, 103014, 1, 10)
    AddItem(ItemGroup, 103100, 1, 10)
    AddItem(ItemGroup, 101008, 1, 10)
    AddItem(ItemGroup, 101004, 1, 10)
    AddItem(ItemGroup, 101013, 1, 10)
    AddItem(ItemGroup, 103009, 1, 10)
   
    
    
end

DropItemConfig.InitConfig()

return DropItemConfig