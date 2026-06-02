if mods["foundry-expanded"] then
    -- The new recipe is sightly more balanced
    data.raw.recipe["foundry-expanded-casting-engine-unit"].hidden = true
    data.raw.technology["foundry-expanded-casting-engine-unit"].hidden = true
end

if mods["pelagos"] then
    -- Change its icon and order so it's less confusing
    local pelagos_engine = data.raw.recipe["pelagos-casting-engine-unit"]
    pelagos_engine.icon = nil
    pelagos_engine.icons = {
        {
                icon = "__aai-industry__/graphics/icons/multi-cylinder-engine.png",
                icon_size = 64,
                scale = 0.375,
                shift = {-4, 4}
            },
            {
                icon = "__aaii-cc__/graphics/icons/casting-empty.png",
                icon_size = 64
            },
            {
                icon = "__pelagos__/graphics/activated-carbon.png",
                icon_size = 64,
                scale = 0.25,
                shift = {8, 8}
            }
    }
    pelagos_engine.order = "b[casting]-h[casting-engine-unit]-[pelagos]"
end