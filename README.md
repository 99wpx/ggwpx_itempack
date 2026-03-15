# 📂 Configuration

All packages can be configured inside **config.lua**.

Example configuration:

```lua
Config = {}

Config.Packages = {
    ['small_package'] = {
        label = "Small Package",
        progressTime = 5000,

        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 49,

        items = {
            { name = "burger", amount = 1 }
        }
    },

    ['medium_package'] = {
        label = "Medium Package",
        progressTime = 7000,

        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 49,

        items = {
            { name = "burger", amount = 2 },
            { name = "bandage", amount = 1 }
        }
    },

    ['special_package'] = {
        label = "Special Package",
        progressTime = 10000,

        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 49,

        items = {
            { name = "burger", amount = 3 },
            { name = "bandage", amount = 2 },
            { name = "phone", amount = 1 },
            { name = "lockpick", amount = 2 }
        }
    }
}
