PlayerIdentifier = nil
-- vMenuOverride = {}
-- vMenuOverride["vehicleEngineAlwaysOn"] = {}
-- vMenuOverride["vehicleEngineAlwaysOn"]["currentlyOverriding"] = false
-- vMenuOverride["vehicleEngineAlwaysOn"]["originalValue"] = nil
BaitCar = {}
BaitCar["Vehicle"] = ""
BaitCar["ForceEngine"] = nil
BaitCar["EBrakeApplied"] = nil
BaitCar["DoorsLocked"] = nil

Emote = {}
Emote["PlayerHasProp"] = false
Emote["PlayerProps"] = {}

-- Setup
Citizen.CreateThread(function() 
    Citizen.Wait(50)

    registerCommandSuggestions()

    registerChatTemplates()
end)

-- Handle Force Engine
Citizen.CreateThread(function() 

    while true do
    
        if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" and BaitCar["ForceEngine"] then

            if GetIsVehicleEngineRunning(BaitCar["Vehicle"]) then

                SetVehicleEngineOn(BaitCar["Vehicle"], false, true, true)

            end

        end

        Citizen.Wait(100)
    end
    
end)

RegisterCommand("-Jay:BaitCar:test_saveCar", function(source, args, rawCommands) 
    local playerPed = GetPlayerPed(-1)

    if isPedRealAndAlive(playerPed) then

        if IsPedSittingInAnyVehicle(playerPed) then 
            local vehicle = GetVehiclePedIsIn( playerPed, false )

            doBaitCarInstallRoutine()

            BaitCar["Vehicle"] = vehicle

            saveBaitCarData()
        end

    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carEngineRelease", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then

        BaitCar["ForceEngine"] = false

        SetVehicleEngineOn(BaitCar["Vehicle"], true, true, false)

    else
        -- No BaitCar Linked
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carEngineOff", function(source, args, rawCommands) 
    

    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then

        BaitCar["ForceEngine"] = true

    else
        -- No BaitCar Linked
    end


end, false)