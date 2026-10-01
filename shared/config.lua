return {

    -- stress: positive relieves stress, negative adds stress | hunger/thirst: added to current value (0-100)
    Consumables = {
        Eat = { -- default food items
            ['bread'] = {
                hunger = 25,
                thirst = 0,
                stress = 5,
                propname = 'p_bread_14_ab_s_a',
            },
            ['bread_sour'] = {
                hunger = 40,
                thirst = 0,
                stress = 10,
                propname = 'p_bread_14_ab_s_a',
            },
            ['cooked_meat'] = {
                hunger = 30,
                thirst = 5,
                stress = 5,
                propname = 'p_meatchunk_sm02x',
            },
            ['cooked_fish'] = {
                hunger = 30,
                thirst = 5,
                stress = 5,
                propname = 'p_meatchunk_sm02x',
            },
        },
        Drink = { -- default drink items
            ['water'] = {
                hunger = 0,
                thirst = 25,
                stress = 5,
                alcohol = -5,
                propname = 'p_bottlebeer01a'
            },
            ['beer'] = {
                hunger = -3,
                thirst = 0,
                stress = -10,
                alcohol = 25,
                propname = 'p_bottlebeer01a'
            },
        },
        Stew = { -- default stew items
            ['stew'] = {
                hunger = 50,
                thirst = 25,
                stress = 20,
                alcohol = -10, -- stew always uses the bowl + spoon props
            },
        },
        Hotdrinks = { -- default hot drink items
            ['coffee'] = {
                hunger = 0,
                thirst = 25,
                stress = 20,
                alcohol = -15, -- hot drinks always use the coffee mug prop
            },
        },
        Eatcanned = { -- canned food items
            ['canned_apricots'] = {
                hunger = 50,
                thirst = 20,
                stress = 10,
                alcohol = -3,
                propname = 's_canrigapricots01x',
            },
        },
    },

    -- AlcoholSystem Configuration
    AlcoholSystem = {
        DrunkThreshold = 50,      -- Threshold to be considered drunk
        PassOutThreshold = 200,   -- Threshold to pass out
        DecreaseAmount = 1,       -- Points removed per cycle
        DecreaseInterval = 5000,  -- Decrement interval (in ms)
        MaxAlcoholLevel = 500,    -- Maximum alcohol level (safety)
    },

    AlcoholEffects = {
        -- Visual Effects Configuration
        DrunkEffect = true,                      -- Enable or disable the drunk post-fx effect
        DrunkEffectName = "PlayerDrunk01",       -- The name of the visual effect for being drunk
        PassOutEffect = "PlayerDrunk01_PassOut", -- The name of the visual effect for passing out
        WakeUpEffect = "PlayerWakeUpDrunk",      -- The name of the visual effect for waking up
        GroggyEffectName = "PlayerHealthPoorCS", -- The visual effect for the hangover/groggy state

        -- Timings & Durations (in milliseconds)
        GroggyDuration = 15000,                  -- How long the hangover state lasts after waking up (ms)
        VomitDuration = 10000,                   -- How long the vomit animation plays (ms)
        SleepDuration = 20000,                   -- How long the character sleeps on the ground (ms)
        FadeOutDuration = 10000,                 -- Duration of the screen fading to black (ms)
        FadeInDuration = 10000,                  -- Duration of the screen fading back in (ms)
    },
}
