---@class BGMPlayer_Teslab_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_Teslab = {}
 
local bgm
local BGMID = 6;
BGMPlayer_Teslab.AKEventID = nil; 

function BGMPlayer_Teslab:ReceiveBeginPlay()
    BGMPlayer_Teslab.SuperClass.ReceiveBeginPlay(self)
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/BGMteslabattle2d_1.BGMteslabattle2d_1"
	--UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMteslabattle2d_1.BGMteslabattle2d_1')
	bgm = UE.LoadObject(path)
end


--[[
function BGMPlayer_Teslab:ReceiveTick(DeltaTime)
    BGMPlayer_Teslab.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_Teslab:ReceiveEndPlay()
    BGMPlayer_Teslab.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_Teslab:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_Teslab:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_Teslab:LuaInit()
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

function BGMPlayer_Teslab:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
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

function BGMPlayer_Teslab:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	return nil;
end

-- [Editor Generated Lua] function define End;

return BGMPlayer_Teslab