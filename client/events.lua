--[[
    TriggerEvent("Jay:BaitCar:receiveIdentifier", identifier)
    TriggerClientEvent("Jay:BaitCar:receiveIdentifier", identifier)
    
    Sets the client side varriable for the user's identifier

    @param {String} identifier - The identifier to set
]]
RegisterNetEvent("Jay:BaitCar:receiveIdentifier")
AddEventHandler("Jay:BaitCar:receiveIdentifier", function(identifier) 
    PlayerIdentifier = identifier
end)

--[[
    TriggerEvent("Jay:BaitCar:updateIdentifier", identifier)
    TriggerClientEvent("Jay:BaitCar:updateIdentifier", identifier)
    
    Calls to the server to update the client identifier varriable
]]
RegisterNetEvent("Jay:BaitCar:updateIdentifier")
AddEventHandler("Jay:BaitCar:updateIdentifier", function() 
    TriggerServerEvent("Jay:BaitCar:updatePlayerIdentifier")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_alarm", function(data)
    print("remoteButton_alarm")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_lock", function(data)
    print("remoteButton_lock")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_unlock", function(data)
    print("remoteButton_unlock")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_engine", function(data)
    print("remoteButton_engine", data)
end)

-- NUI Callback
RegisterNUICallback("remoteButton_ebrake", function(data)
    print("remoteButton_ebrake", data)
end)

-- NUI Callback
RegisterNUICallback("remoteHidden", function(data)
    print("remoteHidden")
    
    SetNuiFocus(false, false)
end)