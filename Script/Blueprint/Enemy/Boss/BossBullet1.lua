---@class BossBullet_C:AActor
---@field Sphere USphereComponent
---@field ParticleSystem UParticleSystemComponent
---@field StaticMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BossBullet1 = {
    TLocation = {X=0,Y=0,Z=0} ,
    Target = nil,
    Move = {X=0,Y=0,Z=0} 
}
--BossBullet1.MoveFvector = nil
BossBullet1.Move = nil
BossBullet1.MoveRotator = nil;

local X_p
local alert
local ParticleSystem
function BossBullet1:ReceiveBeginPlay()
    BossBullet1.SuperClass.ReceiveBeginPlay(self)
    ugcprint("BossBullet1 start")
    self.MoveFvector= {X=1,Y=0,Z=0}
    X_p = -400;
    alert = 1;
    self.Move = self:K2_GetActorLocation();
    self.MoveRotator = self:K2_GetActorRotation();
    local Owner  =self:GetOwner();
    local controller = Owner:GetController();
    local MyBlack =  controller:GetBlackBoardComponent();--self:GetController();
    self.Target = MyBlack:GetValueAsObject("Target");
    self.TLocation = self.Target:GetLocation();
   
    self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self);
    --ParticleSystem = UGCParticleTools.ID2List()
    --local ParticlePath = UGCParticleTools.ID2List['Asset/Blueprint/Monster/WhiteJiJia/Skill/P_AH6_baozha_01.P_AH6_baozha_01']
    ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Effect/ExPlode.Explode_C'))
end



function BossBullet1:ReceiveTick(DeltaTime)
    BossBullet1.SuperClass.ReceiveTick(self, DeltaTime)

    self.TLocation = self.Target:GetLocation();
    ugcprint("BulletLocation is "  ..self.Move.Z)
    if self.Move.Z< 30 then
        ugcprint("<30 Destory")
        self:K2_DestroyActor()
    end
     if not self:HasAuthority() then
     
         local NewRotator = KismetMathLibrary.FindLookAtRotation(self.Move , self.TLocation)
        
         self.MoveRotator = KismetMathLibrary.RInterpTo(self.MoveRotator , NewRotator,  DeltaTime, 0.8)
         self:K2_SetActorRotation(self.MoveRotator)
       
         self.MoveFvector = KismetMathLibrary.Conv_RotatorToVector(self.MoveRotator)
         self.Move.X = self.Move.X + 0.0001*X_p*X_p*self.MoveFvector.X;
         self.Move.Y = self.Move.Y + 0.0001*X_p*X_p*self.MoveFvector.Y;
         self.Move.Z = self.Move.Z + 0.0001*X_p*X_p*self.MoveFvector.Z;
         X_p = X_p+alert;
     
     self:K2_SetActorRotation(self.MoveRotator)
     self:K2_SetActorLocation(self.Move)
     end
    --  local dis = self.TLocation -self.Move;
    --  ugcprint("distance is " ..dis.Length)
end



function BossBullet1:ReceiveEndPlay()
    BossBullet1.SuperClass.ReceiveEndPlay(self) 
    ugcprint("Bullet End Play")
    local BoolKey = UGCGameSystem.ApplyRadialDamage(30,30,self:K2_GetActorLocation(),500,500,0, EDamageType.RadialDamage,nil,nil,nil,ECollisionChannel.ECC_Visibility, 0);
    local Explode = ScriptGameplayStatics.SpawnActor(self,ParticleSystem,self:K2_GetActorLocation() ,self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    --STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self.TLocation,self:K2_GetActorRotation(),true);
   
end



function BossBullet1:GetReplicatedProperties()
    return
    "TLocation",
    "Target",
    "Move"
end


--[[
function BossBullet1:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BossBullet1:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BossBullet1:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    ugcprint("Bullet hit")
    --self:K2_DestroyActor()
	return nil;
end

-- [Editor Generated Lua] function define End;

return BossBullet1