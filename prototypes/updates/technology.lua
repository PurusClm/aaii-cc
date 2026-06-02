if not settings.startup["aaii-cc-burner-backup"] then goto backup_end end

do
    ---- Here, we make backup recipes unlocked together with the main recipe.

    local recipe_backup = AAIICC.recipe_backup

    -- Before we begin, eliminate recipes that is unlocked from the beginning.

    for k, recipe in ipairs(recipe_backup) do
        if data.raw["recipe"][recipe].enabled then
            data.raw["recipe"]["aai-"..recipe].enabled = true
            table.remove(recipe_backup, k)
        end
    end

    -- First, find the techs that unlock recipes in [recipe_backup].

    local tech_repo = {}

    -- tech_repo has this format:
    -- ["<recipe name>"] = {<techs that unlock this recipe>}

    for _, recipe in pairs(recipe_backup) do
        tech_repo[recipe] = {}
    end

    for _, tech in pairs(data.raw["technology"]) do
        if not tech.effects then
            goto final
        end

        for _, effect in pairs(tech.effects) do
            if not effect.type == "unlock-recipe" then
                goto skip
            end

            for _, recipe in pairs(recipe_backup) do
                if effect.recipe == recipe then
                    table.insert(tech_repo[recipe], tech.name)
                end
            end

            ::skip::
        end

        ::final::
    end

    -- we can now add the BACKUP versions of recipes

    for recipe, list in pairs(tech_repo) do
        for _, tech in pairs(list) do
            table.insert(data.raw["technology"][tech].effects, {type = "unlock-recipe", recipe = "aai-"..recipe} )
        end
    end
end

::backup_end::
