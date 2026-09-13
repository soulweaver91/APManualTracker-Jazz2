import argparse
import json
import os
import pprint
import re

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Transforms level data from raw output closer to the desired end result. Some manual work still needed afterwards!')
  parser.add_argument('file', help='The location of the JSON file containing the map data')
  parser.add_argument('target_map', help='Name of the map to attach these locations to')
  parser.add_argument('--out-file', help='The file to save the result to', default=None)
  parser.add_argument('--split-map', help='Move x-coordinates larger than specified number to another map. Enter in form of --split-map X_COORD:MAP_NAME.', action='append', default=[])
  parser.add_argument('--scale', help='Tile width in the image used as the map', default=16, type=int)
  parser.add_argument('--tsf', help='Add visibility rule for this being a The Secret Files level', action='store_true')
  parser.add_argument('--cc', help='Add visibility rule for this being a Holiday Hare \'98/Christmas Chronicles level', action='store_true')
  args = parser.parse_args()

  if not os.path.exists(os.path.abspath(args.file)) or not os.path.isfile(os.path.abspath(args.file)):
    print(f'error: {os.path.abspath(args.file)} is not a file')
    exit(1)

  result = {
    'name': '',
    'access_rules': ['(auto generated level entry)'],
    'sections': [],
    'children': []
  }

  # these overwrite each other but doesn't matter, user error if both are used at once
  if args.tsf:
    result['visibility_rules'] = [ 'enable_tsf' ]
  if args.cc:
    result['visibility_rules'] = [ 'enable_cc', 'enable_hh' ]

  default_coords_index = 0

  def to_snake_case(name):
    name = re.sub(r'([^A-Za-z0-9]+)', '_', name)

    return name.lower()

  map_divisions = []
  for item in args.split_map:
    item_x, item_map = item.split(':')
    try:
      map_divisions.append((int(item_x) * args.scale, item_map))
    except:
      print(f'warning: map division ignored, unknown syntax {item}')

  map_divisions.sort(key=lambda a: -a[0])
  def get_map_division(x):
    for division in map_divisions:
      if division[0] < x:
        return division
      
    return None

  def map_location_from_entry(name):
    global default_coords_index

    map_location = {
      'map': args.target_map,
      'x': 32 + default_coords_index * 32,
      'y': 32
    }

    coords = re.search(r'\((\d+), (\d+)\)', name)
    if coords is not None:
      map_location['x'] = int((int(coords[1]) + 0.5) * args.scale)
      map_location['y'] = int((int(coords[2]) + 0.5) * args.scale)
    else:
      default_coords_index += 1

    division = get_map_division(map_location['x'])
    if division is not None:
      map_location['x'] -= division[0]
      map_location['map'] = division[1]

    return map_location

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
    elif name.endswith(' Defeated'):
      return 98
    elif name == 'Exit':
      # Sort this one first in the location file specifically
      return -100
    else:
      print(f'no rule matched for {name}')
      
    return 200

  def sub_location_properties_by_name(name):
    result = {
      'name': '',
      'chest_unopened_img': '',
      'chest_opened_img': ''
    }

    if name.startswith('Save Point'):
      result['chest_unopened_img'] = 'images/locations/save_point.png'
      result['chest_opened_img'] = 'images/locations/save_point_visited.png'
      result['name'] = 'Save Point'
    elif name.startswith('Sign'):
      result['chest_unopened_img'] = 'images/locations/sign.png'
      result['chest_opened_img'] = 'images/locations/sign_visited.png'
      result['name'] = 'Sign'
    elif name.startswith('Bonus Warp'):
      result['chest_unopened_img'] = 'images/locations/bonus_warp.png'
      result['chest_opened_img'] = 'images/locations/bonus_warp_visited.png'
      result['name'] = 'Bonus Area Entered'
    elif name.endswith(' Defeated'):
      boss_name = name[:-9]
      result['chest_unopened_img'] = f'images/locations/{to_snake_case(boss_name)}.png'
      result['chest_opened_img'] = f'images/locations/{to_snake_case(boss_name)}_defeated.png'
      result['name'] = 'Boss Defeated'
    elif name == 'Level Complete':
      result['chest_unopened_img'] = 'images/locations/exit.png'
      result['chest_opened_img'] = 'images/locations/exit_visited.png'
      result['name'] = 'Level Complete'
    else:
      result['name'] = name
      
    return result

  try:
    with open(os.path.abspath(args.file), 'r') as file:
      data = json.loads(file.read())
      level = data[0]

      result['name'] = level['name']
      for region in level['children']:
        region_name = region['name'][len(level['name']) + 3:]

        region_result = {
          'name': region_name,
          'access_rules': region['access_rules'] if 'access_rules' in region else [],
          'comment': '(auto generated region entry)'
        }

        for location in region['sections']:
          location_name = location['name'][len(level['name']) + 3:]

          location_data = {
            'name': location_name,
            'access_rules': [f'@{level['name']}/{region_name}'],
            'sections': [
              {
                **sub_location_properties_by_name(location_name)
              }
            ],
            'map_locations': [map_location_from_entry(location_name)]
          }

          if location_name.endswith(' Defeated'):
            location_data['name'] = location_name[:-9]
          elif location_name == 'Level Complete':
            location_data['name'] = 'Exit'
            if region_name == 'Exit':
              # Move the exit region into the locations as it always has a check
              location_data['access_rules'] = region['access_rules']
              region_result = None

          result['children'].append(location_data)

        if region_result is not None:
          result['sections'].append(region_result)

    result['children'].sort(key=sort_key_for_location)

  except OSError as e:
    print(f'error: {os.path.abspath(args.file)} could not be opened')
    exit(1)

  target_file = f'gen_{os.path.basename(args.file)}'
  if args.out_file is not None:
    target_file = os.path.abspath(args.out_file)

  with open(target_file, 'w') as outfile:
    outfile.write(json.dumps([result], indent=2))
