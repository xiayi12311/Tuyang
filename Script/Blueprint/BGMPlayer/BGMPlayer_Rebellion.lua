---@class BGMPlayer_Rebellion_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BGMPlayer_Rebellion = {}
 
local bgm
local BGMID = 1;
BGMPlayer_Rebellion.AKEventID = nil;
function BGMPlayer_Rebellion:ReceiveBeginPlay()
    BGMPlayer_Rebellion.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	--self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Rebellion_of_Human_Civilization_1.Rebellion_of_Human_Civilization_1')
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMRebellion.BGMRebellion')
    bgm = UE.LoadObject(path)
end


--[[
function BGMPlayer_Rebellion:ReceiveTick(DeltaTime)
    BGMPlayer_Rebellion.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BGMPlayer_Rebellion:ReceiveEndPlay()
    BGMPlayer_Rebellion.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BGMPlayer_Rebellion:GetReplicatedProperties()
    return
end
--]]

--[[
function BGMPlayer_Rebellion:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function BGMPlayer_Rebellion:LuaInit()
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

function BGMPlayer_Rebellion:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    ugcprint("BGMPlayer BeginOverLap")
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

function BGMPlayer_Rebellion:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    -- ugcprint("BGMPlayer EndOverLap")
    -- local PlayerController = OtherActor:GetPlayerControllerSafety()
    -- if PlayerController then
    --     ugcprint("BGMPlayer EndSound")
    --     UGCSoundManagerSystem.StopAllSound()
    -- end

    return nil;
end

-- [Editor Generated Lua] function define End;

return BGMPlayer_Rebellion