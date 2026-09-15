-- Check to see if a relevant flag is set to "off"
function negate(code)
    return Tracker:ProviderCountForCode(code) == 0
end

-- Returns true if there are at least count number of items from group group_name
function has_count_from_group(group_name, count)
    local group_members = ITEM_GROUPS[group_name]
    if group_members == nil then
        return false
    end
    local found_count = 0
    for _, item in pairs(group_members) do
        found_count = found_count + Tracker:ProviderCountForCode(item)
        if found_count >= tonumber(count) then
            return true
        end
    end
    return false
end

-- Below are logic functions that come bundled with Manual.
function ItemValue(value_category_name, target_value)
    category_values = ITEM_VALUES[value_category_name]
    if category_values == nil then
        return false
    end
    local current_value = 0
    for item_name, item_value in pairs(category_values) do
        local item_count = Tracker:ProviderCountForCode(item_name)
        current_value = current_value + (item_count * item_value)
        if current_value >= target_value then
            return true
        end
    end
    return false
end

function YamlEnabled(option)
    return Tracker:ProviderCountForCode(option) > 0
end

function YamlDisabled(option)
    return Tracker:ProviderCountForCode(option) == 0
end

function YamlCompare_EQ(option, value)
    return Tracker:ProviderCountForCode(option) == tonumber(value)
end

function YamlCompare_NE(option, value)
    return Tracker:ProviderCountForCode(option) ~= tonumber(value)
end

function YamlCompare_LT(option, value)
    return Tracker:ProviderCountForCode(option) < tonumber(value)
end

function YamlCompare_LE(option, value)
    return Tracker:ProviderCountForCode(option) <= tonumber(value)
end

function YamlCompare_GT(option, value)
    return Tracker:ProviderCountForCode(option) > tonumber(value)
end

function YamlCompare_GE(option, value)
    return Tracker:ProviderCountForCode(option) >= tonumber(value)
end

function setupLevels()
    local hasTSF = Tracker:ProviderCountForCode("enable_tsf") > 0
    local hasCC = Tracker:ProviderCountForCode("enable_hh") + Tracker:ProviderCountForCode("enable_cc") > 0

    Tracker:AddLayouts("layouts/map_tabs_top.json")
    if hasTSF and not hasCC then
        Tracker:AddLayouts("layouts/map_tabs_top_tsf.json")
    elseif hasCC and not hasTSF then
        Tracker:AddLayouts("layouts/map_tabs_top_cc.json")
    elseif not hasTSF and not hasCC then
        Tracker:AddLayouts("layouts/map_tabs_top_base.json")
    end

    if Tracker:ProviderCountForCode("individual_level_unlock_keys") > 0 then
        Tracker:AddLayouts("layouts/levels.json")
        if hasTSF and not hasCC then
            Tracker:AddLayouts("layouts/levels_keys_tsf.json")
        elseif hasCC and not hasTSF then
            Tracker:AddLayouts("layouts/levels_keys_cc.json")
        elseif not hasTSF and not hasCC then
            Tracker:AddLayouts("layouts/levels_keys_base.json")
        end
    else
        Tracker:AddLayouts("layouts/levels_progressive.json")
        if hasTSF and not hasCC then
            Tracker:AddLayouts("layouts/levels_progressive_tsf.json")
        elseif hasCC and not hasTSF then
            Tracker:AddLayouts("layouts/levels_progressive_cc.json")
        elseif not hasTSF and not hasCC then
            Tracker:AddLayouts("layouts/levels_progressive_base.json")
        end
    end
end

function setupLori()
    local hasTSF = Tracker:ProviderCountForCode("enable_tsf") > 0
    local hasCC = Tracker:ProviderCountForCode("enable_cc") > 0

    -- local buttstompIcon = Tracker:FindObjectForCode("buttstomp_unlock")
    -- local copterIcon = Tracker:FindObjectForCode("copter_ears_unlock")
    -- local sidekickIcon = Tracker:FindObjectForCode("sidekick_unlock")

    if hasTSF or hasCC then
        -- buttstompIcon.Icon = ImageReference:FromPackRelativePath('images/items/buttstomp_unlock_lori.png')
        -- copterIcon.Icon = ImageReference:FromPackRelativePath('images/items/copter_ears_unlock_lori.png')
        -- sidekickIcon.Icon = ImageReference:FromPackRelativePath('images/items/sidekick_unlock_lori.png')
        -- Tracker:AddItems('items/items_movement.json')
        Tracker:AddLayouts("layouts/playable_character.json")
    else
        -- buttstompIcon.Icon = ImageReference:FromPackRelativePath('images/items/buttstomp_unlock.png')
        -- copterIcon.Icon = ImageReference:FromPackRelativePath('images/items/copter_ears_unlock.png')
        -- sidekickIcon.Icon = ImageReference:FromPackRelativePath('images/items/sidekick_unlock.png')
        -- Tracker:AddItems('items/items_movement_base_hh.json')
        Tracker:AddLayouts("layouts/playable_character_base_hh.json")
    end
end

function setupTSF()
    setupLevels()
    setupLori()
end

function setupHH()
    setupLevels()
end

function setupCC()
    setupLevels()
    setupLori()
end
