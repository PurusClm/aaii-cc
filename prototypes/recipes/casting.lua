local meld = require("meld")

--- Casting recipes

local molten_chart = {
    -- [intermediate-name] = { metal-name, metal-amount, time }
}

local molten_metal = {
    "molten-iron",
    "molten-copper"
}

-- Find every one molten metal, one result recipes

for _, recipe in pairs(data.raw.recipe) do

    -- Check if the recipe is one ingredient, one result; this should filter out the most of recipes.

    local one_ingred = type(recipe.ingredients) == "table" and #recipe.ingredients == 1 and type(recipe.ingredients[1]) == "table" and type(recipe.ingredients[1].name) == "string"
    local one_result = type(recipe.results) == "table" and #recipe.results == 1 and type(recipe.results[1]) == "table" and type(recipe.results[1].name) == "string"
    if not (one_ingred and one_result) then goto next_molten end

    -- If the one ingredient is a molten metal, attempt to record this recipe

    for _, metal_name in pairs(molten_metal) do
        if recipe.ingredients[1].name == metal_name and recipe.ingredients[1].type == "fluid" and recipe.results[1].type == "item" then
            local ingredient = recipe.ingredients[1]
            local result = recipe.results[1]
            local info ={
                ["metal-name"] = metal_name,
                ["metal-amount"] = ingredient.amount / result.amount,
                ["time"] = recipe.energy_required / result.amount
            }

            if not molten_chart[result.name] then
                molten_chart[result.name] = info
            elseif info["metal-amount"] < molten_chart[result.name]["metal-amount"] then
                molten_chart[result.name] = info
            end
        end
    end
    ::next_molten::
end

log("[AAII-CC, casting] Scan complete, the final molten_chart is:")
log(serpent.block(molten_chart))

local function cast_convert(item)
    local old_ingredients = data.raw.recipe[item].ingredients
    local new_ingredients = {}

    -- Convert everything when possible, and pass the others over.

    local molten_registry = {}
    for _, metal_name in pairs(molten_metal) do
        molten_registry[metal_name] = 0
    end

    for k, ingredient in pairs(old_ingredients) do
        local converted = false
        for intermediate, cast_info in pairs(molten_chart) do
            if ingredient.name == intermediate then
                local target_metal = cast_info["metal-name"]
                local converted_amount = ingredient.amount * cast_info["metal-amount"]
                molten_registry[target_metal] = molten_registry[target_metal] + converted_amount
                converted = true
                goto converted
            end
        end
        ::converted::

        if not converted then
            table.insert( new_ingredients, ingredient )
        end
    end

    -- Now, we are ready to insert molten ingredients.

    for metal_name, amount in pairs(molten_registry) do
        if amount > 0 then
            table.insert( new_ingredients, { type = "fluid", name = metal_name, amount = amount } )
        end
    end

    return new_ingredients
end

-- Big engine will still have one small engine in it, in order to be distinguished from Pelagos casting engine.

local cast_list = {
    ["motor"] = "__base__/graphics/icons/engine-unit.png",
    ["electric-motor"] = "__aai-industry__/graphics/icons/small-electric-motor.png",
    ["engine-unit"] = "__aai-industry__/graphics/icons/multi-cylinder-engine.png"
}

local function add_casting(name, icon)
    local ingredients = cast_convert(name)
    -- In vanilla, simple items like gears have raw crafting time doubled, while complicated ones like low density structure is unchanged. Here this rule is followed.
    local raw_time = function ()
        local old_time = data.raw.recipe[name].energy_required
        if old_time >= 1 then
            return old_time
        else
            return (old_time*2)
        end
    end
    local recipe_proto = table.deepcopy(data.raw.recipe["casting-iron"])
    local recipe_update = {
        type = "recipe",
        name = "casting-"..name,
        order = "b[casting]-h[casting-"..name.."]",
        category = "metallurgy",
        icons = {
            {
                icon = icon,
                icon_size = 64,
                scale = 0.375,
                shift = {-4, 4}
            },
            {
                icon = "__aaii-cc__/graphics/icons/casting-empty.png",
                icon_size = 64
            }
        },
        crafting_machine_tint = data.raw.recipe[name].crafting_machine_tint,
        ingredients = ingredients,
        results = {
            { type = "item", name = name, amount = 1 }
        },
        energy_required = raw_time()
    }

    recipe_proto = meld( recipe_proto, recipe_update )
    data:extend({recipe_proto})
    table.insert( data.raw.technology["foundry"].effects, { type = "unlock-recipe", recipe = "casting-"..name }  )
end

for name, icon in pairs(cast_list) do
    add_casting( name, icon )
end