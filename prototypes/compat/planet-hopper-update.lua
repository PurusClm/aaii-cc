if not mods["Planet-Hopper"] then return end

local hopper = data.raw["rocket-silo"]["planet-hopper-launcher"]

if hopper.energy_source.type == "burner" then
    table.insert( hopper.energy_source.fuel_categories, "processed-chemical" )
end