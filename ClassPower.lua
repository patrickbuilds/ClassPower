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

local class, classID = select(2, UnitClass("player"))
local color = RAID_CLASS_COLORS[class]

local text = cpFrame:CreateFontString(nil, "OVERLAY")

text:SetFont("Interface\\AddOns\\ClassPower\\Fonts\\MUNIRG__.TTF", 16)
text:SetTextColor(color.r, color.g, color.b, 1)
text:SetPoint("CENTER", 0, 0)

cpFrame:RegisterEvent("UNIT_POWER")

local function UpdateText(self, event)
	if classID == 2 then
		displayText = UnitPower("player", 9)

	elseif classID == 6 then
		local numReady = 0
		for runeSlot = 1,6 do
			local start, duration, runeReady = GetRuneCooldown(runeSlot)
			if (runeReady) then
				numReady = numReady + 1
			end
		end
		displayText = numReady

	elseif classID == 4 then
		displayText = GetComboPoints("player", "target")

	elseif classID == 10 then
		displayText = UnitPower("player", 12)

	elseif classID == 8  then
		displayText = UnitPower("player", 16)

	elseif classID == 11 then
		displayText = GetComboPoints("player", "target")

	elseif classID == 9 then
		displayText = UnitPower("player", 7)

 	end

	text:SetText(displayText)
end

cpFrame:SetScript("OnEvent", UpdateText)
