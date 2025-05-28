---@class BP_SummomBossProjectile_C:BP_Projectile_C
--Edit Below--
local BP_Projectile = require("Script.BP_Projectile")
local BP_SummomBossProjectile = setmetatable({}, { __index = BP_Projectile, __metatable = BP_Projectile, })

return BP_SummomBossProjectile