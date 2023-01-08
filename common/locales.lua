LOCALES = {}

function _(str, ...)  -- Translate string
    local locale = "en"
    local _manifestLocale = GetResourceMetadata(GetCurrentResourceName(), "locale", 0)
    local _configLocale = CONFIG["Locale"]

    if _configLocale ~= nil then
        locale = _configLocale
    elseif _manifestLocale ~= nil then
        locale = _manifestLocale
    end

	if LOCALES[locale] ~= nil then

		if LOCALES[locale][str] ~= nil then
			return string.format(LOCALES[locale][str], ...)
		else
			return 'Translation [' .. locale .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. locale .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end