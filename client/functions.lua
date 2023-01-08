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
    Shoutout to Flatracer on the forums for this one
    https://forum.cfx.re/t/use-displayonscreenkeyboard-properly/51143/2

    -- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght
]]
function getUserTextInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
    
end


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
    isPedRealAndAlive(playerPed)
    Checks to make sure a player exists and is not dead

    @playerPed - The player ped of the entity to test (See GetPlayerPed())

    @returns - boolean
]]
function isPedRealAndAlive(playerPed) 

    if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then 
        return true 
    else
        return false 
    end

end


--[[
    isVehicleLocked(vehicle) 
    Checks to see if a vehicle is locked

    @vehicle - The vehicle to check

    @returns - boolean

    @nilReturns 
    The function will return nil when the vehicle
    doesn't exist
]]
function isVehicleLocked(vehicle) 

    if not DoesEntityExist(vehicle) then return nil end         -- Make sure the vehicle is real

    local lockState = GetVehicleDoorLockStatus(vehicle)

    if lockState == 0 or lockState == 1 then
        return false
    else
        return true
    end

end


--[[
    doesVehicleHaveDoor(vehicle, doorIndex)
    Checks if a vehicle has a specific door

    Vehicle Door Indexes:
    0 = Front Driver
    1 = Rear Driver
    2 = Front Passenger
    3 = Rear Passenger
    4 = Hood
    5 = Trunk

    @vehicle - The vehicle to check
    @doorIndex - The index of the door to check

    @returns - boolean

    @nilReturns 
    The function will return nil when either the vehicle
    doesn't exist or the doorIndex is out of value
]]
function doesVehicleHaveDoor(vehicle, doorIndex) 

    if not isDoorIndexValid(doorIndex) then return nil end      -- Make sure the doorIndex is valid
    if not DoesEntityExist(vehicle) then return nil end         -- Make sure the vehicle is real

    local value = GetIsDoorValid(vehicle, doorIndex)

    return value

end


--[[
    doesVehicleHaveWindow(vehicle, windowIndex)
    Checks if a vehicle has a specific window

    Vehicle Window Indexes:
    0 = Front Driver
    1 = Front Passenger
    2 = Rear Driver
    3 = Rear Passenger

    @vehicle - The vehicle to check
    @windowIndex - The index of the window to check

    @returns - boolean

    @nilReturns 
    The function will return nil when either the vehicle
    doesn't exist or the windowIndex is out of value
]]
function doesVehicleHaveWindow(vehicle, windowIndex) 

    if not isWindowIndexValid(windowIndex) then return nil end      -- Make sure the windowIndex is valid
    if not DoesEntityExist(vehicle) then return nil end         -- Make sure the vehicle is real

    doorIndex = windowIndexToDoorIndex(windowIndex)

    local value = GetIsDoorValid(vehicle, doorIndex)

    return value

end


--[[
    isVehicleDoorOpen(vehicle, doorIndex)
    Checks if a vehicle's door is open or not

    Vehicle Door Indexes:
    0 = Front Driver
    1 = Rear Driver
    2 = Front Passenger
    3 = Rear Passenger
    4 = Hood
    5 = Trunk

    @vehicle - The vehicle to check
    @doorIndex - The index of the door to check

    @returns - boolean

    @nilReturns 
    The function will return nil when either 
        the vehicle doesn't exist
        the doorIndex is out of value
        the vehicle doesn't have the requested door
]]
function isVehicleDoorOpen(vehicle, doorIndex)

    if not isDoorIndexValid(doorIndex) then return nil end                      -- Make sure the doorIndex is valid
    if not DoesEntityExist(vehicle) then return nil end                         -- Make sure the vehicle is real
    if not doesVehicleHaveDoor(vehicle, doorIndex) then return nil end           -- Make sure the vehicle has the door

    if GetVehicleDoorAngleRatio(vehicle, doorIndex) > 0 then
        return true
    else
        return false
    end

end


--[[
    isDoorIndexValid(doorIndex) 
    Checks if a value is allowed as a doorIndex

    Vehicle Door Indexes:
    0 = Front Driver
    1 = Rear Driver
    2 = Front Passenger
    3 = Rear Passenger
    4 = Hood
    5 = Trunk

    @doorIndex - The index of the door to check

    @returns - boolean
]]
function isDoorIndexValid(doorIndex) 
    if doorIndex >= 0 and doorIndex <= 5 then
        return true
    else
        return false
    end
end


--[[
    TODO: Document Function
]]
function getPedCurrentWeaponObject()
    local playerPed = GetPlayerPed(-1)
    xx, currentWeaponHash = GetCurrentPedWeapon(playerPed)

    if WEAPONS[tostring(currentWeaponHash)] ~= nil then
        return WEAPONS[tostring(currentWeaponHash)]
    else
        return nill
    end
end


--[[
    TODO: Document Function
]]
function getWeaponObjectFromHash(weaponHash)
    return WEAPONS[weaponHash]
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
    TODO: Document Function
]]
function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      Wait(10)
    end
end


--[[
    
]]
function saveBaitCarData()
    local kvpString_vehicle = _("kvpString_baitCar_vehicle", PlayerIdentifier)
    local kvpString_forceEngine = _("kvpString_baitCar_forceEngine", PlayerIdentifier)
    local kvpString_eBrake = _("kvpString_baitCar_eBrakeApplied", PlayerIdentifier)
    local kvpString_doorLocks = _("kvpString_baitCar_doorsLocked", PlayerIdentifier)

    SetResourceKvp(kvpString_vehicle, BaitCar["Vehicle"])

    if BaitCar["EBrakeApplied"] == nil then 
        SetResourceKvpInt(kvpString_eBrake, -1)
    elseif BaitCar["EBrakeApplied"] == false then
        SetResourceKvpInt(kvpString_eBrake, 0)
    elseif BaitCar["EBrakeApplied"] == true then
        SetResourceKvpInt(kvpString_eBrake, 1)
    end
    
    if BaitCar["DoorsLocked"] == nil then 
        SetResourceKvpInt(kvpString_doorLocks, -1)
    elseif BaitCar["DoorsLocked"] == false then
        SetResourceKvpInt(kvpString_doorLocks, 0)
    elseif BaitCar["DoorsLocked"] == true then
        SetResourceKvpInt(kvpString_doorLocks, 1)
    end
    
    if BaitCar["ForceEngine"] == nil then 
        SetResourceKvpInt(kvpString_forceEngine, -1)
    elseif BaitCar["ForceEngine"] == false then
        SetResourceKvpInt(kvpString_forceEngine, 0)
    elseif BaitCar["ForceEngine"] == true then
        SetResourceKvpInt(kvpString_forceEngine, 1)
    end
end


--[[
    
]]
function getBaitCarData()
    local kvpString_vehicle = _("kvpString_baitCar_vehicle", PlayerIdentifier)
    local kvpString_forceEngine = _("kvpString_baitCar_forceEngine", PlayerIdentifier)
    local kvpString_eBrake = _("kvpString_baitCar_eBrakeApplied", PlayerIdentifier)
    local kvpString_doorLocks = _("kvpString_baitCar_doorsLocked", PlayerIdentifier)
    local baitCar_forceEngine = GetResourceKvpInt(kvpString_forceEngine)
    local baitCar_eBrake = GetResourceKvpInt(kvpString_eBrake)
    local baitCar_doorLocks = GetResourceKvpInt(kvpString_doorLocks)

    BaitCar["Vehicle"] = GetResourceKvpString(kvpString_vehicle)

    if baitCar_eBrake == -1 then 
        BaitCar["EBrakeApplied"] = nil
    elseif baitCar_eBrake == 0 then
        BaitCar["EBrakeApplied"] = false
    elseif baitCar_eBrake == 1 then
        BaitCar["EBrakeApplied"] = true
    end
    
    if baitCar_doorLocks == -1 then 
        BaitCar["DoorsLocked"] = nil
    elseif baitCar_doorLocks == 0 then
        BaitCar["DoorsLocked"] = false
    elseif baitCar_doorLocks == 1 then
        BaitCar["DoorsLocked"] = true
    end
    
    if baitCar_forceEngine == -1 then 
        BaitCar["ForceEngine"] = nil
    elseif baitCar_forceEngine == 0 then
        BaitCar["ForceEngine"] = false
    elseif baitCar_forceEngine == 1 then
        BaitCar["ForceEngine"] = true
    end
end


--[[
    
]]
function DestroyAllProps()
    for _,v in pairs(Emote["PlayerProps"]) do
      DeleteEntity(v)
    end
    Emote["PlayerHasProp"] = false
    -- DebugPrint("Destroyed Props")
end


--[[
    
]]
function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop1) then
      LoadPropDict(prop1)
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+3.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(Emote["PlayerProps"], prop)
    Emote["PlayerHasProp"] = true
    SetModelAsNoLongerNeeded(prop1)
end


--[[
    
]]
function doBaitCarInstallRoutine()
	local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local waitTime_1 = math.random(18, 20) * 1000
    local waitTime_2 = math.random(6, 15) * 1000
    local waitTime_3 = math.random(13, 16) * 1000
    local waitTime_4 = math.random(13, 18) * 1000
    local waitTime_5 = math.random(14, 18) * 1000
    local waitTime_6 = math.random(12, 15) * 1000
    local waitTime_7 = math.random(14, 18) * 1000
    local stage3WaitTime = waitTime_3 + waitTime_4 + waitTime_5 + waitTime_6 + waitTime_7

    print(waitTime_1, waitTime_2, waitTime_3, waitTime_4, waitTime_5, waitTime_6, waitTime_7, stage3WaitTime)

    --[[
        Stages:
        
        Stage 1 - Install equipment     Min: [18]   Max: [20]
        Stage 2 - Linking receiver      Min: [ 6]   Max: [15]
        Stage 3 - Testing satellites     [-------------------]
            Stage 3.1 - Satellite 1      Min: [13]   Max: [16]
            Stage 3.2 - Satellite 2      Min: [13]   Max: [18]
            Stage 3.3 - Satellite 3      Min: [14]   Max: [18]
            Stage 3.4 - Satellite 4      Min: [12]   Max: [15]
            Stage 3.5 - Satellite 5      Min: [14]   Max: [18]

    ]]


    --
    -- STAGE 1 - Install Equipment
    -- Min: 18 seconds
    -- Max: 20 seconds
    --

        -- Start Install Equipment
        print("start stage 1")
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage1"))
        
        -- Start Animation
        ClearPedTasks(playerPed)
        LoadAnim("veh@std@ds@base")
        TaskPlayAnim(playerPed, "veh@std@ds@base", "hotwire", 8.0, 8.0, waitTime_1, 51, 2, 0, 0, 0)
        RemoveAnimDict("veh@std@ds@base")

        -- Wait
        Wait(waitTime_1)

        -- Finish Install Equiment
        drawNotification(_("fiveMColour_green") .. _U("setBaitCarStage2"))

        print("end stage 1")

    --
    -- STAGE 2 - Linking Receiver
    -- Min: 6 seconds
    -- Max: 15 seconds
    --

    print("start stage 2")
        -- Start Linking Receiver
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage3"))
        
        -- Exit the car
        ClearPedTasks(playerPed)
        TaskLeaveVehicle(playerPed, vehicle, 0)
        Wait(3000)

        -- Start Radar Animation (w_am_digiscanner)
        -- ClearPedTasks(playerPed)
        -- LoadAnim("cellphone@")
        print("Anim 2", stage3WaitTime)
        -- TaskPlayAnim(playerPed, "cellphone@", "cellphone_text_read_base", 2.0, 2.0, stage3WaitTime, 0, 0, false, false, false)
        -- RemoveAnimDict("cellphone@")
        
        print("Adding Phone")
        -- AddPropToPlayer("prop_npc_phone_02", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        -- AddPropToPlayer("w_am_digiscanner", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

        -- Wait
        Wait(waitTime_2)

        -- Finish Linking Receiver
        drawNotification(_("fiveMColour_green") .. _U("setBaitCarStage4"))

        print("end stage 2")

    --
    -- STAGE 3 - Testing Satellite Connections
    -- Collective Min: 66 seconds
    -- Collective Max: 85 seconds
    --

    print("start stage 3")
        -- Start Testing Satellite Connections
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage5"))


    --
    -- STAGE 3.1 - Testing Satellite 1 Connection
    -- Min: 13 seconds
    -- Max: 16 seconds
    --

    print("start stage 3.1")
        -- Wait
        Wait(waitTime_3)

        -- Finish Testing Satellite 1 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage6"))

        print("end stage 3.1")

    --
    -- STAGE 3.2 - Testing Satellite 2 Connection
    -- Min: 13 seconds
    -- Max: 18 seconds
    --

    print("start stage 3.2")
        -- Wait
        Wait(waitTime_4)

        -- Finish Testing Satellite 2 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage7"))

        print("end stage 3.2")

    --
    -- STAGE 3.3 - Testing Satellite 3 Connection
    -- Min: 14 seconds
    -- Max: 18 seconds
    --

    print("start stage 3.3")
        -- Wait
        Wait(waitTime_5)

        -- Finish Testing Satellite 3 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage8"))

        print("end stage 3.3")

    --
    -- STAGE 3.4 - Testing Satellite 4 Connection
    -- Min: 12 seconds
    -- Max: 15 seconds
    --
    print("start stage 3.4")

        -- Wait
        Wait(waitTime_6)

        -- Finish Testing Satellite 4 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage9"))

        print("end stage 3.4")

    --
    -- STAGE 3.5 - Testing Satellite 5 Connection
    -- Min: 14 seconds
    -- Max: 18 seconds
    --
    print("start stage 3.5")

        -- Wait
        Wait(waitTime_7)

        -- Finish Testing Satellite 5 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage10"))

        print("end stage 3.5")

        print("end stage 3")
    --
    -- ROUTINE FINISH
    --

        -- End All Animation
        ClearPedTasks(playerPed)
        if Emote["PlayerHasProp"] then
            DestroyAllProps()
        end

        drawNotification(_("fiveMColour_green") .. _U("setBaitCarDone"))
        print("done")
end

function doBaitCarInstallRoutineDEV()
	local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local waitTime_1 = math.random(18, 20) * 100
    local waitTime_2 = math.random(6, 15) * 100
    local waitTime_3 = math.random(13, 16) * 100
    local waitTime_4 = math.random(13, 18) * 100
    local waitTime_5 = math.random(14, 18) * 100
    local waitTime_6 = math.random(12, 15) * 100
    local waitTime_7 = math.random(14, 18) * 100
    local stage3WaitTime = waitTime_3 + waitTime_4 + waitTime_5 + waitTime_6 + waitTime_7

    print(waitTime_1, waitTime_2, waitTime_3, waitTime_4, waitTime_5, waitTime_6, waitTime_7, stage3WaitTime)

    --[[
        Stages:
        
        Stage 1 - Install equipment     Min: [18]   Max: [20]
        Stage 2 - Linking receiver      Min: [ 6]   Max: [15]
        Stage 3 - Testing satellites     [-------------------]
            Stage 3.1 - Satellite 1      Min: [13]   Max: [16]
            Stage 3.2 - Satellite 2      Min: [13]   Max: [18]
            Stage 3.3 - Satellite 3      Min: [14]   Max: [18]
            Stage 3.4 - Satellite 4      Min: [12]   Max: [15]
            Stage 3.5 - Satellite 5      Min: [14]   Max: [18]

    ]]


    --
    -- STAGE 1 - Install Equipment
    -- Min: 18 seconds
    -- Max: 20 seconds
    --

        -- Start Install Equipment
        print("start stage 1")
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage1"))
        
        -- Start Animation
        ClearPedTasks(playerPed)
        LoadAnim("veh@std@ds@base")
        TaskPlayAnim(playerPed, "veh@std@ds@base", "hotwire", 8.0, 8.0, waitTime_1, 51, 2, 0, 0, 0)
        RemoveAnimDict("veh@std@ds@base")

        -- Wait
        Wait(waitTime_1)

        -- Finish Install Equiment
        drawNotification(_("fiveMColour_green") .. _U("setBaitCarStage2"))

        print("end stage 1")

    --
    -- STAGE 2 - Linking Receiver
    -- Min: 6 seconds
    -- Max: 15 seconds
    --

    print("start stage 2")
        -- Start Linking Receiver
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage3"))
        
        -- Exit the car
        ClearPedTasks(playerPed)
        TaskLeaveVehicle(playerPed, vehicle, 0)
        Wait(3000)

        -- Start Radar Animation (w_am_digiscanner)
        -- ClearPedTasks(playerPed)
        -- LoadAnim("cellphone@")
        print("Anim 2", stage3WaitTime)
        -- TaskPlayAnim(playerPed, "cellphone@", "cellphone_text_read_base", 2.0, 2.0, stage3WaitTime, 0, 0, false, false, false)
        -- RemoveAnimDict("cellphone@")
        
        print("Adding Phone")
        -- AddPropToPlayer("prop_npc_phone_02", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        -- AddPropToPlayer("w_am_digiscanner", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

        -- Wait
        Wait(waitTime_2)

        -- Finish Linking Receiver
        drawNotification(_("fiveMColour_green") .. _U("setBaitCarStage4"))

        print("end stage 2")

    --
    -- STAGE 3 - Testing Satellite Connections
    -- Collective Min: 66 seconds
    -- Collective Max: 85 seconds
    --

    print("start stage 3")
        -- Start Testing Satellite Connections
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage5"))


    --
    -- STAGE 3.1 - Testing Satellite 1 Connection
    -- Min: 13 seconds
    -- Max: 16 seconds
    --

    print("start stage 3.1")
        -- Wait
        Wait(waitTime_3)

        -- Finish Testing Satellite 1 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage6"))

        print("end stage 3.1")

    --
    -- STAGE 3.2 - Testing Satellite 2 Connection
    -- Min: 13 seconds
    -- Max: 18 seconds
    --

    print("start stage 3.2")
        -- Wait
        Wait(waitTime_4)

        -- Finish Testing Satellite 2 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage7"))

        print("end stage 3.2")

    --
    -- STAGE 3.3 - Testing Satellite 3 Connection
    -- Min: 14 seconds
    -- Max: 18 seconds
    --

    print("start stage 3.3")
        -- Wait
        Wait(waitTime_5)

        -- Finish Testing Satellite 3 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage8"))

        print("end stage 3.3")

    --
    -- STAGE 3.4 - Testing Satellite 4 Connection
    -- Min: 12 seconds
    -- Max: 15 seconds
    --
    print("start stage 3.4")

        -- Wait
        Wait(waitTime_6)

        -- Finish Testing Satellite 4 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage9"))

        print("end stage 3.4")

    --
    -- STAGE 3.5 - Testing Satellite 5 Connection
    -- Min: 14 seconds
    -- Max: 18 seconds
    --
    print("start stage 3.5")

        -- Wait
        Wait(waitTime_7)

        -- Finish Testing Satellite 5 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage10"))

        print("end stage 3.5")

        print("end stage 3")
    --
    -- ROUTINE FINISH
    --

        -- End All Animation
        ClearPedTasks(playerPed)
        if Emote["PlayerHasProp"] then
            DestroyAllProps()
        end

        drawNotification(_("fiveMColour_green") .. _U("setBaitCarDone"))
        print("done")
end


function GoToTargetWalking(target, vehicle, driver)
    while enroute do
        Citizen.Wait(500)
        engine = GetWorldPositionOfEntityBone(target, GetEntityBoneIndexByName(target, "engine"))
        TaskGoToCoordAnyMeans(driver, engine, 2.0, 0, 0, 786603, 0xbf800000)
        distanceToTarget = GetDistanceBetweenCoords(engine, GetEntityCoords(driver).x, GetEntityCoords(driver).y, GetEntityCoords(driver).z, true)
        norunrange = false 
        if distanceToTarget <= 10 and not norunrange then 
            TaskGoToCoordAnyMeans(driver, engine, 1.0, 0, 0, 786603, 0xbf800000)
            norunrange = true
        end
        if distanceToTarget <= 2 then
            SetVehicleUndriveable(target, true)
            TaskTurnPedToFaceCoord(driver, GetEntityCoords(target), -1)
            Citizen.Wait(1000)
            TaskStartScenarioInPlace(driver, "PROP_HUMAN_BUM_BIN", 0, 1)
            SetVehicleDoorOpen(target, 4, false, false)
            Citizen.Wait(10000)
            ClearPedTasks(driver)
            RepairVehicle(target, vehicle, driver)
            TriggerServerEvent('knb:mech:pay')
        end
        
    end
end


function openRemote()
    SendNUIMessage({ module = "JayBaitCar-openRemote" })
    SetNuiFocus(true, true)
end


function closeRemote()
    SendNUIMessage({ module = "JayBaitCar-closeRemote" })
    SetNuiFocus(false, false)
end