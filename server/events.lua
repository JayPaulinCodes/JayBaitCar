--[[
    TriggerServerEvent("Jay:BaitCar:setBaitCarData", table)
    
    An example event

    @param {Table} table - The message 
]]
RegisterServerEvent("Jay:BaitCar:setBaitCarData")
AddEventHandler("Jay:BaitCar:setBaitCarData", function(table) 
    local _source = source
    local identifier = getIdentifierFromSource("license", _source)
    local kvpString = _("kvpString_baitCar", identifier)

    SetResourceKvpStringNoSync(kvpString, table["Vehicle"])
    SetResourceKvpIntNoSync(kvpString, table["EBrakeApplied"])
    SetResourceKvpIntNoSync(kvpString, table["DoorsLocked"])

    FlushResourceKvp()
end)