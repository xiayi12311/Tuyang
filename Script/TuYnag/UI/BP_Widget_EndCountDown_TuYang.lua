---@class BP_Widget_EndCountDown_TuYang_C:UUserWidget
---@field Anim UWidgetAnimation
---@field TextBlock_2 UTextBlock
--Edit Below--
local BP_Widget_EndCountDown_TuYang = { bInitDoOnce = false } 
local TimeCount = 10
local TimeSet = 0
local EndCoutTime = 0
local TeamID = 0
function BP_Widget_EndCountDown_TuYang:Construct()
	self:LuaInit();
   -- self.Anim.OnAnimationFinished:Add(self.AnimEnd,self)
	--self:PlayAnimation(self.Anim,0,1,EUMGSequencePlayMode.forward,0)
    ugcprint("BP_Widget_EndCountDown_TuYang Construct")
    local GameState  = UGCGameSystem.GetGameState()
    
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    TeamID = PlayerController.PlayerState.TeamID
    local PlayerState = PlayerController.PlayerState
    TimeCount = GameState.fFailCountDown
    TimeSet = 0
    --self.Button_1.OnReleased:Add(self)
    --self.Button_1.OnReleased:Add(self.Respawn, self)
    self:PlayAnimation(self.Anim,0,0,EUMGSequencePlayMode.Forward,1)
    self.TextBlock_2:SetText(""..TimeCount)
 
end




function BP_Widget_EndCountDown_TuYang:Tick(MyGeometry, InDeltaTime)
    -- TimeSet = InDeltaTime +TimeSet;
    -- if TimeSet>=1 then
    --     TimeCount = TimeCount-1
    --     TimeSet = TimeSet-1
    --     local GameState  = UGCGameSystem.GetGameState()
    --     EndCoutTime = GameState.GetFailCountDownTime(TeamID)
        
    --     self.TextBlock_2:SetText(""..EndCoutTime)
    --     if TimeCount<=0 then
    --         ugcprint("Slow Respawn")
    --         --local PlayerController = GameplayStatics.GetPlayerController(self, 0)
           
    --         self:RemoveFromViewport()
    --     end
    -- end
    local GameState  = UGCGameSystem.GetGameState()
    EndCoutTime = GameState:GetFailCountDownTime(TeamID)
    self.TextBlock_2:SetText(""..EndCoutTime)
end

-- function BP_Widget_EndCountDown_TuYang:Destruct()

-- end
-- [Editor Generated Lua] function define Begin:
function BP_Widget_EndCountDown_TuYang:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	-- [Editor Generated Lua] BindingEvent End;
end

function BP_Widget_EndCountDown_TuYang:TextBlock_2_Text(ReturnValue)
	return "";
end

-- [Editor Generated Lua] function define End;

return BP_Widget_EndCountDown_TuYang