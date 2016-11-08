local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:SetScript("OnEvent", function(self,event,...) 

--print("Liza fixed your camera.")

-- Fix the fucking Camera.
	SetCVar("cameraDistanceMaxFactor", 2.6)

end)