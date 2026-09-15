import argparse
import json
import os
import pprint

LEVEL_INDICES = {
  'Rabbit in Training': 11,
  'Dungeon Dilemma': 12,
  'Knight Cap': 13,
  'Tossed Salad': 14,
  'Carrot Juice': 15,
  'Weirder Science': 16,
  'Loose Screws': 17,
  'Victorian Secret': 21,
  'Colonial Chaos': 22,
  'Purple Haze Maze': 23,
  'Funky Grooveathon': 24,
  'Beach Bunny Bingo': 25,
  'Marinated Rabbit': 26,
  'A Diamondus Forever': 31,
  'Fourteen Carrot': 32,
  'Electric Boogaloo': 33,
  'Voltage Village': 34,
  'Medieval Kineval': 35,
  'Hare Scare': 36,
  'Gargoyles Lair': 37,
  'Thriller Gorilla': 41,
  'Jungle Jump': 42,
  'A Cold Day in Heck': 43,
  'Rabbit Roast': 44,
  'Burnin Biscuits': 45,
  'Bad Pitt': 46,
  'Darn Ratz': 51,
  'Retro Rabbit': 52,
  'Frog Stomp': 53,
  'Easter Bunny': 61,
  'Spring Chickens': 62,
  'Scrambled Eggs': 63,
  'Ghostly Antics': 64,
  'Skeletons Turf': 65,
  'Graveyard Shift': 66,
  'Turtle Town': 67,
  'Suburbia Commando': 68,
  'Urban Brawl': 69,
  'Snow Bunnies': 71,
  'Dashing thru the snow..': 72,
  'Tinsel Town': 73
}

EPISODE_TOPLEFT = [
  ( 45,  35),
  (455,  35),
  (865,  35),
  ( 45, 334),
  (455, 309),
  (865, 358),
  (455, 508)
]

VICTORY_TOPLEFT = (45, 608)

def sort_key_for_location(location):
  name = location['name']

  if name.startswith('Save Point'):
    index = name[11:].split(' ', maxsplit=1)[0]
    return int(index) - 1
  elif name.startswith('Sign'):
    index = name[5:].split(' ', maxsplit=1)[0]
    return int(index) + 20 - 1
  elif name.startswith('Bonus Warp'):
    return 90
  #elif name.endswith(' Defeated'):
  #  return 98
  elif name == 'Exit':
    return 99
  #else:
  #  print(f'no rule matched for {name}')
    
  return 200

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Builds the overview location map based on individual level maps')
  parser.add_argument('dir', help='The location of the JSON files containing the map data')
  parser.add_argument('--out-file', help='The file to save the result to', default=None)
  args = parser.parse_args()

  result = {
    'name': 'Overview',
    'children': []
  }

  if not os.path.exists(os.path.abspath(args.dir)) or not os.path.isdir(os.path.abspath(args.dir)):
    print(f'error: {os.path.abspath(args.dir)} is not a directory')
    exit(1)

  for file_entry in os.scandir(args.dir):
    if not file_entry.is_file or not file_entry.name.endswith('.json') or file_entry.name.endswith('overview.json'):
      continue

    try:
      with open(file_entry.path, 'r') as file:
        data = json.loads(file.read())

        level_name = data[0]['name']

        if level_name not in LEVEL_INDICES:
          print(f'skipping file, {level_name} has no index')
          continue

        i = LEVEL_INDICES[level_name]

        episode = i // 10 - 1
        order = i % 10 - 1

        topleft = EPISODE_TOPLEFT[episode]

        level_marker = {
          'name': level_name,
          'access_rules': [],
          'sections': [],
          'map_locations': [
            {
              'map': 'main_map',
              'x': topleft[0] + 9 + 10,
              'y': topleft[1] + 89 + 10 + 25 * order
            }
          ],
          'level_sort_key': i
        }

        for location in data[0]['children']:
          level_marker['sections'].append({
            'name': location['name'],
            'ref': f'{level_name}/{location['name']}/{location['sections'][0]['name']}'
          })

        level_marker['sections'].sort(key=sort_key_for_location)

        result['children'].append(level_marker)


    except OSError as e:
      print(f'error: {file_entry.path} could not be opened')
      exit(1)

  result['children'].sort(key=lambda a: a['level_sort_key'] if 'level_sort_key' in a else 999)
  for item in result['children']:
    if 'level_sort_key' in item:
      del item['level_sort_key']

  result['children'].insert(0, {
    'name': 'Victory',
    'access_rules': [ 'all_episodes_complete' ],
    'sections': [
      {
        'name': 'All Levels Completed'
      }
    ],
    'map_locations': [
      {
        'map': 'main_map',
        'x': VICTORY_TOPLEFT[0] + 13 + 18,
        'y': VICTORY_TOPLEFT[1] + 18 + 18,
        'size': 36
      }
    ]
  })

  target_file = f'generate_overview_result.json'
  if args.out_file is not None:
    target_file = os.path.abspath(args.out_file)

  with open(target_file, 'w') as outfile:
    outfile.write(json.dumps([result], indent=2))
