---@class BPCharacter_ProtectAthena_C:BP_UGCPlayerPawn_C
---@field Plane UStaticMeshComponent
---@field BP_UGCVideoPlayer BP_UGCVideoPlayer_C
--Edit Below--
local BPCharacter_ProtectAthena = BPCharacter_ProtectAthena or 
{
    EnemyCount = 0;
    InsectCount = 0, --击杀蟑螂计数
    TaskStage_Insect = 0,
    TaskStage_XiaoQi = 0,
    PlayersNum = 0
}
local EventSystem = require("Script.Common.UGCEventSystem")
require("Script.VectorHelper")
local TuYang_WeaponConfig = require("Script.TuYang_WeaponConfig")


BPCharacter_ProtectAthena.BingDiaoMap = {}

--[[local BPCharacter_ProtectAthena = {

    Temperature = 100,
}]]

--BPCharacter_ProtectAthena.SnowTrainTemperature = 100
BPCharacter_ProtectAthena.BackPack =nil

BPCharacter_ProtectAthena.DamageScaleValue = 1

BPCharacter_ProtectAthena.time = 0

BPCharacter_ProtectAthena.BingDiao = nil

BPCharacter_ProtectAthena.BingDiaoNew = nil

BPCharacter_ProtectAthena.location = nil

BPCharacter_ProtectAthena.IceButton = nil

BPCharacter_ProtectAthena.MoveFlag = true

BPCharacter_ProtectAthena.BingDiaoFlag = false

BPCharacter_ProtectAthena.LocalHot = nil

BPCharacter_ProtectAthena.Hot = 10

--冰冻效果
BPCharacter_ProtectAthena.ColdStage = nil
BPCharacter_ProtectAthena.ColdStage1 = nil
BPCharacter_ProtectAthena.ColdStage2 = nil
BPCharacter_ProtectAthena.ColdStage3 = nil
BPCharacter_ProtectAthena.ColdStage4 = nil
BPCharacter_ProtectAthena.ColdStage5 = nil

BPCharacter_ProtectAthena.FireHotUI = nil
BPCharacter_ProtectAthena.FireHotUI1 = nil
BPCharacter_ProtectAthena.FireHotUI2 = nil
BPCharacter_ProtectAthena.FireHotUI3 = nil
BPCharacter_ProtectAthena.FireHotUI4 = nil
BPCharacter_ProtectAthena.MainControlPanel =nil
--显示温度标识的标志

BPCharacter_ProtectAthena.GunBuff =
{
    
    --上面是调试
    {
        id =107096;
        damage = 130
    },
    {
        id =107002;
        damage = 280
    },
    {
        id =103009;
        damage = 114
    },
    {
        id =101013;
        damage = 90
    },
    {
        id =101004;
        damage = 92
    },
    {
        id =101008        ;
        damage = 95
    },
    {
        id =103100;
        damage = 99
    },
    {
        id =105012;
        damage = 110
    },
    {
        id =103014;
        damage = 139
    },
    {
        id =103002;
        damage = 380
    },

    {
        id =103001;
        damage = 170
    },
    {
        id =103011;
        damage = 190
    },
    {
        id =104004;
        damage =45
    },
    {
        id =101006;
        damage = 94
    },
    {
        id =105001;
        damage = 85
    },
    {
        id =103003;
        damage = 523
    },
    {
        id =107099;
        damage = 154
    },
    {
        id =102105;
        damage = 73
    },
    {
        id =101005;
        damage = 104
    },
    {
        id =104005;
        damage = 50
    },
    {
        id =103012;
        damage = 700
    },
    {
        id =103015;
        damage = 638
    },
    {
        id =105003;
        damage = 132
    },
    {
        id =107098;
        damage = 154
    }
}
BPCharacter_ProtectAthena.ColdAreaUI = nil

BPCharacter_ProtectAthena.FireHotFlag = false
BPCharacter_ProtectAthena.ClearTime = 0
local TaskButton = nil
BPCharacter_ProtectAthena.Coin= nil
function  BPCharacter_ProtectAthena:ClearFireHotUI() 
    if UE.IsValid(self.FireHotUI) then
        self.FireHotUI:RemoveFromViewport()
        self.FireHotUI = nil
    end

end



function BPCharacter_ProtectAthena:GetIceButtonClassPath()
    return  string.format([[UGCWidgetBlueprint'%sAsset/IceButton.IceButton_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

-- function BPCharacter_ProtectAthena:GetTestPercentClassPath()
-- 	return string.format([[UGCWidgetBlueprint'%sAsset/TestPercent.TestPercent_C']], UGCMapInfoLib.GetRootLongPackagePath())
-- end

function BPCharacter_ProtectAthena:GetColdStage1ClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/ColdUI/ColdStage1.ColdStage1_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPCharacter_ProtectAthena:GetColdStage2ClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/ColdUI/ColdStage2.ColdStage2_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPCharacter_ProtectAthena:GetColdStage3ClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/ColdUI/ColdStage3.ColdStage3_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPCharacter_ProtectAthena:GetColdStage4ClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/ColdUI/ColdStage4.ColdStage4_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPCharacter_ProtectAthena:GetColdStage5ClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/ColdUI/ColdStage5.ColdStage5_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPCharacter_ProtectAthena:GetFireHotUIClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/FireHotUI/FireHotUI.FireHotUI_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPCharacter_ProtectAthena:GetColdAreaUIClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/Blueprint/ColdAreaUI/ColdAreaUI.ColdAreaUI_C']], UGCMapInfoLib.GetRootLongPackagePath())
end


function BPCharacter_ProtectAthena:GetReplicatedProperties()
    return "DamageScaleValue",
    "InsectCount",
    "TaskStage_Insect",
    "TaskStage_XiaoQi",
    "EnemyCount",
    "PlayersNum"
end


function BPCharacter_ProtectAthena:ResetTask_Insect()
        self.TaskStage_Insect = 0
        self.InsectCount = 0

end


function BPCharacter_ProtectAthena:IsVelocityZero() 
    local velocity = self:GetVelocity()
    return (velocity.x == 0 and velocity.y == 0 and velocity.z == 0)
end



function BPCharacter_ProtectAthena:UGC_WeaponShootBulletEvent(ShootWeapon,Bullet,HitInfo)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local FireHotUIClass = UE.LoadClass(self:GetFireHotUIClassPath())
    if self:HasAuthority() == true then 
    else
        if PlayerController.PlayerState.InIce then
            --开枪升温
            local hot = PlayerController.PlayerState.Hot
            if hot > 0 then

                if not UE.IsValid(self.FireHotUI)then
                    self.FireHotUI = UserWidget.NewWidgetObjectBP(PlayerController, FireHotUIClass)
                    self.FireHotUI:AddToViewport(0)
                end

            else
                if UE.IsValid(self.FireHotUI) then
                    self.FireHotUI:RemoveFromViewport()
                    self.FireHotUI = nil
                end    
            end

        else
            if UE.IsValid(self.FireHotUI) then
                self.FireHotUI:RemoveFromViewport()
                self.FireHotUI = nil
            end
            
        end
    end

end




function BPCharacter_ProtectAthena:ShowIceButton()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local IceButtonClass = UE.LoadClass(self:GetIceButtonClassPath())
        if UE.IsValid(IceButtonClass) then
            if not UE.IsValid(self.IceButton) then
                self.IceButton = UserWidget.NewWidgetObjectBP(PlayerController, IceButtonClass)
            end
        end
        if UE.IsValid(self.IceButton) then
            self.IceButton:AddToViewport(0)
        end
end

function BPCharacter_ProtectAthena:CloseIceButton()
    if UE.IsValid(self.IceButton) then
        self.IceButton:RemoveFromViewport()
        self.IceButton = nil
    end
end


function BPCharacter_ProtectAthena:GetDistanceTimer()
    ugcprint("[maoyu] GetDistanceTimer")
    self.timer = Timer.InsertTimer(3,
    function()
        ugcprint("[maoyu]111")
        local ProjActorPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalSkillProjectile/TuYang_TacticalSkillProjectile.TuYang_TacticalSkillProjectile_C')
        local ProjActorClass = UE.LoadClass(ProjActorPath)
        local ProjActor = GameplayStatics.GetAllActorsOfClass(self, ProjActorClass, {})
        local Dis = VectorHelper.GetDistance(self:K2_GetActorLocation(),{X=1950.000000,Y=1150.000000,Z=3149.575439})
        --UGCLog.Log("[maoyu] 距离=",Dis)
    end,
    true
    )
end


function BPCharacter_ProtectAthena:ReceiveTick(Deltatime)
    BPCharacter_ProtectAthena.SuperClass.ReceiveTick(self,Deltatime)

    -- 速度追踪 ，不受速度上限限制的真实速度值
    local Velocity = self:GetVelocity()
    self.ActualSpeedValue = VectorHelper.Length(Velocity)

    if self:HasAuthority() then
        -- 特殊技能MoveSkill逻辑判断
        if self.MoveSkillData["Skill4_1"].Check then
            self:UpdateMoveDistance("Skill4_1")
        end
        if self.MoveSkillData["Skill4_3"].Check then
            self:UpdateMoveDistance("Skill4_3")
        end
        if self.MoveSkillData["Skill4_4"].Check then
            self:UpdateMoveDistance("Skill4_4")
        end
        if self.MoveSkillData["Skill4_7"].Check then
            self:UpdateMoveDistance("Skill4_7")
        end
        if self.MoveSkillData["Skill4_9"].Check then
            self:UpdateMoveDistance("Skill4_9")
        end
        --特殊技能StandSkill逻辑判断
        if self.StaySkillData["Skill5_4"].Check then
            self:CheckIsStayTimeEnough("Skill5_4")
        end
        if self.StaySkillData["Skill5_1"].Check then
            self:CheckIsStayTimeEnough("Skill5_1")
        end
        if self.StaySkillData["Skill5_2"].Check then
            self:CheckIsStayTimeEnough("Skill5_2")
        end
        if self.StaySkillData["Skill5_3"].Check then
            self:CheckIsStayTimeEnough("Skill5_3")
        end
        if self.StaySkillData["Skill5_9"].Check then
            self:CheckIsStayTimeEnough("Skill5_9")
        end
    end
end


function BPCharacter_ProtectAthena:RefershBingDiaoHandle(hot,PlayerKey)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
   
    local ColdStage1Class = UE.LoadClass(self:GetColdStage1ClassPath())
    local ColdStage2Class = UE.LoadClass(self:GetColdStage2ClassPath())
    local ColdStage3Class = UE.LoadClass(self:GetColdStage3ClassPath())
    local ColdStage4Class = UE.LoadClass(self:GetColdStage4ClassPath())
    local ColdStage5Class = UE.LoadClass(self:GetColdStage5ClassPath())

    local SoundPath1 = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/cold_1_1.cold_1_1')
    local SoundPath2 = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/cold_2_1.cold_2_1')
    local SoundPath3 = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/cold_3_1.cold_3_1')
    local SoundPath4 =UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/cold_4_1.cold_4_1')
    local SoundPath5 =UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/cold_5_1.cold_5_1')
    local Sound1 = UE.LoadObject(SoundPath1)
    local Sound2 = UE.LoadObject(SoundPath2)
    local Sound3 = UE.LoadObject(SoundPath3)
    local Sound4 = UE.LoadObject(SoundPath4)
    local Sound5 = UE.LoadObject(SoundPath5)

    
    if self.PlayerState.InIce== true then 
       
        if self:HasAuthority() == true  then 
            
        
        else
            if hot <= 0 then --暂时注释掉


               


                if self.MoveFlag then
                    self.DisableInput(PlayerController)
                    self.MoveFlag = false
                    
                end

                if not UE.IsValid(self.IceButton) then
                   self:ShowIceButton()
                end

                self.MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
                if self.MainControlPanel ~= nil then 
                    local MainControlShootUI = self.MainControlPanel.ShootingUIPanel;
                    MainControlShootUI.CustomReload:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomCrouch:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomProne:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomFireBtnR:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomJumpBtn:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomShootRed:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomShootAim:SetVisibility(ESlateVisibility.Collapsed);
                    MainControlShootUI.CustomFireBtnL:SetVisibility(ESlateVisibility.Collapsed);
                end


                --[[
                
                if not UE.IsValid(self.ColdStage5) then
                    self.ColdStage5 = UserWidget.NewWidgetObjectBP(PlayerController, ColdStage5Class)
                    self.ColdStage5:AddToViewport(0)
                    UGCSoundManagerSystem.PlaySoundAttachActor(Sound5,self,false)
                end

                --]]
                
                
              
                if UE.IsValid(self.ColdStage4) then
                    self.ColdStage4:RemoveFromViewport()
                    self.ColdStage4 = nil
                end

                if UE.IsValid(self.ColdStage3) then
                    self.ColdStage3:RemoveFromViewport()
                    self.ColdStage3 = nil
                end

                if UE.IsValid(self.ColdStage2) then
                    self.ColdStage2:RemoveFromViewport()
                    self.ColdStage2 = nil
                end

                if UE.IsValid(self.ColdStage1) then
                    self.ColdStage1:RemoveFromViewport()
                    self.ColdStage1 = nil
                end

                
            else

                

                if UE.IsValid(self.IceButton) then
                    self:CloseIceButton()
                end

                if hot >80 and hot <= 100 then

                    
                    if UE.IsValid(self.ColdStage4) then
                        self.ColdStage4:RemoveFromViewport()
                        self.ColdStage4 = nil
                    end

                    if UE.IsValid(self.ColdStage3) then
                        self.ColdStage3:RemoveFromViewport()
                        self.ColdStage3 = nil
                    end

                    if UE.IsValid(self.ColdStage2) then
                        self.ColdStage2:RemoveFromViewport()
                        self.ColdStage2 = nil
                    end

                    if UE.IsValid(self.ColdStage1) then
                        self.ColdStage1:RemoveFromViewport()
                        self.ColdStage1 = nil
                    end

                    if UE.IsValid(self.ColdStage5) then
                        self.ColdStage5:RemoveFromViewport()
                        self.ColdStage5 = nil
                    end
                    
                   


                end

                if hot >60 and hot <= 80 then

                    
                    if not UE.IsValid(self.ColdStage1) then
                        self.ColdStage1 = UserWidget.NewWidgetObjectBP(PlayerController, ColdStage1Class)
                        self.ColdStage1:AddToViewport(0)
                        UGCSoundManagerSystem.PlaySoundAttachActor(Sound1,self,false)
                    end  
                    

                    if UE.IsValid(self.ColdStage4) then
                        self.ColdStage4:RemoveFromViewport()
                        self.ColdStage4 = nil
                    end

                    if UE.IsValid(self.ColdStage3) then
                        self.ColdStage3:RemoveFromViewport()
                        self.ColdStage3 = nil
                    end

                    if UE.IsValid(self.ColdStage2) then
                        self.ColdStage2:RemoveFromViewport()
                        self.ColdStage2 = nil
                    end

                    if UE.IsValid(self.ColdStage5) then
                        self.ColdStage5:RemoveFromViewport()
                        self.ColdStage5 = nil
                    end
                    
                    
                    
                end

                if hot >40 and hot <= 60 then

                    if not UE.IsValid(self.ColdStage2) then
                        self.ColdStage2 = UserWidget.NewWidgetObjectBP(PlayerController, ColdStage2Class)
                        self.ColdStage2:AddToViewport(0)
                        UGCSoundManagerSystem.PlaySoundAttachActor(Sound2,self,false)
                    end  
                    

                    if UE.IsValid(self.ColdStage4) then
                        self.ColdStage4:RemoveFromViewport()
                        self.ColdStage4 = nil
                    end

                    if UE.IsValid(self.ColdStage3) then
                        self.ColdStage3:RemoveFromViewport()
                        self.ColdStage3 = nil
                    end

                    if UE.IsValid(self.ColdStage1) then
                        self.ColdStage1:RemoveFromViewport()
                        self.ColdStage1 = nil
                    end

                    if UE.IsValid(self.ColdStage5) then
                        self.ColdStage5:RemoveFromViewport()
                        self.ColdStage5 = nil
                    end
       
                end

                if hot >20 and hot <= 40 then

                    
                    if not UE.IsValid(self.ColdStage3) then
                        self.ColdStage3 = UserWidget.NewWidgetObjectBP(PlayerController, ColdStage3Class)
                        self.ColdStage3:AddToViewport(0)
                        UGCSoundManagerSystem.PlaySoundAttachActor(Sound3,self,false)
                    end  

                    if UE.IsValid(self.ColdStage4) then
                        self.ColdStage4:RemoveFromViewport()
                        self.ColdStage4 = nil
                    end

                    if UE.IsValid(self.ColdStage1) then
                        self.ColdStage1:RemoveFromViewport()
                        self.ColdStage1 = nil
                    end

                    if UE.IsValid(self.ColdStage2) then
                        self.ColdStage2:RemoveFromViewport()
                        self.ColdStage2 = nil
                    end

                    if UE.IsValid(self.ColdStage5) then
                        self.ColdStage5:RemoveFromViewport()
                        self.ColdStage5 = nil
                    end
                    
          
                end

                if hot >0 and hot <= 20 then
                              
                    if not UE.IsValid(self.ColdStage4) then
                        self.ColdStage4 = UserWidget.NewWidgetObjectBP(PlayerController, ColdStage4Class)
                        self.ColdStage4:AddToViewport(0)
                        UGCSoundManagerSystem.PlaySoundAttachActor(Sound4,self,false)

                    end  
                
                    if UE.IsValid(self.ColdStage1) then
                        self.ColdStage1:RemoveFromViewport()
                        self.ColdStage1 = nil
                    end

                    if UE.IsValid(self.ColdStage3) then
                        self.ColdStage3:RemoveFromViewport()
                        self.ColdStage3 = nil
                    end

                    if UE.IsValid(self.ColdStage2) then
                        self.ColdStage2:RemoveFromViewport()
                        self.ColdStage2 = nil
                    end

                    if UE.IsValid(self.ColdStage5) then
                        self.ColdStage5:RemoveFromViewport()
                        self.ColdStage5 = nil
                    end
                    

                end


                if not self.MoveFlag then
                    self.EnableInput(PlayerController)
                    self.MoveFlag = true
                end

                self.MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
                local MainControlShootUI = self.MainControlPanel.ShootingUIPanel;
                MainControlShootUI.CustomReload:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomCrouch:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomProne:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomFireBtnR:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomJumpBtn:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomShootRed:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomShootAim:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
                MainControlShootUI.CustomFireBtnL:SetVisibility(ESlateVisibility.SelfHitTestInvisible);

                
                
           
            end
    
        end
    --[[
    else

        if UE.IsValid(self.IceButton) then
            self:CloseIceButton()
        end

        if UE.IsValid(self.ColdStage4) then
            self.ColdStage4:RemoveFromViewport()
            self.ColdStage4 = nil
        end

        if UE.IsValid(self.ColdStage3) then
            self.ColdStage3:RemoveFromViewport()
            self.ColdStage3 = nil
        end

        if UE.IsValid(self.ColdStage1) then
            self.ColdStage1:RemoveFromViewport()
            self.ColdStage1 = nil
        end

        if UE.IsValid(self.ColdStage5) then
            self.ColdStage5:RemoveFromViewport()
            self.ColdStage5 = nil
        end

        if UE.IsValid(self.ColdStage2) then
            self.ColdStage2:RemoveFromViewport()
            self.ColdStage2 = nil
        end

        local MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
        local MainControlShootUI = MainControlPanel.ShootingUIPanel;
        MainControlShootUI.CustomReload:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomCrouch:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomProne:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomFireBtnR:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomJumpBtn:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomShootRed:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomShootAim:SetVisibility(ESlateVisibility.SelfHitTestInvisible);
        MainControlShootUI.CustomFireBtnL:SetVisibility(ESlateVisibility.SelfHitTestInvisible);

        --]]
    
    end
    
    
end



function BPCharacter_ProtectAthena:OnRep_DamageScale()
    KismetSystemLibrary.PrintString(self, "BPCharacter_ProtectAthena:OnRep_DamageScale " .. tostring(self.DamageScaleValue), true, true, LinearColor.New(1, 1, 1, 1), 15)
end


function BPCharacter_ProtectAthena:ReceiveBeginPlay()
    self.bVaultIsOpen = true
    self.bIsOpenShovelAbility = true
    BPCharacter_ProtectAthena.SuperClass.ReceiveBeginPlay(self)
    ugcprint("Character Begin!")
     if not self:HasAuthority() then
        self.MainControlPanel = GameBusinessManager.GetWidgetFromName(ingame, "MainControlPanelTochButton_C");
        if self.MainControlPanel ~= nil then
            local MainControlBaseUI = self.MainControlPanel.MainControlBaseUI;
            MainControlBaseUI.NavigatorPanel:SetVisibility(ESlateVisibility.Collapsed);
            MainControlBaseUI.SurviveInfoPanel:SetVisibility(ESlateVisibility.Collapsed);
            MainControlBaseUI.CanvasPanel_16:SetVisibility(ESlateVisibility.Collapsed);
        else
            UGCLog.Log("Error: BPCharacter_ProtectAthena:ReceiveBeginPlay MainControlPanel == nil!");
        end

        --UGCWidgetManagerSystem.GetMainControlUI():SetVisibility(ESlateVisibility.Collapsed)
    
    end
    --TuYang
    self:BindItemDelegate()
    self:TuYang_WeaponInitialize()
    Timer.InsertTimer(1,
    function() 
        local PlayerController = self:GetPlayerControllerSafety()
        if PlayerController then
            if PlayerController.PlayerBuffComponent then
                PlayerController.PlayerBuffComponent:InitializeBuff()
            end
        end
    end,
    false)

    

   

    self.OnDeath:AddInstance(self.OnSelfDeath,self)
    self.OnPlayerSwitchWeaponDelegate:Add(self.OnPlayerSwitchWeapon,self)
    ugcprint("[maoyu] BPCharacter_ProtectAthenaUGC_PlayerSwitchWeaponDelegate")

    
    if self:HasAuthority() then
        -- self.LastLocation = self:K2_GetActorLocation()
        -- for k, v in pairs(self.MoveSkillList) do
        --     v = self:K2_GetActorLocation()
        -- end
    end

    
        
    
    -- if not self:HasAuthority() then
    --     local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    --     local CoinPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/BPWidget_GameFight.BPWidget_GameFight_C')
    --     local CoinClass = UE.LoadClass(CoinPath)
    --     BPCharacter_ProtectAthena.Coin = UserWidget.NewWidgetObjectBP(PlayerController,CoinClass)
    --     if UE.IsValid(BPCharacter_ProtectAthena.Coin) then
    --         if BPCharacter_ProtectAthena.Coin:AddToViewport(0) then
    --         end
    --     end
    -- else
    --     self.PlayersNum = UGCGameSystem:GetPlayerNum(false)

    -- end

    
    --UGCLog.Log("Loc = ")
end


-- 接收伤害函数
function BPCharacter_ProtectAthena:BPReceiveDamage(Damage,DamageType,InstigatedBy,DamageCauser,DamageEventFlags)
    BPCharacter_ProtectAthena.SuperClass.BPReceiveDamage(self, Damage, DamageType, InstigatedBy, DamageCauser)
end


function BPCharacter_ProtectAthena:IsSkipSpawnDeadTombBox(EventInstigater)
    return true
end

function BPCharacter_ProtectAthena:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, Victim)
    --KismetSystemLibrary.PrintString(self, "BPCharacter_ProtectAthena:PreInstigatedDamage " .. tostring(self.DamageScaleValue) .. " " .. tostring(DamageAmount), true, true, LinearColor.New(1, 1, 1, 1), 15)

    return DamageAmount * self.DamageScaleValue
end




function BPCharacter_ProtectAthena:GetLocation()
    return self:K2_GetActorLocation()
end

function BPCharacter_ProtectAthena:AddEnemyCount()
    --self.PlayerState:AddEnemyCount()
    ugcprint("Enemy add count "..self.EnemyCount)
    self.EnemyCount = self.EnemyCount+1
   
end

function BPCharacter_ProtectAthena:GetEnemyCount()
    return self.PlayerState:GetEnemyCount()

end


function BPCharacter_ProtectAthena:AddInsectCount()
    self.PlayerState:AddInsectCount()
    -- ugcprint("insect add count "..self.InsectCount )
    -- self.InsectCount = self.InsectCount+1
end
function BPCharacter_ProtectAthena:SetInsectCount(num)
    self.PlayerState:SetInsectCount(num)
    -- ugcprint("insect add count "..self.InsectCount )
    -- self.InsectCount = num
end


function BPCharacter_ProtectAthena:GetTaskStage_Insect()
    return self.PlayerState:GetTaskStage_Insect()--self.TaskStage_Insect
end

function BPCharacter_ProtectAthena:AddTaskStage_Insect(num)
    self.PlayerState:AddTaskStage_Insect(num)
    --self.TaskStage_Insect =  self.TaskStage_Insect+num
end
function BPCharacter_ProtectAthena:SetTaskStage_Insect(num)
    self.PlayerState:SetTaskStage_Insect(num)
    --self.TaskStage_Insect =  num
end
function BPCharacter_ProtectAthena:SetTaskStage_XiaoQi(num)
    self.PlayerState:SetTaskStage_XiaoQi(num)
    --self.TaskStage_XiaoQi = num
end
function BPCharacter_ProtectAthena:GetTaskStage_XiaoQi()
    return self.PlayerState:GetTaskStage_XiaoQi()
end

function BPCharacter_ProtectAthena:ShowTaskTips(num)
    ugcprint("TaskButton show 2")
end --TaskButton
function BPCharacter_ProtectAthena:GetMainUI()
    if self.MainControlPanel then
        ugcprint("MainUi is true")
    else
        ugcprint("MainUi is nil")
    end
    return self.MainControlPanel
end

function BPCharacter_ProtectAthena:BindItemDelegate()
    self.BackPack = UGCBackPackSystem.GetBackpackComponent(self)
    if self.BackPack then
        self.BackPack.UGC_ItemOperationDelegate:Add(self.GetItem,self)
        ugcprint("BPCharacter_ProtectAthenaUGC_ItemOperationDelegate")
    end
    
end

function BPCharacter_ProtectAthena:GetItem(DefineID,OperationType,Reason)
    ugcprint("Item Get  ")
    self:TuYang_WeaponInitialize()
    --新技能重武器增加生命值
    local controller = UGCGameSystem.GetPlayerControllerByPlayerPawn(self)
    if controller then
        controller:CheckIsHeavyWeaponSetMaxHealth()
    end
end


function BPCharacter_ProtectAthena:TuYang_WeaponInitialize()
    local weapon1 = UGCWeaponManagerSystem.GetWeaponBySlot(self,ESurviveWeaponPropSlot.SWPS_MainShootWeapon1)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState 
    
    
    local weaponList = {}
    if weapon1 then
        local weapon1ID = weapon1:GetItemDefineID().TypeSpecificID 
        
        ugcprint("武器名称"..tostring(weapon1ID))
        table.insert(weaponList,weapon1ID)
        --ugcprint("Weapon id is"..weapon1:GetItemDefineID().TypeSpecificID)
        self:AddGunBuff(weapon1)
        self:AddEnableClipInfiniteBullets(weapon1)
        self:UpDatePlayerBuff_Gun(weapon1)

        --新技能
        if PlayerController then
            PlayerController:RestoreModifiedWeapon(weapon1)
        end
    end



    local weapon2 = UGCWeaponManagerSystem.GetWeaponBySlot(self,ESurviveWeaponPropSlot.SWPS_MainShootWeapon2)
    
    if weapon2 then
        local weapon2ID = weapon2:GetItemDefineID().TypeSpecificID 
        --PlayerState:AddGunBuff(weapon2ID,self,weapon2)
        --ugcprint("Weapon id is"..weapon2:GetItemDefineID().TypeSpecificID)
        table.insert(weaponList,weapon2ID)

        self:AddGunBuff(weapon2)
        self:AddEnableClipInfiniteBullets(weapon2)
        self:UpDatePlayerBuff_Gun(weapon2)

        --新技能
        if PlayerController then
            PlayerController:RestoreModifiedWeapon(weapon2)
        end
    end
    --self:OnPlayerSwitchWeapon()
end

function BPCharacter_ProtectAthena:RestoreModifiedWeapon()
    local weapon1 = UGCWeaponManagerSystem.GetWeaponBySlot(self,ESurviveWeaponPropSlot.SWPS_MainShootWeapon1)
    if weapon1 then
        --新技能
        self.Controller:RestoreModifiedWeapon(weapon1)
    end
    local weapon2 = UGCWeaponManagerSystem.GetWeaponBySlot(self,ESurviveWeaponPropSlot.SWPS_MainShootWeapon2)
    if weapon2 then
        --新技能
        self.Controller:RestoreModifiedWeapon(weapon2)
    end
end

-- 定制化武器属性
function BPCharacter_ProtectAthena:AddGunBuff(Gun)
    -- for _,GunBuf in pairs(self.GunBuff) do
    --     if GunBuf.id == Gun:GetItemDefineID().TypeSpecificID then
    --      local damage = UGCGunSystem.GetBulletBaseDamage(Gun)
	-- 	-- UGCGunSystem.SetBulletImpulse(weapon, 1000)
	-- 	UGCGunSystem.SetBulletBaseDamage(Gun, GunBuf.damage)
    --     end
    -- end
    --local tDam = TuYang_WeaponConfig:GetWeaponItems(TuYang_WeaponConfig.ItemKey.WeaponItemID,Gun:GetItemDefineID().TypeSpecificID).Damage
    local tItemID = Gun:GetItemDefineID().TypeSpecificID
    local tData = UGCGameSystem.GetTableDataByRowName(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/TuYang_WeaponConfig.TuYang_WeaponConfig'),tItemID)
    if tData then
        local tDam = tData.BulletBaseDamage
        local tShootInterval = tData.ShootIntervalTime
        -- UGCLog.Log("BPCharacter_ProtectAthena:AddGunBuff tDam = ",tDam)
        -- UGCLog.Log("BPCharacter_ProtectAthena:AddGunBuff tShootInterval = ",tShootInterval)
        UGCGunSystem.SetBulletBaseDamage(Gun, tDam)
        UGCGunSystem.SetShootIntervalTime(Gun,tShootInterval)
        UGCGunSystem.SetMaxBulletNumInOneClip(Gun,tData.MaxBulletNumInOneClip)
    else
        UGCLog.Log("BPCharacter_ProtectAthenaAddGunBuff tData is nil",tItemID)
    end
    
    -- local tShootInterval = UGCGunSystem.GetShootIntervalTime(Gun) * TuYang_WeaponConfig:GetWeaponItems(TuYang_WeaponConfig.ItemKey.WeaponItemID,Gun:GetItemDefineID().TypeSpecificID).ShootIntervalScale
    -- UGCLog.Log("BPCharacter_ProtectAthena:AddGunBuff tShootInterval = ",tShootInterval)
    -- UGCGunSystem.SetShootIntervalTime(Gun,tShootInterval)
end

function BPCharacter_ProtectAthena:AddEnableClipInfiniteBullets(Gun)
    UGCGunSystem.EnableClipInfiniteBullets(Gun, true)
end

function BPCharacter_ProtectAthena:UpDatePlayerBuff_Gun(InGun)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if PlayerController.PlayerBuffComponent then
        PlayerController.PlayerBuffComponent:UpDatePlayerBuff_Gun(InGun)
    end
end

--tuyang

BPCharacter_ProtectAthena.MoveSkillData = {
    Skill4_1 = { Check = false, Distance = 0, LastLocation = { X = 0, Y = 0, Z = 0 } },
    Skill4_2 = { Check = false, Distance = 0, LastLocation = { X = 0, Y = 0, Z = 0 } },
    Skill4_3 = { Check = false, Distance = 0, LastLocation = { X = 0, Y = 0, Z = 0 } },
    Skill4_4 = { Check = false, Distance = 0, LastLocation = { X = 0, Y = 0, Z = 0 } },
    Skill4_7 = { Check = false, Distance = 0, LastLocation = { X = 0, Y = 0, Z = 0 } },
    Skill4_9 = { Check = false, Distance = 0, LastLocation = { X = 0, Y = 0, Z = 0 }}
}

BPCharacter_ProtectAthena.StaySkillData = {
    Skill5_1 = { Check = false, StayStartTime  = 0 ,StayThreshold  = 3.0},
    Skill5_2 = { Check = false, StayStartTime  = 0 ,StayThreshold  = 1.0},
    Skill5_3 = { Check = false, StayStartTime  = 0 ,StayThreshold  = 2.0},
    Skill5_4 = { Check = false, StayStartTime  = 0 ,StayThreshold  = 3.0},
    Skill5_9 = { Check = false, StayStartTime  = 0 ,StayThreshold  = 4.0}
}

BPCharacter_ProtectAthena.Skill5_9Actor = nil

BPCharacter_ProtectAthena.LastHealthBonus = 0

function BPCharacter_ProtectAthena:AddPlayerBuff(InEnumBuff,InIsOpen)
    if self:HasAuthority() then
        UGCLog.Log("[ljh]CharacterAddPlayerBuff")
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        PlayerController.PlayerBuffComponent:SetPlayerBuff(InEnumBuff,InIsOpen)
    end
end 

-- 判断是否在移动
-- @return boolean true表示在移动，false表示不在移动
function BPCharacter_ProtectAthena:CheckIsMoving()
    local Velo = self:GetVelocity()
    local Dis = VectorHelper.Length(Velo)
    if Dis > 0 then
        return true
    end
    return false
end

-- 检查是否满足停留时间条件
function BPCharacter_ProtectAthena:CheckIsStayTimeEnough(InKey)
    --ugcprint("[maoyu]CheckIsStayTimeEnough: "..InKey)
    -- 参数有效性验证
    if not self.StaySkillData[InKey] then
        --ugcprint("[maoyu] Invalid skill key: "..InKey)
        return false
    end

    -- 技能Actor存在检测
    -- Skill5_2,Skill5_3不需要技能Actor存在检测
    if InKey ~= "Skill5_2" and InKey ~= "Skill5_3" and InKey ~= "Skill5_9" then
        if self.ActiveSkills and self.ActiveSkills[InKey] then
            UGCLog.Log("[maoyu]CheckIsStayTimeEnough 技能Actor存在 ")
            return false
        end
    end

    
    local skillData = self.StaySkillData[InKey]
    local currentTime = GameplayStatics.GetTimeSeconds(self) -- 使用服务器时间

    -- 新增逻辑：当技能检测首次激活且处于静止状态时立即初始化计时器
    if skillData.Check and not self:CheckIsMoving() and skillData.StayStartTime == 0 then
        skillData.StayStartTime = currentTime
        return false
    end
    
    if self:CheckIsMoving() then
        if InKey == "Skill5_9" then
            if self.ActiveSkills and self.ActiveSkills[InKey] then
                if self.Skill5_9Actor then
                    self.Skill5_9Actor:DestroyActor()
                end
                UGCLog.Log("[maoyu]CheckIsStayTimeEnough:Skill5_9Actor 销毁 ")
            end
        end

        if skillData.StayStartTime ~= -1 then
            --ugcprint("[maoyu] 移动状态重置计时器 - Key:"..InKey)
            skillData.StayStartTime = -1
        end
        return false
    end

    -- 初始化计时器
    if skillData.StayStartTime == -1 then
        skillData.StayStartTime = currentTime
        --ugcprint("[maoyu] 开始计时 Key:" ..InKey.. "需要" ..skillData.StayThreshold.. "秒")
        return false
    end

    -- 计算持续时间
    local duration = currentTime - skillData.StayStartTime
    local isReady = duration >= skillData.StayThreshold
    
    -- 调试输出
    -- if isReady then
    --     UGCLog.Log(string.format("[StaySkill] 条件达成 Key:%s | 持续%.1f秒", InKey, duration))
    -- end
    
    return isReady
end

-- 在技能生成时设置状态标记
function BPCharacter_ProtectAthena:OnSkillActorSpawned(InKey)
    if InKey == "Skill5_1" or InKey == "Skill5_4" or InKey == "Skill5_9" then
        self.ActiveSkills = self.ActiveSkills or {}
        self.ActiveSkills[InKey] = true
        UGCLog.Log("[maoyu] stay技能Actor生成 Key:",InKey)
    end
end

-- 在技能销毁时清除标记
function BPCharacter_ProtectAthena:OnSkillActorDestroyed(InKey)
    if self.ActiveSkills then
        self.ActiveSkills[InKey] = nil
    end
    UGCLog.Log("[maoyu] stay技能Actor销毁 Key:"..InKey)
end


-- 更新技能的移动距离
-- @param InSkillKey 技能的键值（如 "Skill4_1"）
function BPCharacter_ProtectAthena:UpdateMoveDistance(InSkillKey)
    local SkillData = self.MoveSkillData[InSkillKey]
    if not SkillData then
        UGCLog.Log("[maoyu Error] Invalid SkillKey: ", InSkillKey)
        return
    end
    --ugcprint("[maoyu]UpdateMoveDistance")
    local CurrentLocation = self:K2_GetActorLocation()
    local Distance = VectorHelper.GetDistance2D(SkillData.LastLocation, CurrentLocation)
    SkillData.Distance = SkillData.Distance + Distance
    SkillData.LastLocation = CurrentLocation
end

-- 检测移动距离是否足够
-- @param InDistance 需要移动的距离
-- @param InSkillKey 技能的键值（如 "Skill4_1"）
-- @return boolean true表示移动距离足够，false表示移动距离不足
function BPCharacter_ProtectAthena:CheckMoveDistanceEnough(InDistance,InSkillKey)
    --UGCLog.Log("[maoyu]CheckMoveDistanceEnough",InSkillKey)
    local SkillData = self.MoveSkillData[InSkillKey]
    if not SkillData then
        UGCLog.Log("[maoyu error] Invalid SkillKey: ", InSkillKey)
        return false
    end
    --UGCLog.Log("[maoyu]CheckMoveDistanceEnough",SkillData)

    if SkillData.Distance >= InDistance then
        SkillData.Distance = 0 -- 重置距离
        UGCLog.Log("[maoyu]CheckMoveDistanceEnough true")
        return true
    end
    --UGCLog.Log("[maoyu]CheckMoveDistanceEnough:distance = " ,SkillData.Distance)
    return false
end

-- 玩家死亡回调
-- @param BPCharacter_ProtectAthena 玩家角色
-- @param KillerController 杀死玩家的控制器
-- @param DamageCauseActor 造成伤害的Actor
-- @param HitResult 碰撞结果
-- @param HitImpulseDirection 碰撞冲击方向
-- @param DamageTypeID 伤害类型ID
-- @param bHeadShotDamage 是否为爆头伤害
function BPCharacter_ProtectAthena:OnSelfDeath(BPCharacter_ProtectAthena, KillerController, DamageCauseActor, HitResult, HitImpulseDirection, DamageTypeID, bHeadShotDamage)
    if UE.IsValid(self) then
        --死亡时退出车辆（战术增益）
        UGCVehicleSystem.ExitVehicle(self)

        --死亡时销毁技能Actor（新技能）
        self:OnSkillActorDestroyed("Skill5_1")
        self:OnSkillActorDestroyed("Skill5_4")
        self:OnSkillActorDestroyed("Skill5_9")
    end
end

-- 玩家切枪回调
function BPCharacter_ProtectAthena:OnPlayerSwitchWeapon()
    --ugcprint("[maoyu] OnPlayerSwitchWeapon")
    
    -- 通过PlayerState获取技能配置
    local PlayerState = self.PlayerState
    local controller = UGCGameSystem.GetPlayerControllerByPlayerPawn(self)

    if not PlayerState or not controller then
        UGCLog.Log("[maoyu] PlayerState is nil")
        return
    end

    controller:CheckIsHeavyWeaponSetMaxHealth()
    -- 遍历所有技能配置
    for skillKey, skillData in pairs(PlayerState.PersistSkillDamagesList) do
        if skillData.Handler and 
           controller.SkillInstanceList and 
           controller.SkillInstanceList[skillKey] 
        then
            local handler = controller[skillData.Handler]
            if handler and skillData.Handler ~= "SkillChangePlayerSpeed" and skillData.Handler ~= "SkillChangePlayerHealth" then
                handler(controller, skillKey)
            end
        end
    end
end


return BPCharacter_ProtectAthena