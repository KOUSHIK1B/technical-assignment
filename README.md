# Technical Assignment

This repository contains solutions for the **Full Stack Engineering technical assignment**.

The assignment covers:

- **Python web scraping**
- **SQL and database queries**
- **Unix shell scripting**

## Repository Structure

```text
technical-assignment/
├── README.md
├── question1/
│   └── scraper.py
├── question2/
│   └── queries.sql
└── question3/
    └── companies.sh
```

## 1. Prerequisites

The following software is required:

- **Python 3.11 or later**
- **Bash or Git Bash**
- **curl**
- **MySQL Workbench** or another MySQL client
- **Internet connection**

## 2. Installation and Setup

### Question 1 - Python Web Scraper

Install the required Python packages:

```bash
pip install requests beautifulsoup4
```

### Question 2 - SQL and Database

Question 2 uses the **Rfam public MySQL database**.

**Connection details:**

```text
Host: mysql-rfam-public.ebi.ac.uk
Port: 4497
Username: rfamro
Database: Rfam
```

The database is **read-only**.

### Question 3 - Unix Shell Script

Question 3 requires:

- **Bash**
- **curl**
- **Python 3.11 or later**

On Windows, **Git Bash** can be used.

## 3. How to Run Each Solution

### Question 1 - Python Web Scraper

Go to the Question 1 directory:

```bash
cd question1
```

Run the program:

```bash
python scraper.py
```

Enter a search term when prompted.

**Example:**

```text
external hard drive
```

The program displays matching product names and selling prices.

### Question 2 - SQL and Database

Open:

```text
question2/queries.sql
```

in **MySQL Workbench**.

Connect to the **Rfam public MySQL database** using the connection details above.

Run the queries in the SQL file.

The queries determine:

- The **number of Acacia plant types**
- The **wheat type with the longest DNA sequence**
- The required **page 9** family results

### Question 3 - Unix Shell Script

Go to the Question 3 directory:

```bash
cd question3
```

Make the script executable:

```bash
chmod +x companies.sh
```

Run the script with the CSV URL:

```bash
./companies.sh "https://raw.githubusercontent.com/datasets/s-and-p-500-companies/main/data/constituents.csv"
```

The script downloads the CSV file and displays the **S&P 500 companies sorted by founding year**.

## 4. Example Input and Output

### Question 1

**Example input:**

```text
external hard drive
```

**Example output:**

```text
Products found for: external hard drive

Product Name : Seagate Expansion 1TB External Hard Drive
Selling Price: ₹9,140
```

> Product names and prices may change because they are retrieved from the website at runtime.

### Question 2

**Example result for Question A:**

```text
acacia_plant_types
326
```

**Example result for Question B:**

```text
wheat_type                    dna_sequence_length
Triticum durum (durum wheat)  836514780
```

For **Question C**, 15 results are returned for **page 9**.

Page 9 contains results **121-135**, so the query uses:

```sql
LIMIT 15 OFFSET 120;
```

### Question 3

**Example command:**

```bash
./companies.sh "https://raw.githubusercontent.com/datasets/s-and-p-500-companies/main/data/constituents.csv"
```

**Example output:**

```text
S&P 500 Companies
==========================================================================================
Company                             Location                            Founded
------------------------------------------------------------------------------------------
...
```

The companies are sorted by **founding year**.

## 5. Dependencies

### Question 1

- **Python 3.11+**
- **requests**
- **beautifulsoup4**

Install the packages with:

```bash
pip install requests beautifulsoup4
```

### Question 2

- **MySQL Workbench** or another MySQL client
- **Rfam public MySQL database**

### Question 3

- **Bash or Git Bash**
- **curl**
- **Python 3.11+**

Python's built-in **`csv`** module is used for CSV processing.

## 6. Assumptions and Limitations

### Question 1

- An internet connection is required.
- MDComputers results and prices may change over time.
- The website HTML structure may change.
- The search term is entered by the user at runtime.
- The program handles HTTP request errors.

### Question 2

- The queries are designed for the Rfam public MySQL database.
- The Rfam database is read-only.
- Large queries may take longer to execute on the public database.
- Question C may exceed the public Rfam server's execution time limit.
- Page 9 uses **`LIMIT 15 OFFSET 120`**.

### Question 3

- A Bash-compatible environment is required.
- Git Bash can be used on Windows.
- curl is required to download the CSV file.
- The CSV URL is provided as a command-line argument.
- The CSV URL is not hard-coded in the script.
- Python's **`csv`** module correctly handles commas inside quoted CSV fields.
- For values such as **`2013 (1888)`**, the first year is used for sorting.
- The source CSV data may change when the dataset is updated.

## 7. Solution Summary

| Question | Technology | Solution |
|----------|------------|----------|
| **Question 1** | Python | MDComputers web scraper |
| **Question 2** | SQL / MySQL | Rfam database queries |
| **Question 3** | Bash / Python | S&P 500 CSV processing |

## 8. Results Verified During Development

### Question 1

The scraper was tested with:

- **external hard drive**
- **graphics card**

The scraper successfully retrieved product names and selling prices.

### Question 2

**Question A:** 326 Acacia plant types.

**Question B:** Triticum durum (durum wheat), with a DNA sequence length of **836514780**.

**Question C:** The query was tested against the public Rfam database. The large query may exceed the public server's **30-second execution limit**.

### Question 3

The shell script was successfully executed using the S&P 500 CSV URL and processed **all 500 companies**.
