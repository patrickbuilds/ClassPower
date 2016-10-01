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

local text = cpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local pointCharacter = 'X'
local depletedCharacter = 'x'

text:SetFont("Interface\\AddOns\\ClassPower\\Fonts\\MUNIRG__.TTF", 16)
text:SetTextColor(color.r, color.g, color.b, 1)
text:SetPoint("CENTER", 0, 0)

cpFrame:RegisterEvent("UNIT_POWER")

local function repeats(s, n)
	return n > 0 and s .. repeats(s, n-1) or ""
end

local function UpdateText(self, event)
	if classID == 2 then
		pointCount = UnitPower("player", 9)
		maxPoints = 5

	elseif classID == 6 then
		local numReady = 0
		for runeSlot = 1,6 do
			local start, duration, runeReady = GetRuneCooldown(runeSlot)
			if (runeReady) then
				numReady = numReady + 1
			end
		end
		pointCount = numReady
		maxPoints = 6

	elseif classID == 4 then
		pointCount = GetComboPoints("player", "target")
		maxPoints = UnitPowerMax("player", 4)

	elseif classID == 10 then
		pointCount = UnitPower("player", 12)
		maxPoints = UnitPowerMax("player", 12)

	elseif classID == 8  then
		pointCount = UnitPower("player", 16)
		maxPoints = 4

	elseif classID == 11 then
		pointCount = GetComboPoints("player", "target")
		maxPoints = UnitPowerMax("player", 4)

	elseif classID == 9 then
		pointCount = UnitPower("player", 7)
		maxPoints = UnitPowerMax("player", 7)

 	end

	leftOver = maxPoints - pointCount

	active = repeats(pointCharacter, pointCount)
	depleted = repeats(depletedCharacter, leftOver)

	text:SetText(active..depleted)
end

cpFrame:SetScript("OnEvent", UpdateText)
