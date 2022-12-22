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
BaitCar["Blip"] = nil

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
            if GetIsVehicleEngineRunning(BaitCar["Vehicle"]) then SetVehicleEngineOn(BaitCar["Vehicle"], false, true, true) end
        end

        Citizen.Wait(100)
    end
    
end)

-- Handle Blip Location
Citizen.CreateThread(function() 

    while true do
        if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
            local baitCar_Coords = GetEntityCoords(BaitCar["Vehicle"])

            if BaitCar["Blip"] == nil then
                BaitCar["Blip"] = AddBlipForCoord(baitCar_Coords.x, baitCar_Coords.y, baitCar_Coords.z)

                SetBlipSprite(BaitCar["Blip"], 225)
                SetBlipColour(BaitCar["Blip"], 30)
                SetBlipDisplay(BaitCar["Blip"], 2)
    
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(_("baitCarBlip"))
                EndTextCommandSetBlipName(BaitCar["Blip"])
            else 
                SetBlipCoords(BaitCar["Blip"], baitCar_Coords.x, baitCar_Coords.y, baitCar_Coords.z)
            end

        elseif BaitCar["Blip"] ~= nil then
            BaitCar["Blip"] = nil
        end

        Citizen.Wait(3000)
    end
    
end)

-- Handle Blip Flash
Citizen.CreateThread(function() 

    while true do
        if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" and BaitCar["Blip"] ~= nil then
            local baitCar_blipAlpha = GetBlipAlpha(BaitCar["Blip"])

            if baitCar_blipAlpha == 255 then
                SetBlipAlpha(BaitCar["Blip"], 0)
            else 
                SetBlipAlpha(BaitCar["Blip"], 255)
            end

        end

        Citizen.Wait(1000)
    end
    
end)

RegisterCommand("-Jay:BaitCar:test_saveCar", function(source, args, rawCommands) 
    local playerPed = GetPlayerPed(-1)

    if isPedRealAndAlive(playerPed) then

        if IsPedSittingInAnyVehicle(playerPed) then 
            local vehicle = GetVehiclePedIsIn( playerPed, false )

            -- doBaitCarInstallRoutine()
            doBaitCarInstallRoutineDEV()

            BaitCar["Vehicle"] = vehicle

            saveBaitCarData()
        else
            -- You must be in a car
        end

    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carEngineRelease", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        BaitCar["ForceEngine"] = false

        SetVehicleEngineOn(BaitCar["Vehicle"], true, true, false)

        drawNotification(_("fiveMColour_green") .. _U("releaseEngine"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carEngineOff", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        BaitCar["ForceEngine"] = true

        drawNotification(_("fiveMColour_green") .. _U("forceOffEngine"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carDoorLock", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        -- SetVehicleDoorsLockedForAllPlayers(BaitCar["Vehicle"], true)
        SetVehicleDoorsLocked(BaitCar["Vehicle"], 4)

        BaitCar["DoorsLocked"] = true

        drawNotification(_("fiveMColour_green") .. _U("lockedDoors"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carDoorUnlock", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        -- SetVehicleDoorsLockedForAllPlayers(BaitCar["Vehicle"], false)
        SetVehicleDoorsLocked(BaitCar["Vehicle"], 1)

        BaitCar["DoorsLocked"] = false

        drawNotification(_("fiveMColour_green") .. _U("unlockedDoors"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carEBrakeEnable", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        SetVehicleHandbrake(BaitCar["Vehicle"], true)

        BaitCar["EBrakeApplied"] = true

        drawNotification(_("fiveMColour_green") .. _U("enableEBrake"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carEBrakeDisable", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        SetVehicleHandbrake(BaitCar["Vehicle"], false)

        BaitCar["EBrakeApplied"] = false

        drawNotification(_("fiveMColour_green") .. _U("disableEBrake"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand("-Jay:BaitCar:test_carToggleAlarm", function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        if IsVehicleAlarmSet(BaitCar["Vehicle"]) or IsVehicleAlarmActivated(BaitCar["Vehicle"]) then
            SetVehicleAlarmTimeLeft(BaitCar["Vehicle"], 1)

            drawNotification(_("fiveMColour_green") .. _U("stopAlarm"))
        else
            SetVehicleAlarmTimeLeft(BaitCar["Vehicle"], 100000)
            StartVehicleAlarm(BaitCar["Vehicle"])

            drawNotification(_("fiveMColour_green") .. _U("startAlarm"))
        end
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)