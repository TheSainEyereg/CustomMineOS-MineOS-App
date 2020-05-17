----------------------------------------core---------------------------------------------------
local GUI = require("GUI")
local system = require("System")
local fs = require("Filesystem")
local internet = require("internet")
local component = require("Component")
local localization = system.getLocalization(SD .. "/Localizations/")
local EFI = component.eeprom

-----------------------------------functions---------------------------------------------------
local function flashEFI(url)
	internet.download(url, "/temp.lua")
	local a = fs.read("/temp.lua")
	EFI.set(a)
	fs.remove("/temp.lua")
end

local function replaceloader(url)
	internet.download(url, "/replace.lua")
	fs.remove("/OS.lua")
	fs.rename("/replace.lua", "/OS.lua")
end

local function Text(txt)
	layout:addChild(GUI.text(1, 1, 0x2D2D2D, txt))
end

local function Button(txt)
return layout:addChild(GUI.roundedButton(1, 1, 36, 3, 0xD2D2D2, 0x696969, 0x4B4B4B, 0xF0F0F0, txt))
end

-------------------------------------------main------------------------------------------------

local workspace, window = system.addWindow(GUI.tabbedWindow(1, 1, 118, 33, 0xF0F0F0))
 
local layout = window:addChild(GUI.layout(1, 3, window.width, window.height, 1, 1))

Text(localization.warn)
Button(localization.inst).onTouch = function()
	flashEFI("https://raw.githubusercontent.com/TheSainEyereg/CustomMineOS-MineOS-App/master/Custom/CustomEFI.lua")
	replaceloader("https://raw.githubusercontent.com/TheSainEyereg/CustomMineOS-MineOS-App/master/Custom/OS.lua")
	GUI.alert(localization.comp)
    computer.shutdown(true)
end
	
