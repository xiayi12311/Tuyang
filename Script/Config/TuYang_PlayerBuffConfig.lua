local TuYang_PlayerBuffConfig = TuYang_PlayerBuffConfig or {}

TuYang_PlayerBuffConfig.ItemsGroup = {}

local function InitGroup(InKey, Group)
    TuYang_PlayerBuffConfig.ItemsGroup[InKey] = Group
    return TuYang_PlayerBuffConfig.ItemsGroup[InKey]
end

function TuYang_PlayerBuffConfig.InitConfig()
    for k, v in pairs(TuYang_PlayerBuffConfig.BuffItems) do
        InitGroup(v.Key, v)
    end
    --UGCLog.Log("TuYang_PlayerBuffConfigInitConfig",TuYang_PlayerBuffConfig.ItemsGroup)
end

function TuYang_PlayerBuffConfig:GetItem(InKey)
    local Group = TuYang_PlayerBuffConfig.ItemsGroup[InKey]
    if Group == nil then
        print("Error TuYang_PlayerBuffConfig.GetItem: Key:"..tostring(InKey))
        return
    end
    return TuYang_PlayerBuffConfig.ItemsGroup[InKey]
end

TuYang_PlayerBuffConfig.BuffItems = 
{
   -- BuffCardItemUI 
    {
        Key = 0, 
        Name = "肾上腺素",
        Description = "换弹时间 -15%",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_5.BuffSkill2_5'),
        StatusBarTexturePath = "",
        Level = 1
    },
    {
        Key = 1, 
        Name = "脚底抹油",
        Description = "移速增加 15%",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_5.BuffSkill4_5'),
        StatusBarTexturePath = "",
        Level = 1
    },
    {
        Key = 2, 
        Name = "身强体壮",
        Description = "生命值 +50",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill7_2.BuffSkill7_2'),
        StatusBarTexturePath = "",
        Level = 1
    },
    {
        Key = 3, 
        Name = "赏金猎人",
        Description = "谁跟钱有仇呢|-额外获得25%赏金",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_7.BuffSkill2_7'),
        StatusBarTexturePath = "",
        Level = 1
    },
    {
        Key = 4, 
        Name = "高利贷",
        Description = "开局获得3000金币，但击杀怪物赏金减少20",
        Texture = '/Game/UGC/Repository/Icon/Skill/Icon_Skill_39.Icon_Skill_39',
        StatusBarTexturePath = "",
        Level = 1
    },
    -- {
    --     Key = 5, 
    --     Name = "祖传武器",
    --     Description = "开局获得1把AK47",
    --     Texture = '/Game/UGC/Repository/Icon/Skill/Icon_Skill_27.Icon_Skill_27',
    --     StatusBarTexturePath = "",
    --     Level = 1
    -- },
    -- {
    --     Key = 6, 
    --     Name = "炸弹狂人",
    --     Description = "开局获得5个手雷 ",
    --     Texture = '/Game/UGC/Repository/Icon/Skill/Icon_Skill_55.Icon_Skill_55',
    --     StatusBarTexturePath = "",
    --     Level = 1
    -- },
    {
        Key = 7, 
        Name = "吸血鬼",
        Description = "德古拉伯爵第四十八世孙|-击败怪物回复1滴血",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill7_4.BuffSkill7_4'),
        StatusBarTexturePath = "",
        Level = 1
    },
    -- {
    --     Key = 8, 
    --     Name = "乌龟壳",
    --     Description = "开局获得1件3级甲",
    --     Texture = '/Game/UGC/Repository/Icon/Skill/Icon_Skill_30.Icon_Skill_30',
    --     StatusBarTexturePath = "",
    --     Level = 1
    -- },
    {
        Key = 9, 
        Name = "时空旅者",
        Description = "神出鬼没，来去自如|-使用传送门费用-90%",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill7_1.BuffSkill7_1'),
        StatusBarTexturePath = "",
        Level = 1
    },   
    {
        Key = 10, 
        Name = "偷袭！",
        Description = "发射一颗威力巨大的穿甲弹，对一条直线的敌人造成100伤害，可以穿透场地中央空气墙|-快让对手读秒复活！",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill6_5.BuffSkill6_5'),
        StatusBarTexturePath = "",
        Level = 2
    },
    {
        Key = 11, 
        Name = "冰冻子弹",
        Description = "每射击2发子弹发射一颗冰冻子弹，造成100%武器伤害和2s的冰冻效果|-增加16%冰系伤害-增加10%射速",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_1.BuffSkill1_1'),
        StatusBarTexturePath = "",
        Level = 1
    },  
    {
        Key = 12, 
        Name = "治愈之风",
        Description = "站立不动3s秒时召唤一阵治愈之风，每1s对范围内友军治疗1%生命值，对敌人造成4%生命值的伤害|-增加18%风系伤害-增加11%生命值",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill5_4.BuffSkill5_4'),
        StatusBarTexturePath = "",
        Level = 2
    },  
    {
        Key = 13, 
        Name = "旺旺碎冰冰",
        Description = "每发子弹有20%概率生成一颗冰冻球，命中后对2M范围的敌人造成70%武器伤害和冰冻效果|-增加18%冰系伤害-增加1弹夹容量",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_1.BuffSkill2_1'),
        StatusBarTexturePath = "",
        Level = 2
    },  
    {
        Key = 14, 
        Name = "大火收汁",
        Description = "每射击8发子弹喷射火焰，点燃喷射范围内的敌人，持续5s共造成65%武器伤害|-增加18%火系伤害-增加11%换弹速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_2.BuffSkill1_2'),
        StatusBarTexturePath = "",
        Level = 2
    },  
    {
        Key = 15, 
        Name = "自热火锅",
        Description = "每次射击有11%概率发射一碗爆炸辣的自热火锅，点燃300范围的敌人，持续5s共造成60%武器伤害|-增加21%火系伤害-增加1弹夹容量",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_2.BuffSkill2_2'),
        StatusBarTexturePath = "",
        Level = 3
    },  
    {
        Key = 16, 
        Name = "闪电子弹",
        Description = "冷却时间1.5s，下一次射击时发射一发闪电子弹，造成255%武器伤害和2s麻痹|-增加16%电系伤害-增加10%武器伤害",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_3.BuffSkill3_3'),
        StatusBarTexturePath = "",
        Level = 1
    },  
    {
        Key = 17, 
        Name = "逆风快递",
        Description = "每射击20发子弹送货上门一个龙卷风，对4m范围内的敌人造成105%武器伤害|-增加27%风系伤害-范围增加17%射击速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_4.BuffSkill1_4'),
        StatusBarTexturePath = "",
        Level = 4
    },  
    {
        Key = 18, 
        Name = "十万伏特",
        Description = "每次射击时14%的概率发射一次闪电爆炸，对4m范围内的敌人造成40%武器伤害和2s麻痹|-增加27%电系伤害-增加17%换弹速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_3.BuffSkill2_3'),
        StatusBarTexturePath = "",
        Level = 4
    },  
    {
        Key = 19, 
        Name = "电能激荡",
        Description = "每射击6发子弹发射一次电能穿刺，造成50%武器伤害和2s麻痹|-增加18%电系伤害-增加11%弹夹容量",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_3.BuffSkill1_3'),
        StatusBarTexturePath = "",
        Level = 2 
    },  
    {
        Key = 20, 
        Name = "春风拂面",
        Description = "每次射击有25%概率发射一阵春风，造成225%武器伤害，在目标位置处留下一个治疗法球|-增加18%风系伤害-增加1弹夹容量",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_4.BuffSkill2_4'),
        StatusBarTexturePath = "",
        Level = 2
    },  
    {
        Key = 21, 
        Name = "滑冰运动",
        Description = "每移动6.5m召唤一个冰雕爆裂，对4m范围敌人造成（5%武器伤害+1%移动速度）伤害和2s冰冻|-增加27%冰系伤害-增加17%移动速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_1.BuffSkill4_1'),
        StatusBarTexturePath = "",
        Level = 4
    },  
    {
        Key = 22, 
        Name = "大威天雷",
        Description = "每移动10m召唤一个雷域，对3m范围敌人造成（9%武器伤害+2.1%移动速度）伤害和2s麻痹|-增加21%冰系伤害-增加13%移动速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_3.BuffSkill4_3'),
        StatusBarTexturePath = "",
        Level = 3
    },  
    {
        Key = 23, 
        Name = "英雄登场",
        Description = "每次跳跃时，对3m范围敌人造成（20%武器伤害+2.5%移动速度）点燃伤害|-增加18%火系伤害-增加11%移动速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_2.BuffSkill4_2'),
        StatusBarTexturePath = "",
        Level = 2
    },  
    {
        Key = 24, 
        Name = "美丽冻人",
        Description = "站立不动3s后，生成一个4m范围的霜冻领域，每0.5s对范围所有敌人造成（2.5%生命值）伤害和冰冻|-增加21%冰系伤害-增加13%生命值",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill5_1.BuffSkill5_1'),
        StatusBarTexturePath = "",
        Level = 3
    },  
    {
        Key = 25, 
        Name = "电疗",
        Description = "站立不动时，每3s 召唤一个持续3s的电场，每1s对范围所有敌人造成（6%生命值）伤害和麻痹|-增加18%电系伤害-增加11%生命值",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill5_3.BuffSkill5_3'),
        StatusBarTexturePath = "",
        Level = 2
    },  
    {
        Key = 26, 
        Name = "小火慢炖",
        Description = "站立不动时，每1s 发射一团火焰，造成（60%生命值）点燃伤害|-增加16%火系伤害-增加10%生命值",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill5_2.BuffSkill5_2'),
        StatusBarTexturePath = "",
        Level = 1
    }, 
    {
        Key = 27, 
        Name = "风刃术",
        Description = "每移动2m召唤1柄风刃，造成（12%武器伤害+1.2%移速）伤害|-增加16%火系伤害-增加10%移动速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_4.BuffSkill4_4'),
        StatusBarTexturePath = "",
        Level = 1
    }, 
    {
        Key = 28, 
        Name = "霹雳15火箭弹",
        Description = "冷却时间10s，射击时发射一枚火箭弹，造成4m范围105%武器伤害和5s点燃|-增加27%火系伤害-增加17%武器伤害",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_2.BuffSkill3_2'),
        StatusBarTexturePath = "",
        Level = 4
    }, 
    {
        Key = 29, 
        Name = "冰锥术",
        Description = "冷却时间2s，射击时发射一发可无限穿透的冰锥，造成85%武器伤害和2s减速|-增加18%冰系伤害-增加11%武器伤害",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_1.BuffSkill3_1'),
        StatusBarTexturePath = "",
        Level = 2
    }, 
    {
        Key = 30, 
        Name = "飓风呼啸",
        Description = "冷却时间5s，射击时生成一道向前滑行的飓风，造成135%武器伤害|-增加21%风系伤害-增加13%武器伤害",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_4.BuffSkill3_4'),
        StatusBarTexturePath = "", 
        Level = 3
    }, 
    {
        Key = 31, 
        Name = "冰火两重天",
        Description = "寒冰系技能与火焰系技能【伤害增加135%】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill6_1.BuffSkill6_1'),
        StatusBarTexturePath = "",
        Level = 2
    }, 
    {
        Key = 32, 
        Name = "电火花",
        Description = "闪电系技能与火焰系技能【伤害增加135%】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill6_2.BuffSkill6_2'),
        StatusBarTexturePath = "",
        Level = 2
    }, 
    {
        Key = 33, 
        Name = "闪电增伤",
        Description = "闪电系技能【伤害增加100%】",
        Texture = '/Game/UGC/Repository/Icon/Skill/Icon_Skill_52.Icon_Skill_52',
        StatusBarTexturePath = "",
        Level = 1
    }, 
    {
        Key = 34, 
        Name = "风系增效",
        Description = "风系技能【效果增强100%】，伤害与治疗效果均增强",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill6_4.BuffSkill6_4'),
        StatusBarTexturePath = "",
        Level = 1
    }, 
    {
        Key = 35, 
        Name = "第一发",
        Description = "当前武器发射第一发子弹时【武器伤害增加150%】，可以使技能增伤",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_5.BuffSkill3_5'),
        StatusBarTexturePath = "",
        Level = 1
    }, 
    {
        Key = 36, 
        Name = "最后一发",
        Description = "当前武器发射最后一发子弹时【武器伤害增加150%】，可以使技能增伤",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_6.BuffSkill3_6'),
        StatusBarTexturePath = "",
        Level = 4
    }, 
    {
        Key = 37, 
        Name = "射击增速",
        Description = "射击时【增加35%移动速度】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_5.BuffSkill4_5'),
        StatusBarTexturePath = "",
        Level = 2
    }, 
    {
        Key = 38, 
        Name = "滑溜换弹",
        Description = "换弹时【增加75%移动速度】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_6.BuffSkill4_6'),
        StatusBarTexturePath = "",
        Level = 3
    }, 
    {
        Key = 39, 
        Name = "一路发财",
        Description = "每移动9m掉落一个大红包，拾取获得50金币|-无",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_7.BuffSkill4_7'),
        StatusBarTexturePath = "",
        Level = 3
    }, 
    {
        Key = 40, 
        Name = "扩容弹夹",
        Description = "增加【20%弹夹容量】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_6.BuffSkill1_6'),
        StatusBarTexturePath = "",
        Level = 2
    }, 
    {
        Key = 41, 
        Name = "快速换弹",
        Description = "减少【30%换弹时间】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_5.BuffSkill2_5'),
        StatusBarTexturePath = "",
        Level = 3
    }, 
    {
        Key = 42, 
        Name = "快速射击",
        Description = "增加【15%武器射速】",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_5.BuffSkill1_5'),
        StatusBarTexturePath = "",
        Level = 1
    }, 
    {
        Key = 43, 
        Name = "紧急换弹",
        Description = "弹夹剩余子弹变成1时，有20%概率重新填满弹匣",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_6.BuffSkill2_6'),
        StatusBarTexturePath = "",
        Level = 2
    }, 
    {
        Key = 44, 
        Name = "理财达人",
        Description = "开始理财，每分钟获得60%存款的利息|-无",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_7.BuffSkill3_7'),
        Level = 2
    }, 
    {
        Key = 45, 
        Name = "打钱高手",
        Description = "每射击10发子弹后掉落一个红包，拾取后获得50金币|-无",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_7.BuffSkill1_7'),
        Level = 1
    },
    {
        Key = 46, 
        Name = "火龙卷",
        Description = "射击时有12%概率生成一道向前滑行的火龙卷，造成100%武器伤害和5s点燃|-增加27%风系伤害-增加27%火系伤害-增加2弹夹容量",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill8_8.BuffSkill8_8'),
        Level = 4  
    },
    {
        Key = 47, 
        Name = "寄生种子",
        Description = "每射击18发子弹发射一颗神奇大树种子，对4m范围敌人造成75%武器伤害，同时范围回血|-增加21%木系伤害-增加13%换弹速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill1_9.BuffSkill1_9'),
        Level = 3
    },
    {
        Key = 48, 
        Name = "毒刺子弹",
        Description = "射击时有25%概率发射一颗毒刺子弹，造成200%武器伤害|-增加16%木系伤害-增加10%换弹速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill2_9.BuffSkill2_9'),
        Level = 1
    },
    {
        Key = 49, 
        Name = "变质大西瓜",
        Description = "冷却时间3s，射击时发射一颗变质大西瓜，造成2m范围130%武器伤害|-增加18%木系伤害-增加11%武器伤害",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill3_9.BuffSkill3_9'),
        Level = 2
    },
    {
        Key = 50, 
        Name = "人肉毒气弹",
        Description = "每移动3m放出一朵毒云，每1s造成 （2.5%武器伤害+0.5%移速）伤害|-增加18%木系伤害-增加11%移动速度",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill4_9.BuffSkill4_9'),
        Level = 2
    },
    {
        Key = 51, 
        Name = "天罗毒网",
        Description = "站立不动时，每2s召唤一朵毒性爆炸，造成2m范围（25%生命值）伤害|-增加27%木系伤害-增加17%生命值 ",
        Texture = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Picture/BuffIcon/BuffSkill5_9.BuffSkill5_9'),
        Level = 4
    },
}

-- 
-- 
-- 
-- 
-- 
-- 
-- 

TuYang_PlayerBuffConfig.InitConfig()

return TuYang_PlayerBuffConfig