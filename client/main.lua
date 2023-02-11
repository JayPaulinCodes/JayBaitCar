--[[
    Required for the base script setup
]]
Citizen.CreateThread(function() 
    Citizen.Wait(50)

    registerCommandSuggestions()

    registerChatTemplates()
end)

PlayerIdentifier = nil
-- vMenuOverride = {}
-- vMenuOverride["vehicleEngineAlwaysOn"] = {}
-- vMenuOverride["vehicleEngineAlwaysOn"]["currentlyOverriding"] = false
-- vMenuOverride["vehicleEngineAlwaysOn"]["originalValue"] = nil
BaitCar = {}
BaitCar["Vehicle"] = ""
BaitCar["ForceEngine"] = false
BaitCar["EBrakeApplied"] = false
BaitCar["DoorsLocked"] = false
BaitCar["Blip"] = nil

Emote = {}
Emote["PlayerHasProp"] = false
Emote["PlayerProps"] = {}

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

RegisterCommand("devsetbaitcar", function(source, args, rawCommands) 
    local playerPed = GetPlayerPed(-1)

    if isPedRealAndAlive(playerPed) then

        if IsPedSittingInAnyVehicle(playerPed) then 
            local vehicle = GetVehiclePedIsIn( playerPed, false )

            doBaitCarInstallRoutineDEV()

            BaitCar["Vehicle"] = vehicle

            saveBaitCarData()
        else
            -- You must be in a car
        end

    end

end, false)

RegisterCommand(_("setbaitcarCmd_name"), function(source, args, rawCommands) 
    local playerPed = GetPlayerPed(-1)

    if isPedRealAndAlive(playerPed) then

        if IsPedSittingInAnyVehicle(playerPed) then 
            local vehicle = GetVehiclePedIsIn( playerPed, false )

            doBaitCarInstallRoutine()

            BaitCar["Vehicle"] = vehicle

            saveBaitCarData()
        else
            -- You must be in a car
        end

    end

end, false)

RegisterCommand(_("remoteengineCmd_name"), function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        print("Bait Car Engine Status: ", BaitCar["ForceEngine"])
        if BaitCar["ForceEngine"] == false then
            BaitCar["ForceEngine"] = true

            SetVehicleEngineOn(BaitCar["Vehicle"], true, true, false)
    
            drawNotification(_("fiveMColour_green") .. _U("forceOffEngine"))
        else
            BaitCar["ForceEngine"] = false
            
            drawNotification(_("fiveMColour_green") .. _U("releaseEngine"))
        end

    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand(_("remotelockCmd_name"), function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        -- SetVehicleDoorsLockedForAllPlayers(BaitCar["Vehicle"], true)
        SetVehicleDoorsLocked(BaitCar["Vehicle"], 4)

        BaitCar["DoorsLocked"] = true

        drawNotification(_("fiveMColour_green") .. _U("lockedDoors"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand(_("remoteunlockCmd_name"), function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        -- SetVehicleDoorsLockedForAllPlayers(BaitCar["Vehicle"], false)
        SetVehicleDoorsLocked(BaitCar["Vehicle"], 1)

        BaitCar["DoorsLocked"] = false

        drawNotification(_("fiveMColour_green") .. _U("unlockedDoors"))
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand(_("remoteebrakeCmd_name"), function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then

        if BaitCar["EBrakeApplied"] == true then
            SetVehicleHandbrake(BaitCar["Vehicle"], false)

            BaitCar["EBrakeApplied"] = false
    
            drawNotification(_("fiveMColour_green") .. _U("disableEBrake"))
        else
            SetVehicleHandbrake(BaitCar["Vehicle"], true)

            BaitCar["EBrakeApplied"] = true
    
            drawNotification(_("fiveMColour_green") .. _U("enableEBrake"))
        end


    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand(_("remotealarmCmd_name"), function(source, args, rawCommands) 
    
    if BaitCar["Vehicle"] ~= nil and BaitCar["Vehicle"] ~= "" then
        print(IsVehicleAlarmSet(BaitCar["Vehicle"]), IsVehicleAlarmActivated(BaitCar["Vehicle"]))

        if (IsVehicleAlarmSet(BaitCar["Vehicle"]) == 1 or IsVehicleAlarmSet(BaitCar["Vehicle"]) == true) or IsVehicleAlarmActivated(BaitCar["Vehicle"]) then
            SetVehicleAlarmTimeLeft(BaitCar["Vehicle"], 1)
            -- SetVehicleAlarm(BaitCar["Vehicle"], false)

            drawNotification(_("fiveMColour_green") .. _U("stopAlarm"))
        else
            SetVehicleAlarmTimeLeft(BaitCar["Vehicle"], 3000)
            StartVehicleAlarm(BaitCar["Vehicle"])
            -- SetVehicleAlarm(BaitCar["Vehicle"], true)

            drawNotification(_("fiveMColour_green") .. _U("startAlarm"))
        end
    else
        drawNotification(_("fiveMColour_red") .. _U("noBaitCarLinked"))
    end

end, false)

RegisterCommand(_("openremoteCmd_name"), function(source, args, rawCommands) 
    
    openRemote()

end, false)

RegisterCommand(_("closeremoteCmd_name"), function(source, args, rawCommands) 
    
    closeRemote()

end, false)