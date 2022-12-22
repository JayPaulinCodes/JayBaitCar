function getIdentifierFromSource(idType, source)
    local returnVal = nil
    local steamid   = nil
    local license   = nil
    local discord   = nil
    local xbl       = nil
    local liveid    = nil
    local ip        = nil

    for k,v in pairs(GetPlayerIdentifiers(source))do
        
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = string.sub(v, string.len("steam:") + 1, string.len(v))
            if idType == "steam" then 
                returnVal = steamid
            end
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = string.sub(v, string.len("license:") + 1, string.len(v))
            if idType == "license" then 
                returnVal = license
            end
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = string.sub(v, string.len("xbl:") + 1, string.len(v))
            if idType == "xbl" then 
                returnVal = xbl
            end
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, string.len("ip:") + 1, string.len(v))
            if idType == "ip" then 
                returnVal = ip
            end
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.sub(v, string.len("discord:") + 1, string.len(v))
            if idType == "discord" then 
                returnVal = discord
            end
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = string.sub(v, string.len("live:") + 1, string.len(v))
            if idType == "live" then 
                returnVal = liveid
            end
        end

    end

    return returnVal
end