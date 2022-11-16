function getIdentifierFromSource(idType, source)
    local returnVal = false
    local steamid   = false
    local license   = false
    local discord   = false
    local xbl       = false
    local liveid    = false
    local ip        = false

    for k,v in pairs(GetPlayerIdentifiers(source))do
        
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
            if idType == "steam" then 
                returnVal = steamid
            end
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
            if idType == "license" then 
                returnVal = steamid
            end
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
            if idType == "xbl" then 
                returnVal = steamid
            end
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
            if idType == "ip" then 
                returnVal = steamid
            end
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
            if idType == "discord" then 
                returnVal = steamid
            end
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
            if idType == "live" then 
                returnVal = steamid
            end
        end

    end
end