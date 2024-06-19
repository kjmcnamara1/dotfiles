import argparse
import logging
from collections import Counter
from pathlib import Path

log = logging.getLogger(__name__)
logging.basicConfig(level="DEBUG")

parser = argparse.ArgumentParser(
    description="Count characters in all python files in a directory"
)
parser.add_argument(
    "directory",
    type=Path,
    # default=Path(__file__).parent,
    help="Directory to search for python files",
)
args = parser.parse_args()

print(f"{args.directory = }")


counter = Counter()
for py_file in args.directory.glob("**/*.py"):
    # print(f"{py_file = }")
    log.debug('py_file = "%s"', py_file)
    if py_file.name == "ipython_config.py":
        continue
    counter += Counter(py_file.read_text().casefold())
    # with py_file.open("r") as f:
    #     for line in f:
    # print(f"{py_file = }")
    print(counter)

# print(pd.DataFrame(counter))
