#!/bin/bash
mkdir -p location_gen
python transform_level_location_output.py ../../intermediate_levels/rabbit_in_training.json e1l0_map --out-file location_gen/rabbit_in_training.json
python transform_level_location_output.py ../../intermediate_levels/dungeon_dilemma.json e1l1_map --out-file location_gen/dungeon_dilemma.json
python transform_level_location_output.py ../../intermediate_levels/knight_cap.json e1l2_map --out-file location_gen/knight_cap.json
python transform_level_location_output.py ../../intermediate_levels/tossed_salad.json e1l3_map --out-file location_gen/tossed_salad.json
python transform_level_location_output.py ../../intermediate_levels/carrot_juice.json e1l4_map --out-file location_gen/carrot_juice.json
python transform_level_location_output.py ../../intermediate_levels/weirder_science.json e1l5_map --out-file location_gen/weirder_science.json
python transform_level_location_output.py ../../intermediate_levels/loose_screws.json e1l6_map --out-file location_gen/loose_screws.json
python transform_level_location_output.py ../../intermediate_levels/victorian_secret.json e2l1_map --out-file location_gen/victorian_secret.json
python transform_level_location_output.py ../../intermediate_levels/colonial_chaos.json e2l2_map --out-file location_gen/colonial_chaos.json
python transform_level_location_output.py ../../intermediate_levels/purple_haze_maze.json e2l3_map --out-file location_gen/purple_haze_maze.json
python transform_level_location_output.py ../../intermediate_levels/funky_grooveathon.json e2l4_map --out-file location_gen/funky_grooveathon.json
python transform_level_location_output.py ../../intermediate_levels/beach_bunny_bingo.json e2l5_map --out-file location_gen/beach_bunny_bingo.json
python transform_level_location_output.py ../../intermediate_levels/marinated_rabbit.json e2l6_map --out-file location_gen/marinated_rabbit.json
python transform_level_location_output.py ../../intermediate_levels/a_diamondus_forever.json e3l1_map --out-file location_gen/a_diamondus_forever.json
python transform_level_location_output.py ../../intermediate_levels/fourteen_carrot.json e3l2_map --out-file location_gen/fourteen_carrot.json
python transform_level_location_output.py ../../intermediate_levels/electric_boogaloo.json e3l3_map --out-file location_gen/electric_boogaloo.json
python transform_level_location_output.py ../../intermediate_levels/voltage_village.json e3l4_map --out-file location_gen/voltage_village.json
python transform_level_location_output.py ../../intermediate_levels/medieval_kineval.json e3l5_map --out-file location_gen/medieval_kineval.json
python transform_level_location_output.py ../../intermediate_levels/hare_scare.json e3l6_map --scale 32 --out-file location_gen/hare_scare.json
python transform_level_location_output.py ../../intermediate_levels/gargoyles_lair.json e3l7_map --out-file location_gen/gargoyles_lair.json
python transform_level_location_output.py ../../intermediate_levels/thriller_gorilla.json e4l1_map --out-file location_gen/thriller_gorilla.json
python transform_level_location_output.py ../../intermediate_levels/jungle_jump.json e4l2_map --out-file location_gen/jungle_jump.json
python transform_level_location_output.py ../../intermediate_levels/a_cold_day_in_heck.json e4l3_map --out-file location_gen/a_cold_day_in_heck.json
python transform_level_location_output.py ../../intermediate_levels/rabbit_roast.json e4l4_map --out-file location_gen/rabbit_roast.json
python transform_level_location_output.py ../../intermediate_levels/burnin_biscuits.json e4l5_map --out-file location_gen/burnin_biscuits.json
python transform_level_location_output.py ../../intermediate_levels/bad_pitt.json e4l6_map --out-file location_gen/bad_pitt.json
python transform_level_location_output.py ../../intermediate_levels/darn_ratz.json e5l1_map --out-file location_gen/darn_ratz.json
python transform_level_location_output.py ../../intermediate_levels/retro_rabbit.json e5l2_map --out-file location_gen/retro_rabbit.json
python transform_level_location_output.py ../../intermediate_levels/frog_stomp.json e5l3_map --out-file location_gen/frog_stomp.json
python transform_level_location_output.py ../../intermediate_levels/easter_bunny.json e6l1a_map --tsf --split-map 256:e6l1b_map --out-file location_gen/easter_bunny.json
python transform_level_location_output.py ../../intermediate_levels/spring_chickens.json e6l2a_map --tsf --split-map 256:e6l2b_map --out-file location_gen/spring_chickens.json
python transform_level_location_output.py ../../intermediate_levels/scrambled_eggs.json e6l3a_map --tsf --split-map 256:e6l3b_map --out-file location_gen/scrambled_eggs.json
python transform_level_location_output.py ../../intermediate_levels/ghostly_antics.json e6l4a_map --tsf --split-map 200:e6l4b_map --out-file location_gen/ghostly_antics.json
python transform_level_location_output.py ../../intermediate_levels/skeletons_turf.json e6l5a_map --tsf --split-map 256:e6l5b_map --out-file location_gen/skeletons_turf.json
python transform_level_location_output.py ../../intermediate_levels/graveyard_shift.json e6l6_map --tsf --out-file location_gen/graveyard_shift.json
python transform_level_location_output.py ../../intermediate_levels/turtle_town.json e6l7a_map --tsf --split-map 200:e6l7b_map --out-file location_gen/turtle_town.json
python transform_level_location_output.py ../../intermediate_levels/suburbia_commando.json e6l8a_map --tsf --split-map 210:e6l8b_map --out-file location_gen/suburbia_commando.json
python transform_level_location_output.py ../../intermediate_levels/urban_brawl.json e6l9a_map --tsf --split-map 135:e6l9b_map --out-file location_gen/urban_brawl.json
python transform_level_location_output.py ../../intermediate_levels/snow_bunnies.json e7l1a_map --cc --split-map 256:e7l1b_map --out-file location_gen/snow_bunnies.json
python transform_level_location_output.py ../../intermediate_levels/dashing_thru_the_snow...json --cc e7l2a_map --split-map 256:e7l2b_map --split-map 512:e7l2c_map --out-file location_gen/dashing_thru_the_snow...json
python transform_level_location_output.py ../../intermediate_levels/tinsel_town.json e7l3a_map --cc --split-map 256:e7l3b_map --split-map 512:e7l3c_map --out-file location_gen/tinsel_town.json
python generate_overview.py ./location_gen --out-file location_gen/overview.json
