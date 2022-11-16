--[[
    TriggerEvent("Jay:BaitCar:exampleEvent", message)
    TriggerClientEvent("Jay:BaitCar:exampleEvent", message)
    
    An example event

    @param {String} message - The message 
]]
RegisterNetEvent("Jay:BaitCar:exampleEvent")
AddEventHandler("Jay:BaitCar:exampleEvent", function(message) 
    print(message)
end)