NpcBots.InitLocale()
local i18n = NpcBots.I18n

-- Create the Main frame
local frame = CreateFrame("Frame", "NpcbotsFrame", UIParent)
frame:SetSize(200, 250)
frame:SetPoint("CENTER", UIParent, "CENTER")

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", frame, "TOP", 0, -10)
title:SetText(i18n("NpcBots - NPCBOT Addon"))

-- Set the background color and transparency for MainFrame "Frame"
frame:SetBackdrop({
  bgFile = "Interface/Buttons/WHITE8X8",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true, tileSize = 16, edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
frame:SetBackdropColor(0.35, 0.14, 0.73, 0.25)
frame:SetBackdropBorderColor(0.53, 0.07, 0.89, 1)

-- Make the frame movable
frame:SetMovable(true)
frame:EnableMouse(true)

-- Create the adminFrame
local adminFrame = CreateFrame("Frame", "NpcbotsAdminFrame", UIParent)
adminFrame:SetSize(200, 200)
adminFrame:SetPoint("RIGHT", frame, "LEFT", -10, 0)
adminFrame:SetBackdrop({
  bgFile = "Interface/Tooltips/UI-Tooltip-Background",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true, tileSize = 16, edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
adminFrame:SetBackdropColor(1, 0, 0, 0.2)
adminFrame:SetBackdropBorderColor(0, 1, 0, 1)
adminFrame:Hide()

local adminTitle = adminFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
adminTitle:SetPoint("TOP", adminFrame, "TOP", 0, -10)
adminTitle:SetText(i18n("Admin"))



-- Handle frame movement
frame:SetScript("OnMouseDown", function(self, button)
  if button == "LeftButton" then
    self:StartMoving()
  end
end)

-- Stop frame movement
frame:SetScript("OnMouseUp", function(self, button)
  if button == "LeftButton" then
    self:StopMovingOrSizing()
  end
end)



-- Create the buttons
-- Your addon's namespace and variables
local NpcBots = {}
NpcbotsDB = {}  -- Your saved variables table

-- Create a function to set and save the scale
local function SetAndSaveScale(scale)
  frame:SetScale(scale)
  NpcbotsDB.scale = scale
end

-- Add UI scale buttons
local increaseScaleButton = CreateFrame("Button", "NpcbotsIncreaseScaleButton", frame)
increaseScaleButton:SetSize(20, 20)
increaseScaleButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
increaseScaleButton:SetNormalFontObject("GameFontNormal")
local increaseButtonText = increaseScaleButton:CreateFontString(nil, "OVERLAY")
increaseButtonText:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
increaseButtonText:SetText("")
increaseButtonText:SetPoint("CENTER", 0, 0)
increaseButtonText:SetTextColor(1, 1, 0)
increaseScaleButton:RegisterForClicks("LeftButtonUp")
increaseScaleButton:SetScript("OnClick", function()
  local currentScale = frame:GetScale()
  local newScale = currentScale + 0.1
  SetAndSaveScale(newScale)
end)

local decreaseScaleButton = CreateFrame("Button", "NpcbotsDecreaseScaleButton", frame)
decreaseScaleButton:SetSize(20, 20)
decreaseScaleButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
decreaseScaleButton:SetNormalFontObject("GameFontNormal")
local decreaseButtonText = decreaseScaleButton:CreateFontString(nil, "OVERLAY")
decreaseButtonText:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
decreaseButtonText:SetText("")
decreaseButtonText:SetPoint("CENTER", 0, 0)
decreaseButtonText:SetTextColor(1, 1, 0)
decreaseScaleButton:RegisterForClicks("LeftButtonUp")
decreaseScaleButton:SetScript("OnClick", function()
  local currentScale = frame:GetScale()
  local newScale = currentScale - 0.1
  SetAndSaveScale(newScale)
end)

-- Event handler for addon loading
local function OnAddonLoaded(self, event, addonName)
  if addonName == "NpcBots" then
    -- Check if the scale is saved in the saved variables
    if NpcbotsDB and NpcbotsDB.scale then
      frame:SetScale(NpcbotsDB.scale)
    end
  end
end

local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript("OnEvent", OnAddonLoaded)



-- Add texture to the increase button
local increaseTexture = increaseScaleButton:CreateTexture(nil, "BACKGROUND")
increaseTexture:SetTexture("Interface\\Icons\\spell_chargepositive")
increaseTexture:SetAllPoints()
increaseScaleButton:SetNormalTexture(increaseTexture)
-- Add texture to the decrease button
local decreaseTexture = decreaseScaleButton:CreateTexture(nil, "BACKGROUND")
decreaseTexture:SetTexture("Interface\\Icons\\spell_chargenegative")
decreaseTexture:SetAllPoints()
decreaseScaleButton:SetNormalTexture(decreaseTexture)



-- Follow Button
local followButton = CreateFrame("Button", "NpcbotsFollowButton", frame, "ActionButtonTemplate")
followButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -35)
followButton:SetSize(42, 42)
local followButtonText = followButton:CreateFontString(nil, "OVERLAY")
followButtonText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE") -- Use the "OUTLINE" flag for text outline
followButtonText:SetText("Follow")
followButtonText:SetPoint("CENTER", 0, 0)
followButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local followTexture = followButton:CreateTexture(nil, "BACKGROUND")
followTexture:SetTexture("Interface\\Icons\\Ability_Tracking")
followTexture:SetAllPoints()
followButton:SetNormalTexture(followTexture)

local followpushedTexture = followButton:CreateTexture(nil, "BACKGROUND")
followpushedTexture:SetTexture("Interface\\Icons\\Ability_Tracking")
followpushedTexture:SetAllPoints()
followButton:SetPushedTexture(followpushedTexture)

-- StandStill Button
local standstillButton = CreateFrame("Button", "NpcbotsStandstillButton", frame, "ActionButtonTemplate")
standstillButton:SetPoint("LEFT", followButton, "RIGHT", 5, 0)
standstillButton:SetSize(42, 42)
local standstillButtonText = standstillButton:CreateFontString(nil, "OVERLAY")
standstillButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
standstillButtonText:SetText("Stand")
standstillButtonText:SetPoint("CENTER", 0, 0)
standstillButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local standstillTexture = standstillButton:CreateTexture(nil, "BACKGROUND")
standstillTexture:SetTexture("Interface\\Icons\\Inv_misc_map_01")
standstillTexture:SetAllPoints()
standstillButton:SetNormalTexture(standstillTexture)

local standstillpushedTexture = standstillButton:CreateTexture(nil, "BACKGROUND")
standstillpushedTexture:SetTexture("Interface\\Icons\\Inv_misc_map_01")
standstillpushedTexture:SetAllPoints()
standstillButton:SetPushedTexture(standstillpushedTexture)

--FullStop Button
local fullstopButton = CreateFrame("Button", "NpcbotsfullstopButton", frame, "ActionButtonTemplate")
fullstopButton:SetPoint("LEFT", standstillButton, "RIGHT", 5, 0)
fullstopButton:SetSize(42, 42)
local fullstopButtonText = fullstopButton:CreateFontString(nil, "OVERLAY")
fullstopButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
fullstopButtonText:SetText("Stop")
fullstopButtonText:SetPoint("CENTER", 0, 0)
fullstopButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local fullstopTexture = fullstopButton:CreateTexture(nil, "BACKGROUND")
fullstopTexture:SetTexture("Interface\\Icons\\Spell_chargenegative")
fullstopTexture:SetAllPoints()
fullstopButton:SetNormalTexture(fullstopTexture)

local fullstoppushedTexture = fullstopButton:CreateTexture(nil, "BACKGROUND")
fullstoppushedTexture:SetTexture("Interface\\Icons\\Spell_chargenegative")
fullstoppushedTexture:SetAllPoints()
fullstopButton:SetPushedTexture(fullstoppushedTexture)

-- Slack Button
local followOnlyButton = CreateFrame("Button", "NpcbotsFollowOnlyButton", frame, "ActionButtonTemplate")
followOnlyButton:SetPoint("LEFT", fullstopButton, "RIGHT", 5, 0)
followOnlyButton:SetSize(42, 42)
local followOnlyButtonText = followOnlyButton:CreateFontString(nil, "OVERLAY")
followOnlyButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
followOnlyButtonText:SetText("Slack")
followOnlyButtonText:SetPoint("CENTER", 0, 0)
followOnlyButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local followOnlyTexture = followOnlyButton:CreateTexture(nil, "BACKGROUND")
followOnlyTexture:SetTexture("Interface\\Icons\\Spell_Nature_Sleep")
followOnlyTexture:SetAllPoints()
followOnlyButton:SetNormalTexture(followOnlyTexture)

local followOnlyPushedTexture = followOnlyButton:CreateTexture(nil, "BACKGROUND")
followOnlyPushedTexture:SetTexture("Interface\\Icons\\Spell_Nature_Sleep")
followOnlyPushedTexture:SetAllPoints()
followOnlyButton:SetPushedTexture(followOnlyPushedTexture)

-- Show Button
local ShowNPCButton = CreateFrame("Button", "NpcbotsShow3Button", frame, "ActionButtonTemplate")
ShowNPCButton:SetPoint("TOPLEFT", followButton, "BOTTOMLEFT", 0, -5)
ShowNPCButton:SetSize(42, 42)
local ShowButtonText = ShowNPCButton:CreateFontString(nil, "OVERLAY")
ShowButtonText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE") -- Use the "OUTLINE" flag for text outline
ShowButtonText:SetText("UnHide")
ShowButtonText:SetPoint("CENTER", 0, 0)
ShowButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local ShowNPCTexture = ShowNPCButton:CreateTexture(nil, "BACKGROUND")
ShowNPCTexture:SetTexture("Interface\\Icons\\ability_hunter_beastcall")
ShowNPCTexture:SetAllPoints()
ShowNPCButton:SetNormalTexture(ShowNPCTexture)

local ShowNPCpushedTexture = ShowNPCButton:CreateTexture(nil, "BACKGROUND")
ShowNPCpushedTexture:SetTexture("Interface\\Icons\\ability_hunter_beastcall")
ShowNPCpushedTexture:SetAllPoints()
ShowNPCButton:SetPushedTexture(ShowNPCpushedTexture)

-- Hide Button
local HideNPCButton = CreateFrame("Button", "NpcbotsShow3Button", frame, "ActionButtonTemplate")
HideNPCButton:SetPoint("LEFT", ShowNPCButton, "RIGHT", 5, 0)
HideNPCButton:SetSize(42, 42)
local HideButtonText = HideNPCButton:CreateFontString(nil, "OVERLAY")
HideButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
HideButtonText:SetText("Hide")
HideButtonText:SetPoint("CENTER", 0, 0)
HideButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local HideNPCTexture = HideNPCButton:CreateTexture(nil, "BACKGROUND")
HideNPCTexture:SetTexture("Interface\\Icons\\ability_stealth")
HideNPCTexture:SetAllPoints()
HideNPCButton:SetNormalTexture(HideNPCTexture)

local HideNPCpushedTexture = HideNPCButton:CreateTexture(nil, "BACKGROUND")
HideNPCpushedTexture:SetTexture("Interface\\Icons\\ability_stealth")
HideNPCpushedTexture:SetAllPoints()
HideNPCButton:SetPushedTexture(HideNPCpushedTexture)



-- Summon Button
local SummonNPCButton = CreateFrame("Button", "NpcbotsShow3Button", frame, "ActionButtonTemplate")
SummonNPCButton:SetPoint("LEFT", HideNPCButton, "RIGHT", 5, 0)
SummonNPCButton:SetSize(42, 42)
local SummonButtonText = SummonNPCButton:CreateFontString(nil, "OVERLAY")
SummonButtonText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE") -- Use the "OUTLINE" flag for text outline
SummonButtonText:SetText("Summon")
SummonButtonText:SetPoint("CENTER", 0, 0)
SummonButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local SummonNPCTexture = SummonNPCButton:CreateTexture(nil, "BACKGROUND")
SummonNPCTexture:SetTexture("Interface\\Icons\\Inv_misc_rune_01")
SummonNPCTexture:SetAllPoints()
SummonNPCButton:SetNormalTexture(SummonNPCTexture)

local SummonNPCpushedTexture = SummonNPCButton:CreateTexture(nil, "BACKGROUND")
SummonNPCpushedTexture:SetTexture("Interface\\Icons\\Inv_misc_rune_01")
SummonNPCpushedTexture:SetAllPoints()
SummonNPCButton:SetPushedTexture(SummonNPCpushedTexture)

-- Unbind Button
local unbindButton = CreateFrame("Button", "NpcbotsUnbindButton", frame, "ActionButtonTemplate")
unbindButton:SetPoint("LEFT", SummonNPCButton, "RIGHT", 5, 0)  -- Positioning it to the right of the S button
unbindButton:SetSize(42, 42)
local unbindButtonText = unbindButton:CreateFontString(nil, "OVERLAY")
unbindButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
unbindButtonText:SetText("Unbind")
unbindButtonText:SetPoint("CENTER", 0, 0)
unbindButtonText:SetTextColor(1, 1, 0)

local unbindTexture = unbindButton:CreateTexture(nil, "BACKGROUND")
unbindTexture:SetTexture("Interface\\Icons\\INV_Misc_Key_14") -- Example texture, change as needed
unbindTexture:SetAllPoints()
unbindButton:SetNormalTexture(unbindTexture)

local unbindPushedTexture = unbindButton:CreateTexture(nil, "BACKGROUND")
unbindPushedTexture:SetTexture("Interface\\Icons\\INV_Misc_Key_14") -- Example texture, change as needed
unbindPushedTexture:SetAllPoints()
unbindButton:SetPushedTexture(unbindPushedTexture)

-- Unbind Button Function
unbindButton:SetScript("OnClick", function()
    SendChatMessage(".npcbot command unbind", "SAY")
end)

local distanceLabel = standstillButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
distanceLabel:SetPoint("BOTTOM", standstillButton, "BOTTOM", 25, -65)
distanceLabel:SetText(i18n("Follow Distance:"))

-- Distance1 Button
local distance1Button = CreateFrame("Button", "Npcbotsdistance1Button", frame, "ActionButtonTemplate")
distance1Button:SetPoint("TOPLEFT", followButton, "BOTTOMLEFT", 10, -70)
distance1Button:SetSize(50, 25)
local distance1ButtonText = distance1Button:CreateFontString(nil, "OVERLAY")
distance1ButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
distance1ButtonText:SetText(i18n("Low"))
distance1ButtonText:SetPoint("CENTER", 0, 0)
distance1ButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local distance1Texture = distance1Button:CreateTexture(nil, "BACKGROUND")
distance1Texture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
distance1Texture:SetAllPoints()
distance1Button:SetNormalTexture(distance1Texture)
local distance1pushedTexture = distance1Button:CreateTexture(nil, "BACKGROUND")
distance1pushedTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
distance1pushedTexture:SetAllPoints()
distance1Button:SetPushedTexture(distance1pushedTexture)

-- Distance2 Button
local distance2Button = CreateFrame("Button", "Npcbotsdistance2Button", frame, "ActionButtonTemplate")
distance2Button:SetPoint("LEFT", distance1Button, "RIGHT", 5, 0)
distance2Button:SetSize(50, 30)
local distance2ButtonText = distance2Button:CreateFontString(nil, "OVERLAY")
distance2ButtonText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE") -- Use the "OUTLINE" flag for text outline
distance2ButtonText:SetText(i18n("Medium"))
distance2ButtonText:SetPoint("CENTER", 0, 0)
distance2ButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local distance2Texture = distance2Button:CreateTexture(nil, "BACKGROUND")
distance2Texture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
distance2Texture:SetAllPoints()
distance2Button:SetNormalTexture(distance2Texture)
local distance2pushedTexture = distance2Button:CreateTexture(nil, "BACKGROUND")
distance2pushedTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
distance2pushedTexture:SetAllPoints()
distance2Button:SetPushedTexture(distance2pushedTexture)

-- Distance3 Button
local distance3Button = CreateFrame("Button", "Npcbotsdistance3Button", frame, "ActionButtonTemplate")
distance3Button:SetPoint("LEFT", distance2Button, "RIGHT", 5, 0)
distance3Button:SetSize(50, 30)
local distance3ButtonText = distance3Button:CreateFontString(nil, "OVERLAY")
distance3ButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
distance3ButtonText:SetText(i18n("High"))
distance3ButtonText:SetPoint("CENTER", 0, 0)
distance3ButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local distance3Texture = distance3Button:CreateTexture(nil, "BACKGROUND")
distance3Texture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
distance3Texture:SetAllPoints()
distance3Button:SetNormalTexture(distance3Texture)
local distance3pushedTexture = distance3Button:CreateTexture(nil, "BACKGROUND")
distance3pushedTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
distance3pushedTexture:SetAllPoints()
distance3Button:SetPushedTexture(distance3pushedTexture)

-- Attack Distance Label
local attackDistanceLabel = standstillButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
attackDistanceLabel:SetPoint("BOTTOM", distanceLabel, "BOTTOM", 0, -50)
attackDistanceLabel:SetText(i18n("Attack Distance:"))

-- Attack Distance Short Button
local attackDistanceShortButton = CreateFrame("Button", "NpcbotsAttackDistanceShortButton", frame, "ActionButtonTemplate")
attackDistanceShortButton:SetPoint("TOPLEFT", distance1Button, "BOTTOMLEFT", 0, -25)
attackDistanceShortButton:SetSize(50, 25)
local attackDistanceShortButtonText = attackDistanceShortButton:CreateFontString(nil, "OVERLAY")
attackDistanceShortButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
attackDistanceShortButtonText:SetText(i18n("Short"))
attackDistanceShortButtonText:SetPoint("CENTER", 0, 0)
attackDistanceShortButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local attackDistanceShortTexture = attackDistanceShortButton:CreateTexture(nil, "BACKGROUND")
attackDistanceShortTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
attackDistanceShortTexture:SetAllPoints()
attackDistanceShortButton:SetNormalTexture(attackDistanceShortTexture)
local attackDistanceShortPushedTexture = attackDistanceShortButton:CreateTexture(nil, "BACKGROUND")
attackDistanceShortPushedTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
attackDistanceShortPushedTexture:SetAllPoints()
attackDistanceShortButton:SetPushedTexture(attackDistanceShortPushedTexture)

-- Attack Distance Medium Button
local attackDistanceMediumButton = CreateFrame("Button", "NpcbotsAttackDistanceMediumButton", frame, "ActionButtonTemplate")
attackDistanceMediumButton:SetPoint("LEFT", attackDistanceShortButton, "RIGHT", 5, 0)
attackDistanceMediumButton:SetSize(50, 25)
local attackDistanceMediumButtonText = attackDistanceMediumButton:CreateFontString(nil, "OVERLAY")
attackDistanceMediumButtonText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE") -- Use the "OUTLINE" flag for text outline
attackDistanceMediumButtonText:SetText(i18n("Medium"))
attackDistanceMediumButtonText:SetPoint("CENTER", 0, 0)
attackDistanceMediumButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local attackDistanceMediumTexture = attackDistanceMediumButton:CreateTexture(nil, "BACKGROUND")
attackDistanceMediumTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
attackDistanceMediumTexture:SetAllPoints()
attackDistanceMediumButton:SetNormalTexture(attackDistanceMediumTexture)
local attackDistanceMediumPushedTexture = attackDistanceMediumButton:CreateTexture(nil, "BACKGROUND")
attackDistanceMediumPushedTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
attackDistanceMediumPushedTexture:SetAllPoints()
attackDistanceMediumButton:SetPushedTexture(attackDistanceMediumPushedTexture)

-- Attack Distance Long Button
local attackDistanceLongButton = CreateFrame("Button", "NpcbotsAttackDistanceLongButton", frame, "ActionButtonTemplate")
attackDistanceLongButton:SetPoint("LEFT", attackDistanceMediumButton, "RIGHT", 5, 0)
attackDistanceLongButton:SetSize(50, 25)
local attackDistanceLongButtonText = attackDistanceLongButton:CreateFontString(nil, "OVERLAY")
attackDistanceLongButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE") -- Use the "OUTLINE" flag for text outline
attackDistanceLongButtonText:SetText(i18n("Long"))
attackDistanceLongButtonText:SetPoint("CENTER", 0, 0)
attackDistanceLongButtonText:SetTextColor(1, 1, 0) -- Set text color (yellow in this case)

local attackDistanceLongTexture = attackDistanceLongButton:CreateTexture(nil, "BACKGROUND")
attackDistanceLongTexture:SetTexture("Interface\\Icons\\Inv_misc_punchcards_red")
attackDistanceLongTexture:SetAllPoints()
attackDistanceLongButton:Setend)
