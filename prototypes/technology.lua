local function tech_proto(tech_name)
    return data.raw["technology"][tech_name]
end

if not settings.startup["aaii-cc-early-tech"] then goto early_end end

do
    local tech_list = {
        "industrial-furnace",
        "area-mining-drill"
    }

    -- sanity

    local error = false
    for _, tech_name in pairs(tech_list) do
        if not tech_proto(tech_name) then
            error = true
            log("[AAII-CC] WARNING: tech "..tech_name.." not found.")
            error = true
        end
    end

    if error == true then
        goto early_end
    end

    for _, tech_name in pairs(tech_list) do
        -- Remove Productivity pack prereq.
        for k, pre_name in pairs( tech_proto(tech_name).prerequisites ) do
            if pre_name == "production-science-pack" then
                table.remove( tech_proto(tech_name).prerequisites, k )
            end
        end

        -- Remove Productivity pack usage
        for k, pack in pairs( tech_proto(tech_name).unit.ingredients ) do
            if pack[1] == "production-science-pack" then
                table.remove( tech_proto(tech_name).unit.ingredients, k )
            end
        end

        -- Increase unit count
        tech_proto(tech_name).unit.count = 500
    end

end

::early_end::