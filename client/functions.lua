--[[
    sendChatMessage(templateID, arguments) 

    @param {String} templateID - The tempalte ID of the template to use
    @param {Array} arguments - Array of the arguments for the message
]]
function sendChatMessage(templateID, arguments) 
    TriggerEvent('chat:addMessage', 
        { 
            templateId = templateID, 
            multiline = true, 
            args = arguments
        }
    )
end


--[[
    Returns the player's server id
]]
function serverId()
    return GetPlayerServerId(PlayerId())    
end


--[[
    Registers command suggestions for each command
    in the common/commands.lua file
]]
function registerCommandSuggestions()
    for i, command in ipairs(COMMANDS) do
        
        if #command.parameters == 0 then
            TriggerEvent("chat:addSuggestion", "/" .. command.name, command.description)
        else 
            TriggerEvent("chat:addSuggestion", "/" .. command.name, command.description, command.parameters)
        end

        print(GetThisScriptName() .. _("registeredCommand") .. command.name)
        Citizen.Wait(25)
        
    end
end


--[[
    Registers chat templates for each template
    in the common/chatTemplates.lua file
]]
function registerChatTemplates()
    for i, chatTemplate in ipairs(CHAT_TEMPLATES) do
        TriggerEvent("chat:addTemplate", chatTemplate.templateId, chatTemplate.htmlString)
    
        print(GetThisScriptName() .. _("registeredChatTemplate") .. chatTemplate.templateId)
        Citizen.Wait(25)
    end
end


--[[
    drawNotification(message)
    Displayes a message above the map

    @param {String} message - The message to display
]]
function drawNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end


--[[
    isPedRealAndAlive(playerPed)
    Checks to make sure a player exists and is not dead

    @param {Entity} - The player ped of the entity to test (See GetPlayerPed())

    @returns {Boolean} Returns true when the ped is real and alive and false otherwise
]]
function isPedRealAndAlive(playerPed) 

    if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then 
        return true 
    else
        return false 
    end

end


--[[
    TODO: Document Function
]]
function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end


--[[
    
]]
function syncBaitCarData()
    TriggerServerEvent("Jay:BaitCar:setBaitCarData", BaitCar)
end