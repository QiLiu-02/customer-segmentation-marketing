"""Shared DuckDB helpers for the customer segmentation project.

The project's SQL lives in sql/ as real, standalone .sql files (see the project README for why).
These helpers open the shared DuckDB database and run those files from the notebooks, so the SQL
itself is written once and never re-typed inside a notebook cell.
"""
from pathlib import Path
import duckdb

ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "bank_marketing.duckdb"
SQL_DIR = ROOT / "sql"
RAW_CSV = ROOT / "data" / "bank-full.csv"

# read_csv needs to be told each column's type: left to guess, it would infer yes/no columns as
# BOOLEAN, which would hide the yes/no -> boolean-flag conversion that notebook 1 does on purpose,
# as an explicit, narrated step.
RAW_COLUMN_TYPES = {
    "age": "BIGINT", "job": "VARCHAR", "marital": "VARCHAR", "education": "VARCHAR",
    "default": "VARCHAR", "balance": "BIGINT", "housing": "VARCHAR", "loan": "VARCHAR",
    "contact": "VARCHAR", "day": "BIGINT", "month": "VARCHAR", "duration": "BIGINT",
    "campaign": "BIGINT", "pdays": "BIGINT", "previous": "BIGINT", "poutcome": "VARCHAR",
    "y": "VARCHAR",
}


def connect():
    """Open the shared DuckDB database file (created on first use)."""
    return duckdb.connect(str(DB_PATH))


def load_raw(con, csv_path=RAW_CSV):
    """(Re)build bank_raw from the UCI CSV. Safe to call every time notebook 1 runs."""
    csv_path = Path(csv_path)
    if not csv_path.exists():
        raise FileNotFoundError(
            f"{csv_path} not found. See data/README.md for how to download bank-full.csv."
        )
    con.execute(f"""
        CREATE OR REPLACE TABLE bank_raw AS
        SELECT * FROM read_csv('{csv_path.as_posix()}', delim=';', header=True, quote='"',
                                columns={RAW_COLUMN_TYPES})
    """)
    return con.execute("SELECT COUNT(*) FROM bank_raw").fetchone()[0]


def run_sql_file(con, filename):
    """Read a .sql file from sql/ and run it, returning the result as a DataFrame."""
    sql = (SQL_DIR / filename).read_text()
    return con.execute(sql).fetchdf()


def exec_sql_file(con, filename):
    """Read a .sql file from sql/ and execute it for its side effect (CREATE TABLE, etc.)."""
    sql = (SQL_DIR / filename).read_text()
    con.execute(sql)
