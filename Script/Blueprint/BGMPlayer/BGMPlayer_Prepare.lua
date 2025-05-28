---@class BGMPlayer_Prepare_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_Prepare = {}
 
 
local bgm
local BGMID = 4;
BGMPlayer_Prepare.AKEventID = nil;
function BGMPlayer_Prepare:ReceiveBeginPlay()
    BGMPlayer_Prepare.SuperClass.ReceiveBeginPlay(self)
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/BGMPreparetofight_1.BGMPreparetofight_1"
	--UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMPreparetofight_1.BGMPreparetofight_1')
	bgm = UE.LoadObject(path)
end

--[[
function BGMPlayer_Prepare:ReceiveTick(DeltaTime)
    BGMPlayer_Prepare.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_Prepare:ReceiveEndPlay()
    BGMPlayer_Prepare.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_Prepare:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_Prepare:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_Prepare:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BGMPlayer_Prepare:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
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

function BGMPlayer_Prepare:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    -- if not self:HasAuthority() then 
    --     local PlayerController = OtherActor:GetPlayerControllerSafety()
    --     if PlayerController then
    --         local PlayerState = OtherActor.PlayerState
    --         local PlayingID = PlayerState:GetBGMID()
    --         if BGMID~=PlayingID then
    --             local AKEventID = PlayerState:GetAkEvent()
    --             if AKEventID then
    --                 UGCSoundManagerSystem.StopSoundByID(AKEventID)
    --             end
    --             local NewEvent = UGCSoundManagerSystem.PlaySound2D(bgm) 
    --             PlayerState:SetAkEvent(NewEvent)
    --             PlayerState:SetBGMID(BGMID)
    --         end
    --     end
    -- end
    -- return nil;
end

-- [Editor Generated Lua] function define End;

return BGMPlayer_Prepare