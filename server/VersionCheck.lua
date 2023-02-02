local installedVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
local githubVersion = "0.0.1"
local githubURL = GetResourceMetadata(GetCurrentResourceName(), "github_link", 0)
local githubRawURL = "https://raw.githubusercontent.com/" .. GetResourceMetadata(GetCurrentResourceName(), "github_link", 0) .. "/master/fxmanifest.lua"
local printArray = {
    "\n"
}

Citizen.CreateThread(function()
    print("Script starting up...")
    Citizen.Wait(3000)

    updateVersionFromGitHubURL()

    Citizen.Wait(1000)

    local line0 = ""
    local line1 = "^6" .. GetCurrentResourceName()
    local line2 = "^7Thank you for using " .. line1 .. "^7!"
    local line3 = "^9Discord: ^7https://discord.gg/aJcVKFMd9F"
    local line4 = "^9Installed Version: ^7" .. installedVersion
    local line4_5 = "^9Latest Version: ^7" .. githubVersion
    local line5 = ""
    local line6 = "^3!!! ^1UPDATE REQUIRED ^3!!!^4"
    local line7 = "^1DOWNLOAD FROM GITHUB:"
    local line8 = "^1github.com/" .. githubURL .. "/releases"
    local line9 = ""

    if installedVersion ~= githubVersion then
        longestLine = findLongestStringLength(line0, line1, line2, line3, line4, line4_5, line5, line6, line7, line8, line9)
    else 
        longestLine = findLongestStringLength(line0, line1, line2, line3, line4, line9)
    end

    table.insert(printArray, "\t^4________" .. padString("", longestLine, "_") .. "^4________")
    table.insert(printArray, "\t^4| |^6     " .. padString(line0, longestLine, " ") .. "     ^4| |")
    table.insert(printArray, "\t^4| |^6      " .. padString(line1, longestLine, " ") .. "      ^4| |")
    table.insert(printArray, "\t^4| |^6        " .. padString(line2, longestLine, " ") .. "        ^4| |")
    table.insert(printArray, "\t^4| |^6       " .. padString(line3, longestLine, " ") .. "       ^4| |")
    table.insert(printArray, "\t^4| |^6       " .. padString(line4, longestLine, " ") .. "       ^4| |")
    
    -- Version Check
    if installedVersion ~= githubVersion then --	UPDATE DETECTED
        table.insert(printArray, "\t^4| |^6       " .. padString(line4_5, longestLine, " ") .. "       ^4| |")
        table.insert(printArray, "\t^4| |^6     " .. padString(line5, longestLine, " ") .. "     ^4| |")
        table.insert(printArray, "\t^4| |^6         " .. padString(line6, longestLine, " ") .. "         ^4| |")
        table.insert(printArray, "\t^4| |^6      " .. padString(line7, longestLine, " ") .. "      ^4| |")
        table.insert(printArray, "\t^4| |^6      " .. padString(line8, longestLine, " ") .. "      ^4| |")
    end
    
    table.insert(printArray, "\t^4| |^6     " .. padString(line9, longestLine, " ") .. "     ^4| |")
    table.insert(printArray, "\t^4| |_____" .. padString("", longestLine, "_") .. "^4_____| |")
    table.insert(printArray, "\n^7")

    for _, message in ipairs(printArray) do
        print(message)
    end

end)

function findLongestStringLength(...)
    local args = {...}
    longestLength = 0

    for _, line in ipairs(args) do
        length = string.len(line)
        if length > longestLength then 
            longestLength = length
        end
    end

    return longestLength
end

function padString(str, targetLength, pad)
    local returnString = str

    ind = 0
    while string.len(returnString) ~= targetLength do
        Citizen.Wait(1)
        if ind == 0 then
            returnString = pad .. returnString
            ind = 1
        else 
            returnString = returnString .. pad
            ind = 0
        end
    end

    return returnString
end

function updateVersionFromGitHubURL() 
    PerformHttpRequest(githubRawURL, function(error, responseText, headers)
        if responseText ~= nil and responseText ~= "" then 
            local findres = string.find(responseText, '\nversion ".') + 10
            githubVersion = string.sub(responseText, findres, string.find(string.sub(responseText, findres), '"') - 2 + findres)
        end
    end)
end