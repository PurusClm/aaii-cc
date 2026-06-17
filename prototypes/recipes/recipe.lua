local meld = require("meld")
local util = require("__aai-industry__/data-util")

---- Basics

local recipes = data.raw["recipe"]

local function startups(name)
    return settings.startup["aaii-cc-"..name].value
end

local function ingred(name, amount)
    return {type = "item", name = name, amount = amount}
end

local recipe_backup = {}

---- Circuit
-- For "historical" reasons, aai-circuit here is in fact non-AAI circuit.

local aai_circuit = table.deepcopy( data.raw.recipe["electronic-circuit"] )
local aai_circuit_update = {
    name = "aai-electronic-circuit",
    ingredients = {
        {type = "item", name = "iron-plate", amount = 1},
        {type = "item", name = "copper-cable", amount = 3}
    },
    icons = util.sub_icons(
        "__base__/graphics/icons/electronic-circuit.png",
        "__base__/graphics/icons/iron-plate.png"
    ),
    surface_conditions = {
        {property = "stone-avl", max = 2},
        -- {property = "copper-avl", min = 2}
    },
    auto_recycle = false
}

aai_circuit.icon = nil
aai_circuit.localised_name = nil
meld(aai_circuit, aai_circuit_update)
data:extend({aai_circuit})

table.insert(recipe_backup, "electronic-circuit")

---- Motor

if startups("emotor") then
    recipes["electric-motor"].ingredients = {
        {type = "item", name = "iron-gear-wheel", amount = 1},
        {type = "item", name = "copper-cable", amount = 4}
    }
end

if startups("multi-cylinder") then
    recipes["engine-unit"].ingredients = {
        ingred("motor", 1),
        ingred("pipe", 1),
        ingred("steel-plate", 1)
    }
end

if startups("big-motor") then
    recipes["electric-engine-unit"].ingredients = {
        ingred("electric-motor", 1),
        ingred("steel-plate", 1),
        ingred("electronic-circuit", 2),
        {type = "fluid", name = "lubricant", amount = 20 }
    }
end

if startups("robot-frame") then
    recipes["flying-robot-frame"].energy_required = 5
end

--- Mining time

if settings.startup["aaii-cc-mining-time"].value then
    for _, resource in pairs({"coal", "stone", "iron-ore", "copper-ore"}) do
        data.raw.resource[resource].minable.mining_time = 1
    end
end

----Burner upgrade chain

local iron_inserter = {}
local iron_drill = {}

--- Furnace

if settings.startup["aaii-cc-furnace-mode"].value == "no-burner" then
    recipes["electric-furnace"].ingredients = {
        {type = "item", name = "steel-plate", amount = 10}, 
        {type = "item", name = "advanced-circuit", amount = 5}, 
        {type = "item", name = "stone-brick", amount = 10}
    }
end

if settings.startup["aaii-cc-furnace-mode"].value == "cheap" then
    --- Interestingly, steel furnace is already cheap enough, so no changes here.
    recipes["electric-furnace"].ingredients = {
        {type = "item", name = "steel-plate", amount = 4},
        {type = "item", name = "advanced-circuit", amount = 5},
        {type = "item", name = "steel-furnace", amount = 1}
  }
end

--- Inserter

local function undo_logistic_change()
    local sp_recipe = recipes["logistic-science-pack"]
    sp_recipe.ingredients = {
        {type = "item", name = "transport-belt", amount = 1},
        {type = "item", name = "inserter", amount = 1}
    }
    sp_recipe.energy_required = 6
    sp_recipe.results = {
        {type = "item", name = "logistic-science-pack", amount = 1}
    }
end

if settings.startup["aaii-cc-inserter-mode"].value == "no-burner" then
    recipes["inserter"].ingredients = {
        {type = "item", name = "electric-motor", amount = 1},
        {type = "item", name = "iron-gear-wheel", amount = 1},
        {type = "item", name = "iron-stick", amount = 2}
    }
    undo_logistic_change()
end

if settings.startup["aaii-cc-inserter-mode"].value == "cheap" then
    iron_inserter = {
        ingred("iron-stick", 2),
        ingred("motor", 1)
    }

    recipes["inserter"].ingredients = {
        ingred("burner-inserter", 1),
        ingred("copper-cable", 3)
    }

    undo_logistic_change()

    if startups("burner-backup") then
        data:extend({
            {
            type = "recipe",
            name = "aai-burner-inserter",
            category = "crafting",
            enabled = false,
            energy_required = 0.5,
            ingredients = iron_inserter,
            results = {
                {type="item", name="burner-inserter", amount=1}
            },
            icon = "__base__/graphics/icons/burner-inserter.png",
            surface_conditions = {
                {property = "wood-avl", max = 3}
            }
        }
        })
        log("[AAIICC] initial: "..data.raw["recipe"]["aai-burner-inserter"].name)

        table.insert(recipe_backup, "burner-inserter")
    end
end

--- Drill

if settings.startup["aaii-cc-drill-mode"].value == "no-burner" then
    recipes["electric-mining-drill"].ingredients = {
        {type = "item", name = "electric-motor", amount = 3},
        {type = "item", name = "iron-gear-wheel", amount = 5},
        {type = "item", name = "iron-plate", amount = 10}
    }
end

local wood_drill = false

if mods["lignumis"] then
    wood_drill = true
end

if settings.startup["aaii-cc-drill-mode"].value == "cheap" then

    iron_drill = {
        {type = "item", name = "motor", amount = 1},
        {type = "item", name = "iron-gear-wheel", amount = 3},
        {type = "item", name = "iron-plate", amount = 3}
    }

    if wood_drill then
        goto continue
    end

    recipes["burner-mining-drill"].ingredients = iron_drill

    ::continue::

    recipes["electric-mining-drill"].ingredients = {
        ingred("burner-mining-drill", 1),
        {type = "item", name = "electric-motor", amount = 3},
        {type = "item", name = "iron-gear-wheel", amount = 1},
        {type = "item", name = "iron-plate", amount = 6}
    }

    if startups("burner-backup") then
        data:extend({
            {
                type = "recipe",
                name = "aai-burner-mining-drill",
                category = "crafting",
                enabled = false,
                energy_required = 2,
                ingredients = iron_drill,
                results = {
                    {type="item", name="burner-mining-drill", amount=1}
                },
                icon = "__base__/graphics/icons/burner-mining-drill.png",
                surface_conditions = {
                    {property = "wood-avl", max = 3}
                }
            }
        })

        table.insert(recipe_backup, "burner-mining-drill")
    end
end

--- Belt

if settings.startup["aaii-cc-belt"].value then
    if mods["lignumis"]  then
        if settings.startup["lignumis-belt-progression"].value then
            goto continue
        end
    end

    if mods["wood-logistics"] then
        if settings.startup["wood-logistics-belts"].value then
            goto continue
        end
    end

    recipes["transport-belt"].ingredients = {
        {type = "item", name = "iron-gear-wheel", amount = 1},
        {type = "item", name = "iron-plate", amount = 1}
    }

    ::continue::
end

--- Lab

if settings.startup["aaii-cc-lab"].value then
    recipes["burner-lab"].ingredients = {
        {type = "item", name = "copper-plate", amount = 10},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "iron-stick", amount = 20},
        {type = "item", name = "stone-brick", amount = 5}
    }

    recipes["lab"].ingredients = {
        {type = "item", name = "burner-lab", amount = 1},
        {type = "item", name = "electric-motor", amount = 10},
        {type = "item", name = "glass", amount = 5}
    }
end

--- Assembler

local iron_assembler = {
    ingred("iron-plate", 8),
    ingred("motor", 1),
    ingred("stone-brick", 4)
}

if  startups("burner-backup") then
    data:extend({
        {
            type = "recipe",
            name = "aai-burner-assembling-machine",
            category = "crafting",
            enabled = false,
            energy_required = 2,
            ingredients = iron_assembler,
            results = {
                {type="item", name="burner-assembling-machine", amount=1}
            },
            icon = "__aai-industry__/graphics/icons/burner-assembling-machine.png",
            surface_conditions = {
                {property = "wood-avl", max = 3}
            }
        }
    })

    table.insert(recipe_backup, "burner-assembling-machine")
end

---- Recipe review

--- Repair pack

if startups("hold-repair-pack") then
    recipes["repair-pack"].ingredients = {
        ingred("iron-gear-wheel", 1),
        ingred("electronic-circuit", 1)
    }
end

--- Concrete

if startups("concrete-backup") then
    data:extend({
        {
            type = "recipe",
            name = "aai-concrete",
            category = "crafting-with-fluid",
            enabled = false,
            energy_required = 10,
            ingredients = {
                ingred("iron-stick", 2),
                ingred("sand", 10),
                ingred("stone-brick", 5),
                {type = "fluid", name = "water", amount = 100}
            },
            results = {
                {type = "item", name = "concrete", amount = 10}
            },
            icons = {
                {icon = "__base__/graphics/icons/concrete.png"},
                {
                    icon = "__base__/graphics/icons/iron-stick.png",
                    icon_size = 64,
                    scale = 0.3,
                    shift = {8, 8}
                }
            },
            surface_conditions = {
                {property = "iron-avl", min = 3, max = 3},
                {property = "stone-avl", min = 3}
            }
        }
    })

    table.insert(recipe_backup, "concrete")
end

log("[AAIICC] recipe backup list:")
log(serpent.block(recipe_backup))

return recipe_backup