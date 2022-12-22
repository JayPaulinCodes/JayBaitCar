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
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage1"))
        
        -- Start Animation
        ClearPedTasks(playerPed)
        LoadAnim("veh@std@ds@base")
        print("Anim 1")
        TaskPlayAnim(playerPed, "veh@std@ds@base", "hotwire", 8.0, 8.0, waitTime_1, 51, 2, 0, 0, 0)
        RemoveAnimDict("veh@std@ds@base")

        -- Wait
        Wait(waitTime_1)

        -- Finish Install Equiment
        drawNotification(_("fiveMColour_green") .. _U("setBaitCarStage2"))


    --
    -- STAGE 2 - Linking Receiver
    -- Min: 6 seconds
    -- Max: 15 seconds
    --

        -- Start Linking Receiver
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage3"))
        
        -- Exit the car
        ClearPedTasks(playerPed)
        TaskLeaveVehicle(playerPed, vehicle, 0)
        Wait(3000)

        -- Start Radar Animation (w_am_digiscanner)
        ClearPedTasks(playerPed)
        LoadAnim("cellphone@")
        print("Anim 2", stage3WaitTime)
        TaskPlayAnim(playerPed, "cellphone@", "cellphone_text_read_base", 2.0, 2.0, stage3WaitTime, 0, 0, false, false, false)
        RemoveAnimDict("cellphone@")
        
        print("Adding Phone")
        AddPropToPlayer("prop_npc_phone_02", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        -- AddPropToPlayer("w_am_digiscanner", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

        -- Wait
        Wait(waitTime_2)

        -- Finish Linking Receiver
        drawNotification(_("fiveMColour_green") .. _U("setBaitCarStage4"))


    --
    -- STAGE 3 - Testing Satellite Connections
    -- Collective Min: 66 seconds
    -- Collective Max: 85 seconds
    --

        -- Start Testing Satellite Connections
        drawNotification(_("fiveMColour_yellow") .. _U("setBaitCarStage5"))


    --
    -- STAGE 3.1 - Testing Satellite 1 Connection
    -- Min: 13 seconds
    -- Max: 16 seconds
    --

        -- Wait
        Wait(waitTime_3)

        -- Finish Testing Satellite 1 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage6"))


    --
    -- STAGE 3.2 - Testing Satellite 2 Connection
    -- Min: 13 seconds
    -- Max: 18 seconds
    --

        -- Wait
        Wait(waitTime_4)

        -- Finish Testing Satellite 2 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage7"))


    --
    -- STAGE 3.3 - Testing Satellite 3 Connection
    -- Min: 14 seconds
    -- Max: 18 seconds
    --

        -- Wait
        Wait(waitTime_5)

        -- Finish Testing Satellite 3 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage8"))


    --
    -- STAGE 3.4 - Testing Satellite 4 Connection
    -- Min: 12 seconds
    -- Max: 15 seconds
    --

        -- Wait
        Wait(waitTime_6)

        -- Finish Testing Satellite 4 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage9"))


    --
    -- STAGE 3.5 - Testing Satellite 5 Connection
    -- Min: 14 seconds
    -- Max: 18 seconds
    --

        -- Wait
        Wait(waitTime_7)

        -- Finish Testing Satellite 5 Connection
        drawNotification(_("fiveMColour_blue") .. _U("setBaitCarStage10"))


    --
    -- ROUTINE FINISH
    --

        -- End All Animation
        ClearPedTasks(playerPed)
        if Emote["PlayerHasProp"] then
            DestroyAllProps()
        end

        drawNotification(_("fiveMColour_green") .. _U("setBaitCarDone"))
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