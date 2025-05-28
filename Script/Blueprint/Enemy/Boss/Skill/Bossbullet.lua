---@class Bossbullet_C:UGC_BFS_BulletBall_C
--Edit Below--
local Bossbullet = {
    TLocation = {X=0,Y=0,Z=0} ,
    Target = nil
}
Bossbullet.MoveFvector = nil
Bossbullet.Move = nil
Bossbullet.MoveRotator = nil;

local X_p
local alert
local ParticleSystem
function Bossbullet:ReceiveBeginPlay()
    Bossbullet.SuperClass.ReceiveBeginPlay(self)
    ugcprint("BossBullet start")
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
    self.Capsule.OnComponentBeginOverlap:Add(self.Capsule_OnComponentBeginOverlap, self);
    self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self);
    ParticleSystem = UE.LoadObject(
        UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Monster/WhiteJiJia/Skill/P_AH6_baozha_01.P_AH6_baozha_01'))
end



function Bossbullet:ReceiveTick(DeltaTime)
    Bossbullet.SuperClass.ReceiveTick(self, DeltaTime)

    self.TLocation = self.Target:GetLocation();
  
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
end



function Bossbullet:ReceiveEndPlay()
    Bossbullet.SuperClass.ReceiveEndPlay(self) 
    ugcprint("Bullet End Play")
    local BoolKey = UGCGameSystem.ApplyRadialDamage(30,30,self:K2_GetActorLocation(),500,500,0, EDamageType.RadialDamage,nil,nil,nil,ECollisionChannel.ECC_Visibility, 0);
    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
   
end



function Bossbullet:GetReplicatedProperties()
    return
    "TLocation",
    "Target"
end


--[[
function BossBullet:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function Bossbullet:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self);
	self.Capsule.OnComponentBeginOverlap:Add(self.Capsule_OnComponentBeginOverlap, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function Bossbullet:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    ugcprint("Bullet hit")

    --self:K2_DestroyActor()
	return nil;
end

function Bossbullet:Capsule_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Bullet hit c")
    return nil;
end

-- [Editor Generated Lua] function define End;

return Bossbullet