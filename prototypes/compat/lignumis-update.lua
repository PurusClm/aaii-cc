if not mods["lignumis"] then return end

local list = {
    "electric-mining-drill",
    "inserter",
    "burner-lab",
    "assembling-machine-1"
}

for _, name in pairs(list) do
    local ingredients = data.raw["recipe"][name].ingredients

    for k, item in pairs(ingredients) do
        if item.name == "basic-circuit-board" then
            table.remove(ingredients, k)
        end
    end
end