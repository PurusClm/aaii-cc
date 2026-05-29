---- Industrial Furnace

if not settings.startup["aaii-cc-furnace-buff"] then
    log("[AAII-CC] WARNING! Furnace buff not implemented; setting not found")
    goto continue_1
elseif not settings.startup["aaii-cc-furnace-buff"].value then
    log("[AAII-CC] WARNING! Furnace buff not implemented; setting value is nil")
    goto continue_1
end

--- Extract the speed-prod value from the setting

do
    local command = settings.startup["aaii-cc-furnace-buff"].value
    local bar = string.find(command, "-")
    local furnace_speed = tonumber( string.sub(command, 1, bar - 1) )
    local furnace_prod = tonumber( string.sub(command, bar + 1, -1) )
    local furnace = data.raw["assembling-machine"]["industrial-furnace"]

    if not ( type(furnace_speed) == "number" and type(furnace_prod) == "number" ) then
        log("[AAII-CC] WARNING! Furnace buff not implemented; parsing error with s-p pairing: "..furnace_speed.."-"..furnace_prod)
        goto continue_1
    end

    furnace.crafting_speed = furnace_speed
    if furnace_prod > 0 then
        furnace.effect_receiver = { base_effect = { productivity = furnace_prod }}
    end
end

::continue_1::

---- Area Drill

if not settings.startup["aaii-cc-drill-buff"] then
    log("[AAII-CC] WARNING! Drill buff not implemented; setting not found")
    goto continue_2
elseif not settings.startup["aaii-cc-drill-buff"].value then
    goto continue_2
end

do
    local drill = data.raw["mining-drill"]["area-mining-drill"]
    drill.mining_speed = 1.75
    drill.resource_drain_rate_percent = 60
end

::continue_2::