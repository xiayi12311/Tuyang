---@class BP_TextGM_C:UUserWidget
---@field Button_AddGold UButton
---@field Button_Close UButton
---@field Button_Custom UButton
---@field Button_GiveItem UButton
---@field Button_GiveSkillBuff UButton
---@field Button_GM UButton
---@field Button_Suicide UButton
---@field CanvasPanel_GM UCanvasPanel
---@field EditableTextBox_GiveSkillBuff UEditableTextBox
---@field Score UEditableTextBox
---@field TextBlock_SaveData UTextBlock
--Edit Below--
local BP_TextGM = { bInitDoOnce = false } 
BP_TextGM.bIsOpen = false

function BP_TextGM:Construct()
    self.Button_GM.OnReleased:Add(
        function ()
            
            self:OpenAndCloseGMUI(not self.bIsOpen)
        end
    )
	self.Button_Close.OnReleased:Add(
        function ()
            self:OpenAndCloseGMUI(false)
        end
    )
    self.Button_AddGold.OnReleased:Add(
        function ()
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:ServerRPC_AddGoldNumber(10000000)
        end
    )
	self.Button_Suicide.OnReleased:Add(
        function ()
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:ServerRPC_Suicide()
        end
    )
    self.Button_GiveItem.OnReleased:Add(
        function ()
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            local Score = tonumber(self.Score.Text);
            UGCBackPackSystem.AddItem(PlayerController:GetPlayerCharacterSafety(), Score, 1)
        end
    )
    self.Button_Custom.OnReleased:Add(
        function ()
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:GM_SavePlayerData()
        end
    )
    self.Button_GiveSkillBuff.OnReleased:Add(
        function ()
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            local Score = tonumber(self.EditableTextBox_GiveSkillBuff.Text);
            PlayerController:ServerRPC_ClickBuffToSelect(Score)
        end
    )

end


function BP_TextGM:Tick(MyGeometry, InDeltaTime)
    local PlayerController = GameplayStatics.GetPlayerController(self,0)
    if UE.IsValid(PlayerController.Pawn) then
        local tData = PlayerController.Pawn.Health
        self.TextBlock_SaveData:SetText(tostring(tData))
    end
    
end

-- function BP_TextGM:Destruct()

-- end

function BP_TextGM:OpenAndCloseGMUI(InbOpen)
    self.bIsOpen = InbOpen
    if InbOpen then
        self.CanvasPanel_GM:SetVisibility(ESlateVisibility.Visible)
    else
        self.CanvasPanel_GM:SetVisibility(ESlateVisibility.Hidden)
    end
    
end
return BP_TextGM