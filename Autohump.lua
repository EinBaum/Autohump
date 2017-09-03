Autohump = CreateFrame("FRAME")
Autohump:RegisterEvent("ADDON_LOADED")
Autohump:RegisterEvent("PLAYER_LOGIN")
Autohump:RegisterEvent("CHAT_MSG_SYSTEM")
Autohump:SetScript("OnUpdate", function() updateHandler() end)
Autohump:SetScript("OnEvent", function() AutohumpEvents[event]() end)

function updateHandler()
	if HUMPCONFIG.HUMPON == true then
		Hump()
	end
end

function HumpIntroduction()
    DEFAULT_CHAT_FRAME:AddMessage("Pidisc Autohump AddOn Type /ah help for the list of commands!", 1.0, 0.0, 0.0)
end

function AutohumpLoaded()
	SLASH_HUMP1, SLASH_HUMP2 = '/AH', '/AUTOHUMP'
	SlashCmdList["HUMP"] = function(msg)
		HumpCommands(msg)
	end
	if HUMPCONFIG == nil then
	   HUMPCONFIG = { HUMPON = false, HUMPAFK = true }
	end
	HUMPCONFIG.HUMPON = false
end

function HumpCommands(msg)
	if (msg == "help" or msg == "Help") then
		DEFAULT_CHAT_FRAME:AddMessage(" /ah hump to hump or stop humping", 1.0, 0.0, 0.0)
		DEFAULT_CHAT_FRAME:AddMessage(" /ah afk to enable or disable auto afk humping", 1.0, 0.0, 0.0)
	end

	if (msg == "hump" or msg == "Hump") then
		if HUMPCONFIG.HUMPON == true then
			DEFAULT_CHAT_FRAME:AddMessage("Humping mode DISABLED", 1.0, 0.0, 0.0)
			HUMPCONFIG.HUMPON = false
		elseif HUMPCONFIG.HUMPON == false then
			DEFAULT_CHAT_FRAME:AddMessage("Humping mode ENABLED", 1.0, 0.0, 0.0)
			HUMPCONFIG.HUMPON = true
		end
	end

	if (msg == "afk"
		or msg == "Afk") then
		if HUMPCONFIG.HUMPAFK == true then
			HUMPCONFIG.HUMPAFK = false
			HUMPCONFIG.HUMPON = false
			DEFAULT_CHAT_FRAME:AddMessage("HUMPAFK DISABLED", 1.0, 0.0, 0.0)
		elseif HUMPCONFIG.HUMPAFK == false then
			HUMPCONFIG.HUMPAFK = true
			DEFAULT_CHAT_FRAME:AddMessage("HUMPAFK ENABLED", 1.0, 0.0, 0.0)
		end
	end
end

function Hump()
    SitOrStand()
end

function AutoHumpAFK()
    if HUMPCONFIG.HUMPAFK == true
	and string.find(arg1, "You are now AFK") then
		HUMPCONFIG.HUMPON = true
    end

	if arg1 == "You are no longer AFK" then
	    HUMPCONFIG.HUMPON = false
	end
end

AutohumpEvents = {
	["ADDON_LOADED"] = AutohumpLoaded,
	["CHAT_MSG_SYSTEM"] = AutoHumpAFK,
	["PLAYER_LOGIN"] = HumpIntroduction,
}
