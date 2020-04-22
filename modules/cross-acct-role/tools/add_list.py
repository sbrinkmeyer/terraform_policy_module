import argparse
import json


parser = argparse.ArgumentParser(description='take a list of numbers, return the result')
parser.add_argument('numbers', metavar='N', nargs='+',
                    help='series of numbers to add')

args = parser.parse_args()

#The numbers arrive as strings, so parse to ints
def add(num_str):
  total = 0
  for n in num_str:
    total+=int(n)
  return str(total)

#output expects a map
output={"Result": add(args.numbers)}

print(json.dumps(output))

