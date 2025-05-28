---@class BP_ShopComponent_C:ActorComponent
--Edit Below--
local DependencyProperty = require("common.DependencyProperty")

local BP_EnemyShopComponent = BP_EnemyShopComponent or {}

BP_EnemyShopComponent.DataSource1 = 
{
    Items = 
    {
        --怪物升级商店

        {
            Key = "Level1", 
            Cost = 950, 
            Description = "汪汪队立大功！", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "汪汪队",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Insectpic.Insectpic')--UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Insectpic.Insectpic')
        },
        {
            Key = "Level2", 
            Cost = 950, 
            Description = "听说能够拿来下酒！", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "蝎子",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Scorpin.Scorpin')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Scorpin.Scorpin')
        }, {
            Key = "Level3", 
            Cost = 950, 
            Description = "这种狼人跟哈士奇有点血缘关系", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "小狼人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Wolf1.Wolf1')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Wolf1.Wolf1')
        }, {
            Key = "Level4", 
            Cost = 950, 
            Description = "训练精良的特种士兵，手持30cm尼泊尔军刀，会冲刺加速攻击", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "刀斧手",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Kandaoguaipic.Kandaoguaipic')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Kandaoguaipic.Kandaoguaipic')
        }, {
            Key = "Level5", 
            Cost = 950, 
            Description = "装备精良的枪手，三连发开枪射击敌人", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "枪手",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/shooter.shooter')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/shooter.shooter')
        }, {
            Key = "Level6", 
            Cost = 1000, 
            Description = "超级大的扑棱蛾子，会吐出毒液攻击敌人，还会在地上留下一滩毒液，Yue恶心", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "大扑棱蛾子",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BLCpic.BLCpic')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BLCpic.BLCpic')
        }, {
            Key = "Level7", 
            Cost = 1000, 
            Description = "从魔戒世界里面穿越而来，被仇恨填满的他现在会不知疲倦的追击敌人", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "小咕噜",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Kuangzhanl.Kuangzhanl')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Kuangzhanl.Kuangzhanl')
        }, {
            Key = "Level8", 
            Cost = 1000, 
            Description = "听说发明这款炸弹机器人的奥多汤姆皮特博士获得了诺贝尔奖提名", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "ATP炸弹机器人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Boomer.Boomer')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Boomer.Boomer')
        }, {
            Key = "Level9", 
            Cost = 1000, 
            Description = "这种狼人有着严重的口腔溃疡，吐出去的口水能够腐蚀敌人", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "裂嘴狼人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Wolf2.Wolf2')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Wolf2.Wolf2')
        }, {
            Key = "Level10", 
            Cost = 1000, 
            Description = "你的敌人要倒大霉了！ 这些训练有素的狙击手一枪一个准儿", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "狙击手",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Sniper.Sniper')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Sniper.Sniper')
        },
        {
            Key = "Level11", 
            Cost = 1050, 
            Description = "这些持盾士兵就像战神阿喀琉斯一样，唯一的弱点是他们的脚踝", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "持盾士兵",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Dunpaiguai.Dunpaiguai')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Dunpaiguai.Dunpaiguai')
        },
        {
            Key = "Level12", 
            Cost = 1050, 
            Description = "你的敌人该小心了！这些不知疲倦的机器人不知道从哪找来了电击枪", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "电击机器人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaLightninger.TeslaLightninger')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaLightninger.TeslaLightninger')
        },

        {
            Key = "Level13", 
            Cost = 1050, 
            Description = "这些机器人所持的霰弹枪可以一次性打出三发子弹，威胁扇形范围内的所有敌人", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "霰弹枪机器人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaShotguner3.TeslaShotguner3')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaShotguner3.TeslaShotguner3')
        },
        {
            Key = "Level14", 
            Cost = 1050, 
            Description = "这些机器人学会了三连发点射，把他们送给你的对手吧！", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "机枪机器人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Teslashooter.Teslashooter')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Teslashooter.Teslashooter')
        },
        {
            Key = "Level15", 
            Cost = 1050, 
            Description = "小咕噜叫来了他的大哥！现在所有人都无法忽视他了", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "大咕噜",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/KuangzhanBig.KuangzhanBig')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/KuangzhanBig.KuangzhanBig')
        },
        {
            Key = "Level16", 
            Cost = 1100, 
            Description = "这些狼人可以搬起大石块砸向敌人，当年愚公要是有这样的狼人手下该多好", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "大狼人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Wolf3.Wolf3')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Wolf3.Wolf3')
        },
        {
            Key = "Level17", 
            Cost = 1100, 
            Description = "队长级机器人都做了护甲跟视觉模块升级，他们所持重型机关枪可以5连发射击", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "机器人队长",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaBig.TeslaBig')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaBig.TeslaBig')
        },
        {
            Key = "Level18", 
            Cost = 1100, 
            Description = "这些科学家把自己改造成了最得意的作品，他们可以远程攻击也可以近战攻击敌人", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "基因科学家",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Scientist.Scientist')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Scientist.Scientist')
        },
        {
            Key = "Level19", 
            Cost = 1100, 
            Description = "看到这些狙击机器人瞄准镜上的红光了吗，你应该庆幸他们的敌人不是你", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "狙击机器人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaSniper.TeslaSniper')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaSniper.TeslaSniper')
        },
        
        
        {
            Key = "LevelMax", 
            Cost = 2000, 
            Description = "这些机器人指挥官每一个都是万里挑一的老兵，他们持有的能量武器可以8连发射击！", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "机器人指挥官",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaCaptain.TeslaCaptain')
            --UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaCaptain.TeslaCaptain')
        },
        
    }, 
}


BP_EnemyShopComponent.DataSource2 = 
{
    
    Items = 
    {
        --怪物召唤商店

        {
            Key = "Monster1", 
            Cost = 550, 
            Description = "这些狙击手是百战精英，除了能精准的射击敌人，他们还会扔出手雷造成范围伤害！", 
            ItemId = 1,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "精英狙击手",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Sniper.Sniper'),
            HealthList = {2400,6300,14000}
        },

        {
            Key = "Monster2", 
            Cost = 1100, 
            Description = "如果一发导弹解决不了问题，那就两发！", 
            ItemId = 2,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "导弹机器人",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/TeslaRocket.TeslaRocket'),
            HealthList = {4700,12600,28000}
        },    
        
        {
            Key = "Monster3", 
            Cost = 2050, 
            Description = "这个基因体手持一面刀枪不入的盾牌，而且属土拨鼠，可以使出钻地攻击！", 
            ItemId = 3,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 3,
            BulletNeed = "持盾基因体",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Tankpicture.Tankpicture'),
            HealthList = {7100,19000,42500}
        },  

        {
            Key = "Monster4", 
            Cost = 3700, 
            Description = "你也要起舞吗？", 
            ItemId = 4,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 1,
            BulletNeed = "女武神",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Jstk.Jstk'),
            HealthList = {10500,28000,64000}
        },    
        
        
        
        {
            Key = "Monster5", 
            Cost = 6600, 
            Description = "当执行官降落在场上时，你的对手应该感到绝望", 
            ItemId = 5,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 2,
            BulletNeed = "机甲执行官",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/Zhixinguan.Zhixinguan'),
            HealthList = {14000,38000,85000}
        },    
        
        








        -- 战术技能商店
        {
            Key = "skill_1", 
            Cost = 1000, 
            Description = "召唤一枚毁天灭地的炸弹轰炸敌方场地", 
            ItemId = 100,
            Count = 10, 
            Cooldown = 10,
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 1,
            BulletNeed = "地狱火炸弹",
            Picture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill8_1.BuffSkill8_1')
            --'/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_Prop_EMPUAV.Icon_Prop_EMPUAV'
        },      
      
        -- 战术增益商店
        {
            Key = "skill_2", 
            Cost = 1000, 
            Description = "召唤一挺可以输出成吨伤害的M4机枪援助", 
            ItemId = 200,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 1,
            BulletNeed = "M4机枪炮台",
            Picture =  '/Game/UGC/UMGTemplate/RockingCarUI/UI/Texture/NoAtlas/RC_Icon_Shamoxianfeng.RC_Icon_Shamoxianfeng'
            --''/Game/UGC/UMGTemplate/RockingCarUI/UI/Texture/NoAtlas/RC_Icon_Shamoxianfeng.RC_Icon_Shamoxianfeng'
        },      


    }, 
}

function BP_EnemyShopComponent:GetDataSourceItem(ShopType,ItemKey,PlayerController)
    local DataSource = nil
    if ShopType == 1 then
        DataSource = self.DataSource1
    elseif ShopType == 2 then
        DataSource = self.DataSource2
    elseif ShopType == 3 then
        DataSource = self.DataSource3
    elseif ShopType == 4 then
        DataSource = self.DataSource4
    elseif ShopType == 5 then
        DataSource = self.DataSource5
    else
        ugcprint("error BP_EnemyShopComponent:GetDataSourceItem ShopType is nil"..ShopType)
        return nil
    end
    for _, Category in pairs(DataSource) do
        for X, Y in pairs(Category) do
            if type(Y) == "table" and Y.Key == ItemKey then
                return  Y
            end
        end
    end
    return nil
end
return BP_EnemyShopComponent