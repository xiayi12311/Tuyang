


local Action_PlayerLogin = {}

Action_PlayerLogin.PlayerKey = 0




--function Action_PlayerLogin:GetBPWidget_ShopEntryClassPath()
--   return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_ShopEntry.BPWidget_ShopEntry_C']], UGCMapInfoLib.GetRootLongPackagePath())
--end 



function Action_PlayerLogin:Execute() --(PlayerController, PlayerKey)
	sandbox.LogNormalDev(StringFormat_Dev("[Action_PlayerLogin:Execute] self=%s", GetObjectFullName_Dev(self)))

    local PlayerKey = self.PlayerKey
    UGCLog.Log("Action_PlayerLogin:Execute PlayerKey=%s", PlayerKey)
    local PlayerController = nil
    PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
    local PlayerPawn = UGCGameSystem.GetPlayerPawnByPlayerKey(self.PlayerKey)
    PlayerPawn:BindItemDelegate()
	
    local WaitForPlayerThen = function ()
        local GameState = GameplayStatics.GetGameState(self)
        if GameState.GameStatus == "WaitForPlayer" then
            GameState.GameStatus = "GameReady"
            GameState.GameStatusChangedDelegate(GameState)
           
        end
        local PlayerController = nil
        PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
        UGCLog.Log("正常加入流程")
        PlayerController:PlayerLogin()
        
    end
    local GameState = GameplayStatics.GetGameState(self)
    if GameState.GameStatus == "WaitForPlayer" or GameState.GameStatus == "GameReady" then
        WaitForPlayerThen()
    else
       
    end
    if GameState:HasAuthority() then
        local Name =UGCPlayerStateSystem.GetPlayerAccountInfo(self.PlayerKey).PlayerName
        local tUID = UGCPlayerStateSystem.GetPlayerAccountInfo(self.PlayerKey).UID
        GameState:AddCurrentPlayerData(tUID,self.PlayerKey,Name)
    end
    return true
end

function Action_PlayerLogin:Update(DeltaSeconds)
   
end

return Action_PlayerLogin