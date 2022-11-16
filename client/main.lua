BairCar = {}
BairCar["Vehicle"] = ""
BairCar["EBrakeApplied"] = -1
BairCar["DoorsLocked"] = -1

-- Setup
Citizen.CreateThread(function() 
    Citizen.Wait(50)

    registerCommandSuggestions()

    registerChatTemplates()
end)