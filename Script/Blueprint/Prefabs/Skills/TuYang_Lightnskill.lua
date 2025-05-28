---@class TuYang_Lightnskill_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_Lightnskill = {}
 
function TuYang_Lightnskill:OnEnableSkill_BP()
    TuYang_Lightnskill.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_Lightnskill:OnDisableSkill_BP()
    TuYang_Lightnskill.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_Lightnskill:OnActivateSkill_BP()
    TuYang_Lightnskill.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_Lightnskill:OnDeActivateSkill_BP()
    TuYang_Lightnskill.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_Lightnskill:CanActivateSkill_BP()
    return TuYang_Lightnskill.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_Lightnskill:LunchProj()
    -- local params = UE.LoadClass('/Script/ShadowTrackerExtra.ProjectileParams')
    -- params.Speed = 1000.0
    -- params.GravityScale = 0
    -- params.Direction = self:GetNetOwnerActor()
    -- params.Target = nil
    -- params.GeneralCampID = 0
    -- params.DamageValueWrapper.Value = 1000.0
    -- local ProjectileClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Projectiles/TuYang_FireCDRedSkillProj_A_3_2.TuYang_FireCDRedSkillProj_A_3_2_C'))
    -- UGCGameSystem.SpawnActor(
    --                 self,
    --                 ProjectileClass,
    --                 self:GetNetOwnerActor():K2_GetActorLocation(),
    --                 {Pitch=0,Yaw=0,Roll=0},
    --                 {1,1,1},
    --                 self:GetNetOwnerActor()
    --             )

    ugcprint("[maoyu] TuYang_Lightnskill:LunchProj")

    --local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self:GetNetOwnerActor())

    -- 添加空值检查确保角色存在
    local ownerActor = self:GetNetOwnerActor()
    if not ownerActor then
        ugcprint("[Error] OwnerActor is nil!")
        return
    end

   

    -- local StartLoc = self:GetNetOwnerActor():K2_GetActorLocation()
    -- local EndLoc = KismetMathLibrary.Add_VectorVector(KismetMathLibrary.Multiply_VectorFloat(KismetMathLibrary.GetForwardVector(self:GetNetOwnerActor():GetInstigatorController().ControlRotation), 10000) , StartLoc)

    --local MuzzleLocation,MuzzleRotation,MuzzleScale = KismetMathLibrary.BreakTransform(weapon:GetMuzzleTransform()) 

    --local Ratator = weapon:GetWeapomAngledSightRotator()

    --local controlRotation = self:GetNetOwnerActor():GetInstigatorController().ControlRotation

    -- --controlRotation.Roll = 0
    -- --controlRotation.Pitch = 0

    local forwardVector = self:GetNetOwnerActor():GetInstigatorController():GetActorForwardVector()

    -- -- 修改向量运算方式，使用Unreal数学库方法
    --local ScaledVector = KismetMathLibrary.Multiply_VectorFloat(forwardVector, 10000)
    --local EndLocation = KismetMathLibrary.Add_VectorVector(MuzzleLocation, ScaledVector)

    --local Rotation = KismetMathLibrary.FindLookAtRotation(StartLoc, EndLoc)

    --Rotation.Roll = 0
    --Rotation.Pitch = 0

    --local Direction = KismetMathLibrary.Subtract_VectorVector(EndLocation, MuzzleLocation)

    --self:SetSelectDirection(forwardVector)
    --Direction.Y = 0
    self:SetSelectDirection(forwardVector)
    
end

return TuYang_Lightnskill