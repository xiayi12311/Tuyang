---@class TankUI_C:UUserWidget
---@field Image_Background UImage
---@field ProgressBar_23 UProgressBar
--Edit Below--
local EventSystem =  require('Script.common.UGCEventSystem')
local TankUI = { bInitDoOnce = false } 


function TankUI:Construct()
	self:LuaInit();
	EventSystem:AddListener("TankUI",self.SetPercent,self)
	ugcprint("Start UI")
end


-- function TankUI:Tick(MyGeometry, InDeltaTime)

-- end

-- function TankUI:Destruct()

-- end

-- [Editor Generated Lua] function define Begin:
function TankUI:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	self.ProgressBar_23:BindingProperty("Percent", self.ProgressBar_23_Percent, self);
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	-- [Editor Generated Lua] BindingEvent End;
end

function TankUI:ProgressBar_23_Percent(ReturnValue)
	return ReturnValue;
end

-- [Editor Generated Lua] function define End;
function TankUI:SetPercent(health)
    self.ProgressBar_23:SetPercent(health)
	if health ==0 then
		self:RemoveFromViewport()
		ugcprint("UI destory self")
	end
end
return TankUI