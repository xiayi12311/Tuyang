---@class BP_BGMManger_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BP_BGMManger = {}
 
local BGMPath = {
    UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMBoss_1.BGMBoss_1'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMBoss_1.BGMBoss_1'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMBoss_1.BGMBoss_1'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BGMBoss_1.BGMBoss_1'),
}
local CurrentBGM
--[[
function BP_BGMManger:ReceiveBeginPlay()
    BP_BGMManger.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BP_BGMManger:ReceiveTick(DeltaTime)
    BP_BGMManger.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_BGMManger:ReceiveEndPlay()
    BP_BGMManger.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BP_BGMManger:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_BGMManger:GetAvailableServerRPCs()
    return
end
--]]

function BP_BGMManger:PlayTargetBGM(InPlayerController,InBGMID)
    UGCLog.Log("BP_BGMMangerPlayTargetBGM",InBGMID)
    local PlayerController = InPlayerController
    if PlayerController then
        PlayerController:ClientRPC_PlaySound(InBGMID)
    end
    -- local path = UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/BGMBoss_1.BGMBoss_1"  
    -- local bgm = UE.LoadObject(path)
    -- local NewEvent = UGCSoundManagerSystem.PlaySound2D(bgm) 


   
end
return BP_BGMManger