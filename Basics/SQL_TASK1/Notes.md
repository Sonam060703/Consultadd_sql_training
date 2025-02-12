# Introduction to Databases
## History and Evolution of Databases
Databases have evolved significantly from simple file-based systems to sophisticated database management systems. Early databases were hierarchical and network-based, but the advent of relational databases in the 1970s revolutionized data storage and retrieval. Today, databases range from traditional relational systems to modern distributed and NoSQL databases.

## Types of Databases: Relational vs. Non-relational
- **Relational Databases (RDBMS)**: Use structured tables with rows and columns and follow ACID (Atomicity, Consistency, Isolation, Durability) principles. Example: MySQL, PostgreSQL.
- **Non-relational Databases (NoSQL)**: Designed for flexibility and scalability, handling unstructured or semi-structured data. Example: MongoDB, Cassandra.

## Database Management Systems (DBMS) Overview
A DBMS is software that manages databases and provides tools for data storage, retrieval, and manipulation. Examples include MySQL, Oracle DB, and SQL Server.

## SQL vs. NoSQL Databases
- **SQL (Structured Query Language)**: Used in RDBMS for structured data processing.
- **NoSQL (Not Only SQL)**: Suitable for high-volume, distributed, and unstructured data applications.

# Relational Database Fundamentals
## Database Design Concepts
Effective database design ensures data integrity, reduces redundancy, and enhances performance.

## Entity-Relationship (ER) Model
The ER model represents entities, attributes, and relationships, helping design a structured schema for relational databases.

## Tables, Rows, and Columns
Tables store data in a structured format with rows (records) and columns (attributes).

## Primary Keys and Foreign Keys
- **Primary Key**: A unique identifier for records in a table.
- **Foreign Key**: A reference to a primary key in another table to establish relationships.

## Normalization
Normalization organizes data to minimize redundancy and dependency. It includes:
- **1NF (First Normal Form)**: Eliminates duplicate columns and ensures atomicity.
- **2NF (Second Normal Form)**: Ensures that non-key attributes depend entirely on the primary key.
- **3NF (Third Normal Form)**: Eliminates transitive dependencies.
- **BCNF (Boyce-Codd Normal Form)**: A stricter version of 3NF.

## Denormalization and When to Use It
Denormalization combines tables to reduce joins and improve read performance, useful in read-heavy applications.

# Basic SQL Commands
## Data Definition Language (DDL)
- **CREATE**: Creates database objects like tables.
- **ALTER**: Modifies existing database objects.
- **DROP**: Deletes database objects.

## Data Manipulation Language (DML)
- **SELECT**: Retrieves data from tables.
- **INSERT**: Adds new records.
- **UPDATE**: Modifies existing records.
- **DELETE**: Removes records.

## Data Control Language (DCL)
- **GRANT**: Provides access privileges.
- **REVOKE**: Removes access privileges.

## Transaction Control Language (TCL)
- **BEGIN**: Starts a transaction.
- **COMMIT**: Saves changes.
- **ROLLBACK**: Undoes changes.

# Advanced SQL Queries
## Joins
- **Inner Join**: Returns matching rows from both tables.
- **Outer Join (Left, Right, Full)**: Returns all rows from one or both tables, filling unmatched rows with NULL.
- **Cross Join**: Returns the Cartesian product of tables.

## Subqueries and Correlated Subqueries
- **Subqueries**: Nested queries executed independently.
- **Correlated Subqueries**: Subqueries dependent on the outer query.

## Set Operations
- **UNION**: Combines results from two queries, removing duplicates.
- **INTERSECT**: Returns common records from two queries.
- **EXCEPT**: Returns records from the first query that are not in the second.

## Window Functions
Used for analytical calculations across rows.
- **ROW_NUMBER()**: Assigns a unique number to each row.
- **RANK()**: Assigns ranks with gaps.
- **DENSE_RANK()**: Assigns ranks without gaps.
- **NTILE()**: Divides results into equal parts.
- **LAG()/LEAD()**: Access previous/next row values.

## Common Table Expressions (CTEs) and Recursive Queries
### Common Table Expressions (CTEs)
A CTE is a temporary named result set that simplifies complex queries by breaking them into smaller, more readable parts. It improves code readability and reusability.

**Example:**
```sql
WITH Sales AS (
    SELECT customer_id, SUM(amount) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM Sales WHERE total_sales > 1000;
```

### Recursive CTEs
Recursive CTEs are used to process hierarchical or tree-structured data, such as organizational charts or category structures.

**Example:**
```sql
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.id, e.name, e.manager_id
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM EmployeeHierarchy;
```

### Uses of CTEs and Recursive CTEs
- **Improves Readability**: Makes complex queries easier to understand.
- **Encapsulates Logic**: Avoids repeating subqueries.
- **Hierarchical Data Processing**: Ideal for tree structures like company hierarchies and file systems.
- **Recursive Query Execution**: Efficiently handles multi-level relationships in data.

## Pivoting and Unpivoting Data
- **Pivoting**: Transforms rows into columns.
- **Unpivoting**: Converts columns back into rows for analysis.

