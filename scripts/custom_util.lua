function toSnakeCase(str)
	local res = string.gsub(str, '([^a-zA-Z0-9]+)', '_')
	return string.lower(res)
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

	return Tracker:ProviderCountForCode(toSnakeCase(weapon) .. '_permit') > 0 and 
		Tracker:ProviderCountForCode(toSnakeCase(weapon) .. '_destructible_scenery') > 0
end

function canUseSpecialMoveByDirection(directions)
	local directionList = {
		['above'] = false,
		['below'] = false,
		['sides'] = false
	}
	for direction in string.gmatch(directions, '([^/]+)') do
		directionList[direction] = true
	end

	if directionList.above then
		if canButtstomp() then
			return true
		end
	end

	if directionList.below then
		if canUppercut() then
			return true
		end
	end

	if directionList.sides then
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
		print('warning: canDestroySpecialMoveBlockOrTriggerCrate does not yet handle TNT access (' .. level .. ', ' .. directions .. ')')
		-- TODO: TNT rules here
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

function canReachRegion(location)
	-- TODO: test this
	local region = Tracker:FindObjectForCode(location)
	if region == nil then
		return false
	end
	
	return region.AccessibilityLevel >= AccessibilityLevel.Normal
end

function hasContinuousLevelAccess(from_level, to_level)
	print('warning: hasContinuousLevelAccess not implemented')
	return true
end

function hasWeaponAccess(level, weapon)
	print('warning: hasWeaponAccess not implemented')
	return true
end

function canCollectEnoughCoins(level, cost)
	print('warning: canCollectEnoughCoins not implemented')
	return true
end


