local dcore = CreateFrame("Frame", "LizaCoreFrame")
dcore:RegisterEvent("PLAYER_LOGIN")

dcore:SetScript("OnEvent", function(...)

	--Set up Vars
	LizaTable = {
		version = "1.2",
		supported = "70000",
		autorepair = "true"
	}
	
	--Loaded Addon
	print("Loaded LizaUI", LizaTable.version)

	--Autosell Crap and Auto Repair
	local g = CreateFrame("Frame")
	g:RegisterEvent("MERCHANT_SHOW")

	
	g:SetScript("OnEvent", function()  
			local bag, slot
			for bag = 0, 4 do
					for slot = 0, GetContainerNumSlots(bag) do
							local link = GetContainerItemLink(bag, slot)
							if link and (select(3, GetItemInfo(link)) == 0) then
									UseContainerItem(bag, slot)
							end
					end
			end

			if(CanMerchantRepair()) then
					local cost = GetRepairAllCost()
					if cost > 0 then
							local money = GetMoney()
							if IsInGuild() then
									local guildMoney = GetGuildBankWithdrawMoney()
									if guildMoney > GetGuildBankMoney() then
											guildMoney = GetGuildBankMoney()
									end
									if guildMoney > cost and CanGuildBankRepair() then
											RepairAllItems(1)
											print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
											return
									end
							end
							if money > cost then
									RepairAllItems()
									print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
							else
									print("Not enough gold to cover the repair cost.")
							end
					end
			end
	end)
	

	--Fix the fucking map
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript('onmousewheel', function(self, delta)
			if delta > 0 then
					Minimap_ZoomIn()
					Minimap_ZoomIn()
			else
					Minimap_ZoomOut()
			end
	end)
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetPoint("TOPRIGHT", -26, 7)

	--Turn off Shitty Cast Bar - Utilising Quartz.
	--CastingBarFrame:UnregisterAllEvents()
	
	--Turn off Shitty Garrison Bar
	local b = OrderHallCommandBar
	b:UnregisterAllEvents()
	b:SetScript("OnShow", b.Hide)
	b:Hide()

	UIParent:UnregisterEvent("UNIT_AURA")
	
--End
end)