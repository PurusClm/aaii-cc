if not mods["planet-muluna"] then return end

local carbon_motor = data.raw["recipe"]["electric-engine-unit-from-carbon"]

for _, ingr in pairs(carbon_motor.ingredients) do
    if ingr.name == "lubricant" then
        local lub_num = ingr.amount
        ingr.type = "item"
        ingr.name = "carbon"
        ingr.amount = math.ceil(lub_num / 15)
    end
end