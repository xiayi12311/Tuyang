---@class BP_PayLockComponent_C:ActorComponent
--Edit Below--
local BP_PayLockComponent = {}
 
BP_PayLockComponent.PayLockBinaryDigit = 0x00000000 
BP_PayLockComponent.LockList = 
{
    [1] = {Key = "M134",CommodityID = 1003 , Rank = 1}, -- 加特林
    [2] = {Key = "Monster5",CommodityID = 1004 , Rank = 2}, -- 大Boss
    [3] = {Key = "Groza",CommodityID = 1005 , Rank = 3}, -- GROZA
    [4] = {Key = "M200",CommodityID = 1007 , Rank = 4}, -- M200
    [5] = {Key = "46",CommodityID = 1008,Rank = 5}, -- 火龙卷
    -- [4] = {Key = "Monster2",Rank = 4}, -- 普通怪
    -- [5] = {Key = "Monster1",Rank = 5}, -- 小兵
}
function BP_PayLockComponent:ReceiveBeginPlay()
    BP_PayLockComponent.SuperClass.ReceiveBeginPlay(self)  
   
    -- -- 测试
    -- local num = 10 -- 二进制: 1010
    -- local N = 2
    -- if self:isBitSet(num, N) then
    --     print("第 " .. N .. " 位是 1")
    -- else
    --     print("第 " .. N .. " 位是 0")
    -- end
end


--[[
function BP_PayLockComponent:ReceiveTick(DeltaTime)
    BP_PayLockComponent.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_PayLockComponent:ReceiveEndPlay()
    BP_PayLockComponent.SuperClass.ReceiveEndPlay(self) 
end
--]]


function BP_PayLockComponent:GetReplicatedProperties()
    return "PayLockBinaryDigit"
end


--[[
function BP_PayLockComponent:GetAvailableServerRPCs()
    return
end
--]]
function BP_PayLockComponent:OnRep_PayLockBinaryDigit()
    local PlayerController = self:GetOwner()
    if PlayerController then
        PlayerController:OnPayLockChange()
    end
end
-- 判断二进制数 num 的第 N 位是否为 1
function BP_PayLockComponent:isBitSet(num, N)
    return (num & (1 << (N - 1))) ~= 0
end

-- 将二进制数num 的第 N 位为 1
function BP_PayLockComponent:SetPayLockBinary(num, N)
    return (num | (1 << (N - 1)))
end

function BP_PayLockComponent:GetRank(InKey)
    --UGCLog.Log("[YYH]BP_PayLockComponentGetRank InKey",InKey)
    for k, v in pairs(self.LockList) do
        if type(InKey) == "string" then
            --UGCLog.Log("[YYH]BP_PayLockComponentGetRank InKey type string")
            if v.Key == InKey then
                return v.Rank
            end
        elseif type(InKey) == "number" then
            --UGCLog.Log("[YYH]BP_PayLockComponentGetRank InKey type number")
           if v.CommodityID == InKey then
                return v.Rank
           end
        else
            --UGCLog.Log("[YYH]BP_PayLockComponentGetRank InKey type error")
            return 0
        end
        -- if v.Key == InKey or v.CommodityID == InKey then
        --     return v.Rank
        -- end
    end
    return 0
end
-- 解锁-true 锁定-false
function BP_PayLockComponent:CheckUnlocked(InKey)
    local tRank = self:GetRank(InKey)
    if tRank == 0 then
        --UGCLog.Log("[YYH]BP_PayLockComponentCheckUnlocked tRank == 0")
        return true
    end
    return self:isBitSet(self.PayLockBinaryDigit,tRank)
end

function BP_PayLockComponent:UpDataPayLockBinaryDigit(InCommodityID)
    UGCLog.Log("[YYH]BP_PayLockComponentUpDataPayLockBinaryDigit",InCommodityID)
    local tRank = self:GetRank(InCommodityID)
    if tRank == 0 then
        UGCLog.Log("[YYH]BP_PayLockComponentUpDataPayLockBinaryDigit tRank == 0")
        return
    end
    if not self:isBitSet(self.PayLockBinaryDigit,tRank) then
        self.PayLockBinaryDigit = self:SetPayLockBinary(self.PayLockBinaryDigit,tRank)
    end
    --self:PrintBinary()
end
local function toBinaryString(num)
    local binary = ""
    while num > 0 do
        local bit = num % 2
        binary = bit .. binary
        num = math.floor(num / 2)
    end
    return binary == "" and "0" or binary
end
-- 测试打印二进制
function BP_PayLockComponent:PrintBinary()
    print("当前 PayLockBinaryDigit 值: " .. self.PayLockBinaryDigit) -- 打印十进制值
    local binaryString = toBinaryString(self.PayLockBinaryDigit)
    print("二进制表示: " .. binaryString)
end

return BP_PayLockComponent