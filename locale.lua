
NPCBots = {
	Locales = {},
}

local _usedLocale
function NPCBots.InitLocale()
	_usedLocale = NPCBots.Locales[GetLocale()]
end

function NPCBots.I18n(text)
	if _usedLocale then
		return _usedLocale[text] or text
	else
		return text
	end
end
