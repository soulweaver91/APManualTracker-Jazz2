function can_reach_all_level_exits(levels)
  for i, level in pairs(levels) do
    local level_complete_section = Tracker:FindObjectForCode('@' .. level .. '/Exit/Level Complete')
    if level_complete_section == nil then
      print('can_reach_all_level_exits: location section ' .. level .. '/Exit/Level Complete not found')
      return false
    end

    if level_complete_section.AvailableChestCount > 0 then
      -- exit hasn't yet been collected
      return false
    end
  end

  return true
end

function formerly_a_prince_complete()
  local levels = {
    Levels.RABBIT_IN_TRAINING,
    Levels.DUNGEON_DILEMMA, 
    Levels.KNIGHT_CAP,
    Levels.TOSSED_SALAD,
    Levels.CARROT_JUICE,
    Levels.WEIRDER_SCIENCE,
    Levels.LOOSE_SCREWS
  }

  return can_reach_all_level_exits(levels)
end

function jazz_in_time_complete()
  local levels = {
    Levels.VICTORIAN_SECRET,
    Levels.COLONIAL_CHAOS,
    Levels.PURPLE_HAZE_MAZE,
    Levels.FUNKY_GROOVEATHON,
    Levels.BEACH_BUNNY_BINGO,
    Levels.MARINATED_RABBIT
  }

  return can_reach_all_level_exits(levels)
end

function flashback_complete()
  local levels = {
    Levels.A_DIAMONDUS_FOREVER,
    Levels.FOURTEEN_CARROT,
    Levels.ELECTRIC_BOOGALOO,
    Levels.VOLTAGE_VILLAGE,
    Levels.MEDIEVAL_KINEVAL,
    Levels.HARE_SCARE,
    Levels.GARGOYLES_LAIR
  }

  return can_reach_all_level_exits(levels)
end

function funky_monkeys_complete()
  local levels = {
    Levels.THRILLER_GORILLA,
    Levels.JUNGLE_JUMP,
    Levels.A_COLD_DAY_IN_HECK,
    Levels.RABBIT_ROAST,
    Levels.BURNIN_BISCUITS,
    Levels.BAD_PITT
  }

  return can_reach_all_level_exits(levels)
end

function shareware_demo_complete()
  local levels = {
    Levels.DARN_RATZ,
    Levels.RETRO_RABBIT,
    Levels.FROG_STOMP
  }

  return can_reach_all_level_exits(levels)
end

function the_secret_files_complete()
  local levels = {
    Levels.EASTER_BUNNY,
    Levels.SPRING_CHICKENS,
    Levels.SCRAMBLED_EGGS,
    Levels.GHOSTLY_ANTICS,
    Levels.SKELETONS_TURF,
    Levels.GRAVEYARD_SHIFT,
    Levels.TURTLE_TOWN,
    Levels.SUBURBIA_COMMANDO,
    Levels.URBAN_BRAWL
  }

  return can_reach_all_level_exits(levels)
end

function christmas_chronicles_complete()
  local levels = {
    Levels.SNOW_BUNNIES,
    Levels.DASHING_THRU_THE_SNOW,
    Levels.TINSEL_TOWN
  }

  return can_reach_all_level_exits(levels)
end

function all_episodes_complete()
  local complete_so_far = true

  complete_so_far = complete_so_far and formerly_a_prince_complete()
  complete_so_far = complete_so_far and jazz_in_time_complete()
  complete_so_far = complete_so_far and flashback_complete()
  complete_so_far = complete_so_far and funky_monkeys_complete()
  complete_so_far = complete_so_far and shareware_demo_complete()
  if YamlEnabled('enable_tsf') then
    complete_so_far = complete_so_far and the_secret_files_complete()
  end
  if YamlEnabled('enable_cc') or YamlEnabled('enable_hh') then
    complete_so_far = complete_so_far and christmas_chronicles_complete()
  end

  return complete_so_far
end
