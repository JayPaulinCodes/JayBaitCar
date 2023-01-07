LOCALES["en"] = {
    ["author"] = "script writen by Jay (Error#3569 on discord)",

    ["invalidArgs"] = "invalid arguments, usage: %s",

    ["redHex"] = "#d90429",
    ["greenHex"] = "#70e000",
    ["yellowHex"] = "#ffb703",

    ["fiveMColour_red"] = "~r~",
    ["fiveMColour_blue"] = "~b~",
    ["fiveMColour_green"] = "~g~",
    ["fiveMColour_yellow"] = "~y~",
    ["fiveMColour_purple"] = "~p~",
    ["fiveMColour_grey"] = "~c~",
    ["fiveMColour_darkGrey"] = "~m~",
    ["fiveMColour_black"] = "~u~",
    ["fiveMColour_orange"] = "~o~",
    ["fiveMColour_newLine"] = "~n~",
    ["fiveMColour_resetColour"] = "~s~",
    ["fiveMColour_boldText"] = "~h~",

--    +------------+        
--    |    KVP     |
--    +------------+  

    ["kvpString_baitCar_vehicle"] = "Jay:BaitCar:baitCar_vehicle_%s",
    ["kvpString_baitCar_forceEngine"] = "Jay:BaitCar:baitCar_forceEngine_%s",
    ["kvpString_baitCar_eBrakeApplied"] = "Jay:BaitCar:baitCar_eBrakeApplied_%s",
    ["kvpString_baitCar_doorsLocked"] = "Jay:BaitCar:baitCar_doorsLocked_%s",

--    +------------+        
--    |  Commands  |
--    +------------+   

    -- [/openremote] Remote Open Command
    ["openremoteCmd_name"] = "openremote",
    ["openremoteCmd_description"] = "Opens bait car remote.",

    -- [/closeremote] Remote Close Command
    ["closeremoteCmd_name"] = "closeremote",
    ["closeremoteCmd_description"] = "Closes bait car remote.",

    -- [/setbaitcar] Set Bait Car Command
    ["setbaitcarCmd_name"] = "setbaitcar",
    ["setbaitcarCmd_description"] = "Installs bait car equipment into the car you're in",

    -- [/toggletracking] Toggle Tracking Command
    ["toggletrackingCmd_name"] = "toggletracking",
    ["toggletrackingCmd_description"] = "Enables tracking of the bait car",

    -- [/remotelocks] Remote Locks Command
    ["remotelocksCmd_name"] = "remotelocks",
    ["remotelocksCmd_description"] = "Remotely toggles the bair car's door locks",

    -- [/remoteengine] Remote Engine Command
    ["remoteengineCmd_name"] = "remoteengine",
    ["remoteengineCmd_description"] = "Remotely toggles the bair car's engine",

    -- [/remotebrake] Remote Brake Command
    ["remotebrakeCmd_name"] = "remotebrake",
    ["remotebrakeCmd_description"] = "Remotely applies the the bair car's brakes",

    -- [/remoteebrake] Remote E-Brake Command
    ["remoteebrakeCmd_name"] = "remoteebrake",
    ["remoteebrakeCmd_description"] = "Remotely applies the the bair car's emergency brakes",


--    +------------+        
--    |  Messages  |
--    +------------+   

    -- Bait Car Install Messages
    ["setBaitCarStage1"] = "installing bait car equipment...",  
    ["setBaitCarStage2"] = "successfully installed bait car equipment!",
    ["setBaitCarStage3"] = "linking bait car to receiver...",
    ["setBaitCarStage4"] = "successfully linked bait car to receiver!",
    ["setBaitCarStage5"] = "testing receiver satellite connection...",
    ["setBaitCarStage6"] = "satellite #1 successfully established a connection!",
    ["setBaitCarStage7"] = "satellite #2 successfully established a connection!",
    ["setBaitCarStage8"] = "satellite #3 successfully established a connection!",
    ["setBaitCarStage9"] = "satellite #4 successfully established a connection!",
    ["setBaitCarStage10"] = "satellite #5 successfully established a connection!",
    ["setBaitCarDone"] = "the bait car has successfully been setup and linked!",

    -- Misc
    ["notInCar"] = "you must be in a car to do this!",
    ["forceOffEngine"] = "forcing off the bait car's engine.",
    ["releaseEngine"] = "releasing the bait car's engine.",
    ["noBaitCarLinked"] = "there is no bait car linked.",
    ["lockedDoors"] = "the bait car's doors have been locked.",
    ["unlockedDoors"] = "the bait car's doors have been unlocked.",
    ["enableEBrake"] = "the bait car's e-brake has been engaged.",
    ["disableEBrake"] = "the bait car's e-brake has been disengaged.",
    ["startAlarm"] = "the bait car's alarm has been started.",
    ["stopAlarm"] = "the bait car's alarm has been stopped.",
    ["baitCarBlip"] = "Bait Car",

    -- Other
    ["registeredCommand"] = " registered command: ",
    ["registeredChatTemplate"] = " registered chat template: ",
    ["obtainingLicense"] = "obtaining player license.",
    ["failedToObtainLicense"] = "failed to obtain player license. Please try to relog.",


--    +------------+        
--    |    Logs    |
--    +------------+  
}