---@class BP_ShopComponent_C:ActorComponent
--Edit Below--
local DependencyProperty = require("common.DependencyProperty")

local BP_ShopComponent = BP_ShopComponent or {}

BP_ShopComponent.DataSource = 
{
    --[[
    Attributes = 
    {
        BuyHandler = function (self, ItemValue, PlayerController)
            PlayerController.Character[ItemValue.AttributeName] = PlayerController.Character[ItemValue.AttributeName] + ItemValue.DeltaAttribute
        end, 

        {
            Key = "Damage", 
            Cost = 1, 
            Description = "伤害 + %10", 
            AttributeName = "DamageScaleValue", 
            DeltaAttribute = 0.1, 
        }, 
    }, 
    --]] 

    Items = 
    {
        -- BuyHandler = function (self, ItemValue, PlayerController)
        --     -- if PlayerController.PlayerState.Gold >= ItemValue.Cost() then
        --         UGCBackPackSystem.AddItem(PlayerController:GetPlayerCharacterSafety(), ItemValue.ItemId, ItemValue.Count)
        --     -- end
        -- end, 

        --装备消耗品·车尾商店

        -- {
        --     Key = "Bullet45", 
        --     Cost = 10, 
        --     Description = "点45子弹", 
        --     ItemId = 305001,
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 1,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_45ACP_UG.Icon_Ammo_45ACP_UG'
        -- },

        -- {
        --     Key = "row", 
        --     Cost = 10, 
        --     Description = "弓箭", 
        --     ItemId = 307001,
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 2,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_bolt_UG.Icon_Ammo_bolt_UG'
        -- },

        -- {
        --     Key = "Bullet9", 
        --     Cost = 10, 
        --     Description = "9mm子弹", 
        --     ItemId = 301001,
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 3,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_9mm_UG.Icon_Ammo_9mm_UG'
        -- },

        -- {
        --     Key = "Bullet12", 
        --     Cost = 100, 
        --     Description = "12霰弹枪子弹", 
        --     ItemId = 304001,
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 4,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_12Guage_UG.Icon_Ammo_12Guage_UG'
        -- },

        -- {
        --     Key = "Bullet556",
        --     Cost = 30, 
        --     Description = "5.56 子弹", 
        --     ItemId = 303001, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 5,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_556mm_UG.Icon_Ammo_556mm_UG'
            
        -- }, 


        -- {
        --     Key = "Bullet762",
        --     Cost = 30, 
        --     Description = "7.62 子弹", 
        --     ItemId = 302001, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 6,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_762mm_UG.Icon_Ammo_762mm_UG'
        -- }, 

        -- {
        --     Key = "BulletRPG",
        --     Cost = 100, 
        --     Description = "火箭弹", 
        --     ItemId = 307002, 
        --     Count = 5, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 1,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_RPGBox.Icon_Ammo_RPGBox'
        -- }, 

        -- {
        --     Key = "BulletLD",
        --     Cost = 100, 
        --     Description = "40mm榴弹", 
        --     ItemId = 307099, 
        --     Count = 5, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 2,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm'
        -- }, 


        {
            Key = "FireBomb",
            Cost = 50, 
            Description = "燃烧瓶", 
            ItemId = 602003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_FireBomb.Icon_WEP_FireBomb',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Grenade",
            Cost = 100, 
            Description = "碎片手雷", 
            ItemId = 602004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Grenade.Icon_WEP_Grenade',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "Bandage",
            Cost = 20, 
            Description = "绷带", 
            ItemId = 601004, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_Bandage_UG.Icon_Heal_Bandage_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Drink",
            Cost = 20, 
            Description = "能量饮料", 
            ItemId = 601001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Drink_UG.Icon_Boost_Drink_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Helmet_Lv1",
            Cost = 50, 
            Description = "摩托车头盔(1级)", 
            ItemId = 502001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv1_A.Icon_Helmet_Lv1_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Armor_Lv1",
            Cost = 100, 
            Description = "警用防弹衣(1级)", 
            ItemId = 503001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv1.Icon_Armor_Lv1',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bag_Lv1",
            Cost = 200, 
            Description = "背包(1级)", 
            ItemId = 501001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Bag_Lv1.Icon_Bag_Lv1',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        --车尾B级武器

        {
            Key = "Sickle",
            Cost = 200, 
            Description = "镰刀", 
            ItemId = 108003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Sickle.Icon_WEP_Sickle',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Machete",
            Cost = 200, 
            Description = "大砍刀", 
            ItemId = 108001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Machete.Icon_WEP_Machete',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Cowbar",
            Cost = 200, 
            Description = "撬棍", 
            ItemId = 108002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Cowbar.Icon_WEP_Cowbar',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P92",
            Cost = 100, 
            Description = "P92", 
            ItemId = 106001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 4,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P92.Icon_WEP_P92',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P1911",
            Cost = 100, 
            Description = "P1911", 
            ItemId = 106002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 5,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P1911.Icon_WEP_P1911',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P18C",
            Cost = 100, 
            Description = "P18C", 
            ItemId = 106004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 6,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P18C.Icon_WEP_P18C',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

    --车尾B级武器

        {
            Key = "R45",
            Cost = 100, 
            Description = "R45", 
            ItemId = 106005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page，index表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 1,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Rhino.Icon_WEP_Rhino',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bow",
            Cost = 100, 
            Description = "十字弩", 
            ItemId = 107001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 2,
            BulletNeed = "需要弩箭",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Crossbow.Icon_WEP_Crossbow',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "UZI",
            Cost = 250, 
            Description = "UZI", 
            ItemId = 102001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 3,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_UZI.Icon_WEP_UZI',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

       
        {
            Key = "Thompson",
            Cost = 750, 
            Description = "汤姆逊", 
            ItemId = 102004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 4,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Thompson.Icon_WEP_Thompson',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "UMP45",
            Cost = 750, 
            Description = "UMP45", 
            ItemId = 102002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 5,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_UMP45.Icon_WEP_UMP45',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "PP19",
            Cost = 800, 
            Description = "野牛冲锋枪", 
            ItemId = 102005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 6,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PP19.Icon_WEP_PP19',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "VSS",
            Cost = 250, 
            Description = "VSS", 
            ItemId = 103005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 1,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_VSS.Icon_WEP_VSS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        
        {
            Key = "Win1894",
            Cost = 250, 
            Description = "Win1894", 
            ItemId = 103008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 2,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Win1894.Icon_WEP_Win1894',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SawedOff",
            Cost = 500, 
            Description = "短管霰弹枪", 
            ItemId = 106006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 3,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SawedOff.Icon_WEP_SawedOff',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Panzerfaust",
            Cost = 500, 
            Description = "Panzerfaust", 
            ItemId = 107005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 4,
            BulletNeed = "一次性火箭筒",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Panzerfaust.Icon_WEP_Panzerfaust',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "AC-VAL",
            Cost = 750, 
            Description = "AC-VAL", 
            ItemId = 101011, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 5,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_VAL.Icon_WEP_VAL',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Mini14",
            Cost = 800, 
            Description = "Mini14", 
            ItemId = 103006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 6,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Mini14.Icon_WEP_Mini14',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "S1897",
            Cost = 850, 
            Description = "S1897", 
            ItemId = 104002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 4 ,
            Index = 1,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S1897.Icon_WEP_S1897',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "S686",
            Cost = 850, 
            Description = "S686", 
            ItemId = 104001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 4 ,
            Index = 2,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S686.Icon_WEP_S686',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        {
            Key = "Kar98k",
            Cost = 800, 
            Description = "Kar98k", 
            ItemId = 103001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 4 ,
            Index = 3,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Kar98k.Icon_WEP_Kar98k',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Mosin",
            Cost = 850, 
            Description = "莫辛纳甘", 
            ItemId = 103011, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 4 ,
            Index = 4,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_mosin.Icon_WEP_mosin',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 



        --车尾·A级别武器

        {
            Key = "QBZ95",
            Cost = 1400, 
            Description = "QBZ", 
            ItemId = 101007, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 1,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_QBZ95_Small.Icon_WEP_QBZ95_Small',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "G36C",
            Cost = 1400, 
            Description = "G36C", 
            ItemId = 101010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 2,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_G36C.Icon_WEP_G36C',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M16A4",
            Cost = 1500, 
            Description = "M16A4", 
            ItemId = 101002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 3,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M16A4.Icon_WEP_M16A4',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 



        {
            Key = "SCAR",
            Cost = 1700, 
            Description = "SCAR", 
            ItemId = 101003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 4,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SCAR.Icon_WEP_SCAR',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "AK47",
            Cost = 1700, 
            Description = "AK47", 
            ItemId = 101001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 5,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AK47.Icon_WEP_AK47',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MK14",
            Cost = 2000, 
            Description = "MK14", 
            ItemId = 103007, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 6,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK14.Icon_WEP_MK14',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SawM79",
            Cost = 4000, 
            Description = "短管榴弹", 
            ItemId = 107096, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 1,
            BulletNeed = "需要40mm榴弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SawedOffM79.Icon_WEP_SawedOffM79',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "DP28",
            Cost = 2500, 
            Description = "DP28", 
            ItemId = 105002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 2,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DP28.Icon_WEP_DP28',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        {
            Key = "S12K",
            Cost = 2500, 
            Description = "S12K", 
            ItemId = 104003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 3,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S12K.Icon_WEP_S12K',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "RPG",
            Cost = 8800, 
            Description = "RPG", 
            ItemId = 107002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 4,
            BulletNeed = "需要火箭弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_RPG7.Icon_WEP_RPG7',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

--车尾商人S级武器

        {
            Key = "SLR",
            Cost = 3000, 
            Description = "SLR", 
            ItemId = 103009, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SLR.Icon_WEP_SLR',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

       
        {
            Key = "Famas",
            Cost = 3200, 
            Description = "Famas", 
            ItemId = 101013, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 2,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Famas.Icon_WEP_Famas',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M416",
            Cost = 3400, 
            Description = "M416", 
            ItemId = 101004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 3,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M416.Icon_WEP_M416',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M762",
            Cost = 3400, 
            Description = "M762", 
            ItemId = 101008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 4,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M762_Small.Icon_WEP_M762_Small',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        --车尾商店·SSS


        {
            Key = "PKM",
            Cost = 6500, 
            Description = "PKM", 
            ItemId = 105012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PKM.Icon_WEP_PKM',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

       

        --[[
        {
            Key = "AKM", 
            Cost = 1, 
            Description = "AKM", 
            ItemId = 101001,
            Count = 1, 
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AK47.Icon_WEP_AK47' 
        }, 

     
        {
            Key = "M16A4",
            Cost = 10, 
            Description = "M16A4", 
            ItemId = 101002, 
            Count = 1, 
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M16A4.Icon_WEP_M16A4'
        }, 

        --]]


        
    }, 
}


BP_ShopComponent.DataSource1 = 
{
    
    Items = 
    {
        -- BuyHandler = function (self, ItemValue, PlayerController)
        --     -- if PlayerController.PlayerState.Gold >= ItemValue.Cost() then
        --         UGCBackPackSystem.AddItem(PlayerController:GetPlayerCharacterSafety(), ItemValue.ItemId, ItemValue.Count)
        --     -- end
        -- end, 

        --装备消耗品·高级商店

        -- {
        --     Key = "Bullet45", 
        --     Cost = 10, 
        --     Description = "点45子弹", 
        --     ItemId = 305001,
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 1,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_45ACP_UG.Icon_Ammo_45ACP_UG'
        -- },

        -- {
        --     Key = "row", 
        --     Cost = 10, 
        --     Description = "弓箭", 
        --     ItemId = 307001,
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 2,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_bolt_UG.Icon_Ammo_bolt_UG'
        -- },

        -- {
        --     Key = "Bullet9", 
        --     Cost = 10, 
        --     Description = "9mm子弹", 
        --     ItemId = 301001,
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 3,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_9mm_UG.Icon_Ammo_9mm_UG'
        -- },

        -- {
        --     Key = "Bullet12", 
        --     Cost = 100, 
        --     Description = "12霰弹枪子弹", 
        --     ItemId = 304001,
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 4,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_12Guage_UG.Icon_Ammo_12Guage_UG'
        -- },

        -- {
        --     Key = "Bullet556",
        --     Cost = 30, 
        --     Description = "5.56 子弹", 
        --     ItemId = 303001, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 5,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_556mm_UG.Icon_Ammo_556mm_UG'
            
        -- }, 


        -- {
        --     Key = "Bullet762",
        --     Cost = 30, 
        --     Description = "7.62 子弹", 
        --     ItemId = 302001, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 6,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_762mm_UG.Icon_Ammo_762mm_UG'
        -- }, 

        -- {
        --     Key = "BulletRPG",
        --     Cost = 100, 
        --     Description = "火箭弹", 
        --     ItemId = 307002, 
        --     Count = 5, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 1,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_RPGBox.Icon_Ammo_RPGBox'
        -- }, 

        -- {
        --     Key = "BulletLD",
        --     Cost = 100, 
        --     Description = "40mm榴弹", 
        --     ItemId = 307099, 
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 2,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm'
        -- }, 

        -- {
        --     Key = "300Magnum",
        --     Cost = 50, 
        --     Description = "300magnum狙击枪子弹", 
        --     ItemId = 306001, 
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 3,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_300Magnum_UG.Icon_Ammo_300Magnum_UG'
        -- }, 

        {
            Key = "FireBomb",
            Cost = 50, 
            Description = "燃烧瓶", 
            ItemId = 602003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_FireBomb.Icon_WEP_FireBomb',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Grenade",
            Cost = 200, 
            Description = "碎片手雷", 
            ItemId = 602004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Grenade.Icon_WEP_Grenade',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FireGrenade",
            Cost = 5000, 
            Description = "C4炸药", 
            ItemId = 602044, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_Prop_C4.Icon_Prop_C4',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bandage",
            Cost = 10, 
            Description = "绷带", 
            ItemId = 601004, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_Bandage_UG.Icon_Heal_Bandage_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Drink",
            Cost = 20, 
            Description = "能量饮料", 
            ItemId = 601001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Drink_UG.Icon_Boost_Drink_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

    

        -- {
        --     Key = "40mm",
        --     Cost = 50, 
        --     Description = "40mm机枪子弹", 
        --     ItemId = 307009, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 6,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm'
        -- }, 

      

        {
            Key = "FirstAid",
            Cost = 60, 
            Description = "急救包", 
            ItemId = 601005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_FirstAid_UG.Icon_Heal_FirstAid_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Pills",
            Cost = 50, 
            Description = "止痛药", 
            ItemId = 601003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Pills_UG.Icon_Boost_Pills_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Injection",
            Cost = 100, 
            Description = "肾上腺素", 
            ItemId = 601002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Injection_UG.Icon_Boost_Injection_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FirstAidbox",
            Cost = 200, 
            Description = "全能医疗箱", 
            ItemId = 601006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_FirstAidbox_UG.Icon_Heal_FirstAidbox_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Helmet_Lv2",
            Cost = 200, 
            Description = "摩托车头盔(2级)", 
            ItemId = 502002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv2_A.Icon_Helmet_Lv2_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Armor_Lv2",
            Cost = 300, 
            Description = "警用防弹衣(2级)", 
            ItemId = 503002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv2.Icon_Armor_Lv2',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bag_Lv2",
            Cost = 400, 
            Description = "背包(2级)", 
            ItemId = 501005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Bag_Lv2_A.Icon_Bag_Lv2_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

    
        

        --高级商店·B级武器

        {
            Key = "Pan",
            Cost = 100, 
            Description = "平底锅", 
            ItemId = 108004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Pan.Icon_WEP_Pan',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "R1895",
            Cost = 100, 
            Description = "R1895", 
            ItemId = 106003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 2,
            BulletNeed = "7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_R1895.Icon_WEP_R1895',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Skorpion",
            Cost = 200, 
            Description = "蝎式手枪", 
            ItemId = 106008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 3,
            BulletNeed = "9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Skorpion.Icon_WEP_Skorpion',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        
        {
            Key = "AKS74",
            Cost = 600, 
            Description = "AKS74", 
            ItemId = 102008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 4,
            BulletNeed = "5.56mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AKS.Icon_WEP_AKS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MP5",
            Cost = 600, 
            Description = "MP5", 
            ItemId = 102007, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 5,
            BulletNeed = "9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MP5K.Icon_WEP_MP5K',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Vector",
            Cost = 600, 
            Description = "Vector", 
            ItemId = 102003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 6,
            BulletNeed = "9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Vector.Icon_WEP_Vector',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        --高级商店·A级武器

       
        {
            Key = "HoneyBadger",
            Cost = 1500, 
            Description = "蜜獾", 
            ItemId = 101012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_HoneyBadger.Icon_WEP_HoneyBadger',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "QBU",
            Cost = 1500, 
            Description = "QBU", 
            ItemId = 103010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 2,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_QBU.Icon_WEP_QBU',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
       
        {
            Key = "SKS",
            Cost = 1800, 
            Description = "SKS", 
            ItemId = 103004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 3,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SKS.Icon_WEP_SKS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MK47",
            Cost = 1800, 
            Description = "MK47", 
            ItemId = 101009, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 4,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK47.Icon_WEP_MK47',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "SPAS",
            Cost = 2500, 
            Description = "SPAS", 
            ItemId = 104100, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 5,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SPAS.Icon_WEP_SPAS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M417",
            Cost = 2000, 
            Description = "M417", 
            ItemId = 103013, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 6,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M417.Icon_WEP_M417',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

--高级商店·S级武器

        

        {
            Key = "MK12",
            Cost = 3000, 
            Description = "MK12", 
            ItemId = 103100, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 1,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK12.Icon_WEP_MK12',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MK20",
            Cost = 3000, 
            Description = "MK20", 
            ItemId = 103014, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 2,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK20.Icon_WEP_MK20',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "M24",
            Cost = 3000, 
            Description = "M24", 
            ItemId = 103002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 3,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M24.Icon_WEP_M24',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "DPS",
            Cost = 3600, 
            Description = "DBS霰弹枪", 
            ItemId = 104004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 4,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DP12.Icon_WEP_DP12',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "AUG",
            Cost = 3750, 
            Description = "AUG", 
            ItemId = 101006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 5,
            BulletNeed = "需要5.56mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AUG.Icon_WEP_AUG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },
 
        {
            Key = "M249",
            Cost = 5750, 
            Description = "M249", 
            ItemId = 105001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 6,
            BulletNeed = "需要5.56mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M249.Icon_WEP_M249',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },
        
        {
            Key = "AWM",
            Cost = 3200, 
            Description = "AWM", 
            ItemId = 103003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 1,
            BulletNeed = "需要.300Magnum子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AWM.Icon_WEP_AWM',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
 

        {
            Key = "M3E1",
            Cost = 9000, 
            Description = "M3E1导弹", 
            ItemId = 107099, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 2,
            BulletNeed = "需要火箭弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M3E2.Icon_WEP_M3E2',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MGL",
            Cost = 9000, 
            Description = "MGL榴弹", 
            ItemId = 107098, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 3,
            BulletNeed = "需要40mm榴弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MGL140.Icon_WEP_MGL140',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

--高级商店 SSS级武器

        {
            Key = "M134",
            Cost = 7000, 
            Description = "加特林", 
            ItemId = 105003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M134.Icon_WEP_M134',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        -- {
        --     Key = "ElectricGun",
        --     Cost = 8000, 
        --     Description = "电击步枪", 
        --     ItemId = 190010, 
        --     Count = 1, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 5;
        --     Page = 1,
        --     Index = 6,
        --     BulletNeed = "充能电池",
        --     Picture = '/Game/UGC/Weapon/WeaponArt/ElectricGun/Icon/Icon_UGC_ElectricGun.Icon_UGC_ElectricGun'
        -- }, 

        -- {
        --     Key = "Explode",
        --     Cost = 12000, 
        --     Description = "爆破投射器", 
        --     ItemId = 190008, 
        --     Count = 1, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 5;
        --     Page = 2,
        --     Index = 1,
        --     BulletNeed = "需要RPG子弹",
        --     Picture = '/Game/UGC/Weapon/WeaponArt/MGL/Icon/Icon_UGC_MGL.Icon_UGC_MGL'
        -- }, 
        
      
    }, 
}


BP_ShopComponent.DataSource2 = 
{
    
    Items = 
    {
        -- BuyHandler = function (self, ItemValue, PlayerController)
        --     -- if PlayerController.PlayerState.Gold >= ItemValue.Cost() then
        --         UGCBackPackSystem.AddItem(PlayerController:GetPlayerCharacterSafety(), ItemValue.ItemId, ItemValue.Count)
        --     -- end
        -- end, 

        --装备消耗品·隐藏商店

    

        -- {
        --     Key = "row", 
        --     Cost = 10, 
        --     Description = "弓箭", 
        --     ItemId = 307001,
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 1,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_bolt_UG.Icon_Ammo_bolt_UG'
        -- },

        -- {
        --     Key = "Bullet9", 
        --     Cost = 10, 
        --     Description = "9mm子弹", 
        --     ItemId = 301001,
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 2,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_9mm_UG.Icon_Ammo_9mm_UG'
        -- },

        -- {
        --     Key = "Bullet12", 
        --     Cost = 100, 
        --     Description = "12霰弹枪子弹", 
        --     ItemId = 304001,
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 3,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_12Guage_UG.Icon_Ammo_12Guage_UG'
        -- },

        -- {
        --     Key = "Bullet556",
        --     Cost = 30, 
        --     Description = "5.56 子弹", 
        --     ItemId = 303001, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 4,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_556mm_UG.Icon_Ammo_556mm_UG'
            
        -- }, 


        -- {
        --     Key = "Bullet762",
        --     Cost = 30, 
        --     Description = "7.62 子弹", 
        --     ItemId = 302001, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 5,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_762mm_UG.Icon_Ammo_762mm_UG'
        -- }, 

        -- {
        --     Key = "BulletRPG",
        --     Cost = 100, 
        --     Description = "火箭弹", 
        --     ItemId = 307002, 
        --     Count = 5, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 1,
        --     Index = 6,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_RPGBox.Icon_Ammo_RPGBox'
        -- }, 


        -- {
        --     Key = "BulletLD",
        --     Cost = 100, 
        --     Description = "40mm榴弹", 
        --     ItemId = 307099, 
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 1,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm'
        -- }, 

        
        -- {
        --     Key = "300Magnum",
        --     Cost = 50, 
        --     Description = "300magnum子弹", 
        --     ItemId = 306001, 
        --     Count = 10, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 2,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_300Magnum_UG.Icon_Ammo_300Magnum_UG'
        -- }, 
        -- {
        --     Key = "50BMG",
        --     Cost = 100, 
        --     Description = "点50mm子弹", 
        --     ItemId = 306002, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 3,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_50BMG_UG.Icon_Ammo_50BMG_UG'
        -- },

        -- {
        --     Key = "5.7mm",
        --     Cost = 100, 
        --     Description = "5.7mm子弹", 
        --     ItemId = 301002, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 4,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_557mm_UG.Icon_Ammo_557mm_UG'
        -- },

        -- {
        --     Key = "0408",
        --     Cost = 100, 
        --     Description = ".408口径子弹", 
        --     ItemId = 306003, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 5,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_408_Pickup.Icon_Ammo_408_Pickup'
        -- }, 

        -- {
        --     Key = "ChargeElectric",
        --     Cost = 200, 
        --     Description = "能量弹药", 
        --     ItemId = 307100, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 6,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_50BMG_UG.Icon_Ammo_50BMG_UG'
        -- }, 

        {
            Key = "FireBomb",
            Cost = 50, 
            Description = "燃烧瓶", 
            ItemId = 602003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_FireBomb.Icon_WEP_FireBomb',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FireGrenade",
            Cost = 5000, 
            Description = "C4炸药", 
            ItemId = 602044, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_Prop_C4.Icon_Prop_C4',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Grenade",
            Cost = 200, 
            Description = "碎片手雷", 
            ItemId = 602004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Grenade.Icon_WEP_Grenade',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "Bandage",
            Cost = 20, 
            Description = "绷带", 
            ItemId = 601004, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_Bandage_UG.Icon_Heal_Bandage_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Drink",
            Cost = 20, 
            Description = "能量饮料", 
            ItemId = 601001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Drink_UG.Icon_Boost_Drink_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        -- {
        --     Key = "40mm",
        --     Cost = 50, 
        --     Description = "40mm机枪子弹", 
        --     ItemId = 307009, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 2,
        --     Index = 6,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm'
        -- }, 


        {
            Key = "FirstAid",
            Cost = 60, 
            Description = "急救包", 
            ItemId = 601005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_FirstAid_UG.Icon_Heal_FirstAid_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Pills",
            Cost = 50, 
            Description = "止痛药", 
            ItemId = 601003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Pills_UG.Icon_Boost_Pills_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Injection",
            Cost = 100, 
            Description = "肾上腺素", 
            ItemId = 601002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Injection_UG.Icon_Boost_Injection_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FirstAidbox",
            Cost = 200, 
            Description = "全能医疗箱", 
            ItemId = 601006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_FirstAidbox_UG.Icon_Heal_FirstAidbox_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        

      --  {
      --      Key = "SpecialBullet",
      --      Cost = 100, 
      --      Description = "激光弹药", 
      --      ItemId = 307101, 
      --      Count = 30, 
      --      --Belong为类别,Page为页数，Page表示框的位置，
      --      Belong = 1;
      --      Page = 3,
      --      Index = 6,
      --      BulletNeed = "",
      --      Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_300Magnum_UG.Icon_Ammo_300Magnum_UG'
      --  }, 

        {
            Key = "Helmet_Lv3",
            Cost = 500, 
            Description = "特种部队头盔(3级)", 
            ItemId = 502003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv3.Icon_Helmet_Lv3',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Armor_Lv3",
            Cost = 1500, 
            Description = "3级防弹衣", 
            ItemId = 503003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv3.Icon_Armor_Lv3',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bag_Lv3",
            Cost = 2000, 
            Description = "背包(3级)", 
            ItemId = 501003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Bag_Lv3_A.Icon_Bag_Lv3_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

     


        --隐藏商店B级别武器

  
         

        {
            Key = "FlashShield",
            Cost = 200, 
            Description = "突击盾牌", 
            ItemId = 107010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_FlashShield.Icon_WEP_FlashShield',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "DesertEagle",
            Cost = 200, 
            Description = "沙漠之鹰", 
            ItemId = 106010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 2,
            BulletNeed = "点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DesertEagle_C.Icon_WEP_DesertEagle_C',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        --隐藏商店 A级武器

        {
            Key = "FireBow",
            Cost = 2500, 
            Description = "燃点复合弓", 
            ItemId = 107008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 1,
            BulletNeed = "箭矢",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_CompoundBow.Icon_WEP_CompoundBow',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

           --隐藏商店 S级武器

        {
            Key = "P90",
            Cost = 3000, 
            Description = "P90", 
            ItemId = 102105, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 1,
            BulletNeed = "5.7mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P90_Set.Icon_WEP_P90_Set',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

  
        {
            Key = "GROZA",
            Cost = 3750, 
            Description = "GROZA", 
            ItemId = 101005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 2,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_GROZA.Icon_WEP_GROZA',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

    
        --隐藏商店 SSS级武器
       
        {
            Key = "PKM",
            Cost = 6500, 
            Description = "PKM", 
            ItemId = 105012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PKM.Icon_WEP_PKM',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M134",
            Cost = 7000, 
            Description = "加特林", 
            ItemId = 105003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 2,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M134.Icon_WEP_M134',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MG3",
            Cost = 7250, 
            Description = "MG3", 
            ItemId = 105010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 3,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MG3.Icon_WEP_MG3',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        
        {
            Key = "AA12",
            Cost = 7500, 
            Description = "AA12", 
            ItemId = 104005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 4,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AA12.Icon_WEP_AA12',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        
        

        {
            Key = "AMR",
            Cost = 5500, 
            Description = "AMR", 
            ItemId = 103012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 5,
            BulletNeed = "需要点50子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AMR.Icon_WEP_AMR',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "M200",
            Cost = 5500, 
            Description = "M200", 
            ItemId = 103015, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 6,
            BulletNeed = "需要.408子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M200.Icon_WEP_M200',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


       



        --隐藏重武器
        

        

        -- {
        --    Key = "M202",
        --    Cost = 8000, 
        --    Description = "M202", 
       --     ItemId = 107095, 
         --  Count = 1, 
           --Belong为类别,Page为页数，Page表示框的位置，
        --    Belong = 5;
        --    Page = 1,
         --   Index = 4,
         --   BulletNeed = "需要火箭弹",
         --   Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M202.Icon_WEP_M202'
        -- }, 

      --  {
      --      Key = "LaserGun",
      --      Cost = 10000, 
      --      Description = " 蓄能激光枪", 
       --     ItemId = 190009, 
       --     Count = 1, 
      --     --Belong为类别,Page为页数，Page表示框的位置，
      --      Belong = 5;
      --      Page = 1,
       --     Index = 5,
       --     BulletNeed = "需要能量弹药",
       --     Picture = '/Game/UGC/Weapon/WeaponArt/RPG/Icon/Icon_UGC_RPG.Icon_UGC_RPG'
      --  }, 
       
      
    }, 
}

BP_ShopComponent.DataSource3= 
{
    Items = 
    {
        -- BuyHandler = function (self, ItemValue, PlayerController)
        --     -- if PlayerController.PlayerState.Gold >= ItemValue.Cost() then
        --         UGCBackPackSystem.AddItem(PlayerController:GetPlayerCharacterSafety(), ItemValue.ItemId, ItemValue.Count)
        --     -- end
        -- end, 

    

    --1枪口

    {
        Key = "Chock", 
        Cost = 300, 
        Description = "霰弹枪收束器", 
        ItemId = 201001,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 1,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Choke.Icon_QK_Choke',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DuckBill", 
        Cost = 300, 
        Description = "鸭嘴枪口(霰弹枪)", 
        ItemId = 201012,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 1,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_DuckBill.Icon_QK_DuckBill',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Small_Suppressor", 
        Cost = 50, 
        Description = "消音器(手枪)", 
        ItemId = 201008,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 1,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Small_Suppressor.Icon_QK_Small_Suppressor',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Mid_Suppressor", 
        Cost = 50, 
        Description = "消音器(冲锋枪,手枪)", 
        ItemId = 201006,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 1,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Mid_Suppressor.Icon_QK_Mid_Suppressor',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Mid_Compensator", 
        Cost = 100, 
        Description = "枪口补偿器(冲锋枪)", 
        ItemId = 201002,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 1,
        Index = 5,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Mid_Compensator.Icon_QK_Mid_Compensator',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Mid_FlashHider", 
        Cost = 100, 
        Description = "消焰器(冲锋枪)", 
        ItemId = 201004,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 1,
        Index = 6,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Mid_FlashHider.Icon_QK_Mid_FlashHider',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Small_ExtendedBarrel", 
        Cost = 100, 
        Description = "延长枪管(冲锋枪)", 
        ItemId = 201050,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 2,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Small_ExtendedBarrel.Icon_QK_Small_ExtendedBarrel',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Large_FlashHider", 
        Cost = 150, 
        Description = "消焰器(步枪)", 
        ItemId = 201010,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 2,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Large_FlashHider.Icon_QK_Large_FlashHider',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Large_Suppressor", 
        Cost = 150, 
        Description = "消音器(步枪)", 
        ItemId = 201011,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 2,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Large_Suppressor.Icon_QK_Large_Suppressor',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Large_ExtendedBarrel", 
        Cost = 150, 
        Description = "延长枪管(步枪,狙击枪)", 
        ItemId = 201051,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 2,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Large_ExtendedBarrel.Icon_QK_Large_ExtendedBarrel',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Sniper_Compensator", 
        Cost = 150, 
        Description = "枪口补偿器(狙击枪)", 
        ItemId = 201003,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 2,
        Index = 5,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Sniper_Compensator.Icon_QK_Sniper_Compensator',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Sniper_FlashHider", 
        Cost = 200, 
        Description = "消焰器(狙击枪)", 
        ItemId = 201005,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 2,
        Index = 6,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Sniper_FlashHider.Icon_QK_Sniper_FlashHider',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "Sniper_Suppressor", 
        Cost = 200, 
        Description = "消音器(狙击枪)", 
        ItemId = 201007,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 1;
        Page = 3,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Sniper_Suppressor.Icon_QK_Sniper_Suppressor',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },



    --2握把

    {
        Key = "WB_Angled", 
        Cost = 150, 
        Description = "直角前握把", 
        ItemId = 202001,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 2;
        Page = 1,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_Angled.Icon_WB_Angled',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "WB_Vertical", 
        Cost = 200, 
        Description = "垂直握把", 
        ItemId = 202002,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 2;
        Page = 1,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_Vertical.Icon_WB_Vertical',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "WB_ThumbGrip", 
        Cost = 150, 
        Description = "拇指握把", 
        ItemId = 202006,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 2;
        Page = 1,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_ThumbGrip.Icon_WB_ThumbGrip',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "WB_LightGrip", 
        Cost = 150, 
        Description = "轻型握把", 
        ItemId = 202004,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 2;
        Page = 1,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_LightGrip.Icon_WB_LightGrip',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "WB_HalfGrip", 
        Cost = 150, 
        Description = "半截式握把", 
        ItemId = 202005,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 2;
        Page = 1,
        Index = 5,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_HalfGrip.Icon_WB_HalfGrip',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    --3弹夹


    {
        Key = "DJ_Small_E", 
        Cost = 50, 
        Description = "扩容弹匣(手枪)", 
        ItemId = 204001,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 1,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Small_E.Icon_DJ_Small_E',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Small_Q", 
        Cost = 50, 
        Description = "快速弹匣(手枪)", 
        ItemId = 204002,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 1,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Small_Q.Icon_DJ_Small_Q',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Small_EQ", 
        Cost = 100, 
        Description = "快速扩容弹匣(手枪)", 
        ItemId = 204003,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 1,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Small_EQ.Icon_DJ_Small_EQ',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Mid_E", 
        Cost = 100, 
        Description = "扩容弹匣(冲锋枪,手枪)", 
        ItemId = 204004,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 1,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Mid_E.Icon_DJ_Mid_E',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Mid_Q", 
        Cost = 100, 
        Description = "快速弹匣(冲锋枪,手枪)", 
        ItemId = 204005,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 1,
        Index = 5,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Mid_Q.Icon_DJ_Mid_Q',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Mid_EQ", 
        Cost = 200, 
        Description = "快速扩容弹匣(冲锋枪,手枪)", 
        ItemId = 204006,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 1,
        Index = 6,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Mid_EQ.Icon_DJ_Mid_EQ',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "ZDD_Sniper", 
        Cost = 300, 
        Description = "子弹袋(狙击枪,霰弹枪)", 
        ItemId = 204014,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 2,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_ZDD_Sniper.Icon_ZDD_Sniper',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Large_E", 
        Cost = 150, 
        Description = "扩容弹匣(步枪,机枪)", 
        ItemId = 204011,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 2,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_E.Icon_DJ_Large_E',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Large_Q", 
        Cost = 150, 
        Description = "快速弹匣(步枪,机枪)", 
        ItemId = 204012,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 2,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_Q.Icon_DJ_Large_Q',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Large_EQ", 
        Cost = 300, 
        Description = "快速扩容弹匣(步枪,机枪)", 
        ItemId = 204013,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 2,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_EQ.Icon_DJ_Large_EQ',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Large_Dou", 
        Cost = 200, 
        Description = "并联弹匣(步枪)", 
        ItemId = 204016,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 2,
        Index = 5,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_Dou.Icon_DJ_Large_Dou',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Sniper_E", 
        Cost = 100, 
        Description = "扩容弹匣(狙击枪)", 
        ItemId = 204007,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 2,
        Index = 6,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Sniper_E.Icon_DJ_Sniper_E',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Sniper_Q", 
        Cost = 100, 
        Description = "快速弹匣(狙击枪)", 
        ItemId = 204008,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 3,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Sniper_Q.Icon_DJ_Sniper_Q',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "DJ_Sniper_EQ", 
        Cost = 200, 
        Description = "快速扩容弹匣(狙击枪)", 
        ItemId = 204009,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 3,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Sniper_EQ.Icon_DJ_Sniper_EQ',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "QT_A", 
        Cost = 200, 
        Description = "战术枪托(步枪,冲锋枪,机枪)", 
        ItemId = 205002,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 3,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QT_A.Icon_QT_A',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "QT_Sniper", 
        Cost = 150, 
        Description = "战术枪托(步枪,冲锋枪,机枪)", 
        ItemId = 205003,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 3;
        Page = 3,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QT_Sniper.Icon_QT_Sniper',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    --4瞄准镜

    {
        Key = "attach_Lower_LaserPointer", 
        Cost = 300, 
        Description = "激光瞄准器", 
        ItemId = 202007,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 4;
        Page = 1,
        Index = 1,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/icon_attach_Lower_LaserPointer.icon_attach_Lower_LaserPointer',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "MZJ_HD", 
        Cost = 50, 
        Description = "红点瞄准镜", 
        ItemId = 203001,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 4;
        Page = 1,
        Index = 2,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_HD.Icon_MZJ_HD',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "MZJ_QX", 
        Cost = 50, 
        Description = "全息瞄准镜", 
        ItemId = 203002,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 4;
        Page = 1,
        Index = 3,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_QX.Icon_MZJ_QX',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "MZJ_2X", 
        Cost = 100, 
        Description = "2倍瞄准镜", 
        ItemId = 203003,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 4;
        Page = 1,
        Index = 4,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_2X.Icon_MZJ_2X',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    },

    {
        Key = "MZJ_4X", 
        Cost = 800, 
        Description = "4倍瞄准镜", 
        ItemId = 203004,
        Count = 1, 
        --Belong为类别,Page为页数，Page表示框的位置，
        Belong = 4;
        Page = 1,
        Index = 5,
        BulletNeed = "",
        Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_4X.Icon_MZJ_4X',
        PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
    }

    },

}

BP_ShopComponent.DataSource4 = 
{
    
    Items = 
    {
        -- BuyHandler = function (self, ItemValue, PlayerController)
        --     -- if PlayerController.PlayerState.Gold >= ItemValue.Cost() then
        --         UGCBackPackSystem.AddItem(PlayerController:GetPlayerCharacterSafety(), ItemValue.ItemId, ItemValue.Count)
        --     -- end
        -- end, 





        --装备消耗品

            --1枪口

        {
            Key = "Chock", 
            Cost = 300, 
            Description = "霰弹枪收束器", 
            ItemId = 201001,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Choke.Icon_QK_Choke',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DuckBill", 
            Cost = 300, 
            Description = "鸭嘴枪口(霰弹枪)", 
            ItemId = 201012,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_DuckBill.Icon_QK_DuckBill',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Small_Suppressor", 
            Cost = 50, 
            Description = "消音器(手枪)", 
            ItemId = 201008,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Small_Suppressor.Icon_QK_Small_Suppressor',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Mid_Suppressor", 
            Cost = 50, 
            Description = "消音器(冲锋枪,手枪)", 
            ItemId = 201006,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Mid_Suppressor.Icon_QK_Mid_Suppressor',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Mid_Compensator", 
            Cost = 100, 
            Description = "枪口补偿器(冲锋枪)", 
            ItemId = 201002,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Mid_Compensator.Icon_QK_Mid_Compensator',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Mid_FlashHider", 
            Cost = 100, 
            Description = "消焰器(冲锋枪)", 
            ItemId = 201004,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Mid_FlashHider.Icon_QK_Mid_FlashHider',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Small_ExtendedBarrel", 
            Cost = 100, 
            Description = "延长枪管(冲锋枪)", 
            ItemId = 201050,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Small_ExtendedBarrel.Icon_QK_Small_ExtendedBarrel',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Large_FlashHider", 
            Cost = 150, 
            Description = "消焰器(步枪)", 
            ItemId = 201010,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Large_FlashHider.Icon_QK_Large_FlashHider',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Large_Suppressor", 
            Cost = 150, 
            Description = "消音器(步枪)", 
            ItemId = 201011,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Large_Suppressor.Icon_QK_Large_Suppressor',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Large_ExtendedBarrel", 
            Cost = 150, 
            Description = "延长枪管(步枪,狙击枪)", 
            ItemId = 201051,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Large_ExtendedBarrel.Icon_QK_Large_ExtendedBarrel',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Sniper_Compensator", 
            Cost = 150, 
            Description = "枪口补偿器(狙击枪)", 
            ItemId = 201003,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Sniper_Compensator.Icon_QK_Sniper_Compensator',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Sniper_FlashHider", 
            Cost = 200, 
            Description = "消焰器(狙击枪)", 
            ItemId = 201005,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Sniper_FlashHider.Icon_QK_Sniper_FlashHider',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Sniper_Suppressor", 
            Cost = 200, 
            Description = "消音器(狙击枪)", 
            ItemId = 201007,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 3,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QK_Sniper_Suppressor.Icon_QK_Sniper_Suppressor',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },



        --2握把

        {
            Key = "WB_Angled", 
            Cost = 150, 
            Description = "直角前握把", 
            ItemId = 202001,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_Angled.Icon_WB_Angled',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "WB_Vertical", 
            Cost = 200, 
            Description = "垂直握把", 
            ItemId = 202002,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_Vertical.Icon_WB_Vertical',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "WB_ThumbGrip", 
            Cost = 150, 
            Description = "拇指握把", 
            ItemId = 202006,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_ThumbGrip.Icon_WB_ThumbGrip',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "WB_LightGrip", 
            Cost = 150, 
            Description = "轻型握把", 
            ItemId = 202004,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_LightGrip.Icon_WB_LightGrip',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "WB_HalfGrip", 
            Cost = 150, 
            Description = "半截式握把", 
            ItemId = 202005,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_WB_HalfGrip.Icon_WB_HalfGrip',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        --3弹夹


        {
            Key = "DJ_Small_E", 
            Cost = 50, 
            Description = "扩容弹匣(手枪)", 
            ItemId = 204001,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Small_E.Icon_DJ_Small_E',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Small_Q", 
            Cost = 50, 
            Description = "快速弹匣(手枪)", 
            ItemId = 204002,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Small_Q.Icon_DJ_Small_Q',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Small_EQ", 
            Cost = 100, 
            Description = "快速扩容弹匣(手枪)", 
            ItemId = 204003,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Small_EQ.Icon_DJ_Small_EQ',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Mid_E", 
            Cost = 100, 
            Description = "扩容弹匣(冲锋枪,手枪)", 
            ItemId = 204004,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Mid_E.Icon_DJ_Mid_E',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Mid_Q", 
            Cost = 100, 
            Description = "快速弹匣(冲锋枪,手枪)", 
            ItemId = 204005,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Mid_Q.Icon_DJ_Mid_Q',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Mid_EQ", 
            Cost = 200, 
            Description = "快速扩容弹匣(冲锋枪,手枪)", 
            ItemId = 204006,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Mid_EQ.Icon_DJ_Mid_EQ',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "ZDD_Sniper", 
            Cost = 300, 
            Description = "子弹袋(狙击枪,霰弹枪)", 
            ItemId = 204014,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_ZDD_Sniper.Icon_ZDD_Sniper',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Large_E", 
            Cost = 150, 
            Description = "扩容弹匣(步枪,机枪)", 
            ItemId = 204011,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_E.Icon_DJ_Large_E',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Large_Q", 
            Cost = 150, 
            Description = "快速弹匣(步枪,机枪)", 
            ItemId = 204012,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_Q.Icon_DJ_Large_Q',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Large_EQ", 
            Cost = 300, 
            Description = "快速扩容弹匣(步枪,机枪)", 
            ItemId = 204013,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_EQ.Icon_DJ_Large_EQ',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Large_Dou", 
            Cost = 200, 
            Description = "并联弹匣(步枪)", 
            ItemId = 204016,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Large_Dou.Icon_DJ_Large_Dou',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Sniper_E", 
            Cost = 100, 
            Description = "扩容弹匣(狙击枪)", 
            ItemId = 204007,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Sniper_E.Icon_DJ_Sniper_E',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Sniper_Q", 
            Cost = 100, 
            Description = "快速弹匣(狙击枪)", 
            ItemId = 204008,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 3,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Sniper_Q.Icon_DJ_Sniper_Q',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "DJ_Sniper_EQ", 
            Cost = 200, 
            Description = "快速扩容弹匣(狙击枪)", 
            ItemId = 204009,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 3,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_DJ_Sniper_EQ.Icon_DJ_Sniper_EQ',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "QT_A", 
            Cost = 200, 
            Description = "战术枪托(步枪,冲锋枪,机枪)", 
            ItemId = 205002,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 3,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QT_A.Icon_QT_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "QT_Sniper", 
            Cost = 150, 
            Description = "战术枪托(步枪,冲锋枪,机枪)", 
            ItemId = 205003,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 3,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_QT_Sniper.Icon_QT_Sniper',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        --4瞄准镜

        {
            Key = "attach_Lower_LaserPointer", 
            Cost = 300, 
            Description = "激光瞄准器", 
            ItemId = 202007,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/icon_attach_Lower_LaserPointer.icon_attach_Lower_LaserPointer',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "MZJ_HD", 
            Cost = 50, 
            Description = "红点瞄准镜", 
            ItemId = 203001,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_HD.Icon_MZJ_HD',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "MZJ_QX", 
            Cost = 50, 
            Description = "全息瞄准镜", 
            ItemId = 203002,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_QX.Icon_MZJ_QX',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "MZJ_2X", 
            Cost = 100, 
            Description = "2倍瞄准镜", 
            ItemId = 203003,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_2X.Icon_MZJ_2X',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "MZJ_4X", 
            Cost = 800, 
            Description = "4倍瞄准镜", 
            ItemId = 203004,
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Attach/Icon_MZJ_4X.Icon_MZJ_4X',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },


        {
            Key = "Bullet45", 
            Cost = 10, 
            Description = "点45子弹", 
            ItemId = 305001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置， 物品库
            Belong = 1;
            Page = 1,
            Index = 1,
            BulletNeed = "45",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_45ACP_UG.Icon_Ammo_45ACP_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "row", 
            Cost = 10, 
            Description = "弓箭", 
            ItemId = 307001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_bolt_UG.Icon_Ammo_bolt_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Bullet9", 
            Cost = 10, 
            Description = "9mm子弹", 
            ItemId = 301001,
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_9mm_UG.Icon_Ammo_9mm_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Bullet12", 
            Cost = 100, 
            Description = "12霰弹枪子弹", 
            ItemId = 304001,
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_12Guage_UG.Icon_Ammo_12Guage_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Bullet556",
            Cost = 30, 
            Description = "5.56 子弹", 
            ItemId = 303001, 
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_556mm_UG.Icon_Ammo_556mm_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
            
        }, 


        {
            Key = "Bullet762",
            Cost = 30, 
            Description = "7.62 子弹", 
            ItemId = 302001, 
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 1,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_762mm_UG.Icon_Ammo_762mm_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "BulletRPG",
            Cost = 100, 
            Description = "RPG子弹", 
            ItemId = 307002, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_RPGBox.Icon_Ammo_RPGBox',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "BulletLD",
            Cost = 100, 
            Description = "40mm榴弹", 
            ItemId = 307099, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FireBomb",
            Cost = 50, 
            Description = "燃烧瓶", 
            ItemId = 602003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_FireBomb.Icon_WEP_FireBomb',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FireGrenade",
            Cost = 5000, 
            Description = "C4炸药", 
            ItemId = 602044, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_Prop_C4.Icon_Prop_C4',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Grenade",
            Cost = 200, 
            Description = "碎片手雷", 
            ItemId = 602004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Grenade.Icon_WEP_Grenade',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        {
            Key = "Bandage",
            Cost = 10, 
            Description = "绷带", 
            ItemId = 601004, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_Bandage_UG.Icon_Heal_Bandage_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Drink",
            Cost = 20, 
            Description = "能量饮料", 
            ItemId = 601001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Drink_UG.Icon_Boost_Drink_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Helmet_Lv1",
            Cost = 50, 
            Description = "摩托车头盔(1级)", 
            ItemId = 502001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv1_A.Icon_Helmet_Lv1_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Armor_Lv1",
            Cost = 100, 
            Description = "警用防弹衣(1级)", 
            ItemId = 503001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 3,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv1.Icon_Armor_Lv1',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bag_Lv1",
            Cost = 200, 
            Description = "背包(1级)", 
            ItemId = 501001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 3,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Bag_Lv1.Icon_Bag_Lv1',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        -- {
        --     Key = "40mm",
        --     Cost = 50, 
        --     Description = "40mm机枪子弹", 
        --     ItemId = 307009, 
        --     Count = 30, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 1;
        --     Page = 3,
        --     Index = 3,
        --     BulletNeed = "",
        --     Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_40mm.Icon_Ammo_40mm'
        -- }, 

        {
            Key = "300Magnum",
            Cost = 50, 
            Description = "300magnum子弹", 
            ItemId = 306001, 
            Count = 10, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 3,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_300Magnum_UG.Icon_Ammo_300Magnum_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FirstAid",
            Cost = 60, 
            Description = "急救包", 
            ItemId = 601005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 3,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_FirstAid_UG.Icon_Heal_FirstAid_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Pills",
            Cost = 50, 
            Description = "止痛药", 
            ItemId = 601003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 3,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Pills_UG.Icon_Boost_Pills_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Injection",
            Cost = 100, 
            Description = "肾上腺素", 
            ItemId = 601002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 4,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Boost_Injection_UG.Icon_Boost_Injection_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FirstAidbox",
            Cost = 200, 
            Description = "全能医疗箱", 
            ItemId = 601006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 4,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Health/Icon_Heal_FirstAidbox_UG.Icon_Heal_FirstAidbox_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "Helmet_Lv2",
            Cost = 200, 
            Description = "摩托车头盔(2级)", 
            ItemId = 502002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 4,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv2_A.Icon_Helmet_Lv2_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Armor_Lv2",
            Cost = 300, 
            Description = "警用防弹衣(2级)", 
            ItemId = 503002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 4,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv2.Icon_Armor_Lv2',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bag_Lv2",
            Cost = 400, 
            Description = "背包(2级)", 
            ItemId = 501005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 4,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Bag_Lv2_A.Icon_Bag_Lv2_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

      --  {
       --     Key = "SpecialBullet",
       --     Cost = 100, 
      --      Description = "激光弹药", 
      --      ItemId = 307101, 
      --      Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
       --     Belong = 1;
       --     Page = 4,
      --      Index = 6,
       --     BulletNeed = "",
      --      Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_300Magnum_UG.Icon_Ammo_300Magnum_UG'
     --   }, 

        {
            Key = "Helmet_Lv3",
            Cost = 500, 
            Description = "特种部队头盔(3级)", 
            ItemId = 502003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 5,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Helmet_Lv3.Icon_Helmet_Lv3',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Armor_Lv3",
            Cost = 1500, 
            Description = "3级防弹衣", 
            ItemId = 503003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 5,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Armor_Lv3.Icon_Armor_Lv3',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bag_Lv3",
            Cost = 2000, 
            Description = "背包(3级)", 
            ItemId = 501003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 5,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Equipment/Icon_Bag_Lv3_A.Icon_Bag_Lv3_A',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "50BMG",
            Cost = 100, 
            Description = "点50mm子弹", 
            ItemId = 306002, 
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 5,
            Index = 4,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_50BMG_UG.Icon_Ammo_50BMG_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "5.7mm",
            Cost = 100, 
            Description = "5.7mm子弹", 
            ItemId = 301002, 
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 5,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_557mm_UG.Icon_Ammo_557mm_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "ChargeElectric",
            Cost = 200, 
            Description = "能量弹药", 
            ItemId = 307100, 
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 5,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_50BMG_UG.Icon_Ammo_50BMG_UG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "LaserGun",
            Cost = 10000, 
            Description = "蓄能步枪", 
            ItemId = 190009, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 1,
            BulletNeed = "需要能量弹药",
            Picture = '/Game/UGC/Weapon/WeaponArt/LaserGun/Icon/Icon_UGC_RPG.Icon_UGC_RPG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 


        --手枪冲锋枪

        {
            Key = "Sickle",
            Cost = 200, 
            Description = "镰刀", 
            ItemId = 108003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 1,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Sickle.Icon_WEP_Sickle',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Machete",
            Cost = 200, 
            Description = "大砍刀", 
            ItemId = 108001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 2,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Machete.Icon_WEP_Machete',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Cowbar",
            Cost = 200, 
            Description = "撬棍", 
            ItemId = 108002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 3,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Cowbar.Icon_WEP_Cowbar',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P92",
            Cost = 100, 
            Description = "P92", 
            ItemId = 106001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 4,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P92.Icon_WEP_P92',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P1911",
            Cost = 100, 
            Description = "P1911", 
            ItemId = 106002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 5,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P1911.Icon_WEP_P1911',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P18C",
            Cost = 100, 
            Description = "P18C", 
            ItemId = 106004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 6,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P18C.Icon_WEP_P18C',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "R45",
            Cost = 100, 
            Description = "R45", 
            ItemId = 106005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 1,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Rhino.Icon_WEP_Rhino',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Bow",
            Cost = 200, 
            Description = "十字弩", 
            ItemId = 107001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 2,
            BulletNeed = "需要弩箭",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Crossbow.Icon_WEP_Crossbow',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "UMP45",
            Cost = 750, 
            Description = "UMP45", 
            ItemId = 102002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 3,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_UMP45.Icon_WEP_UMP45',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "UZI",
            Cost = 250, 
            Description = "UZI", 
            ItemId = 102001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 4,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_UZI.Icon_WEP_UZI',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Thompson",
            Cost = 750, 
            Description = "汤姆逊", 
            ItemId = 102004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 5,
            BulletNeed = "需要点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Thompson.Icon_WEP_Thompson',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "PP19",
            Cost = 800, 
            Description = "野牛冲锋枪", 
            ItemId = 102005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 6,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PP19.Icon_WEP_PP19',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Pan",
            Cost = 100, 
            Description = "平底锅", 
            ItemId = 108004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 2,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Pan.Icon_WEP_Pan',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "R1895",
            Cost = 100, 
            Description = "R1895", 
            ItemId = 106003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 1,
            BulletNeed = "7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_R1895.Icon_WEP_R1895',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Skorpion",
            Cost = 200, 
            Description = "蝎式手枪", 
            ItemId = 106008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 2,
            BulletNeed = "9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Skorpion.Icon_WEP_Skorpion',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "AKS74",
            Cost = 600, 
            Description = "AKS74", 
            ItemId = 102008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 3,
            BulletNeed = "5.56mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AKS.Icon_WEP_AKS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MP5",
            Cost = 600, 
            Description = "MP5", 
            ItemId = 102007, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 4,
            BulletNeed = "9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MP5K.Icon_WEP_MP5K',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Vector",
            Cost = 600, 
            Description = "Vector", 
            ItemId = 102003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 5,
            BulletNeed = "9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Vector.Icon_WEP_Vector',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FlashShield",
            Cost = 200, 
            Description = "突击盾牌", 
            ItemId = 107010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 3,
            Index = 6,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_FlashShield.Icon_WEP_FlashShield',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "DesertEagle",
            Cost = 200, 
            Description = "沙漠之鹰", 
            ItemId = 106010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 4,
            Index = 1,
            BulletNeed = "点45子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DesertEagle_C.Icon_WEP_DesertEagle_C',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "P90",
            Cost = 3000, 
            Description = "P90", 
            ItemId = 102105, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 4,
            Index = 2,
            BulletNeed = "5.7mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_P90_Set.Icon_WEP_P90_Set',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "FireBow",
            Cost = 2500, 
            Description = "燃点复合弓", 
            ItemId = 107008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 2;
            Page = 1,
            Index = 3,
            BulletNeed = "箭矢",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_CompoundBow.Icon_WEP_CompoundBow',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        


        





        --步枪

        {
            Key = "QBZ95",
            Cost = 1400, 
            Description = "QBZ", 
            ItemId = 101007, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 1,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_QBZ95_Small.Icon_WEP_QBZ95_Small',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "G36C",
            Cost = 1400, 
            Description = "G36C", 
            ItemId = 101010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 2,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_G36C.Icon_WEP_G36C',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M16A4",
            Cost = 1500, 
            Description = "M16A4", 
            ItemId = 101002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 2,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M16A4.Icon_WEP_M16A4',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
 
        {
            Key = "Famas",
            Cost = 3200, 
            Description = "Famas", 
            ItemId = 101013, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 3,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Famas.Icon_WEP_Famas',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SCAR",
            Cost = 1700, 
            Description = "SCAR", 
            ItemId = 101003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 5,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SCAR.Icon_WEP_SCAR',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M416",
            Cost = 3400, 
            Description = "M416", 
            ItemId = 101004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 1,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M416.Icon_WEP_M416',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M762",
            Cost = 3400, 
            Description = "M762", 
            ItemId = 101008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 2,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M762_Small.Icon_WEP_M762_Small',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "AK47",
            Cost = 1700, 
            Description = "AK47", 
            ItemId = 101001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 6,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AK47.Icon_WEP_AK47',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "HoneyBadger",
            Cost = 1500, 
            Description = "蜜獾", 
            ItemId = 101012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 2,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_HoneyBadger.Icon_WEP_HoneyBadger',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "AC-VAL",
            Cost = 750, 
            Description = "AC-VAL", 
            ItemId = 101011, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 4,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_VAL.Icon_WEP_VAL',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "MK47",
            Cost = 1800, 
            Description = "MK47", 
            ItemId = 101009, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 4,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK47.Icon_WEP_MK47',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "AUG",
            Cost = 3750, 
            Description = "AUG", 
            ItemId = 101006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 5,
            BulletNeed = "需要5.56mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AUG.Icon_WEP_AUG',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        {
            Key = "GROZA",
            Cost = 3750, 
            Description = "GROZA", 
            ItemId = 101005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 2,
            Index = 6,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_GROZA.Icon_WEP_GROZA',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        },

        --狙击枪

        {
            Key = "SLR",
            Cost = 3000, 
            Description = "SLR", 
            ItemId = 103009, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SLR.Icon_WEP_SLR',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "VSS",
            Cost = 250, 
            Description = "VSS", 
            ItemId = 103005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 4,
            BulletNeed = "需要9mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_VSS.Icon_WEP_VSS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Mini14",
            Cost = 800, 
            Description = "Mini14", 
            ItemId = 103006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 4,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Mini14.Icon_WEP_Mini14',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Win1894",
            Cost = 250, 
            Description = "Win1894", 
            ItemId = 103008, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 2,
            BulletNeed = "需要点45mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Win1894.Icon_WEP_Win1894',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Kar98k",
            Cost = 800, 
            Description = "Kar98k", 
            ItemId = 103001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 5,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Kar98k.Icon_WEP_Kar98k',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SKS",
            Cost = 1800, 
            Description = "SKS", 
            ItemId = 103004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 6,
            BulletNeed = "需要7.62mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SKS.Icon_WEP_SKS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "QBU",
            Cost = 1500, 
            Description = "QBU", 
            ItemId = 103010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 1,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_QBU.Icon_WEP_QBU',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MK12",
            Cost = 3000, 
            Description = "MK12", 
            ItemId = 103100, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 3,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK12.Icon_WEP_MK12',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M417",
            Cost = 2000, 
            Description = "M417", 
            ItemId = 103013, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 3;
            Page = 1,
            Index = 4,
            BulletNeed = "需要5.56子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M417.Icon_WEP_M417',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Mosin",
            Cost = 850, 
            Description = "Mosin", 
            ItemId = 103011, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 4,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_mosin.Icon_WEP_mosin',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MK20",
            Cost = 3000, 
            Description = "MK20", 
            ItemId = 103014, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 5,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK20.Icon_WEP_MK20',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M24",
            Cost = 3000, 
            Description = "M24", 
            ItemId = 103002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 2,
            Index = 6,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M24.Icon_WEP_M24',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MK14",
            Cost = 2000, 
            Description = "MK14", 
            ItemId = 103007, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 3,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MK14.Icon_WEP_MK14',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "AMR",
            Cost = 5500, 
            Description = "AMR", 
            ItemId = 103012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 3,
            Index = 2,
            BulletNeed = "需要点50子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AMR.Icon_WEP_AMR',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "AWM",
            Cost = 3200, 
            Description = "AWM", 
            ItemId = 103003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 3,
            Index = 3,
            BulletNeed = "需要.300Magnum子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AWM.Icon_WEP_AWM',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "0408",
            Cost = 100, 
            Description = ".408口径子弹", 
            ItemId = 306003, 
            Count = 30, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 1;
            Page = 2,
            Index = 5,
            BulletNeed = "",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Ammo/Icon_Ammo_408_Pickup.Icon_Ammo_408_Pickup',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M200",
            Cost = 5500, 
            Description = "M200", 
            ItemId = 103015, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 4;
            Page = 1,
            Index = 3,
            BulletNeed = "需要.300Magnum子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M200.Icon_WEP_M200',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        --重武器

        {
            Key = "S1897",
            Cost = 850, 
            Description = "S1897", 
            ItemId = 104002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 2,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S1897.Icon_WEP_S1897',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SawedOff",
            Cost = 500, 
            Description = "短管霰弹枪", 
            ItemId = 106006, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 1,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SawedOff.Icon_WEP_SawedOff',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "S686",
            Cost = 850, 
            Description = "S686", 
            ItemId = 104001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 3,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S686.Icon_WEP_S686',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "S12K",
            Cost = 2500, 
            Description = "S12K", 
            ItemId = 104003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 4,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_S12K.Icon_WEP_S12K',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "DP28",
            Cost = 2500, 
            Description = "DP28", 
            ItemId = 105002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 5,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DP28.Icon_WEP_DP28',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "PKM",
            Cost = 6500, 
            Description = "PKM", 
            ItemId = 105012, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 6,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_PKM.Icon_WEP_PKM',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SawM79",
            Cost = 4000, 
            Description = "短管榴弹", 
            ItemId = 107096, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 2,
            Index = 1,
            BulletNeed = "需要40mm榴弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SawedOffM79.Icon_WEP_SawedOffM79',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "RPG",
            Cost = 8800, 
            Description = "RPG", 
            ItemId = 107002, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 2,
            Index = 2,
            BulletNeed = "需要RPG火箭弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_RPG7.Icon_WEP_RPG7',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "SPAS",
            Cost = 2500, 
            Description = "SPAS", 
            ItemId = 104100, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 2,
            Index = 2,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_SPAS.Icon_WEP_SPAS',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "DBS",
            Cost = 3600, 
            Description = "DBS霰弹枪", 
            ItemId = 104004, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 2,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_DP12.Icon_WEP_DP12',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M249",
            Cost = 5750, 
            Description = "M249", 
            ItemId = 105001, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 2,
            Index = 4,
            BulletNeed = "需要5.56mm子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M249.Icon_WEP_M249',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MGL",
            Cost = 9000, 
            Description = "MGL榴弹", 
            ItemId = 107098, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 5,
            BulletNeed = "需要40mm榴弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MGL140.Icon_WEP_MGL140',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
 

        {
            Key = "M134",
            Cost = 7000, 
            Description = "加特林", 
            ItemId = 105003, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 3,
            Index = 1,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M134.Icon_WEP_M134',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        -- {
        --     Key = "ElectricGun",
        --     Cost = 8000, 
        --     Description = "电击步枪", 
        --     ItemId = 190010, 
        --     Count = 1, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 5;
        --     Page = 3,
        --     Index = 2,
        --     BulletNeed = "充能电池",
        --     Picture = '/Game/UGC/Weapon/WeaponArt/ElectricGun/Icon/Icon_UGC_ElectricGun.Icon_UGC_ElectricGun'
        -- }, 

       -- {
       --     Key = "Explode",
      --      Cost = 12000, 
       --     Description = "爆破投射器", 
       --     ItemId = 190008, 
       --     Count = 1, 
      --      --Belong为类别,Page为页数，Page表示框的位置，
      --      Belong = 5;
      --      Page = 3,
       --     Index = 3,
      --      BulletNeed = "需要RPG子弹",
      --      Picture = '/Game/UGC/Weapon/WeaponArt/MGL/Icon/Icon_UGC_MGL.Icon_UGC_MGL'
      --  }, 

        -- {
        --     Key = "LaserGun",
        --     Cost = 20000, 
        --     Description = "激光步枪", 
        --     ItemId = 190011, 
        --     Count = 1, 
        --     --Belong为类别,Page为页数，Page表示框的位置，
        --     Belong = 5;
        --     Page = 3,
        --     Index = 4,
        --     BulletNeed = "需要300Magnum子弹",
        --     Picture = '/Game/UGC/Weapon/WeaponArt/LaserGun/Icon/Icon_UGC_LaserGun.Icon_UGC_LaserGun'
        -- }, 

        {
            Key = "AA12",
            Cost = 7500, 
            Description = "AA12", 
            ItemId = 104005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 3,
            Index = 5,
            BulletNeed = "需要12霰弹枪子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_AA12.Icon_WEP_AA12',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "M3E1",
            Cost = 9000, 
            Description = "M3E1导弹", 
            ItemId = 107099, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 1,
            BulletNeed = "需要火箭弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M3E2.Icon_WEP_M3E2',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "MG3",
            Cost = 7250, 
            Description = "MG3", 
            ItemId = 105010, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 2,
            BulletNeed = "需要7.62子弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_MG3.Icon_WEP_MG3',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
        
        {
            Key = "M202",
            Cost = 8000, 
            Description = "M202四联火箭", 
            ItemId = 107095, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 1,
            Index = 2,
            BulletNeed = "需要火箭弹",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_M202.Icon_WEP_M202',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 

        {
            Key = "Panzerfaust",
            Cost = 500, 
            Description = "Panzerfaust", 
            ItemId = 107005, 
            Count = 1, 
            --Belong为类别,Page为页数，Page表示框的位置，
            Belong = 5;
            Page = 4,
            Index = 1,
            BulletNeed = "一次性火箭筒",
            Picture = '/Game/Arts/UI/TableIcons/ItemIcon/Weapon/Icon_WEP_Panzerfaust.Icon_WEP_Panzerfaust',
            PayLockNum = 0 -- 0: 不锁定 1: 锁定 2: 已购买
        }, 
      
    }, 
}


function BP_ShopComponent:Buy(ItemKey, PlayerController)
    sandbox.LogNormalDev(StringFormat_Dev("[BP_ShopComponent:Buy] self=%s ItemKey=%s PlayerController=%s", GetObjectFullName_Dev(self), ToString_Dev(ItemKey), GetObjectFullName_Dev(PlayerController)))
    ugcprint("BP_ShopComponentBuy"..ItemKey)
    local Owner = self:GetOwner()
    ugcprint("BP_ShopComponentBuy1  "..GetObjectFullName_Dev(Owner))
   
    if UE.IsValid(Owner) then
        if Owner:HasAuthority() and UE.IsValid(PlayerController) and PlayerController:HasAuthority() then
            local DataSource = self.DataSource4
           
            for _, Category in pairs(DataSource) do
                for X, Y in pairs(Category) do
                    if type(Y) == "table" and Y.Key == ItemKey then
                        sandbox.LogNormalDev(StringFormat_Dev("[BP_ShopComponent:Buy] PlayerController.PlayerState.Gold=%s Y.Cost=%s", ToString_Dev(PlayerController.PlayerState.Gold), ToString_Dev(Y.Cost)))
    
                        if PlayerController.PlayerState.Gold >= Y.Cost then
                            --Category.BuyHandler(self, Y, PlayerController)
                            PlayerController.PlayerState.Gold = PlayerController.PlayerState.Gold - Y.Cost                        
                        end
                        break
                    end
                end
            end    
        else
            ugcprint("BP_ShopComponentBuy2"..ItemKey.." "..GetObjectFullName_Dev(PlayerController))
            PlayerController:ServerRPC_Buy(ItemKey)
            --Owner:Server_Buy(ItemKey, PlayerController)
            ugcprint("BP_ShopComponentBuy3")
        end
    end
end

function BP_ShopComponent:GetDataSourceItem(ShopType,ItemKey,PlayerController)
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
return BP_ShopComponent