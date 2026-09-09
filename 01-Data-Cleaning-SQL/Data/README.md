# India Layoffs Data Cleaning — SQL

## 📌 Project Overview

This project focuses on cleaning and preparing an **India layoffs dataset** using **pure SQL (MySQL)**.

The goal is to transform raw, inconsistent data into a cleaner and more structured dataset that can be used for further analysis and reporting.

All data-cleaning operations in this project are performed using SQL.

---

## 🎯 Objectives

The main objectives of this project are:

* Identify and remove duplicate records
* Standardize inconsistent data
* Handle NULL and blank values
* Convert date values into the correct data type
* Remove unnecessary columns
* Validate the cleaned dataset

---

## 🗂️ Dataset

The dataset contains information related to layoffs in India, including:

* Company
* Location
* State
* Industry
* Total Laid Off
* Percentage Laid Off
* Date
* Funding Stage
* Country
* Funds Raised
* Role
* Department
* Employee Type
* Reason
* Company Size

The raw data is stored in the `india_layoffs_raw` table.

---

## 🛠️ Data Cleaning Process

### 1. Create a Clean Working Table

A separate table was created from the raw dataset so that the original data could be preserved.

```sql
CREATE TABLE india_layoffs_clean
LIKE india_layoffs_raw;
```

The data was then copied from the raw table into the cleaning table.

---

### 2. Remove Duplicate Records

Duplicates were identified using the `ROW_NUMBER()` window function.

The duplicate check considered multiple columns, including:

* Company
* Location
* State
* Industry
* Total Laid Off
* Percentage Laid Off
* Date
* Stage
* Country
* Funds Raised
* Role
* Department
* Employee Type
* Reason
* Company Size

Records with a `row_num > 1` were identified as duplicates and removed.

---

### 3. Standardize the Data

Whitespace and formatting inconsistencies were cleaned using the `TRIM()` function.

The following fields were standardized:

* Company
* Location
* State
* Industry
* Department
* Employee Type
* Reason
* Other categorical fields

Example:

```sql
UPDATE india_layoffs_clean2
SET company = TRIM(company);
```

Similar transformations were applied to other relevant columns.

---

### 4. Convert Date Data Type

The original `date` column was stored as text.

The values were converted into proper SQL `DATE` values using `STR_TO_DATE()`.

```sql
UPDATE india_layoffs_clean2
SET date = CASE
    WHEN date IS NULL OR TRIM(date) = '' THEN NULL
    ELSE STR_TO_DATE(date, '%Y-%m-%d')
END;
```

The column was then changed to the `DATE` data type.

---

### 5. Handle NULL and Blank Values

Blank values were converted to `NULL` where appropriate.

Missing values were then investigated and, where possible, populated using information available in other records belonging to the same company.

This was applied to fields such as:

* Location
* Industry
* Role
* Department
* Reason

For example, missing location values were populated by matching records from the same company where a valid location existed.

---

### 6. Remove Temporary Columns

After duplicate removal and validation, the temporary `row_num` column was removed from the final cleaned table.

```sql
ALTER TABLE india_layoffs_clean2
DROP COLUMN row_num;
```

---

## 🧰 SQL Skills Demonstrated

This project demonstrates practical use of:

* `SELECT`
* `CREATE TABLE`
* `ALTER TABLE`
* `UPDATE`
* `DELETE`
* `INSERT`
* `WHERE`
* `ORDER BY`
* `DISTINCT`
* `TRIM()`
* `STR_TO_DATE()`
* `CASE`
* `JOIN`
* `CTE (Common Table Expressions)`
* `ROW_NUMBER()`
* Window Functions
* NULL handling
* Data type conversion

---

## 📁 Project Structure

```text
01_Data_Cleaning/
│
├── README.md
└── 01_Data_Cleaning.sql
```

---

## 💡 Key Takeaway

This project demonstrates how SQL can be used not only to query data, but also to perform a complete **data-cleaning workflow**.

The process covers:

**Raw Data → Data Exploration → Duplicate Removal → Standardization → NULL Handling → Data Type Conversion → Validation → Clean Dataset**

---

## 🚀 Future Improvements

Possible extensions to this project include:

* Add data-quality validation queries
* Calculate before-and-after row counts
* Analyze the cleaned layoffs dataset
* Create an exploratory data analysis project using SQL
* Build a dashboard using the cleaned dataset

---

## 👨‍💻 Author

**Tushar**

Aspiring Data Analyst | SQL | Data Cleaning | Data Analysis

