---@class BFS_C:STExtraSimpleCharacter
---@field SkeletalMesh USkeletalMeshComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field Sphere USphereComponent
--Edit Below--
local BFS = {}
local time;
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
BFS.gold = 100

function BFS:ReceiveBeginPlay()
    BFS.SuperClass.ReceiveBeginPlay(self)
    time = math.random(0,100);
	self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end



function BFS:ReceiveTick(DeltaTime)
    BFS.SuperClass.ReceiveTick(self, DeltaTime)
    local health = UGCSimpleCharacterSystem.GetHealth(self);
	if health>0 then
		time = time + 2*DeltaTime;

		local number = 200*math.sin(time)

		self.Sphere:K2_SetRelativeLocation({X = 0,Y = 0,Z = number+200},1)
		
    end
	local controller = self:GetController();
	local MyBlack = controller:GetBlackBoardComponent();
	local MyTarget = MyBlack:GetValueAsObject("Target");
	local Targetlo = MyTarget:K2_GetActorLocation();
	local LookRo = KismetMathLibrary.FindLookAtRotation(self:K2_GetActorLocation(),Targetlo)
	self:K2_SetActorRotation(LookRo);
end

function  BFS:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)
    end
end

function  BFS:ReceiveEndPlay()
    if not self:HasAuthority() then
        return
    end

    local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 5)

    local location = self:K2_GetActorLocation()
    if location.Z < 0 then
        location.Z = 0
    end
    UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)

end


--[[
function BFS:ReceiveEndPlay()
    BFS.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BFS:GetReplicatedProperties()
    return
end
--]]

--[[
function BFS:GetAvailableServerRPCs()
    return
end
--]]

return BFS