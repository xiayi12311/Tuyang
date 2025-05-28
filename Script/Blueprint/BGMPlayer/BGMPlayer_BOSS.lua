---@class BGMPlayer_BOSS_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_BOSS = {}
 
 
local bgm
local BGMID = 3;
BGMPlayer_BOSS.AKEventID = nil;
function BGMPlayer_BOSS:ReceiveBeginPlay()
    BGMPlayer_BOSS.SuperClass.ReceiveBeginPlay(self)
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/BGMBoss_1.BGMBoss_1"  
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMBoss_2.BGMBoss_2')
	bgm = UE.LoadObject(path)
end

--[[
function BGMPlayer_BOSS:ReceiveTick(DeltaTime)
    BGMPlayer_BOSS.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_BOSS:ReceiveEndPlay()
    BGMPlayer_BOSS.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_BOSS:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_BOSS:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_BOSS:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BGMPlayer_BOSS:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if not self:HasAuthority() then 
        local PlayerController = OtherActor:GetPlayerControllerSafety()
        if PlayerController then
            local PlayerState = OtherActor.PlayerState
            local PlayingID = PlayerState:GetBGMID()
            if BGMID~=PlayingID then
                local AKEventID = PlayerState:GetAkEvent()
                if AKEventID then
                    UGCSoundManagerSystem.StopSoundByID(AKEventID)
                end
                local NewEvent = UGCSoundManagerSystem.PlaySound2D(bgm) 
                PlayerState:SetAkEvent(NewEvent)
                PlayerState:SetBGMID(BGMID)
            end
        end
    end
    return nil;
end

function BGMPlayer_BOSS:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	local PlayerController = OtherActor:GetPlayerControllerSafety()
    if PlayerController then
       -- UGCSoundManagerSystem.StopAllSound()
        --UGCSoundManagerSystem.StopSoundByID(self.AkEventID)
    end
    return nil;
end

-- [Editor Generated Lua] function define End;

return BGMPlayer_BOSS