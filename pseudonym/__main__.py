from argparse import ArgumentParser
from csv import DictReader, DictWriter
from pathlib import Path

from .hash import hash


def convert(names: Path, hashes: Path) -> None:
    """names.csv → hashes.csv"""
    with names.open(encoding="utf-8", newline="") as names_file:
        reader = DictReader(names_file, fieldnames=("真名", "化名"))
        next(reader)  # Drop field names

        with hashes.open("w", encoding="utf-8", newline="") as hashes_file:
            writer = DictWriter(hashes_file, fieldnames=("化名", "hash"))
            writer.writeheader()

            for row in reader:
                writer.writerow(
                    {
                        "化名": row["化名"],
                        "hash": hash(row["真名"]),
                    }
                )


def build_parser() -> ArgumentParser:
    """生成 CLI 参数解析器"""
    root = Path(__file__).parent

    parser = ArgumentParser(description="根据 names.csv 计算 hashes.csv")
    parser.add_argument(
        "--names", type=Path, help="Path to names.csv", default=root / "names.csv"
    )
    parser.add_argument(
        "--hashes", type=Path, help="path to hashes.csv", default=root / "hashes.csv"
    )
    return parser


if __name__ == "__main__":
    args = build_parser().parse_args()
    convert(args.names, args.hashes)
    print(f"“{args.names}” → “{args.hashes}”")
