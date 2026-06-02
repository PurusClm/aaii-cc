if mods["aai-loaders"] then
    for _, ingredient in pairs(data.raw.recipe["aai-loader"].ingredients) do
        if ingredient.name == "basic-circuit-board" then
            ingredient.name = "electronic-circuit"
        end
    end
end