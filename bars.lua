-- Create a frame to listen for events:
local dbars = CreateFrame("Frame", "LizaBarsFrame")
dbars:SetFrameStrata("BACKGROUND")
dbars:SetWidth(346)
dbars:SetHeight(30)
dbars:SetPoint("CENTER", UIParent, "BOTTOM", 0, 0)
dbars:Show()

-- Register the events to listen for:
dbars:RegisterEvent("PLAYER_LOGIN")
dbars:RegisterEvent("PLAYER_ENTERING_WORLD")
dbars:RegisterEvent("ADDON_LOADED")
dbars:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
dbars:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
dbars:RegisterEvent("UPDATE_STEALTH")
dbars:RegisterEvent("PET_BATTLE_OVER")

-- Define this list once, instead of creating a new
-- table every time an event fires:
local MicroButtons = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	GuildMicroButton,
	PVPMicroButton,
	LFDMicroButton,
	EJMicroButton,
	CompanionsMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
}

-- Set the function to be run when the frame receives
-- an event it's listening for:
dbars:SetScript("OnEvent", function(self, event, ...)
	-- If you're in combat, stop here:
	if InCombatLockdown() then return end
	-- Only run the rest if you're not in combat:

	--Hide Gryphoons - Ugly
	MainMenuBarLeftEndCap:Hide()
	MainMenuBarRightEndCap:Hide()

	--Hide Background Textures - Ugly
	MainMenuBarTexture0:Hide()
	MainMenuBarTexture1:Hide()
	MainMenuBarTexture2:Hide()
	MainMenuBarTexture3:Hide()
	
	--HidePaging Options
	MainMenuBarPageNumber:Hide()
	ActionBarUpButton:Hide()
	ActionBarDownButton:Hide()        

	--Hide Primary XP 
	MainMenuExpBar:SetAlpha(1)	
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("BOTTOM",UIParent,0, -3)
	MainMenuExpBar:SetScale(.5)
	
	ReputationWatchBar:SetAlpha(0)	
	
	ArtifactWatchBar:SetAlpha(1)
	ArtifactWatchBar:ClearAllPoints()
	ArtifactWatchBar:SetPoint("BOTTOM",UIParent,0,-3)
	ArtifactWatchBar:SetScale(.5)
	

	--Hide Secondary XP Bars
	MainMenuMaxLevelBar0:Hide()
	MainMenuMaxLevelBar1:Hide()
	MainMenuMaxLevelBar2:Hide()
	MainMenuMaxLevelBar3:Hide()
	
	--Hide/Move Bags (uncomment top line to show main backpack (counter))
	MainMenuBarBackpackButton:Hide()
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("LEFT", ActionButton1, "RIGHT", 360, 1)
	MainMenuBarBackpackButton:SetScale(1.3)
		
	--Hide Equipped Bags
	CharacterBag0Slot:Hide()
	CharacterBag1Slot:Hide()
	CharacterBag2Slot:Hide()
	CharacterBag3Slot:Hide()

	--Stance bars
	StanceBarLeft:Hide()
	StanceBarMiddle:Hide()
	StanceBarRight:Hide()

	--Main Bars
	MainMenuBar:SetScale(0.75)
	MainMenuBar:SetFrameStrata("BACKGROUND")
	
	-- Points, width of bars is 346 set at top, divide by 2 for 173.
	-- Set center center then -x by width/2.		
	-- UI Also counts from top of button, not bottom, so Y Value needs to be > than size of button. 
	-- Plus 1/2 width of button itself (55ish - I can't math)
	ActionButton1:ClearAllPoints()
	ActionButton1:SetPoint("CENTER", dbars, "BOTTOM", -228, 55)

	--Stagger Bars, position in relation to AB1
	MultiBarBottomLeftButton1:ClearAllPoints()
	MultiBarBottomLeftButton1:SetPoint("BOTTOM", ActionButton1, "TOP", 0, 6)

	-- Stagger Bars, position in relation to MBBL
	MultiBarBottomRightButton1:ClearAllPoints()
	MultiBarBottomRightButton1:SetPoint("BOTTOM", MultiBarBottomLeftButton1, "TOP", 0, 6)

	--Micro Menu Buttons
	local function showMicroMenu(self)
	 for _, v in ipairs(MICRO_BUTTONS) do
	 _G[v]:SetAlpha(1)
	 end
	end

	local function hideMicroMenu(self)
	 for _, v in ipairs(MICRO_BUTTONS) do
	 _G[v]:SetAlpha(0)
	 end
	end

	for _, v in ipairs(MICRO_BUTTONS) do
	 v = _G[v]
	 v:SetScript("OnEnter", showMicroMenu)
	 v:SetScript("OnLeave", hideMicroMenu)
	 v:SetAlpha(0)
	end
	
	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("CENTER",ActionButton1, "LEFT",-280, 10)

	--Left/Right Bars
	MultiBarRight:SetScale(1.0)

	-- Set Up In Relation to AB1B1
	MultiBarLeftButton1:ClearAllPoints()
	MultiBarLeftButton1:SetPoint("LEFT", ActionButton1, "RIGHT", 1491, 180)
	MultiBarLeftButton1:SetPoint("LEFT", ActionButton1, "RIGHT", 1370, 270)
	MultiBarLeftButton5:ClearAllPoints()
	MultiBarLeftButton5:SetPoint("LEFT", MultiBarLeftButton1, "RIGHT", 4, 0)
	MultiBarLeftButton9:ClearAllPoints()
	MultiBarLeftButton9:SetPoint("LEFT", MultiBarLeftButton5, "RIGHT", 4, 0)

	MultiBarRightButton1:ClearAllPoints() -- Position off of MBLB1 - Same X pos as bar coded above
	MultiBarRightButton1:SetPoint("LEFT", MultiBarLeftButton1, "LEFT", 0, 170)
	MultiBarRightButton5:ClearAllPoints()
	MultiBarRightButton5:SetPoint("LEFT", MultiBarRightButton1, "RIGHT", 4, 0)
	MultiBarRightButton9:ClearAllPoints()
	MultiBarRightButton9:SetPoint("LEFT", MultiBarRightButton5, "RIGHT", 4, 0)

	--Stance/Shapeshift bars
	StanceButton1:ClearAllPoints()
	StanceButton1:SetPoint("BOTTOM", MultiBarBottomRightButton1, "TOP", -4, 6)

	--Pet Action Bars
	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("BOTTOM", MultiBarBottomRightButton1, "TOP", -4, 6)
end)