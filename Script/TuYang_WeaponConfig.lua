local TuYang_WeaponConfig = {}

local BP_ShopComponent = require("Script.BP_ShopComponent")

TuYang_WeaponConfig.ItemKey = 
{
    WeaponKey = "WeaponKey";
    WeaponItemID = "WeaponItemID";
}
TuYang_WeaponConfig.ItemsGroup = 
{
    [TuYang_WeaponConfig.ItemKey.WeaponKey] = {};
    [TuYang_WeaponConfig.ItemKey.WeaponItemID] = {};
}
local function InitGroup(GroupName, GroupID, Group)
    TuYang_WeaponConfig.ItemsGroup[GroupName][GroupID] = Group
    return TuYang_WeaponConfig.ItemsGroup[GroupName][GroupID]
end
-- local function InitGroup(GroupName,Group)
--     TuYang_WeaponConfig.ItemsGroup[GroupName] = Group
--     return TuYang_WeaponConfig.ItemsGroup[GroupName]
-- end

function TuYang_WeaponConfig.InitConfig()
    for k, v in pairs(TuYang_WeaponConfig.WeaponData) do
        InitGroup(TuYang_WeaponConfig.ItemKey.WeaponKey,v.Key, v)
        InitGroup(TuYang_WeaponConfig.ItemKey.WeaponItemID,v.ItemID, v)
    end


      ----- Log -> Config
    --   local WeaponLevelTwo = {}
    --   table.insert(WeaponLevelTwo, TuYang_WeaponConfig:CreateNewDataBasedOnTheOldStore("M249",2))


    --   table.insert(WeaponLevelTwo, TuYang_WeaponConfig:CreateNewDataBasedOnTheOldStore("PKM",3))

    --   table.insert(WeaponLevelTwo, TuYang_WeaponConfig:CreateNewDataBasedOnTheOldStore("M134",4))
    --   local tDataString = TuYang_WeaponConfig:AllTableToString(WeaponLevelTwo)
    --   UGCLog.Log("武器配置",tDataString)


    -- GetWeaponOriginalData
    
end

function TuYang_WeaponConfig:GetWeaponItems(Key, GroupID)
    local Group = TuYang_WeaponConfig.ItemsGroup[Key]
    if Group == nil then
        print("Error TuYang_WeaponConfig.GetDropItems: Key:"..Key)
        return
    end

    local ItemGroup = Group[GroupID]
    if ItemGroup == nil then
        print("Error TuYang_WeaponConfig.GetDropItems: Key: "..Key.."  GroupId: "..GroupID)
        return
    end 
    return TuYang_WeaponConfig.ItemsGroup[Key][GroupID]
end
-- 找不到的武器  GBZ 



TuYang_WeaponConfig.WeaponData = 
{
    {
        Key = "MZJ_HD",
        Name = "红点瞄准镜",
        ItemID = 203001, 
        Cost = 200, 
        Level = 0,
        Description = "", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_HD.Icon_MZJ_HD',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Helmet_Lv2",
        Name = "摩托车头盔",
        ItemID = 502002, 
        Cost = 200, 
        Level = 2,
        Description = "摩托车头盔(2级)", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv2_A.Icon_Helmet_Lv2_A',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Helmet_Lv3",
        Name = "特种部队头盔",
        ItemID = 502003, 
        Cost = 3750, 
        Level = 2,
        Description = "特种部队头盔(3级)", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv3.Icon_Helmet_Lv3',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Armor_Lv2",
        Name = "警用防弹衣",
        ItemID = 503002, 
        Cost = 3750, 
        Level = 3,
        Description = "警用防弹衣(2级)", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv2.Icon_Armor_Lv2',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Armor_Lv3",
        Name = "3级防弹衣",
        ItemID = 503003, 
        Cost = 3750, 
        Level = 3,
        Description = "3级防弹衣(3级)", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv3.Icon_Armor_Lv3',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Sickle",
        Name = "镰刀",
        ItemID = 108003, 
        Cost = 3750, 
        Level = 1,
        Description = "农民伯伯，收割利器，搭配移速流技能使用。", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Sickle.Icon_WEP_Sickle',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Machete",
        Name = "大砍刀",
        ItemID = 108001, 
        Cost = 3750, 
        Level = 3,
        Description = "看着怪吓人的，搭配移速流技能使用。", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Machete.Icon_WEP_Machete',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Cowbar",
        Name = "撬棍",
        ItemID = 108002, 
        Cost = 3750, 
        Level = 1,
        Description = "给我一个支点，我能撬起整个地球，搭配移速流技能使用。", 
        Count = 2, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Cowbar.Icon_WEP_Cowbar',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "Pan",
        Name = "平底锅",
        ItemID = 108004, 
        Cost = 3750, 
        Level = 4,
        Description = "用小锅锅砸你胸口！ 搭配移速流技能使用。", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Pan.Icon_WEP_Pan',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "P92",
        Name = "P92",
        ItemID = 106001, 
        Cost = 3750, 
        Level = 1,
        Description = "P92详情 需要9mm子弹", 
        Count = 1, 
        BulletNeed = "需要9mm子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P92.Icon_WEP_P92',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "P1911",
        Name = "P1911",
        ItemID = 106002, 
        Cost = 3750, 
        Level = 1,
        Description = "P1911 需要.45子弹", 
        Count = 1, 
        BulletNeed = "需要9mm子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P1911.Icon_WEP_P1911',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "P18C",
        Name = "P18C",
        ItemID = 106004, 
        Cost = 3750, 
        Level = 1,
        Description = "P18C 需要9mm子弹", 
        Count = 1, 
        BulletNeed = "需要9mm子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P18C.Icon_WEP_P18C',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "R45",
        Name = "R45",
        ItemID = 106005, 
        Cost = 3750, 
        Level = 1,
        Description = "R45 需要.45子弹", 
        Count = 1, 
        BulletNeed = "需要9mm子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Rhino.Icon_WEP_Rhino',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "SawM79",
        Name = "短管榴弹",
        ItemID = 107096, 
        Cost = 4000, 
        Level = 1,
        Description = " 需要40mm榴弹", 
        Count = 1, 
        BulletNeed = "需要40mm榴弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SawedOffM79.Icon_WEP_SawedOffM79',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    }, 

    -- 一级武器
    {
        Key = "Famas",
        Name = "Famas步枪",
        ItemID = 101013, 
        Cost = 3750, 
        Level = 1,
        Description = "经典3连发步枪，3连发武器伤害48，射速每秒发射4.8发子弹，弹匣容量30", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Famas.Icon_WEP_Famas',
        TagList = {},
        Damage = 48,
        ShootIntervalScale = 1,
    },
    {
        Key = "QBZ95",
        Name = "QBZ95",
        ItemID = 101007, 
        Cost = 3750, 
        Level = 1,
        Description = "拥有单发和全自动两种模式。后坐力较低，稳定性优异，缺点是装填速度较慢，百搭元素流技能", 
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_QBZ95_Small.Icon_WEP_QBZ95_Small',
        TagList = {},
        Damage = 21,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "G36C",
        Name = "G36C",
        ItemID = 101010, 
        Cost = 3750, 
        Level = 1,
        Description = "拥有单发和全自动两种模式，是一把非常全面的武器，无特别明显的优缺点，百搭元素流技能", 
        Count = 1, 
        BulletNeed = "需要5.56子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_G36C.Icon_WEP_G36C',
        TagList = {},
        Damage = 21,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "M16A4",
        Name = "M16A4",
        ItemID = 101002, 
        Cost = 3750, 
        Level = 1,
        Description = "拥有单发和三连发两种模式，三连发射速快，近战爆发力强；缺点是没有全自动模式，百搭元素流技能", 
        Count = 1, 
        BulletNeed = "需要5.56子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M16A4.Icon_WEP_M16A4',
        TagList = {},
        Damage = 15,
        ShootIntervalScale = 1,
    },
    {
        Key = "Thompson",
        Name = "汤姆逊",
        ItemID = 102004, 
        Cost = 3750, 
        Level = 1,
        Description = "比其他冲锋枪单发伤害更高，载弹量高，近战可持续火力压制，适合射速流技能",
        Count = 1, 
        BulletNeed = "需要点45子弹",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Thompson.Icon_WEP_Thompson',
        TagList = {},
        Damage = 22,
        ShootIntervalScale = 1.1,
    },
    {
        Key = "UZI",
        Name = "UZI",
        ItemID = 102001, 
        Cost = 3750, 
        Level = 1,
        Description = "机动性强，射速极快，近战之王，缺点是需要频繁换弹，适合射速流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_UZI.Icon_WEP_UZI',
        TagList = {},
        Damage = 17,
        ShootIntervalScale = 1.0,
    },
    {
        Key = "Skorpion",
        Name = "蝎式手枪",
        ItemID = 106008, 
        Cost = 3750, 
        Level = 1,
        Description = "便携式冲锋手枪，弹容量大，缺点是威力较小，适合射速流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Skorpion.Icon_WEP_Skorpion',
        TagList = {},
        Damage = 20,
        ShootIntervalScale = 1.0,
    },
    {
        Key = "AKS74",
        Name = "AKS74",
        ItemID = 102008, 
        Cost = 3750, 
        Level = 1,
        Description = "性能均衡的冲锋枪，拥有折叠枪托，便于携行和进出载具，适合射速流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AKS.Icon_WEP_AKS',
        TagList = {},
        Damage = 22,
        ShootIntervalScale = 1.1,
    },
    {
        Key = "S686",
        Name = "S686",
        ItemID = 104001, 
        Cost = 3750, 
        Level = 1,
        Description = "双管猎枪，2发子弹射击间隔非常短，爆发高，每次射击发射9颗弹丸，适合概率流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S686.Icon_WEP_S686',
        TagList = {},
        Damage = 17,
        ShootIntervalScale = 1,
    },
    {
        Key = "S1897",
        Name = "S1897",
        ItemID = 104002, 
        Cost = 3750, 
        Level = 1,
        Description = "威力突出的霰弹枪，需要手动上膛，换弹速度较慢，每次射击发射9颗弹丸，适合概率流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S1897.Icon_WEP_S1897',
        TagList = {},
        Damage = 10,
        ShootIntervalScale = 1,
    },
    {
        Key = "SawedOff",
        Name = "短管霰弹枪",
        ItemID = 106006, 
        Cost = 3750, 
        Level = 1,
        Description = "枪威力较大适合近战或巷战，缺点持续输出较弱。每次射击发射9颗弹丸，适合概率流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/WeaponIcons/Icon256x128/Icon_WEP_SawedOff.Icon_WEP_SawedOff',
        TagList = {},
        Damage = 18,
        ShootIntervalScale = 1,
    },
    {
        Key = "Kar98k",
        Name = "Kar98k",
        ItemID = 103001, 
        Cost = 3750, 
        Level = 1,
        Description = "性能优异的单发栓动狙击枪。单发伤害高。对枪法依赖很高，适合CD流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Kar98k.Icon_WEP_Kar98k',
        TagList = {},
        Damage = 250,
        ShootIntervalScale = 1,
    },
    {
        Key = "Win94",
        Name = "Win94狙击枪",
        ItemID = 103008, 
        Cost = 3750, 
        Level = 1,
        Description = "经典老式杠杆步枪，威力大，可快速射击，适合CD流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Win1894.Icon_WEP_Win1894',
        TagList = {},
        Damage = 130,
        ShootIntervalScale = 0.8,
    },
    {
        Key = "SVD",
        Name = "SVD狙击枪",
        ItemID = 103016, 
        Cost = 3750, 
        Level = 1,
        Description = "全球广泛列装的半自动狙击步枪，支持稳定、连续的射击，适合CD流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SVD.Icon_WEP_SVD',
        TagList = {},
        Damage = 140,
        ShootIntervalScale = 0.8,
    },
    {
        Key = "Bow",
        Name = "十字弩",
        ItemID = 107001, 
        Cost = 3750, 
        Level = 1,
        Description = "末世极品武器，弩箭伤害很高，但由于装弹慢，容错率很低，适合CD流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Crossbow.Icon_WEP_Crossbow',
        TagList = {},
        Damage = 350,
        ShootIntervalScale = 1,
    },
    {
        Key = "DP28",
        Name = "DP28",
        ItemID = 105002, 
        Cost = 3750, 
        Level = 1,
        Description = "大盘鸡来一份，重武器减少25%移动速度，额外增加30点生命值,适合阵地流技能",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DP28.Icon_WEP_DP28',
        TagList = {},
        Damage = 25,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "VAL",
        Name = "VAL",
        ItemID = 101011,
        Cost = 3750,
        Level = 1,
        Description = "自带消音器，稳定性高，是适合近距离作战的特种突击步枪，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_VAL.Icon_WEP_VAL",
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    },
    {
        Key = "HoneyBadger",
        Name = "蜜獾突击步枪",
        ItemID = 101012,
        Cost = 0,
        Level = 2,
        Description = "枪体短，爆发高，适合近距离作战，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_HoneyBadger.Icon_WEP_HoneyBadger",
        TagList = {},
        Damage = 22,
        ShootIntervalScale = 1.1,
    },
    {
        Key = "SCAR-L",
        Name = "SCAR-L",
        ItemID = 101003, 
        Cost = 3750, 
        Level = 2,
        Description = "后坐力低，容易操控，精准而稳定，综合性能优异，缺点是射速不如其他同级别步枪，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SCAR.Icon_WEP_SCAR",
        TagList = {},
        Damage = 23,
        ShootIntervalScale = 1.1,
    },
    {
        Key = "AK47",
        Name = "AK47",
        ItemID = 101001,
        Cost = 3750,
        Level = 2,
        Description = "唯一真神阿卡47，单发伤害高是它最大的优势，但后坐力很大，难以操控；推荐高手使用，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath =  "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AK47.Icon_WEP_AK47",
        TagList = {},
        Damage = 26,
        ShootIntervalScale = 1.1,
    },
    {
        Key = "MP5K",
        Name = "MP5K",
        ItemID = 102007,
        Cost = 3750,
        Level = 2,
        Description = "拥有单发、3连发、全自动模式的冲锋枪。伤害稳定，适合近距离作战，适合射速流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MP5K.Icon_WEP_MP5K",
        TagList = {},
        Damage = 24,
        ShootIntervalScale = 1,
    },
    {
        Key = "Vector",
        Name = "Vector",
        ItemID = 102003,
        Cost = 3750,
        Level = 2,
        Description = "射速很快，稳定性强，机动性强，缺点就是载弹量低，适合射速流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath ="/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Vector.Icon_WEP_Vector",
        TagList = {},
        Damage = 23,
        ShootIntervalScale = 1,
    },
    {
        Key = "UMP45",
        Name = "UMP45",
        ItemID = 102002,
        Cost = 3750,
        Level = 2,
        Description = "机动性强，稳定性强，综合性能优异，但各方面表现都不够突出，适合射速流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath ="/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_UMP45.Icon_WEP_UMP45",
        TagList = {},
        Damage = 28,
        ShootIntervalScale = 1,
    },
    {
        Key = "S12K",
        Name = "S12K",
        ItemID = 104003,
        Cost = 3750,
        Level = 2,
        Description = "半自动霰弹枪。容错率高，十分好用，每次发射9颗弹丸，适合概率流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S12K.Icon_WEP_S12K",
        TagList = {},
        Damage = 12,
        ShootIntervalScale = 1,
    },
    {
        Key = "SPAS-12",
        Name = "SPAS-12",
        ItemID = 104100,
        Cost = 3750,
        Level = 2,
        Description = "半自动霰弹枪，大威力，中距离，单发装填，每次发射9颗弹丸，适合概率流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SPAS.Icon_WEP_SPAS",
        TagList = {},
        Damage = 15,
        ShootIntervalScale = 1,
    },
    {
        Key = "M24",
        Name = "M24",
        ItemID = 103002,
        Cost = 3750,
        Level = 2,
        Description = "性能优异的单发栓动狙击枪，单发伤害高，对枪法依赖高，适合CD流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M24.Icon_WEP_M24",
        TagList = {},
        Damage = 280,
        ShootIntervalScale = 1,
    },
    {
        Key = "SKS",
        Name = "SKS",
        ItemID = 103004,
        Cost = 3750,
        Level = 2,
        Description = "某半自动精确射手步枪。单发伤害高。枪械本身后坐力大，难以操控，适合CD流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SKS.Icon_WEP_SKS",
        TagList = {},
        Damage = 50,
        ShootIntervalScale = 1.2,
        },
    {
        Key = "Mosin",
        Name = "莫辛纳甘",
        ItemID = 103011,
        Cost = 3750,
        Level = 2,
        Description = "经典单发栓动狙击枪。单发伤害高，对枪法依赖很高，适合CD流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_mosin.Icon_WEP_mosin",
        TagList = {},
        Damage = 250,
        ShootIntervalScale = 0.8,
    },
    {
        Key = "M249",
        Name = "M249大菠萝",
        ItemID = 105001,
        Cost = 3750,
        Level = 2,
        Description = "能形成强大火力压制的大菠萝，重武器减少25%移动速度，额外增加55点生命值，适合阵地流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M249.Icon_WEP_M249",
        TagList = {},
        Damage = 27,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "M416",
        Name = "M416步枪",
        ItemID = 101004,
        Cost = 3750,
        Level = 3,
        Description = "是一把非常全面的武器，适合各种距离下使用，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath =  "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M416.Icon_WEP_M416",
        TagList = {},
        Damage = 30,
        ShootIntervalScale = 1.1,
    },
    {
        Key = "M762",
        Name = "M762步枪",
        ItemID = 101008,
        Cost = 3750,
        Level = 3,
        Description = "威力较大射速高，水平后坐力小，缺点是垂直后坐力较大，非常考验压枪技巧，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M762_Small.Icon_WEP_M762_Small",
        TagList = {},
        Damage = 35,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "JS9",
        Name = "JS9冲锋枪",
        ItemID = 102009,
        Cost = 10,
        Level = 3,
        Description = "JS9的经典无托结构提供了超高的射击稳定性，适合射速流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_JS9.Icon_WEP_JS9",
        TagList = {},
        Damage = 24,
        ShootIntervalScale = 1,
    },
    {
        Key = "PP19",
        Name = "野牛冲锋枪",
        ItemID = 102005,
        Cost = 3750,
        Level = 3,
        Description = "拥有一个特殊的53发大容量弹匣，持续火力强，压制利器，适合射速流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PP19.Icon_WEP_PP19",
        TagList = {},
        Damage = 26,
        ShootIntervalScale = 1,
    },
    {
        Key = "DBS",
        Name = "DBS",
        ItemID = 104004,
        Cost = 3750,
        Level = 3,
        Description = "无托泵动双管霰弹枪，一次上膛两次击发，爆发伤害高容错空间大，每次发射9颗弹丸，适合概率流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DP12.Icon_WEP_DP12",
        TagList = {},
        Damage = 12,
        ShootIntervalScale = 1,
    },
    {
        Key = "MK20-H",
        Name = "MK20-H",
        ItemID = 103014,
        Cost = 3750,
        Level = 3,
        Description = "自带重型枪管和脚架，使其在中远距离作战中，有着强大的威慑力。适合CD流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK20.Icon_WEP_MK20",
        TagList = {},
        Damage = 110,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "AWM",
        Name = "AWM",
        ItemID = 103003,
        Cost = 3750,
        Level = 3,
        Description = "中门对狙少不了它，伤害非常高，对枪法依赖高。适合CD流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AWM.Icon_WEP_AWM",
        TagList = {},
        Damage = 500,
        ShootIntervalScale = 1,
    },
    {
        Key = "PKM",
        Name = "PKM",
        ItemID = 105012,
        Cost = 3750,
        Level = 3,
        Description = "持续火力输出的通用机枪，重武器减少25%移动速度，额外增加215点生命值，适合阵地流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PKM.Icon_WEP_PKM",
        TagList = {},
        Damage = 38,
        ShootIntervalScale = 1.2,
    },
    {
        Key = "AUG",
        Name = "AUG",
        ItemID = 101006,
        Cost = 3750,
        Level = 4,
        Description = "拥有单发和全自动两种模式。后坐力小，易于操控，中远距离表现优秀，几乎没有缺点，百搭元素流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AUG.Icon_WEP_AUG',
        TagList = {},
        Damage = 43,
        ShootIntervalScale = 1,
    },
    {
        Key = "Groza",
        Name = "GROZA突击步枪",
        ItemID = 101005,
        Cost = 3750,
        Level = 4,
        Description = "中近距离表现最单发伤害高，射速快，是全自动中近距离表现最强的步枪，百搭元素派技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_GROZA.Icon_WEP_GROZA",
        TagList = {},
        Damage = 40,
        ShootIntervalScale = 1,
    },
    {
        Key = "P90",
        Name = "P90",
        ItemID = 102105,
        Cost = 3750,
        Level = 4,
        Description = "稳定性强，射速较高，自带全部配件的新型武器，适合射速流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P90_Set.Icon_WEP_P90_Set",
        TagList = {
        },
        Damage = 29,
        ShootIntervalScale = 0.8,
    },
    {
        Key = "AA12-G",
        Name = "AA12-G",
        ItemID = 104005,
        Cost = 3750,
        Level = 4,
        Description = " 雪隼AA12G可以撕碎一切，每次发射9颗弹丸，适合概率流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AA12.Icon_WEP_AA12",
        TagList = {
        },
        Damage = 16,
        ShootIntervalScale = 1,
    },
    {
        Key = "M200",
        Name = "M200",
        ItemID = 103015,
        Cost = 3750,
        Level = 4,
        Description = "传说中可以一枪爆7头的武器，拥有全场最高的单发伤害，适合CD流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M200.Icon_WEP_M200",
        TagList = {},
        Damage = 650,
        ShootIntervalScale = 1,
    },
    {
        Key = "AMR",
        Name = "AMR狙击枪",
        ItemID = 103012,
        Cost = 3750,
        Level = 4,
        Description = "伤害非常高的反器材狙击枪，适合CD流技能。",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AMR.Icon_WEP_AMR",
        TagList = {},
        Damage = 550,
        ShootIntervalScale = 1,
    },
    {
        Key = "MG3",
        Name = "MG3",
        ItemID = 105010,
        Cost = 3750,
        Level = 4,
        Description = "织布机与毁灭者，重武器减少25%移动速度，额外增加215点生命值，适合阵地流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MG3.Icon_WEP_MG3",
        TagList = {},
        Damage = 45,
        ShootIntervalScale = 1,
    },
    {
        Key = "M134",
        Name = "M134",
        ItemID = 105003,
        Cost = 3750,
        Level = 4,
        Description = "真男人就要玩加特林，重武器减少25%移动速度，额外增加215点生命值，适合阵地流技能",
        Count = 1,
        BulletNeed = "",
        TexturePath = "/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M134.Icon_WEP_M134",
        TagList = {},
        Damage = 17,
        ShootIntervalScale = 1,
    }
   
}

TuYang_WeaponConfig.WeaponAddAccessories = 
{
    ["AWM"] = 
    {
        "MZJ_HD"
    }
}
    
function TuYang_WeaponConfig:GetWeaponAddAccessoriesList(InKey)
    UGCLog.Log("[LJH]TuYang_WeaponConfig.GetWeaponAddAccessoriesList",InKey)
    local Group = TuYang_WeaponConfig.WeaponAddAccessories[InKey]
    if Group == nil then
        print("Error TuYang_WeaponConfig.GetWeaponAddAccessoriesList: Key:"..InKey)
        return nil
    end

   
    return TuYang_WeaponConfig.WeaponAddAccessories[InKey]
end


-------------------------------------以下功能仅用于测试  最好别放到项目中使用 -----------------------------------
-- 打印装有string的table
function TuYang_WeaponConfig:AllTableToString(tbl)
    local function SerializeTable(t, indent)
        local result = ""
        for _, v in ipairs(t) do
            if type(v) == "table" then
                result = result .. SerializeTable(v, indent + 1) .. ","
            else
                result = result .. tostring(v) .. ","
            end
        end
        return "\n".."{" .. result:sub(1, -2) .. "}"
    end
    return SerializeTable(tbl, 1)
end



-- 制作新的武器数据
function TuYang_WeaponConfig:CreateNewDataBasedOnTheOldStore(InItemID,InLevel)
    
    local tItemID
    local tDataSource
    local tData = {
        Key = "",
        Name = "",
        ItemID = 105002, 
        Cost = 3750, 
        Level = 1,
        Description = "需要7.62子弹",
        Count = 1, 
        BulletNeed = "",
        TexturePath = '',
        TagList = {},
        Damage = 0,
        ShootIntervalScale = 1,
    }
    local tDataString = ""
    tItemID = InItemID
    local tPath = '/Game/CSV/UGCItemOpen.UGCItemOpen'
    local tItemData = UGCGameSystem.GetTableDataByRowName(tPath,tostring(tItemID))
    local tItem = UGCItemSystem.GetItemData(tItemID)
    
    tData.Key = tItem.ArmorySimpleDesc
    tData.Name = tItem.ArmorySimpleDesc
    tData.ItemID = tItem.ItemID
    tData.Level = InLevel
    tData.Description = tItemData.ArmoryDesc
    tData.TexturePath = tItem.ItemSmallIcon_n
    -- if tDataSource ~= nil then
        
    
    -- else
    --     UGCLog.Log("BPPlayerController_ProtectAthena:CreateNewDataBasedOnTheOldStore tDataSource = nil!!!!!",InKey)  
    --     tData = {Key = InKey}
    -- end
    tDataString = self:TableToString_NewData(tData)
    return tDataString
end
function TuYang_WeaponConfig:TableToString_NewData(tbl)
    local function SerializeTable(t, indent)
        local result = "{\n"
        local indentStr = string.rep("    ", indent)
        local keysOrder = {
            "Key", "Name", "ItemID", "Cost", "Level", "Description", 
            "Count", "BulletNeed", "TexturePath", "TagList", "Damage", "ShootIntervalScale"
        }
        for _, key in ipairs(keysOrder) do
            local value = t[key]
            if value ~= nil then
                if type(value) == "table" then
                    value = SerializeTable(value, indent + 1)
                elseif type(value) == "string" then
                    value = string.format('"%s"', value)
                else
                    value = tostring(value)
                end
                result = result .. string.format("%s%s = %s,\n", indentStr, key, value)
            end
        end
        return result .. string.rep("    ", indent - 1) .. "}"
    end
    return SerializeTable(tbl, 1)
end



function TuYang_WeaponConfig:GetWeaponOriginalData(InPlayerController,InKey)
    local PlayerPawn = InPlayerController:GetPlayerCharacterSafety()  -- 获取玩家角色Pawn
    if PlayerPawn == nil then
        print("GetWeaponOriginalData PlayerPawn == nil")
        return 
    end
    local AllItemData = UGCBackPackSystem.GetAllItemData(PlayerPawn)
    for i, itemData in pairs(AllItemData) do
    local tType = UGCItemSystem.GetItemType(itemData.ItemID)
        if tType ~= 4 and tType <= 30 then
            UGCBackPackSystem.DropItemByInstanceID(PlayerPawn, itemData.InstanceID, itemData.Count,true) -- 删除物品 
        end                        
    end
    local DataSource = TuYang_WeaponConfig:GetWeaponItems(TuYang_WeaponConfig.ItemKey.WeaponKey,InKey)
    UGCBackPackSystem.AddItem(PlayerPawn, DataSource.ItemID, DataSource.Count)
    return TuYang_WeaponConfig:GetWeaponData(InKey,PlayerPawn)
end

function TuYang_WeaponConfig:GetWeaponData(InKey,PlayerPawn)
    local WeaponData = {}
    --local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(PlayerPawn)
    local weapon = UGCWeaponManagerSystem.GetWeaponBySlot(PlayerPawn,ESurviveWeaponPropSlot.SWPS_MainShootWeapon1)
    if weapon == nil then
        print("GetWeaponData weapon == nil  "..tostring(InKey))
        return 
    end
    WeaponData.Key = InKey
    WeaponData.Name = weapon:GetWeaponName()
    WeaponData.MaxBulletNum = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
    WeaponData.BulletFireSpeed = UGCGunSystem.GetBulletFireSpeed(weapon)
    WeaponData.ShootIntervalTime = UGCGunSystem.GetShootIntervalTime(weapon)
    WeaponData.BulletRange = UGCGunSystem.GetBulletRange(weapon)
    WeaponData.BulletBaseDamage = UGCGunSystem.GetBulletBaseDamage(weapon)
    WeaponData.BulletMinimumDamage = UGCGunSystem.GetBulletMinimumDamage(weapon)
    WeaponData.BulletImpulse = UGCGunSystem.GetBulletImpulse(weapon)
    WeaponData.ReloadTime = UGCGunSystem.GetReloadTime(weapon)
    WeaponData.TacticalReloadTime = UGCGunSystem.GetTacticalReloadTime(weapon)
    WeaponData.VerticalRecoilSacle = UGCGunSystem.GetVerticalRecoilSacle(weapon)
    WeaponData.HorizontalRecoilSacle = UGCGunSystem.GetHorizontalRecoilSacle(weapon)
    WeaponData.DeviationSacle = UGCGunSystem.GetDeviationSacle(weapon)
    
    local tString = self:TableToString_WeaponProperty(WeaponData)
    UGCLog.Log("[LJH]GetWeaponData",tString)

    return tString
end

function TuYang_WeaponConfig:TableToString_WeaponProperty(tbl)
    local function SerializeTable(t, indent)
        local result = "{\n"
        local indentStr = string.rep("    ", indent)
        local keysOrder = {
            "Key","Name", "MaxBulletNum", "BulletFireSpeed", "ShootIntervalTime", "BulletRange", 
            "BulletBaseDamage", "BulletMinimumDamage", "BulletImpulse", "ReloadTime", "TacticalReloadTime", "VerticalRecoilSacle",
            "HorizontalRecoilSacle", "DeviationSacle"
        }
        for _, key in ipairs(keysOrder) do
            local value = t[key]
            if value ~= nil then
                if type(value) == "table" then
                    value = SerializeTable(value, indent + 1)
                elseif type(value) == "string" then
                    value = string.format('"%s"', value)
                else
                    value = tostring(value)
                end
                result = result .. string.format("%s%s = %s,\n", indentStr, key, value)
            end
        end
        return result .. string.rep("    ", indent - 1) .. "}"
    end
    return SerializeTable(tbl, 1)
end







TuYang_WeaponConfig.InitConfig()

return TuYang_WeaponConfig