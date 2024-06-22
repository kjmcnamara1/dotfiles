import argparse
import logging
import string
from collections import Counter
from pathlib import Path

log = logging.getLogger(__name__)
logging.basicConfig(level="DEBUG")


def parse_args():
    parser = argparse.ArgumentParser(
        description="Count characters in all python files in a directory"
    )
    parser.add_argument(
        "directory",
        type=Path,
        nargs="?",
        default=Path.home() / "Code",
        help="Directory to search for python files",
    )
    args = parser.parse_args()

    print(f"{args.directory = }")
    return args


def count_chars(directory: Path) -> dict[str, Counter]:
    counts = {}
    for py_file in directory.glob("**/*.py"):
        if py_file.name == "ipython_config.py":
            continue
        counts[py_file.name] = Counter(py_file.read_text().casefold())

    return counts


def chars_as_frame(counts: dict[str, Counter]):
    import pandas as pd

    df = (
        pd.DataFrame.from_dict(counts, orient="columns", dtype="Int64")
        .assign(TOTAL=lambda df: df.sum(axis=1))
        .sort_values("TOTAL", ascending=False)
    )
    # df.loc["TOTAL"] = df.sum(numeric_only=True)
    return df[~df.index.isin(list(string.ascii_lowercase + string.digits))]


def main():
    directory = parse_args().directory
    counts = count_chars(directory)
    print(counts)
    # print(Counter({k: v for k, v in counts.items() if k not in string.ascii_lowercase}))


# print(pd.DataFrame(counter))

if __name__ == "__main__":
    main()
