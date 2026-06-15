if not mods["Cerys-Moon-of-Fulgora"] then return end

local common = require("__Cerys-Moon-of-Fulgora__/common")

local cerys_recipe = table.deepcopy( data.raw.recipe["assembling-machine-3"] )

cerys_recipe.name = "cerys-assembling-machine-3"

for _, ingredient in pairs(cerys_recipe.ingredients) do
    if ingredient.name == "electric-engine-unit" then
        ingredient.name = "processing-unit"
        ingredient.amount = 1
    end
end

cerys_recipe.surface_conditions = {
    common.AMBIENT_RADIATION_MIN,
}

cerys_recipe.icon = nil
cerys_recipe.icon_size = nil
cerys_recipe.icons = {
            {
                icon = "__base__/graphics/icons/assembling-machine-3.png",
                icon_size = 64
            },
            {
                icon = "__Cerys-Moon-of-Fulgora__/graphics/icons/cerys.png",
                icon_size = 256,
                scale = 0.25 * 0.25,
                shift = {8,8}
            },
        }

data:extend({cerys_recipe})

table.insert( data.raw.technology["cerys-fulgoran-cryogenics"].effects, { type = "unlock-recipe", recipe = cerys_recipe.name } )