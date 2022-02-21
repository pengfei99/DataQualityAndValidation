# DataQualityAndValidation

Quality evaluation is a topic much more complex than the data validation.  In this Project, we will only focus on
data validation. For more information about data quality management, please check [data quality management](docs/data_quality_management.md)


## 1. Steps in data quality evaluation and data validation

Let's start by understanding different steps in data validation process.

### 1.1 Data validation process overview
I did not find good literatures that define the different steps of how to do the data validation process.
Below, I just illustrate how I do it in general.

1. Understand the raw data: collect documentation, metadata, run data profiling tools
2. Setup validation rules: Based on your understanding of the data, you can set up validation rules.
3. Detect anomalies:  Applying validation rules on the data to detect all rows that violate the validation rules.
4. Correct/Clean data: Imputation, drop rows, change values, etc.
5. Repeat 3,4 till no anomaly 

#### 1.1.1 Understand your data

Before you code any data pipeline, just try to understand the input raw data as much as you can, find **documents, metadata**
that describes your data. 

For example, for a structure/semi-structure data set, you need to know :
- the number of columns, rows, the name of each column, the meaning of each column. 
- for numeric columns, you need to know the basic stats such as min, max, median, mean, standard deviation, etc. 
- for categorical columns, you need to know all the possible values, the value that has most count, etc.

If you don't have documents or metadata that provides you these information, you need to generate them by yourself. We call this data profiling.

## Data Profiling

Data Profiling is the process of running analysis on source data to understand its structure and content. You can get 
following insights by doing data profiling on a new dataset:

- Structure Discovery: Number of columns and their names in the source data
- Content Discovery: Data types of the columns, Identify Nullable columns
- Cardinality of Data: Number of Distinct Values in each column
- Statistical Analysis: Min / Max / Mean / Std Dev of numerical columns
- Value Histograms: Frequency of values in low-cardinality columns

### Why Data Profiling?
Data profiling is typically needed to address following points:
- Use data profiling before beginning to ingest data from a new source to discover if data is in suitable form — and 
   make a “go / no go” decision on the dataset.
- Identify and correct data quality issues in source data, even before starting to move it into target database.
- Reconcile vendor specification with real data
- Identify data quality issues that can be corrected by Extract-Transform-Load (ETL), while data is moved from source 
   to target. Data profiling can uncover if additional processing is needed before feeding data to pipeline.
- Help you to define validation rules

Here are some tools that you can use

## Common problems in semi-structure data

- unescaped commas in unquoted (comma-separated) values: e.g. some word, some word in a text column. the commas are not escaped 
    and will cause column parsing error. (Orderliness)
- an unspecified non-UTF-8 encoding: e.g. using iso-8859-1 ("latin-1" to its friends), or iso-8859-15 ("latin-9") 
- different null markers in different fields(columns), and some cases, different null markers in a single field(columns) (Orderliness)
- field names (column headers) that included spaces, apostrophes, dashes and a non-ASCII 
   non-alphanumeric character (Orderliness)
- multiple date formats, even within a single field. For example year with 4 digit, and 2 digit. (Orderliness)

## Types of Data Validation

There are many types of data validation. Most data validation procedures will perform one or more of these checks 
to ensure that the data is correct before storing it in the database. Common types of data validation checks include:

 
1. Data Type Check : A data type check confirms that the data entered has the correct data type. For example, a field 
     might only accept numeric data. If this is the case, then any data containing other characters such as letters or 
     special symbols should be rejected by the system.

 

2. Code Check : A code check ensures that a field is selected from a valid list of values or follows certain 
    formatting rules. For example, it is easier to verify that a postal code is valid by checking it against a list 
    of valid codes. The same concept can be applied to other items such as country codes and NAICS industry codes.

 

3. Range Check : A range check will verify whether input data falls within a predefined range. For example, 
   latitude and longitude are commonly used in geographic data. A latitude value should be between -90 and 90, 
    while a longitude value must be between -180 and 180. Any values out of this range are invalid.

 

4. Format Check : Many data types follow a certain predefined format. A common use case is date columns that are 
   stored in a fixed format like “YYYY-MM-DD” or “DD-MM-YYYY.” A data validation procedure that ensures dates 
   are in the proper format helps maintain consistency across data and through time.

 

5. Consistency Check : A consistency check is a type of logical check that confirms the data’s been entered in a 
   logically consistent way. An example is checking if the delivery date is after the shipping date for a parcel.

 

6. Uniqueness Check : Some data like IDs or e-mail addresses are unique by nature. A database should likely have 
   unique entries on these fields. A uniqueness check ensures that an item is not entered multiple times into a database.

 
## Open source projects

- pandas profiling
- TDDA, pydqc, Bulwark, Engarde, Voluptous, Opulent Pandas, mobydq, dvc, aws dedupe, datacleaner, and Great Expectations
- soda sql (https://github.com/sodadata/soda-sql)
- google's tensorflow datavalidation

## Commerciales solutions
