-- For each level, which weapons are available and how.
-- If the value is true, the weapon can be obtained if the main path can be followed to the end.
-- Otherwise, the list specifies the regions that, if accessible, can all provide access to the weapon.
-- Note that for locations in the same level, this doesn't account for backtracking at the moment.
LEVEL_WEAPON_ACCESS_LOOKUP = {
  [Levels.RABBIT_IN_TRAINING] = {},
  [Levels.DUNGEON_DILEMMA] = {
    [Weapons.BOUNCER] = true
  },
  [Levels.KNIGHT_CAP] = {
    [Weapons.BOUNCER] = true,
    [Weapons.FREEZER] = { 'Jazz Main Area' }
  },
  [Levels.TOSSED_SALAD] = {
    [Weapons.TOASTER] = true
  },
  [Levels.CARROT_JUICE] = {
    [Weapons.BOUNCER] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.WEIRDER_SCIENCE] = {
    [Weapons.BOUNCER] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.LOOSE_SCREWS] = {
    [Weapons.BOUNCER] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.VICTORIAN_SECRET] = {
    [Weapons.SEEKER] = true
  },
  [Levels.COLONIAL_CHAOS] = {
    [Weapons.FREEZER] = true,
    [Weapons.SEEKER] = true
  },
  [Levels.PURPLE_HAZE_MAZE] = {
    [Weapons.RF] = true,
    [Weapons.TOASTER] = { 'Toaster Ammo Crate Behind RF Blocks Secret' }
  },
  [Levels.FUNKY_GROOVEATHON] = {
    [Weapons.BOUNCER] = true,
    [Weapons.RF] = true,
    [Weapons.TOASTER] = true,
    [Weapons.TNT] = { 'TNT Ammo Above Vine Near Start' }
  },
  [Levels.BEACH_BUNNY_BINGO] = {
    [Weapons.BOUNCER] = true,
    [Weapons.TOASTER] = { 'Bonus Warp Area' },
    [Weapons.TNT] = true
  },
  [Levels.MARINATED_RABBIT] = {
    [Weapons.SEEKER] = true,
    [Weapons.RF] = { 'Bonus Warp Area' }
  },
  [Levels.A_DIAMONDUS_FOREVER] = {
    [Weapons.BOUNCER] = true,
    [Weapons.FREEZER] = { 'Freezer Ammo Above Trigger Scenery Secret' },
    [Weapons.SEEKER] = { 'Spaz Start' },
    [Weapons.TOASTER] = true
  },
  [Levels.FOURTEEN_CARROT] = {
    [Weapons.BOUNCER] = { 'Character Morph Power-Up Below Buttstomp Block Secret' },
    [Weapons.FREEZER] = true,
    [Weapons.TOASTER] = true,
    [Weapons.PEPPER] = true
  },
  [Levels.ELECTRIC_BOOGALOO] = {
    [Weapons.BOUNCER] = true,
    [Weapons.FREEZER] = {
      'Freezer Ammo Behind Bouncer Blocks Secret',
      'Freezer Ammo Behind Destructible Barrier Secret',
      'First Freezer Power Up Behind Sidekick Blocks Secret',
      'Second Freezer Power Up Behind Sidekick Blocks Secret'
    }
  },
  [Levels.VOLTAGE_VILLAGE] = {
    [Weapons.TOASTER] = true,
    [Weapons.TNT] = true
  },
  [Levels.MEDIEVAL_KINEVAL] = {
    [Weapons.ELECTRO] = true
  },
  [Levels.HARE_SCARE] = {
    [Weapons.RF] = true
  },
  [Levels.GARGOYLES_LAIR] = {
    [Weapons.BOUNCER] = true,
    [Weapons.SEEKER] = true,
    [Weapons.RF] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.THRILLER_GORILLA] = {
    [Weapons.TOASTER] = true
  },
  [Levels.JUNGLE_JUMP] = {
    [Weapons.FREEZER] = true
  },
  [Levels.A_COLD_DAY_IN_HECK] = {
    [Weapons.TOASTER] = true
  },
  [Levels.RABBIT_ROAST] = {
    [Weapons.FREEZER] = true
  },
  [Levels.BURNIN_BISCUITS] = {
    [Weapons.TOASTER] = true,
    [Weapons.PEPPER] = true
  },
  [Levels.BAD_PITT] = {
    [Weapons.TOASTER] = true,
    [Weapons.TNT] = true
  },
  [Levels.DARN_RATZ] = {
    [Weapons.BOUNCER] = true
  },
  [Levels.RETRO_RABBIT] = {
    [Weapons.FREEZER] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.FROG_STOMP] = {
    -- no weapon specific ammo in this level, only ammo crates
  },
  [Levels.EASTER_BUNNY] = {
    [Weapons.BOUNCER] = true
  },
  [Levels.SPRING_CHICKENS] = {
    [Weapons.TOASTER] = true
  },
  [Levels.SCRAMBLED_EGGS] = {
    -- no weapon specific ammo in this level
  },
  [Levels.GHOSTLY_ANTICS] = {
    [Weapons.BOUNCER] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.SKELETONS_TURF] = {
    [Weapons.TOASTER] = true
  },
  [Levels.GRAVEYARD_SHIFT] = {
    [Weapons.BOUNCER] = { 'After Trigger Crate in Room Behind Sturdy Blocks Secret' },
    [Weapons.TOASTER] = true
  },
  [Levels.TURTLE_TOWN] = {
    [Weapons.BOUNCER] = true,
    [Weapons.TOASTER] = true
  },
  [Levels.SUBURBIA_COMMANDO] = {
    [Weapons.BOUNCER] = true,
    [Weapons.FREEZER] = true,
    [Weapons.SEEKER] = true,
    [Weapons.TNT] = true
  },
  [Levels.URBAN_BRAWL] = {
    [Weapons.TOASTER] = true
  },
  [Levels.SNOW_BUNNIES] = {
    [Weapons.BOUNCER] = true,
    [Weapons.FREEZER] = true,
    [Weapons.SEEKER] = true,
    [Weapons.RF] = { 'RF Ammo Inside Destructible Block Platforms Secret' },
    [Weapons.TNT] = true
  },
  [Levels.DASHING_THRU_THE_SNOW] = {
    [Weapons.BOUNCER] = true
  },
  [Levels.TINSEL_TOWN] = {
    [Weapons.TNT] = true,
    [Weapons.ELECTRO] = true
  }
}

-- Tuples of level and an arbitrary number, splitting the level into region groups
-- based on whether TNT can be brought there from within itself or an earlier
-- part of the level
IN_LEVEL_TNT_RULES = {
  -- Funky Grooveathon #0: The entire level
  [Levels.FUNKY_GROOVEATHON .. '@0'] = { 'TNT Ammo Above Vine Near Start' },
  -- Beach Bunny Bingo #0: The entire level
  [Levels.BEACH_BUNNY_BINGO .. '@0'] = true,
  -- Voltage Village #0: Jazz's path until the paths meet
  [Levels.VOLTAGE_VILLAGE .. '@0'] = true,
  -- Voltage Village #1: Spaz's path until the paths meet
  [Levels.VOLTAGE_VILLAGE .. '@1'] = false,
  -- Voltage Village #2: The rest of the level
  [Levels.VOLTAGE_VILLAGE .. '@2'] = true,
  -- Bad Pitt #0: From start to after the first wildcard blocks
  [Levels.BAD_PITT .. '@0'] = false,
  -- Bad Pitt #1: The rest of the level
  [Levels.BAD_PITT .. '@1'] = true,
  -- Suburbia Commando #0: Most of the level
  [Levels.SUBURBIA_COMMANDO .. '@0'] = false,
  -- Suburbia Commando #1: The last stretch to the exit
  [Levels.SUBURBIA_COMMANDO .. '@1'] = true,
  -- Snow Bunnies #0: The entire level
  [Levels.SNOW_BUNNIES .. '@0'] = true,
  -- Tinsel Town #0: The entire level
  [Levels.TINSEL_TOWN .. '@0'] = true
}
