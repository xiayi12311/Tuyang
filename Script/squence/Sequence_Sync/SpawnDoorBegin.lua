---@class SpawnDoorBegin_C:LevelSequenceActor
--Edit Below--
local SpawnFirstBoss = {}
 

function SpawnFirstBoss:ReceiveBeginPlay()
    SpawnFirstBoss.SuperClass.ReceiveBeginPlay(self)
    -- ugcprint("sequence beginplay")
    -- self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
    ugcprint("sequence beginplay")
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Captions/CarbinTridoor.CarbinTridoor_C')
    local UIClass =UE.LoadClass(path);
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local Captions = UserWidget.NewWidgetObjectBP(PlayerController,UIClass)
    Captions:AddToViewport(0) --Asset/UI/Captions/CarbinTridoor.CarbinTridoor_C

    
end


function SpawnFirstBoss:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
-- 	ugcprint("Boss Overlap!")

  
--     local AllController = UGCGameSystem.GetAllPlayerController()
--     for _,Controller in pairs(AllController) do
--         UnrealNetwork.CallUnrealRPC(PlayerController, PlayerController, "PlaySequence",PlayerController, self)
--     end
--     local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
--     function()    
--         ugcprint("Sequence End!")         --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/NPC/Oil.Oil_C')                      
--         self:K2_DestroyActor()
--     end)
-- -- KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 10, false)
-- 	return nil;
end

function SpawnFirstBoss:RPCPlaySequence()
    -- local SequencePlayer = self.SequencePlayer
	-- SequencePlayer:Play()
end
return SpawnFirstBoss