data:extend({
    {
        type = "bool-setting",
        name = "aaii-cc-emotor",
        setting_type = "startup",
        default_value = true,
        order = "a[motor]-a"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-multi-cylinder",
        setting_type = "startup",
        default_value = true,
        order = "a[motor]-b"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-big-motor",
        setting_type = "startup",
        default_value = true,
        order = "a[motor]-c"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-robot-frame",
        setting_type = "startup",
        default_value = true,
        oreder = "a[motor]-d"
    },
    {
        type = "bool-setting", 
        name = "aaii-cc-mining-time",
        setting_type = "startup",
        default_value = true,
        order = "a[mining]"
    },
    {
        type = "string-setting",
        name = "aaii-cc-furnace-mode",
        setting_type = "startup",
        allowed_values = {
            "default",
            "no-burner",
            "cheap"
        },
        default_value = "no-burner",
        order = "b-a[furnace]"
    },
    {
        type = "string-setting",
        name = "aaii-cc-inserter-mode",
        setting_type = "startup",
        allowed_values = {
            "default",
            "no-burner",
            "cheap"
        },
        default_value = "no-burner",
        order = "b-a[inserter]"
    },
    {
        type = "string-setting",
        name = "aaii-cc-drill-mode",
        setting_type = "startup",
        allowed_values = {
            "default",
            "no-burner",
            "cheap"
        },
        default_value = "no-burner",
        order = "b-a[drill]"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-lab",
        setting_type = "startup",
        default_value = true,
        order = "b-a[lab]"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-burner-backup",
        setting_type = "startup",
        default_value = true,
        order = "b-b"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-belt",
        setting_type = "startup",
        default_value = true,
        order = "c[belt]-a"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-splitter",
        setting_type = "startup",
        default_value = true,
        order = "c[belt]-b"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-hold-repair-pack",
        setting_type = "startup",
        default_value = true,
        order = "c[repair]"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-concrete-backup",
        setting_type = "startup",
        default_value = true,
        order = "c[concrete]"
    },
    {
        type = "bool-setting",
        name = "aaii-cc-remove-board",
        setting_type = "startup",
        default_value = true,
        order = "c[board]"
    }
})