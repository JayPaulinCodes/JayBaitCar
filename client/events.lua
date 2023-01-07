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
RegisterNUICallback("remoteButton_engineOn", function(data)
    print("remoteButton_engineOn")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_engineOff", function(data)
    print("remoteButton_engineOff")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_ebrakeOn", function(data)
    print("remoteButton_ebrakeOn")
end)

-- NUI Callback
RegisterNUICallback("remoteButton_ebrakeOff", function(data)
    print("remoteButton_ebrakeOff")
end)

-- NUI Callback
RegisterNUICallback("remoteHidden", function(data)
    print("remoteHidden")
end)