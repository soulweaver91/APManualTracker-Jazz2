function to_snake_case(str)
	local res = string.gsub(str, '([^a-zA-Z0-9]+)', '_')
	return string.lower(res)
end

function table_find(table, value)
	local pos = nil

	for i, v in pairs(table) do
		if v == value then
			pos = i
			break
		end
	end

	return pos
end

function hasMovementUnlock(name)
	if YamlDisabled('basic_movement_in_pool') then
		return true
	end

	return Tracker:ProviderCountForCode(name) > 0
end

function canDoubleJump()
	if Tracker:ProviderCountForCode('spaz_unlock') == 0 then
		return false
	end

	return hasMovementUnlock('double_jump_unlock')
end

function canCopter()
	if Tracker:ProviderCountForCode('jazz_unlock') + Tracker:ProviderCountForCode('lori_unlock') == 0 then
		return false
	end

	return hasMovementUnlock('copter_ears_unlock')
end

function canUppercut()
	if Tracker:ProviderCountForCode('jazz_unlock') == 0 then
		return false
	end

	return hasMovementUnlock('uppercut_unlock')
end

function canSidekick()
	if Tracker:ProviderCountForCode('spaz_unlock') + Tracker:ProviderCountForCode('lori_unlock') == 0 then
		return false
	end

	return hasMovementUnlock('sidekick_unlock')
end

function canButtstomp()
	return hasMovementUnlock('buttstomp_unlock')
end

function canGrabVines()
	return hasMovementUnlock('vine_traversal')
end

function canGrabHooks()
	return hasMovementUnlock('hook_traversal')
end

function canSwim()
	return hasMovementUnlock('swimming_unlock')
end

function canDestroyWildcardBlocks()
	if YamlDisabled('block_destruction_in_pool') then
		return true
	end

	return Tracker:ProviderCountForCode('wildcard_destructible_scenery') > 0
end

function canDestroyWeaponBlocks(weapon)
	if YamlDisabled('block_destruction_in_pool') then
		return true
	end

	return Tracker:ProviderCountForCode(to_snake_case(weapon) .. '_permit') > 0 and
		Tracker:ProviderCountForCode(to_snake_case(weapon) .. '_destructible_scenery') > 0
end

function canUseSpecialMoveByDirection(directions)
	local direction_list = {
		['above'] = false,
		['below'] = false,
		['sides'] = false
	}
	for direction in directions:gmatch('([^/]+)') do
		direction_list[direction] = true
	end

	if direction_list.above then
		if canButtstomp() then
			return true
		end
	end

	if direction_list.below then
		if canUppercut() then
			return true
		end
	end

	if direction_list.sides then
		if canSidekick() then
			return true
		end
	end

	return false
end

function canDestroySpecialMoveBlockOrTriggerCrate(level, directions)
	if canUseSpecialMoveByDirection(directions) then
		return true
	end

	if Tracker:ProviderCountForCode('tnt_permit') > 0 then
		local level_subdivision_index = 0
		local level_name = level
		local level_index_sep_pos = level:find('@')
		if level_index_sep_pos ~= nil then
			level_name = level:sub(1, level_index_sep_pos - 1)
			level_subdivision_index = level:sub(level_index_sep_pos + 1)
		end

		if hasWeaponAccess(level, Weapons.TNT) then
			return true
		end

		local in_level_rule = IN_LEVEL_TNT_RULES[level_name .. '@' .. level_subdivision_index]
		if in_level_rule ~= nil then
			if type(in_level_rule) == 'table' then
				for idx, region in in_level_rule do
					if canReachRegion('@' .. level .. '/' .. region) then
						return true
					end
				end
			elseif in_level_rule == true then
				return true
			end
		end
	end

	return false
end

function canDestroySpecialMoveBlocks(level, directions)
	if YamlEnabled('block_destruction_in_pool') and Tracker:ProviderCountForCode('special_move_destructible_scenery') == 0 then
		return false
	end

	return canDestroySpecialMoveBlockOrTriggerCrate(level, directions)
end

function canDestroyTriggerCrates(level, directions)
	return canDestroySpecialMoveBlockOrTriggerCrate(level, directions)
end

function canDestroySpeedBlocks()
	if YamlDisabled('block_destruction_in_pool') then
		return true
	end

	return Tracker:ProviderCountForCode('speed_destructible_scenery')
end

function canReachRegion(region)
	local region = Tracker:FindObjectForCode(region)
	if region == nil then
		return false
	end

	return region.AccessibilityLevel >= AccessibilityLevel.Normal
end

function hasContinuousLevelAccess(from_level, to_level)
	local end_index = table_find(LEVEL_ORDER_LOOKUP, to_level)

	if end_index == nil then
		return false
	end

	local cursor_index = end_index
	while cursor_index > 1 do
		local cursor_index = cursor_index - 1
		local prev_level = LEVEL_ORDER_LOOKUP[cursor_index]

		if prev_level == nil then
			print('hasContinuousLevelAccess: no valid path from ' .. from_level .. ' to ' .. to_level)
			return false
		end

		local next_level_access = canReachRegion('@' .. prev_level .. '/Exit')

		if prev_level == from_level then
			return next_level_access
		elseif next_level_access == false then
			return false
		end
	end

	return false
end

function hasWeaponAccess(level, weapon)
	if table_find(Weapons, weapon) == nil then
		print('hasWeaponAccess: invalid weapon ' .. weapon)
		return false
	end

	local end_index = table_find(LEVEL_ORDER_LOOKUP, level)
	if level == nil then
		print('hasWeaponAccess: invalid target level ' .. level)
		return false
	end

	local unconditional_last_level = nil
	local conditional_last_regions = {}

	local cursor_index = end_index
	while cursor_index > 1 do
		cursor_index = cursor_index - 1
		local prev_level = LEVEL_ORDER_LOOKUP[cursor_index]

		if prev_level == nil then
			break
		end

		if LEVEL_WEAPON_ACCESS_LOOKUP[prev_level] ~= nil then
			local weapon_regions = LEVEL_WEAPON_ACCESS_LOOKUP[prev_level][weapon]
			if weapon_regions == true then
				unconditional_last_level = prev_level
				break
			elseif type(weapon_regions) == 'table' then
				for idx, region in pairs(weapon_regions) do
					conditional_last_locations:insert({ prev_level = region })
				end
			end
		end
	end

	if unconditional_last_level ~= nil then
		if hasContinuousLevelAccess(unconditional_last_level, level) then
			print('hasWeaponAccess: can access unconditional weapon ' .. weapon .. ' region in ' .. unconditional_last_level)
			return true
		end
		print('hasWeaponAccess: unconditional weapon ' .. weapon .. ' region in ' .. unconditional_last_level .. ' is inaccessible')
	else
		print('hasWeaponAccess: no unconditional weapon ' .. weapon .. ' region available')
	end

	for idx, item in pairs(conditional_last_locations) do
		weapon_level, region = item[1], item[2]
		if hasContinuousLevelAccess(weapon_level, region) then
			if CanReachRegion('@' .. weapon_level .. '/' .. region) then
				print('hasWeaponAccess: can access conditional weapon ' .. weapon .. ' region in ' .. weapon_level .. '/' .. region)
				return true
			end
			print('hasWeaponAccess: conditional weapon ' .. weapon .. ' region in ' .. weapon_level .. '/' .. region .. ' is inaccessible')
		end
	end

	print('hasWeaponAccess: cannot access any weapon ' .. weapon .. ' regions from ' .. level)
	return false
end

function canCollectEnoughCoins(level, cost)
	print('warning: canCollectEnoughCoins not implemented')
	return true
end


