---@class BGMPlayer_club_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_club = {}
local bgm
local BGMID = 7;
BGMPlayer_club.AKEventID = nil; 

function BGMPlayer_club:ReceiveBeginPlay()
    BGMPlayer_club.SuperClass.ReceiveBeginPlay(self)
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/BGMclub_1.BGMclub_1"
	--UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMclub_1.BGMclub_1')
	bgm = UE.LoadObject(path)
end
 
--[[
function BGMPlayer_club:ReceiveBeginPlay()
    BGMPlayer_club.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BGMPlayer_club:ReceiveTick(DeltaTime)
    BGMPlayer_club.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_club:ReceiveEndPlay()
    BGMPlayer_club.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_club:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_club:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_club:LuaInit()
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

function BGMPlayer_club:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
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

function BGMPlayer_club:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	return nil;
end

-- [Editor Generated Lua] function define End;

return BGMPlayer_club