---@class TestPercent_C:UUserWidget
---@field ProgressBar_145 UProgressBar
--Edit Below--
local TestPercent = { bInitDoOnce = false } 
local EventSystem = require("Script.Common.UGCEventSystem")

function TestPercent:Construct()
	self:LuaInit();
	EventSystem:AddListener("RefershHot",self.RefershHotHandle,self)
	
end


function TestPercent:Tick()
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	if not PlayerController.PlayerState.InIce then
		self.ProgressBar_145:SetVisibility(ESlateVisibility.Collapsed)
	else
		self.ProgressBar_145:SetVisibility(ESlateVisibility.Visible)
	end

end


-- function TestPercent:Destruct()

-- end

-- [Editor Generated Lua] function define Begin:
function TestPercent:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	-- [Editor Generated Lua] BindingEvent End;
end



function TestPercent:RefershHotHandle(hot)
	self.ProgressBar_145:SetPercent(tostring(hot))
	
end



-- [Editor Generated Lua] function define End;

return TestPercent