---@class BGMPlayer_PV_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_PV = {}
 
local bgm
local BGMID = 2;
BGMPlayer_PV.AKEventID = nil;
function BGMPlayer_PV:ReceiveBeginPlay()
    BGMPlayer_PV.SuperClass.ReceiveBeginPlay(self)
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/PV_2.PV_2"
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/PV_1.PV_1')
	bgm = UE.LoadObject(path)
    if not self:HasAuthority() then 
            local PlayerStates = UGCGameSystem.GetAllPlayerState()
            for _,PlayerState in pairs(PlayerStates) do
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
end
--[[
function BGMPlayer_PV:ReceiveTick(DeltaTime)
    BGMPlayer_PV.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_PV:ReceiveEndPlay()
    BGMPlayer_PV.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_PV:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_PV:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_PV:LuaInit()
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

function BGMPlayer_PV:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if not self:HasAuthority() then 
        local PlayerController = OtherActor:GetPlayerControllerSafety()
        if PlayerController then
            local PlayerState = OtherActor.PlayerState
            local PlayingID = PlayerState:GetBGMID()
            if PlayingID then
                ugcprint("Playing id! "..PlayingID)
            end
            ugcprint("BGM id! "..BGMID)
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

-- function BGMPlayer_PV:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
-- 	local PlayerController = OtherActor:GetPlayerControllerSafety()
--     if PlayerController then
--         UGCSoundManagerSystem.StopAllSound()
--         --UGCSoundManagerSystem.StopSoundByID(self.AkEventID)
--     end
--     return nil;
-- end

-- [Editor Generated Lua] function define End;

return BGMPlayer_PV