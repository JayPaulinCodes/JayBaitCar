--[[
    An example event

    @param {Table} table - The message 
]]
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals) 
    local _source = source
    local identifier = nil

    deferrals.defer()

    Wait(0)

    deferrals.update(_U("obtainingLicense"))

    identifier = getIdentifierFromSource("license", _source)

    Wait(0)

    if identifier == nil then
        deferrals.done(_U("failedToObtainLicense"))
    else
        deferrals.done()
        TriggerClientEvent("Jay:BaitCar:receiveIdentifier", _source, identifier)
    end

end)


--[[
    An example event

    @param {Table} table - The message 
]]
AddEventHandler("onResourceStart", function(resource) 
    local _resource = resource

    if _resource == GetCurrentResourceName() then
        Wait(5000)
        TriggerClientEvent("Jay:BaitCar:updateIdentifier", -1)
    end

end)


--[[
    TriggerServerEvent("Jay:BaitCar:updatePlayerIdentifier", table)
    
    An example event
]]
RegisterServerEvent("Jay:BaitCar:updatePlayerIdentifier")
AddEventHandler("Jay:BaitCar:updatePlayerIdentifier", function() 
    local _source = source
    local identifier = getIdentifierFromSource("license", _source)

    print(_source)
    TriggerClientEvent("Jay:BaitCar:receiveIdentifier", _source, identifier)
end)