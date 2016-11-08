local lizaunitframes = CreateFrame("Frame", "LizaUnitFrame")
lizaunitframes:RegisterEvent("PLAYER_LOGIN")
lizaunitframes:RegisterEvent("PLAYER_ENTERING_WORLD")

lizaunitframes:SetScript("OnEvent", function(...)

	--Class Icons instead of portraits... How it should be...
	hooksecurefunc("UnitFramePortrait_Update",function(self)
			if self.portrait then
					if UnitIsPlayer(self.unit) then                         
							local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
							if t then
									self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
									self.portrait:SetTexCoord(unpack(t))
							end
					else
							self.portrait:SetTexCoord(0,1,0,1)
					end
			end
	end)

	--Class Colour Behind Name
	local frame = CreateFrame("FRAME")
	frame:RegisterEvent("GROUP_ROSTER_UPDATE")
	frame:RegisterEvent("PLAYER_TARGET_CHANGED")
	frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
	frame:RegisterEvent("UNIT_FACTION")

	local function eventHandler(self, event, ...)
			if UnitIsPlayer("target") then
					c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
					TargetFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
			end
			if UnitIsPlayer("focus") then
					c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
					FocusFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
			end
	end

	frame:SetScript("OnEvent", eventHandler)

	for _, BarTextures in pairs({TargetFrameNameBackground, FocusFrameNameBackground}) do
			BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
	end

	--Fix HP Values
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
			PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")))
			PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))

			TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")))
			TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))

			FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")))
			FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))
	end)

	--Hide PVP Icon
	PlayerPVPIcon:SetAlpha(0)
	TargetFrameTextureFramePVPIcon:SetAlpha(0)
	FocusFrameTextureFramePVPIcon:SetAlpha(0)

	--Hide Reset Icon
	PlayerRestIcon:SetAlpha(0)

end)