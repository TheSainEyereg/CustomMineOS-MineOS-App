----------------------------------------core---------------------------------------------------
local GUI = require("GUI")
local system = require("System")
local fs = require("Filesystem")
local SD = fs.path(system.getCurrentScript())
local internet = require("internet")
local component = require("Component")
local localization = system.getLocalization(SD .. "/Localizations/")
local EFI = component.eeprom

local workspace, window, menu = system.addWindow(GUI.filledWindow(1, 1, 70, 20, 0x000000))
local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))

-----------------------------------functions---------------------------------------------------
local function flashEFI(url)
	internet.download(url, "/temp.lua")
	local a = fs.read("/temp.lua")
	EFI.set(a)
	EFI.setLabel("Custom MineOS")
	fs.remove("/temp.lua")
end

local function replaceloader(url)
	internet.download(url, "/replace.lua")
	fs.remove("/OS.lua")
	fs.rename("/replace.lua", "/OS.lua")
end

local function addText(text)
	layout:addChild(GUI.textBox(1, 1, 50, 1, nil, 0xFEFEFE, {text}, 1, 0, 0, true, true))
end

local function addButton(text)
return layout:addChild(GUI.roundedButton(1, 1, 36, 3, 0x2E2E2E, 0x919191, 0x5C5C5C, 0xF0F0F0, text))
end

-------------------------------------------main------------------------------------------------
addText(localization.warn)
addButton(localization.inst).onTouch = function()
	flashEFI("https://raw.githubusercontent.com/TheSainEyereg/CustomMineOS-MineOS-App/master/Custom/CustomEFI.lua")
	replaceloader("https://raw.githubusercontent.com/TheSainEyereg/CustomMineOS-MineOS-App/master/Custom/OS.lua")
	GUI.alert(localization.comp)
    computer.shutdown(true)
end

----------------------------------------------------------------------------------------------------

window.onResize = function(newWidth, newHeight)
  window.backgroundPanel.width, window.backgroundPanel.height = newWidth, newHeight
  layout.width, layout.height = newWidth, newHeight
end
