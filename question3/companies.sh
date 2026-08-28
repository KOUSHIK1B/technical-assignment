#!/bin/bash

# Check that exactly one URL is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <CSV_URL>"
    exit 1
fi

CSV_URL="$1"
CSV_FILE=$(mktemp)

# Remove temporary file when the script finishes
trap 'rm -f "$CSV_FILE"' EXIT

# Download the CSV file
if ! curl -L --fail --silent --show-error "$CSV_URL" -o "$CSV_FILE"; then
    echo "Error: Failed to retrieve the CSV file."
    exit 1
fi

# Read and process the CSV file
/c/Users/raoto/AppData/Local/Programs/Python/Python311/python.exe - "$CSV_FILE" <<'PY'
import csv
import sys

filename = sys.argv[1]

try:
    with open(filename, newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)

        required_columns = {
            "Security",
            "Headquarters Location",
            "Founded"
        }

        if not required_columns.issubset(reader.fieldnames or []):
            print("Error: Required columns are missing.")
            sys.exit(1)

        companies = []

        for row in reader:
            name = row["Security"].strip()
            location = row["Headquarters Location"].strip()
            founded = row["Founded"].strip()

            try:
                founding_year = int(founded.split()[0])
            except (ValueError, IndexError):
                founding_year = float("inf")

            companies.append(
                (founding_year, name, location, founded)
            )

        companies.sort(key=lambda company: company[0])

        print("\nS&P 500 Companies")
        print("=" * 90)
        print(f"{'Company':<35} {'Location':<35} {'Founded'}")
        print("-" * 90)

        for year, name, location, founded in companies:
            print(f"{name:<35} {location:<35} {founded}")

except FileNotFoundError:
    print("Error: Unable to open CSV file.")
    sys.exit(1)

except csv.Error as error:
    print(f"Error: Invalid CSV data - {error}")
    sys.exit(1)
PY