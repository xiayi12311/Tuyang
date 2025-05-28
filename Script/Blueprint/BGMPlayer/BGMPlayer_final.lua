---@class BGMPlayer_final_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_final = {}
local bgm
local BGMID = 8;
BGMPlayer_final.AKEventID = nil; 

function BGMPlayer_final:ReceiveBeginPlay()
    BGMPlayer_final.SuperClass.ReceiveBeginPlay(self)
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/BGMfinal_1.BGMfinal_1"
	--UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMfinal_2.BGMfinal_2')
	bgm = UE.LoadObject(path)
end
  
--[[
function BGMPlayer_final:ReceiveBeginPlay()
    BGMPlayer_final.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BGMPlayer_final:ReceiveTick(DeltaTime)
    BGMPlayer_final.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_final:ReceiveEndPlay()
    BGMPlayer_final.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_final:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_final:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_final:LuaInit()
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

function BGMPlayer_final:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
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

function BGMPlayer_final:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	return nil;
end

-- [Editor Generated Lua] function define End;

return BGMPlayer_final