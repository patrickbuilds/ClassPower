local ADDON, ClassPower = ...

local cpFrame = CreateFrame("Frame", "cpFrame")

cpFrame:SetPoint("CENTER", 0, 0)
cpFrame:SetWidth(100)
cpFrame:SetHeight(22)
cpFrame:EnableMouse(true)
cpFrame:SetMovable(true)
cpFrame:SetUserPlaced(true)
cpFrame:RegisterForDrag("LeftButton")

cpFrame:SetScript("OnDragStart", function(self)
	if IsShiftKeyDown() then
		self:StartMoving()
	end
end)

cpFrame:SetScript("OnDragStop", function(self)
	cpFrame:StopMovingOrSizing()
end)

local classDisplayName, class, classID = UnitClass("player")
local color = RAID_CLASS_COLORS[class]

local text = cpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

text:SetTextColor(color.r, color.g, color.b, 1)
text:SetPoint("CENTER", 0, 0)

cpFrame:RegisterEvent("UNIT_POWER")

local function UpdateText(self, event)
	if class == "PALADIN" then
		displayText = UnitPower("player", SPELL_POWER_HOLY_POWER)
	elseif class == "DEATHKNIGHT" then
		local numReady = 0
		for runeSlot=1,6 do
			local start, duration, runeReady = GetRuneCooldown(runeSlot)
			if (runeReady) then
				numReady = numReady + 1
			end
		end
		displayText = numReady
	elseif class == "ROGUE" then
		displayText = GetComboPoints("player", "target")

		-- TODO: mage, warlock, monk, wtfever other classes utilize "points"
 	end

	text:SetText(displayText)
end

cpFrame:SetScript("OnEvent", UpdateText)
