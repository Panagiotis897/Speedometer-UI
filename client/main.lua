local lastGear = nil

RegisterNetEvent("speedometer:show")
AddEventHandler("speedometer:show", function(isMetric, speed, rpm, gear)
    local gearLabel = ""

    if speed == 0 then
        gearLabel = "N"
    elseif gear == 0 then
        gearLabel = "R"
    else
        gearLabel = tostring(gear)
    end

    SendNUIMessage({
        action = "show",
        isMetric = isMetric,
        speed = speed,
        rpm = rpm,
        gear = gearLabel
    })

    if lastGear ~= gear and type(gear) == "number" then
        SendNUIMessage({
            action = "gear",
            gear = gearLabel
        })
        lastGear = gear
    end
end)

RegisterNetEvent("speedometer:hide")
AddEventHandler("speedometer:hide", function()
    SendNUIMessage({
        action = "hide"
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local ped = GetPlayerPed(-1)
        local isInVehicle = IsPedInAnyVehicle(ped, false)

        if isInVehicle then
            local pedVehicle = GetVehiclePedIsIn(ped, false)
            local isMetric = ShouldUseMetricMeasurements()
            local speed = GetEntitySpeed(pedVehicle)
            local rpm = GetVehicleCurrentRpm(pedVehicle)
            local gear = GetVehicleCurrentGear(pedVehicle)

            TriggerEvent("speedometer:show", isMetric, speed, rpm, gear)
        else
            TriggerEvent("speedometer:hide")
        end

        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(9)
    end
end)
