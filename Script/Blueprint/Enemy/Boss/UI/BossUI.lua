---@class BossUI_C:UUserWidget
---@field Image_Background UImage
---@field ProgressBar_23 UProgressBar
--Edit Below--
local EventSystem =  require('Script.common.UGCEventSystem')
local BossUI = { bInitDoOnce = false } 


function BossUI:Construct()
	self:LuaInit();
	EventSystem:AddListener("BossUI",self.SetPercent,self)
end


-- function BossUI:Tick(MyGeometry, InDeltaTime)

-- end

-- function BossUI:Destruct()

-- end

-- [Editor Generated Lua] function define Begin:
function BossUI:LuaInit()
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

function BossUI:ProgressBar_23_Percent(ReturnValue)
	return ReturnValue;
end

-- [Editor Generated Lua] function define End;
function BossUI:SetPercent(health)
    self.ProgressBar_23:SetPercent(health)
end
return BossUI