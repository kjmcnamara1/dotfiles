# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "pyjson5",
# ]
# ///

import re
import sys

import pyjson5 as json



def extract_colors(data):
    colors = set()

    def is_color(value):
        # Check if the value matches a hex color format (#RRGGBBAA or #RRGGBB)
        return isinstance(value, str) and re.match(r"^#[0-9a-fA-F]{6,8}$", value)

    def process_item(item):
        if isinstance(item, dict):
            for value in item.values():
                if is_color(value):
                    colors.add(value)
                elif isinstance(value, (dict, list)):
                    process_item(value)
        elif isinstance(item, list):
            for element in item:
                process_item(element)

    process_item(data)
    return sorted(colors)


# Read and parse the JSON file

with open(sys.argv[1], "r") as file:
    print(sys.argv[1])
    data = json.load(file)

# Extract unique colors
unique_colors = extract_colors(data)

# Print the results
print(f"Found {len(unique_colors)} unique colors:")
for color in unique_colors:
    print(color)
